Return-Path: <linux-kernel+bounces-60363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D38C8503F7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 11:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31CB11F22D96
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 10:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F78C364C4;
	Sat, 10 Feb 2024 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=envs.net header.i=@envs.net header.b="Q6KVukH2"
Received: from mail.envs.net (mail.envs.net [5.199.136.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6D12E3FE;
	Sat, 10 Feb 2024 10:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.199.136.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707561262; cv=none; b=f0le+39CQapKINAhp1StyQRrbHPpcEhZpdvLGK4tE8jgzYUQQUmo7XHUwNxHHJL5wNKi8n7uTJO2EX2rjU4wHMYJ44WU++deYXa3zkQDL3TGxXTyu8B8hzUFGexa2I4dZS+knS63pqzguk8KK/PAbCeegrZ+TA4Hmkmym6D3PD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707561262; c=relaxed/simple;
	bh=AsuSDfnSnrEsA8nNMuWFNnT28IB3MGY8F39wtmkbqgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=itpB1RGsE098W8aXaxFGh83Rb3l+aOmYCAtxWY0Axp7SF6AT4xmh600zO51h4q4Xl0NmRqvIS4SWvjITaOMhtNxZK0XPmKvcSo2RhgyvTj6D+C010bI4pMt4jAsGLGWxLTXTZCND6WXnOuTNd7S0ucsK2vBB3eTVMgYhuVeLkKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=envs.net; spf=pass smtp.mailfrom=envs.net; dkim=pass (4096-bit key) header.d=envs.net header.i=@envs.net header.b=Q6KVukH2; arc=none smtp.client-ip=5.199.136.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=envs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=envs.net
Received: from localhost (mail.envs.net [127.0.0.1])
	by mail.envs.net (Postfix) with ESMTP id 680A738A0669;
	Sat, 10 Feb 2024 10:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=envs.net; s=modoboa;
	t=1707561258; bh=5a4661pQcO2UmB9YG8h4KMvOlZHo5f/ZdvFHx3vRpxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q6KVukH29RtPYwyml17BXgB1SmxkBYEw4zRKRdKhpkPRa67se3EdVj24xz81Ui0wV
	 bBNmdiX5dFJ/Xp/zyB26rb9gY+UsBhPlTzHR0/YSXlz0jXt7TQHToVwVdQ0m6D9VMa
	 vNmRfdEn5LTArmMr2SIjvZMADyomU00AaofZpWTreGX1i0gAO4bXRV+RE88WDG3Yb+
	 3kznEc0XPTY7aoYT1FMzoz8fmwpTlX6A52K2JY85jYorttEXIMeU9kV5yut/B+iGjv
	 JJDyZO87vAiyGH2IBxG1sPRLEIGjHz8ez6XEerXvaRVtRjAaM4QagCuKSpRExeFzYP
	 QWY4e7gG4PVlyVXAhnmaRRHCmLovC3fuoZCGm2lD0leXsnwnsZ7k2OVV9Zf3rYdEpx
	 /Uw5xIjxS5AAh33rNa7LVNAHvNU1hzgGBP06bFerJ9AAf8vZx63wEeS4681LKJA4Bq
	 1l68Gh2zHrzCxnj4kay9zKRabS4r95sXzhEeLLP6gVYWWKBuhrD8bFsA0JdWc53J6T
	 FGqpvGOMqiE8WlDTiWAI2lXoaCMeI1fDKKyf7P6rtFB+LzpPRZLquhDLkUmF97Tmog
	 +xitv9uyVWBsUPLRSOifICJt7QN451b4+c3v9BChHq9OmqaRl2JUMQP4TX3HTQhXpu
	 1H/k22hJKWvTVPg81yHEaMpo=
X-Virus-Scanned: Debian amavisd-new at mail.envs.net
Received: from mail.envs.net ([127.0.0.1])
	by localhost (mail.envs.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BTTrmuQrF_Ze; Sat, 10 Feb 2024 10:33:36 +0000 (UTC)
Received: from xtex.localnet (unknown [103.84.217.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.envs.net (Postfix) with ESMTPSA;
	Sat, 10 Feb 2024 10:33:36 +0000 (UTC)
From: xtex <xtex@envs.net>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Dinh Nguyen <dinguyen@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH 1/2] kbuild: Abort make on install failures
Date: Sat, 10 Feb 2024 18:33:31 +0800
Message-ID: <4681093.vXUDI8C0e8@xtex>
In-Reply-To: <ZcdP7CC+OMbp5ZMi@shell.armlinux.org.uk>
References:
 <20240210074601.5363-1-xtex@envs.net> <20240210074601.5363-2-xtex@envs.net>
 <ZcdP7CC+OMbp5ZMi@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2124038.9o76ZdvQCi";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart2124038.9o76ZdvQCi
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: xtex <xtex@envs.net>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Subject: Re: [PATCH 1/2] kbuild: Abort make on install failures
Date: Sat, 10 Feb 2024 18:33:31 +0800
Message-ID: <4681093.vXUDI8C0e8@xtex>
In-Reply-To: <ZcdP7CC+OMbp5ZMi@shell.armlinux.org.uk>
MIME-Version: 1.0

On Saturday, February 10, 2024 6:29:00 PM CST Russell King (Oracle) wrote:
> What about #!/bin/sh -e on the first line, which is the more normal way
> to do this for an entire script?

Will do this in V2.

-- 
xtex @ Sat Feb 10 10:32:32 AM UTC 2024

--nextPart2124038.9o76ZdvQCi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRyMYBLBSxnDxWmdx25GAhu2ARbkQUCZcdQ+wAKCRC5GAhu2ARb
kfdKAPoCZsP7u1iukZo1ZGlB4JJK7jPZWKy/eD8aN/lnP9KNjgD/Ve0PtHuJoCdb
qNDGRUIqnxjTCIqNFhKrA1/d7wWfEQA=
=uBWc
-----END PGP SIGNATURE-----

--nextPart2124038.9o76ZdvQCi--




