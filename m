Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9BF812E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443946AbjLNLMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443857AbjLNLMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:12:05 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AFECF;
        Thu, 14 Dec 2023 03:12:11 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c41df5577so48031395e9.0;
        Thu, 14 Dec 2023 03:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702552330; x=1703157130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jt3J4/XVejxY3vgug3dZf1dqYgtLiD4GN4h1GZSs4D4=;
        b=YnJulgdBd8YSfRiZzimKbJap51oNVhS+BKk4sR6Xd7bWqVZ1EZxJ/KviYXtpVqTBCG
         iTHx6sCHqd9tO6hEbwIwZLIakG8vSYWVJ9kSzCjc/OZ83Ew6BTWoem3JL0DTp1ENBFSk
         f+vwX5vPf5ANhNSLec9ssY4T6J/Y0iaMWu6w1pEmmiMiX8lKDbGKgNtEkwCnxqtTBvrm
         l2IV0+d8GdY59AuRFk0nBekiUqJLCSDCu0Hku6ZPjJSKcIsb0dhnSST3RGiLZCFPKS5T
         Nf6qBTqWrqnyI/09+yCDW8qxDI4MmiN+g1/sxKeC55GAZjSaRSqOdpKe5M/23W0q9WgX
         7/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702552330; x=1703157130;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jt3J4/XVejxY3vgug3dZf1dqYgtLiD4GN4h1GZSs4D4=;
        b=RZQq9OSzhIhbFxgt01P9AzNaVkTBtgxukA5NDdoV0I+LtjNb9t8gkxiuHDHTeTyBVK
         pTj8EiYyvl6J701mUHUAyQamzYL48qaHvKNLWxRKg7VUlqqw4HV+Zr0/HXXJr+LPTWZ/
         kIASaVcmrcfl2apAIyVsI83X2V6LNsAegbBv8ZEEh0f9gBW5m2GWWv3CQOC5mxIoyYyn
         i8myM5qvwVPPeie/aWSCPgoi2Yj6buAFLqI/hiZM/3nDmxMA77SlVzS8t5NBrVqmUdcx
         zU3LncQ3xVEndCZOphVqHyfCqy2Hb9jXP9PJqlIPsyd068BL+eVVUsFIrAm/03ev7Uh0
         q4Zg==
X-Gm-Message-State: AOJu0YxifdawPo63ioslMd+TROdM4ykksf0pV2IAOO7FpCpkG/mKsiM9
        y/uqlyxsbl8oAFX0pIczwA==
X-Google-Smtp-Source: AGHT+IH6qQC1lEItZ7W1lmW+7AIvLe0ftRHmT6AJLFYLNgUi45vN5PWdueQZ+pgIonqZbP1xpBjkFg==
X-Received: by 2002:a05:600c:3657:b0:40c:35b3:b797 with SMTP id y23-20020a05600c365700b0040c35b3b797mr2444927wmq.35.1702552329884;
        Thu, 14 Dec 2023 03:12:09 -0800 (PST)
Received: from ?IPV6:2a02:810b:f40:4300:bca3:dfc6:dafa:abb2? ([2a02:810b:f40:4300:bca3:dfc6:dafa:abb2])
        by smtp.gmail.com with ESMTPSA id l39-20020a05600c1d2700b0040c2c5f5844sm24347188wms.21.2023.12.14.03.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 03:12:09 -0800 (PST)
Message-ID: <5f4fc919-681f-44ec-bd44-5788e5b718ca@gmail.com>
Date:   Thu, 14 Dec 2023 12:12:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] drm/rockchip: inno_hdmi: Correctly setup HDMI
 quantization range
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
 <20231213195125.212923-5-knaerzche@gmail.com>
 <w7cj24se5gjomfynp5yindnh3s2pea4p3f46u6y7lcci7hri32@62i6hg26pheb>
From:   Alex Bee <knaerzche@gmail.com>
In-Reply-To: <w7cj24se5gjomfynp5yindnh3s2pea4p3f46u6y7lcci7hri32@62i6hg26pheb>
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

Hi Maxime

