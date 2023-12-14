Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7C0813276
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573403AbjLNOGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573393AbjLNOF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:05:57 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8526129;
        Thu, 14 Dec 2023 06:06:01 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c256ffdbcso83820645e9.2;
        Thu, 14 Dec 2023 06:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702562760; x=1703167560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pVJeJO1HsRZL15USbnvPbmKRRvrh/D+wF6I/BbjUvtY=;
        b=O1I5A7KWZ0ycwIeNPvtSSqgdk0Oam622oVsIP1tNdkAxpCqKKypf85FIwXWJh4dgeF
         PEIxewzkVbhewGokjut3ZLhMZ115I/OiJwth5Pgt5ndlJp5r8xDLQXLsHJMR5gwJx5Ao
         LOIn+WzoJwks3wn2ACsGA/oUR+hR77nmEQTabn6CHWx42UFQjEHtbRAsAdoFHB3e+nWi
         /e8MSZIG/mYX1pukz/aC4JDWNzKjmLMDYdnzCJ5HhiN3pKY6uqKtcTJDy9n5/LUDs21T
         svKUfs/NwHZAipe0k5DtAs/jUNk4YhRk5FED6FC4hCVmvl7T9eCLCpSfHuwFfkJSQJWS
         RZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702562760; x=1703167560;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pVJeJO1HsRZL15USbnvPbmKRRvrh/D+wF6I/BbjUvtY=;
        b=AdvFxO6w8xh5RjNHyuE5TYWlftUWP+td/mgK65LIRStgtBjJLaR2ixJK83gtQKb3sd
         ZavJuCTXqMATJ31olxoDnYAMA1EGHmiT4cKdcGgeFXlFtMf3k9XuaHyw1xsky3TnIfZV
         XnrTMtXT+2J0y7EQ6Ctx/zqRGhlh4JsYAEl+0iJx8vm4f5vxkrQk/TFz98TjV04mKa2S
         iMwH26AdczscAPN2a8HfrUAdqro6bz6IZuwnYl9NNUuPmBjgjgUDFTgimdbgkMoVyPIg
         80phCRPZ3I2Iu14ICxOAReslnM0uFAK/p+Fnj5M/xm3SByW1SCdaYpESdjjB4wMoCZgb
         f/lg==
X-Gm-Message-State: AOJu0YzA1Jk0RnPSM+PllYyCxC46j1V+XRaNmAGuarwBfIZZ9wYtg6XX
        lGwARmFljW/tKc00kj61cg==
X-Google-Smtp-Source: AGHT+IGEibxucWSKbBiOsWTsKNrxSPrV0djit9jKX1j4/jyMouWXn8buCXt4pJ+c4g6ulVA7yUvrYw==
X-Received: by 2002:a05:600c:1c1f:b0:3fe:4cbc:c345 with SMTP id j31-20020a05600c1c1f00b003fe4cbcc345mr4925156wms.41.1702562760052;
        Thu, 14 Dec 2023 06:06:00 -0800 (PST)
Received: from ?IPV6:2a02:810b:f40:4300:fb6a:140c:b21d:7387? ([2a02:810b:f40:4300:fb6a:140c:b21d:7387])
        by smtp.gmail.com with ESMTPSA id r20-20020a05600c35d400b0040b538047b4sm27230090wmq.3.2023.12.14.06.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 06:05:59 -0800 (PST)
Message-ID: <a8f13e19-7bb3-4a7f-a264-1e1ede1864e0@gmail.com>
Date:   Thu, 14 Dec 2023 15:05:59 +0100
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
 <5f4fc919-681f-44ec-bd44-5788e5b718ca@gmail.com>
 <db3kdzy4ogf3o2fd6apr36s44qitcsxksfkfa2oc77s5y6dv2w@kfji4iszthxa>
From:   Alex Bee <knaerzche@gmail.com>
In-Reply-To: <db3kdzy4ogf3o2fd6apr36s44qitcsxksfkfa2oc77s5y6dv2w@kfji4iszthxa>
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


