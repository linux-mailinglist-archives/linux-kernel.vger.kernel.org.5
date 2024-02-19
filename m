Return-Path: <linux-kernel+bounces-71984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D29EE85AD6D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718511F25270
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3517B535CF;
	Mon, 19 Feb 2024 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORKqJJPx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788B92E40C;
	Mon, 19 Feb 2024 20:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708375537; cv=none; b=DqXwCRmZ2FomO1XzhdpyRPo52znHJXMDcHTc54joi0kisig4Dns4niKrnS5UNJ1wWsi1VYTXVsaxTSD0h+Jl2ZkHfxGIN8O/tE4H1guL/Uw7QGCaBKJ4Kb3T7WgzX3qKrlObaL/XotXHsLLSOB3f+nYy2hDqmKn1g42HV0wPvto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708375537; c=relaxed/simple;
	bh=RbLok3TbzDososfsQR6bBnabxTYPM3ftFZEG1ID3oXk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=q2ttGYig0exyM+H4Vnxq0lhpIoqv1wrGBnUeu3csTtjTEeHVXEANYwtiXOBZtcLwVRY27TPszHAiaCjlL/SIPUamEwhm9U8Ub31jHSnJREBmg7//ynjYU0kuhhAIx/twtZoFAgaU/7LJpUWxUQF4D07Ayg4gE6ZWf5Ttp+GtEDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORKqJJPx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC55EC433F1;
	Mon, 19 Feb 2024 20:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708375537;
	bh=RbLok3TbzDososfsQR6bBnabxTYPM3ftFZEG1ID3oXk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ORKqJJPxeviSRqukC/iAm7zBNCaa4iR8Tc9fVBK6aB7dng3G7U2hQP/KCA3khvlXE
	 AmcRUJFrn6G1ScFF4cz5ItWC+HGV+NlKfFY8u68ftAvEoiY8u9+njfZqnZRSenccjz
	 9bC3NDRwq8SBgT+8AJRkeCBgdTG+noAi73LCkQcECJe7ac/rqdCcw6/BcFyD+n5S3s
	 MDU7Mz2qjW+wcEiyYVE9UzbN8HV++BXTMP7uiSNGu3jx0M6QB0BB1uaC29IEe+m7sL
	 Ubo0qZOCtxmIbMcfHbo+qgJXuf59B+chSKaov+yuY91AqAvA0g+RWTfSEEslhpjtiS
	 BgCgFh+Y5MxuQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Feb 2024 20:45:33 +0000
Message-Id: <CZ9CL1MYG4SK.2L7WVGM7WVCG1@seitikki>
Cc: "Ross Philipson" <ross.philipson@oracle.com>, "Peter Huewe"
 <peterhuewe@gmx.de>
Subject: Re: [PATCH 3/3] tpm: make locality request return value consistent
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>, "Jason Gunthorpe"
 <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
 <20240131170824.6183-4-dpsmith@apertussolutions.com>
 <CYU3XUGOX6QT.1GL070ONNPBWQ@suppilovahvero>
 <80d95a08-a1c1-44a7-959c-8bff14254608@apertussolutions.com>
In-Reply-To: <80d95a08-a1c1-44a7-959c-8bff14254608@apertussolutions.com>

On Mon Feb 19, 2024 at 8:29 PM UTC, Daniel P. Smith wrote:
> On 2/1/24 17:49, Jarkko Sakkinen wrote:
> > On Wed Jan 31, 2024 at 7:08 PM EET, Daniel P. Smith wrote:
> >> The function tpm_tis_request_locality() is expected to return the loca=
lity
> >> value that was requested, or a negative error code upon failure. If it=
 is called
> >> while locality_count of struct tis_data is non-zero, no actual localit=
y request
> >> will be sent. Because the ret variable is initially set to 0, the
> >> locality_count will still get increased, and the function will return =
0. For a
> >> caller, this would indicate that locality 0 was successfully requested=
 and not
> >> the state changes just mentioned.
> >>
> >> Additionally, the function __tpm_tis_request_locality() provides incon=
sistent
> >> error codes. It will provide either a failed IO write or a -1 should i=
t have
> >> timed out waiting for locality request to succeed.
> >>
> >> This commit changes __tpm_tis_request_locality() to return valid negat=
ive error
> >> codes to reflect the reason it fails. It then adjusts the return value=
 check in
> >> tpm_tis_request_locality() to check for a non-negative return value be=
fore
> >> incrementing locality_cout. In addition, the initial value of the ret =
value is
> >> set to a negative error to ensure the check does not pass if
> >> __tpm_tis_request_locality() is not called.
> >=20
> > This is way way too abtract explanation and since I don't honestly
> > understand what I'm reading, the code changes look bunch of arbitrary
> > changes with no sound logic as a whole.
>
> In more simpler terms, the interface is inconsistent with its return=20
> values. To be specific, here are the sources for the possible values=20
> tpm_tis_request_locality() will return:
> 1. 0 - 4: _tpm_tis_request_locality() was able to set the locality
> 2. 0: a locality already open, no locality request made
> 3. -1: if timeout happens in __tpm_tis_request_locality()
> 4. -EINVAL: unlikely, return by IO write for incorrect sized write
>
> As can easily be seen, tpm_tis_request_locality() will return 0 for both=
=20
> a successful(1) and non-successful request(2). And to be explicit for=20
> (2), if tpm_tis_request_locality is called for a non-zero locality and=20
> the locality counter is not zero, it will return 0. Thus, making the=20
> value 0 reflect as success when locality 0 is successfully requested and=
=20
> as failure when a locality is requested with a locality already open.
>
> As for failures, correct me if I am wrong, but if a function is=20
> returning negative error codes, it should not be using a hard coded -1=20
> as a generic error code. As I note, it is unlikely for the -EINVAL to be=
=20
> delivered, but the code path is still available should something in the=
=20
> future change the backing call logic.
>
> After this change, the possible return values for=20
> tpm_tis_request_locality() become:
> 1. 0 - 4: the locality that was successfully requested
> 2. -EBUSY: tpm busy, unable to request locality
> 3. -EINVAL: invalid parameter
>
> With this more consistent interface, I updated the return value checks=20
> at the call sites to check for negative error as the means to catch=20
> failures.

For all commits: your responses to my queries have much more to the
point information and buy-in than the original commit messages. So
for next version I would take them and edit a bit and then this all
makes much much more sense. Thank you.
>
> v/r,
> dps

BR, Jarkko

