Return-Path: <linux-kernel+bounces-75417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E4C85E872
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64BBDB2A521
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85539126F0F;
	Wed, 21 Feb 2024 19:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqZK98bd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78CB85C44;
	Wed, 21 Feb 2024 19:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544587; cv=none; b=Okyd0Xz0dhfYn4uhx4gw4SGpOvzJHxC1qjFaKnv5+SXHi9c3Wbvc/3F+TqQUvl60d4zOfmqq7djMP15gmQKsIFw/cD4vvckCCLAkn5qEtF3N4MryS+LdKlD9psbJjb7LHgbzYfe7WlDFsTn8rBy5X41Am2bV/kzBuT2REwpkq3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544587; c=relaxed/simple;
	bh=DRCQpYbsfLGvcxFl1aJDHx7me4PHhx5rFi6Tt+smuIQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=ruV0F3fiuI5daGzJ7T7GLBb9eL3fuqZO6MbzS0qvB0felnyGehyns0jtJm1hnLkZulj2EEbDgFgYrUspLMnLKo681ubfyMTbhqyxyyunAvQ1aCoLQxK5KLs+pYcLZVPNGAY9fVAeWr15sam4CpysYne+6Mn6xPMC8tczviN3+K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqZK98bd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D905DC433C7;
	Wed, 21 Feb 2024 19:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708544587;
	bh=DRCQpYbsfLGvcxFl1aJDHx7me4PHhx5rFi6Tt+smuIQ=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=BqZK98bdFzoiPgfy1v5a3KkvlW/mMl13u2vpbBwemJnvVooFfafU+C6hAgET2f+PI
	 4YzpYc+a9+SerKbg2mOYaNdMvyVYU63MS+oHOskhsqDA8qBOy95jKaqFGlJyaQkKEv
	 EFz6QtSoXGKQ1LxcXpgEFtWjNiJpYbvkzxgLdLfJl9h1FD1VMkxzUbuyz9GEbin+XA
	 xdNwHEIeKaZvIfUC22SGdoz8seuaSgyxWiBV1kDy+aQ0Rt7e/Tf9ihSdd1B0Xu78UD
	 TiUl6OPyHdgzkXA25fZQucLhweMQ+n3sgAV0FWjldb2iGcCnxeeRab1iXIhHEspb9Z
	 TRgvFWB8yDmGg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Feb 2024 19:43:02 +0000
Message-Id: <CZB0I9OAGNHT.1HTSJU3925RBY@seitikki>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>, "Lino
 Sanfilippo" <l.sanfilippo@kunbus.com>, "Alexander Steffen"
 <Alexander.Steffen@infineon.com>, "Daniel P. Smith"
 <dpsmith@apertussolutions.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Sasha
 Levin" <sashal@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Cc: "Ross Philipson" <ross.philipson@oracle.com>, "Kanth Ghatraju"
 <kanth.ghatraju@oracle.com>, "Peter Huewe" <peterhuewe@gmx.de>
Subject: Re: [PATCH 1/3] tpm: protect against locality counter underflow
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.15.2
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
 <20240131170824.6183-2-dpsmith@apertussolutions.com>
 <CYU3CFW08DAA.29DJY7SJYPJJZ@suppilovahvero>
 <2ba9a96e-f93b-48e2-9ca0-48318af7f9b1@kunbus.com>
 <ae3fecc4-7b76-4607-8749-045e17941923@infineon.com>
 <91f600ef-867b-4523-89be-1c0ba34f8a4c@kunbus.com>
 <CZA9CM3PDILC.82JMLUWMB6B7@seitikki> <CZA9GMC718HA.1JFHTTWV563IE@seitikki>
 <7a7f8f0c1b9d124bfc01b66082abf2d8445564ce.camel@HansenPartnership.com>
In-Reply-To: <7a7f8f0c1b9d124bfc01b66082abf2d8445564ce.camel@HansenPartnership.com>

On Wed Feb 21, 2024 at 12:37 PM UTC, James Bottomley wrote:
> On Tue, 2024-02-20 at 22:31 +0000, Jarkko Sakkinen wrote:
> >=20
> > 2. Because localities are not too useful these days given TPM2's
> > =C2=A0=C2=A0 policy mechanism
>
> Localitites are useful to the TPM2 policy mechanism.  When we get key
> policy in the kernel it will give us a way to create TPM wrapped keys
> that can only be unwrapped in the kernel if we run the kernel in a
> different locality from userspace (I already have demo patches doing
> this).

Let's keep this discussion in scope, please.

Removing useless code using registers that you might have some actually
useful use is not wrong thing to do. It is better to look at things from
clean slate when the time comes.

> >  I cannot recall out of top of my head can
> > =C2=A0=C2=A0 you have two localities open at same time.
>
> I think there's a misunderstanding about what localities are: they're
> effectively an additional platform supplied tag to a command.  Each
> command can therefore have one and only one locality.  The TPM doesn't

Actually this was not unclear at all. I even read the chapters from
Ariel Segall's yesterday as a refresher.

I was merely asking that if TPM_ACCESS_X is not properly cleared and you
se TPM_ACCESS_Y where Y < X how does the hardware react as the bug
report is pretty open ended and not very clear of the steps leading to
unwanted results.

With a quick check from [1] could not spot the conflict reaction but
it is probably there.

> submission).   I think the locality request/relinquish was modelled
> after some other HW, but I don't know what.

My wild guess: first implementation was made when TPM's became available
and there was no analytical thinking other than getting something that
runs :-)

> James

[1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific=
-Platform-TPM-Profile-for-TPM-2p0-v1p05p_r14_pub.pdf

BR, Jarkko


