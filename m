Return-Path: <linux-kernel+bounces-45168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4AB842C6A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3141F23FEF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C7C67C51;
	Tue, 30 Jan 2024 19:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AZUgL6e7"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA8F7AE40
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 19:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706641803; cv=none; b=pHPb08yoyz8nk3FLV0rt5yqku+0ge/gUbgbFJ1knJr2OiujqmB7UNsXECkyj2VsPOHVztw5yBC2oZAHZ/X6ifMH+SYhwqU9KVbCvCVjXZ7OovgFrQhN/RpWQt582YW1/F/L7/1gGCZg5QiCmPpiYbmb7UD3nN1DQTuAZ8wEh4JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706641803; c=relaxed/simple;
	bh=4Wv7EMdZaXZPyCqV9RTBByX8RH6muWD20puuZEhAicQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BprBXA10nSs75jPCp13l9tMcaen8EYyOsMvIYXvUzWmpKyRXSa8YmUGEi6y7asu9Q9jzHPAgX6BmbHikBdhylwORiih30evKZA28zBXqcIxeZd1fHbgRidEYPUKT3aqdLX2oWbGC7FqJoQQDWXHuWPWsw1qIXnkPM3XcFsw1QAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AZUgL6e7; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4973F40E016C;
	Tue, 30 Jan 2024 19:09:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5DI3nXipE2Gi; Tue, 30 Jan 2024 19:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706641794; bh=RTH1wsxLCCpTiC5DL2Utg7rZdMRnIA9+LdjTLXF1qHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AZUgL6e7Qf80Liky3XdrojKCNDmXCKagEIFO3tHAyOUMXmbO8hkoWorr0rrYBA8Oh
	 S3IkSYJTC6FBInJS4y39q8g6YOr3jlGOSxVIMxmkpehP7SwfnMoTXqhku3L97m3LZ7
	 ojybgFcAE49EyzpkfxVm7XhjRKYWxcYfxLt6razd+o1/cusuq/LXtkXZUfoaeB6t8w
	 MSR2NA1lTbbAdzu9Xqeuoy8zHOmXn65VxqJY45RyROGeEFPEe8bZ6AC76vvtkxArCZ
	 RW5FYFq4GfCLgrwLbmANVKyfOcGy/nmLvT1E/p+EOykefxSfZc6d2wcjQovwyWtR7i
	 wGQO+FhNrbZMA6tfC4465DPt+RcVCF5/AFEiIRr85mB9dLFnchBmGgoVNsXHY/0LSo
	 aIBqjjJPiT7F0UN/h07Pi9OtYPXjvl07yf7+0v+CR13BF8CRNSuHV+x6iLAWfey2tf
	 EYcy7TbNT/oJv7qauVHZr5RYodUjELwjguvknyGGnyCaqEJylTx9BxoPYtt7pele+3
	 PLE69QdSEJb0x3lG2FQ8XOtbTZuCiNFjA5lUpTrUVy4kA+IGpqEloXAzUfp8RWAPUc
	 NDM2c6xjvmbVF0GK7CGVd2r4oI9jyajKkvMnLdBCLATA6hNWsRlHK6JcbGj7aybNXt
	 XLukxXLkZM3S1lMcAFbAe188=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2128340E00B2;
	Tue, 30 Jan 2024 19:09:35 +0000 (UTC)
Date: Tue, 30 Jan 2024 20:09:29 +0100
From: Borislav Petkov <bp@alien8.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Feng Tang <feng.tang@intel.com>,
	Andy Shevchenko <andy@infradead.org>,
	Michael Kelley <mhklinux@outlook.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch v5 04/19] x86/cpu: Use common topology code for Centaur
 and Zhaoxin
Message-ID: <20240130190929.GDZblJaV66OM8NW8MO@fat_crate.local>
References: <20240117115752.863482697@linutronix.de>
 <20240117115908.542473474@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240117115908.542473474@linutronix.de>

On Tue, Jan 23, 2024 at 01:53:35PM +0100, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Centaur and Zhaoxin CPUs use only the legacy SMP detection. Remove the
> invocations from their 32bit path and exempt them from the call 64bit.

"... and exclude them from the 64-bit call path."

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

