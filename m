Return-Path: <linux-kernel+bounces-132656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9308997DD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD011F22CE9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE742156F2C;
	Fri,  5 Apr 2024 08:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thefossguy.com header.i=@thefossguy.com header.b="tM5Z4qbO"
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8186D156F3D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 08:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712305943; cv=none; b=rmRPTcmmciYlaj5y7wuTzNryDJK1BY1IyBEpUZ+CtC0fpYEO1pL+b/IjlKqtTUJAYoA1YM2sECB2TjPZMOjJm637x/EwhB65QTmdvDh6AYrESij9uyg5lk4zyT0OGjHYhnwp1gENk2PgxA3bobzj0BG/dAomxdSWg2wrm3aXrX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712305943; c=relaxed/simple;
	bh=NALxV+zs5Tnjgphk/TpkK7zxaU7vpIhcOCwZW6f35is=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tetk+9MXEFLREQwqQ/Z4ymcUe1RMbvGWc12v4ijH0XcWXRAidVS9N/7m8e1sBAUgOw8w8ucmHXv0SZtdQ1SjRsb37X/Eg4ni8TLEV2AeHkrA9HjWWfvUHfkHXUZEq4D+cHcs/W9stE4jH9Aj2Pe6qcuY6yGwL92wSxn3s9YsPxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thefossguy.com; spf=pass smtp.mailfrom=thefossguy.com; dkim=pass (2048-bit key) header.d=thefossguy.com header.i=@thefossguy.com header.b=tM5Z4qbO; arc=none smtp.client-ip=185.70.40.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thefossguy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thefossguy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thefossguy.com;
	s=protonmail; t=1712305932; x=1712565132;
	bh=NALxV+zs5Tnjgphk/TpkK7zxaU7vpIhcOCwZW6f35is=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=tM5Z4qbOnuDyhJmzm7Iqonyk3hz9cJ1q0eVMFcprGM5Adx5wfRTd2MSQgRoIB16k4
	 wCJD5FWeZv2sph+EMZPLCBWYwPbz3MIo7p7LnOwstEw1xX6Tn62LTm2yWtjcJ2Mvwh
	 IE3R2EEVAaF5mQKAyTeClc1l6JctSa8QcHOFHpOqv17HOodFID44p7mHbm6Qs0RjSa
	 xjjRoGuoJRxhy6fCcYFs3hoSdqxtQSUDUnrhIdNvVw4K20l37hgLJnJSXaXxQQAoKN
	 wsEn21ph5v9wM2SpHo/DmZW5Xu8sd8dOFyaw0KUv94Gz6DHVXj9I1A6QEmhNWvVm8A
	 TMX4k9EP74VUw==
Date: Fri, 05 Apr 2024 08:32:08 +0000
To: Saravana Kannan <saravanak@google.com>
From: Pratham Patel <prathampatel@thefossguy.com>
Cc: Dragan Simic <dsimic@manjaro.org>, sebastian.reichel@collabora.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: Fixing the devicetree of Rock 5 Model B (and possibly others)
Message-ID: <Z6J7NF8AKNHDzwd1lbld1obVJZrKq0UKLSzKVtoL0TmOzpdyM8PRMvel8IUyhwsphxBg1bjku4ZaeQcwMhfKagEM2lRYtMChYv6VNPK5Tvg=@thefossguy.com>
In-Reply-To: <D0A2ZL6S8UG6.2BQKIBQWYB36D@thefossguy.com>
References: <tQ0L3-34g4t-mzfQIP6KDe5OYelGnEo6Udzq6Kb_nEcljppSQUXOktpE__nL-CdLOu9gW-4tIIbjtSbqrdCrjEkdhZLPiiHTqRcCB6WORuM=@thefossguy.com> <ac4246bf3786230eb9ca85b329e7d0df@manjaro.org> <CAGETcx89V5CJrAq6XwuGiusQnkR804pTgYAtS94v7Q+v=Cv+qA@mail.gmail.com> <D0A122WK7CB9.33B2TP6UCMJBJ@thefossguy.com> <CAGETcx_ToHsp_c+Yt0qqST4Zd-GC7dPn_j=PpB1n1xpZtOnMfg@mail.gmail.com> <D0A2ZL6S8UG6.2BQKIBQWYB36D@thefossguy.com>
Feedback-ID: 104309535:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, April 3rd, 2024 at 06:33, Pratham Patel <prathampatel@thefoss=
guy.com> wrote:

