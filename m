Return-Path: <linux-kernel+bounces-37785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE81483B4FC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2CA1C243B6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59978136661;
	Wed, 24 Jan 2024 22:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OUysXtpV"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2D1136648;
	Wed, 24 Jan 2024 22:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706136467; cv=none; b=rE/nZ9o11T791sIvF8PnTbG4BS/Mt5YrW2XoSJtISWbM7wKCw/sAmUPhUPvUpPVNVvyZCf251Ul6soZ3cIu5qlEsuxwYJmNZQKu5yA9MbvoWx1GOwfGShtzpMxZXz5nXtnARpgPkA6Ggl4KuPm4T51Z2dvqC/iEC+UGjDdNyDRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706136467; c=relaxed/simple;
	bh=7NgKqpvf5ts0U/jiEHbjF5qX/ZCVUDB5vcs7oK3wDSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q78Ru6TM/NkVh0I49ZATA6jqwa8IzE9JWYbSzwAhkYJRI4Dipw9vP2X+lLGeasMPkzyazhOrpk++ESYavvuSYsoBv16yOoX7mB8VQAeAM6iHHxwiWWy6sJnUqT5GTRRUvLMBOuc8LrFX791VG3fBqKrfM+nd4hFGgUWv66k4tFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OUysXtpV; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4F2E740E00C5;
	Wed, 24 Jan 2024 22:47:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7iCk-vQQ6vEP; Wed, 24 Jan 2024 22:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706136457; bh=/tJsEHYFxLjcxm+X6zZpNETmsYnkA5xx8zeO8j+bDdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OUysXtpVh8W+H4rkW+UKUsnxLg2F5g7IEhqwlxeeG1R2mdxLHmFArV/6QIHPCU07i
	 eXig1f19BDPX7lRCJs3sqlSP0GuVl7uVbTEHFj99t1edFiIF8jsxqmmyi1bVjaPxtD
	 zBTmOO6dmJo5qWdFCtWSKvwmmg0PPzaKeta/TfIalWf15/H8zSk5bHEKComp4wM/F+
	 Exti95+WCDiv+vHaryOKHUtGNuWVmBTTUNpM0Vwk8K+22i+bC5lgBz2UrgHHR5hegu
	 spWxzq2oE2dcp3Jy5coDcIozVZv7ZJgmnqU6412bVoT3hQjQb8BJql/55gPjpqPwRx
	 gO87Uw6GNCJfRFgsWdbiKr2jSEy2uTxw0FfZCiNkk0MgiCbugCaj7K0D4jtveUcj2G
	 s2PO4PwrC1BG2vciupncSXO8Fx10wCIEhPruzWSCVAa4dCnc9Sy4d8JXJsSV5PIxcs
	 lH+Rfk+w3DUxFM1lQQLFxu+o6neH2PmXBhSy0JQ45+6IMYCa8iJ4cxgI0tXrtiOD75
	 9HEEiZ/SeVkbl8BU49qV7pIQv2XBo2Fndn8xkVChMXk+UETkEi5CDeY2mBYbV18r4f
	 DDHbcou2XCNFKa4ZoXxh8mha0XAwBjEN8XxJT9Q1jo0/GfCdAWGsUh+0tGRuJIvhXP
	 xvpfTSzWo7mhhLpRPKgQ8gzg=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 700A840E01AE;
	Wed, 24 Jan 2024 22:47:03 +0000 (UTC)
Date: Wed, 24 Jan 2024 23:46:57 +0100
From: Borislav Petkov <bp@alien8.de>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
	rdunlap@infradead.org, tj@kernel.org, peterz@infradead.org,
	yanjiewtw@gmail.com, kim.phillips@amd.com, lukas.bulwahn@gmail.com,
	seanjc@google.com, jmattson@google.com, leitao@debian.org,
	jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
	kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
	kai.huang@intel.com, kan.liang@linux.intel.com,
	daniel.sneddon@linux.intel.com, pbonzini@redhat.com,
	sandipan.das@amd.com, ilpo.jarvinen@linux.intel.com,
	peternewman@google.com, maciej.wieczor-retman@intel.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	eranian@google.com
Subject: Re: [PATCH] x86/resctrl: Fix unneeded variable warning reported by
 kernel test robot
Message-ID: <20240124224657.GKZbGTYTjN2m8VirbF@fat_crate.local>
References: <202401241810.jbd8Ipa1-lkp@intel.com>
 <84128a3c83654493f637b8349153af10d69e2752.1706118776.git.babu.moger@amd.com>
 <39c4501e-4937-49de-b12b-742e6201df6f@intel.com>
 <20240124183153.GFZbFXmTKTLEpwZshW@fat_crate.local>
 <e96df7ac-f0b4-4300-8546-7c1df836dea2@intel.com>
 <20240124191429.GGZbFhldYr3K85H9cg@fat_crate.local>
 <6635c607-cab2-45f4-a0fe-ff4f53b36849@intel.com>
 <20240124204525.GIZbF25bekUME2flt0@fat_crate.local>
 <7d6e3d39-ce53-40e4-bba5-242911a1522a@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d6e3d39-ce53-40e4-bba5-242911a1522a@intel.com>

On Wed, Jan 24, 2024 at 01:31:01PM -0800, Reinette Chatre wrote:
> I do not know the motivation for that requirement. From what I can tell the
> change [1] that added that check went in as first version without discussion.
> [1] starts by saying that the format is "preferred" so I assume there is
> some history that I am not familiar with.

My main goal with commit messages, code comments and every other *text*
you have in the code is to be as succinct and understandable as possible
for time considerations, clarity, etc.

If I see a 12-char sha1 followed by a title, to me that is a commit. No
need to say "commit" too. But as already said, if you prefer to have
"commit" there, I'll add it - no biggie.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

