Return-Path: <linux-kernel+bounces-92332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC9E871E9F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2251F25491
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F2E5A110;
	Tue,  5 Mar 2024 12:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FmHFljN4"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A1A7484
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640634; cv=none; b=cpqL1qzUsfpbTS/qi9Nr2hXNYtW7hBiWke1MfVExsHou5ioZYHoGKndaexzVeqQb/sE5Uur3jE/d4fxL5m12zEseWQTg4/Hw95ArroG0KamQPoSBVxCAgcmirQU1nNWecqAKmGa9O9PbChxhcHAMqkAjOaIrC+scUUdC3VqR1xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640634; c=relaxed/simple;
	bh=GTjS4Hkd6m77b/ORuwXUUEbnwog+yQE/lJDXncdEy/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OaTp/wrlhhfiMNgroxwLRA94uUG4Xw1c+5O/j5KTeu5vAL1lxZ2e58NxN0W7SCsjE9EihLSkRZhlE7z6RnQ49CEgBhmEwuecK/V1XuLPpRTlEugoVQ/F+11PnUROUInwAzYCw/WIQPkuz0qFFVizeMx0r++80qdVOf/9rRghsHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FmHFljN4; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 01C9A40E019B;
	Tue,  5 Mar 2024 12:10:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id inAhnK3DAZRM; Tue,  5 Mar 2024 12:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709640627; bh=iRYl9yVrWnm/9hHhvB+M62llDTIozXO0uAjI7rSuGhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FmHFljN4VDClKiC2ei98DOu2HsHOSZex+IoAuOpadqA/H5Vfx+MZk6pUG1h5yQL+0
	 3NRmbphXyDaGBrtSoEt1reo8piZqz/BHrUgPNPF/aE8AAy7i2kFwF0+uNFH86ksgNI
	 TyOoXJbDQoKJfV+XTQOzBZc6yRtC9PCegexBYLnBpD79lolB8u/KHI/rw7C15xBde4
	 VYbs9r9EOhl1OVKBDHFxa4ZS0bDot8+Ul4ZoDcyMjXE1zekWPFkBHScYJ4D4MonZ9G
	 bCZdExQDQmBUonKARjn/FcnRA7Xkc2FDMBhhXG4uSL7CYrH2Slsn2YTCibfmL6DFbl
	 O11Yfv+vyIoQYjJ8QlVYxF7zni/sJpQ7Agor0H8G9NESlK4AYW2ALwv4CM12xEcMYV
	 k/lWRdTucvRkllMLO0tm5c8RRbwCzhSYGlxHrPgte1dAG35kE0k1DqN0/qzSiEcSYu
	 nGBWadqEOb0VS3IsNw402vIljKWSiQLIDK7xvQBUao+kr/oz4RUV8UdtRbikdWe1v6
	 1UepcFn6WJzh4F42K2ZkuUMwVpc30LJWVq/WDHI1rF2r2PrNyWI+7AJiu2rVS4eU5p
	 jnbIUMYhMJQwgqMLLHxoXry8sRgwJ5THvV2tcmAnuYUaI2GV7h0DcHBmYBALALmFqG
	 RVaMNELGkzCWCdkwdYKpQEY0=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 100B040E0196;
	Tue,  5 Mar 2024 12:10:19 +0000 (UTC)
Date: Tue, 5 Mar 2024 13:10:14 +0100
From: Borislav Petkov <bp@alien8.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, x86-ml <x86@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Antonov <alexander.antonov@linux.intel.com>,
	lkml <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: unchecked MSR access error: WRMSR to 0xd84 (tried to write
 0x0000000000010003) at rIP: 0xffffffffa025a1b8
 (snbep_uncore_msr_init_box+0x38/0x60 [intel_uncore])
Message-ID: <20240305121014.GCZecLppQTzWmpI_yR@fat_crate.local>
References: <20240304201233.GDZeYrMc9exmV21PFB@fat_crate.local>
 <87sf15ugsz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sf15ugsz.ffs@tglx>

On Tue, Mar 05, 2024 at 11:14:04AM +0100, Thomas Gleixner wrote:
> It seems that none of the consumers of topology_num_cores_per_package()
> can actually be used on virt, so a reasonable restriction is to reject
> non-present CPUs on bare metal. Something like the below.

Yeah, workie.

Reported-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Borislav Petkov (AMD) <bp@alien8.de>

Some relevant diffs of dmesg before and after:

+ACPI: Ignoring non-present APIC ID on bare metal

-CPU topo: Num. cores per package:    16
-CPU topo: Num. threads per package:  32
-CPU topo: Allowing 8 present CPUs plus 24 hotplug CPUs
+CPU topo: Num. cores per package:     4
+CPU topo: Num. threads per package:   8
+CPU topo: Allowing 8 present CPUs plus 0 hotplug CPUs

-setup_percpu: NR_CPUS:256 nr_cpumask_bits:32 nr_cpu_ids:32 nr_node_ids:1
+setup_percpu: NR_CPUS:256 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1

-pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07
-pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15
-pcpu-alloc: [0] 16 17 18 19 [0] 20 21 22 23
-pcpu-alloc: [0] 24 25 26 27 [0] 28 29 30 31
+pcpu-alloc: [0] 0 1 2 3 [0] 4 5 6 7

Those hotpluggable CPUs ended up wasting percpu mem too.

As a result, APIC is not in physical flat mode anymore:

-APIC: Switched APIC routing to: physical flat

I guess ship it but we'll pay attention to what else ends up
complaining.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

