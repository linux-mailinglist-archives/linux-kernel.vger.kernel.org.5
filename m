Return-Path: <linux-kernel+bounces-91863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B005871793
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBB16B21429
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7E37EF17;
	Tue,  5 Mar 2024 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgPtNp5r"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649A86025A;
	Tue,  5 Mar 2024 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626024; cv=none; b=bxWvYt9fdADChza5odBqUh3T8bma7C8ifVhrTfBgOwiFLCIWqnz946JyLVjcHtCxNs2LTEMA9xI/4ebv7nC/BFB52k9D64AB4ji7BhSDqqZSpc3loHglpk/ndYUogvmsMOFNAALKdKD5ZKlyhRH++svAXcHbP9J92P0cf7MgNMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626024; c=relaxed/simple;
	bh=DYtaxA9zcAmNi+liq/6oCQmZryeCBKRANOVUcsNQUp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CO8JHahdO8fjy2AaEAGH8rWZp2yh5U32YbaJpl18VBpoBbjUfvE2omeakWpeXCtdYRBLfG8hezGoLe2BtG3dgvniHA1vnSYS8K1snFUNP7QGbSQ9Efeedgk3Aj5Ahd/pO6zfJJgx014es1OST8PxW1UY2Z3+MgcKVzxXws22fi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgPtNp5r; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a4515f8e13cso250172866b.3;
        Tue, 05 Mar 2024 00:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709626021; x=1710230821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FjEV1yFnENl5ezsytX07FAriwjPDghCBMypC8n+cEQ=;
        b=BgPtNp5r8AAhvYlwYnU1JRENWIWt97y0o9s1ZtFE/eBplSmlZpxVbH5xhs9cUwD4sr
         FWKYqd0xx2j3p7dZ06mM7Mld9cGmRhL+KrpLNHzpciGoh2SVN6ulUmRSFbtJ3He4Tya9
         p5pS1yyIFWxfH0kGbjuU1dhGsThDNehJOfGLz4/OKaMO7bpVx2nyvz48/vutw0GDIy2o
         zmA+ZEMKyZ7FM3Z34ALrH07vHm4vpZ/ho81NAGkIQLMmPmG+OpNde9FwvZ6TTSmq0GZV
         gaWUpb4lTAxV9Pbnr7kd4C9PjGtfkM6k0/CSKRoKNOBu5f4eISAQ23Llz5IUocxvVQgZ
         Hy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709626021; x=1710230821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FjEV1yFnENl5ezsytX07FAriwjPDghCBMypC8n+cEQ=;
        b=DDkTyb3NAK6e93wmTt0ssMfSaYI1Q/BGxHdDWDwAXVe9P6RpX8L5/Z7vtimPxq0NDD
         w4PcgDgS/gcOIY6eDxf9Ps/LDBkvyJeR79V34TVgZIWWU8zQkB8DffmDQqZyZ97XTAHE
         QAoLRdGcenu1TQm/+s22YgqXnn2GzElv6xvKKCclZr1bsjuNY430t2E/nf9DoCoJjB8E
         T59NYfbG13m7ZuSzrgqygtRpQI2bUqpKOJvzuuAzVMvcAkK9beVTpORUlPJu2RaEPzgX
         1OHSefUdq+wjOGCd3Tmq6P+mEu4gMuhfos7SKCDlIQQl/Dmyx5DOF77qj1rzXveyllju
         O0Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUqZvrMyQxs0cGRnvDOEBvEqkIX6R2vAuRDktP7FfA4CqMIpS9vXintmNAvENPP3EvgS8a8F3tDVFTt+3/rqrV7u9Xj38Bk1OxlYJMfS3Ad7QWF8xBxYfND7IuTO7r/0OAh3pfw8J5jjA==
X-Gm-Message-State: AOJu0Yw1H01Q9alO5DRVw0CVIifY4lT90l9g7+uS4l5pBkBruwBqO429
	Y5MqePCKFmc1LUKPzT4RT6wpOigG9Sh1hV554b7eJkYtA+NOWnwqj24F05p4NcCpmwQgfojNQma
	5VqTYAFmMYM2EVO3EFbVl9sRgJCsnhcJYwmgDWQ==
