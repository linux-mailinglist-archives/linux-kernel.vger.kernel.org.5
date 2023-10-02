Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023E97B4C51
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbjJBHLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235692AbjJBHLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:11:51 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF6DE8
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 00:11:49 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50325ce89e9so25729518e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 00:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696230707; x=1696835507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8b6I74ChX5IXifXdV7pS9ht3VdeHdLMbH0+LYgUaS1E=;
        b=NZnu4KZQtKE/kG0sRVmCj3vdsul0LhfNLBiIQBhAoz3kjnLRvZJrz9HwGYvjfSbmVE
         OL0nvTHrBrNsFNpYfL8FXsTYurj1TVnPx/VcXyZsIC7JwftR31HdhY9p9e7fsTWMjfnZ
         jh3v6uIDAAoiLPs9qeS/WcWubpz0YX8kaDtqIv2CGeD5nJXTBZQse/Gf7Bi7/JuCavTO
         xIg9IPt84Qxkpc/4qEgVvuY1FJRGdWUmwd+pJRMYXNTTMPDoMCM33i3GjJXzieI1zxPS
         8DuyDnEujllnS7m6zbGKWOiQBYA/nlLCwuzQh4ab+L4Irn7GGdhiCBUct7lpxLKFPnX+
         ZFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696230707; x=1696835507;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8b6I74ChX5IXifXdV7pS9ht3VdeHdLMbH0+LYgUaS1E=;
        b=gbLIVHoV3KK28/d58Ngwf1h1/rYxlefjz1ip+DWnm5OfgVEzopOcDvIcCQH5DUJObZ
         IWhTLYLWPA0Hx0srYN/rkAWU34opo2jDy7GcpwRpHsykbZH9sb/aCmWBQ+RNgAR4KyU6
         wbyXIW7U24kGsQD8qE20len4cTkjuMpeHqwQ1ZNx7zCxvcZ7bE31WgiHnGPQRS3sXgXQ
         nREGKFCBnmQ9mpyMYsiKf3MLGG5aX6ao7ju8xk+jTakTdRVkJCHGTkQEHh5dImTLREtY
         ik3nwMfGLIDOXTBxIJKtFhZhx12b7E3SLgOqqRH8pG0KVYRgP+1n//WvTZPiLbEu27Pq
         1H2w==
X-Gm-Message-State: AOJu0Yzw0Ng/WZemaAYP13ogf63IciF8E6rWziUdRWcmJVctk8No0E+8
        RuiSnkWKpKvCnfXgnFXb0HrEvg==
X-Google-Smtp-Source: AGHT+IEYeQHOtTVqs/b3x1pEQIQklFTXhwp8Jgz4wdXC6OWOAm0JdlT8b+6fTwzpm5fomzbSGzqnRw==
X-Received: by 2002:a05:6512:1c6:b0:504:2dac:c017 with SMTP id f6-20020a05651201c600b005042dacc017mr7771083lfp.38.1696230707264;
        Mon, 02 Oct 2023 00:11:47 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 25-20020a05600c025900b00405623e0186sm6601371wmj.26.2023.10.02.00.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 00:11:46 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Brown <broonie@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230929-drm-adv7511-v1-1-b871b28ee594@kernel.org>
References: <20230929-drm-adv7511-v1-1-b871b28ee594@kernel.org>
Subject: Re: [PATCH] drm/bridge: adv7511: Convert to use maple tree
 register cache
Message-Id: <169623070644.3600226.16238713428149894711.b4-ty@linaro.org>
Date:   Mon, 02 Oct 2023 09:11:46 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 29 Sep 2023 14:54:19 +0200, Mark Brown wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/bridge: adv7511: Convert to use maple tree register cache
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=86c3331c8089ac1cf231825f406c4bf8afd9f3a2

-- 
Neil

