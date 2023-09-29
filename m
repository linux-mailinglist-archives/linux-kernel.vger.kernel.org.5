Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D8F7B2ADC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 06:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjI2EJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 00:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjI2EJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 00:09:08 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBD0B7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 21:09:06 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40651a726acso14817515e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 21:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695960545; x=1696565345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KUiX4IeP5dcs+VWg502cfRIf5MgfBL2Llr+m8u48rDc=;
        b=MuM+IJi/G3k5PQuzgzRe39OmXvhm+cl34Qh0GayPMCByNBMrdPeaZzWv+FRiPPxTk1
         pIS3miUFf1EhOVPlPCESvlBh+PbPy5loJAOI0sshYdzRy8CvTsepVo9d8t8/CZW++hlZ
         58EygYxkmHsyczwEsEtzmnyhy0/A1PbcgeMxbTaDy68Cwrd3u6R+PTzzwYBZDDNcQwFm
         KdLPaUF3OrOoQiL18ZUxOTh26GI1tvRB2n0yviEB2VczVbIKGHmydP+6/68XdfAej6UH
         hUA66bh0fgsrN73ws0U53lIRlKgFE/SdgE0j/1GqCaLH6zfjM9vx1qwiap9JlByDkI8w
         n7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695960545; x=1696565345;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUiX4IeP5dcs+VWg502cfRIf5MgfBL2Llr+m8u48rDc=;
        b=hGjM/sDLnz3LzVwjrp1L1R+zmKnbPQ1DOUcv2zy8kUxY8HOFbwLQx2mbiyxm1mjA4F
         3569dQ/0et2haGa4cO2xK8cs944ya0LH/nLKAWyG9ugDqf4A5loItCmYxpxAgfaAyLAu
         kG0YDwrVFY/IHAvdJqlwHMAB8jMKMQLG5zn5vmiaK8sZ3IRb8/jE6RqxiWJ2puVvGgnH
         M4A0Ofq3XEJ8PEWIg7cxrWVtjcSewOf6YqUzybzhRuEYHT3eCh+14fQYtSku47BW1e0s
         L/ADjIplfvFA9RJDJ+qb2U3J4TMdrq88KxXKFf0hLHvuWWn/CLUtPnXkv7+EG65sFaA9
         alAQ==
X-Gm-Message-State: AOJu0YzRHa/s6xfRC/7WPYP4EjseMmt+z6MTfDO3Yg7/vlGRoPieyCWx
        LCG5y8yLsizXpDlNR9i7/lWvsQ==
X-Google-Smtp-Source: AGHT+IEpeY+hEpdBdL8tAE7KjTMNsWXt2lQNzAWPfgLcdjDfX7T/mZ/pA1eqXRFYf5ZD3xcb+v7Oew==
X-Received: by 2002:a7b:c40f:0:b0:401:bcd9:4871 with SMTP id k15-20020a7bc40f000000b00401bcd94871mr2695453wmi.21.1695960544572;
        Thu, 28 Sep 2023 21:09:04 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id b9-20020a05600c11c900b0040596352951sm543237wmi.5.2023.09.28.21.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 21:09:04 -0700 (PDT)
Message-ID: <cd18fa16-e060-f69b-b53c-f1bce4f76430@linaro.org>
Date:   Fri, 29 Sep 2023 06:09:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/3] drm: Spelling s/hardward/hardware/g
Content-Language: en-GB
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <cover.1695903065.git.geert+renesas@glider.be>
 <17b8682bb30f15001afac754d5844194428df5af.1695903065.git.geert+renesas@glider.be>
From:   Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <17b8682bb30f15001afac754d5844194428df5af.1695903065.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 28/09/2023 à 14:16, Geert Uytterhoeven a écrit :
> Fix misspellings of "hardware".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>   include/drm/drm_bridge.h                 | 2 +-
>   include/drm/drm_modeset_helper_vtables.h | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index cfb7dcdb66c4b0b5..05b360a4357fed01 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -107,7 +107,7 @@ struct drm_bridge_funcs {
>   	 * Since this function is both called from the check phase of an atomic
>   	 * commit, and the mode validation in the probe paths it is not allowed
>   	 * to look at anything else but the passed-in mode, and validate it
> -	 * against configuration-invariant hardward constraints. Any further
> +	 * against configuration-invariant hardware constraints. Any further
>   	 * limits which depend upon the configuration can only be checked in
>   	 * @mode_fixup.
>   	 *
> diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
> index e3c3ac615909474b..bbc516f313913254 100644
> --- a/include/drm/drm_modeset_helper_vtables.h
> +++ b/include/drm/drm_modeset_helper_vtables.h
> @@ -134,7 +134,7 @@ struct drm_crtc_helper_funcs {
>   	 * Since this function is both called from the check phase of an atomic
>   	 * commit, and the mode validation in the probe paths it is not allowed
>   	 * to look at anything else but the passed-in mode, and validate it
> -	 * against configuration-invariant hardward constraints. Any further
> +	 * against configuration-invariant hardware constraints. Any further
>   	 * limits which depend upon the configuration can only be checked in
>   	 * @mode_fixup or @atomic_check.
>   	 *
> @@ -550,7 +550,7 @@ struct drm_encoder_helper_funcs {
>   	 * Since this function is both called from the check phase of an atomic
>   	 * commit, and the mode validation in the probe paths it is not allowed
>   	 * to look at anything else but the passed-in mode, and validate it
> -	 * against configuration-invariant hardward constraints. Any further
> +	 * against configuration-invariant hardware constraints. Any further
>   	 * limits which depend upon the configuration can only be checked in
>   	 * @mode_fixup or @atomic_check.
>   	 *

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
