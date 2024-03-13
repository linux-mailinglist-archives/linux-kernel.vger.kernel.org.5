Return-Path: <linux-kernel+bounces-102021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5239B87ADA9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A7028343F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E756053395;
	Wed, 13 Mar 2024 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="u/x7ASb8"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE9D4C600;
	Wed, 13 Mar 2024 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348305; cv=none; b=WvJ4uoYsijG++C3NqFlKhRSCoq2KlbM20wphMmoBmKpFXbsiqLZM+zBqjm1UrJVNYr5Q/BFTXUQL+VLnyD/3djntXd42gpplHlENvzYzFs/ssSs9BZkVIWKejWEMuGkRq4MqIYeckJAyY4eHzaqwcJbqnOaNpOIZ0hs6Iy3nm40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348305; c=relaxed/simple;
	bh=r2yTOImLEgBv+5kM0rWcsT1rGUuk6c9e8dJPwXpk3p4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=YNJqpz71JP3ebZ000M24g+hJqyCexg6pO6mFphbtu3UnIRzA952Qcs08fkV/czcOPhiV66OC40kzhPd4u5xFhozqkiTd/Psj3orma1KDLfnq9g2CpXyU9w3KF9lkNuA+r5Sgo8FQAjDt9rxpPlnccL83YlakP9R0vE0BpP45NwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=u/x7ASb8; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710348294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wRKYVbWo7rvuu2swGuQTlLkzEW9Czyjs6ZI6qNJKWlo=;
	b=u/x7ASb8r5+IJYatiC5vG444aqGl7ANW3qnobJ3WI3dR9QVwHGCX23Hgs4LJ+GoKNsSrpY
	iXF7HeiuTwLKJPEFpX2aGowdgf5lFDeQgBqZ3GW1c4djxB0JZZgznbWchonZVm8rIuyGSA
	Jvx+/5hXbQE56i7A3GC+4bFaEJmU/A1kyavNRseHFBgFp7c/+s4VDImU8jRCqd02ub3r3K
	1Uj3L41kJl0QD9oZOYEWcvb9SZ1oTctz26XUdVtKbDS/TEzqMMjPAd6sIGQxjmV/1lmEzE
	IRMCWVQV9ahsJN4NQPtXvJlJPY1H5tLUhggxQge5klVAXhFP0LU0IwqicRRCLA==
Date: Wed, 13 Mar 2024 17:44:53 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Alexey Charkov <alchark@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu
 Tsai <wens@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] RK3588 and Rock 5B dts additions: thermal, OPP and
 fan
In-Reply-To: <cen2x7vlenevup34efl7sqn7sm5td35vkfmo4fcaotwk6fmv67@tdpcg5jokjhv>
References: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
 <j3krazypdc7gsvnp4kcocaftxsbjrfhj6nr2kf2cieo4bjxbv7@bqdfbirk5tei>
 <CABjd4Yxs9b0XDXYfdnmT08BQnsJLonRy4X-g73J67yeGw3xL+w@mail.gmail.com>
 <CABjd4YzTL=5S7cS8ACNAYVa730WA3iGd5L_wP1Vn9=f83RCORA@mail.gmail.com>
 <pkyne4g2cln27dcdu3jm7bqdqpmd2kwkbguiolmozntjuiajrb@gvq4nupzna4o>
 <cen2x7vlenevup34efl7sqn7sm5td35vkfmo4fcaotwk6fmv67@tdpcg5jokjhv>
Message-ID: <5e93447d1b219fde1e2b390d40495ef1@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Sebastian,

