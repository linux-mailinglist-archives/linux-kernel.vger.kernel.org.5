Return-Path: <linux-kernel+bounces-167866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5558BB082
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3749F1F22291
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C2B155332;
	Fri,  3 May 2024 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bs/uce9r"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6E6101F2
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714752288; cv=none; b=douIdVhFPtDt9pKV0iFq4THuhBhCVYd8qKOmR07m1AiccxYv+W7HD6aA6sQjqaNQH1jzOhLsjMJPC10HnOtlSEP0XRnCkP3+QMstXIvk0K9VEY9RbLevMIYNQaZjH5xFM2FklN1KFMTDljIWjoDHmv2hwHZ7jIUNNTgMFHqxcCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714752288; c=relaxed/simple;
	bh=HxBaO96K211UiYQ5afvNa23Ez+3lq/l8p8/2SLvqxGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHafIMOFtqM1AKyT2hyLL9i2hcfC5eowutEmxrG06gOfYna/Xba1LMiSsQYqrekUbmx1r2hrtNkVxAnb3y0TAQkHoPn4NuspcHll7nt5Sc8uTMfPgaOoekQw+XOmlkTVZmTbv2DqCKF7NRoBUa/vreU22XdKuntNKs4+TQIOm9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bs/uce9r reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D89B540E0205;
	Fri,  3 May 2024 16:04:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NSKdZbyqgaiX; Fri,  3 May 2024 16:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714752279; bh=kgK1Sd7njMaUz6Vs0JsFM7PKN9JL8A16q9TsB9gAF+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bs/uce9rl1p2FswYSj8iEK9JU5VIYnzElPuhETDzrricDQ3pQqqQYLRUGevF4Z8zS
	 HMcLKq3R2HUhGPrzQejgUqNqEnGkzY5nI2LoO8Cv7HCBJRCMVxZmd7oY3Z786HvE65
	 Q5upDmSaEEFjqnitdtIbYIpeHNWeS1QEdtwJdYmwx4pAPTw2/bevH5r7GZtV3z9p7b
	 fi7FhPleZWWI9JAyaj9uvxcQxRAvN5rCR3zyFWi4tQfsq+61+52uwX4pvqNUfZUwz/
	 khwrjMNNM5niNRo/CloD4K4aBOUML8EnrRKkMtQcZV2o8MXTv4LBOv0xBDEop0Flgo
	 LbG6PW6YmIyj2QjFC/e9kT9m5d/CwV69sqyra+8r+x1KadkpgxXvR2WD2ymWm7mzen
	 GK0oNH3djcmOSMJ8Gsuf0vEGY4tDgKjjabdqnQ5e6AwIjAL+IHEqGHqlLX2l63h0vi
	 k1DY/CFJojQ7wmX6NQhpfkLjipgBlQ6qG8pdkRZYU6MGl1CFXRBTu3UtrEGpZfV59x
	 Acyj9fs12a02CmaUapVtc0Zif8alECfRpNsRWBJckEBYX3WB36orm6l4+KUn3YlXhR
	 JRxYRECbxHGkVgI1/R4I5mvvgia0VDtTKppA3lWIT4TbmIJyzYvtLMrJHbqVA8CI5n
	 YDZL0crKE9IkLhg73GkMq5Vc=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EAB6940E0192;
	Fri,  3 May 2024 16:04:24 +0000 (UTC)
Date: Fri, 3 May 2024 18:04:19 +0200
From: Borislav Petkov <bp@alien8.de>
To: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-coco@lists.linux.dev,
	svsm-devel@coconut-svsm.dev, Peter Zijlstra <peterz@infradead.org>,
	Michael Roth <michael.roth@amd.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [svsm-devel] [PATCH v4 15/15] x86/sev: Allow non-VMPL0 execution
 when an SVSM is present
Message-ID: <20240503160419.GAZjULA7HhinTfCWZ6@fat_crate.local>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <e377d148acac799f6905fc544fbb8bf2ed76e078.1713974291.git.thomas.lendacky@amd.com>
 <ZjTMcC7KTP9xRAqk@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZjTMcC7KTP9xRAqk@8bytes.org>
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 01:37:20PM +0200, J=C3=B6rg R=C3=B6del wrote:
> Nit: Can this be formated more like "SNP running at VMPL-%u"? That make=
s
> it easier to parse for me when looking into dmesg :)

Hmm, except that all documentation is without a "-"... The APM talks
about VMPL%d everywhere...

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

