Return-Path: <linux-kernel+bounces-163250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38C88B67A8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C43FBB22199
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AAB525D;
	Tue, 30 Apr 2024 01:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gYdMRRJk"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCA717F5;
	Tue, 30 Apr 2024 01:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714441583; cv=none; b=J9JNwIIcRB3Uk8lHsVz/hiYePkr/gqXiUJocURXFvCzCgmOVGHnxkB3pFbxjQuOG0jt41c5Goq5CESXDaBmGMlt58fRFgeohYDSUGRxMFWXZp+Ge5Ic6PRyTTMn2y0ZRfkHe0sPQcU307Y6oaUnIAywVYcd7p0+fXRzL+tWE8aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714441583; c=relaxed/simple;
	bh=f/XBlC+boAOS1gDGEGOBzm3DPT9aqczRyWdZDoucV1U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=fuH9i6EETELUHXvxOY0NNK8TiRpe6PkHnjk8VAWTxlrcPlILWqsIyX+oNF9gL4j1CDAK7ewzurYmb+TQzmOHrNOOoz7rli8WzolD/pdKb1BEpPSqa9AB9zlUB/pRgNjd1X6cmMprD220hKwyZg+V6iSXSq602wab3sCWlQ5xVlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=gYdMRRJk; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714441578;
	bh=fV/cOYzT6LmLxkiPuYWOK3irW1uzWS5hYhP4cXqbGao=;
	h=Date:From:To:Cc:Subject:From;
	b=gYdMRRJkaA25k++r01A6sA/yWZgWGhBPx7s7gxjEmeDXL20h9vxcnLzyEOeD2/5TT
	 j3sqgTWWgCt6q1giuG96ijNIv1kafVCJbDLYPUIJXD5WnI+uCVb7SCn5mj/5GFDq+v
	 rbVhiE/InPneA2qpN2BAetrI/g/dabWP0fk9mDIX6aNwD7q48gOIHDAyu3F9xVaqIm
	 qmXwEnL9FvhSV1jBTBeXCD1ZA89EKs6/ai4NLm71bl6mfV1awe0gv8DDQ7LOmyvVM2
	 ZFqCXN3sHr37pJ1IivYrw1jVGNgV9oJTdNLL1yyT1wmavALdYR+7io3On5ZWHRrgv4
	 zpVHMsv0+vo3Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VT32L1kLHz4x1R;
	Tue, 30 Apr 2024 11:46:16 +1000 (AEST)
Date: Tue, 30 Apr 2024 11:46:13 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the dmi tree
Message-ID: <20240430114613.0cef65fc@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/o+=qb0K4XMlUtRh4lKU4i5E";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/o+=qb0K4XMlUtRh4lKU4i5E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the dmi tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

In file included from include/asm-generic/bug.h:22,
                 from arch/arm/include/asm/bug.h:60,
                 from include/linux/bug.h:5,
                 from include/linux/thread_info.h:13,
                 from include/asm-generic/preempt.h:5,
                 from ./arch/arm/include/generated/asm/preempt.h:1,
                 from include/linux/preempt.h:79,
                 from include/linux/spinlock.h:56,
                 from include/linux/mmzone.h:8,
                 from include/linux/gfp.h:7,
                 from include/linux/umh.h:4,
                 from include/linux/kmod.h:9,
                 from include/linux/module.h:17,
                 from drivers/firmware/dmi_scan.c:5:
drivers/firmware/dmi_scan.c: In function 'dmi_decode_table':
include/linux/kern_levels.h:5:25: warning: format '%ld' expects argument of=
 type 'long int', but argument 2 has type 'int' [-Wformat=3D]
    5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
      |                         ^~~~~~
include/linux/printk.h:429:25: note: in definition of macro 'printk_index_w=
rap'
  429 |                 _p_func(_fmt, ##__VA_ARGS__);                      =
     \
      |                         ^~~~
include/linux/printk.h:510:9: note: in expansion of macro 'printk'
  510 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
      |         ^~~~~~
include/linux/kern_levels.h:12:25: note: in expansion of macro 'KERN_SOH'
   12 | #define KERN_WARNING    KERN_SOH "4"    /* warning conditions */
      |                         ^~~~~~~~
include/linux/printk.h:510:16: note: in expansion of macro 'KERN_WARNING'
  510 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
      |                ^~~~~~~~~~~~
drivers/firmware/dmi_scan.c:109:25: note: in expansion of macro 'pr_warn'
  109 |                         pr_warn(FW_BUG
      |                         ^~~~~~~

Introduced by commit

  868577e6bfe1 ("firmware: dmi: Stop decoding on broken entry")

Include printk.h?
--=20
Cheers,
Stephen Rothwell

--Sig_/o+=qb0K4XMlUtRh4lKU4i5E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYwTWUACgkQAVBC80lX
0GyvWQf/S6SHEsGTXftvQFWz756B7Eqj1dVwdsf9EioubZEKshdvUEvenDhWcWRT
e9Wfe0MG2YcSNScDjIHWAr3Rf63AWIuakIzDn6N7mSWFWoOkqwaXySbCyqquc3Ih
gnHDmHXgR6HxRe0OetQHFwuANtBOuO0XcmOhDMixRTSzbQW16m2pICvIGzzdXzud
0NAHjOEh2bHE/i9qERS6gNzsCpv1zoVb2vVB6Yl+cD6hSvOHHuri00tqCjmYRFF4
wO3C/vnZI3a1CuWczI6tgWXINZbbKLFBX+GGeI9hV6xK8AornFBfskgZz/O6olzl
BraSutiwpoLHY0LppRTk1917++Bh6g==
=at/o
-----END PGP SIGNATURE-----

--Sig_/o+=qb0K4XMlUtRh4lKU4i5E--

