Return-Path: <linux-kernel+bounces-127578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C86DF894DD8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F32B1F22F09
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D9051C4A;
	Tue,  2 Apr 2024 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="V883+4pJ"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9C0481C2;
	Tue,  2 Apr 2024 08:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712047584; cv=none; b=QtR5b19cZuZE072lmfEfV9ZTy74DinjEko4i5cYYcs17hfcOCZIFFdxiWTxDu7oHDO0hg9yo/k3mWik5icgTRjLDrmQ0LkvDzzvtSbmrcofFckZjneT9hpS++3nZ8IqVmNj9e34d6YYQIjfrqkqM9rZsWiQYiMSfbGeDynowOe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712047584; c=relaxed/simple;
	bh=VkBHRfvSSY64YEIMMUm3e85GngUDObcOmq5K7WEvjEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rcX4Wkj/UpjecepMhnANuKqnC8C/ECewogyCNuiJbpvF4T1X1zKjIusv5HsY8TBTRgiNxF27gyoRMZOUQ7W4saq/y1hv/yog5qPCBUDPeUHTvZP5JgskNu4rFGJp2wFC8AcNadmtsZI/vAflUdcSgiNqa4S81OkRobigWTcwrSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=V883+4pJ; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=UOKR97xWJsCzeiNSwUpoZzyukhRCG3SAXSValTgdpjo=;
	t=1712047582; x=1712479582; b=V883+4pJc6LtnMgoRsNevh2Zv4dhZ7lXDR41MjMdSYn/zOV
	/kaRt/Vc7VtsadMgcg0tyoG1W0c6L2vZU23HcuMKYgiIUFHovvXHxDLLzQgaam6AVcKdiAJSmuVzn
	wjRJ4Pt5qDOCNuUmzRn2CfAei26R1oENIlkFE2ULevEcmS8doW3HCzds/DlLf0SJf8zwiUZbjpFMq
	y83n+zrMR6tVX4y6KtFqu0A3YwP2GcF3A2Qnua/iCqNmc+zHEiaekRtXZqCMzaiOOpC5zhup80cK8
	vxNCTdP7FCaTVkGyKaiF86mufswDa/tDXzC/bk0Lg83U/U166q2YMGqA4E8Z7BrA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rrZmW-0000jW-Qi; Tue, 02 Apr 2024 10:46:12 +0200
Message-ID: <ecc8bd98-0dac-4f17-abb3-ebc8b10fd0f7@leemhuis.info>
Date: Tue, 2 Apr 2024 10:46:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] external monitor+Dell dock in 6.8
To: Imre Deak <imre.deak@intel.com>
Cc: regressions@lists.linux.dev, Andrei Gaponenko <beamflash@quaintcat.com>,
 LKML <linux-kernel@vger.kernel.org>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 ML dri-devel <dri-devel@lists.freedesktop.org>
References: <22aa3878-62c7-9a2c-cfcc-303f373871f6@quaintcat.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Content-Language: en-US, de-DE
In-Reply-To: <22aa3878-62c7-9a2c-cfcc-303f373871f6@quaintcat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1712047582;8e22cf2f;
X-HE-SMSGID: 1rrZmW-0000jW-Qi

[Adding a few folks and list while dropping the stable list, as this is
unrelated to it]

On 31.03.24 07:59, Andrei Gaponenko wrote:
> 
> I noticed a regression with the mailine kernel pre-compiled by EPEL.
> I have just tried linux-6.9-rc1.tar.gz from kernel.org, and it still
> misbehaves.
> 
> The default setup: a laptop is connected to a dock, Dell WD22TB4, via
> a USB-C cable.  The dock is connected to an external monitor via a
> Display Port cable.  With a "good" kernel everything works.  With a
> "broken" kernel, the external monitor is still correctly identified by
> the system, and is shown as enabled in plasma systemsettings. The
> system also behaves like the monitor is working, for example, one can
> move the mouse pointer off the laptop screen.  However the external
> monitor screen stays black, and it eventually goes to sleep.

Just a quick heads up to ensure people are aware of it:

Imre Deak, turns out this is caused by a patch of yours: 55eaef16417448
("drm/i915/dp_mst: Handle the Synaptics HBlank expansion quirk"). Andrei
Gaponenko meanwhile filed a ticket about it here:

https://gitlab.freedesktop.org/drm/intel/-/issues/10637

Ciao, Thorsten

> Everything worked with EPEL mainline kernels up to and including
> kernel-ml-6.7.9-1.el9.elrepo.x86_64
> 
> The breakage is observed in
> 
> kernel-ml-6.8.1-1.el9.elrepo.x86_64
> kernel-ml-6.8.2-1.el9.elrepo.x86_64
> linux-6.9-rc1.tar.gz from kernel.org (with olddefconfig)
> 
> Other tests: using an HDMI cable instead of the Display Port cable
> between the monitor and the dock does not change things, black screen
> with the newer kernels.
> 
> Using a small HDMI-to-USB-C adapter instead of the dock results in a
> working system, even with the newer kernels.  So the breakage appears
> to be specific to the Dell WD22TB4 dock.
> 
> Operating System: AlmaLinux 9.3 (Shamrock Pampas Cat)
> 
> uname -mi: x86_64 x86_64
> 
> Laptop: Dell Precision 5470/02RK6V
> 
> lsusb |grep dock
> Bus 003 Device 007: ID 413c:b06e Dell Computer Corp. Dell dock
> Bus 003 Device 008: ID 413c:b06f Dell Computer Corp. Dell dock
> Bus 003 Device 006: ID 0bda:5413 Realtek Semiconductor Corp. Dell dock
> Bus 003 Device 005: ID 0bda:5487 Realtek Semiconductor Corp. Dell dock
> Bus 002 Device 004: ID 0bda:0413 Realtek Semiconductor Corp. Dell dock
> Bus 002 Device 003: ID 0bda:0487 Realtek Semiconductor Corp. Dell dock
> 
> dmesg and kernel config are attached to 
> https://bugzilla.kernel.org/show_bug.cgi?id=218663
> 
> #regzbot introduced: v6.7.9..v6.8.1

P.S.:

#regzbot duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=218663
#regzbot duplicate: https://gitlab.freedesktop.org/drm/intel/-/issues/10637
#regzbot title: drm/i915/dp_mst: external monitor on Dell dock broke