>=20
>=20
> On Wed Apr 3, 2024 at 6:16 AM IST, Saravana Kannan wrote:
>=20
> > On Tue, Apr 2, 2024 at 4:32=E2=80=AFPM Pratham Patel
> > prathampatel@thefossguy.com wrote:
> >=20
> > > On Tue Apr 2, 2024 at 4:54 AM IST, Saravana Kannan wrote:
> > >=20
> > > > On Sat, Mar 23, 2024 at 10:10=E2=80=AFAM Dragan Simic dsimic@manjar=
o.org wrote:
> > > >=20
> > > > > Hello Pratham,
> > > > >=20
> > > > > On 2024-03-23 18:02, Pratham Patel wrote:
> > > > >=20
> > > > > > I looked at the patch and tried several things, neither resulte=
d in
> > > > > > anything that would point me to the core issue. Then I tried th=
is:
> > > > >=20
> > > > > Could you, please, clarify a bit what's the actual issue you're
> > > > > experiencing on your Rock 5B?
> > > >=20
> > > > Pratham, can you reply to this please? I don't really understand wh=
at
> > > > your issue is for me to be able to help.
> > >=20
> > > Hi,
> > >=20
> > > I apologize for not replying. Somehow, I did not notice the reply fro=
m
> > > Dragan. :(
> > >=20
> > > Since this patch was applied, an issue in the Rock 5B's DT has been
> > > unearthed which now results in the kernel being unable to boot proper=
ly.
> > >=20
> > > Following is the relevant call trace from the UART capture:
> > >=20
> > > [ 21.595068] Call trace:
> > > [ 21.595288] smp_call_function_many_cond+0x174/0x5f8
> > > [ 21.595728] on_each_cpu_cond_mask+0x2c/0x40
> > > [ 21.596109] cpuidle_register_driver+0x294/0x318
> > > [ 21.596524] cpuidle_register+0x24/0x100
> > > [ 21.596875] psci_cpuidle_probe+0x2e4/0x490
> > > [ 21.597247] platform_probe+0x70/0xd0
> > > [ 21.597575] really_probe+0x18c/0x3d8
> > > [ 21.597905] __driver_probe_device+0x84/0x180
> > > [ 21.598294] driver_probe_device+0x44/0x120
> > > [ 21.598669] __device_attach_driver+0xc4/0x168
> > > [ 21.599063] bus_for_each_drv+0x8c/0xf0
> > > [ 21.599408] __device_attach+0xa4/0x1c0
> > > [ 21.599748] device_initial_probe+0x1c/0x30
> > > [ 21.600118] bus_probe_device+0xb4/0xc0
> > > [ 21.600462] device_add+0x68c/0x888
> > > [ 21.600775] platform_device_add+0x19c/0x270
> > > [ 21.601154] platform_device_register_full+0xdc/0x178
> > > [ 21.601602] psci_idle_init+0xa0/0xc8
> > > [ 21.601934] do_one_initcall+0x60/0x290
> > > [ 21.602275] kernel_init_freeable+0x20c/0x3e0
> > > [ 21.602664] kernel_init+0x2c/0x1f8
> > > [ 21.602979] ret_from_fork+0x10/0x20
> >=20
> > This doesn't make a lot of sense. "remote-endpoint" shouldn't be
> > related to anything to do with psci cpuidle. I'm guessing something
> > else is failing much earlier in boot that's indirectly causing this
> > somehow? Can you please take a look at what's failing earlier and let
> > us know? Or see what driver probe is failing up to this point but used
> > to work in the good case.
>=20
>=20
> I'm pretty new to this, "just starting". I'm not sure how to do that,
> since the kernel doesn't really "move forward". I will verify if
> a8037ceb8964 fixes it or not and get back by the end of this week.
>=20
> > Also, where is the dts file that corresponds to this board in upstream?=
 Is it
> > arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>=20
>=20
> Yes.
>=20
> > > > Also, can you give the output of <debugfs>/devices_deferred for the
> > > > good vs bad case?
> > >=20
> > > I can't provide you with requested output from the bad case, since th=
e
> > > kernel never moves past this to an initramfs rescue shell, but follow=
ing
> > > is the output from v6.8.1 (with aforementioned patch reverted).
> > >=20
> > > # cat /sys/kernel/debug/devices_deferred
> > > fc400000.usb platform: wait for supplier /phy@fed90000/usb3-port
> > > 1-0022 typec_fusb302: cannot register tcpm port
> > > fc000000.usb platform: wait for supplier /phy@fed80000/usb3-port
> > >=20
> > > It seems that v6.8.2 works without needing to revert the patch. I wil=
l
> > > have to look into this sometime this week but it seems like
> > > a8037ceb8964 (arm64: dts: rockchip: drop rockchip,trcm-sync-tx-only f=
rom rk3588 i2s)
> > > seems to be the one that fixed the root issue. I will have to test it
> > > sometime later this week.
> >=20
> > Ok, once you find the patch that fixes things, let me know too.

I confirm that a8037ceb8964 fixed this issue for me. Now, v6.8.2+ boots on =
my Rock 5B,
with my distro's config and the arm64 defconfig.

 -- Pratham Patel

