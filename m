Return-Path: <linux-kernel+bounces-112409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DBE88796B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 17:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7911F1F219E1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 16:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1CD42ABE;
	Sat, 23 Mar 2024 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="vh6YNanG"
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15D722625
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 16:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711211873; cv=none; b=HlkugIZS1YJm6cmSH0pXFhp8aVghl57eMMgClqbkIO8Cbl9nQ5mJy10E4W0yOIKxVTzdSbbd5DegoTiVIZ/L/pd3lGIVPDXYXotCHW57x8pMSXLz0HwNV2DKAS/wRsJ0lzPDeaJiDgs1BCzITa4xZE07HCn/vq0lVWJ2hHIL/kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711211873; c=relaxed/simple;
	bh=XEiB6i9LbUv2gvZ0g7Rzdz2DBRkWU14YeEGBU6bTRsc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pntMNLFoCV5SW17ZY+Ld+ojcTlD28XIvSNbXw1eM4blhuMK0cVB4UWmVcoRwRSpjFVxFcaRLzpMWy8xpKkbtWG2Uj/wYsZ2U+l0EXR3BTSVZt/7Y12xdgKQvCeD+IbMkDmeSjZLR8hS4Z7BAGZHBFUWL/HyrYf6a40Ku53Ni3Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=vh6YNanG; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1711211860; x=1711471060;
	bh=XEiB6i9LbUv2gvZ0g7Rzdz2DBRkWU14YeEGBU6bTRsc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=vh6YNanGH1X20zGK1tfAaV4nESkLDgECUm44By3xP/rrepE0RC54y96FmF8vXXoAX
	 C8OKoFzrhRaela23fr04aAr9c9G2k19VwHX2hon3KR5Ww1bdaSY3UiHRthffDJvkbO
	 vGnHnfWrjy3AqBoDJlHzl0sN3UtpvfHC1wkQiFeZzIg2BjW8P4jyQJcs/uNsUOAo8b
	 hRInHyvu2tAFYn2J7gbRiwVWNGTN3SKlnU3vwFFRAnSLfUFFaRPx7Zh8H1BW/APelU
	 UOHoNnylCMXjdiHAPiN/8IXicIHHkO52kCjxeGvzWdlGLNNJYDuqcCv8wRFnta3igC
	 6Wb2bQ5hnio2Q==
Date: Sat, 23 Mar 2024 16:37:27 +0000
To: Sam Ravnborg <sam@ravnborg.org>
From: Koakuma <koachan@protonmail.com>
Cc: "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "ndesaulniers@google.com" <ndesaulniers@google.com>, "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [sparc] Use of -fcall-used-* flags in Makefile?
Message-ID: <FLtGz1AK53Qsar2xlt7KBdmT7JLz3H_NoxJQ0UaC0zqNmBtsQ2eSU6LA_lojbVQh8gArSmZoVikYxEuTC4j75PMP_BcnGPuAM2mv1YK7GHA=@protonmail.com>
In-Reply-To: <20240319221615.GA379167@ravnborg.org>
References: <JAYB7uS-EdLABTR4iWZdtFOVa5MvlKosIrD_cKTzgeozCOGRM7lhxeLigFB1g3exX445I_W5VKB-tAzl2_G1zCVJRQjp67ODfsSqiZWOZ9o=@protonmail.com> <20240319221615.GA379167@ravnborg.org>
Feedback-ID: 6608610:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello Sam,

Sam Ravnborg <sam@ravnborg.org> wrote:

> Hi Koakuma,
> Looking at https://github.com/gcc-mirror/gcc/blob/master/gcc/config/sparc=
/sparc.h
> I read that:
>=20
> On v9 systems:
> g1,g5 are free to use as temporaries, and are free to use between calls
> ...
> g6-g7 are reserved for the operating system (or application in
> embedded case).
>=20
> Based on the above I would assume gcc do not change behaviour with or
> without -fcall-used-g7.
> [...]
> For sparc32 the above file says:
>=20
> g5 through g7 are reserved for the operating system.
>=20
> So again - it looks like -fcall-used-g5 -fcall-used-g7 should have no
> effect here and verification on a real target would be nice.
>=20
> Sam

From my understanding (and looking at the codegen results) those flags
forces GCC to treat the named register as volatile, despite what the ABI
says. However, I also believe that removing them wouldn't be harmful?

To quote my reasoning in the LLVM tracker:
> omitting the flags shouldn't be harmful either - compilers will now
> simply refuse to touch them, and any assembly code that happens
> to touch them would still work like usual (because Linux' conventions
> already treats them as volatile anyway).

But I am not entirely sure about it, that is why it'd be great if there's
some explaination on why those flags were added in the first place.

> I do not have a sparc64 system at my hands - and for this qemu may not
> cut it. But it would be super if someone with a working sparc64 target
> could verify if the kernel could be built and works without
> -fcall-used-g7.

I am currently running a build with those flags taken out on a T5120,
and the kernel seems to be running okay for what I do (LLVM development),
but I don't know if there are more comprehensive test suite for me
to try on.


