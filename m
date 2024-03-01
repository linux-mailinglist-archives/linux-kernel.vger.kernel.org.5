Return-Path: <linux-kernel+bounces-88124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AEB86DDA9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FFF91F22019
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBDF6A33D;
	Fri,  1 Mar 2024 08:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="orUcIuS7"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088EB69E16;
	Fri,  1 Mar 2024 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709283159; cv=none; b=HwMcgwHMKX7JtLzNGFNUy887rSxdgsbgiFTplk7sRLjATU9fNVVVx4U5JEVOTvnzJsFloITtmO3Pq0AWC26Lx1AhzFxxI1GhnwpQDxTzoG3gcPVusPU8P8WOzJlMmyuh8wzRcNh3QNzns6eS5Rvl3QAIWQlBMoRFa/29E7k22cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709283159; c=relaxed/simple;
	bh=ByJxXjUmVJOan1Gat8sDAxu1MHfl4qWUa465EQgUY7Q=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=kpqgRD3XxtvHiHDJL77t6wIiMHLA+IOITbpEMxK6F9C1pL5KPfGGfrNjjUwKYHHpOTTi6CzKLBVTBa2hMUr1B02FJJeNAaY6aJkCOTR2osqKocWGzYRM4z1D9TTNCvQWRwqNoV2TddiTmNZL2OvQIIjpwQnglhaV91n8a+yibQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=orUcIuS7; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1709283154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HLbvrgwUZZKBHF7NvvXt4qwWmyIAaI4FWrdM6t+PElo=;
	b=orUcIuS7xstNMAE2D54STQMmWn3gzMFrWU0mCVp7v8cA9eEpuaqSdvrWrsQQ2Aee60Eerw
	gf21eR1Ap0G3tJglp2/CuNjBCBpsw2dqpeuK8BeEJO0bBigoGu6k37inPdFpJ3ZZVtuElw
	D1X3XRcX6eRn01R/fCmil5hxndf51F+f2/j9g/+dpjXuTNt/eGN4RbVRDD9X/fRYnHZSlp
	Xmilmr7rmn/HoZmnd2Sv8pbV/TalK+glKMbGthe/TlspYoVnm09U6WFgeEqVCOnV3u2GdN
	+y4vC8hUd5L5oyUDk7vNgkaQ1LVOJvjyJmG/FWX3kHPzPPeNoeFJAcDOrICdJA==
Date: Fri, 01 Mar 2024 09:52:34 +0100
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
In-Reply-To: <CABjd4YwMtZUhZG12qXv-=L8e2itwr6_Pex3E_ma1UC9MPQ95EA@mail.gmail.com>
References: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
 <20240229-rk-dts-additions-v3-1-6afe8473a631@gmail.com>
 <a370efd768021ce1afd6ea5ce841acbb@manjaro.org>
 <CABjd4YxM3HY20BbLZ2bJbEFuf6Uv9P_=v4NdHuvN2M-pxh652Q@mail.gmail.com>
 <ad00189e1a25ca90128be6c8b3841b77@manjaro.org>
 <CABjd4YwMtZUhZG12qXv-=L8e2itwr6_Pex3E_ma1UC9MPQ95EA@mail.gmail.com>
Message-ID: <8b48eeac7b629c39adc6024ff418724c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-01 09:25, Alexey Charkov wrote:
> On Fri, Mar 1, 2024 at 9:51 AM Dragan Simic <dsimic@manjaro.org> wrote:
>> On 2024-03-01 06:12, Alexey Charkov wrote:
>> > On Fri, Mar 1, 2024 at 12:21 AM Dragan Simic <dsimic@manjaro.org>
>> > wrote:
>> >> On 2024-02-29 20:26, Alexey Charkov wrote:
>> >> > Include thermal zones information in device tree for RK3588 variants.
>> >> >
>> >> > This also enables the TSADC controller unconditionally on all boards
>> >> > to ensure that thermal protections are in place via throttling and
>> >> > emergency reset, once OPPs are added to enable CPU DVFS.
>> >> >
>> >> > The default settings (using CRU as the emergency reset mechanism)
>> >> > should work on all boards regardless of their wiring, as CRU resets
>> >> > do not depend on any external components. Boards that have the TSHUT
>> >> > signal wired to the reset line of the PMIC may opt to switch to GPIO
>> >> > tshut mode instead (rockchip,hw-tshut-mode = <1>;)
>> >>
>> >> Quite frankly, I'm still not sure that enabling this on the SoC level
>> >> is the way to go.  As I already described in detail, [4] according to
>> >> the RK3588 Hardware Design Guide v1.0 and the Rock 5B schematic, we
>> >> should actually use GPIO-based handling for the thermal runaways on
>> >> the Rock 5B.  Other boards should also be investigated individually,
>> >> and the TSADC should be enabled on a board-to-board basis.
>> >
>> > With all due respect, I disagree, here is why:
>> >  - Neither the schematic nor the hardware design guide, on which the
>> > schematic seems to be based, prescribes a particular way to handle
>> > thermal runaways. They only provide the possibility of GPIO based
>> > resets, along with the CRU based one
>> 
>> Please note that other documents from Rockchip also exist.  Below is
>> a link to a screenshot from the Thermal developer guide, version 1.0,
>> which describes the whole thing further.  I believe it's obvious that
>> the thermal runaway is to be treated as a board-level feature.
>> 
>> - https://i.imgur.com/IJ6dSAc.png
> 
> Frankly, that still doesn't make TSADC per se a board-level thing IMO.
> The only thing that is board-level is the wiring of GPIO based resets,
> which I fully agree should go to board .dts for boards that support
> it, but that's not part of the current defaults and can be safely
> added later.
> 
> TSADC is inside the SoC. CRU is inside the SoC. They work just fine
> for a thermal reset, even if no dedicated reset logic is wired on the
> board. I really don't see any downsides in having TSADC enabled by
> default with CRU based resets:
> - it's a safe default (i.e. I cannot think of any configuration or use
> case where enabled-by-default TSADC does any harm)
> - it's safer than accidentally forgetting to enable TSADC (as it adds
> thermal protection which is otherwise missing)
> - it will work on all boards (even if it doesn't utilize the full
> hardware functionality by ignoring GPIO resets that some boards also
> have in addition to the CRU)
> - and it requires fewer overrides in board .dts files
> 
> Sounds like a no-regret move to me.

