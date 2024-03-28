Return-Path: <linux-kernel+bounces-123594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57196890B86
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED1A1C296BF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8E513248D;
	Thu, 28 Mar 2024 20:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isUQcFeO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD20D4436B;
	Thu, 28 Mar 2024 20:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658315; cv=none; b=jIw5exNBeojK6fpMtwQxFHDwCBioiT3V9QRufI/NDi9UgO3VuMyQx/sLjhzngMyVRKPQ97cAOCjw8mwZTSUOXAvySdSykwS2VMafRIJSSu1ZLH/B6JrPmwf8VSU3CNxcYQF8CPy7wu+miQsrHJTUqPK/rfJS2QZ+mBZ/YVd9iOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658315; c=relaxed/simple;
	bh=//UHZ5wlfdBrGcEXtCNieykr9XzbKv3rHPqzSEhgiFk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Wr76bmhLhFCeWCSQVi5I5ufUw4lrzXhkVnSqtksN2ZkXx/D1nJmry3YpwYoAROCiHdsrv/BTiCbIv6tLSmMcgRxrfpOHq8ny4lMWnwyEYnErcMyG/zoThpLYqkL+xJ9YYcWLBTdBERQ2Z1zSZGMqrYk6Epca26U9nmzUlDtXQFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isUQcFeO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0626CC433C7;
	Thu, 28 Mar 2024 20:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711658315;
	bh=//UHZ5wlfdBrGcEXtCNieykr9XzbKv3rHPqzSEhgiFk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=isUQcFeODmd1cT+v2ZNaKD1vpflYBGQ5Se9fuVidaCEfht+qiRhDtNMKFw/x3wUMg
	 QzWyjN4zRPBUdyjD8niUMVDPdfQGEXB1RspiOL+NZsLHkkRKYalf1+zlMGuoga2UdY
	 yoChbYqvN6EG76w2sGhRW/WgQGB5ZCKXd95RXrr1PjAVbaq3g6B8ktk2B9RuXFb4GE
	 zXUmVY9eG97XipAfQc1jlIbVfeSjbtxOEwaVY6wawkWTm2t/JD2jeODs54RtYJGfit
	 yJW32QAZK1zsLbQ31IKmWLBJmrptoujj8OFVzH0XUUwzaqLrgAgDcoqbYMfkMaADtj
	 PmPM/7qsa2lMQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Mar 2024 22:38:29 +0200
Message-Id: <D05O8BUCPQL6.22850B90ITSCR@kernel.org>
Cc: <linux-doc@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <fsverity@lists.linux.dev>,
 <linux-block@vger.kernel.org>, <dm-devel@lists.linux.dev>,
 <audit@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v16 00/20] Integrity Policy Enforcement LSM (IPE)
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Fan Wu"
 <wufan@linux.microsoft.com>, <corbet@lwn.net>, <zohar@linux.ibm.com>,
 <jmorris@namei.org>, <serge@hallyn.com>, <tytso@mit.edu>,
 <ebiggers@kernel.org>, <axboe@kernel.dk>, <agk@redhat.com>,
 <snitzer@kernel.org>, <eparis@redhat.com>, <paul@paul-moore.com>
X-Mailer: aerc 0.17.0
References: <1711657047-10526-1-git-send-email-wufan@linux.microsoft.com>
 <D05O6JVMMZY7.5ZUBAPJH22FC@kernel.org>
In-Reply-To: <D05O6JVMMZY7.5ZUBAPJH22FC@kernel.org>

On Thu Mar 28, 2024 at 10:36 PM EET, Jarkko Sakkinen wrote:
> On Thu Mar 28, 2024 at 10:17 PM EET, Fan Wu wrote:
> > Overview:
> > ---------
>
> s/://
>
> It is already a heading.
>
> >
> > IPE is a Linux Security Module which takes a complimentary approach to
>  =20
>   Integrity Policy Enforcement (IPE) is a ...
>
> > access control. Whereas existing mandatory access control mechanisms
> > base their decisions on labels and paths, IPE instead determines
> > whether or not an operation should be allowed based on immutable
> > security properties of the system component the operation is being
> > performed on.
>
> What is "a immutable property of the system component", or even,
> what is "a immutable property" and what is "a system component".
>
> These should be defined per context of use as there is no unambiguous
> definitions of these "properties".
>
> So can you add a paragraph before this defining these concepts?
> Otherwise, it would be pretty hard to review any of this.
>
> I.e. I have to make my own imaginary definitions of them and possibly
> make completely false conclusions what was meant.

This might sound like nitpicking but often in security patch sets
people get their own ideas and that leads to useless iterations
etc. so I think it is useful to be pretty formal with definitions
so that we dont end up shadow boxing...

I have ton of experience with this with SGX patches in the past.

BR, Jarkko

