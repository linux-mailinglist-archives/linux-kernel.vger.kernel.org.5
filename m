Return-Path: <linux-kernel+bounces-30335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 593DD831D43
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98A1CB21A01
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17FE2942A;
	Thu, 18 Jan 2024 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Lzr3rovx"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A714728E0B;
	Thu, 18 Jan 2024 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705594310; cv=none; b=vED4mcPDvviUPX/XJAwGfuajGyOjBwbIlXMv/tQSoQmZoDdTmTRWivEkLAipRdvCiKw8h6FbsnzNSM3YK4mw0z2LHHPQ1uujbR41qETzSlIkbifWpPSo+6rXh/44iRBn3ziW8h8CmP6n2PVaA7l+BQ8S0yfROmllGmzpJ4iyZaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705594310; c=relaxed/simple;
	bh=+amD+bxZBryr3MMtjAsPlP/HGDcam0tceeZ5dyFYnZo=;
	h=Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=qGsp5YCF4LQQnJ6a92asLJfBn/U8hYFQDJPxzz3xec56aakkmG7jEgyMV0Di57+8VGia6zwJ/aS6HYuKjCtZkmkQC13eB3DIMpXhUEND4co7FM4xM2Zn7e7ahyEMItluuNr2VGaQwIbsD0OJYGeicfo4jjp/bW3LLxBb471285k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Lzr3rovx; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 73EE47A21;
	Thu, 18 Jan 2024 16:11:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 73EE47A21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1705594302; bh=3HRi5GF1TAeVY+4xKMDRwDNwSXAhBkYztTTb+LS76kQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Lzr3rovxmvJUfX+bMePUILHF7PgF8v3kiBM5p+bLyZ4I1cZpbR+lL+Yq3sfn5IYVi
	 KURA+k9GC589XVm4nGvW9PUQUf2cL1PnXElx/Isdl6NCxCiJdMEvPNoRG6l8fip/Wu
	 Yclt2QELWVIZWq7E3o4kTlEt77ZEsaGALRZ+NeK6nniAiQg8dgB5ZYLWs2sn8JS0bS
	 /A8boPr0v6/z1r3+wlwr6XsTL3PXLedgYLB+whbvwlU5C1lse1xJIVG88Yce6K1hTS
	 cCX2Zn2yHBfvT/SfC4sbdR6rSzUxti3RlTsa8Evlm15i4kghta4yvZuvogfRujyRq6
	 ZoS8tRy5bCVsg==
From: Jonathan Corbet <corbet@lwn.net>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Remove reference to syscall trampoline in PTI
In-Reply-To: <dd0e864d-295a-4edc-bfd7-ad5de88d7a0c@suse.com>
References: <20231102130204.41043-1-nik.borisov@suse.com>
 <dd0e864d-295a-4edc-bfd7-ad5de88d7a0c@suse.com>
Date: Thu, 18 Jan 2024 09:11:41 -0700
Message-ID: <87edee1v0i.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Nikolay Borisov <nik.borisov@suse.com> writes:

> On 2.11.23 =D0=B3. 15:02 =D1=87., Nikolay Borisov wrote:
>> Commit bf904d2762ee ("x86/pti/64: Remove the SYSCALL64 entry trampoline")
>> removed the syscall trampoline and instead opted to enable using the
>> default syscall64 entry point by mapping the percpu TSS. Unfortunately
>> the PTI documentation wasn't updated when the respective changes were
>> made, so let's bring the doc up to speed.
>>=20
>> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
>
> Ping

Hmm...this has indeed languished for a while.  I was waiting for an ack
from x86land, but I guess I'll just apply it unless somebody screams.

Thanks,

jon