Please see my comments below.

>> To be fair, that version of the Thermal developer guide dates back to
>> 2019, meaning that it technically applies to the RK3399, for example,
>> but the TSADC and reset circuitry design has basically remained the
>> same for the RK3588.
>> 
>> >  - My strong belief is that defaults (regardless of context) should be
>> > safe and reasonable, and should also minimize the need to override
>> > them
>> 
>> Please note that the TSADC is disabled in the RK3399 SoC dtsi, so 
>> having
>> it disabled in the RK3588(s) SoC dtsi would provide some consistency.
> 
> I'm happy to produce a patch to reverse the logic in RK3399 (and any
> others for that matter) to also have TSADC enabled by default there,
> thus saving several lines of code, if it's just about consistency.

But why should we change something that has served us for years, on
multiple SoCs, with zero troubles and with (AFAIK) zero boards producing
puffs of bluish smoke?

>> Though, the RK3399 still does it in a safe way, by moving the OPPs 
>> into
>> a separate dtsi file, named rk3399-opp.dtsi, which the board dts files
>> then include together with enabling the TSADC.
>> 
>> If you agree, let's employ the same approach for the RK3588(s), by
>> having
>> the its OPPs defined in a separate file, named rk3588s-opp.dtsi, etc.
> 
> Separate file for OPPs is a good no-regret move to declutter the SoC
> level .dtsi (as the OPP table is long and boring) - happy to move it
> regardless of the outcome of the above TSADC discussion. Thanks for
> the pointer!

Yeah, but I'm not sure that everyone would like that kind of separation.
In fact, such separation may be frowned upon unless it's necessary.

As I already described in another thread, the separation for the RK3399
is there only because a couple of different variants of the RK3399 SoC
require different OPPs.

>> >  - In context of dts/dtsi, as far as I understand the general logic
>> > behind the split, the SoC .dtsi should contain all the things that are
>> > fully contained within the SoC and do not depend on the wiring of a
>> > particular board or its target use case. Boards then
>> > add/remove/override settings to match their wiring and use case more
>> > closely
>> 
>> Of course, but the thermal shutdown is obviously a board-level 
>> feature,
>> which I described further above.
> 
> Not so obvious to me :-) I don't mean to be stubborn or uncooperative
> here, but I really can't find any technical merit in having it enabled
> at board level instead of SoC level.

Well, please also consider that the PMICs from Rockchip are kind of
weird little chips, specifically customized to serve particular SoCs.
For example, they ensure the right sequencing and ramping-up of 
different
power rails, which is in many cases essential.

Thus, who knows what might (or might not) go wrong if we don't reset the
PMIC at the same time when the CRU resets the SoC?  Unfortunately, the
things aren't that straightforward.

On top of that, some boards, such as the Rock 5B, use a few additional
discrete voltage regulators instead of a master-slave PMIC 
configuration,
which may actually introduce some weird power-related issues, which also
may be intermittent.  Actually, I've already overheard that the Rock 5B
experiences some issues of that nature, but I don't know the details.

> Switching to PMIC-assisted resets is one thing - it definitely should
> go to board files, as it depends on the specific wiring of the
> TSADC_SHUT signal. Enabling TSADC in a default configuration that can
> and will work on all boards regardless of their wiring is another
> thing. I'm just arguing for the latter.

CRU-based thermal runaway handling may in theory work on all boards, but
we simply can't be 100% sure without detailed insights into the board
designs and testing.  Maybe even the downstream U-Boot does some magic
during such thermal runaway resets, which we don't know.  It may be
similar to the SoC reset issues that the RK3399 suffers from.

See also my comment above.

> To me it seems similar to the watchdog timer situation: we enable it
> at the SoC level [1], as it is expected to work in its default
> configuration regardless of the board wiring, and it provides
> protection against system malfunctions. Doesn't matter if the board or
> its userspace code ends up using the full functionality - it just sits
> there waiting for its spotlight without hurting anybody.

Frankly, I don't know much about the watchdog functionality, so I'd need
to research it before I could say something about it.

> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3588s.dtsi#n1872

