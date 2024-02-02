Return-Path: <linux-kernel+bounces-50533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5712847A56
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C84871C22471
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9018172E;
	Fri,  2 Feb 2024 20:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="DXbiRx2j"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6850580628;
	Fri,  2 Feb 2024 20:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706904904; cv=none; b=hhjTCxvO7g7/5L68Nq1vlI0GUOq5k+UkdwS8iE6qC8P/CbzAoQafpQyZ2pewge3SIylxjAQulK/UPntEwcD4+BBixC0DytkOBUb1bxTiFZyRIzM9wD2lsVLy4XYU/nD0oPhxlt0pL0dQt/jTVi+J1yzYeFmtmeHwMtDC3BnfACM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706904904; c=relaxed/simple;
	bh=As08Hoz1r6/7sqmqTnM0RRJh+snjRDORsY8yXsb0HRU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=uv7zB7ujo50Y46G5nFIkYbZpmExjZ+VGcokaC2JgwMej/HTw0pq9QQmjB0YMEXTOCVvU9iNaysP4T2XEJ53GXERNqBadOcSldKU4FAMkWDlV9QCxVfyy61KtTtBORKFR6urrU1JQt79YdNXLUp+SIs+vBvF3Lx30sO8Yt91awV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=DXbiRx2j; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1706904898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=azvYitpzHFcBsNABC+bzx/2dZxQ21D8VOQgAFUteWBg=;
	b=DXbiRx2j365q8TCBx1wXUUobz2thdRqSwuViaViPBN7HBlHYIhty2jFou+4Oq88r+FxmQo
	a77Aeo/znUDDwp1zO9ibM+1W1MncGuBlPv8hxgz9e/uWPTLa5FVzaAq+d4y66rhX3iC3cy
	3fAD+dLaxB4JSMW+ZNalrmwMYbWn6RFlFYa3JNjAT/1bSCHO0QLS9XIYgMcnF4NMW3nZi3
	j2AUELzx+2cEwiFHnrY2XPzVgo9s9I2A9R5XjEKPmt6+UggkeQlkJmy+XopELWkPuetoIN
	wncKuasBSEGGeOqEAy2l9nd/dhlRXqNDEGp7sN3xTXGvo3zLVBULSDIJbrg5EQ==
Date: Fri, 02 Feb 2024 21:14:58 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: wens@kernel.org, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] arm64: dts: rockchip: enable temperature driven
 fan control on Rock 5B
In-Reply-To: <CABjd4Yy0HYFEdW-XA4vmX4aMhCS-fKd7X_f=ar3qcm_4ROxk1A@mail.gmail.com>
References: <20240130-rk-dts-additions-v2-0-c6222c4c78df@gmail.com>
 <20240130-rk-dts-additions-v2-2-c6222c4c78df@gmail.com>
 <CAGb2v65--rgb2FqmG_0-w1-jUL0odqKXxiZJ-XPYA4uomfYmaQ@mail.gmail.com>
 <5e3e12d65e4919372e7fb02d56202393@manjaro.org>
 <CABjd4Yx0kQ67fScrFVavjObMLaNt_PJ3TVOhLpCmj00Dx9dOqA@mail.gmail.com>
 <a8aa04ca0061cd09c7b3eb5336e534a4@manjaro.org>
 <bd6e93cf907572e86697dc10a50bfe66@manjaro.org>
 <CABjd4Yy0HYFEdW-XA4vmX4aMhCS-fKd7X_f=ar3qcm_4ROxk1A@mail.gmail.com>
Message-ID: <4e7c2b5a938bd7c919b852699c951701@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Alexey,

On 2024-02-02 15:42, Alexey Charkov wrote:
> On Thu, Feb 1, 2024 at 11:43 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-02-01 20:31, Dragan Simic wrote:
>>> On 2024-02-01 20:15, Alexey Charkov wrote:
>>>> On Thu, Feb 1, 2024 at 9:34 PM Dragan Simic <dsimic@manjaro.org> 
>>>> wrote:
>>>>> On 2024-02-01 15:26, Chen-Yu Tsai wrote:
>>>>>> Is there any reason this can't be enabled by default in the .dtsi 
>>>>>> file?
>>>>>> The thermal sensor doesn't depend on anything external, so there 
>>>>>> should
>>>>>> be no reason to push this down to the board level.
>>>>> 
>>>>> Actually, there is a reason.  Different boards can handle the
>>>>> critical overheating differently, by letting the CRU or the PMIC
>>>>> handle it.  This was also the case for the RK3399.
>>>>> 
>>>>> Please, have a look at the following DT properties, which are
>>>>> consumed by drivers/thermal/rockchip_thermal.c:
>>>>>    - "rockchip,hw-tshut-mode"
>>>>>    - "rockchip,hw-tshut-polarity"
>>>>> 
>>>>> See also page 1,372 of the RK3588 TRM v1.0.
>>>>> 
>>>>> This has also reminded me to check how is the Rock 5B actually 
>>>>> wired,
>>>>> just to make sure.  We actually need to provide the two DT 
>>>>> properties
>>>>> listed above, at least to avoid emitting the warnings.
>>>> 
>>>> Well the defaults are already provided in rk3588s.dtsi, so there 
>>>> won't
>>>> be any warnings (see lines 2222-2223 in Linus' master version), and
>>>> according to the vendor kernel those are also what Rock 5B uses.
>>> 
>>> Yes, I noticed the same a couple of minutes after sending my last
>>> message, but didn't want to make more noise about it. :)  I would've
>>> mentioned it in my next message, of course.
>> 
>> Just checked the Rock 5B schematic and it expects the CRU to be used
>> to perform the hardware reset in case of a thermal runaway, so the
>> defaults in the RK3588s dtsi are fine.  I had to double-check it. :)
> 
> I've just looked at Rock 5B, Rock 5A and NanoPC T6 schematics, and
> they all seem to have the TSADC_SHUT line connected to RESET_L.

