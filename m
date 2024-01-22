Return-Path: <linux-kernel+bounces-32480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A21E835C2E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE836B27B21
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDB21A71B;
	Mon, 22 Jan 2024 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="uT8k24hN"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B24210F9;
	Mon, 22 Jan 2024 07:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705910282; cv=none; b=Y1no8DqZT9mn5W9KW2undk+SJMXq8RG/26YYJw3twz86HOuXZm5rD5vVrJOqgcT3Q2MA8WYbW4bYeSx3XO9QhbeteQmx4AP9NllchIT4i5t2jvwpoESS6gxgPw6zwFvZXpxMhamsTBuWtMQlWmz3fDhc47y6sEqdQJ+o05+H7xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705910282; c=relaxed/simple;
	bh=3Y7jySyqlPvZGaoyZ+YsKIG1U/XZlc8UyCALp+lz74o=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=B7f0fnDaI+P/RrdoZNzFKOE06uCes00WOPeD3SojomaOpzzyp01F/gl1ZUYWskRkmtyKPT+Rot+s86zN6F5zfZVMHltkc0ClP2GLEZeMqwaXb1ES8cMSkrUu//ljQTR0+JPLE1kbhvZV2Sk5MebYHWclYnvblLccUXCHAE8C3iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=uT8k24hN; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1705910276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nLAyqZlJC+DpGPL0c7ZN+DlDbeATJhEmWXqHqK+FrVc=;
	b=uT8k24hN3//N3XzLOdgPwh2SoEZuhbMsotxXfEmkJD1CkzqDR2KduqYXDa2fARQCT37COP
	Bq7im39H502CbRPgdiY+DMvf5hrK37SAs3Zj8BA2WVU4UdYRqIBigJ6AjcUmcbALrLG0Jn
	xcdbrjy+YRcMHaS4CnoSAOaLzK2xaRULyYlwYZAtBSbaG8F14dTnchEEFARV9mMJnoiJ5g
	wvs1iDx4ir0v9BsgYOuYYz2cDr2Wja/r/GaGkAPWnJeq6jDgDXoPmnhzsa6iKsEARhuEZB
	GY+GYg5qv+OCvsRo6dDQ+whC4tZvDuRQ03n4EJpSbmv9w+9A3VrhmoHh2R35ZQ==
Date: Mon, 22 Jan 2024 08:57:54 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Sebastian Reichel
 <sebastian.reichel@collabora.com>, Cristian Ciocaltea
 <cristian.ciocaltea@collabora.com>, Christopher Obbard
 <chris.obbard@collabora.com>, =?UTF-8?Q?Tam=C3=A1s_Sz=C5=B1cs?=
 <szucst@iit.uni-miskolc.hu>, Shreeya Patel <shreeya.patel@collabora.com>,
 Kever Yang <kever.yang@rock-chips.com>, Chris Morgan
 <macromorgan@hotmail.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: enable built-in thermal monitoring
 on rk3588
In-Reply-To: <CABjd4YwxoPrKRPmjn-eWsU1N5fXCjAbnRwfKD9DLKgeL2=vHrA@mail.gmail.com>
References: <20240106222357.23835-1-alchark@gmail.com>
 <e0302da12345e5539583b2c96d747592@manjaro.org>
 <CABjd4Yw5wTLyK5OPw2S-ipPVCw7RTUeF2J0RgH-Vyis-ng8rTw@mail.gmail.com>
 <d7f2f25071a4d7c72bd286b11836dce7@manjaro.org>
 <CABjd4Yz11D8ThcT-oCWsQf9jL2idChFYSRYVVu3KNnzwoOwkKQ@mail.gmail.com>
 <f5c05015e042b11a51a9af26c35f18ed@manjaro.org>
 <CABjd4Yy91MAd2wALp4KQiEub9OyxU+MR+ti5KA_c+yvZT5xaqQ@mail.gmail.com>
 <81a5410c3dbedbd4fe9ce60ab236700c@manjaro.org>
 <CABjd4YwxoPrKRPmjn-eWsU1N5fXCjAbnRwfKD9DLKgeL2=vHrA@mail.gmail.com>
