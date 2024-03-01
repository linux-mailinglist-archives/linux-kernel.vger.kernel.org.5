Return-Path: <linux-kernel+bounces-88170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F58D86DE1E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A343C1C212A8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E946A8A4;
	Fri,  1 Mar 2024 09:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="OyVDsnqz"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426E96A337;
	Fri,  1 Mar 2024 09:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285048; cv=none; b=GA/vl+4uGdZqurq2VASxKtDpbcfK/+QoJ+OeJsbbuI7/uFoGclphWANLkeebjwloMKaGCqkwX6jigXs662srg2V6V5U0RRdiIttK02tqvunG5ZkVFFikTDy40Bl5SbN8GIEu3M6Jb8B9WqkWblDUqGeL1TufdI5oAs6O2z2FJuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285048; c=relaxed/simple;
	bh=vit5J2cqgO6Q702EJY+gZN+tuz/WYcCgtku2XTm6Kl0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=euDT84P2kmXXme2wtjv+bJbn1ra6ogN054gjwFAEwqXzjipCBnArWqYq6kb9Xd8int6RnEzKyvWjIoRuDxH9Sq3SXrugZ6Hgw4PYsmuE0ZvA7RKr5J0ZplZsKhuxT75J9B7urULci/tbrHLO9qVaEsto0F5rPZ6tOSj21zcAu58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=OyVDsnqz; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1709285043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+NwpU1T7X3OYWsftSxh0KjSAxoWEc7j9i7vGX3zBZjA=;
	b=OyVDsnqz/Bdtug2srvCc36iTvO6BLM+N1ix3Eu+NP1SmP+bHEKWOTSqyKbR71J1DY4p1Wh
	AZoq7L78ngdGocntVAHkAE4Oj2oFVGNSvP6tkkgHAQ6QH2Q4MmlYvRoASEjRiIBEd7xR0c
	MmpVeTgdReeTXjJ4YR/nQ2Xfn4wj2CodgUBUkeCi1GZ1IJzwvQdFNqIufPYu7OzVyrZtEO
	L56xEPnUeVCIQYr9GxorQzC/DBllYlT4jK2fYYaFIvvucIO0aQDQS8SKkhRx6339rXc3o9
	f80W3/6xUGNs6CcfHS4n7kk2V4fo3SUR/KKQ4QNySLHRf7h8zxjZlEShweLUog==
Date: Fri, 01 Mar 2024 10:24:01 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu
 Tsai <wens@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] arm64: dts: rockchip: enable built-in thermal
 monitoring on RK3588
In-Reply-To: <8b48eeac7b629c39adc6024ff418724c@manjaro.org>
References: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
 <20240229-rk-dts-additions-v3-1-6afe8473a631@gmail.com>
 <a370efd768021ce1afd6ea5ce841acbb@manjaro.org>
 <CABjd4YxM3HY20BbLZ2bJbEFuf6Uv9P_=v4NdHuvN2M-pxh652Q@mail.gmail.com>
 <ad00189e1a25ca90128be6c8b3841b77@manjaro.org>
 <CABjd4YwMtZUhZG12qXv-=L8e2itwr6_Pex3E_ma1UC9MPQ95EA@mail.gmail.com>
 <8b48eeac7b629c39adc6024ff418724c@manjaro.org>
