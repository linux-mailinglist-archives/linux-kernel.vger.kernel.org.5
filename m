Return-Path: <linux-kernel+bounces-33825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00992836FA0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E912B2B8A1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D728256766;
	Mon, 22 Jan 2024 17:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="nPj3rQHg"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA0065BCF;
	Mon, 22 Jan 2024 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944802; cv=none; b=YzRAIjVnKjplk/8dFvKfGE+eq7xrsa6AO5IK4YBcGuH3FMlcTlVyksZlkEb7ZLLl9JrSB7CyON8qE+9rqQ30xwWJ/cWXAkE+PnRHpUY2uNjWJ7upfKycfUYxL1Gzpp4nWMKESExb+NR0mRfPsRYGL+BKimyb3Vyzqux1wtK/KKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944802; c=relaxed/simple;
	bh=14d93NgQ7WaShPCrTEgxGGfCgwchSDNqbHuU6YhNWiU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=c8BGz4DU5zRIQcbc5F8YtYzJUD+tgtvjrujg5RQ4vH7KyNjHbu5o8oOYrEreM7J86l3XFGvpKkc7OpOyipjLndJ/Zl9U6NRKAGDkVZ7oEC8KYVRLq8T7A+U5WmHJSVEgoa7TpftTwME7SxEma+vFvGtXSiSIkZnCWsbMkecuV24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=nPj3rQHg; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1705944796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKbnuh2h0PgDQC33RKrscO7YxrGHfOAB3fAT8BQBrEE=;
	b=nPj3rQHgAr0Ii8SDx8QS8QRKwwrRLk/eHPSMua7vhZYj3qBZVLqwSw5jltWhLlVCP50RPA
	p5rQRwWF/VZY95QxUaGOWwznvQrLCaJrmo6mIkFi0MIR+/asO+qpxUWXUc9wYYEVP5JjXf
	VT7ftUqIUyWHjAbONtVFaN2HhdkLUbwD6FVAe79bLxxBAwLoqUBIGL7QHvTaP9rRi/UcVi
	JqwHeewzbdfQGamZmL0LVe74ri4pNa82dP8LK/pAplzpinI7qSCOCcIEIyoIX52jUxDSld
	Oy9uHI8JXfRVrhhG/MUki3/U9WDbD5GezpzNqUuZgxWPvMl4Igkd1inWvTPPCw==
Date: Mon, 22 Jan 2024 18:33:14 +0100
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
In-Reply-To: <CABjd4Yxw_wgjRRO12Zjy75=CA_uuucexVnhVRt3fURJFYQqYSw@mail.gmail.com>
References: <20240106222357.23835-1-alchark@gmail.com>
 <e0302da12345e5539583b2c96d747592@manjaro.org>
 <CABjd4Yw5wTLyK5OPw2S-ipPVCw7RTUeF2J0RgH-Vyis-ng8rTw@mail.gmail.com>
 <d7f2f25071a4d7c72bd286b11836dce7@manjaro.org>
 <CABjd4Yz11D8ThcT-oCWsQf9jL2idChFYSRYVVu3KNnzwoOwkKQ@mail.gmail.com>
 <f5c05015e042b11a51a9af26c35f18ed@manjaro.org>
 <CABjd4Yy91MAd2wALp4KQiEub9OyxU+MR+ti5KA_c+yvZT5xaqQ@mail.gmail.com>
 <81a5410c3dbedbd4fe9ce60ab236700c@manjaro.org>
 <CABjd4YwxoPrKRPmjn-eWsU1N5fXCjAbnRwfKD9DLKgeL2=vHrA@mail.gmail.com>
 <a15edb98c32ca79b75bd4eaf64734561@manjaro.org>
 <CABjd4Yxw_wgjRRO12Zjy75=CA_uuucexVnhVRt3fURJFYQqYSw@mail.gmail.com>
Message-ID: <c762d5d87189a77d62111b4f5a8c8166@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-01-22 15:20, Alexey Charkov wrote:
> On Mon, Jan 22, 2024 at 11:57 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-01-22 08:36, Alexey Charkov wrote:
>> > On Mon, Jan 22, 2024 at 10:22 AM Dragan Simic <dsimic@manjaro.org> wrote:
>> >> As a suggestion, it would be good to test with a couple of different
>> >> fans, to make sure that the PWM values work well for more that one fan
>> >> model.  The Rock 5B requires a 5 V fan, if I'm not mistaken?
>> >
>> > It is 5V, yes. I only have one fan to try though, and I simply relied
>> > on the PWM values that are already defined in the upstream
>> > rk3588-rock-5b.dts. They don't look ideal for my particular fan,
>> > because the lowest non-zero cooling state currently uses a PWM value
>> > of 95, which doesn't always make it spin up. But in the end it doesn't
>> > seem to matter that much, because that tiny fan needs to spin at full
>> > 255 whenever all eight cores are loaded (and even then it can only
>> > balance the temperature at around 60.5С), and when the load is lighter
>> > (such as during various ./configure runs) it just switches off
>> > completely as the temperature goes down to 46C even with the fan not
>> > spinning.
>> 
>> I see, 5 V fans unfortunately aren't very common.  I'm not sure why
>> Radxa opted for 5 V there;  maybe the goal was to use Raspberry Pi 5 V
>> fans, but using those tiny fans doesn't make much sense, IMHO.
>> 
>> I think you can freely adjust the PWM values a bit to make your fan
>> start reliably at the lowest state, regardless of how rarely that 
>> state
>> will be used.  See, if your fan doesn't spin up reliably with the 
>> current
>> lowest state, chances for other fan models not to spin up are quite
>> high.  IOW, it's better to play safe there, if you agree.
>> 
>> What kind of heatsink are you using with your Rock 5B?  Ah yes, and
>> what's the actual model of the fan you're using?
> 
> I use Radxa's 4012 heatsink-fan assembly that comes as an add-on
> option when buying the board itself from Allnet. I guess I'll include
> slightly adjusted PWM values in the rk3588-rock-5b.dts patch to better
> represent my fan's "preferred" range (in my experience a PWM value of
> around 120 is the reliable lower end - it would continue spinning
> below that point but won't always start without being pushed manually)

Sure, just go ahead.  You're using an official active cooling solution
for the Rock 5B, so adjusting the PWM values a bit to make the fan start
up reliably is even more warranted.

>> > I don't currently use the GPU/NPU/VPU though - maybe those would
>> > produce more moderate load which could benefit from spinning the fan
>> > at medium speeds.
>> 
>> Perhaps, but it will need to be tested at some point.  Have you tried
>> loading only one or two CPU cores?
> 
> I do see the full range of PWM values being used, including
> intermediate ones. It doesn't go zero to hero :) My point was more
> about the default fan not being super mighty vs. the full package
> thermal output, which will likely mean that intermediate values are
> rarely used. But I'll double check with more varied loads to make sure
> it behaves in a sensible way (especially given that I'll be testing
> purely interrupt-driven operation per Daniel's guidance in the other
> sub-thread).

I see, thanks for the clarification. :)  The 4012 fan and heatsink seem
rather tiny; [1]  a more beefy assembly, with more thermal mass, larger
fin surface and a fan that pushes a bit more air across its RPM range,
would probably result in a noticeably broader use of the intermediate
PWM values.

[1] 
https://shop.allnetchina.cn/products/active-heat-sink-for-visionfive-sbc

