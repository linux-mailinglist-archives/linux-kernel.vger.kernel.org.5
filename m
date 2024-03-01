Return-Path: <linux-kernel+bounces-88381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B520086E0CD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E611C22AE4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7866D1D7;
	Fri,  1 Mar 2024 12:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pi0evXJj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243A76BFA4;
	Fri,  1 Mar 2024 12:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709294551; cv=none; b=eRgvUsga0tNoJyEXWQFpKAdKPoLqmeNeuK8Qzz0hlVf2PZ3UBnLmLm6PSs5621zIqd4TgqGinpEac9dBR7LOL4FHD3aAp7WRkOjno4YWkbZujknMHmwuWKW7IgfzfR4NP14xf7mJSv3T2VuI+OX0jHS2YuhI36npCb3C45rUCW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709294551; c=relaxed/simple;
	bh=J+B9ECfnbk/ngE+kNYgoOPNE6XW/Celh9owt9Ky/YPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQuw1wjudgCblWyCbmTiMJquIQrcaS22nVH1EtradJDIrXVGwftuTqhTewfTMlJGS3wXhA8Uj5KiPO2besRPSCkNP4VcQOKvZ20BQre691X0eLiuaYudkRRc+Rm3CkJ6C4EuhOteQ+bUGwb95/lRd/dp8CmFKYpsW8NmgcZK7JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pi0evXJj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CEEC433A6;
	Fri,  1 Mar 2024 12:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709294550;
	bh=J+B9ECfnbk/ngE+kNYgoOPNE6XW/Celh9owt9Ky/YPg=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=Pi0evXJj9b2sp5Vk33tyUXZ5aFcjYuz1ivBQy5jYYKsFs3hueg6KbwAL6FvF90lXT
	 xiOwXFqdg3zBGl2w40GQrHN5DMa7Fz96zamgLSTlU3FdQDr1cj6Yl+FnWVv56wW4WX
	 bimucL4sRNj+Oi/S4LzpFW+p8ZbQ37SYwK8c5OPeu72iFufSpkLCkl9SsN2vcOV9Ls
	 BUiXPX5zok8XNL0hTrHpDRHWEZsRU0MP9t0zJidyRyp1wuR1gS4yObMqOTbNxiIZXA
	 HN+AqeX7r/DmhbxfzbX1rRyRO/CIa2vPfM9hWFohcSQh6vLisxfFg65Gcz1JOGQMfv
	 /eLLXpQXX+k5g==
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2995fa850ddso2491855a91.0;
        Fri, 01 Mar 2024 04:02:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVaS7M7QmDMS2bM2SPPCPUuEPLFmwKNvng9d3g/wkuUBWw/i8nARfmBbavmu9tkHGrI7Scz6X6UFFGdus5dxDRa3rpa5nqhQAY+1hMgg7CpOqBiQLPBkGkUMX9y89E2nL7l49M3gKfGGQ==
X-Gm-Message-State: AOJu0YybY200yEbZ/NoERflvtNQ8K9hW1xmzFV8EdhMs6ubpdELU3m+u
	8MMlEEKXOQ9F8mGRId06cdPStjpFfg8xmAFbx6GVu4ThyP6G//9WZBlfXfrw33/uXiwAuNIBwh3
	jP5OKYvdtSHMcty6WDlW+mQCmsh4=
X-Google-Smtp-Source: AGHT+IH6H5OsMz3dZyGLLiquVl8uCUYEQJTxWWUE/zGOn/gs/bBY4Nq3Qpc8OHDFpSl6v+yQVDqWg8f+Fl6CMRKuQh8=
X-Received: by 2002:a17:90b:2283:b0:298:a422:937d with SMTP id
 kx3-20020a17090b228300b00298a422937dmr1796932pjb.24.1709294550030; Fri, 01
 Mar 2024 04:02:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
 <20240229-rk-dts-additions-v3-1-6afe8473a631@gmail.com> <a370efd768021ce1afd6ea5ce841acbb@manjaro.org>
 <CABjd4YxM3HY20BbLZ2bJbEFuf6Uv9P_=v4NdHuvN2M-pxh652Q@mail.gmail.com>
 <ad00189e1a25ca90128be6c8b3841b77@manjaro.org> <CABjd4YwMtZUhZG12qXv-=L8e2itwr6_Pex3E_ma1UC9MPQ95EA@mail.gmail.com>
 <8b48eeac7b629c39adc6024ff418724c@manjaro.org> <CABjd4YzjQ8NdA-gdux3YPw2K6dwLn5oNWRAix7raSgoGsEdpbA@mail.gmail.com>
In-Reply-To: <CABjd4YzjQ8NdA-gdux3YPw2K6dwLn5oNWRAix7raSgoGsEdpbA@mail.gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 1 Mar 2024 20:02:17 +0800
X-Gmail-Original-Message-ID: <CAGb2v66Fg5dA_p+O9o=1+jkqdGREi_AD73o-J=e3dQ4EoEArjw@mail.gmail.com>
Message-ID: <CAGb2v66Fg5dA_p+O9o=1+jkqdGREi_AD73o-J=e3dQ4EoEArjw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] arm64: dts: rockchip: enable built-in thermal
 monitoring on RK3588
