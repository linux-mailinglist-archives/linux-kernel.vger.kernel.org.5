Return-Path: <linux-kernel+bounces-94290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AE8873C8E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AE391C212EF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75291137925;
	Wed,  6 Mar 2024 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vIJKhngX"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4CBD534;
	Wed,  6 Mar 2024 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709743677; cv=none; b=rsE5+C7GqumhQrFCMsyfLnnA5+qCWwR3xTNXjruAHIvs7/MSbqvTtmyslvIpkqMu+cAAXYgEaR0Kt1omLDiTkHQjbi6WkBpzbDAkXYKEGPrjR60a1Kgmk/RQysacB6416AG5TR+xp36YZbfKdbP88dOj1H6OLH0ZSqX1wn6Bf/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709743677; c=relaxed/simple;
	bh=8W7Dq7YatRAs2b0t73cA2kCx69/JJSpwmIKPnNBRLk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=APY/YP0wiuty6zTFVeSH+UDccidDxZq0udNXfT/Wa+pmVeaWoIRBtXA8ATOk5mkk6tNY4pKUYbMsTnQfKOwjFDHNl+hXUfdJQjfIe73heCMt3lKoTBuViydAm/EhS54CFdle3EybfZNRYtc+eBjztLxsj4J2dQ1I3uYS+1oXjow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vIJKhngX; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709743675; x=1741279675;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8W7Dq7YatRAs2b0t73cA2kCx69/JJSpwmIKPnNBRLk4=;
  b=vIJKhngXsPX8hBVzPBMD2rNIebMa7g55tU1ViL+ZBTr5+qVhy/bEvfJR
   bC+nUH/q3FpfSgjdi2nkqot4pXc8rpXMCVowstmCW3GQhFFrlkThbqHA6
   +qxFR9hgEfMlVJWCTzF4HTE6wVcbKMNnVv8aLZcat9kKA/6exEfHAm3JD
   L09YUvDQ7pq6YHYN4NBEfPQhEukccrhVoQbWG4J6/ov4ID0F8g+F91YeD
   gGC9f8J5M21IOeQM8yyCoMItOSTv/nu2jkCIKXmVkf2N31Imh826FEewB
   YJnMURBTKp3HSAyG37oEsC+FKbECGITevuoeLlUYPgZ5HP+tzHfwuB5St
   A==;
X-CSE-ConnectionGUID: Utymty8TR7qygpmqy9lhLQ==
X-CSE-MsgGUID: 4QUS1VrJSxG6Nif7mvyF0g==
X-IronPort-AV: E=Sophos;i="6.06,208,1705388400"; 
   d="scan'208";a="17834673"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Mar 2024 09:47:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 09:47:25 -0700
Received: from [10.180.117.170] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 6 Mar 2024 09:47:21 -0700
Message-ID: <e6537742-d9be-4745-b457-b36e60ccaa9b@microchip.com>
Date: Wed, 6 Mar 2024 17:46:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: display: atmel,lcdc: convert to dtschema
Content-Language: en-US, fr-FR
To: Dharma B - I70843 <Dharma.B@microchip.com>, Rob Herring <robh@kernel.org>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <20240304-lcdc-fb-v3-1-8b616fbb0199@microchip.com>
 <20240304220154.GA1115739-robh@kernel.org>
 <d3ae3196-4e8a-4e73-bc36-f53541598ab2@microchip.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <d3ae3196-4e8a-4e73-bc36-f53541598ab2@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

Dharma, all,

On 06/03/2024 at 15:35, Dharma B - I70843 wrote:
> 
> On 05/03/24 3:31 am, Rob Herring wrote:
>> On Mon, Mar 04, 2024 at 08:00:03PM +0530, Dharma Balasubiramani wrote:
>>> Convert the atmel,lcdc bindings to DT schema.
>>> Changes during conversion: add missing clocks and clock-names properties.
>>>
>>> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
>>> ---
>>> This patch converts the existing lcdc display text binding to JSON schema.
>>> The binding is split into two namely
>>> lcdc.yaml
>>> - Holds the frame buffer properties
>>> lcdc-display.yaml
>>> - Holds the display panel properties which is a phandle to the display
>>> property in lcdc fb node.
>>>
>>> These bindings are tested using the following command.
>>> 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>>> ---
>>> Changes in v3:
>>> - Remove the generic property "bits-per-pixel"
>>> - Link to v2: https://lore.kernel.org/r/20240304-lcdc-fb-v2-1-a14b463c157a@microchip.com
>>>
>>> Changes in v2:
>>> - Run checkpatch and remove whitespace errors.
>>> - Add the standard interrupt flags.
>>> - Split the binding into two, namely lcdc.yaml and lcdc-display.yaml.
>>> - Link to v1: https://lore.kernel.org/r/20240223-lcdc-fb-v1-1-4c64cb6277df@microchip.com
>>> ---
>>>    .../bindings/display/atmel,lcdc-display.yaml       | 97 ++++++++++++++++++++++
>>>    .../devicetree/bindings/display/atmel,lcdc.txt     | 87 -------------------
>>>    .../devicetree/bindings/display/atmel,lcdc.yaml    | 70 ++++++++++++++++
>>>    3 files changed, 167 insertions(+), 87 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/atmel,lcdc-display.yaml b/Documentation/devicetree/bindings/display/atmel,lcdc-display.yaml
>>> new file mode 100644
>>> index 000000000000..5e0b706d695d

[..]

>>> +  atmel,lcd-wiring-mode:
>>> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
>>
>> Isn't this just a single string rather than an array?
>>
>>> +    description: lcd wiring mode "RGB" or "BRG"
>>
>> enum:
>>     - RGB
>>     - BRG
>>
>> No BGR?
> 
> In the current driver implementation, we have interpreted the wiring
> mode represented by ATMEL_LCDC_WIRING_BGR as 'BRG' in the array
> atmel_lcdfb_wiring_modes. Considering conventional color representation,
> would it be appropriate to consider modifying the existing driver to use
> the 'BGR' string instead of 'BRG' for better alignment with standard
> naming conventions?

This "BRG" thing is definitively a typo. We never had such thing as a 
BRG color wiring but did have BGR wiring mode.

> static const char *atmel_lcdfb_wiring_modes[] = {
>           [ATMEL_LCDC_WIRING_BGR] = "BRG",
>           [ATMEL_LCDC_WIRING_RGB] = "RGB",

The thing is that we have one DT using that:
arch/arm/boot/dts/at91sam9261ek.dts

So, either I would leave it like that: it's only old product using it.
Or just focus on first character in the string so that it works for both 
"BRG" or "BGR", and maintains the backward compatibility.

Regards,
   Nicolas


> };
> 
> 
>>
>> But wait, the example shows the value is '1'. That should fail testing.
>> It didn't, but I've now fixed that.
> 
> It seems correctly configured in our dts files but didn't noticed the
> same in the bindings example, thanks for letting me know, I will correct
> it in the next revision.


