Return-Path: <linux-kernel+bounces-163091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFDE8B6556
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB781B2115F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BFD190680;
	Mon, 29 Apr 2024 22:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AwhPErZ3"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84FE19069C;
	Mon, 29 Apr 2024 22:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714428649; cv=none; b=UnJY+xI8ETO2yRLoE4tTn+RyqrnS1T1/bmvCrJkezk8ZzqyBm6bhKI/A4IFw61rZvUOHgz7cWGDlNln9k1Fn7CKfr4EXY6gtzILhk/uw7rQArURlFCzk/He5Gx1gvUEG5LF1UGo7vCd6KIsdHpVmQuQWDjx1VvMGITNeUn5/+IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714428649; c=relaxed/simple;
	bh=BnORpZI96ulOL2ybGBlixNtcajQVtJLpgJmjNiq9iXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrnPk8d4ZoqSmOo7XCFfhYU9QvCelO69Iu1981MPbur+nifPqUv1AUBrOM+oXxHcUotAUyYU4JJUKEPVL0gvR0lvlR2sRrIf+H55w9k7qxPHgNlr0qKwa5kJfFx7eJLrTsZW/GoWFZas7hyAUxceqjsY0B7jQrcPJ9bCn1CXreY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AwhPErZ3; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7291D40E00C7;
	Mon, 29 Apr 2024 22:10:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7oE8v-9sJrwS; Mon, 29 Apr 2024 22:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714428634; bh=Msj1Hf1pE0OzlB7eC2G079cRtumFYJCMn8TqRTaMLN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AwhPErZ3fyhhceeJbn5Eqsp7ufWGQyJdE/K+WV3uTmuq1agttfcoFjFi1IrZU/B6n
	 YXpeelZouhEQR1f5I01ziH1iTZT6GdEBtE398NGlsP4TGnnpufW5vqWiB+liqsq2CO
	 dsgEN5NI2nSYqiLE79Tf2yXSP2XEjlotni7/VspBHfNH3KrxcMu1FwqYwMYLHkbAZw
	 ixwhTBJ6oHAplgsSNXkjUGHJ1SAD+njmmkyeEe9bRQ41TQHMG57FUabzhai7mVbtLp
	 UlYqn+Qjh1ZUZ9trQsOtUDHRcN1uRiSAE0mxrnMVuHH9qTHSWgPDZ8ptFDfet3bVVI
	 m63ew2tUwhGelkxyMMNr1AK77LfJS1itcXUiAo+pOK85jne+XUEq0kujN9oWp8cs94
	 hHS1RLo7tltzhPpZJFHaKdRnkwwoDg4bVTxp2pslkskeymWUsPh6aLcDmszMgI+b8w
	 lZqIT0Qxr3VJEOVD0uD36Vw90alhCfzaE72X216D7yqb6G4qSNA4RBotUuPZw9MxsA
	 UUvNYQYig7wbx3wFiatf2c4Sm6OR/A7Mo1hsfPS5M7VnLjYk/S92iuenqwOE1Wak9W
	 mc45FamvCR4DR/25bs6C1AaF40hYWwL4hE69eszDly4/23o2D1+PX4mJvZOGhFgxpN
	 4nbsB1lEJJ6RQGp2Ku6rYzgk=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CC64740E0187;
	Mon, 29 Apr 2024 22:10:29 +0000 (UTC)
Date: Tue, 30 Apr 2024 00:10:22 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/cpu: Fix thinko comparing x86_vfm with x86_model
Message-ID: <20240429221022.GKZjAazoIhwQkK7-H_@fat_crate.local>
References: <20240428183142.GHZi6WDu5nbmJJ_BcH@fat_crate.local>
 <20240429022051.63360-1-tony.luck@intel.com>
 <20240429082242.GAZi9Y0uK-e2KGWxmX@fat_crate.local>
 <SJ1PR11MB6083B53C58D36ADB74C08AABFC1B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083B53C58D36ADB74C08AABFC1B2@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Mon, Apr 29, 2024 at 04:05:29PM +0000, Luck, Tony wrote:
> I made one patch per file touched (wherever possible ... there are a few patches
> where ".h" and ".c" files needed to be bundled together).

I figured. I think the next step would've been to group them all into
a single patch based on the subject prefix. But we're doing that now
anyway.

> Thanks. I just did a "git fetch" the x86/cpu branch. It all looks good.

Thx!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

