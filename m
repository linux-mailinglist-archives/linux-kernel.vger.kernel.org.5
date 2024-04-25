Return-Path: <linux-kernel+bounces-158793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8E98B24FA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36F101F230DB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E2214AD15;
	Thu, 25 Apr 2024 15:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lGFhM1vP"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77CA37152
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058567; cv=none; b=FdLYvGKjf1GU8FUvx9xkXq/4nO7qXWIRafwCSvQvPOD45RXZtzeuETd8lmGAyaNq8gYEbVSl216LXxVtGdKb++PW4G4Rndygmxom4RHi/MqR4qFGf5GKZNdBMk1rTl0UnNY3eqhUYQj4VD553ZPru8DjbHZvKstB6N90a3JGGys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058567; c=relaxed/simple;
	bh=Zp1XztddXWSkzPRERD8uSH+GGbnPFecGU8R3FZDOubA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GxrowsKn4TAsze1TeEu8EwZq5HQL/FUBMVxzHYtRdIcrbdiPRYAHVhhRgqQS4dFJCcKpq106dLAY3SeOqD3DFcrJVWooWt0VVdmIuYZbYjJl6aVoEk9iFxy7dFasLI/LWruuYDh3lU99NhEVLOVnjU4t4oyDIVVm2yGvnLeA/aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lGFhM1vP; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <309b52e6-c206-4811-b14e-db5206adf902@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714058563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yLi5S9z+IggrVLuyc1ioiY20GXVGW50A1sm+DJHyEzY=;
	b=lGFhM1vPlM2U00uPhd1FsTRiffFXhMa+qiOudGzBGWJC5ejhSmPE4Wr+9Go5rHD1AeM+GF
	tBfSckSzzxYSJq4idyH1eMnfxoytxkL4evZVUUKA8OQNOZGTUA7a2iM/jTINOmelMwu1qf
	RktX9bHZPJgLsPfojIwXR3wSNSvBjwA=
Date: Thu, 25 Apr 2024 11:22:40 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: pinctrl: zynqmp: Valid pin muxings cannot be configured
To: Michal Simek <michal.simek@amd.com>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <5bb0dc7e-4c89-4f3d-abc6-41ae9ded5ae9@linux.dev>
 <f42fd731-ba2d-4000-99b2-c98f0ce77b67@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <f42fd731-ba2d-4000-99b2-c98f0ce77b67@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/24/24 02:22, Michal Simek wrote:
> Hi Sean,
> 
> On 4/24/24 01:04, Sean Anderson wrote:
>> Hi Michal,
>>
>> I was looking to upstream one of our ZynqMP boards, and I ran into an
>> issue with the pinmuxing. We use almost all of the I/Os, so everything
>> is tightly packed into the MIO. For example, we have the QSPI on MIO0 to
>> MIO5, and MIO6 to MIO11 are used for SPI1. However, I cannot select this
>> configuration using the pinmux driver. I am using the following
>> configuration:
>>
>> pinctrl_qspi_default: qspi-default {
>>     mux {
>>         groups = "qspi0_0_grp";
>>         function = "qspi0";
>>     };
>>
>>     mux-cs {
>>         groups = "qspi_ss_0_grp";
>>         function = "qspi_ss";
>>     };
>> };
>>
>> pinctrl_spi1_default: spi1-default {
>>     mux {
>>         groups = "spi1_0_grp";
>>         function = "spi1";
>>     };
>>
>>     mux-cs {
>>         groups = "spi1_ss_0_grp", "spi1_ss_1_grp";
>>         function = "spi1_ss";
>>     };
>> };
>>
>> But I get the following errors on boot:
>>
>> [    4.261739] zynqmp-pinctrl firmware:zynqmp-firmware:pinctrl: pin MIO8 already requested by ff050000.spi; cannot claim for ff0f0000.spi
>> [    4.274506] zynqmp-pinctrl firmware:zynqmp-firmware:pinctrl: error -EINVAL: pin-8 (ff0f0000.spi)
>> [    4.283789] zynqmp-pinctrl firmware:zynqmp-firmware:pinctrl: error -EINVAL: could not request pin 8 (MIO8) from group qspi0_0_grp  on device zynqmp_pinctrl
>>
>> This is because the qspi0_0_grp and spi1_0_grp groups overlap:
>>
>> group: qspi0_0_grp
>> pin 0 (MIO0)
>> pin 1 (MIO1)
>> pin 2 (MIO2)
>> pin 3 (MIO3)
>> pin 4 (MIO4)
>> pin 8 (MIO8)
>> pin 9 (MIO9)
>> pin 10 (MIO10)
>> pin 11 (MIO11)
>> pin 12 (MIO12)
>>
>> group: qspi_ss_0_grp
>> pin 5 (MIO5)
>> pin 7 (MIO7)
>>
>> group: qspi_fbclk_0_grp
>> pin 6 (MIO6)
>>
>> group: spi1_0_grp
>> pin 6 (MIO6)
>> pin 10 (MIO10)
>> pin 11 (MIO11)
>>
>> group: spi1_ss_0_grp
>> pin 9 (MIO9)
>>
>> group: spi1_ss_1_grp
>> pin 8 (MIO8)
>>
>> group: spi1_ss_2_grp
>> pin 7 (MIO7)
>>
>> However, we are not using the "upper" pins of the QSPI device.
>> Therefore, these pins should not be included in the qspi0_0_grp. This
>> stems from the driver placing all possible pins into a function's group,
>> even though each pin can be muxed individially and it is not necessary
>> to mux all pins for full functionality.
> 
> Correct. These configurations were not consider at that time when code
> was written. The same issue is there if you want to combine pins from
> different groups. IIRC uart rx via MIOX and tx not from MIOX+1.
> 
>>
>> I think it would be better to have a single group for each pin:
>>
>> pinctrl_qspi_default: qspi-default {
>>     mux {
>>         groups = "mio0", "mio1", "mio2", "mio3", "mio4";
>>         function = "qspi0";
>>     };
>>
>>     mux-cs {
>>         groups = "mio5";
>>         function = "qspi_ss";
>>     };
>> };
>>
>> pinctrl_spi1_default: spi1-default {
>>     mux {
>>         groups = "mio6", "mio10", "mio11";
>>         function = "spi1";
>>     };
>>
>>     mux-cs {
>>         groups = "mio8", "mio9";
>>         function = "spi1_ss";
>>     };
>> };
>>
>> This allows the full functionality of this chip to be configured. Does
>> that sound good? I can send a patch to this effect if you agree.
> 
> The only question is if this can be done without changing TF-A code
> because we are running out of space in OCM for it.

I think this can be done just in the Linux driver. This would also be
convenient because then it will work regardless of the firmware.

> Just a generic question to your problem. It doesn't sound like a
> dynamic case. You have static assignment for pins which likely won't
> change over lifecycle. QSPI can be even boot device. Do you really
> need to describe pins via DT that it is not enough to have them
> configured via psu_init directly?
>
> Driver has been developed for i2c bus recovery via gpio which was the
> main application. Right now Kria SOM is using it for carrier card pins
> configuration.  And Kria is pretty much only platform where this is
> regularly tested.

This is just following the example of the ZCU102. But you're right,
these pin configurations are static (excepting I2C).

--Sean

