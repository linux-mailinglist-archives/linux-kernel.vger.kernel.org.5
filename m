Return-Path: <linux-kernel+bounces-128907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8CA8961BD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29CE8289762
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2FEFC0C;
	Wed,  3 Apr 2024 01:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=thefossguy.com header.i=@thefossguy.com header.b="TZre1Pda"
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C624DDC3;
	Wed,  3 Apr 2024 01:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712106199; cv=none; b=mecIfPlYEo8ypBh/dzf7qT5A4f32uLc3H4z+24k9mdss+2ctZQYd+CrxAiQs6XhUz+iOdUxWuxcNVin6fvauDs4/h8XM1Xd6Sgy2TCJ5F78nKb1bvKkFhBSSMOOoLDcnhtUoMXIF9hUib3OBOsDaX9VYf5an2A8mlwTdrIU8CW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712106199; c=relaxed/simple;
	bh=AOZHdUFBAbZLCmK2+LKYvUtaym4XNZbYFlXQzqVeLzo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BK5TTL+p18Ir7vgrOzONX6Uj47K0fHkrw/3y9Zxz7xuTZXNuSRLf5mzveQCwYd0exMnv01t83RAbajYI4X37Owm8NmR61ctfsHgPKP9NC4k/R1hK/xpNViO09DQtMWbBnMfIk/wTxyW3xqZffGGcH2ldbwktfyNxmH4ksaRe7sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thefossguy.com; spf=pass smtp.mailfrom=thefossguy.com; dkim=pass (2048-bit key) header.d=thefossguy.com header.i=@thefossguy.com header.b=TZre1Pda; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thefossguy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thefossguy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thefossguy.com;
	s=protonmail; t=1712106195; x=1712365395;
	bh=nHxcYCHNMSfzwkXGRERFhLW2wEH2xIMrQxurqp9tbRI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=TZre1PdaZbND18eFBwwhyDtGirzYl/imTukmyF5tJw/SWpeZF0Zydt4e3s1+WF5jv
	 FqVbQdH/ZEU+skT79DAlhwwftq4iSIlaWZJtRopHGcnCVWul9SFAaqOhj18UPFVWi/
	 0vTW5Dh70G9iG4GtntujilYBF41ArOy22rYr1aLtvCF/eZILe/r/7zHXsv2N7VHWAo
	 N8jnBhlpmwt14ds5H/ZC+3CnaWaajNEnnSLPJ2FGsOfPgzmmjVt8O/cJxzd3XPfuBt
	 CGYis613tXuVjpgBAQ/PZUadsWrQPgBpQ7U8+m0zS7Foyu5vXGBkdZLRyrGSIPWWYb
	 +xa/PhPqMHJdQ==