Message-ID: <a15edb98c32ca79b75bd4eaf64734561@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-01-22 08:36, Alexey Charkov wrote:
> On Mon, Jan 22, 2024 at 10:22 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-01-22 07:03, Alexey Charkov wrote:
>> > On Mon, Jan 22, 2024 at 8:55 AM Dragan Simic <dsimic@manjaro.org> wrote:
>> >> On 2024-01-21 19:56, Alexey Charkov wrote:
>> >> > I think I'll also add a board-specific active cooling mechanism on the
>> >> > package level in the next iteration, given that Rock 5B has a PWM fan
>> >> > defined as a cooling device. That will go in the separate patch that
>> >> > updates rk3588-rock-5b.dts (your feedback to v2 of this patch is also
>> >> > duly noted, thank you!)
>> >>
>> >> Great, thanks.  Sure, making use of the Rock 5B's support for attaching
>> >> a PWM-controlled cooling fan is the way to go.
>> >>
>> >> Just to reiterate a bit, any "active" trip points belong to the board
>> >> dts file(s), because having a cooling fan is a board-specific feature.
>> >> As a note, you may also want to have a look at the RockPro64 dts(i)
>> >> files, for example;  the RockPro64 also comes with a cooling fan
>> >> connector and the associated PWM fan control logic.
>> >
>> > Thanks for the pointer! There is also a helpful doc within devicetree
>> > bindings descriptions, although it sits under hwmon which was a bit
>> > confusing to me. I've already tested it locally (by adding to the
>> > board dts), and it spins up and down quite nicely, and even modulates
>> > the fan speed swiftly when the load changes - yay!
>> 
>> Nice!  Also, isn't it like magic? :)  To me, turning LEDs on/off and
>> controlling fans acts as some kind of a "bridge" between the virtual
>> and the real world. :)
> 
> Oh yes! I also keep admiring how one can add just a couple of lines of
> text here and there that's not even real code, and the whole kernel
> machinery starts crunching numbers, analyzing temperatures, running
> PID loops, etc etc so that I could enjoy the satisfying whistle of a
> small fan when I type `make -j8` :-D

Yes, it's very satisfying, :) and it also demonstrates the true power
of the device trees as hardware definitions.  Just a few more lines and
the cooling works! :)

>> As a suggestion, it would be good to test with a couple of different
>> fans, to make sure that the PWM values work well for more that one fan
>> model.  The Rock 5B requires a 5 V fan, if I'm not mistaken?
> 
> It is 5V, yes. I only have one fan to try though, and I simply relied
> on the PWM values that are already defined in the upstream
> rk3588-rock-5b.dts. They don't look ideal for my particular fan,
> because the lowest non-zero cooling state currently uses a PWM value
> of 95, which doesn't always make it spin up. But in the end it doesn't
> seem to matter that much, because that tiny fan needs to spin at full
> 255 whenever all eight cores are loaded (and even then it can only
> balance the temperature at around 60.5С), and when the load is lighter
> (such as during various ./configure runs) it just switches off
> completely as the temperature goes down to 46C even with the fan not
> spinning.

I see, 5 V fans unfortunately aren't very common.  I'm not sure why
Radxa opted for 5 V there;  maybe the goal was to use Raspberry Pi 5 V
fans, but using those tiny fans doesn't make much sense, IMHO.

I think you can freely adjust the PWM values a bit to make your fan
start reliably at the lowest state, regardless of how rarely that state
will be used.  See, if your fan doesn't spin up reliably with the 
current
lowest state, chances for other fan models not to spin up are quite 
high.
IOW, it's better to play safe there, if you agree.

What kind of heatsink are you using with your Rock 5B?  Ah yes, and
what's the actual model of the fan you're using?

> I don't currently use the GPU/NPU/VPU though - maybe those would
> produce more moderate load which could benefit from spinning the fan
> at medium speeds.

Perhaps, but it will need to be tested at some point.  Have you tried
loading only one or two CPU cores?

