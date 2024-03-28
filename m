Return-Path: <linux-kernel+bounces-122644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4356F88FADA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECCA82975AE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3308E5FB88;
	Thu, 28 Mar 2024 09:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QIDtddD8"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A506D4F616
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617240; cv=none; b=KkzAQznSdahITvnfqp4t93pchM6NpQmPtJt7q5GQcJof1bPXZyV8rJQazX16ILKuXpVKIoYCl3h/XnpoMibkSPAtH9R1FXYiUty2FvoCqi7Nf2BXEJYhazbbKPGUYNw/jTIEEaF2z2ulYpT6EREZetXI3nIoOC0cJfyFqCWmL2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617240; c=relaxed/simple;
	bh=kq+6MaTIIKAyQxEp2fwWEQaYzkGVVmjNy6tUfTvDL6Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rOe/24KX+QyuUcbtAngzZwsGFAK3f29SAxe4t3MGSWdtcG82U1M39iZZ/Pa9dGIA6Gdl9kWgB3uN+/aH2p96i0iP/j6nUgTyoxQzcMs2awr+C12Qhd5CoVZTNOXsUZP7Q8uqrXYAvuMOH6zxdGFt8PaihEDhdyqEWj79hrXMkCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QIDtddD8; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kq+6MaTIIKAyQxEp2fwWEQaYzkGVVmjNy6tUfTvDL6Q=;
	t=1711617238; x=1712826838; b=QIDtddD8//pXTIszAO1Dgm+JiLLngnSmmYeSUOVUjZzh0bN
	PsjoGliVgr7icGwJhwNgO2iAs3uHGHcbrFLi3zV12vXpLYV8SS3iRQ2jYgBTyinwdGolUSaQdJhba
	04NwSrmgxePiffprieAyGp1NVZ3e5NY9pZvWjAJg0fm2hfU335zs8JI3n1+NYnfqf80u8yyq8ofMu
	Q+Yo6B/7lyg+/uajIa9H8rrCBfG2D3jv951/jti4T5i4j7DjLFy6I/nZpQuobO/VNdb9fMnpxY83r
	BJAGbBcLQJP52ofy+P2+IceteY1ZRp8qQQQaIfwqGPC0TXgvaPG60fYj9zDP4a3Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rplpb-00000000opc-2Ic0;
	Thu, 28 Mar 2024 10:13:55 +0100
Message-ID: <c4121cbbf6673a8c97db1460a8d6847ccc49d4f3.camel@sipsolutions.net>
Subject: Re: [PATCH v2] um: Makefile: use bash from the environment
From: Johannes Berg <johannes@sipsolutions.net>
To: Yueh-Shun Li <shamrocklee@posteo.net>, Richard Weinberger
 <richard@nod.at>,  Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 28 Mar 2024 10:13:54 +0100
In-Reply-To: <20240323174450.18376-1-shamrocklee@posteo.net>
References: <20240323174450.18376-1-shamrocklee@posteo.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sat, 2024-03-23 at 17:44 +0000, Yueh-Shun Li wrote:
> Set Makefile SHELL to bash instead of /bin/bash for better portability.
>=20
> Some systems do not install binaries to /bin, and therefore do not
> provide /bin/bash. This includes Linux distros which intentionally avoid
> implementing the Filesystem Hierarchy Standard (FHS), such as NixOS and
> Guix System.
>=20
> The recipies inside arch/um/Makefile don't require top-level Bash to
> build, and setting "SHELL" to "bash" makes Make pick the Bash executable
> from the environment, hence this patch.
>=20
> Changes since last roll:
> - Rebase onto a more recent commit on the master branch.
> - Remove a dangling in-text citation from the change log.
> - Reword the change log.

Not sure I'd have added the change log here (in this case at least), but
anyway:

Reviewed-by: Johannes Berg <johannes@sipsolutions.net

johannes

