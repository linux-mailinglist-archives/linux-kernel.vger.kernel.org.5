Return-Path: <linux-kernel+bounces-131714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D963B898B00
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14DD81C223E6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2832A12AADB;
	Thu,  4 Apr 2024 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/AzJUXA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A4776033;
	Thu,  4 Apr 2024 15:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244178; cv=none; b=t+tImmtxCq5Nr+CZNp+uzHupo2YNCchV2i5/WKVaN7Ivatw5XWh1VKLMoSTswKQbbE+QjlzW9ml+0DqnQ4SjlLrbbnGTq7/IrVsqz3DYZmrUkXNwfW08bOdEwovtImOe2ffHfJFt+M6Z4k9yBimgLXfGxs0MWA6tDLENWsYkPiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244178; c=relaxed/simple;
	bh=mf7S4t8iN+Lv/e8q7/bkrS0IzTXYMUaXDsSXcEfbLh0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RmGbynjHsAxVrz0pYgTnOCKbIr0jC4ZkjwXvpIbxeI+3jr6FyN6lvIZ08UzfWcZpRwrgzLRnWvqYA82ir9uU+snh7ynMwPlTWQHw5V8z9+DNZ3gpWnpw7Xnv59BlOwq0pkxNjopUTo5fR7wNZ4rZFTGfohkRDaFppnEurz78Azs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/AzJUXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9519EC43390;
	Thu,  4 Apr 2024 15:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712244177;
	bh=mf7S4t8iN+Lv/e8q7/bkrS0IzTXYMUaXDsSXcEfbLh0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=H/AzJUXAZd6iOlzm2MPTHsp7gWlSIptMAhm/LvIQUUOeHA+K889jlH3qbBbx4PEDC
	 hWc3gBlf3yX9hszH8ar157IubNqzUabMuvFV5BLeeyV6qwd7E1WJNUDPzOycrL8yz/
	 qguqZyYKTLZxA2OO93RJBjQEJZRh2uj8b2tiyXja3cciyv47Bj7/1rLHyw73ThO2i8
	 LOY7y8jegD6ChjuCqZ2QMuZc+DRAb5JW5kk/uksuO0hYUPhDQ3qCDQf4ydq+wnSbL2
	 HxVcBNrvYS+HaTBNhgXjfEyS9dT7m1LeHn0H3XZSF1mzinbXl6dFrSBMD5Zqk8URYn
	 1s2njmpyk0d+w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Apr 2024 18:22:54 +0300
Message-Id: <D0BFWIX9KZIQ.191P9DWKCSHSX@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] char: tpm: handle HAS_IOPORT dependencies
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Arnd Bergmann" <arnd@kernel.org>, "Niklas Schnelle"
 <schnelle@linux.ibm.com>, "Peter Huewe" <peterhuewe@gmx.de>
X-Mailer: aerc 0.17.0
References: <20240404105840.3396821-1-schnelle@linux.ibm.com>
 <20240404105840.3396821-2-schnelle@linux.ibm.com>
 <95a63afe-ccd7-4551-86af-00b7fb0d8ff9@app.fastmail.com>
In-Reply-To: <95a63afe-ccd7-4551-86af-00b7fb0d8ff9@app.fastmail.com>

On Thu Apr 4, 2024 at 2:17 PM EEST, Arnd Bergmann wrote:
> On Thu, Apr 4, 2024, at 12:58, Niklas Schnelle wrote:
> > diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_inf=
ineon.c
> > index 9c924a1440a9..99c6e565ec8d 100644
> > --- a/drivers/char/tpm/tpm_infineon.c
> > +++ b/drivers/char/tpm/tpm_infineon.c
> > @@ -26,7 +26,9 @@
> >  #define	TPM_MAX_TRIES		5000
> >  #define	TPM_INFINEON_DEV_VEN_VALUE	0x15D1
> >=20
> > +#ifdef CONFIG_HAS_IOPORT
> >  #define TPM_INF_IO_PORT		0x0
> > +#endif
> >  #define TPM_INF_IO_MEM		0x1
>
> I think hiding this definition in this version of a patch
> results in a build failure because of the assignment that
> you are not stubbing out:
>
>         /* read IO-ports through PnP */
>         if (pnp_port_valid(dev, 0) && pnp_port_valid(dev, 1) &&
>             !(pnp_port_flags(dev, 0) & IORESOURCE_DISABLED)) {
>                 tpm_dev.iotype =3D TPM_INF_IO_PORT;
>
> I don't know what changed since the earlier versions I tested,
> or if I just missed it, but I think you either have to remove
> the #ifdef above or add another one in tpm_inf_pnp_probe().
>
>     Arnd

Thanks for the remark. I placed the current patch to my master branch
which is not too critical ('next' is mirrored to linux-next) if anyone
wants to try it out:

git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git

I can repeal and replace it with a newer one later on.

BR, Jarkko

