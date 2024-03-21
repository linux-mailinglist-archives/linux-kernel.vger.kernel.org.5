Return-Path: <linux-kernel+bounces-110352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D0C885D95
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1DE281AEB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE2E12B7E;
	Thu, 21 Mar 2024 16:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pY10ZF/k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7138ABE6F;
	Thu, 21 Mar 2024 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711038953; cv=none; b=NLczad6a+W67B/Ff0+7OpqxTuNWWEVuhlE6lsbfZOkFvAc4LbQQASkq/3WI+FC6B6s9ZA9i1zeib4VFaBd6rvRn5rC0WgRyo4hBPIrBTyNKdqlfDCqhN4xEVQU3Zf3bEtzSNtvdjmu/kWxaHXJeGJVcuve+aYLYYnSUWRbPs2Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711038953; c=relaxed/simple;
	bh=q6TIVC1DLugr+5uXp6uTbF4gnwhZTC7lhWhpCJCilxU=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=sHK5/YxFHcVKOD4S40d2c3EKuj1yGDfkFaTn/dpsA3yMc9QuFGq2gZYFblUkwh6Fnkru+HYDXL/Sk8JK8TmvQknk710SP5OXuty8xK0TTELq0fSCHuvup2tEENFP75MT4GO5Ka1PnCTN0nZEdnTSV249XhHSU1Of82CDlRQqZKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pY10ZF/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1811EC433C7;
	Thu, 21 Mar 2024 16:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711038952;
	bh=q6TIVC1DLugr+5uXp6uTbF4gnwhZTC7lhWhpCJCilxU=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=pY10ZF/k5TrBvZTao5UgCEUwmL6cYyQJzwXARqWA7e2+YHF4bkVD+ifD/5VQf6ZD7
	 VRcu06eq3JkngTZaL+gcjmtgM6ZvWZIxWD5YF+asRXlUbVuf5SLk0MyPQQnxL0CtzM
	 ZGNWWiC8w33K1geBTFYKpV//Q6Id2FRPt5ptbh70OZsejyFIFCaZdyX0mM50Neo0Az
	 QS4/UJ72XWx49Kj1iax7MxNhZhCxLcX1UGK/dHAZjUEBRmZlgLC6bOLPodFdtZWmDb
	 /pkBV42X3KIuv3tOFy/LOeJYdeqFmuO/3SeMB8WN49L1ZKuprMzIwxhOunvrcrldif
	 /KLbFduDu3b7Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Mar 2024 18:35:48 +0200
Message-Id: <CZZKOPED6NBT.1SQX7TOJJ591D@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Stefan Berger"
 <stefanb@linux.ibm.com>, <linux-integrity@vger.kernel.org>
Cc: "Jonathan Corbet" <corbet@lwn.net>, "Daniel P . Smith"
 <dpsmith@apertussolutions.com>, "Lino Sanfilippo"
 <l.sanfilippo@kunbus.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Peter Huewe"
 <peterhuewe@gmx.de>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Alexander Steffen"
 <Alexander.Steffen@infineon.com>, <keyrings@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Randy Dunlap"
 <rdunlap@infradead.org>
Subject: Re: [PATCH v2] Documentation: tpm_tis
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240320085601.40450-1-jarkko@kernel.org>
 <afc9471c-1c28-4384-82c1-29464ca1fb1f@linux.ibm.com>
 <CZZJQR121P7H.3QS68A6320S32@kernel.org>
 <d957dbd3-4975-48d7-abc5-1a01c0959ea3@linux.ibm.com>
 <CZZKGEUSMI8F.CKFDVBIF1S4R@kernel.org>
 <CZZKMB1B4P0T.26A4YJHD9VJCP@kernel.org>
In-Reply-To: <CZZKMB1B4P0T.26A4YJHD9VJCP@kernel.org>

