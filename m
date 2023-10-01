Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115317B4758
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 14:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbjJAMWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 08:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbjJAMWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 08:22:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F56C99
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 05:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696162919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FMGIU5POL9SiIEmaULx1wsxg5CFJY+OhYIdZTwEiDKI=;
        b=NLmonFthbmaHDHa9i/JjxExpo5qiPSzQ6tqHNsQo6ZhReQMg3a6cvmkJdoggk2OvYhyy/c
        jN3hwIqVRHmnCTAfIL2DjIyK3Dvs9kp9gWL3v0pEqze7c2IddLw6RELV07dk5tosS0FMpj
        mRsUSlq82SQRegiBj90vvgM2h0x62kM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-d-0yzPjfM7KukbidPev2-Q-1; Sun, 01 Oct 2023 08:21:48 -0400
X-MC-Unique: d-0yzPjfM7KukbidPev2-Q-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9ae7663e604so1189997666b.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 05:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696162907; x=1696767707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FMGIU5POL9SiIEmaULx1wsxg5CFJY+OhYIdZTwEiDKI=;
        b=D90wMty9Q3qVPln986T5z5cVIOFnyA1wPfeAn1xzuqNtUCuQZPqSXI2TvM0EYSSByM
         vUQoh4RYNV9FFL0pxI3vjM/e5eQLkdGstq+C8GCzRAUspJmum2rrWFOQLN2lhUhrnB6W
         Qj/2It6obbtDXI4uIqaXJOkYK//ZNGn0YWwCfCBCvpfUp8emjx0MIKWsLOAC8QqCAWTi
         IDYOS4Nv3G6pcIm0DzHuBz/P62H88FW4TYh2RamvqwKXzZohEnQmcPxWaoICwNLnVif0
         8l3OmIBOV9hECcs6tboWCBvaxjxmuk5D5Mko06i8qJyjQAMPfcnQ5OJeSGWYa1Lwy0TV
         Um1w==
X-Gm-Message-State: AOJu0YyRuixLIR4b1SjmJLADREHaD4GypToanFpXr51bZNsSnQemY68R
        p/NKlTpKMZ4DG2A7VXGbNPU+xN016oCT0NYN8Dwx2nfEhZp4VM20ZVGcH+8jvKWrxqjHKZfjwpL
        zAijtMMiHVENRYkn11WbSBnZg
X-Received: by 2002:a17:906:73d4:b0:9ae:5643:6493 with SMTP id n20-20020a17090673d400b009ae56436493mr6330469ejl.74.1696162906954;
        Sun, 01 Oct 2023 05:21:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqk5FvPhXMKuwUIH3oorHan+zY0M1hjcx4uYv3u22n+nlM2d//AN1UZsjIYxvE8lc2RM8HMw==
X-Received: by 2002:a17:906:73d4:b0:9ae:5643:6493 with SMTP id n20-20020a17090673d400b009ae56436493mr6330460ejl.74.1696162906621;
        Sun, 01 Oct 2023 05:21:46 -0700 (PDT)
Received: from [10.101.1.23] (ip-185-104-137-32.ptr.icomera.net. [185.104.137.32])
        by smtp.gmail.com with ESMTPSA id k17-20020a170906681100b00992b50fbbe9sm15468711ejr.90.2023.10.01.05.21.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Oct 2023 05:21:46 -0700 (PDT)
Message-ID: <4a86bbd4-4798-b81b-8f08-b2c8c125999d@redhat.com>
Date:   Sun, 1 Oct 2023 14:21:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] drm: panel-orientation-quirks: Add quirk for One Mix
 2S
To:     Kai Uwe Broulik <foss-linux@broulik.de>,
        linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
References: <20231001114710.336172-1-foss-linux@broulik.de>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231001114710.336172-1-foss-linux@broulik.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/1/23 13:47, Kai Uwe Broulik wrote:
> The One Mix 2S is a mini laptop with a 1200x1920 portrait screen
> mounted in a landscape oriented clamshell case. Because of the too
> generic DMI strings this entry is also doing bios-date matching.
> 
> Signed-off-by: Kai Uwe Broulik <foss-linux@broulik.de>
> ---
> Changes since v1:
> * Got two more BIOS dates reported

Thanks, patch still looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

drm-misc maintainers, I'm currently traveling can
one of you push this to drm-misc-fixes please?

Regards,

Hans




> 
>  drivers/gpu/drm/drm_panel_orientation_quirks.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index 0cb646cb04ee..d5c15292ae93 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -38,6 +38,14 @@ static const struct drm_dmi_panel_orientation_data gpd_micropc = {
>  	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
>  };
>  
> +static const struct drm_dmi_panel_orientation_data gpd_onemix2s = {
> +	.width = 1200,
> +	.height = 1920,
> +	.bios_dates = (const char * const []){ "05/21/2018", "10/26/2018",
> +		"03/04/2019", NULL },
> +	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
> +};
> +
>  static const struct drm_dmi_panel_orientation_data gpd_pocket = {
>  	.width = 1200,
>  	.height = 1920,
> @@ -401,6 +409,14 @@ static const struct dmi_system_id orientation_data[] = {
>  		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "LTH17"),
>  		},
>  		.driver_data = (void *)&lcd800x1280_rightside_up,
> +	}, {	/* One Mix 2S (generic strings, also match on bios date) */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Default string"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Default string"),
> +		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Default string"),
> +		  DMI_EXACT_MATCH(DMI_BOARD_NAME, "Default string"),
> +		},
> +		.driver_data = (void *)&gpd_onemix2s,
>  	},
>  	{}
>  };

