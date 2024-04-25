Return-Path: <linux-kernel+bounces-158006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F228B1A07
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352D01F24EFB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 04:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112D539FD7;
	Thu, 25 Apr 2024 04:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUFvEoHA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D5335F0C;
	Thu, 25 Apr 2024 04:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714020610; cv=none; b=gJMbXSmnyjFko6O/dPlL4EnhBP4EJpsOHmunwpjKgr4Op5qlMOpDi05Jtv289RH/2fm+PflsBPaEgS2KHPwQh9ggBup44soOj8Q28WmE3WeO33VHT35znEUF3iY7R/AYEiaibi7wj1ynsHcdoHiTNM8C2thaRH32DOGSWmexcC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714020610; c=relaxed/simple;
	bh=vi1NdzYR3K7bIhRidGu6Jw31GKlJa67y6775qr/tFeY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=llSR7SVgOHiw57EJuE1QhZlfaPm+AZH0Pjn7m8k2fTNGqfIERPw8i/M099ra3CApJ5EZLsF2QCKJH8q5hixOpG15XtSi3p5U9iPKCoHuwb0xRd7MROEE5dlvZcE7dRABCIlAMWBBlBEaR6jiwZkD6jnx/5Zi6AY26NgJIrZsVwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUFvEoHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83F9C113CC;
	Thu, 25 Apr 2024 04:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714020609;
	bh=vi1NdzYR3K7bIhRidGu6Jw31GKlJa67y6775qr/tFeY=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=hUFvEoHAAnvHmwO5hhpYt6YnDOT1AzDcYkoNypUB/ZCKvPqXSJo5klNoEI7D61kwG
	 Y6Uo87dHMg60h5ptPzW2pTmU1+smuxeF2ZpU/Lw6d6chBUeszm7hkdXOQ0Wwiu/xQl
	 HZCcXjivMharCTttbDUNiGPSxsufuhg+0bd+wxgdy6C/UidJDXfdYHNpxHqoma2HnU
	 jZdhr3JQVwazfZ1ULmTbujzaU7b+C1+FneXegjIhGGb/EUrmx/hs1k4erLkZZW3/E2
	 ckgiOWWtxyEAfZJQdaK220BOygj0CrHZty/t7mLTbjHc8UmEwoCj2t+zin65A1fKbs
	 UM7pFaivXZckQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Apr 2024 07:50:05 +0300
Message-Id: <D0SXLFYAGQVS.1HPM5FELWRYRT@kernel.org>
Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH v4 01/71] tpm: Switch to new Intel CPU model defines
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Tony Luck"
 <tony.luck@intel.com>, "Borislav Petkov" <bp@alien8.de>, "Peter Huewe"
 <peterhuewe@gmx.de>
X-Mailer: aerc 0.17.0
References: <20240424181245.41141-1-tony.luck@intel.com>
 <20240424181444.41174-1-tony.luck@intel.com>
 <D0SXK2EUPF4G.M74BAD7ZDET9@kernel.org>
In-Reply-To: <D0SXK2EUPF4G.M74BAD7ZDET9@kernel.org>

On Thu Apr 25, 2024 at 7:48 AM EEST, Jarkko Sakkinen wrote:
> On Wed Apr 24, 2024 at 9:14 PM EEST, Tony Luck wrote:
> > New CPU #defines encode vendor and family as well as model.
> >
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> >  drivers/char/tpm/tpm.h          | 2 +-
> >  drivers/char/tpm/tpm_tis_core.h | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > index 61445f1dc46d..7b38ce007bdc 100644
> > --- a/drivers/char/tpm/tpm.h
> > +++ b/drivers/char/tpm/tpm.h
> > @@ -28,7 +28,7 @@
> >  #include <linux/tpm_eventlog.h>
> > =20
> >  #ifdef CONFIG_X86
> > -#include <asm/intel-family.h>
> > +#include <asm/cpu_device_id.h>
> >  #endif
> > =20
> >  #define TPM_MINOR		224	/* officially assigned */
> > diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis=
_core.h
> > index 13e99cf65efe..c940fd18988e 100644
> > --- a/drivers/char/tpm/tpm_tis_core.h
> > +++ b/drivers/char/tpm/tpm_tis_core.h
> > @@ -210,7 +210,7 @@ static inline int tpm_tis_verify_crc(struct tpm_tis=
_data *data, size_t len,
> >  static inline bool is_bsw(void)
> >  {
> >  #ifdef CONFIG_X86
> > -	return ((boot_cpu_data.x86_model =3D=3D INTEL_FAM6_ATOM_AIRMONT) ? 1 =
: 0);
> > +	return ((boot_cpu_data.x86_vfm =3D=3D INTEL_ATOM_AIRMONT) ? 1 : 0);

Umh I guess one could complain about extra parentheses ;-)

Not sure if I care, if no other updates needed, probably don't.

> >  #else
> >  	return false;
> >  #endif
>
> +1
>
> BR, Jarkko

BR, Jarkko

