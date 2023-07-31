Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACAD7696FA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjGaNB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjGaNBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:01:23 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6388810B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 06:01:22 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so51013995e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 06:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690808481; x=1691413281;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZR18Xj99HGOD1PDk2Wg3AoA7XuLUWWBfQUMdU0ykAY=;
        b=hV+Fa/iXvze4EZHc4nHJxlGxRetuNEIbLhs5E0XXYKB8oBw519mtJiK1+s2jqcN75V
         Fi4aT4kuLs8DJepDyLQE9C4MAG5dEDC0F6jHsOsSK+IryHYhBTpObKS2xDPjJurf0+yO
         dlbLBjsrj3lgMVDRs4Ru+dCl3/4/+cdIbqm7f+Tgv8ypVc9UJRJ5sb3mzqcn4MS/0O4M
         bqGyJ56bfjvdfFw94bSsWOsUSPaahBGE9EEPpBlc7W44YhHrbm/7bEigI3f13HVE5jxJ
         Wzu/LMVFamzixGigFcIpmr6/iQWjnu3z14XTGBkuZ1RMCFqeuNmRN2XwPXZWwApp8PqV
         zDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690808481; x=1691413281;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZR18Xj99HGOD1PDk2Wg3AoA7XuLUWWBfQUMdU0ykAY=;
        b=Iukbj3PRcB1zTn/fwa9eRQ8bFo5yU5mwmgbsRifxJEXOWdU0kToebDTbGyz9pgjkTt
         soSh6GsXM8TyRWyzVDeNnfxTTINCysGCxuE/dVHS3AxxP5fPIkvEBfLNDvbqSbMP5jRS
         5S6BWcZNZXYuPfhVOo6buUYFguufxaq9U3X854xNP6DsWWJadNCpulUeKtOq+3QQDuv0
         OCclYzh//3B+tpxWdvS0tH5XOW2Bv+AGHX0I5QUNTbtZB2IuvDlE0e/UoPw/wJNfGw5u
         JHae/IGoTtJ0xSScLJXY6xCe09vL/9fUc4ug1i8q+808/8pHWLhJox+6KOTlHi4dZXN7
         an9Q==
X-Gm-Message-State: ABy/qLYWOlkR/NnC6etEhjkPlzqFIO1HT4OSZlX4V1VMMQSpKzH//yMP
        RusyZisIEeBAoLIewRP0Q8NNJQ==
X-Google-Smtp-Source: APBJJlGKwp4AmZBH8wn9WCGXvrGNKhkG80luhvVxrKuEKffDnq+76vxp1MDIU12B9wvo6hBrXjyR9g==
X-Received: by 2002:a5d:548b:0:b0:316:fc86:28ae with SMTP id h11-20020a5d548b000000b00316fc8628aemr8853742wrv.15.1690808480379;
        Mon, 31 Jul 2023 06:01:20 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id j4-20020adfe504000000b003063a92bbf5sm13220390wrm.70.2023.07.31.06.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 06:01:19 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230719130940.659837-1-arnd@kernel.org>
References: <20230719130940.659837-1-arnd@kernel.org>
Subject: Re: [PATCH] drm/panel: r66451: select CONFIG_DRM_DISPLAY_DP_HELPER
Message-Id: <169080847948.304500.9472944038515886970.b4-ty@linaro.org>
Date:   Mon, 31 Jul 2023 15:01:19 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 19 Jul 2023 15:09:21 +0200, Arnd Bergmann wrote:
> The newly added driver only builds when DRM_DISPLAY_DP_HELPER is enabled:
> 
> x86_64-linux-ld: drivers/gpu/drm/panel/panel-visionox-r66451.o: in function `visionox_r66451_enable':
> panel-visionox-r66451.c:(.text+0x105): undefined reference to `drm_dsc_pps_payload_pack'
> 
> Select both CONFIG_DRM_DISPLAY_DP_HELPER and CONFIG_DRM_DISPLAY_HELPER to
> ensure the helper function is always available.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/panel: r66451: select CONFIG_DRM_DISPLAY_DP_HELPER
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=a1865d3b98c97d25cbfbba4318180f5cfe8ec22d

-- 
Neil

