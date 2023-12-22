Return-Path: <linux-kernel+bounces-9985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970A881CE25
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C51528A775
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B152C1A9;
	Fri, 22 Dec 2023 17:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlpONAjz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F592C199;
	Fri, 22 Dec 2023 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ccae5719cfso7034571fa.1;
        Fri, 22 Dec 2023 09:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703267511; x=1703872311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0dJEbxddZykrxGq+8fDRLJfMAa7JxIMNTLEIMv/B4fQ=;
        b=TlpONAjzRMj4k6Y0P10KGuLAzs9+NuNcFH1ZbaOOkMCjedBnFCYEi+6ne2FmSQSv87
         d6XKLFBLRmClWcf2APoRq5Qq55M3nwHU629vvI5Ss69FuGsRjZZ8/GxfoQg+g495oXRl
         syRd+lVXA+lsde0P1axcQt6GPIxSkSQLKNdCSSmNVwgzh2HNY6gGEMKIT0gsVn+BTOrj
         fCwe2Xn+BIGfnvCgv33A8H+sDsJW5N0kEXO2XpSTuOuJz0smBiytpqAlRxlw5lf7s6qK
         wnsltUUSV1lzXCxOMaqyyXxyv0RTdc7ObM16AoiVw1bKiYwHVJ7/wQpJeBdW+byo8anO
         LEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703267511; x=1703872311;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0dJEbxddZykrxGq+8fDRLJfMAa7JxIMNTLEIMv/B4fQ=;
        b=Vka6yPWD9M/bQSKCg/OfytjbBvG40DsAdZVBeAQqjWq13jBHbQ2ykVQg4HEd2YDZz7
         LfR4/L44U0HXdG3IL424A7Q+94CHGbW36TUjuj8aH3Hd4d/iQQgcDBcKLqQxESp0jdcV
         L+x1DjAG80IKoSCSXwAZFv1OUQiUM064aWACITF3RzDbw7XVBluHYuLYqGUorawTkBql
         e4IVace6KI+G5C5K5uw8RDYcMClYxTpAGzsktjTbmkgHWApMkGlq5Jqjk9rFGc8Wnt0s
         jrz4Kdun5dkfX/FdIePj74FKrbQa6wG/h9bh6wLY/2r6As94pu75lxcwPqt6tnmyyhLV
         Mudw==
X-Gm-Message-State: AOJu0YxURvyFMHpCVw848Tlvv+jk9fRJAW2G0Wwwh7uWVCwE39YkQ2cx
	6PjDk8BoXzpvkqj8rG7/5Q==
X-Google-Smtp-Source: AGHT+IGg6N4Sdte4pVXHtfKFyXwvpS+HCjlULl+zL38GRufki+8ZgaUWV81tV7LCLJJv0KeT/EWolg==
X-Received: by 2002:a2e:9611:0:b0:2cc:9548:8d31 with SMTP id v17-20020a2e9611000000b002cc95488d31mr453765ljh.184.1703267511314;
        Fri, 22 Dec 2023 09:51:51 -0800 (PST)
Received: from ?IPV6:2a02:810b:f40:4300:f3ae:2788:7e03:f44? ([2a02:810b:f40:4300:f3ae:2788:7e03:f44])
        by smtp.gmail.com with ESMTPSA id n13-20020a05640204cd00b00554745eca8csm377398edw.59.2023.12.22.09.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Dec 2023 09:51:50 -0800 (PST)
Message-ID: <ebe86636-95aa-4766-b8d8-de5d81218537@gmail.com>
Date: Fri, 22 Dec 2023 18:51:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/27] drm/rockchip: inno_hdmi: Move tmds rate to
 connector state subclass
Content-Language: en-US, de-DE
From: Alex Bee <knaerzche@gmail.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20231216162639.125215-1-knaerzche@gmail.com>
 <20231216162639.125215-20-knaerzche@gmail.com>
 <xte5vjc3o77wnlozz6sy5yysiezdxbzvbwdblhbqb5s2nwnnv5@xxknftdeo6uk>
 <cbb7866c-5e72-4656-966e-9c2244afedbd@gmail.com>
In-Reply-To: <cbb7866c-5e72-4656-966e-9c2244afedbd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Maxime,

