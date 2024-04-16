Return-Path: <linux-kernel+bounces-146898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A458A6C9E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 378E6B21C4E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B905412C49C;
	Tue, 16 Apr 2024 13:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b="WsN+inhp"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617E512BF29
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713274568; cv=none; b=rFTCrPcU28+dq/Ea6sxdnPW5So9ndFLkqH3XI6/stG6Az+2bM28Ik/0YgWafAGcTBMM7guLZZf2dOqPhfYfdtMZZIJcW4N5/DsgT9H5qVtptkD/lh9OMhFUou5HC0iZ1lOsHtenh3Z6FvjFKYGjHSB2oNPxTVxUGMXjQsqlGP3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713274568; c=relaxed/simple;
	bh=ESXTOBerJ11ivDTEUscWQdRvIS+xShE+sRa69XlINm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctE/uTWRD9/y2wutMlMH9OTj1NxIRudvVNn0W7xkWYoCmHIAk7ngObk1TcJicXehmbFYDnzRyXioSPQq81PCJAVv8Q7P8WAd8RqSCHibxgpDbXfOqB6M+8YAHJPCx4shWz5n1A5EriJ0JnguSIXsUDup598o10qssPPDMgdzeBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org; spf=none smtp.mailfrom=jookia.org; dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b=WsN+inhp; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jookia.org
Date: Tue, 16 Apr 2024 23:30:43 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1713274563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yi0/qfx4nmZfF6fdXRi1R9ZAidfFCHR7CYYCzr1ALiw=;
	b=WsN+inhptWBlLAn4tYfGJsUTwLFrLAQSCnnMGn3U0Hj6QgcJ0wxYAoALpOZh7Oi3b5sI6g
	ssaUcULn7c0mtcvWJpB5DP8Qxift4AYjIswvzH2NQmGSI++Cs1XukEkGoRC/byHQ7jsOMO
	CBpOw1a/3pWu8VVA2M41nalYMiRHr3NqB8IzAnPX+iPHISnvSscRdyHTik1VSqmAuFSzAl
	0cKjzNVkuR854rG/g0FK6mX9bCOzX9mAyPnrT3MQNEOHRQl4tzDPZwCR4Cld5ESfftonXn
	sZ5BKACEjTG79h4w+ANMd8FiuEllga+k6ObB5tCsNVvAd/8FjNWdBw5IQmof/g==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: John Watts <contact@jookia.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Ryan Walklin <ryan@testtoast.com>,
	Chris Morgan <macroalpha82@gmail.com>
Subject: Re: [PATCH 1/4] regulator: axp20x: AXP717: fix LDO supply rails and
 off-by-ones
Message-ID: <Zh59gzEB61lNdmMh@titan>
References: <20240329235033.25309-1-andre.przywara@arm.com>
 <20240329235033.25309-2-andre.przywara@arm.com>
 <ZhuNCUnJri4hBOxx@titan>
 <20240416122305.3ffc2bda@donnerap.manchester.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416122305.3ffc2bda@donnerap.manchester.arm.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 16, 2024 at 12:23:05PM +0100, Andre Przywara wrote:
> On Sun, 14 Apr 2024 18:00:09 +1000
> John Watts <contact@jookia.org> wrote:
> 
> Hi John,
> 
> many thanks for the detailed review (also on the other two patches), much
> appreciated!

No problem!

> I see what you mean, though I actually looked at the number of steps
> mentioned in the first part of the register description. Now
> triple-checking this I came up with this table (generated by a spreadsheet
> to minimise human error):
> voltage	decimal	binary	
> 1600	88	1011000
> 1700	89	1011001
> 1800	90	1011010
> 1900	91	1011011
> 2000	92	1011100
> 2100	93	1011101
> 2200	94	1011110
> 2300	95	1011111
> 2400	96	1100000
> 2500	97	1100001
> 2600	98	1100010
> 2700	99	1100011
> 2800	100	1100100
> 2900	101	1100101
> 3000	102	1100110
> 3100	103	1100111
> 3200	104	1101000
> 3300	105	1101001
> 3400	106	1101010
> 
> Which means the final binary value in the datasheet is wrong, as 1101011
> would mean 3.5V.
> Also  1101010 = 106
>      -1011000 = 88
> =============
>       0010010 = 18
> and 18 * 100 + 1600 = 3400, right?
> 
> This *is* admittedly quite bonkers, especially since the representations
> between the manual and the code are so different, but can you check that
> this makes sense?

I wrote a program in Python that steps through each range and prints its
value, and according to it value 106 is 3.4V. I dumped it at the end of
this email for anyone curious. Your math checks out too.

So the datasheet must be wrong. Maybe it originally supported up to 3.5V
and someone who doesn't know binary updated the sheet.

I think you should add a note saying that the datasheet is wrong, to
show people this isn't a bug and also save time of others trying to
write their own drivers and check their logic. Something like this:

Warning, the datasheet specifies that 3.40V is 107, which is incorrect:
- There are only 107 steps in total, making the highest step value 106
- 1.60V is listed as 1011000 (88 in decimal), with 18 steps after that 
- Adding 100mV for each of the 18 steps past 1.60V gives 3.4V

I think this logic convinces me at least. :)

John.

> I discovered some other issue in the original patch (missed declaring the
> range of IRQ acknowledge registers in the MFD part), so I will send a v2 of
> this series soonish.
> 
> > For DCDC3 after applying this patch we get:
> > 
> > #define AXP717_DCDC3_NUM_VOLTAGES	103
> > static const struct linear_range axp717_dcdc3_ranges[] = {
> > 	REGULATOR_LINEAR_RANGE(500000,   0,  70, 10000),
> > 	REGULATOR_LINEAR_RANGE(1220000, 71, 102, 20000),
> > };
> > 
> > The datasheet marks the maximum value as 1100110: 1.84V, which is 102.
> > So this patch to correct the AXP717_DCDC3_NUM_VOLTAGES is correct here.
> 
> I agree ;-) thanks for checking!
> 
> Cheers,
> Andre

---

Python program:

reg = 0
value = 500
for x in range(71):
	print("%i: %imV" % (reg, value))
	value += 10
	reg += 1
value = 1220
for x in range(17):
	print("%i: %imV" % (reg, value))
	value += 20
	reg += 1
value = 1600
for x in range(19):
	print("%i: %imV" % (reg, value))
	value += 100
	reg += 1

