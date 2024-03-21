Return-Path: <linux-kernel+bounces-110335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 459D1885D5F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB3292816CA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D4C12CDAE;
	Thu, 21 Mar 2024 16:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itLbL/oc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C0E12CD9B;
	Thu, 21 Mar 2024 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711038303; cv=none; b=sPm+KHmszoEWvc5X1CyH77CExdIvPeCnA98ub2ETEAF2MajF/N5UO9HE7QIG9dQHHL1uOp/dlwdUdsrbLFlv67T/8jhIIN2iTUwYCZjqKCOYGxSXQ7ESOW0Jq32yQ/WxB3qr6a72iYDuc+OU/J4xzfOGg4HcN2lkVk+t1JpE7f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711038303; c=relaxed/simple;
	bh=Ld70etnbStLyDEyVmPvZO269q61/zWvdOuEcLXgGsW8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=itFkpbLLyG1kokG0Rz54dXjvL3nEA7FfikWZGV2zXlcgMBS7ZMvyLPQDSSH8ISVdZLQ+zj6kyEb6s05XLp5lVjw9+v8UeKeO/JbjRrv7aku/qz/LNwJjUyuNj6pJPZpgNTd8FVnZpq37zeQcB+qeXMS0dZH77gx81Y19GM99w3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itLbL/oc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F8EC433F1;
	Thu, 21 Mar 2024 16:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711038302;
	bh=Ld70etnbStLyDEyVmPvZO269q61/zWvdOuEcLXgGsW8=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=itLbL/ocioQSW2qzSRv9JP/IKWnYOiPZfdyiqJm+1JNxt+OOVdI11NUEo636NtlS2
	 lJjWnOFC5QCgiKfeU6LV8CoT884600fk7mK/z3gzpfW4Shyhuii7T1x85/ZanqyFNS
	 1t9XbfDDbYlLLaEzCszoUgx8DDj7hlWzZXOeIHQTeJz9v2CqV87gyXnNrfVy22BudT
	 pkoF7fISqQsD9bCdScCT2aFbxCG6cXQpoyp/t1HWE4wzpWZVBApa0tX4+AXe1b8fo1
	 B0CDHiwlTT3JIJ/oWGgFR4O6Z0/yWlBrpeL3xTKLLtBqw2bxo1Umi8Y61cJFBJ/6Xr
	 dPTWa+pbgUXww==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Mar 2024 18:24:58 +0200
Message-Id: <CZZKGEUSMI8F.CKFDVBIF1S4R@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>,
 <linux-integrity@vger.kernel.org>
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
In-Reply-To: <d957dbd3-4975-48d7-abc5-1a01c0959ea3@linux.ibm.com>

On Thu Mar 21, 2024 at 6:09 PM EET, Stefan Berger wrote:
>
>
> On 3/21/24 11:51, Jarkko Sakkinen wrote:
> > On Wed Mar 20, 2024 at 6:15 PM EET, Stefan Berger wrote:
> >>
> >>
> >> On 3/20/24 04:56, Jarkko Sakkinen wrote:
> >>> Based recent discussions on LKML, provide preliminary bits of tpm_tis=
_core
> >>> dependent drivers. Includes only bare essentials but can be extended =
later
> >>> on case by case. This way some people may even want to read it later =
on.
> >>>
> >>> Cc: Jonathan Corbet <corbet@lwn.net>
> >>> CC: Daniel P. Smith <dpsmith@apertussolutions.com>
> >>> Cc: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> >>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> >>> Cc: Peter Huewe <peterhuewe@gmx.de>
> >>> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> >>> Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
> >>> Cc: keyrings@vger.kernel.org
> >>> Cc: linux-doc@vger.kernel.org
> >>> Cc: linux-kernel@vger.kernel.org
> >>> Cc: linux-integrity@vger.kernel.org
> >>> Cc: Randy Dunlap <rdunlap@infradead.org>
> >>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> >>> ---
> >>> v2:
> >>> - Fixed errors reported by Randy:
> >>>     https://lore.kernel.org/all/aed28265-d677-491a-a045-24b351854b24@=
infradead.org/
> >>> - Improved the text a bit to have a better presentation.
> >>> ---
> >>>    Documentation/security/tpm/index.rst   |  1 +
> >>>    Documentation/security/tpm/tpm_tis.rst | 30 ++++++++++++++++++++++=
++++
> >>>    2 files changed, 31 insertions(+)
> >>>    create mode 100644 Documentation/security/tpm/tpm_tis.rst
> >>>
> >>> diff --git a/Documentation/security/tpm/index.rst b/Documentation/sec=
urity/tpm/index.rst
> >>> index fc40e9f23c85..f27a17f60a96 100644
> >>> --- a/Documentation/security/tpm/index.rst
> >>> +++ b/Documentation/security/tpm/index.rst
> >>> @@ -5,6 +5,7 @@ Trusted Platform Module documentation
> >>>    .. toctree::
> >>>   =20
> >>>       tpm_event_log
> >>> +   tpm_tis
> >>>       tpm_vtpm_proxy
> >>>       xen-tpmfront
> >>>       tpm_ftpm_tee
> >>> diff --git a/Documentation/security/tpm/tpm_tis.rst b/Documentation/s=
ecurity/tpm/tpm_tis.rst
> >>> new file mode 100644
> >>> index 000000000000..b331813b3c45
> >>> --- /dev/null
> >>> +++ b/Documentation/security/tpm/tpm_tis.rst
> >>> @@ -0,0 +1,30 @@
> >>> +.. SPDX-License-Identifier: GPL-2.0
> >>> +
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> >>> +TPM FIFO interface Driver
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> >>> +
> >>> +FIFO (First-In-First-Out) is the name of the hardware interface used=
 by the
> >>
> >> FIFO is the type. I am surprised you call it a 'name'. I would say TIS
> >> is the 'name'.
> >=20
> > It's what the official specification calls it [1].
> >=20
> >=20
> >>
> >>> +tpm_tis_core dependent drivers. The prefix "tis" comes from the TPM =
Interface
> >>
> >> tis is a tla -- a three letter *acronym*. You aren't using it as a 'pr=
efix'.
> >=20
> > I don't know what "tla" means.
> >=20
> >>
> >>> +Specification, which is the hardware interface specification for TPM=
 1.x chips.
> >>
> >> It's also available for TPM2.
> >  =20
> > Yes, but TIS is the name used by the legacy specification.
>
>
> The point is that TIS is not just a TPM 1.x interface but also used for=
=20
> TPM 2.


FIFO interface is what is  used in the spec so I'll stick to that.

> >=20
> >>
> >>> +
> >>> +Communication is based on a 5 KiB buffer shared by the TPM chip thro=
ugh a
> >>
> >> I thought it was typically 4 KiB.
> >=20
> > You are basing this on table 9 in [1]?
>
> Yes. See below.
>
> >=20
> >>
> >>> +hardware bus or memory map, depending on the physical wiring. The bu=
ffer is
> >>> +further split into five equal-size buffers, which provide equivalent=
 sets of
>
> If you are referring to the MMIO region between 0xfed4 0000 and 0xfed4=20
> 4fff as a buffer then you are talking about a **20kb** MMIO region=20
> (0x5000) that is **split** into equal-sized MMIO regions, each having=20
> 4kb (0x1000). Yes, that's the 4kb then but there that one is no 5kb=20
> 'further split into five equal-sized buffers' of presumably 1kb each.=20
> Each locality has a 0x1000 sized MMIO region.

Oops, true! I'll fix this part thanks, had a blind spot :-)

Will fix for v3.

BR, Jarkko

