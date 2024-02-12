Return-Path: <linux-kernel+bounces-61073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6C7850CEE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 03:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FCE91C21712
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 02:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755C663AE;
	Mon, 12 Feb 2024 02:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="YO3CfOi9"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C60A5666
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707706507; cv=none; b=HxayjKer11wUjzFvFj34b73yBNzPFfUrjb92NdNPlCKBAMrZkCWebKAZ1Imie7JmZarZuQ35cxgCXsI4KnZzBiaURFnDe+clsoaaqdMuPPKj+urci0+5oeTiwanjq8/j4EuBEUUQDJxyRb9cnO7jmFWrNI0nL74lquJ7xrQ9WPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707706507; c=relaxed/simple;
	bh=qlUSYZD0bLJAuefTzEnPs6xV9IOF3ioSgYxX2S/86Xk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=sqyLZIWW1ciH8bSvybCWJdV2t13Dq5anbLU3wN3yb+FTn32dUVCR2u8ylK+s8QcoCxhdkEFapGbnLT/behzHS4CYE43tpaMrrpQJy0CS5f/9vaAbiapYbYjSBCstAafk6Ljst6tWpfQwNLlutTM8ZA7pdyPKdoDvktyrNIj9TFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=YO3CfOi9; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 41C2rr0O164311
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 11 Feb 2024 18:53:54 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 41C2rr0O164311
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1707706434;
	bh=CY9ifFy7eSyw2qG13qoWL2HTqSUMFVRnj/D+4u8/fvs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=YO3CfOi9iJ6gAAaAS3QDv5WzCKdgjgbkobkzY+sWw5ZFLvNk7asuLPuTnoKn0SkrD
	 vcotRQ1Td29rrNjXEiEBB8a3tOe0fkCJk9VvxD1z9iqN1DHf9e9Dpf9cPxKabyVyfP
	 EqTSTSshxor4lttUpspS+RzOnF3397VsZJMtREKllRxn1Mb7odH93jFiYV9+SdIsu2
	 29RlgPrT5zDQOSoXWqbw57ECD+rT8vlMlZylym5ymyxGul7GiALCPKvEE5QJQhZWVG
	 GH1cvP3BFCYmQ70wJpRnDTuXLorA7G4kCrcztpWdlvdXhtXEOiXCWbjobJKkjCWc3U
	 5ueSL1AIUDs/Q==
Date: Sun, 11 Feb 2024 18:53:50 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: hapter@420blaze.it, mingo@redhat.com
CC: tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_arch/x86/kernel/sys=5Fx86=5F64=2Ec=3A_rationale_?= =?US-ASCII?Q?for_0x40000000_for_MAP=5F32BIT=27s_start_address=3F?=
User-Agent: K-9 Mail for Android
In-Reply-To: <a5c2f06ba401cdf13bc87749341b1605@420blaze.it>
References: <a5c2f06ba401cdf13bc87749341b1605@420blaze.it>
Message-ID: <51E4051A-C8E2-4E11-9FB4-DADD99CE1913@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 11, 2024 12:52:45 AM PST, hapter@420blaze=2Eit wrote:
>I've found that passing in MAP_32BIT for mmap() will always return an add=
ress above 0x40000000=2E The problem seems to lie in arch/x86/kernek/sys_x8=
6_64=2Ec, where the following comment is the only thing close to a hint(Lin=
e 100):
>
>/* This is usually used needed to map code in small
>   model, so it needs to be in the first 31bit=2E Limit
>   it to that=2E  This means we need to move the
>   unmapped base down for this case=2E This can give
>   conflicts with the heap, but we assume that glibc
>   malloc knows how to fall back to mmap=2E Give it 1GB
>   of playground for now=2E -AK */
>
>Unfortunately this does not supply a rationale for starting from 0x400000=
00, which seems very arbitrary, and the git commit has been there since the=
 beginning of time (i=2Ee=2E as far the the git history goes), so the git b=
lame has not helped much to clarify it=2E I was also not able to find who "=
AK" was=2E
>
>I have found another operating system that provides MAP_32BIT, FreeBSD, t=
o not exhibit the same behavior and not cause any execution problems for RW=
X pages allocated below 0x40000000, so it does not seem a technical rationa=
le exists either=2E
>
>mmap will happily return 0x10000 (which seems like the lowest address the=
 kernel will map when you supply it as a hint, so I do not see any reason n=
ot to start the find from 0x10000, or something that isn't as big as 0x4000=
0000, which is big enough to impose a significant handicap for applications=
 using MAP_32BIT (e=2Eg=2E JITs that want to use CALL rel32 at all times)=
=2E
>
>I will happily await for any clarifications on this matter=2E
>
>- hapter

Yes it does=2E It is the heap, as described in the comment=2E

Does anyone know why glibc still uses the brk heap? It seems like a relic =
from a bygone time=2E

