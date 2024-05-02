Return-Path: <linux-kernel+bounces-166303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C213D8B98CD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4B491C2030D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACC858AB9;
	Thu,  2 May 2024 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="V/QLUSBx"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0419A56B76;
	Thu,  2 May 2024 10:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714645744; cv=none; b=YYuiZVANCbfooBn88Vf+Zx7uqBtmP5G/DO7MLQ094CVunOiE06nfrbCsUyq0LWVBQQHezMhnuzfsO1p9B/O92aVe8QwlRwU2TAeeiNbGGkCEvylXvyI9t0lwJq4PPJTMWfLRp0gOBKUgl/N5b3JH3Il3vmArLZwqwjiuFHkIy1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714645744; c=relaxed/simple;
	bh=whidl31W9wnEyJzM1qBGPKxDBJA7id+swSjbG2mxWuc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PAhkKB00Z8YLA+VZs43FQ+2+0nSLsvHxWYxOAIxPC61hifbZOUTW5j8hEEyAXj3gvzrMdYApcifK2JAQbDvtmZ3dm9MnjT/Z9NbsNr3cN1cUzzI/btfGrh/ahxUvfjvN+y2yZDkT4kLVK06rMjJzc1h5q8EjUthQGpC9OwIQmQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=V/QLUSBx; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BC+oMysJAVe9SJid1/2jJMdxt6+AgqCmgx++798d6nA=; t=1714645742; x=1715250542; 
	b=V/QLUSBxswksjyY8HDGBfO2iwggf4o9oSxDJKUyC87OdAxUBaqgBIKjIUCrFrehX2FM0ZwzBonL
	H6DFjNpR92qHk66l1EGD7hbs0cUMdtBrMJ8V9Rx32d/9XYwIWpCgBU37iOpxD1ebSeDgbqoydzljX
	gBumbmhRxJ4wsU/GpcWw2VohW2BqfBGQdE4WDp5MslIN6YwbGPIQhCEWrDxq+efrzrwV/FzwssUtY
	N9iJKrNdGazJX4t+lAeKnlHDpCWFGagyBen7dQT0cPsOUH/wMRw6zRz1ZnmpZf+fbU2d3DvIkzD/a
	mRA/a26Dye60N7CyJCYykpVsrclSqPKFcVjQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s2TgS-00000001ygk-0gDf; Thu, 02 May 2024 12:29:00 +0200
Received: from p57bd90e8.dip0.t-ipconnect.de ([87.189.144.232] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s2TgR-000000007bY-4758; Thu, 02 May 2024 12:29:00 +0200
Message-ID: <1b7525bcda4c58eccaf7737bd33bdb1b7f764e28.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] Revert "sh: Handle calling csum_partial with misaligned
 data"
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Guenter Roeck <linux@roeck-us.net>, Yoshinori Sato
	 <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 02 May 2024 12:28:59 +0200
