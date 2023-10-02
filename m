Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A1B7B4C5B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbjJBHMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235722AbjJBHL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:11:57 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17E4E1
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 00:11:53 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4054496bde3so144132805e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 00:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696230712; x=1696835512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKGiwg0kzwrgwMuSE7lVQeLBJXKyNEtXJnfvBT0Ae9U=;
        b=SzDWJMkir7k7dozhZx/cRrl5WN22Shoo/4+RqjUfeG4FcmS+GTrFV1JcWIdZZFVL/J
         WXeFI0/Rmm67HPD/OHtF5zAxRNqySri2f2Jrf/2nOWv/PrjRBy8F8lICuRxwUlpmNjkK
         s3kPfJBN5kwHZbzt7hH1H4+v+veRMK08og9svKCOjSsZHcC/oory6DawgFvrwcnFtIfK
         Mn675bcv05o953FnpnnhR0tKf4/EbZv1QX/dVoIyPh2uFKbJ+Pm5fwGSkMChMIkdanfg
         oHix0MUy1jaYKu9Ir1T4+exNyU5SV4mxqyZrHHhwH1mCYes+tR3mCtAKAvzjXIS0YbeV
         lzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696230712; x=1696835512;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKGiwg0kzwrgwMuSE7lVQeLBJXKyNEtXJnfvBT0Ae9U=;
        b=F7LzHa8MXUgQhsTq8Obe+5bp9ngqK7NMkIxnT73rlgqSgf3PGfLaZMN12bHL4EDyGy
         kIOYgL/muZ/8ale0gvbsFOqneXziMFHe60Eq6B6l4+xI4wRG4ngpfts8FlX0UjbSG0hz
         jmcK8WL4OXx385kqNaz+qEJVYTnussmJVrai59u598QIVV+XyDy7bwiaePqPYuTP8VSd
         BhsXMzfwrEhqLcKpXrZAbjLvmlyzh5mh2g5NdXip1VXCEm0bRN4jbAGYbcIRzpmLTh4N
         5DxAklzgl4cBUKyZJrm/SNMNBJL935jbIR8pxj9mJmx+wbFzS8WsCPh+YpSuF+TZMKfy
         7PFg==
X-Gm-Message-State: AOJu0YxEoBnyFC9oKvHU8YXnJMrCyG8Ggro4OOtFvIJ4EtMfUNd5CUZ1
        /XNmjNgB4Nvsz8xd0n9IBULpkw==
X-Google-Smtp-Source: AGHT+IEBXLLjLVxLUhpaMo4GWOu/TORHc/EVul2gZUOumUPoUmfEf9fOSL+NkxU+zxphePd/sitxDQ==
X-Received: by 2002:a7b:c3d2:0:b0:405:1bfb:ff14 with SMTP id t18-20020a7bc3d2000000b004051bfbff14mr8929570wmj.9.1696230712390;
        Mon, 02 Oct 2023 00:11:52 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 25-20020a05600c025900b00405623e0186sm6601371wmj.26.2023.10.02.00.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 00:11:51 -0700 (PDT)
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
In-Reply-To: <20231001-drm-sn65dsi83-maple-v1-1-cf8ad22b6be0@kernel.org>
References: <20231001-drm-sn65dsi83-maple-v1-1-cf8ad22b6be0@kernel.org>
Subject: Re: [PATCH] drm/bridge: sn65dsi83: Convert to use maple tree
 register cache
Message-Id: <169623071158.3600226.17074010436243792465.b4-ty@linaro.org>
Date:   Mon, 02 Oct 2023 09:11:51 +0200
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

On Sun, 01 Oct 2023 11:26:22 +0100, Mark Brown wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/bridge: sn65dsi83: Convert to use maple tree register cache
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=0908a0225d0fa6d7675bf3c2cc4c25a89e13e83c

-- 
Neil

