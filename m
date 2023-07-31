Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943677696F7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjGaNAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjGaNAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:00:30 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E61810B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 06:00:28 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe110de46dso24190895e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 06:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690808427; x=1691413227;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FUbObSzDV+OWr4/4hJgHfjmLuyqz0P8gKph4x0lk8p0=;
        b=ZyoV5UooYVUTAvAW/QiUxtIzNygDCdr44co6iAnDwRE+YEjUIgZT+lQr4MA5YH80qU
         8zHR7nB1A0Uu9wYLBLbOeGEc8+eimdmxx5PGGaw/ZUC13rHB5Qyrnrh6t0H9U3/3dIQk
         yKJ+FktL7/SjFvJoy0e8VdmG+GX/Qvu35pp1N/XRfX12wFSrqQ01oz5xo/2reKdC+8m9
         X0S3KlN6eMlt/ixdGSKwuc6tsXcRoLstdB6nJBds67VyYSyviq+WVEntTWSbCTwHK2xt
         4sDRPlDOR3VRbPuWfmcarXdL87uL6R5GWC5TkSI7JHfxFYVW76fsSWaSX8v/IHPaNnns
         avxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690808427; x=1691413227;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FUbObSzDV+OWr4/4hJgHfjmLuyqz0P8gKph4x0lk8p0=;
        b=Kk/ugnZKB3LYOEKGOm/RKL7FAUyXEsBv8/n1Epz6seoWJKb4EdHBirlSjMQJmdrCn6
         RMR/9y54bEITD3arIfODCp8Xx/0mI3G+U4rikPHEfMErhXBPmyQ3ymLhqLubPeYyjXy9
         bT+Rvx6T5F4kIPQMw4ibdadr7CkrGbMqkT70xBYHheMi47k6xmWYu34YPRdWFRik7xgo
         gnTcknjofURWeUDxdSINOQJdZVqCSMYeaRdOJ9c++lTqvloCit8Y/BrZlC0VHZkaJXbz
         /Qbhl9n8WGB99MKglfU53qZZjLdvTqfwYio1M4qU390xYSHNJ+3FPuAru4UrMBlQdXD1
         iNTg==
X-Gm-Message-State: ABy/qLZ26pf3JnhScOmz0TO4WRaLD/Lo2BY6us59Z/Jnjy0DGe3kK+NA
        jc2iqME6MjyaN77qaG0h5Hp307HR0LhbKzgjQw4sy6h/
X-Google-Smtp-Source: APBJJlGvNG1zjeg8VNyk3eXXTmbmkaUleTZJkL+2T26lqfmtvgn0n2SEbPFEhrwy7g46uuDI9Aq9fQ==
X-Received: by 2002:a05:600c:2946:b0:3fe:6f7:60aa with SMTP id n6-20020a05600c294600b003fe06f760aamr6452963wmd.12.1690808427221;
        Mon, 31 Jul 2023 06:00:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f723:b60b:92cd:4df4? ([2a01:e0a:982:cbb0:f723:b60b:92cd:4df4])
        by smtp.gmail.com with ESMTPSA id f21-20020a7bcc15000000b003fd32074e74sm14246579wmh.31.2023.07.31.06.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 06:00:26 -0700 (PDT)
Message-ID: <dde2774e-6f0b-21d0-e9c9-4a5bd1eac4e8@linaro.org>
Date:   Mon, 31 Jul 2023 15:00:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: Add prepare_prev_first flag to Visionox
 VTDR6130
Content-Language: en-US
To:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     quic_abhinavk@quicinc.com, quic_parellan@quicinc.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230725-visionox-vtdr-prev-first-v1-1-3bc44cec7dc6@quicinc.com>
Organization: Linaro Developer Services
In-Reply-To: <20230725-visionox-vtdr-prev-first-v1-1-3bc44cec7dc6@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/07/2023 00:56, Jessica Zhang wrote:
> Due to a recent introduction of the pre_enable_prev_first bridge flag [1],
> the panel driver will be probed before the DSI is enabled, causing the
> DCS commands to fail to send.
> 
> Ensure that DSI is enabled before panel probe by setting the
> prepare_prev_first flag for the panel.

Well this is specific to MSM DSI driver, it's not related at all to the panel.

Neil

> 
> [1] commit 4fb912e5e190 ("drm/bridge: Introduce pre_enable_prev_first to alter bridge init order")
> 
> Fixes: 2349183d32d8 ("drm/panel: add visionox vtdr6130 DSI panel driver")
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>   drivers/gpu/drm/panel/panel-visionox-vtdr6130.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
> index bb0dfd86ea67..e1363e128e7e 100644
> --- a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
> +++ b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
> @@ -296,6 +296,7 @@ static int visionox_vtdr6130_probe(struct mipi_dsi_device *dsi)
>   	dsi->format = MIPI_DSI_FMT_RGB888;
>   	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_NO_EOT_PACKET |
>   			  MIPI_DSI_CLOCK_NON_CONTINUOUS;
> +	ctx->panel.prepare_prev_first = true;
>   
>   	drm_panel_init(&ctx->panel, dev, &visionox_vtdr6130_panel_funcs,
>   		       DRM_MODE_CONNECTOR_DSI);
> 
> ---
> base-commit: 28a5c036b05fc5c935cc72d76abd3589825ea9cd
> change-id: 20230717-visionox-vtdr-prev-first-e00ae02eec9f
> 
> Best regards,

