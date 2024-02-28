Return-Path: <linux-kernel+bounces-84450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB8286A6E5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8FC282ED0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4141E864;
	Wed, 28 Feb 2024 02:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HQeO9uEK"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B39DDD7;
	Wed, 28 Feb 2024 02:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709088511; cv=none; b=KsHuO6F5E4G6Jj/JvAz5kLhh4h9nxTF6QjYIBdRFeJxM61oiJOUHz/IVw15DFbwISX7/r7jzK6I7WZz8zPep5VctyQIJi0wwQXuDs5voclO7HnDXSYxejFB7mgCfgmHgxMKQO8TDkVlQ1i7GDUSHh4K+/7jbo4Q5QaGspPDvoLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709088511; c=relaxed/simple;
	bh=ICAns8wxjd1PYdG47lGBYIqp/QhHF4aDdoFKaENJqyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Wzz6E7aVRHbtXlTdfy2uTYkvKsruZxzPBwNYOnMddHVZvc0A7JT7ZrqUb2VlwfEweJrr6l/ld6oCG7p2aQe1C0NPB1q+dRltJUaUK6G6XxuIsOnWmxvsCVoGo2HNtAeXaOQ5E8tEwt69RmDwIak6LLezLrJkqOzgdi03l7p0L6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=HQeO9uEK; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709088500;
	bh=TmErh517pP890p8HTJUYzlERLASanZiIftKNJ3aw8Bo=;
	h=Date:From:To:Cc:Subject:From;
	b=HQeO9uEK4B1Kkj5y7Agyt+wXV7A/sP9SnOpWm2CanRwUsuzqCV/N6IYskYFYMmTxb
	 PLze9uTbyhag0rOJ/uiGOUeTDMDezAwjhB6oUQ1dMiSB7PJaLFcws7/XRA717hOxy5
	 yRPpjpfJ5WR1d7DGNCM9hCSHYtY1F+06Emi27fJ+XDpeT2iwqXrq/IOiOXupgzi2a1
	 oNKnyRy8nHOCz2GiahHARyom6JXOHpWFcuVeGLLEtg/Mv9Ogvh1RDh0hnfu1GpI5A1
	 35psKrmbuMGY1jBY7+ylLTa4zjBf9eu1UIV7ab9IXQzuR111RuwugwwE11IKdoIetR
	 ehOzUmmLpAUYg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TkzLW67ljz4wbQ;
	Wed, 28 Feb 2024 13:48:19 +1100 (AEDT)
Date: Wed, 28 Feb 2024 13:48:18 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Shuah Khan <skhan@linuxfoundation.org>, Brendan Higgins
 <brendanhiggins@google.com>
Cc: David Gow <davidgow@google.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the kunit-next tree
Message-ID: <20240228134818.7b6134dc@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oNsIlO=ukzVRl5gjkW5zm.5";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/oNsIlO=ukzVRl5gjkW5zm.5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kunit-next tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from drivers/gpu/drm/tests/drm_buddy_test.c:7:
drivers/gpu/drm/tests/drm_buddy_test.c: In function 'drm_test_buddy_alloc_c=
ontiguous':
drivers/gpu/drm/tests/drm_buddy_test.c:58:40: error: format '%u' expects ar=
gument of type 'unsigned int', but argument 7 has type 'long unsigned int' =
[-Werror=3Dformat=3D]
   58 |                                        "buddy_alloc hit an error si=
ze=3D%u\n",
      |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
   59 |                                        ps);
      |                                        ~~
      |                                        |
      |                                        long unsigned int
include/kunit/test.h:597:37: note: in definition of macro '_KUNIT_FAILED'
  597 |                                     fmt,                           =
            \
      |                                     ^~~