On 2024-03-13 17:39, Sebastian Reichel wrote:
> On Thu, Mar 07, 2024 at 11:16:20PM +0100, Sebastian Reichel wrote:
>> On Thu, Mar 07, 2024 at 04:38:24PM +0400, Alexey Charkov wrote:
>> > On Tue, Mar 5, 2024 at 12:06 PM Alexey Charkov <alchark@gmail.com> wrote:
>> > > On Mon, Mar 4, 2024 at 9:51 PM Sebastian Reichel
>> > > <sebastian.reichel@collabora.com> wrote:
>> > > > I'm too busy to have a detailed review of this series right now, but
>> > > > I pushed it to our CI and it results in a board reset at boot time:
>> > > >
>> > > > https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/jobs/300950
>> > > >
>> > > > I also pushed just the first three patches (i.e. without OPP /
>> > > > cpufreq) and that boots fine:
>> > > >
>> > > > https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/jobs/300953
>> > >
>> > > Thank you for testing these! I've noticed in the boot log that the CI
>> > > machine uses some u-boot 2023.07 - is that a downstream one? Any
>> > > chance to compare it to 2023.11 or 2024.01 from your (Collabora)
>> > > integration tree?
>> > >
>> > > I use 2023.11 from your integration tree, with a binary bl31, and I'm
>> > > not getting those resets even under prolonged heavy load (I rebuild
>> > > Chromium with 8 concurrent compilation jobs as the stress test -
>> > > that's 14 hours of heavy CPU, memory and IO use). Would be interesting
>> > > to understand if it's just a 'lucky' SoC specimen on my side, or if
>> > > there is some dark magic happening differently on my machine vs. your
>> > > CI machine.
>> > >
>> > > Thinking that maybe if your CI machine uses a downstream u-boot it
>> > > might be leaving some extra hardware running (PVTM?) which might do
>> > > weird stuff when TSADC/clocks/voltages get readjusted by the generic
>> > > cpufreq driver?..
>> > >
>> > > > Note, that OPP / cpufreq works on the same boards in the CI when
>> > > > using the ugly-and-not-for-upstream cpufreq driver:
>> > > >
>> > > > https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/commit/9c90c5032743a0419bf3fd2f914a24fd53101acd
>> > > >
>> > > > My best guess right now is, that this is related to the generic
>> > > > driver obviously not updating the GRF read margin registers.
>> > >
>> > > If it was about memory read margins I believe I would have been
>> > > unlikely to get my machine to work reliably under heavy load with the
>> > > default ones, but who knows...
>> >
>> > Sebastian's report led me to investigate further how all those things
>> > are organized in the downstream code and in hardware, and what could
>> > be a pragmatic way forward with upstream enablement. It turned out to
>> > be quite a rabbit hole frankly, with multiple layers of abstraction
>> > and intertwined code in different places.
>> >
>> > Here's a quick summary for future reference:
>> >  - CPU clocks on RK3588 are ultimately managed by the ATF firmware,
>> > which provides an SCMI service to expose them to the kernel
>> >  - ATF itself doesn't directly set any clock frequencies. Instead, it
>> > accepts a target frequency via SCMI and converts it into an oscillator
>> > ring length setting for the PVPLL hardware block (via a fixed table
>> > lookup). At least that's how it's done in the recently released TF-A
>> > bl31 code [1] - perhaps the binary bl31 does something similar
>> >  - U-boot doesn't seem to mess with CPU clocks, PVTM or PVPLL
>> >  - PVPLL produces a reference clock to feed to the CPUs, which depends
>> > on the configured oscillator ring length but also on the supply
>> > voltage, silicon quality and perhaps temperature too. ATF doesn't know
>> > anything about voltages or temperatures, so it doesn't guarantee that
>> > the requested frequency is matched by the hardware
>> >  - PVPLL frequency generation is bypassed for lower-frequency OPPs, in
>> > which case the target frequency is directly fed by the ATF to the CRU.
>> > This happens for both big-core and little-core frequencies below 816
>> > MHz
>> >  - Given that requesting a particular frequency via SCMI doesn't
>> > guarantee that it will be what the CPUs end up running at, the vendor
>> > kernel also does a runtime voltage calibration for the supply
>> > regulators, by adjusting the supply voltage in minimum regulator steps
>> > until the frequency reported by PVPLL gets close to the requested one
>> > [2]. It then overwrites OPP provided voltage values with the
>> > calibrated ones
>> >  - There's also some trickery with preselecting OPP voltage sets using
>> > the "-Lx" suffix based on silicon quality, as measured by a "leakage"
>> > value stored in an NVMEM cell and/or the PVTM frequency generated at a
>> > reference "midpoint" OPP [3]. Better performing silicon gets to run at
>> > lower default supply voltages, thus saving power
>> >  - Once the OPPs are selected and calibrated, the only remaining
>> > trickery is the two supply regulators per each CPU cluster (one for
>> > the CPUs and the other for the memory interface)
>> >  - Another catch, as Sebastian points out, is that memory read margins
>> > must be adjusted whenever the memory interface supply voltage crosses
>> > certain thresholds [4]. This has little to do with CPUs or
>> > frequencies, and is only tangentially related to them due to the
>> > dependency chain between the target CPU frequency -> required CPU
>> > supply voltage -> matching memory interface supply voltage -> required
>> > read margins
>> >  - At reset the ATF switches all clocks to the lowest 408 MHz [6], so
>> > setting it to anything in kernel code (as the downstream driver does)
>> > seems redundant
>> >
>> > All in all, it does indeed sound like Collabora's CI machine boot-time
>> > resets are most likely caused by the missing memory read margin
>> > settings in my patch series. Voltage values in the OPPs I used are the
>> > most conservative defaults of what the downstream DT has, and PVPLL
>> > should be able to generate reasonable clock speeds with those (albeit
>> > likely suboptimal, due to them not being tuned to the particular
>> > silicon specimen). And there is little else to differ frankly.
>> >
>> > As for the way forward, it would be great to know the opinions from
>> > the list. My thinking is as follows:
>> >  - I can introduce memory read margin updates as the first priority,
>> > leaving voltage calibration and/or OPP preselection for later (as
>> > those should not affect system stability at current default values,
>> > perhaps only power efficiency to a certain extent)
>> >  - CPUfreq doesn't sound like the right place for those, given that
>> > they have little to do with either CPU or freq :)
>> >  - I suggest a custom regulator config helper to plug into the OPP
>> > layer, as is done for TI OMAP5 [6]. At first, it might be only used
>> > for looking up and setting the correct memory read margin value
>> > whenever the cluster supply voltage changes, and later the same code
>> > can be extended to do voltage calibration. In fact, OMAP code is there
>> > for a very similar purpose, but in their case optimized voltages are
>> > pre-programmed in efuses and don't require runtime recalibration
>> >  - Given that all OPPs in the downstream kernel list identical
>> > voltages for the memory supply as for the CPU supply, I don't think it
>> > makes much sense to customize the cpufreq driver per se.
>> > Single-regulator approach with the generic cpufreq-dt and regulator
>> > coupling sounds much less invasive and thus lower-maintenance
>> 
>> Sorry for my late response.
>> 
>> When doing some more tests I noticed, that the CI never build the
>> custom driver and thus never did any CPU frequency scaling at all.
>> I only used it for my own tests (on RK3588 EVB1). When enabling the
>> custom driver, the CI has the same issues as your series. So my
>> message was completely wrong, sorry about that.
>> 
>> Regarding U-Boot: The CI uses "U-Boot SPL 2023.07-rc4-g46349e27";
>> the last part is the git hash. This is the exact U-Boot source tree
>> being used:
>> 
>> https://gitlab.collabora.com/hardware-enablement/rockchip-3588/u-boot/-/commits/46349e27/
>> 
>> This was one of the first U-Boot trees with Rock 5B Ethernet support
>> and is currently flashed to the SPI flash memory of the CI boards.
>> The vendor U-Boot tree is a lot older. Also it is still using the
>> Rockchip binary BL31. We have plans to also CI boot test U-Boot,
>> but currently nobody has time to work on this. I don't think there 
>> should
>> be any relevant changes between upstream 2023.07 and 2023.11 that 
>> could
>> explain this. But it's the best lead now, so I will try to find some 
>> time
>> for doing further tests related to this in the next days.
>> 
>> Regarding the voltage calibration - One option would be to do this
>> calibration at boot time (i.e. in U-Boot) and update the voltages
>> in DT accordingly.
> 
> After some more debugging I finally found the root cause. The CI
> boards were powered from a USB hub using a USB-A to USB-C cable, so
> that the team could access maskrom mode. Since I was not involved in
> setting them up, I was not aware of that. It effectively limits the
> power draw to 500 or 900 mA (depending on USB port implementation),
> which is not enough to power the board with the higher frequencies.
> The KernelCI Rock 5B boards are now switched to proper power
> supplies and the issues are gone.
> 
> Sorry for the false alarm,

Great to know, thanks for the clarification.

