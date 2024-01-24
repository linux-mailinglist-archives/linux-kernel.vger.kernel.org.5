Return-Path: <linux-kernel+bounces-37661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 910CD83B332
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B211F2329D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478D31350C9;
	Wed, 24 Jan 2024 20:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FHomELfS"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C01134744;
	Wed, 24 Jan 2024 20:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706129324; cv=none; b=ih1PIp9yhp9icklkdG2wTmxrP5hl1PZ/kN7BvZQIRKE2KL/DqTRHU/BBq0P11U+OiZremnb+xF2Kb8A632e45ssYplmNIoT7Vc4f2N0iXNQmeobNYoFpRwzLIQ5wxEWOEWRyt/nX/H0Y7X5GyEBYPkmpEKQkvDjonnHdcUabopI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706129324; c=relaxed/simple;
	bh=SlL4+C5cerssw/BzIER+0zF2omYxZdeDBnVROaQ1k10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Im/RWlmNQf7xhJ7p3YIvt91pukjcNIViu9BKqWFRqSFdX9Py7nsY/qcsx63UXwdtfBHv7ORgJRELdPMFAkhjMrVI45wKJBMpPqYMe23wE4aeReIoxPbKHxbbqhxZSRg0n55mBd7VHbuwXRgA8/V9ZwsEme3Pg/XHaNSBUGNtwf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FHomELfS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8F6C440E01F9;
	Wed, 24 Jan 2024 20:48:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bF-VeXvDOoZC; Wed, 24 Jan 2024 20:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706129317; bh=NOnyNTJNVbY/f45/12bFzorZJAkRoknKlPj0tUTFJvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FHomELfSJ59Og69WcqZMfYSfaw90Zb3RMRyV82+AJTkXeCYxkMj+wqh3ac+6y3cz3
	 oszG0KqL9b+Vhumwz2rguACUAKRm9kf/aBq9EfzcdW48QSQ2NjeokH7kmKV07BReB2
	 0gdSXD+ZGEXIoN+uvF8KWRC7qLljT5F5sTlhYZhNQrrZagZLoYdbIAYyo7+rVcIFKU
	 mf9bJhu3Vi4qzs/VTCNoxDto/+AX17gkoNbEEt8MS0IFtT8uyVl4LSG5xr1YbON/ym
	 WeZvkAeTqxtPtgSXwicRW+jXowXxNJNB2pp5I7JgxQaQLb1BwyYdYHXC5BmTWkegTR
	 T+BAk0f/59opiHm1ZFBJFoZSaiy1IFR/zZhUVI1JxfHVgRxZmlwugHMBmTIZEVOm4E
	 ruKtKzDocJ+t5kPQGhnZGuPUYgOAbqVSsIczvLxpmVgONyGy7up0T/DWIfTx+hH8jL
	 PpLiu9VWIlhksTwIM8RHageuOftNxeos6EAYm2UnPr9Yizi0caaB77lG/a+zwTXomt
	 wjI554SnmH7DiK/tE9Wf/z7hIC8/JlXFOYJFx9UEE5M6jKgRclCY6605hchC19EOBM
	 esLgCJ1N3aRSJ7ndHRyniwI5WqsL3COxXjV5PCKq3D27vCb5WXpWKLDrjbPeZaNrvK
	 h8SAwK81kuDwSPRLKjMy5RA4=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 345D140E01AE;
	Wed, 24 Jan 2024 20:48:03 +0000 (UTC)
Date: Wed, 24 Jan 2024 21:48:02 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Moger, Babu" <babu.moger@amd.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
	fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
	peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
	lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
	leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
	kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
	kai.huang@intel.com, kan.liang@linux.intel.com,
	daniel.sneddon@linux.intel.com, pbonzini@redhat.com,
	sandipan.das@amd.com, ilpo.jarvinen@linux.intel.com,
	peternewman@google.com, maciej.wieczor-retman@intel.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	eranian@google.com
Subject: Re: [PATCH] x86/resctrl: Fix unneeded variable warning reported by
 kernel test robot
Message-ID: <20240124204802.GJZbF3gowWCGiDw9UO@fat_crate.local>
References: <202401241810.jbd8Ipa1-lkp@intel.com>
 <84128a3c83654493f637b8349153af10d69e2752.1706118776.git.babu.moger@amd.com>
 <39c4501e-4937-49de-b12b-742e6201df6f@intel.com>
 <20240124183153.GFZbFXmTKTLEpwZshW@fat_crate.local>
 <e96df7ac-f0b4-4300-8546-7c1df836dea2@intel.com>
 <20240124191429.GGZbFhldYr3K85H9cg@fat_crate.local>
 <eadee6af-f8d3-4ede-915c-f3dc3d166068@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eadee6af-f8d3-4ede-915c-f3dc3d166068@amd.com>

On Wed, Jan 24, 2024 at 01:39:01PM -0600, Moger, Babu wrote:
> Yes. Looks good. Compile tested also. Thanks

Thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