Am 14.12.23 um 08:56 schrieb Maxime Ripard:
> Hi Alex,
>
> Thanks for working on this!
>
> On Wed, Dec 13, 2023 at 08:51:18PM +0100, Alex Bee wrote:
>> The display controller will always give full range RGB regardless of the
>> mode set, but HDMI requires certain modes to be transmitted in limited
>> range RGB. This is especially required for HDMI sinks which do not support
>> non-standard quantization ranges.
>>
>> This enables color space conversion for those modes and sets the
>> quantization range accordingly in the AVI infoframe.
>>
>> Fixes: 412d4ae6b7a5 ("drm/rockchip: hdmi: add Innosilicon HDMI support")
>> Signed-off-by: Alex Bee <knaerzche@gmail.com>
>> ---
>>   drivers/gpu/drm/rockchip/inno_hdmi.c | 40 ++++++++++++++++++++++------
>>   1 file changed, 32 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
>> index 345253e033c5..32626a75723c 100644
>> --- a/drivers/gpu/drm/rockchip/inno_hdmi.c
>> +++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
>> @@ -33,6 +33,7 @@ struct hdmi_data_info {
>>   	unsigned int enc_in_format;
>>   	unsigned int enc_out_format;
>>   	unsigned int colorimetry;
>> +	bool rgb_limited_range;
>>   };
>>   
>>   struct inno_hdmi_i2c {
>> @@ -308,6 +309,18 @@ static int inno_hdmi_config_video_avi(struct inno_hdmi *hdmi,
>>   	else
>>   		frame.avi.colorspace = HDMI_COLORSPACE_RGB;
>>   
>> +	if (hdmi->hdmi_data.enc_out_format == HDMI_COLORSPACE_RGB) {
>> +		drm_hdmi_avi_infoframe_quant_range(&frame.avi,
>> +						   &hdmi->connector, mode,
>> +						   hdmi->hdmi_data.rgb_limited_range ?
>> +						   HDMI_QUANTIZATION_RANGE_LIMITED :
>> +						   HDMI_QUANTIZATION_RANGE_FULL);
>> +	} else {
>> +		frame.avi.quantization_range = HDMI_QUANTIZATION_RANGE_DEFAULT;
>> +		frame.avi.ycc_quantization_range =
>> +			HDMI_YCC_QUANTIZATION_RANGE_LIMITED;
>> +	}
>> +
>>   	return inno_hdmi_upload_frame(hdmi, rc, &frame, INFOFRAME_AVI, 0, 0, 0);
>>   }
>>   
>> @@ -334,14 +347,22 @@ static int inno_hdmi_config_video_csc(struct inno_hdmi *hdmi)
>>   	if (data->enc_in_format == data->enc_out_format) {
>>   		if ((data->enc_in_format == HDMI_COLORSPACE_RGB) ||
>>   		    (data->enc_in_format >= HDMI_COLORSPACE_YUV444)) {
>> -			value = v_SOF_DISABLE | v_COLOR_DEPTH_NOT_INDICATED(1);
>> -			hdmi_writeb(hdmi, HDMI_VIDEO_CONTRL3, value);
>> -
>> -			hdmi_modb(hdmi, HDMI_VIDEO_CONTRL,
>> -				  m_VIDEO_AUTO_CSC | m_VIDEO_C0_C2_SWAP,
>> -				  v_VIDEO_AUTO_CSC(AUTO_CSC_DISABLE) |
>> -				  v_VIDEO_C0_C2_SWAP(C0_C2_CHANGE_DISABLE));
>> -			return 0;
>> +			if (data->enc_in_format == HDMI_COLORSPACE_RGB &&
>> +			    data->enc_out_format == HDMI_COLORSPACE_RGB &&
>> +			    hdmi->hdmi_data.rgb_limited_range) {
>> +				csc_mode = CSC_RGB_0_255_TO_RGB_16_235_8BIT;
>> +				auto_csc = AUTO_CSC_DISABLE;
>> +				c0_c2_change = C0_C2_CHANGE_DISABLE;
>> +				csc_enable = v_CSC_ENABLE;
>> +			} else {
>> +				value = v_SOF_DISABLE | v_COLOR_DEPTH_NOT_INDICATED(1);
>> +				hdmi_writeb(hdmi, HDMI_VIDEO_CONTRL3, value);
>> +				hdmi_modb(hdmi, HDMI_VIDEO_CONTRL,
>> +					  m_VIDEO_AUTO_CSC | m_VIDEO_C0_C2_SWAP,
>> +					  v_VIDEO_AUTO_CSC(AUTO_CSC_DISABLE) |
>> +					  v_VIDEO_C0_C2_SWAP(C0_C2_CHANGE_DISABLE));
>> +				return 0;
>> +			}
>>   		}
>>   	}
>>   
>> @@ -458,6 +479,9 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
>>   	else
>>   		hdmi->hdmi_data.colorimetry = HDMI_COLORIMETRY_ITU_709;
>>   
>> +	hdmi->hdmi_data.rgb_limited_range =
>> +		drm_default_rgb_quant_range(mode) == HDMI_QUANTIZATION_RANGE_LIMITED;
>> +
> This patch conflicts heavily with my inno_hdmi patches here (patches 22 to 38):
> https://lore.kernel.org/dri-devel/20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org/
I'm aware of that and I mentioned it in the cover letter. Your series is 
not merged yet and it didn't get much feedback so far. What is the 
status there? Especially because you are removing things from inno-hdmi 
driver (which aren't really required to remove there) which will I have 
to reintroduce.

> I would appreciate if you could test and merge them into your series.
>
> In particular, there's no need to store the range here: enc_out_format
rgb_limited_range is currently not only used for csc, but also for for 
infoframe creation. So it makes sense to have this stored  to avoid 
calling drm_default_rgb_quant_range twice.

> is always RGB, so you'll always end up calling
> drm_hdmi_avi_infoframe_quant_range(), and you'll always have the same csc values.

I don't think that's true. Non-VIC modes like 800x600 or 1024x764 want 
full range RGB and csc must not be done in those cases.

Alex

>
> Maxime
