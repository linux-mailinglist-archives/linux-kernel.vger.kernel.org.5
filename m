Return-Path: <linux-kernel+bounces-165379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E833C8B8BFD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156621C22C57
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF93433A8;
	Wed,  1 May 2024 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="w/ZJL00n";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="w/ZJL00n"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AFE14012;
	Wed,  1 May 2024 14:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714574348; cv=none; b=fRMJu0pgF2JrORixDgJA3K9ByiBRets4P4HmKD5dRswrH5LhYHyOzkDsNoyx7FgueyPxFjTGzTjTMCGcSmO6ksKU3Py6djthykhsvke1a+ruBhvr72b6Kj6vOjLoubOr3Uqh3/AXQ2gOWee4qMC2CZ3ZsAnozo5iJnE/s8988fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714574348; c=relaxed/simple;
	bh=3EQ+oWKQqtrjsODeFi5xeD2z30PLypWt44MJVuizc/8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QcwheGEdC1QL+pgrGQ0fPW/YXU/1CqVf5GtJER6NmJAnwopt2IY83PGmnjBnZ4SC/dURD//0M7NwhQvnjAXyzU0KcNDvXr8ORjS1rjJ0wL7Cwt3/c4Ler0ww3kpntP9Zheo9nM08jw2OLdYQ81JgcfsVP+PFhy9zSdAA8Oc06aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=w/ZJL00n; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=w/ZJL00n; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1714574345;
	bh=3EQ+oWKQqtrjsODeFi5xeD2z30PLypWt44MJVuizc/8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=w/ZJL00nwM6w5z/8CbB0oSsA797HfCvyxdopQkvYx9dCpWNA+8qXeSUuB49jEP3Ju
	 /7sRc8sTS3KGQt04J0Jgv4Cwl11wLPvK+a6T4i4cSKo7U9Ski3NzNH/fbhpOg988WJ
	 7hvKmo+i166QYTG33tUNslnEQgg3Blb1X2dFJ59E=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 67F261285DB5;
	Wed,  1 May 2024 10:39:05 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 1f2y665NX5OW; Wed,  1 May 2024 10:39:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1714574345;
	bh=3EQ+oWKQqtrjsODeFi5xeD2z30PLypWt44MJVuizc/8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=w/ZJL00nwM6w5z/8CbB0oSsA797HfCvyxdopQkvYx9dCpWNA+8qXeSUuB49jEP3Ju
	 /7sRc8sTS3KGQt04J0Jgv4Cwl11wLPvK+a6T4i4cSKo7U9Ski3NzNH/fbhpOg988WJ
	 7hvKmo+i166QYTG33tUNslnEQgg3Blb1X2dFJ59E=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 661001285D8D;
	Wed,  1 May 2024 10:39:04 -0400 (EDT)
Message-ID: <c358208c5d4c823e3373aca4fe42998a6edd12fb.camel@HansenPartnership.com>
Subject: Re: [PATCH v3] scsi: csiostor: Use kcalloc() instead of kzalloc()
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Kees Cook <keescook@chromium.org>, "Martin K. Petersen"
	 <martin.petersen@oracle.com>
Cc: Erick Archer <erick.archer@outlook.com>, Bjorn Helgaas
 <bhelgaas@google.com>,  Justin Stitt <justinstitt@google.com>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>,  linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-hardening@vger.kernel.org
Date: Wed, 01 May 2024 10:39:02 -0400
In-Reply-To: <202404291259.3A8EE11@keescook>
References: 
	<AS8PR02MB7237BA2BBAA646DFDB21C63B8B392@AS8PR02MB7237.eurprd02.prod.outlook.com>
	 <202404291019.5AC903A@keescook> <yq17cgg58sp.fsf@ca-mkp.ca.oracle.com>
	 <202404291259.3A8EE11@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-04-29 at 13:13 -0700, Kees Cook wrote:
> On Mon, Apr 29, 2024 at 02:31:19PM -0400, Martin K. Petersen wrote:
> > 
> > Kees,
> > 
> > > > This patch seems to be lost. Gustavo reviewed it on January 15,
> > > > 2024 but the patch has not been applied since.
> > > 
> > > This looks correct to me. I can pick this up if no one else snags
> > > it?
> > 
> > I guess my original reply didn't make it out, I don't see it in the
> > archives.
> > 
> > My objections were:
> > 
> >  1. The original code is more readable to me than the proposed
> >     replacement.
> 
> I guess this is a style preference. I find the proposed easier to
> read. It also removes lines while doing it. :)
> 
> >  2. The original code has worked since introduced in 2012. Nobody
> > has touched it since, presumably it's fine.
> 
> The code itself is fine unless you have a 32-bit system with a
> malicious card, so yeah, near zero risk.

Well, no actually zero: we assume plugged in hardware to operate
correctly (had this argument in the driver hardening thread a while
ago), but in this particular case you'd have to have a card with a very
high number of ports, which would cause kernel allocations to fail long
before anything could introduce an overflow of sizeof(struct csio_lnode
*) * hw->num_lns.

> >  3. I don't have the hardware and thus no way of validating the
> > proposed changes.
> 
> This is kind of an ongoing tension we have between driver code and
> refactoring efforts.

That's because we keep having cockups where we accept so called "zero
risk" changes to older drivers only to have people with the hardware
turn up months to years later demanding to know why we broke it.

Security is about balancing risks and the risk here of a malicious
adversary crafting an attack based on a driver so few people use (and
given they'd have to come up with modified hardware) seems equally
zero.

>  And this isn't a case where we can show identical binary output,
> since this actively adds overflow checking via kcalloc() internals.

Overflow checking which is unnecessary as I showed above.

> > So what is the benefit of me accepting this patch? We have had
> > several regressions in these conversions. Had one just last week,
> > almost identical in nature to the one at hand.
> 
> People are working through large piles of known "weak code patterns"
> with the goal of reaching 0 instances in the kernel. Usually this is
> for ongoing greater compiler flag coverage, but this particular one
> is harder for the compiler to warn on, so it's from Coccinelle
> patterns.

We understand the problem and we're happy to investigate and then
explain why something like this can't be exploited, so what's the issue
with adding it to the exceptions list given that, as you said, it's
never going to be compiler detected?

> > I am all for fixing code which is undergoing active use and
> > development. But I really don't see the benefit of updating a
> > legacy driver which hasn't seen updates in ages. Why risk
> > introducing a regression?
> 
> I see a common pattern where "why risk introducing a regression?"
> gets paired with "we can't test this code". I'm really not sure what
> to do about this given how much the kernel is changing all the time.

Well, it's a balance of risks, but given that there's zero chance of
exploitation of the potential overflow, it would seem that balance lies
on the side of not risking the regression.  I think if you could
demonstrate you were fixing an exploitable bug (without needing
modified hardware) the balance would lie differently.

> In this particular case, I guess all I can say is that it is a
> trivially correct change that uses a more robust API and more
> idiomatic allocation sizeof()s (i.e. use the sizeof() of what is
> being allocated, not a potentially disconnected struct name).

Which is somewhat similar to the statement other people made about the
strncpy replacement which eventually turned out to cause a problem.

James


