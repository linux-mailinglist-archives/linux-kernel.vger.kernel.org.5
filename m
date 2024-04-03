Return-Path: <linux-kernel+bounces-129883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC8689719B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C651C22D6A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD23B148839;
	Wed,  3 Apr 2024 13:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="GiS2zBBT"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B981487CB;
	Wed,  3 Apr 2024 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152301; cv=none; b=eO6Cntb25P7Mk7OyRRTqamJi3DpItzEl4cysMF7T21evIsaG1ZKmtk+wXOBZIR9W1r+Yjn/eUOz58Qg360Eai4fGd0rkHzW4idFzJIdtmRlbt2KulOY+CRMMujtaivq0xUh+26q8xDGofCYqVYL2HRFOM6U8l+ctMsCY9wZ4jrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152301; c=relaxed/simple;
	bh=Bsd6ob511k3QYVp8+Jssqa3MiM5VrfAAPII3Y9YU9H8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=FwUuMS2HKzPSla7NwoBvETp4eBv0JQuLRnI7Nrm/nweApFK9fXUDm9DTSJAGdN698r7HWygTJutokrRDIrvwV1tP4kBLt6eFm9wB4o84KPIHzsnoqMUt67w+EfacvzV/G9Do18E2xzsjGRyO01eZWI3W5avd9LEoaGiyIwSxLKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=GiS2zBBT; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712152288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nG+giMXCItEPgMBqHyNixdKSn5F1WOll+iAb1XwFvHo=;
	b=GiS2zBBTYOl+k7jg3WvYCBgfq3wdoGR6VfB6hX8A5ejjfLhB0KkKtX0YgNLGLyaJcngEV5
	4GnPQ5SDj3QlLbF3AzrYfJavWLNADOc3g7ZB9JVlCpHOAcC3X35/Ex/vy7tIy4OoSyPRSl
	fLXc3sHfJl1cuoWv8fvAqWK4mg+8LcGVpwBVbmv1/ps0c7tNJHfj/Ual2sVy81QAle6J4i
	gH8DqM41H8hP+FbpDvTgWVpgHOsPp8h7EudBv5Ii2q9uYnmVwb0jWLaojgkjNMKdEYJeQk
	yEH5ELQNdi6ZhMv7Q6y6MUDZYLtvxH/k4PKaQFZ0YQ4eQwHJ7QGBMTkO9b8xeQ==
Date: Wed, 03 Apr 2024 15:51:28 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Pratham Patel <prathampatel@thefossguy.com>
Cc: Saravana Kannan <saravanak@google.com>, sebastian.reichel@collabora.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: Fixing the devicetree of Rock 5 Model B (and possibly others)
In-Reply-To: <D0A122WK7CB9.33B2TP6UCMJBJ@thefossguy.com>
References: <tQ0L3-34g4t-mzfQIP6KDe5OYelGnEo6Udzq6Kb_nEcljppSQUXOktpE__nL-CdLOu9gW-4tIIbjtSbqrdCrjEkdhZLPiiHTqRcCB6WORuM=@thefossguy.com>
 <ac4246bf3786230eb9ca85b329e7d0df@manjaro.org>
 <CAGETcx89V5CJrAq6XwuGiusQnkR804pTgYAtS94v7Q+v=Cv+qA@mail.gmail.com>
 <D0A122WK7CB9.33B2TP6UCMJBJ@thefossguy.com>
Message-ID: <0926eeecfec56fa9225a8aa2a319678a@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Pratham,

On 2024-04-03 01:32, Pratham Patel wrote:
> On Tue Apr 2, 2024 at 4:54 AM IST, Saravana Kannan wrote:
>> On Sat, Mar 23, 2024 at 10:10 AM Dragan Simic <dsimic@manjaro.org> 
>> wrote:
>> > On 2024-03-23 18:02, Pratham Patel wrote:
>> > > I looked at the patch and tried several things, neither resulted in
>> > > anything that would point me to the core issue. Then I tried this:
>> >
>> > Could you, please, clarify a bit what's the actual issue you're
>> > experiencing on your Rock 5B?
>> 
>> Pratham, can you reply to this please? I don't really understand what
>> your issue is for me to be able to help.
> 
> I apologize for not replying. Somehow, I did not notice the reply from
> Dragan. :(

No worries, I saw the serial console log file in one of your messages,
which actually provided the answer to my question. :)

> Since this patch was applied, an issue in the Rock 5B's DT has been
> unearthed which now results in the kernel being unable to boot 
> properly.
> 
> Following is the relevant call trace from the UART capture:
> 
> [   21.595068] Call trace:
> [   21.595288]  smp_call_function_many_cond+0x174/0x5f8
> [   21.595728]  on_each_cpu_cond_mask+0x2c/0x40
> [   21.596109]  cpuidle_register_driver+0x294/0x318
> [   21.596524]  cpuidle_register+0x24/0x100
> [   21.596875]  psci_cpuidle_probe+0x2e4/0x490
> [   21.597247]  platform_probe+0x70/0xd0
> [   21.597575]  really_probe+0x18c/0x3d8
> [   21.597905]  __driver_probe_device+0x84/0x180
> [   21.598294]  driver_probe_device+0x44/0x120
> [   21.598669]  __device_attach_driver+0xc4/0x168
> [   21.599063]  bus_for_each_drv+0x8c/0xf0
> [   21.599408]  __device_attach+0xa4/0x1c0
> [   21.599748]  device_initial_probe+0x1c/0x30
> [   21.600118]  bus_probe_device+0xb4/0xc0
> [   21.600462]  device_add+0x68c/0x888
> [   21.600775]  platform_device_add+0x19c/0x270
> [   21.601154]  platform_device_register_full+0xdc/0x178
> [   21.601602]  psci_idle_init+0xa0/0xc8
> [   21.601934]  do_one_initcall+0x60/0x290
> [   21.602275]  kernel_init_freeable+0x20c/0x3e0
> [   21.602664]  kernel_init+0x2c/0x1f8
> [   21.602979]  ret_from_fork+0x10/0x20
> 
>> Also, can you give the output of <debugfs>/devices_deferred for the
>> good vs bad case?
> 
> I can't provide you with requested output from the bad case, since the
> kernel never moves past this to an initramfs rescue shell, but 
> following
> is the output from v6.8.1 (**with aforementioned patch reverted**).
> 
> # cat /sys/kernel/debug/devices_deferred
> fc400000.usb    platform: wait for supplier /phy@fed90000/usb3-port
> 1-0022  typec_fusb302: cannot register tcpm port
> fc000000.usb    platform: wait for supplier /phy@fed80000/usb3-port
> 
> It seems that v6.8.2 works _without needing to revert the patch_. I 
> will
> have to look into this sometime this week but it seems like
> a8037ceb8964 (arm64: dts: rockchip: drop rockchip,trcm-sync-tx-only
> from rk3588 i2s)
> seems to be the one that fixed the root issue. I will have to test it
> sometime later this week.