Message-ID: <28d44f6e2fcacfb58cd1fb0f7fd9bc69@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-01 09:52, Dragan Simic wrote:
> On 2024-03-01 09:25, Alexey Charkov wrote:
>> On Fri, Mar 1, 2024 at 9:51 AM Dragan Simic <dsimic@manjaro.org> 
>> wrote:
>>> On 2024-03-01 06:12, Alexey Charkov wrote:
>>> > With all due respect, I disagree, here is why:
>>> >  - Neither the schematic nor the hardware design guide, on which the
>>> > schematic seems to be based, prescribes a particular way to handle
>>> > thermal runaways. They only provide the possibility of GPIO based
>>> > resets, along with the CRU based one
>>> 
>>> Please note that other documents from Rockchip also exist.  Below is
>>> a link to a screenshot from the Thermal developer guide, version 1.0,
>>> which describes the whole thing further.  I believe it's obvious that
>>> the thermal runaway is to be treated as a board-level feature.
>>> 
>>> - https://i.imgur.com/IJ6dSAc.png
>> 
>> Frankly, that still doesn't make TSADC per se a board-level thing IMO.
>> The only thing that is board-level is the wiring of GPIO based resets,
>> which I fully agree should go to board .dts for boards that support
>> it, but that's not part of the current defaults and can be safely
>> added later.
>> 
>> TSADC is inside the SoC. CRU is inside the SoC. They work just fine
>> for a thermal reset, even if no dedicated reset logic is wired on the
>> board. I really don't see any downsides in having TSADC enabled by
>> default with CRU based resets:
>> - it's a safe default (i.e. I cannot think of any configuration or use
>> case where enabled-by-default TSADC does any harm)
>> - it's safer than accidentally forgetting to enable TSADC (as it adds
>> thermal protection which is otherwise missing)
>> - it will work on all boards (even if it doesn't utilize the full
>> hardware functionality by ignoring GPIO resets that some boards also
>> have in addition to the CRU)
>> - and it requires fewer overrides in board .dts files
>> 
>> Sounds like a no-regret move to me.
> 
> Please see my comments below.
> 
>>> To be fair, that version of the Thermal developer guide dates back to
>>> 2019, meaning that it technically applies to the RK3399, for example,
>>> but the TSADC and reset circuitry design has basically remained the
>>> same for the RK3588.
>>> 
>>> >  - My strong belief is that defaults (regardless of context) should be
>>> > safe and reasonable, and should also minimize the need to override
>>> > them
>>> 
>>> Please note that the TSADC is disabled in the RK3399 SoC dtsi, so 
>>> having
>>> it disabled in the RK3588(s) SoC dtsi would provide some consistency.
>> 
>> I'm happy to produce a patch to reverse the logic in RK3399 (and any
>> others for that matter) to also have TSADC enabled by default there,
>> thus saving several lines of code, if it's just about consistency.
> 
> But why should we change something that has served us for years, on
> multiple SoCs, with zero troubles and with (AFAIK) zero boards 
> producing
> puffs of bluish smoke?
> 
>>> Though, the RK3399 still does it in a safe way, by moving the OPPs 
>>> into
>>> a separate dtsi file, named rk3399-opp.dtsi, which the board dts 
>>> files
>>> then include together with enabling the TSADC.
>>> 
>>> If you agree, let's employ the same approach for the RK3588(s), by
>>> having
>>> the its OPPs defined in a separate file, named rk3588s-opp.dtsi, etc.
>> 
>> Separate file for OPPs is a good no-regret move to declutter the SoC
>> level .dtsi (as the OPP table is long and boring) - happy to move it
>> regardless of the outcome of the above TSADC discussion. Thanks for
>> the pointer!
> 
> Yeah, but I'm not sure that everyone would like that kind of 
> separation.
> In fact, such separation may be frowned upon unless it's necessary.
> 
> As I already described in another thread, the separation for the RK3399
> is there only because a couple of different variants of the RK3399 SoC
> require different OPPs.
> 
>>> >  - In context of dts/dtsi, as far as I understand the general logic
>>> > behind the split, the SoC .dtsi should contain all the things that are
>>> > fully contained within the SoC and do not depend on the wiring of a
>>> > particular board or its target use case. Boards then
>>> > add/remove/override settings to match their wiring and use case more
>>> > closely
>>> 
>>> Of course, but the thermal shutdown is obviously a board-level 
>>> feature,
>>> which I described further above.
>> 
>> Not so obvious to me :-) I don't mean to be stubborn or uncooperative
>> here, but I really can't find any technical merit in having it enabled
>> at board level instead of SoC level.
> 
> Well, please also consider that the PMICs from Rockchip are kind of
> weird little chips, specifically customized to serve particular SoCs.
> For example, they ensure the right sequencing and ramping-up of 
> different
> power rails, which is in many cases essential.
> 
> Thus, who knows what might (or might not) go wrong if we don't reset 
> the
> PMIC at the same time when the CRU resets the SoC?  Unfortunately, the
> things aren't that straightforward.
> 
> On top of that, some boards, such as the Rock 5B, use a few additional
> discrete voltage regulators instead of a master-slave PMIC 
> configuration,
> which may actually introduce some weird power-related issues, which 
> also
> may be intermittent.  Actually, I've already overheard that the Rock 5B
> experiences some issues of that nature, but I don't know the details.

As an example, did you know that LPDDR4 chips, according to the official
JEDEC documentation, require proper sequencing of the ramping-down of 
their
power rails when they're to be turned off as part of shutting the system
down?  The documentation also specifies that the expected lifetime 
becomes
reduced when the powering-off isn't properly performed, and there's even 
an
official number of such unsafe power-offs that the LPDDR4 chips are 
actually
expected to survive.

Thus, just yanking a power cord from a device that uses LPDDR4 may 
actually
make it die prematurely.  Such behavior is kind of exected when it comes 
to
flash-based storage, but DRAM?  Things are weird these days. :)

