Return-Path: <linux-kernel+bounces-159453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2778B2ECC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4197DB21BAA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FC54A3D;
	Fri, 26 Apr 2024 02:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b="fVBOUnvp"
Received: from mail.kaechele.ca (mail.kaechele.ca [54.39.219.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABB81879;
	Fri, 26 Apr 2024 02:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.39.219.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714100073; cv=none; b=suNJd5ZeGdzRQV+Jdtg7o2I1PD/s8QMp1/TphP/KzjuI9MBJ5O7KZQDk32sKs/cIyNGBXsXMZHyXFCEuLtJ80v0FSObVku45LQLjGn1b9yO18NWwNCcLuRQtX20BQ26xQ+1TdobyyRQcyNqLVkD/8i1pfW06dNqgnCUlsTEYCEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714100073; c=relaxed/simple;
	bh=vTSrCZbh96Ko4At3SJct0APLwL1NkC7AYO7d2RMk4kY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UzqNxy52vawY8KKVXpYhTfA4Ih3dSzocNnPY7ywKj3k/8Z5LtR6JkkwjjYYWkCp6KGuv/H1b7irqGFW3xKAVSw7mc6H5+cNSuhkxT/wvTfTySUDrXttedzPtMgPFtuFfEGFY/PEcVJ0T2hq8B99O81PfaVX2izUc4gOA6SirSFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca; spf=pass smtp.mailfrom=kaechele.ca; dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b=fVBOUnvp; arc=none smtp.client-ip=54.39.219.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaechele.ca
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 22D34C005F;
	Thu, 25 Apr 2024 22:55:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaechele.ca; s=201907;
	t=1714100152; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=VFioysH9yUyQGrVMiRg1acctlzy9aYmlvYtITBCcttQ=;
	b=fVBOUnvp29N1+NYfkHg2qnlzmqbD8LYpev8TUnKXdjTwalMPJZUxYnKskfweuGx2phUGsV
	DQm8k0tPjZpC0TzuPajmvZSrZaK4aFmC9jY/Titp9PWFMQICub6BIoIErY5QvNqcGRkME+
	7SARytKt8tYNsKyFMgmFo8TW09ZmDHU=
Message-ID: <7dd1eb70-b011-4247-aea9-173ddcd17dc7@kaechele.ca>
Date: Thu, 25 Apr 2024 22:54:13 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Felix Kaechele <felix@kaechele.ca>
Subject: Re: [PATCH v2 2/2] Input: edt-ft5x06 - add ft5426
To: Andreas Kemnade <andreas@kemnade.info>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: dmitry.torokhov@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 o.rempel@pengutronix.de, u.kleine-koenig@pengutronix.de,
 hdegoede@redhat.com, ye.xingchen@zte.com.cn, p.puschmann@pironex.com,
 linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, caleb.connolly@linaro.org
References: <20240404222009.670685-1-andreas@kemnade.info>
 <20240404222009.670685-3-andreas@kemnade.info>
 <CAHp75VeZ9U_+1rJQjr4KvvzjYQGzfKtk+BK00vqvKcVn2-yP3g@mail.gmail.com>
 <20240405182832.4e457695@aktux>
 <CAHp75VckoDheCN-KQ0KcSk9rE_-cXFUujurtA4sK6KAixDttQQ@mail.gmail.com>
 <20240425185417.0a5f9c19@aktux>
Content-Language: en-US
In-Reply-To: <20240425185417.0a5f9c19@aktux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 2024-04-25 12:54, Andreas Kemnade wrote:
> On Fri, 5 Apr 2024 20:21:19 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
>> On Fri, Apr 5, 2024 at 7:28 PM Andreas Kemnade <andreas@kemnade.info> wrote: >>> On Fri, 5 Apr 2024 18:13:45 +0300
>>> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

..

>>>> Why a different vendor prefix?

..

>>> I sorted by the numbers. Looking at datasheets for other controllers I see >>> https://www.displayfuture.com/Display/datasheet/controller/FT5x06.pdf
>>> it only mentions FocalTech Systems Co., Ltd.
>>
>> But does the driver use that? AFAICS it uses edt. Perhaps it's due to
>> a business split, not to my knowledge anyway.

I've been looking into this over the past few weeks as I was working on 
mainline support for an Android device.
And please forgive me if any of the following is not fully accurate, I'm 
not an industry expert.

After some research, my understanding of this is as follows:

- There are companies that make touch ICs, LCD driver ICs and sometimes 
even ICs that are both. Focaltech or Himax are examples of such companies.

- There are companies that make LCMs. These are complete assemblies of 
panel, backlight, touch layer and driver circuitry PCBs. This is what 
OEMs generally purchase when they design a consumer device. Emerging 
Display Technologies Corp. (EDT) is such a LCM manufacturing company. 
More often than not LCM manufacturers do not make their own driver ICs.

LCM manufacturers include ICs from Focaltech in their LCMs.
To my knowledge Focaltech is not a manufacturer of LCMs.

As such, an interpretation of the compatible string "edt,edt-ft5406" 
could be: Unspecified EDT LCM with Focaltech FT5406 IC.

 From my perspective, more correct would either be something like 
"edt,etm070001bdh6" (the LCM by EDT that contains this IC, especially if 
it had model specific quirks) or "focaltech,ft5406".
But "edt,edt-ft5406" is incorrect if being specific is the goal here.
Given that the driver predates much of the DT binding rigour it's what 
we have now though.

> Well, lets cite edt-ft5x06.rst:
>
> "The edt-ft5x06 driver is useful for the EDT "Polytouch" family of capacitive > touch screens. Note that it is *not* suitable for other devices based 
on the
> focaltec ft5x06 devices, since they contain vendor-specific firmware. In
> particular this driver is not suitable for the Nook tablet."

That contradicts my experience with this driver. It works fine on a BOE 
TV080WXM-LL4 LCM with a FT8201 without modifications.

> So chips from focaltech which can be equipped with different firmware?

Firmware can change, the vendor drivers support handling firmware transfers.
Apparently firmware is handled differently, depending on how a 
manufacturer designs their LCM.
They can be shipped without flash, with flash but no firmware programmed 
or complete with firmware.

In all but the last scenario the driver would have to load (and possibly 
program to flash) the firmware for the LCM to be fully operational to 
specifications. Today, this driver doesn't do that. As such the 
behaviour is unlikely to change and could as well be described in the 
devicetree instead of having the driver try guessing.

I personally would rather trust whoever is performing the integration 
work to properly describe the hardware in the devicetree if the firmware 
doesn't allow for a definitive way to identify how it would like to be 
treated.
If the driver ever gained firmware handling features I'd expect the 
filename for the firmware to be defined in the devicetree together with 
the properties describing the treatment it expects.

> So edt prefix means EDT firmware?

I don't think that's how the compatible strings are used today, but it 
is what would make sense in my opinion.

> Looking around I found this:
>              if (tsdata->version == EV_FT)
>                          swap(x, y);
> ...
>                 case 0x59:  /* Evervision Display with FT5xx6 TS */
>                          tsdata->version = EV_FT;
>
> I need swap(x.y), I am using touchscreen-swapped-x-y property now.
> So evervision prefix?

The compatible string doesn't have any bearing on whether x and y are 
swapped. The driver relies on its device detection heuristic for that 
determination.
Ideally, the driver would allow describing this property

   1. in the devicetree using the "touchscreen-swapped-x-y" property 
from the common touchscreen bindings

   2. by extending the edt_i2c_chip_data struct to hold that property 
and set it based on the compatible string if it is, in fact, a property 
of that specific IC

The only reason I created this wall of text is because I am intending to 
submit a very similar patch, using the "focaltech,ft8201" string. So 
getting a decision on this would be helpful for my efforts as well.

Regards,
Felix

