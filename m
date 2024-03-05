Return-Path: <linux-kernel+bounces-91516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FD3871283
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0901F23B2E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D67C18026;
	Tue,  5 Mar 2024 01:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSzLJu53"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E162F43;
	Tue,  5 Mar 2024 01:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709603566; cv=none; b=fiyyAG7Gyqizo9cc8QXKhnTqmC9Qj59eS9jGDrdoiK3y3+YbT5HkqxboGdQx45Vv2Nv5EBukpa1Y6vK8Gby+xq1uduV2JAk2LN2M5BTVX+DEyv1hP2gvyhnMSnf1lnhxF9VKsOks9xr66+ixYY9OhXdkNkEWg+FLYSKcmDhObHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709603566; c=relaxed/simple;
	bh=GRusyfa8TF2Nxs4bQB9i2a/gKinpT0tnMyNb3mj5cYE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=EQGXcWBwrLlj5jHMPssAc/2tCAX5WQYRy3DwATWg2T9PFF7nsiEDnoDW1VKzkI3pkNoXg0bn+jEKx8t/hDgagvRQfdZRRvCGoo/BrnAQSLwjD5vVWNggRxXDM2b1wRmDlZUGONSapA0NxlqC8EhN/1TlfCRQ0a0Yz89shS9cKlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSzLJu53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BEDC433F1;
	Tue,  5 Mar 2024 01:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709603566;
	bh=GRusyfa8TF2Nxs4bQB9i2a/gKinpT0tnMyNb3mj5cYE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=nSzLJu53wk1f1qMdYraehDndWs5Mo7yDzC6+kuwoc2efv4CimLQg4plE4s9+yR4gb
	 jTpE1cOz9iKYGdYFkDi1JdfOObk2dJ4OwfIYNsQzkpk7sdzVrwUYNzaZD4CA301ShZ
	 05MzEAFbN3DeADUIRitKnOvf8Hg5zw4Ax3zkCL9pmKZqWX92h7RT122GoQ8vJY3YyL
	 C/73Y1D7B+lk5vHgm1Z8IK8SnTidEQJprV46M/7RQsq8i4/DjzBIOPHWuA7MCWD7gq
	 aVAXBuf08xk+mlp+IzF4QrMVsZ2SkR7FMMbAwmV+x8zakfguT/xcQQ4TwW7GnPiifb
	 tPhSJOgArc0Ag==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Mar 2024 03:52:41 +0200
Message-Id: <CZLFVTVPBFB4.3IIZULN3LKZGI@kernel.org>
Subject: Re: [PATCH] Documentation: tpm_tis
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Randy Dunlap" <rdunlap@infradead.org>, <linux-doc@vger.kernel.org>
Cc: "Jonathan Corbet" <corbet@lwn.net>, "Daniel P . Smith"
 <dpsmith@apertussolutions.com>, "Lino Sanfilippo"
 <l.sanfilippo@kunbus.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Peter Huewe"
 <peterhuewe@gmx.de>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Alexander Steffen"
 <Alexander.Steffen@infineon.com>, <keyrings@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240304212734.43213-1-jarkko@kernel.org>
 <aed28265-d677-491a-a045-24b351854b24@infradead.org>
In-Reply-To: <aed28265-d677-491a-a045-24b351854b24@infradead.org>

On Tue Mar 5, 2024 at 12:53 AM EET, Randy Dunlap wrote:
>
>
> On 3/4/24 13:27, Jarkko Sakkinen wrote:
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
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> >  Documentation/security/tpm/index.rst   |  1 +
> >  Documentation/security/tpm/tpm_tis.rst | 30 ++++++++++++++++++++++++++
> >  2 files changed, 31 insertions(+)
> >  create mode 100644 Documentation/security/tpm/tpm_tis.rst
> >=20
>
> > diff --git a/Documentation/security/tpm/tpm_tis.rst b/Documentation/sec=
urity/tpm/tpm_tis.rst
> > new file mode 100644
> > index 000000000000..3cec0216a169
> > --- /dev/null
> > +++ b/Documentation/security/tpm/tpm_tis.rst
> > @@ -0,0 +1,30 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > +TPM FIFO interface Driver
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > +
> > +FIFO (First-In-First-Out) is the name of the hardware interface used b=
y the
> > +`tpm_tis_core` dependent drivers. The prefix "tis" is named after TPM
> > +Interface Specification, which is the hardware interface specification=
 for
> > +TPM 1.x chips.
> > +
> > +Communication is based on a 5 KiB buffer shared by the TPM chip throug=
h a
> > +hardware bus or memory map. The buffer is further split to five equal =
size
> > +buffers, which provide equivalent sets of registers for communication
> > +between CPU and TPM. The communication end points are called *localiti=
es*
> > +in the TCG terminology.
> > +
> > +When a kernel wants to send a commands to the TPM chip, it first reser=
ves
> > +locality 0 by setting `requestUse` bit in `TPM_ACCESS` register. The b=
it is
> > +cleared by the chip when the access is granted. Once completed its
> > +communication, it sets `activeLocity` bit in the same register.
>
>       Is that              activeLocality ?

Yes.

>
> > +
> > +Pending localities are served in order by the chip descending orderm a=
nd
> > +one at a time:
> > +
> > +- Locality 0 has the lowest priority.
> > +- Locality 5 has the highest priotiy.
>
>                                 priority.
>
> > +
> > +Further information on purpose and meaning of the localities can be fo=
und
> > +from section 3.2 of TCG PC Client Platform TPM Profile Specification.

Thanks for the remarks. Too many typos but at least I think the story is
is understandable and describes pretty well key elements of tpm_tis_core.

BR, Jarkko

