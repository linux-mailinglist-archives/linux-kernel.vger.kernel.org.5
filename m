Return-Path: <linux-kernel+bounces-122368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F2C88F5C0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 04:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9F5CB216FC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C863932182;
	Thu, 28 Mar 2024 03:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iblpSu+M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C962D622;
	Thu, 28 Mar 2024 03:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711595341; cv=none; b=Ed7hGeEeQTlfAotWhifcUVcjIpkY/GbPC0ykJqc4AtCRs+o1aXM6nEEwO3XThr1OuibX5ZIftxsxNDnizLBcuzYvN2MqOmukWcHsXlxWKdkuoVDPqbqCSxZ7Bp/58kl5x1pIsvMOAkaCTrD3OrI4VDtBnk3vSoO5OmAfTbHhm2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711595341; c=relaxed/simple;
	bh=nABLxb6h1Qjjq0SWW/DOT1BK8XdLbDeksfd3ZdK0Bpo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QtmXbvfhlsx49chnMeShwxVxM6Fv3gzNUi8YTE8eVrhb9EwKedx2ILLMiFL8CEVFVQcXytpGpX8F0yYiInL9dlGHZI08NOp0ZOPQpH3RJ+CfG9Cqk6e3sJVHMx8/PeAhi8jzE/cFORVW0ndbkwb8uH+KtbDzW1I0bjCOZrzGJqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iblpSu+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476F3C433C7;
	Thu, 28 Mar 2024 03:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711595340;
	bh=nABLxb6h1Qjjq0SWW/DOT1BK8XdLbDeksfd3ZdK0Bpo=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=iblpSu+Mhd6FpFhdEE0gklvAqe79T5CeTdZl4hBK3S0p9BUHUGVo93nECPqIfUYoS
	 o8c/Lm9DL6bBAV7+jcjwNMDqtrWFOm+wasiEuESIwPZTdkrLpDaN/eDJo9uoY0enVV
	 xdbxDP3WU9CFZSY9T8EJVT+OjtIk3OPb1wCzccdg/7IFs4xRQCAL6RNdL+6j8oG/Om
	 EVldwU6Uvho0emU2TwfAkyY2Q8sIWfxvDgsWhG0VcHMdbECJppoIctldl4NKnq5062
	 TzOkfgABNro+CmKZT03kEqlR0qrGMAbVgFaZwY8glJmF2bQjFT3UsE2dCww32oCkyK
	 ZHd5cihxwe4Hg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Mar 2024 05:08:56 +0200
Message-Id: <D051WQKNXETS.1O1TI7O2DPT1Z@kernel.org>
Cc: <linux-modules@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 "Roberto Sassu" <roberto.sassu@huawei.com>, <linux-kernel@vger.kernel.org>,
 "Ken Goldman" <kgold@linux.ibm.com>
Subject: Re: [PATCH] ima: define an init_module critical data record
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Mimi Zohar" <zohar@linux.ibm.com>, "Luis Chamberlain"
 <mcgrof@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240327150019.81477-1-zohar@linux.ibm.com>
 <D04OU424128P.22TP02GW2CJCT@kernel.org>
 <80b2e479bc0c520423885a16dd46e0201a1c9418.camel@linux.ibm.com>
In-Reply-To: <80b2e479bc0c520423885a16dd46e0201a1c9418.camel@linux.ibm.com>

On Wed Mar 27, 2024 at 11:37 PM EET, Mimi Zohar wrote:
> On Wed, 2024-03-27 at 18:54 +0200, Jarkko Sakkinen wrote:
> > On Wed Mar 27, 2024 at 5:00 PM EET, Mimi Zohar wrote:
> > > The init_module syscall loads an ELF image into kernel space without
> > > measuring the buffer containing the ELF image.  To close this kernel
> > > module integrity gap, define a new critical-data record which include=
s
> > > the hash of the ELF image.
> > >=20
> > > Instead of including the buffer data in the IMA measurement list,
> > > include the hash of the buffer data to avoid large IMA measurement
> > > list records.  The buffer data hash would be the same value as the
> > > finit_module syscall file hash.
> > >=20
> > > To enable measuring the init_module buffer and other critical data fr=
om
> > > boot, define "ima_policy=3Dcritical_data" on the boot command line.  =
Since
> > > builtin policies are not persistent, a custom IMA policy must include
> > > the rule as well: measure func=3DCRITICAL_DATA label=3Dmodules
> > >=20
> > > To verify the template data hash value, first convert the buffer data
> > > hash to binary:
> > > grep "init_module" \
> > > 	/sys/kernel/security/integrity/ima/ascii_runtime_measurements | \
> > > 	tail -1 | cut -d' ' -f 6 | xxd -r -p | sha256sum
> > >=20
> > > Reported-by: Ken Goldman <kgold@linux.ibm.com>
> > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > > ---
> > >  security/integrity/ima/ima_main.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >=20
> > > diff --git a/security/integrity/ima/ima_main.c
> > > b/security/integrity/ima/ima_main.c
> > > index c84e8c55333d..4b4348d681a6 100644
> > > --- a/security/integrity/ima/ima_main.c
> > > +++ b/security/integrity/ima/ima_main.c
> > > @@ -902,6 +902,13 @@ static int ima_post_load_data(char *buf, loff_t =
size,
> > >  		return 0;
> > >  	}
> > > =20
> > > +	/*
> > > +	 * Measure the init_module syscall buffer containing the ELF image.
> > > +	 */
> > > +	if (load_id =3D=3D LOADING_MODULE)
> > > +		ima_measure_critical_data("modules", "init_module",
> > > +					  buf, size, true, NULL, 0);
> >=20
> > No reason not to ack but could be just as well (passing checkpatch):
>
> Please review the tag usage as defined in=20
> https://docs.kernel.org/process/submitting-patches.html.
>
> >=20
> > 	if (load_id =3D=3D LOADING_MODULE)
> > 		ima_measure_critical_data("modules", "init_module", buf, size,
> > true, NULL, 0);
> >=20
> > < 100 characters
>
> From what I understand, it's still preferable to stay under the 80 charac=
ter
> limit, but checkpatch.pl will not complain.  From=20
> https://www.kernel.org/doc/Documentation/process/maintainer-tip.rst:
>
> "The 80 character rule is not a strict rule, so please use common sense w=
hen
> breaking lines. Especially format strings should never be broken up."

I agree with that is your decision to make (as maintainer of
IMA)!

BTW, I guess process/coding-style.rst would be better ref
here because maintainer-tip.rst is meant only for arch/x86
tree (aka tip.git).

That said, both maintainer-tip.rst and coding-style.rst recommend
the same 80 character length. I have no idea whether 80 or 100
character should be considered as "recommended".

The formatted string example is somewhat weird too because you
should not break that even if it was 150 characters so it does
not have any relation to 100 character limit...

R, Jarkko

