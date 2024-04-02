Return-Path: <linux-kernel+bounces-128832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B77896032
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B285B1C22C7F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6735D4E1CE;
	Tue,  2 Apr 2024 23:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thefossguy.com header.i=@thefossguy.com header.b="jiJebc2i"
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5E9446B6
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 23:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712100757; cv=none; b=GW6hFsi05lr2w9Ihd90hh/bEOQClYBlbZ7RsEC8x3zjpK2tkEq9jCvseOO/8n4Ib65W3h3XftcEhnNmWnFFWX2Xz8iKavBW3Uh4RxUNBgzKvMkWnk4fOMkZZbwzTNAk0BD59G7qlVQpc4bjr888Ik3nZl6lNpkYbWySCt0nesPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712100757; c=relaxed/simple;
	bh=Miy8h+46r9L1yli6HXvFolWZmx7sqZ1TBD8yhEMAhbg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sLULCfNOhre2bTKQw1lxPmSV+z2nxpjsXtj5c//9yg3Klsao5JS49izGI6BQ+S2hDlzFoozLtYVMaY6yu5ZqHdLLH4KHcXyIrMCkwHZA1UKBfTl61QZ/8UCz4HI4bCzpAR+FjjWCffYJca21JfmMjk+UBazA7OpauoCGuLZZAX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thefossguy.com; spf=pass smtp.mailfrom=thefossguy.com; dkim=pass (2048-bit key) header.d=thefossguy.com header.i=@thefossguy.com header.b=jiJebc2i; arc=none smtp.client-ip=185.70.40.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thefossguy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thefossguy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thefossguy.com;
	s=protonmail; t=1712100746; x=1712359946;
	bh=eYfJr8KvAv/8O8BAWI9vNpWVyP4tpL6uvttbF+aIVu4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=jiJebc2iTvQ7DqOGLbq51xyXRi2Fq7r/KJfvy/87mOd0Q3kz5GOdh5yR0T5/6r0xt
	 9/eNq3T+lJk4ongASmJANrlCUliuVgdo3nKQn6TFJ4j09ZJF927p0HVx5Y/g6qsrr8
	 4gpXnqaAealF68SfLtAH5CFJQ99uRiwHG9RSTjqjLJ6G7m9J33/vh6W1bAC+3O7iy6
	 GRet7xPum1GiyuF+pHJ4HhLW5XqkJfUTZoOA3bRrY0yNn9OMw7/Q9OeKIZh/u8HmJn
	 rhaZRUfbMjYtMApSBWSv+yAnqxU6RoPO46G1xtHwkFjtVqO9tVQyD4hp0ZQKS1J9qn
	 /XfTWWMaA7CxQ==
Date: Tue, 02 Apr 2024 23:32:19 +0000
To: Saravana Kannan <saravanak@google.com>, Dragan Simic <dsimic@manjaro.org>
From: Pratham Patel <prathampatel@thefossguy.com>
Cc: sebastian.reichel@collabora.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: Fixing the devicetree of Rock 5 Model B (and possibly others)
Message-ID: <D0A122WK7CB9.33B2TP6UCMJBJ@thefossguy.com>
In-Reply-To: <CAGETcx89V5CJrAq6XwuGiusQnkR804pTgYAtS94v7Q+v=Cv+qA@mail.gmail.com>
References: <tQ0L3-34g4t-mzfQIP6KDe5OYelGnEo6Udzq6Kb_nEcljppSQUXOktpE__nL-CdLOu9gW-4tIIbjtSbqrdCrjEkdhZLPiiHTqRcCB6WORuM=@thefossguy.com> <ac4246bf3786230eb9ca85b329e7d0df@manjaro.org> <CAGETcx89V5CJrAq6XwuGiusQnkR804pTgYAtS94v7Q+v=Cv+qA@mail.gmail.com>
Feedback-ID: 104309535:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Apr 2, 2024 at 4:54 AM IST, Saravana Kannan wrote:
> On Sat, Mar 23, 2024 at 10:10=E2=80=AFAM Dragan Simic <dsimic@manjaro.org=
> wrote:
> >
> > Hello Pratham,
> >
> > On 2024-03-23 18:02, Pratham Patel wrote:
> > > I looked at the patch and tried several things, neither resulted in
> > > anything that would point me to the core issue. Then I tried this:
> >
> > Could you, please, clarify a bit what's the actual issue you're
> > experiencing on your Rock 5B?
>
> Pratham, can you reply to this please? I don't really understand what
> your issue is for me to be able to help.

Hi,

I apologize for not replying. Somehow, I did not notice the reply from
Dragan. :(

Since this patch was applied, an issue in the Rock 5B's DT has been
unearthed which now results in the kernel being unable to boot properly.

Following is the relevant call trace from the UART capture:

[   21.595068] Call trace:
[   21.595288]  smp_call_function_many_cond+0x174/0x5f8
[   21.595728]  on_each_cpu_cond_mask+0x2c/0x40
[   21.596109]  cpuidle_register_driver+0x294/0x318
[   21.596524]  cpuidle_register+0x24/0x100
[   21.596875]  psci_cpuidle_probe+0x2e4/0x490
[   21.597247]  platform_probe+0x70/0xd0
[   21.597575]  really_probe+0x18c/0x3d8
[   21.597905]  __driver_probe_device+0x84/0x180
[   21.598294]  driver_probe_device+0x44/0x120
[   21.598669]  __device_attach_driver+0xc4/0x168
[   21.599063]  bus_for_each_drv+0x8c/0xf0
[   21.599408]  __device_attach+0xa4/0x1c0
[   21.599748]  device_initial_probe+0x1c/0x30
[   21.600118]  bus_probe_device+0xb4/0xc0
[   21.600462]  device_add+0x68c/0x888
[   21.600775]  platform_device_add+0x19c/0x270
[   21.601154]  platform_device_register_full+0xdc/0x178
[   21.601602]  psci_idle_init+0xa0/0xc8
[   21.601934]  do_one_initcall+0x60/0x290
[   21.602275]  kernel_init_freeable+0x20c/0x3e0
[   21.602664]  kernel_init+0x2c/0x1f8
[   21.602979]  ret_from_fork+0x10/0x20

> Also, can you give the output of <debugfs>/devices_deferred for the
> good vs bad case?

I can't provide you with requested output from the bad case, since the
kernel never moves past this to an initramfs rescue shell, but following
is the output from v6.8.1 (**with aforementioned patch reverted**).

# cat /sys/kernel/debug/devices_deferred
fc400000.usb    platform: wait for supplier /phy@fed90000/usb3-port
1-0022  typec_fusb302: cannot register tcpm port
fc000000.usb    platform: wait for supplier /phy@fed80000/usb3-port

It seems that v6.8.2 works _without needing to revert the patch_. I will
have to look into this sometime this week but it seems like
a8037ceb8964 (arm64: dts: rockchip: drop rockchip,trcm-sync-tx-only from rk=
3588 i2s)
seems to be the one that fixed the root issue. I will have to test it
sometime later this week.

 -- Pratham Patel