Am 14.12.23 um 12:33 schrieb Maxime Ripard:
> On Thu, Dec 14, 2023 at 12:12:08PM +0100, Alex Bee wrote:
>> Hi Maxime
>>
>> Am 14.12.23 um 08:56 schrieb Maxime Ripard:
>>> Hi Alex,
>>>
>>> Thanks for working on this!
>>>
>>> On Wed, Dec 13, 2023 at 08:51:18PM +0100, Alex Bee wrote:
>>>> The display controller will always give full range RGB regardless of the
>>>> mode set, but HDMI requires certain modes to be transmitted in limited
>>>> range RGB. This is especially required for HDMI sinks which do not support
>>>> non-standard quantization ranges.
>>>>
>>>> This enables color space conversion for those modes and sets the
>>>> quantization range accordingly in the AVI infoframe.
>>>>
>>>> Fixes: 412d4ae6b7a5 ("drm/rockchip: hdmi: add Innosilicon HDMI support")
>>>> Signed-off-by: Alex Bee <knaerzche@gmail.com>
>>>> ---
>>>>    drivers/gpu/drm/rockchip/inno_hdmi.c | 40 ++++++++++++++++++++++------
>>>>    1 file changed, 32 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
>>>> index 345253e033c5..32626a75723c 100644
>>>> --- a/drivers/gpu/drm/rockchip/inno_hdmi.c
>>>> +++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
>>>> @@ -33,6 +33,7 @@ struct hdmi_data_info {
>>>>    	unsigned int enc_in_format;
>>>>    	unsigned int enc_out_format;
>>>>    	unsigned int colorimetry;
>>>> +	bool rgb_limited_range;
>>>>    };
>>>>    struct inno_hdmi_i2c {
>>>> @@ -308,6 +309,18 @@ static int inno_hdmi_config_video_avi(struct inno_hdmi *hdmi,
>>>>    	else
>>>>    		frame.avi.colorspace = HDMI_COLORSPACE_RGB;
>>>> +	if (hdmi->hdmi_data.enc_out_format == HDMI_COLORSPACE_RGB) {
>>>> +		drm_hdmi_avi_infoframe_quant_range(&frame.avi,
>>>> +						   &hdmi->connector, mode,
>>>> +						   hdmi->hdmi_data.rgb_limited_range ?
>>>> +						   HDMI_QUANTIZATION_RANGE_LIMITED :
>>>> +						   HDMI_QUANTIZATION_RANGE_FULL);
>>>> +	} else {
>>>> +		frame.avi.quantization_range = HDMI_QUANTIZATION_RANGE_DEFAULT;
>>>> +		frame.avi.ycc_quantization_range =
>>>> +			HDMI_YCC_QUANTIZATION_RANGE_LIMITED;
>>>> +	}
>>>> +
>>>>    	return inno_hdmi_upload_frame(hdmi, rc, &frame, INFOFRAME_AVI, 0, 0, 0);
>>>>    }
>>>> @@ -334,14 +347,22 @@ static int inno_hdmi_config_video_csc(struct inno_hdmi *hdmi)
>>>>    	if (data->enc_in_format == data->enc_out_format) {
>>>>    		if ((data->enc_in_format == HDMI_COLORSPACE_RGB) ||
>>>>    		    (data->enc_in_format >= HDMI_COLORSPACE_YUV444)) {
>>>> -			value = v_SOF_DISABLE | v_COLOR_DEPTH_NOT_INDICATED(1);
>>>> -			hdmi_writeb(hdmi, HDMI_VIDEO_CONTRL3, value);
>>>> -
>>>> -			hdmi_modb(hdmi, HDMI_VIDEO_CONTRL,
>>>> -				  m_VIDEO_AUTO_CSC | m_VIDEO_C0_C2_SWAP,
>>>> -				  v_VIDEO_AUTO_CSC(AUTO_CSC_DISABLE) |
>>>> -				  v_VIDEO_C0_C2_SWAP(C0_C2_CHANGE_DISABLE));
>>>> -			return 0;
>>>> +			if (data->enc_in_format == HDMI_COLORSPACE_RGB &&
>>>> +			    data->enc_out_format == HDMI_COLORSPACE_RGB &&
>>>> +			    hdmi->hdmi_data.rgb_limited_range) {
>>>> +				csc_mode = CSC_RGB_0_255_TO_RGB_16_235_8BIT;
>>>> +				auto_csc = AUTO_CSC_DISABLE;
>>>> +				c0_c2_change = C0_C2_CHANGE_DISABLE;
>>>> +				csc_enable = v_CSC_ENABLE;
>>>> +			} else {
>>>> +				value = v_SOF_DISABLE | v_COLOR_DEPTH_NOT_INDICATED(1);
>>>> +				hdmi_writeb(hdmi, HDMI_VIDEO_CONTRL3, value);
>>>> +				hdmi_modb(hdmi, HDMI_VIDEO_CONTRL,
>>>> +					  m_VIDEO_AUTO_CSC | m_VIDEO_C0_C2_SWAP,
>>>> +					  v_VIDEO_AUTO_CSC(AUTO_CSC_DISABLE) |
>>>> +					  v_VIDEO_C0_C2_SWAP(C0_C2_CHANGE_DISABLE));
>>>> +				return 0;
>>>> +			}
>>>>    		}
>>>>    	}
>>>> @@ -458,6 +479,9 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
>>>>    	else
>>>>    		hdmi->hdmi_data.colorimetry = HDMI_COLORIMETRY_ITU_709;
>>>> +	hdmi->hdmi_data.rgb_limited_range =
>>>> +		drm_default_rgb_quant_range(mode) == HDMI_QUANTIZATION_RANGE_LIMITED;
>>>> +
>>> This patch conflicts heavily with my inno_hdmi patches here (patches 22 to 38):
>>> https://lore.kernel.org/dri-devel/20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org/
>> I'm aware of that and I mentioned it in the cover letter.
> Sorry, I missed that part.
>
>> Your series is not merged yet and it didn't get much feedback so far.
>> What is the status there?
> It didn't have much reviews, but I'll hope to change that. For the
> patches 22 to 38 though, it doesn't really matter. Those changes are
> self-contained and can be applied as is outside of the series.
>
>> Especially because you are removing things from inno-hdmi driver (which
>> aren't really required to remove there) which will I have to reintroduce.
> I'm not entirely sure which part I remove that are actually going to be
> used here.
I'm refering to [PATCH v5 33/44] which completly removes csc coeffs but 
this series needs the CSC_RGB_0_255_TO_RGB_16_235_8BIT  coeffs and  
[PATCH v5 29/44] which removes writing csc_coeffs to the hardware.
>
>>> I would appreciate if you could test and merge them into your series.
>>>
>>> In particular, there's no need to store the range here: enc_out_format
>> rgb_limited_range is currently not only used for csc, but also for for
>> infoframe creation. So it makes sense to have this stored  to avoid calling
>> drm_default_rgb_quant_range twice.
> You're right, I missed one. Still, it shouldn't be stored in the
> hdmi_data_info structure, it's tied to the mode, and the mode is part of
> the state, so it's not a property to a given device, but it's tied to
> the connector state.
>
> So if you want to do so, you should really create a custom state
> structure and store the range there, just like vc4 is doing for example.

OK - I'll check.

Alex

>
> Maxime