To: Alexey Charkov <alchark@gmail.com>, Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 7:10=E2=80=AFPM Alexey Charkov <alchark@gmail.com> w=
rote:
>
> On Fri, Mar 1, 2024 at 12:52=E2=80=AFPM Dragan Simic <dsimic@manjaro.org>=
 wrote:
> >
> > On 2024-03-01 09:25, Alexey Charkov wrote:
> > > On Fri, Mar 1, 2024 at 9:51=E2=80=AFAM Dragan Simic <dsimic@manjaro.o=
rg> wrote:
> > >> On 2024-03-01 06:12, Alexey Charkov wrote:
> > >> > On Fri, Mar 1, 2024 at 12:21=E2=80=AFAM Dragan Simic <dsimic@manja=
ro.org>
> > >> > wrote:
> > >> >> On 2024-02-29 20:26, Alexey Charkov wrote:
> > >> >> > Include thermal zones information in device tree for RK3588 var=
iants.
> > >> >> >
> > >> >> > This also enables the TSADC controller unconditionally on all b=
oards
> > >> >> > to ensure that thermal protections are in place via throttling =
and
> > >> >> > emergency reset, once OPPs are added to enable CPU DVFS.
> > >> >> >
> > >> >> > The default settings (using CRU as the emergency reset mechanis=
m)
> > >> >> > should work on all boards regardless of their wiring, as CRU re=
sets
> > >> >> > do not depend on any external components. Boards that have the =
TSHUT
> > >> >> > signal wired to the reset line of the PMIC may opt to switch to=
 GPIO
> > >> >> > tshut mode instead (rockchip,hw-tshut-mode =3D <1>;)
> > >> >>
> > >> >> Quite frankly, I'm still not sure that enabling this on the SoC l=
evel
> > >> >> is the way to go.  As I already described in detail, [4] accordin=
g to
> > >> >> the RK3588 Hardware Design Guide v1.0 and the Rock 5B schematic, =
we
> > >> >> should actually use GPIO-based handling for the thermal runaways =
on
> > >> >> the Rock 5B.  Other boards should also be investigated individual=
ly,
> > >> >> and the TSADC should be enabled on a board-to-board basis.
> > >> >
> > >> > With all due respect, I disagree, here is why:
> > >> >  - Neither the schematic nor the hardware design guide, on which t=
he
> > >> > schematic seems to be based, prescribes a particular way to handle
> > >> > thermal runaways. They only provide the possibility of GPIO based
> > >> > resets, along with the CRU based one
> > >>
> > >> Please note that other documents from Rockchip also exist.  Below is
> > >> a link to a screenshot from the Thermal developer guide, version 1.0=
,
> > >> which describes the whole thing further.  I believe it's obvious tha=
t
> > >> the thermal runaway is to be treated as a board-level feature.
> > >>
> > >> - https://i.imgur.com/IJ6dSAc.png
> > >
> > > Frankly, that still doesn't make TSADC per se a board-level thing IMO=
.
> > > The only thing that is board-level is the wiring of GPIO based resets=
,
> > > which I fully agree should go to board .dts for boards that support
> > > it, but that's not part of the current defaults and can be safely
> > > added later.
> > >
> > > TSADC is inside the SoC. CRU is inside the SoC. They work just fine
> > > for a thermal reset, even if no dedicated reset logic is wired on the
> > > board. I really don't see any downsides in having TSADC enabled by
> > > default with CRU based resets:
> > > - it's a safe default (i.e. I cannot think of any configuration or us=
e
> > > case where enabled-by-default TSADC does any harm)
> > > - it's safer than accidentally forgetting to enable TSADC (as it adds
> > > thermal protection which is otherwise missing)
> > > - it will work on all boards (even if it doesn't utilize the full
> > > hardware functionality by ignoring GPIO resets that some boards also
> > > have in addition to the CRU)
> > > - and it requires fewer overrides in board .dts files
> > >
> > > Sounds like a no-regret move to me.
> >
> > Please see my comments below.
> >
> > >> To be fair, that version of the Thermal developer guide dates back t=
o
> > >> 2019, meaning that it technically applies to the RK3399, for example=
,
> > >> but the TSADC and reset circuitry design has basically remained the
> > >> same for the RK3588.
> > >>
> > >> >  - My strong belief is that defaults (regardless of context) shoul=
d be
> > >> > safe and reasonable, and should also minimize the need to override
> > >> > them
> > >>
> > >> Please note that the TSADC is disabled in the RK3399 SoC dtsi, so
> > >> having
> > >> it disabled in the RK3588(s) SoC dtsi would provide some consistency=
.
> > >
> > > I'm happy to produce a patch to reverse the logic in RK3399 (and any
> > > others for that matter) to also have TSADC enabled by default there,
> > > thus saving several lines of code, if it's just about consistency.
> >
> > But why should we change something that has served us for years, on
> > multiple SoCs, with zero troubles and with (AFAIK) zero boards producin=
g
> > puffs of bluish smoke?
>
> That's just if we are concerned about consistency across different SoC
> series. The point is that I'm happy to make whatever change we agree
> upon in a consistent way across all related .dtsi/.dts files - thus no
> need to worry about past decisions that have already been implemented
> for other chips. Let's just agree on the technical merits of one or
> the other approach, leaving "we've been doing it differently
> elsewhere" aside for now.
>
> > >> Though, the RK3399 still does it in a safe way, by moving the OPPs
> > >> into
> > >> a separate dtsi file, named rk3399-opp.dtsi, which the board dts fil=
es
> > >> then include together with enabling the TSADC.
> > >>
> > >> If you agree, let's employ the same approach for the RK3588(s), by
> > >> having
> > >> the its OPPs defined in a separate file, named rk3588s-opp.dtsi, etc=
.
> > >
> > > Separate file for OPPs is a good no-regret move to declutter the SoC
> > > level .dtsi (as the OPP table is long and boring) - happy to move it
> > > regardless of the outcome of the above TSADC discussion. Thanks for
> > > the pointer!
> >
> > Yeah, but I'm not sure that everyone would like that kind of separation=
.
> > In fact, such separation may be frowned upon unless it's necessary.
> >
> > As I already described in another thread, the separation for the RK3399
> > is there only because a couple of different variants of the RK3399 SoC
> > require different OPPs.
> >
> > >> >  - In context of dts/dtsi, as far as I understand the general logi=
c
> > >> > behind the split, the SoC .dtsi should contain all the things that=
 are
