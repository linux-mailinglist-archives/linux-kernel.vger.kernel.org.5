Return-Path: <linux-kernel+bounces-35106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC5F838C3B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F17ECB215AD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120E45C914;
	Tue, 23 Jan 2024 10:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JdFwYTNY"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65655C8FB;
	Tue, 23 Jan 2024 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706006229; cv=none; b=EKEZzE4c75nEn3U60Bp/jxoqmKb9FF0y/qdCYNAMyGaAwbHdmC16zuXbLH6VC0XmWA0g/UutYlHHKBdoUizurTDsZibfFGTTBrPmWyrZl7at7M3cDp5+BB9umktu0YCo5PFOodl/53Ed0sy3Sm/I482k6NMvyfXGVkG6xMOlAPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706006229; c=relaxed/simple;
	bh=ISBqSBU1eibSK1yROlAd67P1p3xOWCAZQTrxGAsc76M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gb9Ii5tzVOLvE5B6bs+GoSdzPqU8hHrhlvCirRauSSy7tNKzX9f/KSnoD+o+80ys23CHinsM6h5Bv7katuzBeqDs23tr9HUovJ4PveKZ7z7bkz/3teFqukoTBChHcEpMahS6wnIjc2dPiFSD+quQLshF0Yy1UhvukhH97d8L6Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JdFwYTNY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 075CA40E01B4;
	Tue, 23 Jan 2024 10:37:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id m_71YppLYEYe; Tue, 23 Jan 2024 10:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706006221; bh=tE/UEHD9KI7AAS+HbKBmjA2d1BJnju/TAX6dJiWwRsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JdFwYTNY5byPwgxwpSXquxkSQTnC4ZQiDXI3CNWF83P8psvQshzU6vZJXWlwtMtnM
	 M5+HokrAiyHCafRJ3RGjEYEy+qP+/HdmqMkv2K7GmsN6GEviPYygF2rc9v7icbs+2v
	 xFHS1sCGSPIkA+rjXhuiwtCmht7aX31Jp9Va73BAIxCMua6Dd0gRiNR7MiTJQ6eV5t
	 8cSCA2RCiMx2a/i5pDrfnLaiyiCOP0N6DwZoio/iGRWWu+0gO1jnDOr4DfQ+vTkOtJ
	 aaQmXVeZG8HdQfe9YI/MnVhA2tuI/Ny4ikvBqNSwu7lgsNa7g6ZOwycnUNtWTeQaWV
	 rdrr4uXgLLnKB5yfKE0yZaGxH1GDIXmIzEmUyLEf2uLXUKh6EO2Qg/q+F6ucm/jJjd
	 YfZyjcRQ+IXhQyTg9j33Y44vBu5sOyPEzvfJg7j4f+viUF//N5U7rbwq1DoC3w0Cp1
	 uEcY6ZvedRqjZaff0J5OlzBa9Kp2mdcvygOzx1nrIV2XNDsqVJVQA9teMBaSSN+6vw
	 anO0crzovgkEvuTr4rwLZHLrQLFNtQPi9t1lDFXVLZzhDJOpfJ2mGnglShYgFIMQ2W
	 KV97r85jzooDZy+rq7zrYl+xULWwsVJ4BkUK9mKprDOqfccrUyseu9vwVB0Z/EDCpC
	 nDgF3rlVDf+g/6RTKzqY8h58=
Received: from zn.tnic (pd953099d.dip0.t-ipconnect.de [217.83.9.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 385BD40E01A9;
	Tue, 23 Jan 2024 10:36:31 +0000 (UTC)
Date: Tue, 23 Jan 2024 11:36:23 +0100
From: Borislav Petkov <bp@alien8.de>
To: Babu Moger <babu.moger@amd.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, reinette.chatre@intel.com,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
	rdunlap@infradead.org, tj@kernel.org, peterz@infradead.org,
	seanjc@google.com, kim.phillips@amd.com, jmattson@google.com,
	ilpo.jarvinen@linux.intel.com, jithu.joseph@intel.com,
	kan.liang@linux.intel.com, nikunj@amd.com,
	daniel.sneddon@linux.intel.com, pbonzini@redhat.com,
	rick.p.edgecombe@intel.com, rppt@kernel.org,
	maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, eranian@google.com,
	peternewman@google.com, dhagiani@amd.com
Subject: Re: [PATCH v5 1/2] x86/resctrl: Remove hard-coded memory bandwidth
 limit
Message-ID: <20240123103623.GAZa-Wp79DMgeArPJz@fat_crate.local>
References: <20231201005720.235639-1-babu.moger@amd.com>
 <c26a8ca79d399ed076cf8bf2e9fbc58048808289.1705359148.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c26a8ca79d399ed076cf8bf2e9fbc58048808289.1705359148.git.babu.moger@amd.com>

On Mon, Jan 15, 2024 at 04:52:27PM -0600, Babu Moger wrote:
> Fixes: 4d05bf71f157 ("x86/resctrl: Introduce AMD QOS feature")

What's the point of this Fixes tag? You want this backported to stable?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

