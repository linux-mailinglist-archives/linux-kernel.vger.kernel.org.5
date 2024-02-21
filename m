Return-Path: <linux-kernel+bounces-73872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFA985CCDF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF531C2199C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35093D65;
	Wed, 21 Feb 2024 00:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UD0dE66U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476F4259B;
	Wed, 21 Feb 2024 00:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476138; cv=none; b=cKJU5NEox7fQi9RsPAVTFX1/LoGs7Zf9CRi+JxkgEmR6vWUxx89X3ZgGsCoMkj/gezV7Y8su8WddtT/IhSY+NYIkmQL2VUJh+3+L5IIuPo5H6GfYA+pcURdHxgK9+1Rv83GJirMrTT2laJenJg7zc9hi6K1a0+y+Sb6MYLP+VHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476138; c=relaxed/simple;
	bh=Y3Wm7OwuVFt4aWjhjtNgPADfLE1yoIPV/Vl/eO3VRK0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Y4xIC+2R0l06c+yCQV1JZ2Aha5L3AMTVfJo7WZwU1adXyd+OsePzphHqVMZRUvK3mFj8HA8nCAtPdYpItAHH3DANWWqG3CgTkC3HPqW5mjCEBLc/nhqI2lzAgiV7LMOfWQJAQUybdj++vh9Iony+NzFmW0HiBL8JpTf5vgAJB2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UD0dE66U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C38C433C7;
	Wed, 21 Feb 2024 00:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708476137;
	bh=Y3Wm7OwuVFt4aWjhjtNgPADfLE1yoIPV/Vl/eO3VRK0=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=UD0dE66UmF+uiSs+1SjG/JUqr9qEaVSdd4Rdg/vl1XXX4RCvxr8NN3c5QQRk5l3w9
	 10M6Ia50KDodPYPJbctvmMH12v9hqMJk47QQTatxd2PIiRDFlfxYIJix3WAC1n7weF
	 +XfimmmXutN4KUw5vkkiE+9xySK0UIfOYDMMZQhmFCgTPaIlFBMy/bedgz3w2w1N/1
	 nXq7IlHp8IAj0wHGZU51afuRKsmD5IVOhl53doczjW1KwVVX6i2qF9KBzQ7HoiBl7q
	 20D0tVWDPIpTsna1BYsi3kxSZbiskQJI8t5c2IuQKmLTWM+zCHluQyoYtNFuN5nAQe
	 eRUzNlhdyQUZg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Feb 2024 00:42:13 +0000
Message-Id: <CZAC8SNXYDU6.2GHMH4MJAOA9C@seitikki>
To: "Lino Sanfilippo" <l.sanfilippo@kunbus.com>, "Alexander Steffen"
 <Alexander.Steffen@infineon.com>, "Daniel P. Smith"
 <dpsmith@apertussolutions.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Sasha
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
 <9da1855b-eca2-4c11-a69d-e01494c985d1@kunbus.com>
In-Reply-To: <9da1855b-eca2-4c11-a69d-e01494c985d1@kunbus.com>

On Tue Feb 20, 2024 at 11:26 PM UTC, Lino Sanfilippo wrote:
>
>
> On 20.02.24 23:31, Jarkko Sakkinen wrote:
> > ATTENTION: This e-mail is from an external sender. Please check attachm=
ents and links before opening e.g. with mouseover.
> >=20
> >=20
> > On Tue Feb 20, 2024 at 10:26 PM UTC, Jarkko Sakkinen wrote:
> >> On Tue Feb 20, 2024 at 8:54 PM UTC, Lino Sanfilippo wrote:
> >>> for (i =3D 0; i <=3D MAX_LOCALITY; i++)
> >>>     __tpm_tis_relinquish_locality(priv, i);
> >>
> >> I'm pretty unfamiliar with Intel TXT so asking a dummy question:
> >> if Intel TXT uses locality 2 I suppose we should not try to
> >> relinquish it, or?
> >>
> >> AFAIK, we don't have a symbol called MAX_LOCALITY.
> >=20
> > OK it was called TPM_MAX_LOCALITY :-) I had the patch set applied
> > in one branch but looked up with wrong symbol name.
> >=20
>
> Sorry for the confusion. The code was just meant to sketch a solution, it=
 was=20
> written out of my head and I just remembered that Daniels patch set intro=
duced
> some define for the max number of the localities. I did not look up the c=
orrect
> name though.

NP

BR, Jarkko

