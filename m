Return-Path: <linux-kernel+bounces-61870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E51CC85179B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78E371F22928
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8DD3BB46;
	Mon, 12 Feb 2024 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="lBcPtdPj"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F1E3BB47
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707750425; cv=none; b=GF0qoMTiKdp5X9x/57W6sFRTHf4T3GdcpKlHj2Oyd5vy0we9ozlMzeqsMwBjV8hshbvi7p3N6Qo4TzlXfUbKZ24BOMdjru/3Vdg73RY/2VtZl4yPfDDQNptJYoJdmuWwpngzuGDd4SmUmJ8kK89bBYizHLAFFco33dX3qWATn74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707750425; c=relaxed/simple;
	bh=vCfkrs4LXkcsKAOjKr0PZzIoNZisYM7i/fhAMFPfhls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGbc2Vkl74XmkOo3a+QGroPLEMugdz7dXuyNfa1kjQdBIaLIGSgNIOBp1fYw6aSUs4CjXu78gZTF7jPMRG2IO5um3bezWEOmvwk8D9H23J1PsRYWCJqdlOCEK8C8aopodXqBPvrZ/VFG6uZuGQjsxs0jTBFPbEYBGiAI8ZO+fOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=lBcPtdPj; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5B4EB40E0196;
	Mon, 12 Feb 2024 15:07:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id o-jPY8JYnAoI; Mon, 12 Feb 2024 15:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707750419; bh=WDM8Uif/B5+8ANeYiSTlCLljZ2ujoEn3IiKUsIYm+R4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lBcPtdPjKv5wfyAc30rmOBb8xnT3Jj/5ufA9bkkTYygCAN9ukaAqIW7xpo2YZOLjM
	 9woRpOMc+GhOHojQNZVv5e61VjorCwhIMcq5TCW0+6fGdAwzothY+9O2XXEnr2Q6AD
	 QYafQKJio+k1uhEWnjgXXg5py2duIZSbSi7Osx5ZOfnWMZ5FQTmuudRs96aN1At8B0
	 e0PD/DaEoMmbmpfkSjpsbTtSdgLMAZsbh4+3mhwNkXZs2MM+Ze+YJT6jNx3loh+5VS
	 NgqWir9i1epBSPtydVEyYaJ/toMXnV/e/ysB59GkQsOLH7U/iKivvCOxuI73/zFzOM
	 BR+xiFAP2t0afMPbV2R2NsaqOlcVupvcqwjADTPBgP8Nh7TyAJNWKB9ou/BeejsSJq
	 Cd3aPWOmLcL2YGlijzSdHtHR71Awnmrq3TKiEEzS1l2daKzw0yG5nqZkRBAn373+Hi
	 U5McIXhNDagHauJnKWDhi95zNickLs8JVQGL7vqwfFWtkaqkmCYoKxzAO7EuwQyh9x
	 BiWzC3DGxM7iOGxmfza4IyR920PWuBW62kr04Ppp2D5uyyhllF0tGeRhKIJliH8b8e
	 XFQUDuA3Wm1H4xCSZv2EUcLSXy+Z0kOSAvkslamJ3Y4d/qgmjiNiZUDZ0RiOv76ZGK
	 /a9GPfYN6lSdJVYOJu3lhGUA=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 29C8F40E01A9;
	Mon, 12 Feb 2024 15:06:41 +0000 (UTC)
Date: Mon, 12 Feb 2024 16:06:40 +0100
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
Subject: Re: [patch v5 11/19] x86/cpu: Use common topology code for AMD
Message-ID: <20240212150640.GGZco0AIP5shsUgXMI@fat_crate.local>
References: <20240117115752.863482697@linutronix.de>
 <20240117115909.011311608@linutronix.de>
 <20240206155830.GPZcJXJkOv8NOtIfHi@fat_crate.local>
 <87cyt1lotf.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87cyt1lotf.ffs@tglx>

On Mon, Feb 12, 2024 at 03:50:04PM +0100, Thomas Gleixner wrote:
> Hrm. That is unfortunate, but we really don't want to mix the RAS
> tree. So this needs a fixup in next and in the pull requests.

Sure, lemme know how you wanna do the patch tetris and I'll take care of
it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

