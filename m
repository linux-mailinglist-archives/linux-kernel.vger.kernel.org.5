Return-Path: <linux-kernel+bounces-108614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F158880D00
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6381A1C22EE2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F54383A4;
	Wed, 20 Mar 2024 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+rqknd1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77F8101E8;
	Wed, 20 Mar 2024 08:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710923324; cv=none; b=mP+rjU8eXFLkZ3PIRENSQgpk8Mmft8SPu4cTYFp3AcRdNCFEPG9/AT9dBMDqrWZSKnINDEgCQQuRFKJ1zulwBEout/J8e6q3eoLWlXUJDjDJstyy0h1PahiS2w1TcYd5Yg/bVEiVS2s96cPeBUV9l/jklPpeAAyTGCeu4z+88Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710923324; c=relaxed/simple;
	bh=BWNgmr1UI8Ez2Yk8JxGhv2jILFoV7E237Mqwin2G1xU=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=hausd+UiYuHv5zj3MO1oKJcxcj9MmB8HjeZhHTURzzK62v7C6JdVhjwTU5YAiw0KTxhLoAPcf45rfVnkFQ6GnQgwxfLbSGYAlqOxubsE7fNBchFVpJ8f431dBqzJ9jeeO4/Xy6Cr/UcovTvCOJFC/PEtmyAbEois4CoGHoquSBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+rqknd1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DB8C433F1;
	Wed, 20 Mar 2024 08:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710923324;
	bh=BWNgmr1UI8Ez2Yk8JxGhv2jILFoV7E237Mqwin2G1xU=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=Z+rqknd11Xq+RxpQ3lOa2Uc20j2piizrSxUqNkCmdP1FQ39nD+481V0wtS5iKppBt
	 dhwwp+ZhJKG90Z7IQFnHeG7lKyvY56576olFr+46vsI3SBRIE3fafp6AS7fneglF8l
	 pEd+7SjXv8owZkIWAuebthTIB0bmCwtSGLN1itKiNkN8l8DaPkrqchOS/F8OE3nH7Q
	 wJYYPVpRX7L/78U68unPdvDX8prEnKpuR7XXUVHzHn20sdQtl+wGK5mFrfdRLZJtto
	 mZHoJKW9S3zezgO/5IIN2p3bK6WAyc69ODlVC/LLzP2RNdqhHxuXwaM+jMyGnpzyVI
	 drRgIQTjnw8qA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Mar 2024 10:28:38 +0200
Message-Id: <CZYFP5S04YTK.23AJMKWQWVCR8@kernel.org>
To: "Paul Moore" <paul@paul-moore.com>, "Fan Wu"
 <wufan@linux.microsoft.com>, <corbet@lwn.net>, <zohar@linux.ibm.com>,
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
X-Mailer: aerc 0.15.2
References: <1710560151-28904-13-git-send-email-wufan@linux.microsoft.com>
 <f5cf9d285bd5f09bbc3f79b0800d37fc@paul-moore.com>
In-Reply-To: <f5cf9d285bd5f09bbc3f79b0800d37fc@paul-moore.com>

On Wed Mar 20, 2024 at 1:00 AM EET, Paul Moore wrote:
> On Mar 15, 2024 Fan Wu <wufan@linux.microsoft.com> wrote:
> >=20
> > This patch introduces a new hook to save block device's integrity
> > data. For example, for dm-verity, LSMs can use this hook to save
> > the roothash signature of a dm-verity into the security blob,
> > and LSMs can make access decisions based on the data inside
> > the signature, like the signer certificate.
> >=20
> > Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> >=20
> > --
> > v1-v14:
> >   + Not present
> >=20
> > v15:
> >   + Introduced
> >=20
> > ---
> >  include/linux/lsm_hook_defs.h |  2 ++
> >  include/linux/security.h      | 14 ++++++++++++++
> >  security/security.c           | 28 ++++++++++++++++++++++++++++
> >  3 files changed, 44 insertions(+)
>
> I'm not sure why you made this a separate patch, help?  If there is
> no significant reason why this is separate, please squash it together
> with patch 11/21.

Off-topic: it is weird to have *RFC* patch set at v15.

RFC by de-facto is something that can be safely ignored if you don't
have bandwidth. 15 versions of anything that can be safely ignored
is by definition spamming :-) I mean just conceptually.

So does the RFC still hold or what the heck is going on with this one?

Haven't followed for some time now...

BR, Jarkko

