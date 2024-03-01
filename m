Return-Path: <linux-kernel+bounces-88073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3935186DD06
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B9B1F27011
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A442669D33;
	Fri,  1 Mar 2024 08:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1I48UcM"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61A169317;
	Fri,  1 Mar 2024 08:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709281567; cv=none; b=Hp9lsyMjDVMxFUYeBaV41JGa7Q5HEhzd9ILfymLEhGgOzk2fEZYJFQ0P78IxVH2VlGgwnnwWU44zecWfKfk+KyK3oiCyoazJ8RSmlCcKAI9SVf/Vx161HCg895XAQdQvX0tG/fkD7efdkzP+RGlei/oIyCUb4C5l7srb3Y9Fq10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709281567; c=relaxed/simple;
	bh=HSwJXZGMESBgXPYDK8eENz/KoKyulO2yDORnPWxeOdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BnZ+4dcv6SPjHjPFf7TzAdmOtDlfyB5r2P6Kc1MEPsL332NTRRi0Is6Hui8uCoja6HgHe3e9WW2b7nJmCyLS2q18ySOptG07XpXna/A4oaZWY24NDJnMBtvst8FInEFCVSM5ffaDAWaUGueRRlfnldAuMh0zIv0fJ9um2+3EzF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1I48UcM; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a4417fa396fso258526166b.1;
        Fri, 01 Mar 2024 00:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709281564; x=1709886364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlyerIzunUFDUg67FEUrIKK1Po21JVdARxZCcUHYdeg=;
        b=l1I48UcMI2YWOURpf5mRWqPctvmsn16qZUpzamyHrWf+AXMzjXppN0rNh/uJ/8O6Sr
         KM31/NTuoH8oLFQOXB6VC9eUU90F4CChUA3MHrft8I+v8FmsSBrqNM7VVD3l0GEIVGxr
         BgNPfCuH9pmDDZU3Mf4FeVBN0ax2ZutnAlb35eQSnMi0UA7pXnzPQXocW+ZsaGzx/t4q
         M+mML7TTki+RoA42s+ukca1N4WcWcWw8d+ET2s9lhP1mRQdZFStDjIr9TxMi1vyeP/kW
         vPDLf/zG0ac0l0mced6B6/87FV/LlthzHy4rTBS+BQjcSnDHMB1Y5F6cmrHCvUBgEXYP
         irFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709281564; x=1709886364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlyerIzunUFDUg67FEUrIKK1Po21JVdARxZCcUHYdeg=;
        b=N5sPPP/NYwlFC6RFOX2aDrfpz5B/EDB3NQEyiS++aHMpHrsakUi9TvXIfzTJZK53BD
         DPINFOvW9I8SMrUHvpy8qcjLkuIH1+NMODcdkMenqUFQivr3nFxL7tvkJBuOB2dGl2xE
         OEVrs77qnW5XU/sfvO8g+NvhsqQAIdIDLc3fVGJFCEdqpb03Wub4tdMhQjnjd6CZKwYz
         wdYdrWDMgp4zqptwYkdsERdSvojh932AFBWDnkwty1vwH09shx313iCDncxBYnJio306
         enARby4zewR27rQaXWEkLi9GJ1VgQLyZ8l9AhZu/08csQhKdML0byytZ4TM94yUTxiFk
         8SPA==
X-Forwarded-Encrypted: i=1; AJvYcCVcaDnHp5IiwVip5t5mJGcbeRjuJ6wbHGOtmuSeY5yfhCV9rsZHfTSxHe/7tfwT1bFUUrn8Go7S0MjRltTxn+4N+SOlJtoCwyv19yQFlW1iAD5qsOapInIM1ITMIg1O6uuorrJ/m1c5Cg==
X-Gm-Message-State: AOJu0YyhiTMPrzhU18080q5M2zhRhTGfBxzy+vlVF3JvEIkAaO7zGiY6
	7JytwZddmlmvja4PwO8b2OAFZZKbrQqNClnMz6CVo/1nBIzmEQHL/zSCOeLeyGVRj3jK7ACfsfM
	Yl12Mz7bJTRZVGpsn1Yy7fCUP87c=
X-Google-Smtp-Source: AGHT+IFkWfFdaH4Mi429uvg75OBHbq8cPVmZxthiWKrwnOcGpQQsAAICveFw8u4V27aIzZneVfbCn/TKukdgdVWuUlo=
X-Received: by 2002:a17:906:4a55:b0:a44:978b:534a with SMTP id
 a21-20020a1709064a5500b00a44978b534amr431442ejv.64.1709281563928; Fri, 01 Mar
 2024 00:26:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
 <20240229-rk-dts-additions-v3-1-6afe8473a631@gmail.com> <a370efd768021ce1afd6ea5ce841acbb@manjaro.org>
 <CABjd4YxM3HY20BbLZ2bJbEFuf6Uv9P_=v4NdHuvN2M-pxh652Q@mail.gmail.com> <ad00189e1a25ca90128be6c8b3841b77@manjaro.org>
In-Reply-To: <ad00189e1a25ca90128be6c8b3841b77@manjaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 1 Mar 2024 12:25:52 +0400
Message-ID: <CABjd4YwMtZUhZG12qXv-=L8e2itwr6_Pex3E_ma1UC9MPQ95EA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] arm64: dts: rockchip: enable built-in thermal
 monitoring on RK3588
