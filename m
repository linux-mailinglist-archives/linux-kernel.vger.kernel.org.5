Return-Path: <linux-kernel+bounces-31583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CA3833060
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D95611F23C1B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FE45821C;
	Fri, 19 Jan 2024 21:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgzZunqF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763EA57888;
	Fri, 19 Jan 2024 21:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705700316; cv=none; b=T0j4G6DnL6j3rWu8LnGhtKjJBzQxDzqgsNYqnRT90QvqYbrur/q4C5Mqtukgal+JpTT7u/CpDUeX4UurhglC2IZgaP0jnxQOqVBIT3CnTJCnbvwWpHtjYTXPuve0k8LmY6c6oWQ4NTl8WOcyDr1NaP2K+W86jP0I7wK4ezzrNdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705700316; c=relaxed/simple;
	bh=s8jIqE+vW+iYqMRnNiKZlbFoWO7EWkMJg5CQzYRn9bk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=OZ0IiROoFyXaYP0CiXu3hkdw7UqdgWzaN9zWYf6jII21hCozYD4z6X19nqeNT7J4jKvPXNqe8p2FKqCfPQkWSJaDuDDoarQJNbwdcqroGaPIV5K7/YBYVV7rXUOY4eMR5Qa/xZocYIL8KFoAMUjmrCoxoo08J0RRU0ldPjt8krE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgzZunqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F093EC433C7;
	Fri, 19 Jan 2024 21:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705700315;
	bh=s8jIqE+vW+iYqMRnNiKZlbFoWO7EWkMJg5CQzYRn9bk=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=VgzZunqFSQAJW/Qgk7hSaAYMCU33W/15xkyyRu/F7jsuzVfx5pNO4SJcpxwGSq7Cw
	 Afym3p8UxCBp5oLhqtzsOoo4uHOq9kCQEhceK0QSJLLMVM2QLTLKxk+2UwbO/kJzmX
	 svOZUAMU4gJh8O3BVj/l6iGh4WQor6SptG0Oju/hTgWY9u1yUBN0wiCnGceFClMBFo
	 YmjI9d7jevRwCF6G3gOq9ONkQ6vvVOchbA9l39rGYp94bLoPMHf8E72PkqKJiiplPM
	 Dr9o/sqnpXjPWZXS9Gq2D8CW35c83wOSCssicjuezHUhtQQMjsbKFN6EvAJMMXWjN4
	 NYTeDEacBYtEw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jan 2024 21:38:32 +0000
Message-Id: <CYJ0APT6N1KL.CSHV5R4VRWHB@seitikki>
To: "Alexander Steffen" <Alexander.Steffen@infineon.com>, "Daniel P. Smith"
 <dpsmith@apertussolutions.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Lino
 Sanfilippo" <l.sanfilippo@kunbus.com>, "Sasha Levin" <sashal@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: "Ross Philipson" <ross.philipson@oracle.com>, "Kanth Ghatraju"
 <kanth.ghatraju@oracle.com>, "Peter Huewe" <peterhuewe@gmx.de>
Subject: Re: [PATCH] tpm: make locality handling resilient
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.15.2
References: <20240115011546.21193-1-dpsmith@apertussolutions.com>
 <711d659f-3f57-48e4-b5b3-efbc2fe236c8@infineon.com>
In-Reply-To: <711d659f-3f57-48e4-b5b3-efbc2fe236c8@infineon.com>

On Wed Jan 17, 2024 at 8:44 AM UTC, Alexander Steffen wrote:
> On 15.01.2024 02:15, Daniel P. Smith wrote:
> > Commit 933bfc5ad213 introduced the use of a locality counter to control=
 when
> > locality request was actually sent to the TPM. This locality counter cr=
eated a
> > hard enforcement that the TPM had no active locality at the time of the=
 driver
> > initialization. The reality is that this may not always be the case cou=
pled
> > with the fact that the commit indiscriminately decremented the counter =
created
> > the condition for integer underflow of the counter. The underflow was t=
riggered
> > by the first pair of request/relinquish calls made in tpm_tis_init_core=
 and all
> > subsequent calls to request/relinquished calls would have the counter f=
lipping
> > between the underflow value and 0. The result is that it appeared all c=
alls to
> > request/relinquish were successful, but they were not. The end result i=
s that
> > the locality that was active when the driver loaded would always remain=
 active,
> > to include after the driver shutdown. This creates a significant issue =
when
> > using Intel TXT and Locality 2 is active at boot. After the GETSEC[SEXI=
T]
> > instruction is called, the PCH will close access to Locality 2 MMIO add=
ress
> > space, leaving the TPM locked in Locality 2 with no means to relinquish=
 the
> > locality until system reset.
> >=20
> > The commit seeks to address this situation through three changes.
>
> Could you split this up into multiple patches then, so that they can be=
=20
> discussed separately?

I have to agree with you ttly.

Yeah also the text above is not exactly in the ballpark.

I did not understand what I read. I had to read the code change instead
to get an idea. A huge pile of text does not equal to stronger story.

Like for any essay, scientific paper or a kernel message one should do
also few edit rounds. The commit message is more important than the code
change itself in bug fixes...

There is trigger (TXT) and solution. A great commit message should have
motivation and implementation parts and somewhat concise story where
things lead to another. It should essentially make *any* reader who
knows the basics of kernel code base convinced, not confused. This is
at leat a good aim even tho sometimes unreachable.

BR, Jarkko

