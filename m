Return-Path: <linux-kernel+bounces-95974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA608875587
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B801C2359B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA14F131720;
	Thu,  7 Mar 2024 17:50:29 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D457F130E23;
	Thu,  7 Mar 2024 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833829; cv=none; b=MAklZEUdOruPMdFiK5t0navwoDKuTxDuq9Zmk6oT+rSbs8m2gSE2CwCdQumpwxyT7PTGcxtjIuucM0WYUlTTqZ9HQACJzhWXZwQ+C1y3AWMbjqSXFmmT6TYhBmE4i7Z4nXTtx4T1fKHm4NMA6xAumdIzgOsHUNA2YpeGDIwHdwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833829; c=relaxed/simple;
	bh=UkQw+M2hziB+AtfHClDHqBrPe0u0iSyiMBdceYnvNxw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O29iQhebTmK42pab0P1Sk6eoQpy+j5kgGStkiHfSSIBhSJjwypIWArFG07YIcDAI9nma7INVkqQyO3Lkm6F9lAVg1z46K4RgDwHw64SowOY3UaS5/Hzlv+DD9vIEgQINpWlYGZ8MS3jqQVl3hQJElLirTYz1nGFEzAf9lEgFhdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 03BBB1C14D8;
	Thu,  7 Mar 2024 17:13:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id 5E9B76000B;
	Thu,  7 Mar 2024 17:13:33 +0000 (UTC)
Message-ID: <3d9e47beeb08b3319651b49b81da4271cbbcad96.camel@perches.com>
Subject: Re: checkpatch.pl getting stuck on a macro in mm/kmsan/kmsan_test.c
From: Joe Perches <joe@perches.com>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Dan Carpenter
	 <dan.carpenter@linaro.org>
Cc: kernel-janitors <kernel-janitors@vger.kernel.org>, Linux Kernel
	Mailing List <linux-kernel@vger.kernel.org>
Date: Thu, 07 Mar 2024 09:13:32 -0800
In-Reply-To: <CAKXUXMwCdV466mRd4K0ePV73qDO9GRAph4KuC5nQ0JAp-ouemQ@mail.gmail.com>
References: 
	<CAKXUXMwCdV466mRd4K0ePV73qDO9GRAph4KuC5nQ0JAp-ouemQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 5E9B76000B
X-Stat-Signature: bcjmq85es8tghntjkgwc514jcdkrqkb4
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+lFb7snM1uJiWroRAnCi7TfyQNi+Z2QnM=
X-HE-Tag: 1709831613-598557
X-HE-Meta: U2FsdGVkX1/fqsZ7gRjkaPArITu2uknZnBXYsXrXUZ/0LIJoV41Ft4QGlY8WStIHj6JK0A/r25AhV4Xs1gk38f/cs+yGSdF9PNMuk6mMWMHLnIjR8OeQyOhBmTmntEML7n6fcwy1f0ywFPhBvJLBA12DqEhI3ouG8JxO1b6QMEbYC5ZwiSqARvUApEJBobDOf2A1/1woP6uPvSJzatdxN2VndGDFXCs7kpFODaYmKL/uTnOi+Lro4GK16qiZthtEkNsc1j6Lj2/i+70ZGA7mslan9AoB5tQt9CJeSSe+5DKKFGsalq787+RPFnzn6P8L

On Wed, 2024-03-06 at 10:33 +0100, Lukas Bulwahn wrote:
> Dear Joe,
>=20
> while running checkpatch.pl -f on all files in the kernel repository
> (v6.8-rc1) for some experiment, I noticed that checkpatch.pl got stuck
> on mm/kmsan/kmsan_test.c, i.e., ./scripts/checkpatch.pl -f
> mm/kmsan/kmsan_test.c never terminates.
>=20
> I could already boil it down to checkpatch getting stuck on the macro
> #define DEFINE_TEST_MEMSETXX(size), see lines 541 to 554 in
> mm/kmsan/kmsan_test.c on v6.8-rc1.
>=20
> I do not know if it is worth fixing, but certainly I was surprised
> that reasonable code can put checkpatch into some stuck state.
>=20

I know why it hangs.  I'll give it a think for a bit.
I rather doubt Dan's suggestion is the appropriate one.

Code is:

		volatile uint##size##_t
uninit;			\

and in checkpatch line 2304:

			$possible =3D~ s/\s*$Type\s*//g;

where uint is a $Type it removes.