X-Google-Smtp-Source: AGHT+IGTD6AeTYnUSeTe7bxreiZpx7VX0g0xxZ5iFIGWUxPZP19fJcj1qLRa19PUeup6SLu0Wz3dPcjRvDf5R5OcatE=
X-Received: by 2002:a17:906:cc93:b0:a43:d473:685 with SMTP id
 oq19-20020a170906cc9300b00a43d4730685mr7793868ejb.38.1709626020356; Tue, 05
 Mar 2024 00:07:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com> <j3krazypdc7gsvnp4kcocaftxsbjrfhj6nr2kf2cieo4bjxbv7@bqdfbirk5tei>
In-Reply-To: <j3krazypdc7gsvnp4kcocaftxsbjrfhj6nr2kf2cieo4bjxbv7@bqdfbirk5tei>
From: Alexey Charkov <alchark@gmail.com>
Date: Tue, 5 Mar 2024 12:06:48 +0400
Message-ID: <CABjd4Yxs9b0XDXYfdnmT08BQnsJLonRy4X-g73J67yeGw3xL+w@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] RK3588 and Rock 5B dts additions: thermal, OPP and fan
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Dragan Simic <dsimic@manjaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Chen-Yu Tsai <wens@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sebastian!

On Mon, Mar 4, 2024 at 9:51=E2=80=AFPM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On Thu, Feb 29, 2024 at 11:26:31PM +0400, Alexey Charkov wrote:
> > This enables thermal monitoring and CPU DVFS on RK3588(s), as well as
> > active cooling on Radxa Rock 5B via the provided PWM fan.
> >
> > Some RK3588 boards use separate regulators to supply CPUs and their
> > respective memory interfaces, so this is handled by coupling those
> > regulators in affected boards' device trees to ensure that their
> > voltage is adjusted in step.
> >
> > In this revision of the series I chose to enable TSADC for all boards
> > at .dtsi level, because:
> >  - The defaults already in .dtsi should work for all users, given that
> >    the CRU based resets don't need any out-of-chip components, and
> >    the CRU vs. PMIC reset is pretty much the only thing a board might
> >    have to configure / override there
> >  - The boards that have TSADC_SHUT signal wired to the PMIC reset line
> >    can still choose to override the reset logic in their .dts. Or stay
> >    with CRU based resets, as downstream kernels do anyway
> >  - The on-by-default approach helps ensure thermal protections are in
> >    place (emergency reset and throttling) for any board even with a
> >    rudimentary .dts, and thus lets us introduce CPU DVFS with better
> >    peace of mind
> >
> > Fan control on Rock 5B has been split into two intervals: let it spin
> > at the minimum cooling state between 55C and 65C, and then accelerate
> > if the system crosses the 65C mark - thanks to Dragan for suggesting.
> > This lets some cooling setups with beefier heatsinks and/or larger
> > fan fins to stay in the quietest non-zero fan state while still
> > gaining potential benefits from the airflow it generates, and
> > possibly avoiding noisy speeds altogether for some workloads.
> >
> > OPPs help actually scale CPU frequencies up and down for both cooling
> > and performance - tested on Rock 5B under varied loads. I've split
> > the patch into two parts: the first containing those OPPs that seem
> > to be no-regret with general consensus during v1 review [2], while
> > the second contains OPPs that cause frequency reductions without
> > accompanying decrease in CPU voltage. There seems to be a slight
> > performance gain in some workload scenarios when using these, but
> > previous discussion was inconclusive as to whether they should be
> > included or not. Having them as separate patches enables easier
> > comparison and partial reversion if people want to test it under
> > their workloads, and also enables the first 'no-regret' part to be
> > merged to -next while the jury is still out on the second one.
> >
> > [1] https://lore.kernel.org/linux-rockchip/1824717.EqSB1tO5pr@bagend/T/=
#ma2ab949da2235a8e759eab22155fb2bc397d8aea
> > [2] https://lore.kernel.org/linux-rockchip/CABjd4YxqarUCbZ-a2XLe3TWJ-qj=
phGkyq=3DwDnctnEhdoSdPPpw@mail.gmail.com/T/#m49d2b94e773f5b532a0bb5d3d76647=
99ff28cc2c
> >
> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > ---
> > Changes in v3:
> > - Added regulator coupling for EVB1 and QuartzPro64
> > - Enabled the TSADC for all boards in .dtsi, not just Rock 5B (thanks C=
henYu)
> > - Added comments regarding two passive cooling trips in each zone (than=
ks Dragan)
> > - Fixed active cooling map numbering for Radxa Rock 5B (thanks Dragan)
> > - Dropped Daniel's Acked-by tag from the Rock 5B fan patch, as there's =
been quite some
> >   churn there since the version he acknowledged
> > - Link to v2: https://lore.kernel.org/r/20240130-rk-dts-additions-v2-0-=
c6222c4c78df@gmail.com
> >
> > Changes in v2:
> > - Dropped the rfkill patch which Heiko has already applied
> > - Set higher 'polling-delay-passive' (100 instead of 20)
> > - Name all cooling maps starting from map0 in each respective zone
> > - Drop 'contribution' properties from passive cooling maps
> > - Link to v1: https://lore.kernel.org/r/20240125-rk-dts-additions-v1-0-=
5879275db36f@gmail.com
> >
> > ---
> > Alexey Charkov (5):
> >       arm64: dts: rockchip: enable built-in thermal monitoring on RK358=
8
> >       arm64: dts: rockchip: enable automatic active cooling on Rock 5B
> >       arm64: dts: rockchip: Add CPU/memory regulator coupling for RK358=
8
> >       arm64: dts: rockchip: Add OPP data for CPU cores on RK3588
> >       arm64: dts: rockchip: Add further granularity in RK3588 CPU OPPs
> >
> >  arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts   |  12 +
> >  .../arm64/boot/dts/rockchip/rk3588-quartzpro64.dts |  12 +
> >  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts    |  30 +-
> >  arch/arm64/boot/dts/rockchip/rk3588s.dtsi          | 385 +++++++++++++=
+++++++-
> >  4 files changed, 437 insertions(+), 2 deletions(-)
>
> I'm too busy to have a detailed review of this series right now, but
> I pushed it to our CI and it results in a board reset at boot time:
>
> https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/jo=
bs/300950
>
> I also pushed just the first three patches (i.e. without OPP /
> cpufreq) and that boots fine:
>
> https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/jo=
bs/300953

