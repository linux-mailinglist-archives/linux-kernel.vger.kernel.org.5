Return-Path: <linux-kernel+bounces-160883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2E28B4402
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 06:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791CD1F22A9E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 04:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE783C485;
	Sat, 27 Apr 2024 04:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="OOdDeghY"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4241381CC
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 04:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714190433; cv=none; b=t1dbqw5AA75lTt68CxP+7dmq6fy0wU+olQyOpl6UHY3yYTTB5RVoWip5UeQwTqCTzyYFiTH6FTgAJ/CIPSxYYqIakBU2cet0imrKx6XimMG7G2yzjjCajd6c3PrNj7MsrUg8yYdFWGezP5yaewbCixhpjNzizdfmIh0CiRgCDuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714190433; c=relaxed/simple;
	bh=sJtvoDhIP4YEm0QlGbaEJ5BUzGmdsLXCnyaF1NsEp1Y=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=BnKxf314LPswF5Wo5OL3LV7Ezgiww27LdhGH1GOx8nSvt9U0a9koxLIVb8SZo8jgCp6KCQSc3zVsL/0EUEYfqrArI5I3FLussquyeDW96m7Bh58hXCUtPzHN7IfwiQk95b8TeynzxcHNgYgckHAui/qPgbepoJMRxcy1dZ4u53U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=OOdDeghY; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1714190429;
	bh=sJtvoDhIP4YEm0QlGbaEJ5BUzGmdsLXCnyaF1NsEp1Y=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=OOdDeghYMYvaUCy+MTrdb7XoT7Zaie53pTl0Huk4DUY4L5ZIAnidGuahtW2mrQ78Q
	 DrX1nDEdNSVIJr2jazrr6fEnuHjTW11pQ9APrCur2D3kLepNZVgZUDp3wQ7/1ntuPB
	 aasnR/wzyrxU91CA3BqwnarxJaE9l8f/kHlTy7wI=
Received: from [IPv6:240e:358:1198:0:dc73:854d:832e:4] (unknown [IPv6:240e:358:1198:0:dc73:854d:832e:4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 9F6B767168;
	Sat, 27 Apr 2024 00:00:26 -0400 (EDT)
Message-ID: <dfdc9823a0b89c8582587fa75448bba5c3a7e15e.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Provide __lshrti3, __ashrti3, and __ashrti3
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>
In-Reply-To: <CAAhV-H74cQ4XdDez5PipCxUZTpfS=CA6azL5qob=jGGebobD6g@mail.gmail.com>
References: <20240426121442.882029-1-xry111@xry111.site>
	 <CAAhV-H74cQ4XdDez5PipCxUZTpfS=CA6azL5qob=jGGebobD6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Apr 2024 12:00:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.52.1 

On Sat, 2024-04-27 at 10:50 +0800, Huacai Chen wrote:
> Hi, Ruoyao,
>=20
> I don't think #ifdef CONFIG_ARCH_SUPPORTS_INT128 is needed here.
> S390/ARM64/RISCV all built it unconditionally.

The problem here is RISCV and ARM64 are using an incorrect prototype for
these functions in asm-prototypes.h:

long long __lshrti3(long long a, int b);=20
long long __ashrti3(long long a, int b);=20
long long __ashlti3(long long a, int b);=20

where "long long" is not 128-bit.  Despite this seems working for RISC-V
and ARM64 I really dislike it.

S390 seems assuming CONFIG_ARCH_SUPPORTS_INT128 is always true, but I
don't think we can assume it too (at least it'll likely to be false for
LA32, so doing so will cause trouble when we add LA32 support).

So if we don't want to check CONFIG_ARCH_SUPPORTS_INT128 and still use a
correct prototype, we'll do:

diff --git a/arch/loongarch/include/asm/asm-prototypes.h b/arch/loongarch/i=
nclude/asm/asm-prototypes.h
index 51f224bcfc65..0a57db01116d 100644
--- a/arch/loongarch/include/asm/asm-prototypes.h
+++ b/arch/loongarch/include/asm/asm-prototypes.h
@@ -7,8 +7,6 @@
 #include <asm/ftrace.h>
 #include <asm-generic/asm-prototypes.h>
=20
-#ifdef CONFIG_ARCH_SUPPORTS_INT128
-__int128_t __ashlti3(__int128_t a, int b);
-__int128_t __ashrti3(__int128_t a, int b);
-__int128_t __lshrti3(__int128_t a, int b);
-#endif
+struct { u64 lo, hi; } __ashlti3(u64 lo, u64 hi, int b);
+struct { u64 lo, hi; } __ashrti3(u64 lo, u64 hi, int b);
+struct { u64 lo, hi; } __lshrti3(u64 lo, u64 hi, int b);
diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
index f61af161f16e..23600c128e05 100644
--- a/arch/loongarch/lib/Makefile
+++ b/arch/loongarch/lib/Makefile
@@ -10,4 +10,4 @@ obj-$(CONFIG_CPU_HAS_LSX) +=3D xor_simd.o xor_simd_glue.o
=20
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) +=3D error-inject.o
=20
-obj-$(CONFIG_ARCH_SUPPORTS_INT128) +=3D tishift.o
+obj-$(CONFIG_64BIT) +=3D tishift.o

Is this really better than checking CONFIG_ARCH_SUPPORTS_INT128?  I
don't know...

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