include/kunit/test.h:662:9: note: in expansion of macro 'KUNIT_UNARY_ASSERT=
ION'
  662 |         KUNIT_UNARY_ASSERTION(test,                                =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:1233:9: note: in expansion of macro 'KUNIT_FALSE_MSG_A=
SSERTION'
 1233 |         KUNIT_FALSE_MSG_ASSERTION(test,                            =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/tests/drm_buddy_test.c:55:17: note: in expansion of macro '=
KUNIT_ASSERT_FALSE_MSG'
   55 |                 KUNIT_ASSERT_FALSE_MSG(test,
      |                 ^~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/tests/drm_buddy_test.c:58:72: note: format string is define=
d here
   58 |                                        "buddy_alloc hit an error si=
ze=3D%u\n",
      |                                                                    =
   ~^
      |                                                                    =
    |
      |                                                                    =
    unsigned int
      |                                                                    =
   %lu
drivers/gpu/drm/tests/drm_buddy_test.c:65:32: error: format '%u' expects ar=
gument of type 'unsigned int', but argument 7 has type 'long unsigned int' =
[-Werror=3Dformat=3D]
   65 |                                "buddy_alloc didn't error size=3D%u\=
n", 3 * ps);
      |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
  ~~~~~~
      |                                                                    =
    |
      |                                                                    =
    long unsigned int
include/kunit/test.h:597:37: note: in definition of macro '_KUNIT_FAILED'
  597 |                                     fmt,                           =
            \
      |                                     ^~~
include/kunit/test.h:654:9: note: in expansion of macro 'KUNIT_UNARY_ASSERT=
ION'
  654 |         KUNIT_UNARY_ASSERTION(test,                                =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:1214:9: note: in expansion of macro 'KUNIT_TRUE_MSG_AS=
SERTION'
 1214 |         KUNIT_TRUE_MSG_ASSERTION(test,                             =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/tests/drm_buddy_test.c:62:9: note: in expansion of macro 'K=
UNIT_ASSERT_TRUE_MSG'
   62 |         KUNIT_ASSERT_TRUE_MSG(test, drm_buddy_alloc_blocks(&mm, 0, =
mm_size,
      |         ^~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/tests/drm_buddy_test.c:65:64: note: format string is define=
d here
   65 |                                "buddy_alloc didn't error size=3D%u\=
n", 3 * ps);
      |                                                               ~^
      |                                                                |
      |                                                                unsi=
gned int
      |                                                               %lu
drivers/gpu/drm/tests/drm_buddy_test.c:71:32: error: format '%u' expects ar=
gument of type 'unsigned int', but argument 7 has type 'long unsigned int' =
[-Werror=3Dformat=3D]
   71 |                                "buddy_alloc didn't error size=3D%u\=
n", 3 * ps);
      |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
  ~~~~~~
      |                                                                    =
    |
      |                                                                    =
    long unsigned int
include/kunit/test.h:597:37: note: in definition of macro '_KUNIT_FAILED'
  597 |                                     fmt,                           =
            \
      |                                     ^~~
include/kunit/test.h:654:9: note: in expansion of macro 'KUNIT_UNARY_ASSERT=
ION'
  654 |         KUNIT_UNARY_ASSERTION(test,                                =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:1214:9: note: in expansion of macro 'KUNIT_TRUE_MSG_AS=
SERTION'
 1214 |         KUNIT_TRUE_MSG_ASSERTION(test,                             =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/tests/drm_buddy_test.c:68:9: note: in expansion of macro 'K=
UNIT_ASSERT_TRUE_MSG'
   68 |         KUNIT_ASSERT_TRUE_MSG(test, drm_buddy_alloc_blocks(&mm, 0, =
mm_size,
      |         ^~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/tests/drm_buddy_test.c:71:64: note: format string is define=
d here
   71 |                                "buddy_alloc didn't error size=3D%u\=
n", 3 * ps);
      |                                                               ~^
      |                                                                |
      |                                                                unsi=
gned int
      |                                                               %lu
drivers/gpu/drm/tests/drm_buddy_test.c:75:32: error: format '%u' expects ar=
gument of type 'unsigned int', but argument 7 has type 'long unsigned int' =
[-Werror=3Dformat=3D]
   75 |                                "buddy_alloc didn't error size=3D%u\=
n", 2 * ps);
      |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
  ~~~~~~
      |                                                                    =
    |
      |                                                                    =
    long unsigned int
include/kunit/test.h:597:37: note: in definition of macro '_KUNIT_FAILED'
  597 |                                     fmt,                           =
            \
      |                                     ^~~
include/kunit/test.h:654:9: note: in expansion of macro 'KUNIT_UNARY_ASSERT=
ION'
  654 |         KUNIT_UNARY_ASSERTION(test,                                =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:1214:9: note: in expansion of macro 'KUNIT_TRUE_MSG_AS=
SERTION'
 1214 |         KUNIT_TRUE_MSG_ASSERTION(test,                             =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/tests/drm_buddy_test.c:72:9: note: in expansion of macro 'K=
UNIT_ASSERT_TRUE_MSG'
   72 |         KUNIT_ASSERT_TRUE_MSG(test, drm_buddy_alloc_blocks(&mm, 0, =
mm_size,
      |         ^~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/tests/drm_buddy_test.c:75:64: note: format string is define=
d here
   75 |                                "buddy_alloc didn't error size=3D%u\=
n", 2 * ps);
      |                                                               ~^
      |                                                                |
      |                                                                unsi=
gned int
      |                                                               %lu
drivers/gpu/drm/tests/drm_buddy_test.c:81:32: error: format '%u' expects ar=
gument of type 'unsigned int', but argument 7 has type 'long unsigned int' =
[-Werror=3Dformat=3D]
   81 |                                "buddy_alloc didn't error size=3D%u\=
n", 3 * ps);
      |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
  ~~~~~~
      |                                                                    =
    |
      |                                                                    =
    long unsigned int
include/kunit/test.h:597:37: note: in definition of macro '_KUNIT_FAILED'
  597 |                                     fmt,                           =
            \
      |                                     ^~~
include/kunit/test.h:654:9: note: in expansion of macro 'KUNIT_UNARY_ASSERT=
ION'
  654 |         KUNIT_UNARY_ASSERTION(test,                                =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:1214:9: note: in expansion of macro 'KUNIT_TRUE_MSG_AS=
SERTION'
 1214 |         KUNIT_TRUE_MSG_ASSERTION(test,                             =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/tests/drm_buddy_test.c:78:9: note: in expansion of macro 'K=
UNIT_ASSERT_TRUE_MSG'
   78 |         KUNIT_ASSERT_TRUE_MSG(test, drm_buddy_alloc_blocks(&mm, 0, =
mm_size,
      |         ^~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/tests/drm_buddy_test.c:81:64: note: format string is define=
d here
   81 |                                "buddy_alloc didn't error size=3D%u\=
n", 3 * ps);
      |                                                               ~^
      |                                                                |
      |                                                                unsi=
gned int
      |                                                               %lu
drivers/gpu/drm/tests/drm_buddy_test.c:90:32: error: format '%u' expects ar=
gument of type 'unsigned int', but argument 7 has type 'long unsigned int' =
[-Werror=3Dformat=3D]
   90 |                                "buddy_alloc hit an error size=3D%u\=
n", 2 * ps);
      |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
  ~~~~~~
      |                                                                    =
    |
      |                                                                    =
    long unsigned int
include/kunit/test.h:597:37: note: in definition of macro '_KUNIT_FAILED'
  597 |                                     fmt,                           =
            \
      |                                     ^~~
include/kunit/test.h:662:9: note: in expansion of macro 'KUNIT_UNARY_ASSERT=
ION'
  662 |         KUNIT_UNARY_ASSERTION(test,                                =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:1233:9: note: in expansion of macro 'KUNIT_FALSE_MSG_A=
SSERTION'
 1233 |         KUNIT_FALSE_MSG_ASSERTION(test,                            =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/tests/drm_buddy_test.c:87:9: note: in expansion of macro 'K=
UNIT_ASSERT_FALSE_MSG'
   87 |         KUNIT_ASSERT_FALSE_MSG(test, drm_buddy_alloc_blocks(&mm, 0,=
 mm_size,
      |         ^~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/tests/drm_buddy_test.c:90:64: note: format string is define=
d here
   90 |                                "buddy_alloc hit an error size=3D%u\=
n", 2 * ps);
      |                                                               ~^
      |                                                                |
      |                                                                unsi=
gned int
      |                                                               %lu
drivers/gpu/drm/tests/drm_buddy_test.c:96:32: error: format '%u' expects ar=
gument of type 'unsigned int', but argument 7 has type 'long unsigned int' =
[-Werror=3Dformat=3D]
   96 |                                "buddy_alloc hit an error size=3D%u\=
n", 3 * ps);
      |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
  ~~~~~~
      |                                                                    =
    |
      |                                                                    =
    long unsigned int
include/kunit/test.h:597:37: note: in definition of macro '_KUNIT_FAILED'
  597 |                                     fmt,                           =
            \
      |                                     ^~~
include/kunit/test.h:662:9: note: in expansion of macro 'KUNIT_UNARY_ASSERT=
ION'
  662 |         KUNIT_UNARY_ASSERTION(test,                                =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:1233:9: note: in expansion of macro 'KUNIT_FALSE_MSG_A=
SSERTION'
 1233 |         KUNIT_FALSE_MSG_ASSERTION(test,                            =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/tests/drm_buddy_test.c:93:9: note: in expansion of macro 'K=
UNIT_ASSERT_FALSE_MSG'
   93 |         KUNIT_ASSERT_FALSE_MSG(test, drm_buddy_alloc_blocks(&mm, 0,=
 mm_size,
      |         ^~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/tests/drm_buddy_test.c:96:64: note: format string is define=
d here
   96 |                                "buddy_alloc hit an error size=3D%u\=
n", 3 * ps);
      |                                                               ~^
      |                                                                |
      |                                                                unsi=
gned int
      |                                                               %lu
In file included from drivers/gpu/drm/tests/drm_mm_test.c:8:
drivers/gpu/drm/tests/drm_mm_test.c: In function 'drm_test_mm_init':
drivers/gpu/drm/tests/drm_mm_test.c:160:34: error: zero-length gnu_printf f=
ormat string [-Werror=3Dformat-zero-length]
  160 |                 KUNIT_FAIL(test, "");
      |                                  ^~
include/kunit/test.h:597:37: note: in definition of macro '_KUNIT_FAILED'
  597 |                                     fmt,                           =
            \
      |                                     ^~~
include/kunit/test.h:625:9: note: in expansion of macro 'KUNIT_FAIL_ASSERTI=
ON'
  625 |         KUNIT_FAIL_ASSERTION(test,                                 =
            \
      |         ^~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/tests/drm_mm_test.c:160:17: note: in expansion of macro 'KU=
NIT_FAIL'
  160 |                 KUNIT_FAIL(test, "");
      |                 ^~~~~~~~~~
drivers/gpu/drm/tests/drm_mm_test.c:174:34: error: zero-length gnu_printf f=
ormat string [-Werror=3Dformat-zero-length]
  174 |                 KUNIT_FAIL(test, "");
      |                                  ^~
include/kunit/test.h:597:37: note: in definition of macro '_KUNIT_FAILED'
  597 |                                     fmt,                           =
            \
      |                                     ^~~
include/kunit/test.h:625:9: note: in expansion of macro 'KUNIT_FAIL_ASSERTI=
ON'
  625 |         KUNIT_FAIL_ASSERTION(test,                                 =
            \
      |         ^~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/tests/drm_mm_test.c:174:17: note: in expansion of macro 'KU=
NIT_FAIL'
  174 |                 KUNIT_FAIL(test, "");
      |                 ^~~~~~~~~~
drivers/gpu/drm/tests/drm_mm_test.c:181:34: error: zero-length gnu_printf f=
ormat string [-Werror=3Dformat-zero-length]
  181 |                 KUNIT_FAIL(test, "");
      |                                  ^~
include/kunit/test.h:597:37: note: in definition of macro '_KUNIT_FAILED'
  597 |                                     fmt,                           =
            \
      |                                     ^~~
include/kunit/test.h:625:9: note: in expansion of macro 'KUNIT_FAIL_ASSERTI=
ON'
  625 |         KUNIT_FAIL_ASSERTION(test,                                 =
            \
      |         ^~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/tests/drm_mm_test.c:181:17: note: in expansion of macro 'KU=
NIT_FAIL'
  181 |                 KUNIT_FAIL(test, "");
      |                 ^~~~~~~~~~

Caused by commit

  e00c5a9fa617 ("kunit: Annotate _MSG assertion variants with gnu printf sp=
ecifiers")

Please fix all the current problems before applying a patch to warn
about them.

I have used the kunit-next tree from next-20240227 for today.
--=20
Cheers,
Stephen Rothwell

--Sig_/oNsIlO=ukzVRl5gjkW5zm.5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXenvIACgkQAVBC80lX
0GxX5Af/Vfvis2//nsnk8VcrZIQuQIzuk8qlnEaP14huyU+3TXINbP5cxiBaGdrG
L5CUG6Gb65MQTQoa9xMnbZjOOLo1dL6ji8y/na3h90hppCuRlZb8qq+l98mRjwCW
4iAivdKaVZbXPzA6c61vYOfgYVQH76eogFb/7WeLJ0/RcVEV/HytW/XKek6EkvKU
GrwwlRTX+MKOurNXPfCChMd7XfrokciE1IripDX1+PD8GqABplnWryeP4d/24vGX
Dw3mN9IE0BBfyld9DmGcrObZArR5ed7oGi6hFM7UPeHXixNtJAhFtK12UYxD+Tor
gk0cVJKTh+pt8X2KQM0TblOsuED5Uw==
=PCh2
-----END PGP SIGNATURE-----

--Sig_/oNsIlO=ukzVRl5gjkW5zm.5--

