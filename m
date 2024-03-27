Return-Path: <linux-kernel+bounces-122034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B559788F107
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6DC11C2C897
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09CF153510;
	Wed, 27 Mar 2024 21:33:42 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C1438396;
	Wed, 27 Mar 2024 21:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575222; cv=none; b=jvt/AXW7fv/MovS+t978wGs1t/pkmfgyEW/DXgGxPHWU7nyZAC38semWTgIbyBs9TNacYl8U82p4+rbKdN6vKE+CUdWQ0zXP7lBsV4nDnVebtBUn4Lfdh2AHp3IxemusZLlkLBsO4idjhVRVu6qrJDtCY7vOy5X312qVFddTq1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575222; c=relaxed/simple;
	bh=QJ8kxMSjZ5GTYT71Keo0YXkt99NSXuFp1hu7izL5OnE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=fg2CGiOU2hVtpxN14Oyp/e/q0pQ/DHvblxtGX47r1a2l5TQ3wiKgcd40jBBQ8BzjfCcHGwk+Fyd4c721cx9Co83svR9ndklGm/EuOzoST1f5DvpppxaxfWYhheuwwm9FqnL1YpiiOu59uj/jHlrhykdGQU603cRsvN4piL6Z9sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id CA90363434F7;
	Wed, 27 Mar 2024 22:33:30 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id bBUx71qkm1eV; Wed, 27 Mar 2024 22:33:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id D26226343B21;
	Wed, 27 Mar 2024 22:33:29 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KjUjrvkRJyPg; Wed, 27 Mar 2024 22:33:29 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id A2B7563434F7;
	Wed, 27 Mar 2024 22:33:29 +0100 (CET)
Date: Wed, 27 Mar 2024 22:33:29 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Eric Biggers <ebiggers@kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, 
	Jens Wiklander <jens.wiklander@linaro.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, tytso <tytso@mit.edu>, 
	Tyler Hicks <code@tyhicks.com>
Message-ID: <585752805.112641.1711575209551.JavaMail.zimbra@nod.at>
In-Reply-To: <20240327100421604167cd@mail.local>
References: <20240327101309.4e7d04f3@canb.auug.org.au> <20240327041653.GA35281@sol.localdomain> <20240327100421604167cd@mail.local>
Subject: Re: linux-next: trees being removed
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: linux-next: trees being removed
Thread-Index: ie1NNMqV9Kbm6V9SPeSAfUd6GZ8cNQ==

----- Urspr=C3=BCngliche Mail -----
> Von: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
>> > ubifs-fixes=09=092023-01-21 16:27:01 -0800
>> >   git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git#fixes
>>=20
>> fscrypt-current and fsverity-current are technically still in use.  I ju=
st
>> haven't used them recently because there haven't been any bug fixes that=
 needed
>> to go in while other commits were already applied for the next merge win=
dow.
>>=20
>> I've updated them to v6.9-rc1.
>>=20
>> I'd guess that some of those *-fixes branches have something similar goi=
ng on,
>> where they may be rarely used fixes branches as opposed to the main deve=
lopment
>> branch.
>>=20
>=20
> This is exactly my case. I don't mind my branch being dropped and I can
> ask to add it back once I have urgent fixes.

Same here. It turned out that the next branch is good enough for me.

Thanks,
//richard

