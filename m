Return-Path: <linux-kernel+bounces-88403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6C086E11F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70C11F26393
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACD81364;
	Fri,  1 Mar 2024 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="p5UhcMKc"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295B1812;
	Fri,  1 Mar 2024 12:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709296474; cv=none; b=QosqjLpF/aYsVAr478S+Chz+MKDCGay6zmANpp/ft5Toi+gNHRTfHByiJhJcvkPn29dSLJz2TgtKQQW9BzcPWji0DE6dQ6INyT4yMjlRARuL8f0rEaml9DLgflMo4WdAgtBgj43F3+LeJmuPNqngnEbyCL8tp4FgI99ITngwLw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709296474; c=relaxed/simple;
	bh=v7pPKcM/LK+j7XMQkYI4Q1FyQ5pU6u6VvVtgS+onmWw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=NKzihLLd/F1wQU9lB5AdDdj+YcWLshVz9BChHown27Yrz0T7d5w/hlG0teHohizL8EAMtVR8h81O5pKOkzxvh9z6Zw2PqoY3R+tFBROBIYilCYefmzXqCbFt5hXhZTCw2ToNB0tC6Ph+vUhU44dheY0v1Gi9wVDcN792gnVQcu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=p5UhcMKc; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1709296467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uXXrFPwA0W0DulbaMA1x6JuvLaWb0VOrWlzgP3c4M7Q=;
	b=p5UhcMKc4xU9LuKVQWuvU/QxoXFmMBjrOiQ8NEc6RjpP2+2CQXenPt0qVjtgB3UWmHyK46
	UdeRcK5vHBHG27dfzTXYKH2XdYhg8nma+o6WSEt02mHL3CPEYQ5+MlmS7zgLKtTEsYd/x5
	8YAZ9nK6fBwVfl6/D/AACEH+KMYt2BzPlfdMWczsjmSaMHhCzcUwCyOrhYiTIdf8WCoX76
	sIkFMrEKNc1B0/7ZUkWkvMY0rMV9QIL0w/zoraMLB9assOKRNwk6RL0KfIrNMUJWCY9Pev
	ueRYy1TSLFVq2cFMYqSeIqQ5He6q18bPYJ61Of82YclwFKRShq4M3vXcODje5w==
Date: Fri, 01 Mar 2024 13:34:26 +0100
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
In-Reply-To: <CABjd4YzjQ8NdA-gdux3YPw2K6dwLn5oNWRAix7raSgoGsEdpbA@mail.gmail.com>
References: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
 <20240229-rk-dts-additions-v3-1-6afe8473a631@gmail.com>
 <a370efd768021ce1afd6ea5ce841acbb@manjaro.org>
 <CABjd4YxM3HY20BbLZ2bJbEFuf6Uv9P_=v4NdHuvN2M-pxh652Q@mail.gmail.com>
 <ad00189e1a25ca90128be6c8b3841b77@manjaro.org>
 <CABjd4YwMtZUhZG12qXv-=L8e2itwr6_Pex3E_ma1UC9MPQ95EA@mail.gmail.com>
 <8b48eeac7b629c39adc6024ff418724c@manjaro.org>
 <CABjd4YzjQ8NdA-gdux3YPw2K6dwLn5oNWRAix7raSgoGsEdpbA@mail.gmail.com>
