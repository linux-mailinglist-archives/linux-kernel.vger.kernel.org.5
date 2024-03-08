Return-Path: <linux-kernel+bounces-96897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFAD8762B7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7971F25D48
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB84D5645F;
	Fri,  8 Mar 2024 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="etjcXPoO"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B414455C07;
	Fri,  8 Mar 2024 11:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709896008; cv=none; b=YIchp+qhrfzyh4smdHKZ2I/31RUFOOKt7/VXhhCNNRfFlwJ3AazH263FbTiVp65RxxEMhVVV6V5U+vlFfIJKAkkFlQdYELwhMY5kuKC5KFKM8AFe0xumnb4W1j+M8X1pgipml139lPAWQlkbvyrha8RgK0aUdGiVq2bVnrY5I4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709896008; c=relaxed/simple;
	bh=oLvt/rPdi86BF82vjpWAcRr8SAf+o021YIyff73q3yE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZFuiY7CzM6KGEvfMpXnu0rNga9bYvqXoWjNlZpn+9kYNh4DSLMCYyfB46BdyBrDgI+mmuLL22SeeqKHgw8GXAOsCbNDhA6JzX2KiGXMWsbwzy/3hH64568leqfziyGF7uGBYqVWs/QFIa8fZxb8bk0LX3rRiRR1wjovvnSDNN40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=etjcXPoO; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8701FFF809;
	Fri,  8 Mar 2024 11:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709896004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Ptz6X1Z3D4WKYLLa+T/MWcgejuk++Ip/X28qrRSyW8=;
	b=etjcXPoOVydHzfrd6N8/ZAGy0gMq4rvt2/2h1b1ECUOdZ/Ehi9TXGT8c4KtkooFIttRasY
	aPcwa6yekn/tW5kefoSj8v1iKD8R9NI9KqFqUG0d3dQ8uvOCNjLg2ePF61eWfWYdI+VhAE
	TCeLn64NcG5pWTdfmlr0dw8/A7l0XaRsPPddyh1YGpC43jHQiD0Sfa3d67LykaUPZEZByU
	oZmXc8Gv2XWq/B4UrGDvkh5tGJw/rPb4Q1bw6Z0+/Ll3S33mlvYf+DHuJR1jHZy9M20CLs
	T4CcZQ17xzz6XSAm1qxRZp0JWGFAv73kqbUAKDNZ4OoPiSvYgPHbDGvVusrGPg==
Message-ID: <5cb1e17c-c283-4092-91ce-5ed03d9d3e48@bootlin.com>
Date: Fri, 8 Mar 2024 12:06:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/panel: simple: add CMT430B19N00 LCD panel
 support
To: Maxime Ripard <mripard@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Yen-Mei Goh <yen-mei.goh@keysight.com>
References: <20240304160454.96977-1-jeremie.dautheribes@bootlin.com>
 <20240304160454.96977-4-jeremie.dautheribes@bootlin.com>
 <20240304-inquisitive-kickass-pronghorn-c641ff@houat>
 <ee36a60d-5b65-4eb8-ac41-e4b6be1cf81f@bootlin.com>
 <20240308-shiny-meaty-duck-446e8d@houat>
Content-Language: en-US
From: =?UTF-8?B?SsOpcsOpbWllIERhdXRoZXJpYmVz?=
 <jeremie.dautheribes@bootlin.com>
In-Reply-To: <20240308-shiny-meaty-duck-446e8d@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jeremie.dautheribes@bootlin.com

Hi Maxime,

On 08/03/2024 11:48, Maxime Ripard wrote:
> On Tue, Mar 05, 2024 at 10:46:55AM +0100, Jérémie Dautheribes wrote:
>> Hi Maxime,
>>
>> On 04/03/2024 17:25, Maxime Ripard wrote:
>>> Hi,
>>>
>>> On Mon, Mar 04, 2024 at 05:04:54PM +0100, Jérémie Dautheribes wrote:
>>>> Add support for Crystal Clear Technology CMT430B19N00 4.3" 480x272
>>>> TFT-LCD panel.
>>>>
>>>> Signed-off-by: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
>>>> ---
>>>>    drivers/gpu/drm/panel/panel-simple.c | 29 ++++++++++++++++++++++++++++
>>>>    1 file changed, 29 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
>>>> index 20e3df1c59d4..b940220f56e2 100644
>>>> --- a/drivers/gpu/drm/panel/panel-simple.c
>>>> +++ b/drivers/gpu/drm/panel/panel-simple.c
>>>> @@ -1457,6 +1457,32 @@ static const struct panel_desc boe_hv070wsa = {
>>>>    	.connector_type = DRM_MODE_CONNECTOR_LVDS,
>>>>    };
>>>> +static const struct drm_display_mode cct_cmt430b19n00_mode = {
>>>> +	.clock = 9000,
>>>> +	.hdisplay = 480,
>>>> +	.hsync_start = 480 + 43,
>>>> +	.hsync_end = 480 + 43 + 8,
>>>> +	.htotal = 480 + 43 + 8 + 4,
>>>> +	.vdisplay = 272,
>>>> +	.vsync_start = 272 + 12,
>>>> +	.vsync_end = 272 + 12 + 8,
>>>> +	.vtotal = 272 + 12 + 8 + 4,
>>>> +	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
>>>> +};
>>>
>>> Your pixel clock doesn't really match the rest of the timings:
>>>
>>> (480 + 43 + 8 + 4) * (272 + 12 + 8 + 4) * 60 = 9501600
>>>
>>> So a ~6% deviation.
>>>
>>> What does the datasheet say?
>>
>> Indeed it does not exactly match but the datasheet indicates that the
>> typical clock frequency is 9MHz and when this frequency is used, the
>> typical values of the other parameters are those we have defined in
>> the drm_display_mode structure.
> 
> It seems weird to me that all the typical timings end up in a
> non-typical configuration, but I've seen my fair share of weird
> datasheet, so.. yeah.
> 
> I guess the best thing to do if you have access to the min/typ/max
> timings is to actually use the display_timings structure here and define
> all of them.

Yes, I do have access to these timings, I'm going to implement the 
display_timing structure as you suggested, thank you!

Regards,

Jérémie

