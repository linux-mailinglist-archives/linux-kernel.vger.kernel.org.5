Return-Path: <linux-kernel+bounces-63875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 858948535C6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1D281C26C7D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0DE5F85E;
	Tue, 13 Feb 2024 16:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UTCxPIT5"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED665F84A
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707840938; cv=none; b=ZQfWEs9RDwU2mqG8Tuq2oETvAh1GWTcFXjShL6fK1VSPZDPsOlAvnEnOa48ghb/4hOwkpGWmHnyaoRCPKU8qRzbPbZEs3nddlb3AEH5tFvvJxZ2pLysUbtW2O9563BC5ZfY+DmAXdzwFwE5Xfss0UtdxE+OvPPrczSIHeUw6RXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707840938; c=relaxed/simple;
	bh=kuxffWKDBhwyo0AylZJcICbz2iJj+buD4hrhfjfE9p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fm70JtvLsPKvTmb2j6t31qrV+Cwnsrb3bY+C42FDp3NAbrjheVQ5y4BOXEHXzv43xMxofK7UbUneMrny07nMrhiCvpT21i8dW+oGV+mw6wF67hXlpjzeuxsZe9vDHtGEdnYPIINYyQZ4LIqH//w5M9co+2rDEt/kJYCqfMp5Mp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UTCxPIT5; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C2A9B40E0192;
	Tue, 13 Feb 2024 16:15:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FrYSjfBi8-K0; Tue, 13 Feb 2024 16:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707840929; bh=rLQLnzuEPEpSul3JxQ9UIClohNnaVnYwJKBIsFYZMNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UTCxPIT5f9uWOMZ0cg+sG5MWAsHW0iuPyMxrOsMADj908Z0SBNm1yd/9U+jSZEoY4
	 f5xpA2Yka5LOX3MJzPMgj8bDD0ED1ioefkEig7tObctHwOUJDr6oDsu9Bextcyf+EZ
	 UKJFa0z0bcjEvcBmgbPR91H64rsjVGV2DSESKmXGOZ5+fON4nKspvQMcmBlkmVeKKD
	 5Nc+Lz2hw5GL7fMP7yTgzX6Thvuh2TtURgvpmSGVk4JPVOpsRNSNOHAus2mfknZW0b
	 CIkgWjYzftgs+Fw3zHvgPIdk0e/0RyT05Rwun+ev6mH4jLeBg3dKL7SUDPKjrDKlNu
	 x2TYhlsZUnq1rsosoN9MP2/z4AFeeDIaynE6SKdIy4na2wCDCxP8G4YxoHw/Ngv3AA
	 OC7P7xhLGddDWKDp46HNmQmowCGuZr/YwjLmfg7OH4jRwUv2AZ0XvY31EBJXnSgBgT
	 xALADCn5yarOSuWnv0HSyL8fayMx+OVAi36a9etl+dyy7HtDoelVJ2YfH1R65j+iYC
	 Pj18D6fs3oTDYrat6JnQIn6QkixcyoquIWpe9rbbGampklFrAKQqLThrXBnWrsbITg
	 sG1boQtsthmu5M9Oyr1Ryj344vXX9uLQvRudggnSHrIjfLRdO93U/jcqd+1264Q861
	 cE/gcT5+31nyh0xITWTdvVTY=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 73D5840E01F7;
	Tue, 13 Feb 2024 16:15:21 +0000 (UTC)
Date: Tue, 13 Feb 2024 17:15:14 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Isaku Yamahata <isaku.yamahata@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH, RESEND] x86/pat: Simplifying the PAT programming protocol
Message-ID: <20240213161514.GCZcuVku13t8p5wHnj@fat_crate.local>
References: <20240124130650.496056-1-kirill.shutemov@linux.intel.com>
 <20240131175738.GIZbqKEhlDKhaKfh_w@fat_crate.local>
 <67hqgqargmt6nln5mds672g263lka7glyzbvcdgt4owdg7xc2e@v6wvuizw5ond>
 <20240131202340.GLZbqsTJkeFQycXT0B@fat_crate.local>
 <fvzki5mtpbsoyljy354qnva5rllgukba7iuxufxjttceio5osd@tdvgddwttfqo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fvzki5mtpbsoyljy354qnva5rllgukba7iuxufxjttceio5osd@tdvgddwttfqo>

On Thu, Feb 01, 2024 at 12:17:32AM +0200, Kirill A. Shutemov wrote:
> > So the "relaxation" is the removal of that CR0.CD requirement?

So I'm looking at the SDM, revisions 081US and 082US.

Section

"12.11.8 MTRR Considerations in MP Systems"

still has

"4. Enter the no-fill cache mode. (Set the CD flag in control register
CR0 to 1 and the NW flag to 0.)"

and

"4. Enter the no-fill cache mode. (Set the CD flag in control register
CR0 to 1 and the NW flag to 0.)"

so where is that relaxation written? Am I looking at the wrong place?

> And double WBINVD if the machine has no X86_FEATURE_SELFSNOOP (before and
> after TLB flush).

That's still there too. Steps 5 and 11, respectively.

Hmmm?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

