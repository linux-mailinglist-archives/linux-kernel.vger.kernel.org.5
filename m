Return-Path: <linux-kernel+bounces-79113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0B2861DBD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB911C216FA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDDC1482FF;
	Fri, 23 Feb 2024 20:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhFn2yva"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F165A1493AC;
	Fri, 23 Feb 2024 20:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708720820; cv=none; b=kxdx9YQ05eVxueOFrOXkRZwhx9KjDrqpRcFWJfKF2dpiwl19MzqUu2BwGUpFUSK5iW0I/qv32Ul1JL5I/rpHGhisIzrpA/e9AOzLpXI60jUA1V8H91u/GKXTBSlMtN2GVfrg0VjgUbEImGWnUWBJugdUR86jrGdRpHER1tI61ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708720820; c=relaxed/simple;
	bh=cQoOBgY4tcjDKxqfdCnMcuDh/0pRDs6uSRyPRcffAXo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=HWPsay0TEv6C/WvLC59nSxJN/nTsQie1tihWzm7H6V1lbHR2irMEhftl2BX4vAITrhiq0ihKoS5T/Wu2jyfWGxJVUDMBdZIXCBD0T140EX1EXOyrxt58VHkHrdLlkDng1cv6wSqJvmEf/Y6iMIqLvdy/di9CK396Z1O0ppGbxag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhFn2yva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99411C43390;
	Fri, 23 Feb 2024 20:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708720818;
	bh=cQoOBgY4tcjDKxqfdCnMcuDh/0pRDs6uSRyPRcffAXo=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=VhFn2yvah2dq+Y+oSziEF1q1OwlMjoJo2OkiQXeQlI69CvBOe6y+yscS0Jt6nbBHW
	 NzJploAd+rNARnClHde8bURRRviV0jCwer2HH96t84bao/DzzF7s5OsTNZ78yFYoSX
	 srqLvJPUU9kXHIZjS86ZxPy7ut9rSkXGreeh4MTB5DDHPHZWSQilvXSa05hAV6zuWV
	 VutX+rGHrkiFP4mnhomsaMlIGUvXuGJ6ntSeMVqiX53zyZbThDA0fA3a2tjz/UxIvA
	 k4TIFtk+Usjgk+9b9DuxfVHIoWU6kiQjSsmBJz+ZkzokGj6U13sLsHsdRbf3SuXzNr
	 qS5cD1XrGkRdA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Feb 2024 22:40:14 +0200
Message-Id: <CZCQZ5FTCCB5.GIN1NU7G5S0@suppilovahvero>
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Lino Sanfilippo"
 <l.sanfilippo@kunbus.com>, "Alexander Steffen"
 <Alexander.Steffen@infineon.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Sasha
 Levin" <sashal@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Cc: "Ross Philipson" <ross.philipson@oracle.com>, "Kanth Ghatraju"
 <kanth.ghatraju@oracle.com>, "Peter Huewe" <peterhuewe@gmx.de>
Subject: Re: [PATCH 1/3] tpm: protect against locality counter underflow
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.15.2
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
 <20240131170824.6183-2-dpsmith@apertussolutions.com>
 <CYU3CFW08DAA.29DJY7SJYPJJZ@suppilovahvero>
 <2ba9a96e-f93b-48e2-9ca0-48318af7f9b1@kunbus.com>
 <ae3fecc4-7b76-4607-8749-045e17941923@infineon.com>
 <91f600ef-867b-4523-89be-1c0ba34f8a4c@kunbus.com>
 <CZA9CM3PDILC.82JMLUWMB6B7@seitikki> <CZA9GMC718HA.1JFHTTWV563IE@seitikki>
 <7a7f8f0c1b9d124bfc01b66082abf2d8445564ce.camel@HansenPartnership.com>
 <CZB0I9OAGNHT.1HTSJU3925RBY@seitikki>
 <f1a54774-9a44-4400-91e2-358facc12191@apertussolutions.com>
In-Reply-To: <f1a54774-9a44-4400-91e2-358facc12191@apertussolutions.com>

