Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BB67919AB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 16:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353146AbjIDO2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 10:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350965AbjIDO2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:28:47 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7772CFB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 07:28:42 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52a39a1c4d5so2042040a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 07:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693837721; x=1694442521; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8iuZC33D0pi0SebavXErWmT+pulYIQNcxBHdRQcQik8=;
        b=i+NrAXlD4u8Ng1VlPXus3DUIWmOtAqb2VmhucPV+g77Tay/c1zJ9yS4cUkxasvsB5m
         2GIsDJV0hczfbL/H4dJdeYX8txCVPtug3RXXpGq7KUw04cEC9cTB2fsMf82ODkCHfOMy
         PIlUlDeFeElL2g771ZAstt3XFWQvUyPR4pAKSi/QZ2UPaqHQYuEZzfL4rP3yx7IzzG73
         YCqPywnmxDr6DZfOn7L5Rl4DuoXE/Kak2HeK080utwKT2p++qVyYc5+QYJozI9jN3HKN
         Xx5B5QnnhVsYSRlN2heUmArF3aTYY+FbuIoYg4BPZjcp3FvEOmE2XXxBxbByzpXC/tbX
         8+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693837721; x=1694442521;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8iuZC33D0pi0SebavXErWmT+pulYIQNcxBHdRQcQik8=;
        b=g2g222x38vnV4thR5lAcFMN3c+yNsP6M9WQCr1ISUSFwb6oyYtII5ybkSlWpE0Fpkn
         NE4hJBboLpZf0OwVUfosVAQzS4nz2ud0SGePBeWVUQDWPjQHSqRu3TZmvE4JOB1l2eUo
         x+2O2UuAzj9wslZSFGFZomcN3F0BfRdvdgVnkqUi45P3+7BdLmZA/YlTXd2sKAFamWm3
         L7w251IuKZfFarOs2SwlK0vlLrgn9mJ7lvGkaM0acdCrp1uc8pEbHw/ilxr2GuV7Cf+p
         7QCWmyqsUcZMWZo2m0whL+EudTtIrQHTFd57z0PiYM010Lr14GNOuxWVupMj0T1NxH51
         6Wgg==
X-Gm-Message-State: AOJu0YxjwHFQSfDsSUbDcvCAVVeDAkuLuhy2WXLMqLTpdHbJEoGFpgOp
        UNNMvBLBq7A37GHWj8Oq398=
X-Google-Smtp-Source: AGHT+IFskoTClGeTBvqu3n1vQK3DtrW+gFUuQJHiyBXfyIZHMy7jeXQO/PenDGkfjW4bANcjhDq1CQ==
X-Received: by 2002:aa7:d407:0:b0:52a:3ee9:a786 with SMTP id z7-20020aa7d407000000b0052a3ee9a786mr6642621edq.26.1693837720880;
        Mon, 04 Sep 2023 07:28:40 -0700 (PDT)
Received: from ?IPV6:2a02:908:8b3:1840:e0a4:c719:5e8d:3b55? ([2a02:908:8b3:1840:e0a4:c719:5e8d:3b55])
        by smtp.gmail.com with ESMTPSA id e11-20020a056402148b00b00529fa63ef6fsm5930777edv.57.2023.09.04.07.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 07:28:40 -0700 (PDT)
Message-ID: <53ee3d14-05f4-981f-26d2-ef9ef6b3a61b@gmail.com>
Date:   Mon, 4 Sep 2023 16:28:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/5] drm/bridge: samsung-dsim: calculate porches in Hz
To:     Michael Tretter <m.tretter@pengutronix.de>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
References: <20230818-samsung-dsim-v1-0-b39716db6b7a@pengutronix.de>
 <20230818-samsung-dsim-v1-5-b39716db6b7a@pengutronix.de>
Content-Language: en-US
From:   Maxim Schwalm <maxim.schwalm@gmail.com>
In-Reply-To: <20230818-samsung-dsim-v1-5-b39716db6b7a@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28.08.23 17:59, Michael Tretter wrote:
> Calculating the byte_clk in kHz is imprecise for a hs_clock of 55687500
> Hz, which may be used with a pixel clock of 74.25 MHz with mode
> 1920x1080-30.
> 
> Fix the calculation by using HZ instead of kHZ.
> 
> This requires to change the type to u64 to prevent overflows of the
> integer type.
> 
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> ---
>  drivers/gpu/drm/bridge/samsung-dsim.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
> index 459be953be55..eb7aca2b9ab7 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -973,10 +973,12 @@ static void samsung_dsim_set_display_mode(struct samsung_dsim *dsi)
>  	u32 reg;
>  
>  	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO) {
> -		int byte_clk_khz = dsi->hs_clock / 1000 / 8;
> -		int hfp = DIV_ROUND_UP((m->hsync_start - m->hdisplay) * byte_clk_khz, m->clock);
> -		int hbp = DIV_ROUND_UP((m->htotal - m->hsync_end) * byte_clk_khz, m->clock);
> -		int hsa = DIV_ROUND_UP((m->hsync_end - m->hsync_start) * byte_clk_khz, m->clock);
> +		u64 byte_clk = dsi->hs_clock / 8;
> +		u64 pix_clk = m->clock * 1000;
> +
> +		int hfp = DIV64_U64_ROUND_UP((m->hsync_start - m->hdisplay) * byte_clk, pix_clk);
> +		int hbp = DIV64_U64_ROUND_UP((m->htotal - m->hsync_end) * byte_clk, pix_clk);
> +		int hsa = DIV64_U64_ROUND_UP((m->hsync_end - m->hsync_start) * byte_clk, pix_clk);

Wouldn't it make sense to use the videomode structure here?

>  
>  		/* remove packet overhead when possible */
>  		hfp = max(hfp - 6, 0);
> 

Best regards,
Maxim