> > >> > fully contained within the SoC and do not depend on the wiring of =
a
> > >> > particular board or its target use case. Boards then
> > >> > add/remove/override settings to match their wiring and use case mo=
re
> > >> > closely
> > >>
> > >> Of course, but the thermal shutdown is obviously a board-level
> > >> feature,
> > >> which I described further above.
> > >
> > > Not so obvious to me :-) I don't mean to be stubborn or uncooperative
> > > here, but I really can't find any technical merit in having it enable=
d
> > > at board level instead of SoC level.
> >
> > Well, please also consider that the PMICs from Rockchip are kind of
> > weird little chips, specifically customized to serve particular SoCs.
> > For example, they ensure the right sequencing and ramping-up of
> > different
> > power rails, which is in many cases essential.
>
> Sure. I'm not saying that switching to a PMIC-assisted reset shouldn't
> be done where the board supports it - quite the opposite. All I'm
> saying is that having at least passive cooling and CRU based resets
> guaranteed for any board, regardless of how thought through its .dts
> is, seems to be a better default than no thermal protection.
>
> > Thus, who knows what might (or might not) go wrong if we don't reset th=
e
> > PMIC at the same time when the CRU resets the SoC?  Unfortunately, the
> > things aren't that straightforward.
> >
> > On top of that, some boards, such as the Rock 5B, use a few additional
> > discrete voltage regulators instead of a master-slave PMIC
> > configuration,
> > which may actually introduce some weird power-related issues, which als=
o
> > may be intermittent.  Actually, I've already overheard that the Rock 5B
> > experiences some issues of that nature, but I don't know the details.
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

FWIW, the CRU reset is what the kernel uses for rebooting the system,
either during a reboot or a kernel panic. So it is already used for both
normal and abnormal scenarios. And yes, it sometimes leaves regulators
or other parts of the system in some weird state that the BROM isn't
expecting.

Why should a hardware triggered reset be any different?

ChenYu

> > > Switching to PMIC-assisted resets is one thing - it definitely should
> > > go to board files, as it depends on the specific wiring of the
> > > TSADC_SHUT signal. Enabling TSADC in a default configuration that can
> > > and will work on all boards regardless of their wiring is another
> > > thing. I'm just arguing for the latter.
> >
> > CRU-based thermal runaway handling may in theory work on all boards, bu=
t
> > we simply can't be 100% sure without detailed insights into the board
> > designs and testing.  Maybe even the downstream U-Boot does some magic
> > during such thermal runaway resets, which we don't know.  It may be
> > similar to the SoC reset issues that the RK3399 suffers from.
>
> That might be true, but we're talking about operation at 120C+ here.
> I'd rather have my board reboot in any way it pleases under those
> conditions, and have that behavior triggered by default even if it's
> imperfect, then worry about the correct state of all regulators and
> peripherals upon next boot. The latter is important of course, but I'd
> rather let it cool down and reboot it manually anyway, because that
> heat could have made more things go sideways than just the regulators.
>
> > See also my comment above.
> >
> > > To me it seems similar to the watchdog timer situation: we enable it
> > > at the SoC level [1], as it is expected to work in its default
> > > configuration regardless of the board wiring, and it provides
> > > protection against system malfunctions. Doesn't matter if the board o=
r
> > > its userspace code ends up using the full functionality - it just sit=
s
> > > there waiting for its spotlight without hurting anybody.
> >
> > Frankly, I don't know much about the watchdog functionality, so I'd nee=
d
> > to research it before I could say something about it.
>
> FWIW, watchdog resets are exclusively routed through the CRU (see
> RK3588 TRM V1.0 part 1 page 31). So if we expect that one to work
> somehow, probably we should expect thermal resets to work too.
>
> Best regards,
> Alexey