Date: Wed, 03 Apr 2024 01:03:07 +0000
To: Saravana Kannan <saravanak@google.com>
From: Pratham Patel <prathampatel@thefossguy.com>
Cc: Dragan Simic <dsimic@manjaro.org>, sebastian.reichel@collabora.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: Fixing the devicetree of Rock 5 Model B (and possibly others)
Message-ID: <D0A2ZL6S8UG6.2BQKIBQWYB36D@thefossguy.com>
In-Reply-To: <CAGETcx_ToHsp_c+Yt0qqST4Zd-GC7dPn_j=PpB1n1xpZtOnMfg@mail.gmail.com>
References: <tQ0L3-34g4t-mzfQIP6KDe5OYelGnEo6Udzq6Kb_nEcljppSQUXOktpE__nL-CdLOu9gW-4tIIbjtSbqrdCrjEkdhZLPiiHTqRcCB6WORuM=@thefossguy.com> <ac4246bf3786230eb9ca85b329e7d0df@manjaro.org> <CAGETcx89V5CJrAq6XwuGiusQnkR804pTgYAtS94v7Q+v=Cv+qA@mail.gmail.com> <D0A122WK7CB9.33B2TP6UCMJBJ@thefossguy.com> <CAGETcx_ToHsp_c+Yt0qqST4Zd-GC7dPn_j=PpB1n1xpZtOnMfg@mail.gmail.com>
Feedback-ID: 104309535:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Apr 3, 2024 at 6:16 AM IST, Saravana Kannan wrote:
> On Tue, Apr 2, 2024 at 4:32=E2=80=AFPM Pratham Patel
> <prathampatel@thefossguy.com> wrote:
> >
> > On Tue Apr 2, 2024 at 4:54 AM IST, Saravana Kannan wrote:
> > > On Sat, Mar 23, 2024 at 10:10=E2=80=AFAM Dragan Simic <dsimic@manjaro=
org> wrote:
> > > >
> > > > Hello Pratham,
> > > >
> > > > On 2024-03-23 18:02, Pratham Patel wrote:
> > > > > I looked at the patch and tried several things, neither resulted =
in
> > > > > anything that would point me to the core issue. Then I tried this=
:
> > > >
> > > > Could you, please, clarify a bit what's the actual issue you're
> > > > experiencing on your Rock 5B?
> > >
> > > Pratham, can you reply to this please? I don't really understand what
> > > your issue is for me to be able to help.
> >
> > Hi,
> >
> > I apologize for not replying. Somehow, I did not notice the reply from
> > Dragan. :(
> >
> > Since this patch was applied, an issue in the Rock 5B's DT has been
> > unearthed which now results in the kernel being unable to boot properly=
.
> >
> > Following is the relevant call trace from the UART capture:
> >
> > [   21.595068] Call trace:
> > [   21.595288]  smp_call_function_many_cond+0x174/0x5f8
> > [   21.595728]  on_each_cpu_cond_mask+0x2c/0x40
> > [   21.596109]  cpuidle_register_driver+0x294/0x318
> > [   21.596524]  cpuidle_register+0x24/0x100
> > [   21.596875]  psci_cpuidle_probe+0x2e4/0x490
> > [   21.597247]  platform_probe+0x70/0xd0
> > [   21.597575]  really_probe+0x18c/0x3d8
> > [   21.597905]  __driver_probe_device+0x84/0x180
> > [   21.598294]  driver_probe_device+0x44/0x120
> > [   21.598669]  __device_attach_driver+0xc4/0x168
> > [   21.599063]  bus_for_each_drv+0x8c/0xf0
> > [   21.599408]  __device_attach+0xa4/0x1c0
> > [   21.599748]  device_initial_probe+0x1c/0x30
> > [   21.600118]  bus_probe_device+0xb4/0xc0
> > [   21.600462]  device_add+0x68c/0x888
> > [   21.600775]  platform_device_add+0x19c/0x270
> > [   21.601154]  platform_device_register_full+0xdc/0x178
> > [   21.601602]  psci_idle_init+0xa0/0xc8
> > [   21.601934]  do_one_initcall+0x60/0x290
> > [   21.602275]  kernel_init_freeable+0x20c/0x3e0
> > [   21.602664]  kernel_init+0x2c/0x1f8
> > [   21.602979]  ret_from_fork+0x10/0x20
>
> This doesn't make a lot of sense. "remote-endpoint" shouldn't be
> related to anything to do with psci cpuidle. I'm guessing something
> else is failing much earlier in boot that's indirectly causing this
> somehow? Can you please take a look at what's failing earlier and let
> us know? Or see what driver probe is failing up to this point but used
> to work in the good case.

I'm pretty new to this, "just starting". I'm not sure how to do that,
since the kernel doesn't really "move forward". I will verify if
a8037ceb8964 fixes it or not and get back by the end of this week.

> Also, where is the dts file that corresponds to this board in upstream? I=
s it
> arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts

Yes.

> >
> > > Also, can you give the output of <debugfs>/devices_deferred for the
> > > good vs bad case?
> >
> > I can't provide you with requested output from the bad case, since the
> > kernel never moves past this to an initramfs rescue shell, but followin=
g
> > is the output from v6.8.1 (**with aforementioned patch reverted**).
> >
> > # cat /sys/kernel/debug/devices_deferred
> > fc400000.usb    platform: wait for supplier /phy@fed90000/usb3-port
> > 1-0022  typec_fusb302: cannot register tcpm port
> > fc000000.usb    platform: wait for supplier /phy@fed80000/usb3-port
> >
> > It seems that v6.8.2 works _without needing to revert the patch_. I wil=
l
> > have to look into this sometime this week but it seems like
> > a8037ceb8964 (arm64: dts: rockchip: drop rockchip,trcm-sync-tx-only fro=
m rk3588 i2s)
> > seems to be the one that fixed the root issue. I will have to test it
> > sometime later this week.
>
> Ok, once you find the patch that fixes things, let me know too.

Will do!

 -- Pratham Patel


