Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F57813658
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjLNQe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLNQe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:34:57 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AE6A6;
        Thu, 14 Dec 2023 08:35:02 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40c38e292c8so5231965e9.0;
        Thu, 14 Dec 2023 08:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702571701; x=1703176501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XbG+eAMrQaBWQ+wuswfsb9grx3t71hV/JH/fBc408/Q=;
        b=ODU27qF5/4ZV7Q8zSiHaIdjZbzVXxHNUPesPSMt2pAhVFHqEcezPZQ7rFF+86yGNjp
         jqMW3dtqL12tDZEQN58rzEWwXmqAjhktVz+arC3pfWU/qoZHqTfEcRy4jqT5TbukuLvv
         1in0637YIaEmkBZRVaSld2hnTdsb82Ab/62TLaNn6LFVmt88Wwah740puDzw8mbXDKlU
         Ju8rTc6XMHewrxZrbJAncoFPxN52dld5uOuvVKCFDaaf1QMuxXRzzXwjBRQUpQ+GJ+bo
         mUvq32nEoPxgdMJ4jsgKd5+ffuu0eUzAIrKviXd/NB0vGvZQB1UlPPrLOL+o6faL16jy
         dmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702571701; x=1703176501;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XbG+eAMrQaBWQ+wuswfsb9grx3t71hV/JH/fBc408/Q=;
        b=sMXLwzyYzv6zqjZHm3yib4dApxb5cnDxPZ6VKxVNvU6xegRRED/2cy1cp6Nbrvnlj7
         zepX+/ZYg0OBCFYeMiiqf+B5MzLQ2RnFE1a9x3Xa1+HxvPiy8j/OWzAAeg1hQCEcJq10
         /6nz9c0zSIkoaSLy1ISHaAzp2vr+vtyNLNkJp17SiegWyqbr/RM3JR49qnGM6aSYZIQx
         zHmieVtkTsDqrNddZXFXEeGkqTuDJbmwxG8Fj2qUwv/TpDtxGLE3fNq0+2WDco2kC48a
         +ASYJ6IDGggfVPGwE0Z9yn7OILfEZttvDBRq1EkgJQ9RCng9E5LhQ9x1mtjMsJdGAHla
         XBHQ==
X-Gm-Message-State: AOJu0YxH/fLGejnLjGof3Vo0JaXzJRtRcuvwPgdGZwyd3oRREa62BVQC
        QKISQyWN6spnfZz0X7pAMQ==
X-Google-Smtp-Source: AGHT+IHEhJt9TnAC+6/28vyZWFHxbmVh3rWrJ5sW42wi+b946fK82gifA8YHOhMiGtePzXIRfssCoQ==
X-Received: by 2002:a05:600c:4d82:b0:40b:5e56:7b36 with SMTP id v2-20020a05600c4d8200b0040b5e567b36mr4568736wmp.127.1702571701014;
        Thu, 14 Dec 2023 08:35:01 -0800 (PST)
Received: from ?IPV6:2a02:810b:f40:4300:fb6a:140c:b21d:7387? ([2a02:810b:f40:4300:fb6a:140c:b21d:7387])
        by smtp.gmail.com with ESMTPSA id h5-20020a05600c314500b0040b56f2cce3sm27378055wmo.23.2023.12.14.08.35.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 08:35:00 -0800 (PST)
Message-ID: <3f970571-f454-4615-8234-64ea68a3d63c@gmail.com>
Date:   Thu, 14 Dec 2023 17:34:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] drm/rockchip: inno_hdmi: Correctly setup HDMI
 quantization range
Content-Language: en-US, de-DE
To:     Maxime Ripard <mripard@kernel.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Sandy Huang <hjc@rock-chips.com>, Andy Yan <andyshrk@163.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231213195125.212923-1-knaerzche@gmail.com>
 <w7cj24se5gjomfynp5yindnh3s2pea4p3f46u6y7lcci7hri32@62i6hg26pheb>
 <5f4fc919-681f-44ec-bd44-5788e5b718ca@gmail.com> <3053311.k3LOHGUjKi@diego>
 <qr7if2k76wdqgevdcwqxj2dkcbga72owjqlk3qaazujhejjloo@cnvmuq27qqns>