Thank you for testing these! I've noticed in the boot log that the CI
machine uses some u-boot 2023.07 - is that a downstream one? Any
chance to compare it to 2023.11 or 2024.01 from your (Collabora)
integration tree?

I use 2023.11 from your integration tree, with a binary bl31, and I'm
not getting those resets even under prolonged heavy load (I rebuild
Chromium with 8 concurrent compilation jobs as the stress test -
that's 14 hours of heavy CPU, memory and IO use). Would be interesting
to understand if it's just a 'lucky' SoC specimen on my side, or if
there is some dark magic happening differently on my machine vs. your
CI machine.

Thinking that maybe if your CI machine uses a downstream u-boot it
might be leaving some extra hardware running (PVTM?) which might do
weird stuff when TSADC/clocks/voltages get readjusted by the generic
cpufreq driver?..

> Note, that OPP / cpufreq works on the same boards in the CI when
> using the ugly-and-not-for-upstream cpufreq driver:
>
> https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/co=
mmit/9c90c5032743a0419bf3fd2f914a24fd53101acd
>
> My best guess right now is, that this is related to the generic
> driver obviously not updating the GRF read margin registers.

If it was about memory read margins I believe I would have been
unlikely to get my machine to work reliably under heavy load with the
default ones, but who knows...

Best regards,
Alexey

