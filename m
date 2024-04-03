Return-Path: <linux-kernel+bounces-130088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1198973F0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDAD51C22DC9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C13C14A0A2;
	Wed,  3 Apr 2024 15:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thefossguy.com header.i=@thefossguy.com header.b="mIu1yPYh"
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4226F148FE8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712158017; cv=none; b=HQHw/QWoc/CDpc4qmf3PvUBp5YyPQzRu7G5wiirk2O7Uj3xMTFtWant5G0FBTjL2iEFmMEZ6WbvPEtC6Xgw/toEbdQoZnT5diGql6ufRVnjpDGG5dtyjNkAAr/m2Al0tY7TwHfvxGkbpycW1URXyIFHKQi74b4I8RL9I78YHuIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712158017; c=relaxed/simple;
	bh=Z7bkTgkUMCbu64k/VOOsbCpZzTWGIgZdwpQsRWq5X3A=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=G6HEYqJFQ1iSq97hW6BUld/ngKQw06aHfw5apa2qPFisYW0JZRYqSfs8YJd6T+qDcJa0A4pT0FtGbQt7Dh4HdBIDl0+H7kofExbWwsxmMBmL53w/dom3gzDUrpR7Vr+6jIDhMZfRaJHFaXtdZTXrgCoJwCjEOjwMOhCmD0ruIkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thefossguy.com; spf=pass smtp.mailfrom=thefossguy.com; dkim=pass (2048-bit key) header.d=thefossguy.com header.i=@thefossguy.com header.b=mIu1yPYh; arc=none smtp.client-ip=185.70.40.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thefossguy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thefossguy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thefossguy.com;
	s=protonmail; t=1712158011; x=1712417211;
	bh=9SQXRgCUecFeWBFD17xwAybx00ZfUI80tkTt7oEpgbI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=mIu1yPYh/SOnPiPmfVQR14NLuXoTecAhyJ/uF7ffGscpgsXDkMJC3hEm7La/4034R
	 bpc1LYk2unCxUXeq64HUDzDoBB6XEidI2YoKgij6T8unAAu4Z8Q9fLzAlnZXWT6+Ut
	 IEho6xr3UisETLI5ymHomXVD7rS7rnaRGPLKiuuVHEvkTh+a84zX/YkGgtZhMpJXO8
	 UAoHc47elTv7sNf3LqD+s7eN4wHBRDtYl2xiMBDItM+Q+nGKkyayRNB6AcIX2WFq7U
	 kw58Zu4myk6mAjyRVgjFz3gZsRbg692KNeQqfYOVr7Ta35HUAtS92kRpVh97RgmNij
	 wpN+qWpcPXNRQ==
Date: Wed, 03 Apr 2024 15:26:44 +0000
To: Sebastian Reichel <sebastian.reichel@collabora.com>
From: Pratham Patel <prathampatel@thefossguy.com>
Cc: Saravana Kannan <saravanak@google.com>, Dragan Simic <dsimic@manjaro.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: Fixing the devicetree of Rock 5 Model B (and possibly others)
Message-ID: <D0ALCT8IOMGQ.105ELHD701M4F@thefossguy.com>
Feedback-ID: 104309535:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Apr 3, 2024 at 7:22 PM IST, Sebastian Reichel wrote:
> Hi,
>
> On Wed, Apr 03, 2024 at 01:03:07AM +0000, Pratham Patel wrote:
> > > > > Also, can you give the output of <debugfs>/devices_deferred for t=
he
> > > > > good vs bad case?
> > > >
> > > > I can't provide you with requested output from the bad case, since =
the
> > > > kernel never moves past this to an initramfs rescue shell, but foll=
owing
> > > > is the output from v6.8.1 (**with aforementioned patch reverted**).
> > > >
> > > > # cat /sys/kernel/debug/devices_deferred
> > > > fc400000.usb    platform: wait for supplier /phy@fed90000/usb3-port
> > > > 1-0022  typec_fusb302: cannot register tcpm port
> > > > fc000000.usb    platform: wait for supplier /phy@fed80000/usb3-port
> > > >
> > > > It seems that v6.8.2 works _without needing to revert the patch_. I=
 will
> > > > have to look into this sometime this week but it seems like
> > > > a8037ceb8964 (arm64: dts: rockchip: drop rockchip,trcm-sync-tx-only=
 from rk3588 i2s)
> > > > seems to be the one that fixed the root issue. I will have to test =
it
> > > > sometime later this week.
> > >
> > > Ok, once you find the patch that fixes things, let me know too.
> >
> > Will do!
>
> FWIW the v6.8.1 kernel referenced above is definitely patched, since
> upstream's Rock 5B DT does neither describe fusb302, nor the USB
> port it is connected to.
>
> We have a few Rock 5B in Kernel CI and upstream boots perfectly
> fine:
>
> https://lava.collabora.dev/scheduler/device_type/rk3588-rock-5b

Hmm, weird then. I can confirm that v6.8.1 doesn't _always_ boot. It
boots some times but still fails a majority of times. There is a
2 out of 10 chance that v6.8.1 will not boot. If you keep rebooting
enough times, you might get it to boot but the next boot is
likely to be borked. :(

That said, v6.8.2 might still have the same issue, but the probably of a
failed boot might be _lesser_ than v6.8.1 (from what I saw). I will
verify that behaviour sometime tomorrow or day after tomorrow.

>
> So it could be one of your downstream patches, which is introducing
> this problem.

I thought so too. So I built a vanilla kernel from the release tarball
of v6.8.1, using GCC + arm64 defconfig. I also tried using LLVM just in
case but noticed the same result.

 -- Pratham Patel