Message-ID: <6e76db0b2e7739176bcea0b90746a35a@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-01 12:10, Alexey Charkov wrote:
> On Fri, Mar 1, 2024 at 12:52 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-03-01 09:25, Alexey Charkov wrote:
>> > On Fri, Mar 1, 2024 at 9:51 AM Dragan Simic <dsimic@manjaro.org> wrote:
>> >> On 2024-03-01 06:12, Alexey Charkov wrote:
>> >> > On Fri, Mar 1, 2024 at 12:21 AM Dragan Simic <dsimic@manjaro.org>
>> >> > wrote:
>> >> >> On 2024-02-29 20:26, Alexey Charkov wrote:
>> >> >> > Include thermal zones information in device tree for RK3588 variants.
>> >> >> >
>> >> >> > This also enables the TSADC controller unconditionally on all boards
>> >> >> > to ensure that thermal protections are in place via throttling and
>> >> >> > emergency reset, once OPPs are added to enable CPU DVFS.
>> >> >> >
>> >> >> > The default settings (using CRU as the emergency reset mechanism)
>> >> >> > should work on all boards regardless of their wiring, as CRU resets
>> >> >> > do not depend on any external components. Boards that have the TSHUT
>> >> >> > signal wired to the reset line of the PMIC may opt to switch to GPIO
>> >> >> > tshut mode instead (rockchip,hw-tshut-mode = <1>;)
>> >> >>
>> >> >> Quite frankly, I'm still not sure that enabling this on the SoC level
>> >> >> is the way to go.  As I already described in detail, [4] according to
>> >> >> the RK3588 Hardware Design Guide v1.0 and the Rock 5B schematic, we
>> >> >> should actually use GPIO-based handling for the thermal runaways on
>> >> >> the Rock 5B.  Other boards should also be investigated individually,
>> >> >> and the TSADC should be enabled on a board-to-board basis.
>> >> >
>> >> > With all due respect, I disagree, here is why:
>> >> >  - Neither the schematic nor the hardware design guide, on which the
>> >> > schematic seems to be based, prescribes a particular way to handle
>> >> > thermal runaways. They only provide the possibility of GPIO based
>> >> > resets, along with the CRU based one
>> >>
>> >> Please note that other documents from Rockchip also exist.  Below is
>> >> a link to a screenshot from the Thermal developer guide, version 1.0,
>> >> which describes the whole thing further.  I believe it's obvious that
>> >> the thermal runaway is to be treated as a board-level feature.
>> >>
>> >> - https://i.imgur.com/IJ6dSAc.png
>> >
>> > Frankly, that still doesn't make TSADC per se a board-level thing IMO.
>> > The only thing that is board-level is the wiring of GPIO based resets,
>> > which I fully agree should go to board .dts for boards that support
>> > it, but that's not part of the current defaults and can be safely
>> > added later.
>> >
>> > TSADC is inside the SoC. CRU is inside the SoC. They work just fine
>> > for a thermal reset, even if no dedicated reset logic is wired on the
>> > board. I really don't see any downsides in having TSADC enabled by
>> > default with CRU based resets:
>> > - it's a safe default (i.e. I cannot think of any configuration or use
>> > case where enabled-by-default TSADC does any harm)
>> > - it's safer than accidentally forgetting to enable TSADC (as it adds
>> > thermal protection which is otherwise missing)
>> > - it will work on all boards (even if it doesn't utilize the full
>> > hardware functionality by ignoring GPIO resets that some boards also
>> > have in addition to the CRU)
>> > - and it requires fewer overrides in board .dts files
>> >
>> > Sounds like a no-regret move to me.
>> 
>> Please see my comments below.
>> 
>> >> To be fair, that version of the Thermal developer guide dates back to
>> >> 2019, meaning that it technically applies to the RK3399, for example,
>> >> but the TSADC and reset circuitry design has basically remained the
>> >> same for the RK3588.
>> >>
>> >> >  - My strong belief is that defaults (regardless of context) should be
>> >> > safe and reasonable, and should also minimize the need to override
>> >> > them
>> >>
>> >> Please note that the TSADC is disabled in the RK3399 SoC dtsi, so
>> >> having
>> >> it disabled in the RK3588(s) SoC dtsi would provide some consistency.
>> >
>> > I'm happy to produce a patch to reverse the logic in RK3399 (and any
>> > others for that matter) to also have TSADC enabled by default there,
>> > thus saving several lines of code, if it's just about consistency.
>> 
>> But why should we change something that has served us for years, on
>> multiple SoCs, with zero troubles and with (AFAIK) zero boards 
>> producing
>> puffs of bluish smoke?
> 
> That's just if we are concerned about consistency across different SoC
> series. The point is that I'm happy to make whatever change we agree
> upon in a consistent way across all related .dtsi/.dts files - thus no
> need to worry about past decisions that have already been implemented
> for other chips. Let's just agree on the technical merits of one or
> the other approach, leaving "we've been doing it differently elsewhere"
> aside for now.

I see, I'd also be willing to implement such cleanup patches.  Though,
let's also keep in mind that some past decisions might have some strong
reasons behind them, which might not be obvious.  That's another reason
why I'm against enabling TSADC by default.

>> >> Though, the RK3399 still does it in a safe way, by moving the OPPs
>> >> into
>> >> a separate dtsi file, named rk3399-opp.dtsi, which the board dts files
>> >> then include together with enabling the TSADC.
>> >>
>> >> If you agree, let's employ the same approach for the RK3588(s), by
>> >> having
>> >> the its OPPs defined in a separate file, named rk3588s-opp.dtsi, etc.
>> >
>> > Separate file for OPPs is a good no-regret move to declutter the SoC
>> > level .dtsi (as the OPP table is long and boring) - happy to move it
>> > regardless of the outcome of the above TSADC discussion. Thanks for
>> > the pointer!
>> 
>> Yeah, but I'm not sure that everyone would like that kind of 
>> separation.
>> In fact, such separation may be frowned upon unless it's necessary.
>> 
>> As I already described in another thread, the separation for the 
>> RK3399
>> is there only because a couple of different variants of the RK3399 SoC
>> require different OPPs.
>> 
>> >> >  - In context of dts/dtsi, as far as I understand the general logic
>> >> > behind the split, the SoC .dtsi should contain all the things that are
>> >> > fully contained within the SoC and do not depend on the wiring of a
>> >> > particular board or its target use case. Boards then
>> >> > add/remove/override settings to match their wiring and use case more
>> >> > closely
>> >>
>> >> Of course, but the thermal shutdown is obviously a board-level
>> >> feature,
>> >> which I described further above.
>> >
>> > Not so obvious to me :-) I don't mean to be stubborn or uncooperative
>> > here, but I really can't find any technical merit in having it enabled
>> > at board level instead of SoC level.
>> 
>> Well, please also consider that the PMICs from Rockchip are kind of
>> weird little chips, specifically customized to serve particular SoCs.
>> For example, they ensure the right sequencing and ramping-up of
>> different power rails, which is in many cases essential.
> 
> Sure. I'm not saying that switching to a PMIC-assisted reset shouldn't
> be done where the board supports it - quite the opposite. All I'm
> saying is that having at least passive cooling and CRU based resets
> guaranteed for any board, regardless of how thought through its .dts
> is, seems to be a better default than no thermal protection.