To: Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu Tsai <wens@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 9:51=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> wr=
ote:
>
> On 2024-03-01 06:12, Alexey Charkov wrote:
> > On Fri, Mar 1, 2024 at 12:21=E2=80=AFAM Dragan Simic <dsimic@manjaro.or=
g>
> > wrote:
> >> On 2024-02-29 20:26, Alexey Charkov wrote:
> >> > Include thermal zones information in device tree for RK3588 variants=
.
> >> >
> >> > This also enables the TSADC controller unconditionally on all boards
> >> > to ensure that thermal protections are in place via throttling and
> >> > emergency reset, once OPPs are added to enable CPU DVFS.
> >> >
> >> > The default settings (using CRU as the emergency reset mechanism)
> >> > should work on all boards regardless of their wiring, as CRU resets
> >> > do not depend on any external components. Boards that have the TSHUT
> >> > signal wired to the reset line of the PMIC may opt to switch to GPIO
> >> > tshut mode instead (rockchip,hw-tshut-mode =3D <1>;)
> >>
> >> Quite frankly, I'm still not sure that enabling this on the SoC level
> >> is the way to go.  As I already described in detail, [4] according to
> >> the RK3588 Hardware Design Guide v1.0 and the Rock 5B schematic, we
> >> should actually use GPIO-based handling for the thermal runaways on
> >> the Rock 5B.  Other boards should also be investigated individually,
> >> and the TSADC should be enabled on a board-to-board basis.
> >
> > With all due respect, I disagree, here is why:
> >  - Neither the schematic nor the hardware design guide, on which the
> > schematic seems to be based, prescribes a particular way to handle
> > thermal runaways. They only provide the possibility of GPIO based
> > resets, along with the CRU based one
>
> Please note that other documents from Rockchip also exist.  Below is
> a link to a screenshot from the Thermal developer guide, version 1.0,
> which describes the whole thing further.  I believe it's obvious that
> the thermal runaway is to be treated as a board-level feature.
>
> - https://i.imgur.com/IJ6dSAc.png

Frankly, that still doesn't make TSADC per se a board-level thing IMO.
The only thing that is board-level is the wiring of GPIO based resets,
which I fully agree should go to board .dts for boards that support
it, but that's not part of the current defaults and can be safely
added later.

TSADC is inside the SoC. CRU is inside the SoC. They work just fine
for a thermal reset, even if no dedicated reset logic is wired on the
board. I really don't see any downsides in having TSADC enabled by
default with CRU based resets:
- it's a safe default (i.e. I cannot think of any configuration or use
case where enabled-by-default TSADC does any harm)
- it's safer than accidentally forgetting to enable TSADC (as it adds
thermal protection which is otherwise missing)
- it will work on all boards (even if it doesn't utilize the full
hardware functionality by ignoring GPIO resets that some boards also
have in addition to the CRU)
- and it requires fewer overrides in board .dts files

Sounds like a no-regret move to me.

> To be fair, that version of the Thermal developer guide dates back to
> 2019, meaning that it technically applies to the RK3399, for example,
> but the TSADC and reset circuitry design has basically remained the
> same for the RK3588.
>
> >  - My strong belief is that defaults (regardless of context) should be
> > safe and reasonable, and should also minimize the need to override
> > them
>
> Please note that the TSADC is disabled in the RK3399 SoC dtsi, so having
> it disabled in the RK3588(s) SoC dtsi would provide some consistency.

I'm happy to produce a patch to reverse the logic in RK3399 (and any
others for that matter) to also have TSADC enabled by default there,
thus saving several lines of code, if it's just about consistency.

> Though, the RK3399 still does it in a safe way, by moving the OPPs into
> a separate dtsi file, named rk3399-opp.dtsi, which the board dts files
> then include together with enabling the TSADC.
>
> If you agree, let's employ the same approach for the RK3588(s), by
> having
> the its OPPs defined in a separate file, named rk3588s-opp.dtsi, etc.

Separate file for OPPs is a good no-regret move to declutter the SoC
level .dtsi (as the OPP table is long and boring) - happy to move it
regardless of the outcome of the above TSADC discussion. Thanks for
the pointer!

> >  - In context of dts/dtsi, as far as I understand the general logic
> > behind the split, the SoC .dtsi should contain all the things that are
> > fully contained within the SoC and do not depend on the wiring of a
> > particular board or its target use case. Boards then
> > add/remove/override settings to match their wiring and use case more
> > closely
>
> Of course, but the thermal shutdown is obviously a board-level feature,
> which I described further above.

Not so obvious to me :-) I don't mean to be stubborn or uncooperative
here, but I really can't find any technical merit in having it enabled
at board level instead of SoC level.

Switching to PMIC-assisted resets is one thing - it definitely should
go to board files, as it depends on the specific wiring of the
TSADC_SHUT signal. Enabling TSADC in a default configuration that can
and will work on all boards regardless of their wiring is another
thing. I'm just arguing for the latter.

To me it seems similar to the watchdog timer situation: we enable it
at the SoC level [1], as it is expected to work in its default
configuration regardless of the board wiring, and it provides
protection against system malfunctions. Doesn't matter if the board or
its userspace code ends up using the full functionality - it just sits
there waiting for its spotlight without hurting anybody.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/arch/arm64/boot/dts/rockchip/rk3588s.dtsi#n1872

Best regards,
Alexey

