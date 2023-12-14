Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78520812E61
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443760AbjLNLRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443635AbjLNLRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:17:36 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D6A93;
        Thu, 14 Dec 2023 03:17:42 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3333074512bso266610f8f.1;
        Thu, 14 Dec 2023 03:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702552661; x=1703157461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C6K0WZ0aorShhSqsnEfIUTq66rUOD4bR1wUC+mAh/Go=;
        b=D5IW65v9Gn6+NSZRXfak6kcVOSzdwNMFznmoJQhY+OzEJKzv3ltF1pAjcmKbQlDdxu
         pu1u9ea11j6cmbIh3BnMp5Jq437B7WOGj5PEyE95Cx/C+N3nDx6FoXB01QA7sGg4CzYh
         5HtxVfSZhWWNE4Qfq18jdoxWSGvARN0Y0P487r7WpjMnUG/46q/BRZvTUT1oBynHjpAK
         2mH5IpVQTK/9GLH4arR79iD4/2sdNvZxGbE2wUQlcDEZLuddfouJvuGtBDVP1yD2ZrUp
         5T79nX+c+V8ADd9eSdvjaB21X1acibg/vixY7p6eNLcpCo2CZ+IOz2L7NiG/uzSWUS8f
         +d6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702552661; x=1703157461;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C6K0WZ0aorShhSqsnEfIUTq66rUOD4bR1wUC+mAh/Go=;
        b=PkrAyrbQHZlhh4YLLWk9oda4SOpgGnZorQn+gARueISNsUlItAjeC7M4kgvUfNWNIX
         /SJr/m0PJjTfKXhsk82whc4+u/ZPcyEjkhmMViuDN6MPMJ7t8dQeK5vem8ytUunhsVeF
         RmC/Ch0epO2QexaAv/TcnEwdRjNl+0pfe8OVjyfBo5r1vl67tba1N92NHkDoH4iczlDS
         wiFolAh+Mr4PqICb8iU5firywc57OF8In52g6sSYuqjVBu8pUCoqnn6aA5JpKt884YNe
         Ldq34GpfuWL9bgfU9kufteqLCsjzrohei82WzqhAr70U4zr78kIerUjwRZHunT83MaUg
         Hw0w==
X-Gm-Message-State: AOJu0YyaCk4pbVa8yKatAQYoXA/aYfc2wDwk9Plk4WNlZ3RLK1GWJBDY
        N1IsqJPfD6J1gQwOVC2RBA==
X-Google-Smtp-Source: AGHT+IEevINjdmtXYe++Uxj7j+jPTBOYKKNzmXYywCsfxlRMvG2q2Cm/KTwBw8dNerafqLJmB7glqA==
X-Received: by 2002:a05:600c:3d91:b0:40b:5e56:7b4c with SMTP id bi17-20020a05600c3d9100b0040b5e567b4cmr4959384wmb.149.1702552660830;
        Thu, 14 Dec 2023 03:17:40 -0800 (PST)
Received: from ?IPV6:2a02:810b:f40:4300:bca3:dfc6:dafa:abb2? ([2a02:810b:f40:4300:bca3:dfc6:dafa:abb2])
        by smtp.gmail.com with ESMTPSA id e12-20020a05600c4e4c00b0040b398f0585sm24766579wmq.9.2023.12.14.03.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 03:17:40 -0800 (PST)
Message-ID: <1b7402b2-ec03-420b-a81b-3e6ea46e402a@gmail.com>
Date:   Thu, 14 Dec 2023 12:17:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] drm/rockchip: inno_hdmi: Add basic mode validation
Content-Language: en-US, de-DE
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Andy Yan <andyshrk@163.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231213195125.212923-1-knaerzche@gmail.com>
 <20231213195125.212923-8-knaerzche@gmail.com>
 <wz4e43ateg3gb7745mz22wwyruwavevvpfbqsdxeynejcjxhzn@qbqldsnkktei>