The way I see it, which I tried to describe in my previous response, is
that we can't be 100% sure that CRU-based resets would work as expected
and 100% reliably on all boards.

>> Thus, who knows what might (or might not) go wrong if we don't reset 
>> the
>> PMIC at the same time when the CRU resets the SoC?  Unfortunately, the
>> things aren't that straightforward.
>> 
>> On top of that, some boards, such as the Rock 5B, use a few additional
>> discrete voltage regulators instead of a master-slave PMIC
>> configuration,
>> which may actually introduce some weird power-related issues, which 
>> also
>> may be intermittent.  Actually, I've already overheard that the Rock 
>> 5B
>> experiences some issues of that nature, but I don't know the details.
> 
> Those discrete regulators seem to be out of scope of this discussion.
> 
> I agree that a deeper power-cycle with proper power-up sequence to
> follow it is better when it's available in the respective hardware.
> I'm also happy to provide a follow-up patch to switch from CRU to PMIC
> resets for the boards I found to support the latter.
> 
> The question we have at hand is solely about the default behavior for
> a hypothetical new board with minimal .dts, or an existing board where
> we can't determine the wiring of the TSHUT signal:
> Option 1. Let them stay nice and warm at 120C+ under load, because
> they should have known better and should have enabled the TSADC in
> their device tree before putting the system under load
> Option 2. Get them passively cooled at 85C under load even with no
> heatsink, then force a CRU reset out of abundance of caution at 120C
> unless they defined PMIC reset in their device tree
> 
> I'm advocating for the latter.

Just to clarify, the way I see it, we'd end up with having TSADC and
CRU-based resets enabled for the boards we can't be sure to have support
for PMIC resets.  It's just that, the way I see it, TSADC wouldn't be
enabled on the SoC level, but no boards would be left with no thermal
runaway handling in place.

>> > Switching to PMIC-assisted resets is one thing - it definitely should
>> > go to board files, as it depends on the specific wiring of the
>> > TSADC_SHUT signal. Enabling TSADC in a default configuration that can
>> > and will work on all boards regardless of their wiring is another
>> > thing. I'm just arguing for the latter.
>> 
>> CRU-based thermal runaway handling may in theory work on all boards, 
>> but
>> we simply can't be 100% sure without detailed insights into the board
>> designs and testing.  Maybe even the downstream U-Boot does some magic
>> during such thermal runaway resets, which we don't know.  It may be
>> similar to the SoC reset issues that the RK3399 suffers from.
> 
> That might be true, but we're talking about operation at 120C+ here.
> I'd rather have my board reboot in any way it pleases under those
> conditions, and have that behavior triggered by default even if it's
> imperfect, then worry about the correct state of all regulators and
> peripherals upon next boot. The latter is important of course, but I'd
> rather let it cool down and reboot it manually anyway, because that
> heat could have made more things go sideways than just the regulators.

Makes sense, but as you can see above, the way I propose it no boards
would be left to sizzle under load.  That would be irresponsible and bad
on multiple levels.

>> See also my comment above.
>> 
>> > To me it seems similar to the watchdog timer situation: we enable it
>> > at the SoC level [1], as it is expected to work in its default
>> > configuration regardless of the board wiring, and it provides
>> > protection against system malfunctions. Doesn't matter if the board or
>> > its userspace code ends up using the full functionality - it just sits
>> > there waiting for its spotlight without hurting anybody.
>> 
>> Frankly, I don't know much about the watchdog functionality, so I'd 
>> need
>> to research it before I could say something about it.
> 
> FWIW, watchdog resets are exclusively routed through the CRU (see
> RK3588 TRM V1.0 part 1 page 31). So if we expect that one to work
> somehow, probably we should expect thermal resets to work too.

I'll see to reasearch that a bit, maybe I'll find something out that
could be interesting or useful.

