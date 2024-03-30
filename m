Return-Path: <linux-kernel+bounces-125684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CA0892AAA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46615B21A08
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2D22D052;
	Sat, 30 Mar 2024 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVyEp2OC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFAFBE6F;
	Sat, 30 Mar 2024 11:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711797093; cv=none; b=pthwGYGVfkKbo79i4r3JfW+J203srEv4BC6L5S4Y3mQ2kd4OYvYtMhaXKPexDmEipY4fIfYU55BS7w/rlrTa8AXWce6NKmQAAkphwv4b4rVqkxv4z+JT6XEZCcVsYS165T4HoL+pSJi6F4ST+gFyWuUe+LrpxL0GWxBdDFIT6Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711797093; c=relaxed/simple;
	bh=iXcSCv1Lm8qoVXmrgVuG9IH8TGJqsJHpTZ9ruAqsmUI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=mneaipFTH8fgHzlTlxHH/boSUgl+zn6i8Dxa5S9wy4cnacpxWYlhZtnVRyobCCFaf/cfp5ja1XzOyMV8XkkFMoV32ZN3x2I54TuTLApffum0FFRV2gHAzm1BmMOpE0b8qYT9y67Y6aNVhYD85N9qu/MsSl+QyonWMhUngoyfY8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVyEp2OC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061ADC433C7;
	Sat, 30 Mar 2024 11:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711797091;
	bh=iXcSCv1Lm8qoVXmrgVuG9IH8TGJqsJHpTZ9ruAqsmUI=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=qVyEp2OCL7jBvHHpwLy5SoX/uOuYnC1rcPn+CPe8wTYEuho90fPuIdCDew6wweXpi
	 vr2rRp7C/tCMbPkVmBjvy0d2xn6W7Vkq71NAS+exqVOYf9jSy5wwSyB4rBFcof/1Vr
	 dtKAFPNiSks+nyA/O9D41wwFoloIqWTxq9TGLOkhwBWa57+P6iPY2DxcR6RL1oMeml
	 U5/g9Yh/kIQo8XvnWmdPc6JRYsVI0rbuX/07su2hZhO9zv1dd7X5ExFmEn+nYdFvuJ
	 jd8KJFKJkfmbb65/UaOIex+Hn/flU5IlCzJjpbswd6ds72r9f3uIOp8vV91t+ASrBX
	 Z0Fp2O26xlMEQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 Mar 2024 13:11:25 +0200
Message-Id: <D071F8P9F4W2.OJB84BIYSIR6@kernel.org>
To: "Randy Dunlap" <rdunlap@infradead.org>, "Fan Wu"
 <wufan@linux.microsoft.com>, <corbet@lwn.net>, <zohar@linux.ibm.com>,
 <jmorris@namei.org>, <serge@hallyn.com>, <tytso@mit.edu>,
 <ebiggers@kernel.org>, <axboe@kernel.dk>, <agk@redhat.com>,
 <snitzer@kernel.org>, <eparis@redhat.com>, <paul@paul-moore.com>
Cc: <linux-doc@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <fsverity@lists.linux.dev>,
 <linux-block@vger.kernel.org>, <dm-devel@lists.linux.dev>,
 <audit@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Deven Bowers"
 <deven.desai@linux.microsoft.com>
Subject: Re: [PATCH v16 01/20] security: add ipe lsm
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <1711657047-10526-1-git-send-email-wufan@linux.microsoft.com>
 <1711657047-10526-2-git-send-email-wufan@linux.microsoft.com>
 <D05ODONHFJ9O.3VG0HLFPA1OB0@kernel.org>
 <cde3dc6e-ca77-445e-a4b7-fc21a934999a@infradead.org>
In-Reply-To: <cde3dc6e-ca77-445e-a4b7-fc21a934999a@infradead.org>

On Fri Mar 29, 2024 at 12:11 AM EET, Randy Dunlap wrote:
>
>
> On 3/28/24 13:45, Jarkko Sakkinen wrote:
> >> +/**
> >> + * ipe_init - Entry point of IPE.
> >> + *
> >> + * This is called at LSM init, which happens occurs early during kern=
el
> >> + * start up. During this phase, IPE registers its hooks and loads the
> >> + * builtin boot policy.
> >> + * Return:
> >> + * * 0		- OK
> >> + * * -ENOMEM	- Out of memory
> > Just a suggestion:
> >=20
> > * 0:		OK
> > * -ENOMEM:	Out of memory (OOM)
> >=20
> > Rationale being more readable (less convoluted).
> >=20
> > And also sort of symmetrical how parameters are formatted in kdoc.
>
> It needs the " * *" to make a formatted list in the generated output.
> Otherwise the use of '- or ':' as a separator doesn't matter AFAIK.

Thanks for the remark! Yeah I don't mind the two stars.

BR, Jarkko

