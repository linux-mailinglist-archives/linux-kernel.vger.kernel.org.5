Return-Path: <linux-kernel+bounces-110282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802CE885C98
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A47741C22FE1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175DC8627E;
	Thu, 21 Mar 2024 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlfcfTh0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3943A86261;
	Thu, 21 Mar 2024 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711036292; cv=none; b=WRr9AmUdOTy8ihuRex2HnvYHqKzOYJAkMohMpjYECjmJDhYjkWZ67La6uH8v1RYT7YqY6DVjlZlb1g5O0VJWl89byQYpoCOp3dPAbOI0DSZq0XfmyKOzkcudO3CMItDKOhmAxVREcdTSA5o8TZGpbEOPtOchudv09uiNBDNrxCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711036292; c=relaxed/simple;
	bh=L+ezlLpknXEsEQmDMvyoEjsnzgAHFu4Z1IjpCnTiL2E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=iVuZsTPaUAqNBtm/gV6JSFlCUuk418eZZGdfa+ShRurWbee2QawJGA8o9TyisGfaHP3RFQikbNY3TUKFlwMJYVuay/0QwDLyo6rBVAsvUL4yxk7bnaCubesgKcHnIJ/dA0SIA7HSN9DZYwShtQvZA7XMPS9p+CGnnkZ5sxXIDcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlfcfTh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27AA9C433F1;
	Thu, 21 Mar 2024 15:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711036291;
	bh=L+ezlLpknXEsEQmDMvyoEjsnzgAHFu4Z1IjpCnTiL2E=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=AlfcfTh01ISixGjDcDgIRSwydLeh5ZF8jX8uFZzxsIRZZi6Ktg07imY+eCoGmUOVx
	 MNTP7MtIERvRNFTLQ9TvOSkDDD0q/gufWcvtgBvVkFIWeVWFJIHLX2FNUf5+Ji6N1L
	 zWxJIqlrOO4Af0/F1R9S0W63/ZwAfUbmTtdf8WMXlq/UKMTOyvdQLDliUbNbm0FXNq
	 x17Bl3oDr0H/7RnuMRMsHWuyt/Bwfu4ZXRl7RchcMmB7j8JTF9tBAnai71o/qiTb4h
	 fe0F9PAED4RhS96LpR3seCSdmqDR/tR+EVjPDSuJ0l23kv9aBg2NTpkoedObt1EVCv
	 I2RTaokxbIORg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Mar 2024 17:51:27 +0200
Message-Id: <CZZJQR121P7H.3QS68A6320S32@kernel.org>
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
To: "Stefan Berger" <stefanb@linux.ibm.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240320085601.40450-1-jarkko@kernel.org>
 <afc9471c-1c28-4384-82c1-29464ca1fb1f@linux.ibm.com>
In-Reply-To: <afc9471c-1c28-4384-82c1-29464ca1fb1f@linux.ibm.com>

On Wed Mar 20, 2024 at 6:15 PM EET, Stefan Berger wrote:
>
>
> On 3/20/24 04:56, Jarkko Sakkinen wrote:
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
> > v2:
> > - Fixed errors reported by Randy:
> >    https://lore.kernel.org/all/aed28265-d677-491a-a045-24b351854b24@inf=
radead.org/
> > - Improved the text a bit to have a better presentation.
> > ---
> >   Documentation/security/tpm/index.rst   |  1 +
> >   Documentation/security/tpm/tpm_tis.rst | 30 +++++++++++++++++++++++++=
+
> >   2 files changed, 31 insertions(+)
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
> > index 000000000000..b331813b3c45
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
>
> FIFO is the type. I am surprised you call it a 'name'. I would say TIS=20
> is the 'name'.

It's what the official specification calls it [1].


>
> > +tpm_tis_core dependent drivers. The prefix "tis" comes from the TPM In=
terface
>
> tis is a tla -- a three letter *acronym*. You aren't using it as a 'prefi=
x'.

I don't know what "tla" means.

>
> > +Specification, which is the hardware interface specification for TPM 1=
x chips.
>
> It's also available for TPM2.
=20
Yes, but TIS is the name used by the legacy specification.

>
> > +
> > +Communication is based on a 5 KiB buffer shared by the TPM chip throug=
h a
>
> I thought it was typically 4 KiB.

You are basing this on table 9 in [1]?

>
> > +hardware bus or memory map, depending on the physical wiring. The buff=
er is
> > +further split into five equal-size buffers, which provide equivalent s=
ets of
>
> equal-sized MMIO regions?

I'm not sure what spec you are referring to but [1] defines also other
communication paths.

>
> > +registers for communication between the CPU and TPM. These communicati=
on
> > +endpoints are called localities in the TCG terminology.
> > +
> > +When the kernel wants to send commands to the TPM chip, it first reser=
ves
> > +locality 0 by setting the requestUse bit in the TPM_ACCESS register. T=
he bit is
> > +cleared by the chip when the access is granted. Once it completes its
> > +communication, the kernel writes the TPM_ACCESS.activeLocality bit. Th=
is
> > +informs the chip that the locality has been relinquished.
> > +
> > +Pending localities are served in order by the chip in descending order=
, one at
> > +a time:
>
> I think I know what pending localities are because I have worked with=20
> this device but I am not sure whether the user can deduce this from the=
=20
> paragraph above. Also, why this particular detail when the driver only=20
> uses locality 0 and nobody is competing about access to localities?

This is pretty good summary that is IMHO somewhat useful.

You are welcome to contribute to the documentation but it has to start
from something.

>
> > +
> > +- Locality 0 has the lowest priority.
> > +- Locality 5 has the highest priority.
> > +
> > +Further information on the purpose and meaning of the localities can b=
e found
> > +in section 3.2 of the TCG PC Client Platform TPM Profile Specification=
.
o


[1] https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profi=
le-ptp-specification/

BR, Jarkko