Am 18.12.23 um 13:49 schrieb Alex Bee:
>
> Am 18.12.23 um 11:06 schrieb Maxime Ripard:
>> Hi,
>>
>> On Sat, Dec 16, 2023 at 05:26:30PM +0100, Alex Bee wrote:
>>> Similar to the othter members of inno_hdmi_connector_state the 
>>> tmds_rate is
>>> not a property of the device, but of the connector state. Move it to
>>> inno_hdmi_connector_state and make it a long to comply with the clock
>>> framework. To get arround the issue of not having the connector 
>>> state when
>>> inno_hdmi_i2c_init is called in the bind path, getting the tmds rate is
>>> wrapped in function which returns the fallback rate if the connector
>>> doesn't have a state yet.
>>>
>>> Signed-off-by: Alex Bee <knaerzche@gmail.com>
>>> ---
>>> changes in v2:
>>>   - new patch
>>>
>>>   drivers/gpu/drm/rockchip/inno_hdmi.c | 36 
>>> +++++++++++++++++++---------
>>>   1 file changed, 25 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c 
>>> b/drivers/gpu/drm/rockchip/inno_hdmi.c
>>> index f9bfae1e97a2..6799d24501b8 100644
>>> --- a/drivers/gpu/drm/rockchip/inno_hdmi.c
>>> +++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
>>> @@ -47,14 +47,13 @@ struct inno_hdmi {
>>>         struct inno_hdmi_i2c *i2c;
>>>       struct i2c_adapter *ddc;
>>> -
>>> -    unsigned int tmds_rate;
>>>   };
>>>     struct inno_hdmi_connector_state {
>>>       struct drm_connector_state    base;
>>>       unsigned int            enc_out_format;
>>>       unsigned int            colorimetry;
>>> +    unsigned long            tmds_rate;
>>>   };
>>>     static struct inno_hdmi *encoder_to_inno_hdmi(struct drm_encoder 
>>> *encoder)
>>> @@ -133,11 +132,33 @@ static inline void hdmi_modb(struct inno_hdmi 
>>> *hdmi, u16 offset,
>>>       hdmi_writeb(hdmi, offset, temp);
>>>   }
>>>   +static unsigned long inno_hdmi_tmds_rate(struct inno_hdmi *hdmi)
>>> +{
>>> +    struct drm_connector *connector = &hdmi->connector;
>>> +    struct drm_connector_state *conn_state = connector->state;
>>> +    struct inno_hdmi_connector_state *inno_conn_state;
>>> +
>>> +    if (conn_state) {
>>> +        inno_conn_state = to_inno_hdmi_conn_state(conn_state);
>>> +        return inno_conn_state->tmds_rate;
>>> +    }
>>> +
>>> +    /*
>>> +     * When IP controller haven't configured to an accurate video
>>> +     * timing, then the TMDS clock source would be switched to
>>> +     * PCLK_HDMI, so we need to init the TMDS rate to PCLK rate,
>>> +     * and reconfigure the DDC clock.
>>> +     */
>>> +
>>> +    return clk_get_rate(hdmi->pclk);
>>> +}
>>> +
>>>   static void inno_hdmi_i2c_init(struct inno_hdmi *hdmi)
>>>   {
>>>       int ddc_bus_freq;
>>> +    unsigned long tmds_rate = inno_hdmi_tmds_rate(hdmi);
>>>   -    ddc_bus_freq = (hdmi->tmds_rate >> 2) / HDMI_SCL_RATE;
>>> +    ddc_bus_freq = (tmds_rate >> 2) / HDMI_SCL_RATE;
>>>         hdmi_writeb(hdmi, DDC_BUS_FREQ_L, ddc_bus_freq & 0xFF);
>>>       hdmi_writeb(hdmi, DDC_BUS_FREQ_H, (ddc_bus_freq >> 8) & 0xFF);
>>> @@ -431,7 +452,7 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
>>>        * DCLK_LCDC, so we need to init the TMDS rate to mode pixel
>>>        * clock rate, and reconfigure the DDC clock.
>>>        */
>>> -    hdmi->tmds_rate = mode->clock * 1000;
>>> +    inno_conn_state->tmds_rate = mode->clock * 1000;
>>>       inno_hdmi_i2c_init(hdmi);
>>>         /* Unmute video and audio output */
>>> @@ -823,13 +844,6 @@ static int inno_hdmi_bind(struct device *dev, 
>>> struct device *master,
>>>           goto err_disable_clk;
>>>       }
>>>   -    /*
>>> -     * When IP controller haven't configured to an accurate video
>>> -     * timing, then the TMDS clock source would be switched to
>>> -     * PCLK_HDMI, so we need to init the TMDS rate to PCLK rate,
>>> -     * and reconfigure the DDC clock.
>>> -     */
>>> -    hdmi->tmds_rate = clk_get_rate(hdmi->pclk);
>>>       inno_hdmi_i2c_init(hdmi);
>> I still think my patch is better there.
>>
I found a way now and added your patch which removes the tmds_rate: I
noticed powering up the phy initially isn't necessary at all (and makes no
sense). I refactored inno_hdmi_set_pwr_mode in two functions (in a similar
way you did for the infoframe), so that the tmds rate (pixelclock) is only
needed as parameter when a mode is set.

Alex

>> There's two places that use the inno_hdmi.tmds_rate field: the two
>> callers of inno_hdmi_i2c_init(). One is at bind time and needs to
>> initialise it with a sane default since we don't have a mode set yet,
>> the other is to update the internal clock rate while we have a mode set.
> That’s, unfortunately, not fully true: inno_hdmi_set_pwr_mode not only
> called at mode_set-time, but also in inno_hdmi_reset which is called 
> in the
> bind path (where we do not have a mode). That’s the point why I thought
> extracting this in function makes sense. Otherwise I would have to 
> pass the
> tmds_rate to inno_hdmi_set_pwr_mode (also for the LOWER_PWR-case where I
> don't need it) or do that whole fallback-if-no-mode thing in
> inno_hdmi_set_pwr_mode directly. Neither would make the code easier to
> follow. Being able to use it in inno_hdmi_i2c_init also is a nice 
> gimmick.
> I agree, having it in the custom connector state is not strictly 
> required,
> but I'd really like to keep the wrapping function.
>
> Alex
>
>> Since there's a single "modeset" user, there's no need to store it in
>> the state structure at all: it can be a local variable.
>>
>> And in the bind function, you're not going to use the state structure
>> either since there's no state, and it's just a default that has no
>> relation to the modeset code at all.
>>
>> Your function on the other end tries to reconcile and handle the two.
>> But there's no reason to, it just makes the code harder to follow. Just
>> pass the parent rate you want to init with as an argument and it's easy
>> to read and maintain.
>>
>> Maxime

