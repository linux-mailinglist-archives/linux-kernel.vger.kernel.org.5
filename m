Return-Path: <linux-kernel+bounces-91332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919A1870FA4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D084282995
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418727AE47;
	Mon,  4 Mar 2024 21:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLaWZax0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF2E46BA0;
	Mon,  4 Mar 2024 21:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709589475; cv=none; b=bM2+k4eOFnJ2OaIViXXjJwW2cvO0rHaKomH1sDyobUFk5PWY9bZvvqJB5+iNXwlWxVpURV/qs7B+paDbblFyXPri3BGNbNlhTLelfSyUtoIQLwSpo0taZ4XhxQZKTAaffzUPEg+QeVS3uNpmA2KV85X44yAykujTL6m/hMXl2JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709589475; c=relaxed/simple;
	bh=KiOKGu0IBKEf+hGEnUTRKLVdRvMzwj+gIS9cVh5qs2s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rV77SlctP0GJuQtGjuUWPAAmKMKziAm2gzBOLTRN0RZJ7YMjZOeTm3haZqVeHxoNi3HqDa0Fn4PmJz5M9kEYUcaW5Bp4xkwqxZVl367dvlkCtx3Er3JCY7YfgGEuL/j2OpJGugsaU+DHk5okToI+w+nM4f5Gd5iz1L/A19P4qS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLaWZax0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1513C433C7;
	Mon,  4 Mar 2024 21:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709589475;
	bh=KiOKGu0IBKEf+hGEnUTRKLVdRvMzwj+gIS9cVh5qs2s=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=jLaWZax0tddgv9Oni6Ktxklh+0fqbjyk2BAcfSTyqSxKtfO6WlhzmsTQ4to+ccTB2
	 ZAMHUTorWlLHe7plKIiyoECCZhAp1PZA6wKdf/j7fxx0rf3hDGWujZwk5igp+XxI5o
	 DTOtZNmiq6EW57op2GHUcAvc3uGbi6T9LMOn4DlswDCbSboJsl9maWRnyTqSXnhKpy
	 OaA/zqmm97Xm3rIDtDrDQqyWr001R8WJkVvSQsUuhRP0Wvi5TXUt6zZ96qi2uVHGVp
	 YkfwuMJeISK3JmRU7XvA9apl30kPJVuECf836TJxAwQFfOKkbz3y3jSutX3nYsUIAd
	 WhIjG0vexvxKA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 Mar 2024 23:57:50 +0200
Message-Id: <CZLAW0OE26P4.3QZ6ZSI0GMP2D@kernel.org>
Cc: "Jonathan Corbet" <corbet@lwn.net>, "Daniel P . Smith"
 <dpsmith@apertussolutions.com>, "Lino Sanfilippo"
 <l.sanfilippo@kunbus.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Peter Huewe"
 <peterhuewe@gmx.de>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Alexander Steffen"
 <Alexander.Steffen@infineon.com>, <keyrings@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH] Documentation: tpm_tis
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, <linux-doc@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240304212734.43213-1-jarkko@kernel.org>
In-Reply-To: <20240304212734.43213-1-jarkko@kernel.org>

Some remarks below that I noticed after sending this.

On Mon Mar 4, 2024 at 11:27 PM EET, Jarkko Sakkinen wrote:
> Based recent discussions on LKML, provide preliminary bits of tpm_tis_cor=
e

s/Based/ Based on/

> dependent drivers. Includes only bare essentials but can be extended late=
r
> on case by case. This way some people may even want to read it later on.
>
> Cc: Jonathan Corbet <corbet@lwn.net>
> CC: Daniel P. Smith <dpsmith@apertussolutions.com>
> Cc: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Peter Huewe <peterhuewe@gmx.de>
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
> Cc: keyrings@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-integrity@vger.kernel.org
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  Documentation/security/tpm/index.rst   |  1 +
>  Documentation/security/tpm/tpm_tis.rst | 30 ++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
>  create mode 100644 Documentation/security/tpm/tpm_tis.rst
>
> diff --git a/Documentation/security/tpm/index.rst b/Documentation/securit=
y/tpm/index.rst
> index fc40e9f23c85..f27a17f60a96 100644
> --- a/Documentation/security/tpm/index.rst
> +++ b/Documentation/security/tpm/index.rst
> @@ -5,6 +5,7 @@ Trusted Platform Module documentation
>  .. toctree::
> =20
>     tpm_event_log
> +   tpm_tis
>     tpm_vtpm_proxy
>     xen-tpmfront
>     tpm_ftpm_tee
> diff --git a/Documentation/security/tpm/tpm_tis.rst b/Documentation/secur=
ity/tpm/tpm_tis.rst
> new file mode 100644
> index 000000000000..3cec0216a169
> --- /dev/null
> +++ b/Documentation/security/tpm/tpm_tis.rst
> @@ -0,0 +1,30 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +TPM FIFO interface Driver
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +FIFO (First-In-First-Out) is the name of the hardware interface used by =
the
> +`tpm_tis_core` dependent drivers. The prefix "tis" is named after TPM
> +Interface Specification, which is the hardware interface specification f=
or
> +TPM 1.x chips.
> +
> +Communication is based on a 5 KiB buffer shared by the TPM chip through =
a
> +hardware bus or memory map. The buffer is further split to five equal si=
ze

s/to/into/

> +buffers, which provide equivalent sets of registers for communication
> +between CPU and TPM. The communication end points are called *localities=
*
> +in the TCG terminology.
> +
> +When a kernel wants to send a commands to the TPM chip, it first reserve=
s

s/a kernel/kernel/
s/a commands/commands/
> +locality 0 by setting `requestUse` bit in `TPM_ACCESS` register. The bit=
 is
> +cleared by the chip when the access is granted. Once completed its
> +communication, it sets `activeLocity` bit in the same register.

s/it sets/kernel relinquishes reservation by setting/

> +
> +Pending localities are served in order by the chip descending orderm and
> +one at a time:

"Pending localities are served in descending order and one at a time:"

> +
> +- Locality 0 has the lowest priority.
> +- Locality 5 has the highest priotiy.
> +
> +Further information on purpose and meaning of the localities can be foun=
d
> +from section 3.2 of TCG PC Client Platform TPM Profile Specification.

s/on purpose/on the purpose/

BR, Jarkko


