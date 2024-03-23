Return-Path: <linux-kernel+bounces-112449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2450C8879FB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 19:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9003F1F216C0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 18:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297735811C;
	Sat, 23 Mar 2024 18:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGmppBV6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4617C63D;
	Sat, 23 Mar 2024 18:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711219253; cv=none; b=F/4s/IBf2ZF3pgZKdykjBUi3BBtwjqXR0Lzc6NmW5BgmFKNnyJhuEeKw6Ijhr7iYBzg9lj+YUe8zIKxUf3lnj/Kw83rP9lhjyXLjyPpVlu/Ly/9qN8LP3Uw5Rb31vRZHWtOOTeMpSikcd8A0sIldE0RuK82qiWQcgB43HrVxN5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711219253; c=relaxed/simple;
	bh=mZVWkf5PRMU/jIt7zWsZvfPFC51ACZxEQ4jt8kEXNeU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jHhK5zRXItxuja5o24NgdgFzHMIIm68GL53/8W+HZTtRgjByswUjjgTTGdU3jzpI3QLeyanNd6Cl6tdem3eRlyLJW38fkOjw9TNR0ZXYstvuRpMvQ85Rh6WkVMWkrsdtK1USzhm827bD9za/ynWL7u85KpgXphWowARb55tTDCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGmppBV6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005AFC433C7;
	Sat, 23 Mar 2024 18:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711219252;
	bh=mZVWkf5PRMU/jIt7zWsZvfPFC51ACZxEQ4jt8kEXNeU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=mGmppBV6AflYiN7F3XzcCV+wLG8tivBw575Juq7TkQ2VDH0FQZGtuth1Nx8/7+Chi
	 Cn7UIRuhYzdg6XxwpBGuTWgSDrw2RrxBAAlNRX3eErCV+vpdFKrnYRX7WwQ9d2bR9y
	 RJL3QGguQEZELZo3x2Z1VWMNuQDkkvxEK8vugI4TbkE/hpN1WoQ5o6jbBAl9JCP9D9
	 CzfH3KteLci9rfCSbh+jFcojF+Jgf+Cgo677NhtyDfhNJHG58PEUz4HWGUb/sLfa3g
	 cuIXhFEq5T3vdAxfxew0SDDoDf+nV9sB6Tazgbsq/j5dwghbe7zkrTN4ezlEO2zWYr
	 eX5pe9QASE+wA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Mar 2024 20:40:48 +0200
Message-Id: <D01CLI2TC5SZ.1A48PDHM5F3UA@kernel.org>
Cc: "Jonathan Corbet" <corbet@lwn.net>, "Lino Sanfilippo"
 <l.sanfilippo@kunbus.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Peter Huewe"
 <peterhuewe@gmx.de>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Alexander Steffen"
 <Alexander.Steffen@infineon.com>, <keyrings@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Richard Cochran" <richardcochran@gmail.com>,
 "open list:PTP HARDWARE CLOCK SUPPORT:Keyword:(?:b|_)ptp(?:b|_)"
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v4] Documentation: tpm_tis
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240322123542.24158-1-jarkko@kernel.org>
 <5a494de5-b004-440c-bcdf-7bdfa3a8c508@apertussolutions.com>
In-Reply-To: <5a494de5-b004-440c-bcdf-7bdfa3a8c508@apertussolutions.com>

