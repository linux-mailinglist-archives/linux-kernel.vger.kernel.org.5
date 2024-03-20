Return-Path: <linux-kernel+bounces-108618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23F6880D0F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E891C22F3D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D2138DDB;
	Wed, 20 Mar 2024 08:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKpWsAr4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38A4374D1;
	Wed, 20 Mar 2024 08:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710923487; cv=none; b=kAhXX2VgJ5N2XeI+u7raujJISqegPsM2XumTnGuTK00HElmotvgTYPvDGGmqlPv+ILe6l0HRoIynh2QJDBmfiK05yb1yHaUnq7Q7cJw1uxsLzx1tdaLNFgWC71Dx7HmzYGNEAJx6EawVfCtD9s9aA/WSbqfqbo9uK6CqWgAVHeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710923487; c=relaxed/simple;
	bh=uYuOLvaXC5zSq3rbHgQsBek5irtHYbjs7ZmCE5k/uss=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gVa19b7jQc023Q3T8xaD8kRSecTfXwrkxmBT5fUL7zItTBBxVzvfduegmp1mLGJ/bKwGLrg8HDQWHOvAfTXuVK2GuuPN5lQWtRIMxSNSJQ8gTe4ZpFau5SQX2IOEfHlb/av9+5Qey/QC+rnXvxX6alwtCJAe5jR7ROwi/Xhcr5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKpWsAr4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C74C43390;
	Wed, 20 Mar 2024 08:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710923487;
	bh=uYuOLvaXC5zSq3rbHgQsBek5irtHYbjs7ZmCE5k/uss=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=sKpWsAr4TQ5rJV1WPhGCeqlhhUwoMVPpLdKthHy3bJrVYHFHZts4lMprouJz0I6eG
	 WSGIgnXJVxT2yfrbfqjWJwR1xQEMd2bfzn/sDtwPtTcRYCpsC/4aSdhmgqdmtuXSUP
	 RjYeeVQPvPM6kmVEPMwynycGLfB/KvylQNpUeg+wYzGwmk+nRJGdtS7P2hSeh1Mksa
	 Qc/GE9Gl9vV/KQf1tCmkv6fplFpS1ArvtJEcwM/jiuI6DZdG96JI9uu2n+cBbZcDkH
	 TdC5SArIBmgJEFk1ouTq9JnFB5BNeXKwDSPGREG7Mi92MVJy0RomdjJKSOuaX7IqOt
	 CE+j33cNYxpbw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Mar 2024 10:31:21 +0200
Message-Id: <CZYFR8LEEQB1.8C0J9KCTF8CB@kernel.org>
Cc: <linux-doc@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <fsverity@lists.linux.dev>,
 <linux-block@vger.kernel.org>, <dm-devel@lists.linux.dev>,
 <audit@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v15 12/21] security: add
 security_bdev_setintegrity() hook
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Paul Moore"
 <paul@paul-moore.com>, "Fan Wu" <wufan@linux.microsoft.com>,
 <corbet@lwn.net>, <zohar@linux.ibm.com>, <jmorris@namei.org>,
 <serge@hallyn.com>, <tytso@mit.edu>, <ebiggers@kernel.org>,
 <axboe@kernel.dk>, <agk@redhat.com>, <snitzer@kernel.org>,
 <eparis@redhat.com>
X-Mailer: aerc 0.15.2
References: <1710560151-28904-13-git-send-email-wufan@linux.microsoft.com>
 <f5cf9d285bd5f09bbc3f79b0800d37fc@paul-moore.com>
 <CZYFP5S04YTK.23AJMKWQWVCR8@kernel.org>
In-Reply-To: <CZYFP5S04YTK.23AJMKWQWVCR8@kernel.org>

On Wed Mar 20, 2024 at 10:28 AM EET, Jarkko Sakkinen wrote:
> On Wed Mar 20, 2024 at 1:00 AM EET, Paul Moore wrote:
> > On Mar 15, 2024 Fan Wu <wufan@linux.microsoft.com> wrote:
> > >=20
> > > This patch introduces a new hook to save block device's integrity
> > > data. For example, for dm-verity, LSMs can use this hook to save
> > > the roothash signature of a dm-verity into the security blob,
> > > and LSMs can make access decisions based on the data inside
> > > the signature, like the signer certificate.
> > >=20
> > > Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> > >=20
> > > --
> > > v1-v14:
> > >   + Not present
> > >=20
> > > v15:
> > >   + Introduced
> > >=20
> > > ---
> > >  include/linux/lsm_hook_defs.h |  2 ++
> > >  include/linux/security.h      | 14 ++++++++++++++
> > >  security/security.c           | 28 ++++++++++++++++++++++++++++
> > >  3 files changed, 44 insertions(+)
> >
> > I'm not sure why you made this a separate patch, help?  If there is
> > no significant reason why this is separate, please squash it together
> > with patch 11/21.
>
> Off-topic: it is weird to have *RFC* patch set at v15.
>
> RFC by de-facto is something that can be safely ignored if you don't
> have bandwidth. 15 versions of anything that can be safely ignored
> is by definition spamming :-) I mean just conceptually.
>
> So does the RFC still hold or what the heck is going on with this one?
>
> Haven't followed for some time now...

I mean if this RFC trend continues I'll just put auto-filter for this
thread to put straight to the bin.  There's enough non-RFC patch sets
to review.

BR, Jarkko

