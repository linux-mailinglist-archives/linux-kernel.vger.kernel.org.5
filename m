Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFED76FC14
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjHDIdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjHDIdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:33:36 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B38C30D7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:33:34 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe1344b707so2962069e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691138013; x=1691742813;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6nwwHLkVG+OtVOcxb9BDvvn6MafDWFcOyabImoFU+A=;
        b=KBmq3vL5fNLVwTa2+FypT8jrqb/g0EPTJ0TXq7MBZHYuDaO8AOPDLQvuYxTnZpqs9a
         lM2eY0uKw3jxL4Hivc5wAEY+5ITe4Or1zycqN35knpYLItevTVQhJTj7QMw7lG/9iG/q
         iP9G2m8Ml297DZntW2QiGm9kLraT/4BmBSVz4vXou6HpmjuUhrkWZ+rqc8RrBSDHuOgX
         qymE+pHPfvk5x+EzKSpPTntei2KIqWWmpFHAW8f07ZovbOpBPTPSTnkJBwfgMxIvvJB5
         hF6To5tCf8s05szuXYDeUsc08HXMVi4GIp76nSPKoZ5CS+3HNTzALHTMT8B/5mH4eMEV
         t0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691138013; x=1691742813;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6nwwHLkVG+OtVOcxb9BDvvn6MafDWFcOyabImoFU+A=;
        b=TKPcUqkuaq9nll11WTa0UIOFkH9Hdqw3/SkCxuiSAC12toEIy45RsYrnsiNAZMhEXT
         Ki5bKobZu6msw6WM7hoVBpdKkri/l6zssoZNG8MoBFHMQycS1vosGWDyLSlV8fy6esDB
         fHlWeoFshZ0jYTpHr4aQ+o2nYyS1sLYXIRc7Wn1+hKwNxgYz3fEkQ3wunVwp0JTbdB9Z
         j0JC3MCGZtiRMkF+K0Isbp61F+ETUdmtnf51U75rN4giQmhkBxGPLhNgAuEXZor3aI2r
         y0CQ6TaUO6+j5+iVM+EprvH+4dd3GdnccroNZRZYQhZppcwrYC8iCCYQC8FFlsUsdzuE
         RwUw==
X-Gm-Message-State: AOJu0Yzra58lcnELakgELD/03U8WHPqRcLv13qJDMpE0DaPd4bO2x1ew
        JI+a8PR9+I/Ua7C7RNNuWSMeHw==
X-Google-Smtp-Source: AGHT+IEMeJXfONqMoY3iVQdO66rqCDGbo3R40rjhpbKanJglhxYE5V5UlpOohZC6WXxoVCJPbivftA==
X-Received: by 2002:a19:9116:0:b0:4fb:78b1:1cd4 with SMTP id t22-20020a199116000000b004fb78b11cd4mr692530lfd.49.1691138012596;
        Fri, 04 Aug 2023 01:33:32 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id y16-20020adff150000000b0031762e89f94sm1880871wro.117.2023.08.04.01.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:33:32 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sandor Yu <Sandor.yu@nxp.com>
Cc:     andrzej.hajda@intel.com, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, adrian.larumbe@collabora.com,
        treding@nvidia.com, the.cheaterman@gmail.com,
        l.stach@pengutronix.de, ville.syrjala@linux.intel.com,
        cychiang@chromium.org, shengjiu.wang@nxp.com
In-Reply-To: <20230804061145.2824843-1-Sandor.yu@nxp.com>
References: <20230804061145.2824843-1-Sandor.yu@nxp.com>
Subject: Re: [PATCH v2] drm: bridge: dw_hdmi: Fix ELD is not updated issue
Message-Id: <169113801157.3169525.1095046691218420995.b4-ty@linaro.org>
Date:   Fri, 04 Aug 2023 10:33:31 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 04 Aug 2023 14:11:45 +0800, Sandor Yu wrote:
> The ELD (EDID-Like Data) is not updated when the HDMI cable
> is plugged into different HDMI monitors.
> This is because the EDID is not updated in the HDMI HPD function.
> As a result, the ELD data remains unchanged and may not reflect
> the capabilities of the newly connected HDMI sink device.
> 
> To address this issue, the handle_plugged_change function should move to
> the bridge_atomic_enable and bridge_atomic_disable functions.
> Make sure the EDID is properly updated before updating ELD.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm: bridge: dw_hdmi: Fix ELD is not updated issue
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=6db96c7703edd6e37da8ca571dfe5e1ecb6010c1

-- 
Neil