Ah, I see it now in the Rock 5B schematic, thank you for the
correction.  I somehow managed to miss it initially;  here's
the link to a screenshot from the Rock 5B schematic v1.423, for
future reference:  https://i.imgur.com/IGAPPgl.png .

> At the same time, Radxa's device tree uses the default
> CRU-based option.

Here's the link to a screenshot from the RK3588 Hardware
Design Guide v1.0, which shows the recommended reset signal
paths for RK3588 boards:  https://i.imgur.com/DNqhjfP.png .

As visible in the Rock 5B schematic, it expectedly follows
this recommendation from Rockchip, so we should actually use
GPIO-based handling for the thermal runaways on the Rock 5B,
to have the PMIC reset as well.  Here's the link to another
screenshot from the Rock 5B schematic v1.423, for future
reference:  https://i.imgur.com/BdgZ30C.png .

Of course, it should be tested to make sure that the thermal
runaway resets work fine.

It isn't uncommon for downstream DTs to sometimes contain
some small mistakes that somehow remained undetected.

> To me this seems to imply that the CRU option should always work, by
> the virtue of CRU being on-chip. At the same time, if the right GPIOs
> are wired to the PMIC reset line for a particular board, the board
> may also choose to use the GPIO option - or stick with CRU.
> 
> If that interpretation is correct, then I suggest we enable TSADC by
> default in the .dtsi, and let it handle both throttling and CRU-based
> critical resets on all boards. Those who know what they are doing may
> then elect to switch their board to GPIO-PMIC based reset.
> 
> What do you think?

I think that, if we choose to enable CRU-based thermal runaway
resets without going into too much detail for each board (but
we should go into the publicly available board schematics, as
also noted in my last comment in this message), we should do
that in the board dts files, instead of just enabling the TSADC
in the RK3588(s) SoC dtsi.

That way, we would clearly indicate the TSADC to be a board-
specific feature, and hopefully gain more attention from the
people interested in the boards, to perform some additional
testing, etc.

>> However, now I have some open questions related to interrupt-driven
>> operation.  I'll research it further and come back with an update.
>> 
>>>> This made me think however: what if a board doesn't enable TSADC, 
>>>> but
>>>> has OPPs in place for higher voltage and frequency states? There 
>>>> won't
>>>> be any throttling (as there won't be any thermal monitoring) and 
>>>> there
>>>> might not be a critical shutdown at all if it heats up - possibly 
>>>> even
>>>> causing hardware damage. In this case it seems that having TSADC
>>>> enabled by default would at least trigger passive cooling, hopefully
>>>> avoiding the critical shutdown altogether and making those 
>>>> properties
>>>> irrelevant in 99% cases.
>>> 
>>> Those are very good questions.  Thumbs up!
>>> 
>>> The trouble is that the boards can use different wiring to handle the
>>> thermal runaways, by expecting the PMIC to handle it or not.  Thus,
>>> it's IMHO better to simply leave that to be tested and enabled on a
>>> board-by-board basis, whenever a new RK3588(s)-based board is added.
>>> 
>>> Thus, the only right way at this point would be to merge the addition
>>> of the OPPs and the enabling of the TSADC for all currently supported
>>> RK3588(s)-based boards at once, instead of just for the Rock 5B.
> 
> If we can agree on a workable 'default-on' configuration for TSADC to
> be included in the .dtsi I think that would be preferable, because it
> would enable all boards to benefit from higher OPPs and throttling.

Please, see my other comments.  I hope we can agree on that.

> This would also save us from a scenario when OPPs get included in the
> default .dtsi, but TSADC is off by default, and then some poor soul
> tries to add a new board with a minimal .dts, forgetting to enable
> TSADC and having their SoC fried under high load...

Well, those poor souls can't escape the need to know what are
they doing. :)  Also, I think it's much more likely that adding
a new RK3588-based board would actually start by editing the
board dts of some already supported RK3588 board, which the way
I propose this to be handled would already have the TSADC enabled,
eliminating the risks yout pointed out.

Please note that the TSADC has been disabled in the RK3399 SoC
dtsi and enabled on a per-RK3399-board-dtsi basis, so we'd also
have some consistency by following the same approach with the
RK3588(s) SoC dtsi.  Consistency is good, if you agree.

>>> I can handle the required changes for the QuartzPro64 dts file.  For
>>> other supported RK3588(s)-based boards, if there are no people having
>>> access to them and willing to perform the dts changes and the 
>>> testing,
>>> I'd be willing to go through the board schematics, to enable the
>>> TSADC for them as well.
>> 
>> Please, let me know are you fine with the above-described approach.
> 
> I believe it's great if we can go through the schematics no matter
> what! Although if we agree that CRU is an always-working default
> option for all, then why don't we just enable TSADC for all, and leave
> the conversion to GPIO-PMIC resets for later and for where it's
> needed?

Great!  We can surely go through the supported RK3588(s) boards
that make their schematics publicly available, and enable the
TSADC in their board dts files accordingly.

For the remaining RK3588(s) boards that remain "black boxes" to
us, we can enable the TSADC in their board dts files with the
let-the-CRU-handle-thermal-runaway defaults, and leave any future
refinements to the people interested in those boards.

That would be a rather clean approach, if you agree.