From:   Alex Bee <knaerzche@gmail.com>
In-Reply-To: <wz4e43ateg3gb7745mz22wwyruwavevvpfbqsdxeynejcjxhzn@qbqldsnkktei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Am 14.12.23 um 09:05 schrieb Maxime Ripard:
> Hi,
>
> On Wed, Dec 13, 2023 at 08:51:21PM +0100, Alex Bee wrote:
>> As per TRM this controller supports pixelclocks starting from 25 MHz. The
>> maximum supported pixelclocks are defined by the phy configurations we
>> have. Also it can't support modes that require doubled clocks.
>> If there is a phy reference clock we can additionally validate against
>> VESA DMT's recommendations.
>> Those checks are added to the mode_valid hook of the connector and
>> encoder's mode_fixup hook.
>>
>> Signed-off-by: Alex Bee <knaerzche@gmail.com>
>> ---
>>   drivers/gpu/drm/rockchip/inno_hdmi.c | 38 ++++++++++++++++++++++++++--
>>   1 file changed, 36 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
>> index f7f0bec725f9..2f839ff31c1c 100644
>> --- a/drivers/gpu/drm/rockchip/inno_hdmi.c
>> +++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
>> @@ -38,6 +38,8 @@ struct inno_hdmi_variant {
>>   	struct inno_hdmi_phy_config *default_phy_config;
>>   };
>>   
>> +#define INNO_HDMI_MIN_TMDS_CLOCK  25000000U
>> +
>>   struct hdmi_data_info {
>>   	int vic;
>>   	bool sink_has_audio;
>> @@ -572,6 +574,34 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
>>   	return 0;
>>   }
>>   
>> +static enum drm_mode_status inno_hdmi_mode_valid(struct inno_hdmi *hdmi,
>> +						 struct drm_display_mode *mode)
>> +{
> So, mode_valid is only called to filter out the modes retrieved by
> get_modes, but it won't be called when userspace programs a mode. That's
> atomic_check's job.
>
> So you probably want to create a shared function between atomic_check
> and mode_valid, and call it from both places (or call mode_valid from
> atomic_check).
This actually _is_ a shared function called in 
inno_hdmi_connector_mode_valid and inno_hdmi_encoder_mode_fixup. Yes, I  
probably should use it in atomic_check _also_.
>
>> +	/* No support for double-clock modes */
>> +	if (mode->flags & DRM_MODE_FLAG_DBLCLK)
>> +		return MODE_BAD;
>> +
>> +	unsigned int mpixelclk = mode->clock * 1000;
> Variables should be declared at the top of the function.
Oookay ... can move them.
>> +	if (mpixelclk < INNO_HDMI_MIN_TMDS_CLOCK)
>> +		return MODE_CLOCK_LOW;
> You probably want to check the max TMDS clock too?
Not sure what you mean here. For the currently supported formats of this 
driver (rgb only) tmds clock and pixel clock are always the same.
>
>> +	if (inno_hdmi_find_phy_config(hdmi, mpixelclk) < 0)
>> +		return MODE_CLOCK_HIGH;
>> +
>> +	if (hdmi->refclk) {
>> +		long refclk = clk_round_rate(hdmi->refclk, mpixelclk);
>> +		unsigned int max_tolerance = mpixelclk / 5000;
>> +
>> +		/* Vesa DMT standard mentions +/- 0.5% max tolerance */
>> +		if (abs(refclk - mpixelclk) > max_tolerance ||
>> +		    mpixelclk - refclk > max_tolerance;
>> +			return MODE_NOCLOCK;
> You should use abs_diff here. abs() will get confused by the unsigned vs
> signed comparison.
Ack.
>
>> +	}
>> +
>> +	return MODE_OK;
>> +}
>> +
>>   static void inno_hdmi_encoder_mode_set(struct drm_encoder *encoder,
>>   				       struct drm_display_mode *mode,
>>   				       struct drm_display_mode *adj_mode)
>> @@ -602,7 +632,9 @@ static bool inno_hdmi_encoder_mode_fixup(struct drm_encoder *encoder,
>>   					 const struct drm_display_mode *mode,
>>   					 struct drm_display_mode *adj_mode)
>>   {
>> -	return true;
>> +	struct inno_hdmi *hdmi = encoder_to_inno_hdmi(encoder);
>> +
>> +	return inno_hdmi_mode_valid(hdmi, adj_mode) == MODE_OK;
>>   }
> Why do you call mode_valid in mode_fixup?

I'm calling the shared function you asked me to introduce 
(inno_hdmi_connector_mode_valid != inno_mode_valid)

Alex

>
> Maxime
