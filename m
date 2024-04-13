Return-Path: <linux-kernel+bounces-143891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7899B8A3ED3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 23:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 083B9B20F86
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 21:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC70D56471;
	Sat, 13 Apr 2024 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToAAOQXU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241A1E542;
	Sat, 13 Apr 2024 21:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713044494; cv=none; b=YKRJ1u5lcu+WuHKEZ3Z+8uYkIB3P69nq04GlIYQxrbP/CAxkX1x4c0owQxODoxfALe+8eFUcqBGLJKYb6Drcbg/nOge5M1N8vdNvv/UQYSLEdUF4DnSu/HdS79KP38h4p6zquP8feb/N76K7q+emRDGTMiYThornFZ7lNNN9jUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713044494; c=relaxed/simple;
	bh=ZMcIxouqaKmGopD4LjyDkY37fHk0qCUz/R0GOM0XHUg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TsI9QhmvoSoGWQ6L8dkKYdZQvqyW9CRNUvs8XyXGZZydx3JRNS68AoxTfDcobIoRlrd7sQjph0FSR5/ueh/X8rW41yYWHNV1nOeQXDG5dB0iQ6sfbQJZFFNKBIik9N7J0Xj/hjAyRg7tUnWAgP47+T2POcQx2/miWhFCG4NmKbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToAAOQXU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2350EC113CD;
	Sat, 13 Apr 2024 21:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713044493;
	bh=ZMcIxouqaKmGopD4LjyDkY37fHk0qCUz/R0GOM0XHUg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ToAAOQXUhLrh9nCG0DBHIil5C1hzoy3H5Mi10fGBU7d9WE7fawotv31I4Xio4pCdv
	 JbMWYbsYHrdSFhiKeZoYF8SjkhmYOrvaOtmaHmSYYz0cG4r1jFzF9k0T4i5T5N/ZHK
	 fSFrrbTCfjGlTEmU30b4Ftc4VKqCt/+1s6E8LZejtrAzWWUQEsAJMvPEH6tDkLLfvF
	 MdZXRZvMydTvKy02/a48YhX+XzUHbxhnSOmRHwN5BGqKJuUfas+H2Hn5g5eMh2S0oT
	 SExamm1xJ2KdsWEfww8NAnt+l+wAWKw8xS7zfrc+BTSGmt1RhZz6CoQvjMAnEnfuu5
	 PFzpOf72b2tlw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 Apr 2024 00:41:29 +0300
Message-Id: <D0JBLACWBFZZ.2ZYOFBJVG5EVU@kernel.org>
Cc: "Alexander Steffen" <Alexander.Steffen@infineon.com>, "Daniel P . Smith"
 <dpsmith@apertussolutions.com>, "James Bottomley"
 <James.Bottomley@hansenpartnership.com>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "Jonathan Corbet" <corbet@lwn.net>, "Lino Sanfilippo"
 <l.sanfilippo@kunbus.com>, "Mimi Zohar" <zohar@linux.ibm.com>, "Peter
 Huewe" <peterhuewe@gmx.de>, "Randy Dunlap" <rdunlap@infradead.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] Documentation: tpm_tis
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Bagas Sanjaya" <bagasdotme@gmail.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240409190847.10869-1-jarkko@kernel.org>
 <20240409190847.10869-3-jarkko@kernel.org> <ZhfAYVLwoYAPnYbI@archie.me>
In-Reply-To: <ZhfAYVLwoYAPnYbI@archie.me>

On Thu Apr 11, 2024 at 1:50 PM EEST, Bagas Sanjaya wrote:
> On Tue, Apr 09, 2024 at 10:08:47PM +0300, Jarkko Sakkinen wrote:
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
> > +
> > +For legacy compliance the original MMIO driver is called tpm_tis and t=
he
> Did you mean "For historical reasons above ..."?

That would be better wording.

> > +framework for FIFO drivers is named as tpm_tis_core. The postfix "tis"=
 in
> > +tpm_tis comes from the TPM Interface Specification, which is the hardw=
are
> > +interface specification for TPM 1.x chips.
> > +
> > +Communication is based on a 20 KiB buffer shared by the TPM chip throu=
gh a
> > +hardware bus or memory map, depending on the physical wiring. The buff=
er is
> > +further split into five equal-size 4 KiB buffers, which provide equiva=
lent
> > +sets of registers for communication between the CPU and TPM. These
> > +communication endpoints are called localities in the TCG terminology.
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
> > +
> > +- Locality 0 has the lowest priority.
> > +- Locality 5 has the highest priority.
> > +
> > +Further information on the purpose and meaning of the localities can b=
e found
> > +in section 3.2 of the TCG PC Client Platform TPM Profile Specification=
.
> > +
> > +References
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +TCG PC Client Platform TPM Profile (PTP) Specification
> > +https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-prof=
ile-ptp-specification/
>
> Other than that,
>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>


Thanks! I'll apply this with the fix you proposed.

For everyone: this is by no means perfect. The point is to seed
something we can build on top of. So I leave it rather lacking stuff
than try to document every possible bells and whistle. This can be
then improved based on discussions and future patch sets.

BR, Jarkko

