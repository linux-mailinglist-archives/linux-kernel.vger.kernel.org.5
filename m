Return-Path: <linux-kernel+bounces-91082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA3987095C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7BA1F21A7C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B9E62176;
	Mon,  4 Mar 2024 18:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="J8lvZYbL"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E9C6025E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709576341; cv=none; b=tW1slpoKWGDOD8ETLtolQHC5EIeaBd/gz/ur4bbzmuzikG88tNUyfaxWqLm/syYNm8inuSC/Fivr2HDTZCXfLDEwO6VUzffjrp9K0u8MT8T/pCPrNe4cpQN6Qb7d90WbyDp0meyTarU1XxF8/FWySd5wui8nWVqcID5nrpb9pWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709576341; c=relaxed/simple;
	bh=cGGgIIC1RWpsDz3r3XZ6uBQqBn17EQ6Fh5wygcHaQX4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z2fBkGUKE/lkHt0sj5WxhFPcX53llR9wUXUoqmonKAS2gxXve8KXq0WY3i6bb53kkG2u/L+ilTIFtzeFLYNwe8KuoLh5MT7HN/Gl/KxsfCK/6vFDhSTC2snD0HwH9kbFZdTgo1iMu2xd0RTULu6TKLEUvyG7amfcls0n0uR4DYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=J8lvZYbL; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0992140E019B;
	Mon,  4 Mar 2024 18:18:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zo9VhH_4nHBM; Mon,  4 Mar 2024 18:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709576332; bh=qbrWRZTEhU68qFmwLeTyfQWef1FZlIa4wlRRoa1qAjo=;
	h=Date:From:To:Cc:Subject:From;
	b=J8lvZYbLh80zcgP2XUyHIeilCIXluI4UAslattC+g6TtnQYB4829jHWWlTndoEwt1
	 g3CAtiJsWvS+Zcpo53d7gdrGKSFwWKo5FaFhsQiYTRghH/9udIf1CgDvuOl901Cb28
	 THFbyMwDOGYWCbRAKcwriiTIG27BMBNuAU9prhTHe2WB1ymjZi4pOtZB2eo81VuUjW
	 sd65TPwGIUUKeOnkAtNx1WqWWSnl2iGWzJGTRgFeul78b6bxTsyaALxtfZ/JZ+GFQH
	 0gss+nKWx+Am0xOMhMr9QuVxkc+U47/mCCwxiEI7rzmMBRNGeupiKR4LbtaSA4w81m
	 UrFiTdxYcgr2INfyhgylm463fap4SJXHdx8MltyzufaxVc4HRFCBpcmYb5L6dNudxz
	 tFKJvINSPp053XmqXeb0ZwpruwTPS/jSjbcJarsGUyzXt65/ekv85LqMrxKN5AA/TW
	 xtmHCy5ekeqcTUK4eSHJbr/nsau+Fic28P3Cky4/fSkisxMk2bKlG5ctyzyX5I6bim
	 5BZSDKTSSPFiB2odsNhe3ic1ln8xGPfZNWhSrQYsnbo+lcqi39e2zuO7bQePZxEmZ6
	 gMRrHgFfsrqk5/2PV4R8JAIR8tP7+3gmArbJAqTc4Bk+rXAwzUs8I204I7IHj+Jcwx
	 gUV0n62vn5s/hOUvH/1Bf8W0=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 949F140E0196;
	Mon,  4 Mar 2024 18:18:46 +0000 (UTC)
Date: Mon, 4 Mar 2024 19:18:41 +0100
From: Borislav Petkov <bp@alien8.de>
To: x86-ml <x86@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Alexander Antonov <alexander.antonov@linux.intel.com>,
	lkml <linux-kernel@vger.kernel.org>
Subject: unchecked MSR access error: WRMSR to 0xd84 (tried to write
 0x0000000000010003) at rIP: 0xffffffffa025a1b8
 (snbep_uncore_msr_init_box+0x38/0x60 [intel_uncore])
Message-ID: <20240304181841.GCZeYQgbZk6fdntg-X@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi all,

sending this to a bunch of people who have touched this function
recently and some more relevant Intel folks.

The machine is an old SNB:

smpboot: CPU0: Intel(R) Xeon(R) CPU E5-1620 0 @ 3.60GHz (family: 0x6, model: 0x2d, stepping: 0x7)

and with latest linus/master + tip/master it gives the below.

It must be something new because 6.8-rc6 is fine.

..
i801_smbus 0000:00:1f.3: enabling device (0000 -> 0003)
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input5
i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
ACPI: button: Power Button [PWRF]
i2c i2c-14: 4/4 memory slots populated (from DMI)
unchecked MSR access error: WRMSR to 0xd84 (tried to write 0x0000000000010003) at rIP: 0xffffffffa025a1b8 (snbep_uncore_msr_init_box+0x38/0x60 [intel_uncore])
Call Trace:
 <TASK>
 ? ex_handler_msr+0xcb/0x130
 ? fixup_exception+0x166/0x320
 ? exc_general_protection+0xd7/0x3f0
 ? asm_exc_general_protection+0x22/0x30
 ? snbep_uncore_msr_init_box+0x38/0x60 [intel_uncore]
 uncore_box_ref.part.0+0x9c/0xc0 [intel_uncore]
 ? __pfx_uncore_event_cpu_online+0x10/0x10 [intel_uncore]
 uncore_event_cpu_online+0x56/0x140 [intel_uncore]
 ? __pfx_uncore_event_cpu_online+0x10/0x10 [intel_uncore]
 cpuhp_invoke_callback+0x174/0x5e0
 ? cpuhp_thread_fun+0x5a/0x200
 cpuhp_thread_fun+0x17e/0x200
 ? smpboot_thread_fn+0x2b/0x250
 smpboot_thread_fn+0x1ad/0x250
 ? __pfx_smpboot_thread_fn+0x10/0x10
 kthread+0xed/0x120
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x30/0x50
 ? __pfx_kthread+0x10/0x10
iTCO_vendor_support: vendor-support=0
 ret_from_fork_asm+0x1a/0x30
 </TASK>
iTCO_wdt iTCO_wdt.1.auto: Found a Patsburg TCO device (Version=2, TCOBASE=0x0460)
iTCO_wdt iTCO_wdt.1.auto: initialized. heartbeat=30 sec (nowayout=0)
RAPL PMU: API unit is 2^-32 Joules, 2 fixed counters, 163840 ms ovfl timer
..

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

