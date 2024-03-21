Return-Path: <linux-kernel+bounces-110345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C04C1885D80
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7A2284DDB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A40314293;
	Thu, 21 Mar 2024 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKM3agjN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6D3C2E9;
	Thu, 21 Mar 2024 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711038765; cv=none; b=gH4m6Ws8t+daCzsHj0EDjbN6Ro9njHAKDUCIBLy9gU8ICvcmTVPESlC0TI5VBuN7cOVI/r+cMFZAe4gEA7a9ZGgr8ZrYuU3opezJzJ8ixpDiGmxcPPlZjIaY9jIoV+dmS+yI66MFU46P+4Xp7k+sZdeGmZsVEni2pBClh+eERsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711038765; c=relaxed/simple;
	bh=/e5J656lgf7Nf4pNZzEd1EaQ77TPACnuex7LThUtq8Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=kiu6v40sZqxGYf7GhwesIoQ/PQ4Lm65jKi2U0tfdVrrjzK6CGFMUGLuMo+lU1+/WIcrxsKM07fLToP/mgF6u1K+UVYsUaHJIrQsGQnsMadY9qgCdfNC0WadwSqx1Pfj0xK6rGiFbCWSJ7ADl+x5gTuyJWSQLY5zh9v2GObFJbV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKM3agjN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B16C433C7;
	Thu, 21 Mar 2024 16:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711038764;
	bh=/e5J656lgf7Nf4pNZzEd1EaQ77TPACnuex7LThUtq8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mKM3agjNhdaGVD54sCnIr2T4jmd4qB8L9BWTjU32qEByYKAjKzm9D1M06ZYKYp2N4
	 qHQ4e+ctSdvvsm+uUQ6HLJe0WsUiDBAdVSYw2GJzPX8XFqGNFcV0wIvaLtkvsK2VhM
	 QKp5gWdoNZCMqR5qBADX29F35/CaBeNv1JA+NunyCIJt978uwF2Zhq7fgcXOzhs39V
	 kzNFAniXu2hFQ0Sh7EGOCCDZG3xghllrnkbWzqeHEqyuM0Lu05x6xnmVwziOxZcHMU
	 +xC3DBpR6ErAd8jO4TFoXSEs+7iO0V8lMy9oX2qZNFjW68O4saww22rbJN8l1SCF08
	 E82jqlhaPIpyg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Mar 2024 18:32:40 +0200
Message-Id: <CZZKMB1B4P0T.26A4YJHD9VJCP@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
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
X-Mailer: aerc 0.17.0
References: <20240320085601.40450-1-jarkko@kernel.org>
 <afc9471c-1c28-4384-82c1-29464ca1fb1f@linux.ibm.com>
 <CZZJQR121P7H.3QS68A6320S32@kernel.org>
 <d957dbd3-4975-48d7-abc5-1a01c0959ea3@linux.ibm.com>
 <CZZKGEUSMI8F.CKFDVBIF1S4R@kernel.org>
In-Reply-To: <CZZKGEUSMI8F.CKFDVBIF1S4R@kernel.org>

On Thu Mar 21, 2024 at 6:24 PM EET, Jarkko Sakkinen wrote:
> On Thu Mar 21, 2024 at 6:09 PM EET, Stefan Berger wrote:
> >
> >
> > On 3/21/24 11:51, Jarkko Sakkinen wrote:
> > > On Wed Mar 20, 2024 at 6:15 PM EET, Stefan Berger wrote:
> > >>
> > >>
> > >> On 3/20/24 04:56, Jarkko Sakkinen wrote:
> > >>> Based recent discussions on LKML, provide preliminary bits of tpm_t=
is_core
> > >>> dependent drivers. Includes only bare essentials but can be extende=
d later
> > >>> on case by case. This way some people may even want to read it late=
r on.
> > >>>
> > >>> Cc: Jonathan Corbet <corbet@lwn.net>
> > >>> CC: Daniel P. Smith <dpsmith@apertussolutions.com>
> > >>> Cc: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> > >>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > >>> Cc: Peter Huewe <peterhuewe@gmx.de>
> > >>> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> > >>> Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
> > >>> Cc: keyrings@vger.kernel.org
> > >>> Cc: linux-doc@vger.kernel.org
> > >>> Cc: linux-kernel@vger.kernel.org
> > >>> Cc: linux-integrity@vger.kernel.org
> > >>> Cc: Randy Dunlap <rdunlap@infradead.org>
> > >>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > >>> ---
> > >>> v2:
> > >>> - Fixed errors reported by Randy:
> > >>>     https://lore.kernel.org/all/aed28265-d677-491a-a045-24b351854b2=
4@infradead.org/
> > >>> - Improved the text a bit to have a better presentation.
> > >>> ---
> > >>>    Documentation/security/tpm/index.rst   |  1 +
> > >>>    Documentation/security/tpm/tpm_tis.rst | 30 ++++++++++++++++++++=
++++++
> > >>>    2 files changed, 31 insertions(+)
> > >>>    create mode 100644 Documentation/security/tpm/tpm_tis.rst
> > >>>
> > >>> diff --git a/Documentation/security/tpm/index.rst b/Documentation/s=
ecurity/tpm/index.rst
> > >>> index fc40e9f23c85..f27a17f60a96 100644
> > >>> --- a/Documentation/security/tpm/index.rst
> > >>> +++ b/Documentation/security/tpm/index.rst
> > >>> @@ -5,6 +5,7 @@ Trusted Platform Module documentation
> > >>>    .. toctree::
> > >>>   =20
> > >>>       tpm_event_log
> > >>> +   tpm_tis
> > >>>       tpm_vtpm_proxy
> > >>>       xen-tpmfront
> > >>>       tpm_ftpm_tee
> > >>> diff --git a/Documentation/security/tpm/tpm_tis.rst b/Documentation=
/security/tpm/tpm_tis.rst
> > >>> new file mode 100644
> > >>> index 000000000000..b331813b3c45
> > >>> --- /dev/null
> > >>> +++ b/Documentation/security/tpm/tpm_tis.rst
> > >>> @@ -0,0 +1,30 @@
> > >>> +.. SPDX-License-Identifier: GPL-2.0
> > >>> +
> > >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > >>> +TPM FIFO interface Driver
> > >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > >>> +
> > >>> +FIFO (First-In-First-Out) is the name of the hardware interface us=
ed by the
> > >>
> > >> FIFO is the type. I am surprised you call it a 'name'. I would say T=
IS
> > >> is the 'name'.
> > >=20
> > > It's what the official specification calls it [1].
> > >=20
> > >=20
> > >>
> > >>> +tpm_tis_core dependent drivers. The prefix "tis" comes from the TP=
M Interface
> > >>
> > >> tis is a tla -- a three letter *acronym*. You aren't using it as a '=
prefix'.
> > >=20
> > > I don't know what "tla" means.
> > >=20
> > >>
> > >>> +Specification, which is the hardware interface specification for T=
PM 1.x chips.
> > >>
> > >> It's also available for TPM2.
> > >  =20
> > > Yes, but TIS is the name used by the legacy specification.
> >
> >
> > The point is that TIS is not just a TPM 1.x interface but also used for=
=20
> > TPM 2.
>
>
> FIFO interface is what is  used in the spec so I'll stick to that.

E.g. Table 15 - *FIFO* Interface Identifier Register

Not *TIS* Inteface Identifier Register.

I don't want to invent my own terminology here and this the spec
that we usually refer in every possible discussion around the topic.

BR, Jarkko

