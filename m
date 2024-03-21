Return-Path: <linux-kernel+bounces-110492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9677A885FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3750EB2669A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBF312BF2E;
	Thu, 21 Mar 2024 17:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQevDAax"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3FD79E0;
	Thu, 21 Mar 2024 17:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711041927; cv=none; b=MDqT6UoiLqk/wN1WQ1KdpMdhqihyZOGCtNURRbC83n2Q3vmmL6QofefPZPh+UFGJ2E+WeZmF/031n0ALV9+x7uLZSvQrxzkw7GcTlXSNGbN0XNCaOw8RBERjEbWcJ/Oa01qlvBdKpU+947CK04FYlvaS4f62VO/amVhSjM2hp4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711041927; c=relaxed/simple;
	bh=iNXaAGwm6iS6DNKISF6dlrJY5wNVKnpnm8REwy4rDho=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=ZlrxG4ckuZ8goLtQ3Em9Yp1/x2MZLfQKcZBNJJRM1Mb3vNory2jOJCXysSu0vJiZhxeJA0sblwHWyEal53rf1STgifO0GY5glb7rHOIhY0wEzcByhjLfmSBat936BVoHSNLC+bg6+vk5KVlv6Cm5OI7VSc+5oY2gGUDKiB9Amaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQevDAax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073E2C433C7;
	Thu, 21 Mar 2024 17:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711041927;
	bh=iNXaAGwm6iS6DNKISF6dlrJY5wNVKnpnm8REwy4rDho=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=uQevDAaxSvs1weuPxAVtTq79oE8xNAAlm00KgUZtg+SF0ZCpdazoYqldu4ms40wTI
	 KdBcq8uWAD47/rKzsT59SMSEtZvXIWGj+5CJdnbpCRBT7JEP/03D/qAdLGr6V1WR1O
	 tKmQl20Xe9j84FJNztEGGULdS8/DLACS1ZZirVT9+YuBlMkeNH6yshOtZFYcoGOQ7c
	 I87pEcsouNJ2soJeKDqyYmUarFAbdb9NjQvdlnXKq82l4NPh+I1KSlj5wGFMn4Ze0w
	 1SfpgXrWpNJ2W3SvSXv2vZ0wLvpr77vGmkJjpJhw4mdXecJniydVNE2PwYSrO+l75f
	 cX/eY3iu0uHhg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Mar 2024 19:25:21 +0200
Message-Id: <CZZLQN9CUN2E.5PNZ0C2JHP42@kernel.org>
To: "Fan Wu" <wufan@linux.microsoft.com>, "Paul Moore"
 <paul@paul-moore.com>, <corbet@lwn.net>, <zohar@linux.ibm.com>,
 <jmorris@namei.org>, <serge@hallyn.com>, <tytso@mit.edu>,
 <ebiggers@kernel.org>, <axboe@kernel.dk>, <agk@redhat.com>,
 <snitzer@kernel.org>, <eparis@redhat.com>
Cc: <linux-doc@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <fsverity@lists.linux.dev>,
 <linux-block@vger.kernel.org>, <dm-devel@lists.linux.dev>,
 <audit@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v15 12/21] security: add
 security_bdev_setintegrity() hook
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <1710560151-28904-13-git-send-email-wufan@linux.microsoft.com>
 <f5cf9d285bd5f09bbc3f79b0800d37fc@paul-moore.com>
 <CZYFP5S04YTK.23AJMKWQWVCR8@kernel.org>
 <CZYFR8LEEQB1.8C0J9KCTF8CB@kernel.org>
 <a69805c7-7b8a-44ee-9b32-f9314b5a9763@linux.microsoft.com>
In-Reply-To: <a69805c7-7b8a-44ee-9b32-f9314b5a9763@linux.microsoft.com>

On Wed Mar 20, 2024 at 10:31 PM EET, Fan Wu wrote:
>
>
> On 3/20/2024 1:31 AM, Jarkko Sakkinen wrote:
> > On Wed Mar 20, 2024 at 10:28 AM EET, Jarkko Sakkinen wrote:
> >> On Wed Mar 20, 2024 at 1:00 AM EET, Paul Moore wrote:
> >>> On Mar 15, 2024 Fan Wu <wufan@linux.microsoft.com> wrote:
> >>>>
> >>>> This patch introduces a new hook to save block device's integrity
> >>>> data. For example, for dm-verity, LSMs can use this hook to save
> >>>> the roothash signature of a dm-verity into the security blob,
> >>>> and LSMs can make access decisions based on the data inside
> >>>> the signature, like the signer certificate.
> >>>>
> >>>> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> >>>>
> >>>> --
> >>>> v1-v14:
> >>>>    + Not present
> >>>>
> >>>> v15:
> >>>>    + Introduced
> >>>>
> >>>> ---
> >>>>   include/linux/lsm_hook_defs.h |  2 ++
> >>>>   include/linux/security.h      | 14 ++++++++++++++
> >>>>   security/security.c           | 28 ++++++++++++++++++++++++++++
> >>>>   3 files changed, 44 insertions(+)
> >>>
> >>> I'm not sure why you made this a separate patch, help?  If there is
> >>> no significant reason why this is separate, please squash it together
> >>> with patch 11/21.
> >>
> >> Off-topic: it is weird to have *RFC* patch set at v15.
> >>
> >> RFC by de-facto is something that can be safely ignored if you don't
> >> have bandwidth. 15 versions of anything that can be safely ignored
> >> is by definition spamming :-) I mean just conceptually.
> >>
> >> So does the RFC still hold or what the heck is going on with this one?
> >>
> >> Haven't followed for some time now...
> >=20
> > I mean if this RFC trend continues I'll just put auto-filter for this
> > thread to put straight to the bin.  There's enough non-RFC patch sets
> > to review.
> >=20
> > BR, Jarkko
>
> Sorry about the confusion with the RFC tag =E2=80=93 I wasn't fully aware=
 of its=20
> conventional meaning and how it's perceived in terms of importance and=20
> urgency. Point taken, and I'll make sure to remove the RFC tag for=20
> future submissions. Definitely not my intention to clog up the workflow=
=20
> or seem like I'm spamming.

OK cool! Just wanted to point this out also because it already looks
good enough not to be considered as RFC in my eyes :-) If you keep RFC
it is by definition "look into if you have the bandwidth but please
do not take this to mainline". No means to nitpick here...

BR, Jarkko