In-Reply-To: <20240324231804.841099-1-linux@roeck-us.net>
References: <20240324231804.841099-1-linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Sun, 2024-03-24 at 16:18 -0700, Guenter Roeck wrote:
> This reverts commit cadc4e1a2b4d20d0cc0e81f2c6ba0588775e54e5.
>=20
> Commit cadc4e1a2b4d ("sh: Handle calling csum_partial with misaligned
> data") causes bad checksum calculations on unaligned data. Reverting
> it fixes the problem.
>=20
>     # Subtest: checksum
>     # module: checksum_kunit
>     1..5
>     # test_csum_fixed_random_inputs: ASSERTION FAILED at lib/checksum_kun=
it.c:500
>     Expected ( u64)result =3D=3D ( u64)expec, but
>         ( u64)result =3D=3D 53378 (0xd082)
>         ( u64)expec =3D=3D 33488 (0x82d0)
>     # test_csum_fixed_random_inputs: pass:0 fail:1 skip:0 total:1
>     not ok 1 test_csum_fixed_random_inputs
>     # test_csum_all_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.=
c:525
>     Expected ( u64)result =3D=3D ( u64)expec, but
>         ( u64)result =3D=3D 65281 (0xff01)
>         ( u64)expec =3D=3D 65280 (0xff00)
>     # test_csum_all_carry_inputs: pass:0 fail:1 skip:0 total:1
>     not ok 2 test_csum_all_carry_inputs
>     # test_csum_no_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c=
:573
>     Expected ( u64)result =3D=3D ( u64)expec, but
>         ( u64)result =3D=3D 65535 (0xffff)
>         ( u64)expec =3D=3D 65534 (0xfffe)
>     # test_csum_no_carry_inputs: pass:0 fail:1 skip:0 total:1
>     not ok 3 test_csum_no_carry_inputs
>     # test_ip_fast_csum: pass:1 fail:0 skip:0 total:1
>     ok 4 test_ip_fast_csum
>     # test_csum_ipv6_magic: pass:1 fail:0 skip:0 total:1
>     ok 5 test_csum_ipv6_magic
>  # checksum: pass:2 fail:3 skip:0 total:5
>  # Totals: pass:2 fail:3 skip:0 total:5
> not ok 22 checksum
>=20
> Fixes: cadc4e1a2b4d ("sh: Handle calling csum_partial with misaligned dat=
a")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/sh/lib/checksum.S | 67 ++++++++++++------------------------------
>  1 file changed, 18 insertions(+), 49 deletions(-)
>=20
> diff --git a/arch/sh/lib/checksum.S b/arch/sh/lib/checksum.S
> index 3e07074e0098..06fed5a21e8b 100644
> --- a/arch/sh/lib/checksum.S
> +++ b/arch/sh/lib/checksum.S
> @@ -33,7 +33,8 @@
>   */
> =20
>  /*=09
> - * asmlinkage __wsum csum_partial(const void *buf, int len, __wsum sum);
> + * unsigned int csum_partial(const unsigned char *buf, int len,
> + *                           unsigned int sum);
>   */
> =20
>  .text
> @@ -45,31 +46,11 @@ ENTRY(csum_partial)
>  	   * Fortunately, it is easy to convert 2-byte alignment to 4-byte
>  	   * alignment for the unrolled loop.
>  	   */
> +	mov	r5, r1
>  	mov	r4, r0
> -	tst	#3, r0		! Check alignment.
> -	bt/s	2f		! Jump if alignment is ok.
> -	 mov	r4, r7		! Keep a copy to check for alignment
> +	tst	#2, r0		! Check alignment.
> +	bt	2f		! Jump if alignment is ok.
>  	!
> -	tst	#1, r0		! Check alignment.
> -	bt	21f		! Jump if alignment is boundary of 2bytes.
> -
> -	! buf is odd
> -	tst	r5, r5
> -	add	#-1, r5
> -	bt	9f
> -	mov.b	@r4+, r0
> -	extu.b	r0, r0
> -	addc	r0, r6		! t=3D0 from previous tst
> -	mov	r6, r0
> -	shll8	r6
> -	shlr16	r0
> -	shlr8	r0
> -	or	r0, r6
> -	mov	r4, r0
> -	tst	#2, r0
> -	bt	2f
> -21:
> -	! buf is 2 byte aligned (len could be 0)
>  	add	#-2, r5		! Alignment uses up two bytes.
>  	cmp/pz	r5		!
>  	bt/s	1f		! Jump if we had at least two bytes.
> @@ -77,17 +58,16 @@ ENTRY(csum_partial)
>  	bra	6f
>  	 add	#2, r5		! r5 was < 2.  Deal with it.
>  1:
> +	mov	r5, r1		! Save new len for later use.
>  	mov.w	@r4+, r0
>  	extu.w	r0, r0
>  	addc	r0, r6
>  	bf	2f
>  	add	#1, r6
>  2:
> -	! buf is 4 byte aligned (len could be 0)
> -	mov	r5, r1
>  	mov	#-5, r0
> -	shld	r0, r1
> -	tst	r1, r1
> +	shld	r0, r5
> +	tst	r5, r5
>  	bt/s	4f		! if it's =3D0, go to 4f
>  	 clrt
>  	.align	2
> @@ -109,31 +89,30 @@ ENTRY(csum_partial)
>  	addc	r0, r6
>  	addc	r2, r6
>  	movt	r0
> -	dt	r1
> +	dt	r5
>  	bf/s	3b
>  	 cmp/eq	#1, r0
> -	! here, we know r1=3D=3D0
> -	addc	r1, r6			! add carry to r6
> +	! here, we know r5=3D=3D0
> +	addc	r5, r6			! add carry to r6
>  4:
> -	mov	r5, r0
> +	mov	r1, r0
>  	and	#0x1c, r0
>  	tst	r0, r0
> -	bt	6f
> -	! 4 bytes or more remaining
> -	mov	r0, r1
> -	shlr2	r1
> +	bt/s	6f
> +	 mov	r0, r5
> +	shlr2	r5
>  	mov	#0, r2
>  5:
>  	addc	r2, r6
>  	mov.l	@r4+, r2
>  	movt	r0
> -	dt	r1
> +	dt	r5
>  	bf/s	5b
>  	 cmp/eq	#1, r0
>  	addc	r2, r6
> -	addc	r1, r6		! r1=3D=3D0 here, so it means add carry-bit
> +	addc	r5, r6		! r5=3D=3D0 here, so it means add carry-bit
>  6:
> -	! 3 bytes or less remaining
> +	mov	r1, r5
>  	mov	#3, r0
>  	and	r0, r5
>  	tst	r5, r5
> @@ -159,16 +138,6 @@ ENTRY(csum_partial)
>  	mov	#0, r0
>  	addc	r0, r6
>  9:
> -	! Check if the buffer was misaligned, if so realign sum
> -	mov	r7, r0
> -	tst	#1, r0
> -	bt	10f
> -	mov	r6, r0
> -	shll8	r6
> -	shlr16	r0
> -	shlr8	r0
> -	or	r0, r6
> -10:
>  	rts
>  	 mov	r6, r0

Applied to my sh-linux tree in the for-next branch.

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