On Thu Mar 21, 2024 at 6:32 PM EET, Jarkko Sakkinen wrote:
> On Thu Mar 21, 2024 at 6:24 PM EET, Jarkko Sakkinen wrote:
> > On Thu Mar 21, 2024 at 6:09 PM EET, Stefan Berger wrote:
> > >
> > >
> > > On 3/21/24 11:51, Jarkko Sakkinen wrote:
> > > > On Wed Mar 20, 2024 at 6:15 PM EET, Stefan Berger wrote:
> > > >>
> > > >>
> > > >> On 3/20/24 04:56, Jarkko Sakkinen wrote:
> > > >>> Based recent discussions on LKML, provide preliminary bits of tpm=
_tis_core
> > > >>> dependent drivers. Includes only bare essentials but can be exten=
ded later
> > > >>> on case by case. This way some people may even want to read it la=
ter on.
> > > >>>
> > > >>> Cc: Jonathan Corbet <corbet@lwn.net>
> > > >>> CC: Daniel P. Smith <dpsmith@apertussolutions.com>
> > > >>> Cc: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> > > >>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > >>> Cc: Peter Huewe <peterhuewe@gmx.de>
> > > >>> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> > > >>> Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
> > > >>> Cc: keyrings@vger.kernel.org
> > > >>> Cc: linux-doc@vger.kernel.org
> > > >>> Cc: linux-kernel@vger.kernel.org
> > > >>> Cc: linux-integrity@vger.kernel.org
> > > >>> Cc: Randy Dunlap <rdunlap@infradead.org>
> > > >>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > >>> ---
> > > >>> v2:
> > > >>> - Fixed errors reported by Randy:
> > > >>>     https://lore.kernel.org/all/aed28265-d677-491a-a045-24b351854=
b24@infradead.org/
> > > >>> - Improved the text a bit to have a better presentation.
> > > >>> ---
> > > >>>    Documentation/security/tpm/index.rst   |  1 +
> > > >>>    Documentation/security/tpm/tpm_tis.rst | 30 ++++++++++++++++++=
++++++++
> > > >>>    2 files changed, 31 insertions(+)
> > > >>>    create mode 100644 Documentation/security/tpm/tpm_tis.rst
> > > >>>
> > > >>> diff --git a/Documentation/security/tpm/index.rst b/Documentation=
/security/tpm/index.rst
> > > >>> index fc40e9f23c85..f27a17f60a96 100644
> > > >>> --- a/Documentation/security/tpm/index.rst
> > > >>> +++ b/Documentation/security/tpm/index.rst
> > > >>> @@ -5,6 +5,7 @@ Trusted Platform Module documentation
> > > >>>    .. toctree::
> > > >>>   =20
> > > >>>       tpm_event_log
> > > >>> +   tpm_tis
> > > >>>       tpm_vtpm_proxy
> > > >>>       xen-tpmfront
> > > >>>       tpm_ftpm_tee
> > > >>> diff --git a/Documentation/security/tpm/tpm_tis.rst b/Documentati=
on/security/tpm/tpm_tis.rst
> > > >>> new file mode 100644
> > > >>> index 000000000000..b331813b3c45
> > > >>> --- /dev/null
> > > >>> +++ b/Documentation/security/tpm/tpm_tis.rst
> > > >>> @@ -0,0 +1,30 @@
> > > >>> +.. SPDX-License-Identifier: GPL-2.0
> > > >>> +
> > > >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > > >>> +TPM FIFO interface Driver
> > > >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > > >>> +
> > > >>> +FIFO (First-In-First-Out) is the name of the hardware interface =
used by the
> > > >>
> > > >> FIFO is the type. I am surprised you call it a 'name'. I would say=
 TIS
> > > >> is the 'name'.
> > > >=20
> > > > It's what the official specification calls it [1].
> > > >=20
> > > >=20
> > > >>
> > > >>> +tpm_tis_core dependent drivers. The prefix "tis" comes from the =
TPM Interface
> > > >>
> > > >> tis is a tla -- a three letter *acronym*. You aren't using it as a=
 'prefix'.
> > > >=20
> > > > I don't know what "tla" means.
> > > >=20
> > > >>
> > > >>> +Specification, which is the hardware interface specification for=
 TPM 1.x chips.
> > > >>
> > > >> It's also available for TPM2.
> > > >  =20
> > > > Yes, but TIS is the name used by the legacy specification.
> > >
> > >
> > > The point is that TIS is not just a TPM 1.x interface but also used f=
or=20
> > > TPM 2.
> >
> >
> > FIFO interface is what is  used in the spec so I'll stick to that.
>
> E.g. Table 15 - *FIFO* Interface Identifier Register
>
> Not *TIS* Inteface Identifier Register.
>
> I don't want to invent my own terminology here and this the spec
> that we usually refer in every possible discussion around the topic.

That table actually also clarifies this pretty well, see interface type:

0000 =E2=80=93 FIFO interface as defined in PTP for TPM 2.0 is active.
0001 =E2=80=93 CRB interface is active.
1111 =E2=80=93 FIFO interface as defined in TIS1.3 is active (all other fie=
lds
of this register are don=E2=80=99t care).

E.g. FIFO interface can be configured according to TIS 1.3 specification
but the interface is still referred as FIFO interface in the current
spec.

BR, Jarkko