On Sat Mar 23, 2024 at 2:39 AM EET, Daniel P. Smith wrote:
> Hi Jarkko,
>
> On 3/22/24 08:35, Jarkko Sakkinen wrote:
> > Based recent discussions on LKML, provide preliminary bits of tpm_tis_c=
ore
> > dependent drivers. Includes only bare essentials but can be extended la=
ter
> > on case by case. This way some people may even want to read it later on=
.
> >=20
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > CC: Daniel P. Smith <dpsmith@apertussolutions.com>
> > Cc: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Peter Huewe <peterhuewe@gmx.de>
> > Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
> > Cc: keyrings@vger.kernel.org
> > Cc: linux-doc@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-integrity@vger.kernel.org
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v4:
> > - Extended the text to address some of Stefan's concerns with v2.
> > - Had to unfortunately remove Randy's reviewed-by because of this, give=
n
> >    the amount of text added.
> > v3:
> > - Fixed incorrect buffer size:
> >    https://lore.kernel.org/linux-integrity/d957dbd3-4975-48d7-abc5-1a01=
c0959ea3@linux.ibm.com/
> > v2:
> > - Fixed errors reported by Randy:
> >    https://lore.kernel.org/all/aed28265-d677-491a-a045-24b351854b24@inf=
radead.org/
> > - Improved the text a bit to have a better presentation.
> > ---
> >   Documentation/security/tpm/index.rst   |  1 +
> >   Documentation/security/tpm/tpm_tis.rst | 46 +++++++++++++++++++++++++=
+
> >   2 files changed, 47 insertions(+)
> >   create mode 100644 Documentation/security/tpm/tpm_tis.rst
> >=20
> > diff --git a/Documentation/security/tpm/index.rst b/Documentation/secur=
ity/tpm/index.rst
> > index fc40e9f23c85..f27a17f60a96 100644
> > --- a/Documentation/security/tpm/index.rst
> > +++ b/Documentation/security/tpm/index.rst
> > @@ -5,6 +5,7 @@ Trusted Platform Module documentation
> >   .. toctree::
> >  =20
> >      tpm_event_log
> > +   tpm_tis
> >      tpm_vtpm_proxy
> >      xen-tpmfront
> >      tpm_ftpm_tee
> > diff --git a/Documentation/security/tpm/tpm_tis.rst b/Documentation/sec=
urity/tpm/tpm_tis.rst
> > new file mode 100644
> > index 000000000000..b448ea3db71d
> > --- /dev/null
> > +++ b/Documentation/security/tpm/tpm_tis.rst
> > @@ -0,0 +1,46 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > +TPM FIFO interface driver
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > +
> > +TCG PTP Specification defines two interface types: FIFO and CRB. The f=
ormer is
>
> I believe in the spec, the authors were specific to classify these as=20
> software interfaces. Not sure if you would want to carry that=20
> distinction into this document.
>
> > +based on sequenced read and write operations,  and the latter is based=
 on a
> > +buffer containing the full command or response.
> > +
> > +FIFO (First-In-First-Out) interface is used by the tpm_tis_core depend=
ent
> > +drivers. Originally Linux had only a driver called tpm_tis, which cove=
red
> > +memory mapped (aka MMIO) interface but it was later on extended to cov=
er other
> > +physical interfaces supported by the TCG standard.
>
> Would it be worth clarifying here that one of those interfaces is=20
> defined in the Mobile TPM specification, which also refers to its=20
> interface as the CRB interface. In the past, this has caused great=20
> confusion when working with individuals from the embedded community,=20
> e.g., Arm. The Mobile TPM CRB interface, which can also be found being=20
> used by some generations of AMD fTPM, is a doorbell style interface=20
> using general-purpose memory. I would also point out that the Mobile TPM=
=20
> CRB interface does not provide for the concept of localities.

I don't necessarily disagree but it is out of scope for this. I'm not
sure tho why "mobile" CRB would ever need that sort of separate
dicussion.

Some CRB implementations have localities some don't, and also fTPM
implementations on x86 vary, no need to state that separately for
mobile.

> In relation to the MMIO backed interfaces, I have heard comment that the=
=20
> software interfaces were not meant to require the physical interface be=
=20
> MMIO. In fact, in section 9.2, "Hardware Implementation of a TPM in a PC=
=20
> Client Platform", there is a comment about Locality 4 registers being=20
> accessible via an implementation specific mechanism other than MMIO.=20
> Additionally, there were some discussions about clarifying the PTP on=20
> how the software interfaces might be expected to work for a=20
> general-purpose memory backed implementation.

So what is the error in the current want, i.e. what do you want to
change? I think this type of stuff can be extended but I don't want
to pollute this with too much detail at this point.

Only what matters for daily kernel development as reminder is what
this type of doc's should contain.

BR, Jarkko