From:   Alex Bee <knaerzche@gmail.com>
In-Reply-To: <qr7if2k76wdqgevdcwqxj2dkcbga72owjqlk3qaazujhejjloo@cnvmuq27qqns>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko, Hi Maxime,

Am 14.12.23 um 12:36 schrieb Maxime Ripard:
> On Thu, Dec 14, 2023 at 12:17:34PM +0100, Heiko Stübner wrote:
>> Am Donnerstag, 14. Dezember 2023, 12:12:08 CET schrieb Alex Bee:
>>> Hi Maxime
>>>
>>> Am 14.12.23 um 08:56 schrieb Maxime Ripard:
>>>> Hi Alex,
>>>>
>>>> Thanks for working on this!
>>>>
>>>> On Wed, Dec 13, 2023 at 08:51:18PM +0100, Alex Bee wrote:
>>>>> The display controller will always give full range RGB regardless of the
>>>>> mode set, but HDMI requires certain modes to be transmitted in limited
>>>>> range RGB. This is especially required for HDMI sinks which do not support
>>>>> non-standard quantization ranges.
>>>>>
>>>>> This enables color space conversion for those modes and sets the
>>>>> quantization range accordingly in the AVI infoframe.
>>>>>
>>>>> Fixes: 412d4ae6b7a5 ("drm/rockchip: hdmi: add Innosilicon HDMI support")
>>>>> Signed-off-by: Alex Bee <knaerzche@gmail.com>
>>>>> ---
>>>>>    drivers/gpu/drm/rockchip/inno_hdmi.c | 40 ++++++++++++++++++++++------
>>>>>    1 file changed, 32 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
>>>>> index 345253e033c5..32626a75723c 100644
>>>>> --- a/drivers/gpu/drm/rockchip/inno_hdmi.c
>>>>> +++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
>>>>> @@ -33,6 +33,7 @@ struct hdmi_data_info {
>>>>>    	unsigned int enc_in_format;
>>>>>    	unsigned int enc_out_format;
>>>>>    	unsigned int colorimetry;
>>>>> +	bool rgb_limited_range;
>>>>>    };
>>>>>    
>>>>>    struct inno_hdmi_i2c {
>>>>> @@ -308,6 +309,18 @@ static int inno_hdmi_config_video_avi(struct inno_hdmi *hdmi,
>>>>>    	else
>>>>>    		frame.avi.colorspace = HDMI_COLORSPACE_RGB;
>>>>>    
>>>>> +	if (hdmi->hdmi_data.enc_out_format == HDMI_COLORSPACE_RGB) {
>>>>> +		drm_hdmi_avi_infoframe_quant_range(&frame.avi,
>>>>> +						   &hdmi->connector, mode,
>>>>> +						   hdmi->hdmi_data.rgb_limited_range ?
>>>>> +						   HDMI_QUANTIZATION_RANGE_LIMITED :
>>>>> +						   HDMI_QUANTIZATION_RANGE_FULL);
>>>>> +	} else {
>>>>> +		frame.avi.quantization_range = HDMI_QUANTIZATION_RANGE_DEFAULT;
>>>>> +		frame.avi.ycc_quantization_range =
>>>>> +			HDMI_YCC_QUANTIZATION_RANGE_LIMITED;
>>>>> +	}
>>>>> +
>>>>>    	return inno_hdmi_upload_frame(hdmi, rc, &frame, INFOFRAME_AVI, 0, 0, 0);
>>>>>    }
>>>>>    
>>>>> @@ -334,14 +347,22 @@ static int inno_hdmi_config_video_csc(struct inno_hdmi *hdmi)
>>>>>    	if (data->enc_in_format == data->enc_out_format) {
>>>>>    		if ((data->enc_in_format == HDMI_COLORSPACE_RGB) ||
>>>>>    		    (data->enc_in_format >= HDMI_COLORSPACE_YUV444)) {
>>>>> -			value = v_SOF_DISABLE | v_COLOR_DEPTH_NOT_INDICATED(1);
>>>>> -			hdmi_writeb(hdmi, HDMI_VIDEO_CONTRL3, value);
>>>>> -
>>>>> -			hdmi_modb(hdmi, HDMI_VIDEO_CONTRL,
>>>>> -				  m_VIDEO_AUTO_CSC | m_VIDEO_C0_C2_SWAP,
>>>>> -				  v_VIDEO_AUTO_CSC(AUTO_CSC_DISABLE) |
>>>>> -				  v_VIDEO_C0_C2_SWAP(C0_C2_CHANGE_DISABLE));
>>>>> -			return 0;
>>>>> +			if (data->enc_in_format == HDMI_COLORSPACE_RGB &&
>>>>> +			    data->enc_out_format == HDMI_COLORSPACE_RGB &&
>>>>> +			    hdmi->hdmi_data.rgb_limited_range) {
>>>>> +				csc_mode = CSC_RGB_0_255_TO_RGB_16_235_8BIT;
>>>>> +				auto_csc = AUTO_CSC_DISABLE;
>>>>> +				c0_c2_change = C0_C2_CHANGE_DISABLE;
>>>>> +				csc_enable = v_CSC_ENABLE;
>>>>> +			} else {
>>>>> +				value = v_SOF_DISABLE | v_COLOR_DEPTH_NOT_INDICATED(1);
>>>>> +				hdmi_writeb(hdmi, HDMI_VIDEO_CONTRL3, value);
>>>>> +				hdmi_modb(hdmi, HDMI_VIDEO_CONTRL,
>>>>> +					  m_VIDEO_AUTO_CSC | m_VIDEO_C0_C2_SWAP,
>>>>> +					  v_VIDEO_AUTO_CSC(AUTO_CSC_DISABLE) |
>>>>> +					  v_VIDEO_C0_C2_SWAP(C0_C2_CHANGE_DISABLE));
>>>>> +				return 0;
>>>>> +			}
>>>>>    		}
>>>>>    	}
>>>>>    
>>>>> @@ -458,6 +479,9 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
>>>>>    	else
>>>>>    		hdmi->hdmi_data.colorimetry = HDMI_COLORIMETRY_ITU_709;
>>>>>    
>>>>> +	hdmi->hdmi_data.rgb_limited_range =
>>>>> +		drm_default_rgb_quant_range(mode) == HDMI_QUANTIZATION_RANGE_LIMITED;
>>>>> +
>>>> This patch conflicts heavily with my inno_hdmi patches here (patches 22 to 38):
>>>> https://lore.kernel.org/dri-devel/20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org/
>>> I'm aware of that and I mentioned it in the cover letter. Your series is
>>> not merged yet and it didn't get much feedback so far. What is the
>>> status there? Especially because you are removing things from inno-hdmi
>>> driver (which aren't really required to remove there) which will I have
>>> to reintroduce.
>> Sadly I haven't found the time to look closer at Maxime's series so far,
>> but I got the impression that it separates into multiple cleanup steps
>> for a number of controllers.
> Yeah, one of the previous version comment was to support more
> controllers than vc4, which is fair. So I ended up reworking and
> converting multiple controllers, but most of the clean up changes can be
> applied outside of that series just fine.
>
> I just didn't find someone to test / review them yet :)

I'm not exactly sure how to proceed here. Do you want me to:

- base my patches on top of Maxime's series and reintroduce csc things 
(of course only those which touch inno-hdmi w/o the framwork changes)

- only apply the patches that do not touch csc things and base my 
series  on top of that

- adapt Maxime's patches so that RGB full to RGB limited stays in there

- wait with resend until Maxime's series is merged and reintroduce csc 
after that

- something else

?

Please advise.

Thanks,

Alex

> Maxime