On Fri Feb 23, 2024 at 3:57 AM EET, Daniel P. Smith wrote:
> On 2/21/24 14:43, Jarkko Sakkinen wrote:
> > On Wed Feb 21, 2024 at 12:37 PM UTC, James Bottomley wrote:
> >> On Tue, 2024-02-20 at 22:31 +0000, Jarkko Sakkinen wrote:
> >>>
> >>> 2. Because localities are not too useful these days given TPM2's
> >>>  =C2=A0=C2=A0 policy mechanism
> >>
> >> Localitites are useful to the TPM2 policy mechanism.  When we get key
> >> policy in the kernel it will give us a way to create TPM wrapped keys
> >> that can only be unwrapped in the kernel if we run the kernel in a
> >> different locality from userspace (I already have demo patches doing
> >> this).
> >=20
> > Let's keep this discussion in scope, please.
> >=20
> > Removing useless code using registers that you might have some actually
> > useful use is not wrong thing to do. It is better to look at things fro=
m
> > clean slate when the time comes.
> >=20
> >>>   I cannot recall out of top of my head can
> >>>  =C2=A0=C2=A0 you have two localities open at same time.
> >>
> >> I think there's a misunderstanding about what localities are: they're
> >> effectively an additional platform supplied tag to a command.  Each
> >> command can therefore have one and only one locality.  The TPM doesn't
> >=20
> > Actually this was not unclear at all. I even read the chapters from
> > Ariel Segall's yesterday as a refresher.
> >=20
> > I was merely asking that if TPM_ACCESS_X is not properly cleared and yo=
u
> > se TPM_ACCESS_Y where Y < X how does the hardware react as the bug
> > report is pretty open ended and not very clear of the steps leading to
> > unwanted results.
> >=20
> > With a quick check from [1] could not spot the conflict reaction but
> > it is probably there.
>
> The expected behavior is explained in the Informative Comment of section=
=20
> 6.5.2.4 of the Client PTP spec[1]:
>
> "The purpose of this register is to allow the processes operating at the=
=20
> various localities to share the TPM. The basic notion is that any=20
> locality can request access to the TPM by setting the=20
> TPM_ACCESS_x.requestUse field using its assigned TPM_ACCESS_x register=20
> address. If there is no currently set locality, the TPM sets current=20
> locality to the requesting one and allows operations only from that=20
> locality. If the TPM is currently at another locality, the TPM keeps the=
=20
> request pending until the currently executing locality frees the TPM.=20

Right.

I'd think it would make sense to document the basic dance like this as
part of kdoc for request_locality:

* Setting TPM_ACCESS_x.requestUse:
*  1. No locality reserved =3D> set locality.
*  2. Locality reserved =3D> set pending.

I.e. easy reminder with enough granularity.

> Software relinquishes the TPM=E2=80=99s locality by writing a 1 to the=20
> TPM_ACCESS_x.activeLocality field. Upon release, the TPM honors the=20
> highest locality request pending. If there is no pending request, the=20
> TPM enters the =E2=80=9Cfree=E2=80=9D state."

And this for relinquish_locality:

* Setting TPM_ACCESS_x.activeLocality:
*  1. No locality pending =3D> free.
*  2. Localities pending =3D> reserve for highest.

> >> submission).   I think the locality request/relinquish was modelled
> >> after some other HW, but I don't know what.
> >=20
> > My wild guess: first implementation was made when TPM's became availabl=
e
> > and there was no analytical thinking other than getting something that
> > runs :-)
>
> Actually, no that is not how it was done. IIRC, localities were designed=
=20
> in conjunction with D-RTM when Intel and MS started the LeGrande effort=
=20
> back in 2000. It was then generalized for the TPM 1.1b specification. My=
=20

OK, thanks for this bit of information! I did not know this.

> first introduction to LeGrande/TXT wasn't until 2005 as part of an early=
=20
> access program. So most of my historical understanding is from=20
> discussions I luckily got to have with one of the architects and a few=20
> of the original TCG committee members.

Thanks alot for sharing this.

>
> [1]=20
> https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-P=
latform-TPM-Profile-for-TPM-2p0-v1p05p_r14_pub.pdf
>
> v/r,
> dps


BR, Jarkko

