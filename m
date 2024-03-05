Return-Path: <linux-kernel+bounces-91630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 000AC87146B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB5C283C73
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAD538FB9;
	Tue,  5 Mar 2024 03:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Td3JBYSJ"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E182127441;
	Tue,  5 Mar 2024 03:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709610628; cv=none; b=OjTSi6LV8Fp2KYxTw+A2OTMufciwLFjtbNoKZIeShAOvsX/5pEQKWsvLAGj0bZfE0ib/qAv8kmnVtbvGpVsPDyDpAFODaruzKIUi39Hm2DH4GSk3ABhwY9OZqQHpGVxVlPMFkvfQBhqV16upPDX6KqfD0X/FZOGotFnhxoYLrzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709610628; c=relaxed/simple;
	bh=f99pSG9e3jGKgzOIrVAMv4aCJ2h7KN2dHvQZyf+Ow8M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=R0H9zsC3FFh7B9q6RsPS9l+gviX8lZwK1ZiEC3DOShJtHA6a5hAxXYd5WZPqa8/XROKVfh1ZpgpFbLDdb+8i9CxdQVg8L0TpQBptBzzOWOIUOccJlo9Vi/RjfoiFQygX6+Ba0nK913pqeWTkLCVhV/5kUdfmkn5nIWp1QhLdUoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Td3JBYSJ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709610620;
	bh=p5nq/vS4hepQGj6OkRNK6qaC4A03OnfOu2ZWVKhR0ys=;
	h=Date:From:To:Cc:Subject:From;
	b=Td3JBYSJaW7qtzCCxrGfh85E93TfzUi6hQQ3s9JjrX0BJ8J06vUMPuCjKwKOLZ1el
	 VZBzIG4r9zKvyUDVYpmbYVB80x3EPdpwu5qKKn4pwSaV7zFUbe5jz/cfOWx/zOMJMv
	 LJtSaeNjVTPDIL6VP7TALETdg35t0D/fR9LghpXt5Q4ZvuswlUqltruW2k2jt1wWiz
	 melwH0WtGpiHHEisi0hyhjveOmxl7tyvYIv2XiDvf/punW6+0BJF6IeR/8wFBMoDph
	 NFF24+hgMDdH6aURxDWK57rmJeKZ2wMUqpQJ3IhyVThBT9E4P2CSdzK3Eqe1prt1qW
	 RXgHhYmXDNfTA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TphRJ15vrz4wbQ;
	Tue,  5 Mar 2024 14:50:20 +1100 (AEDT)
Date: Tue, 5 Mar 2024 14:50:18 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kees Cook <keescook@chromium.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the kspp tree
Message-ID: <20240305145018.39b4e37b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CBOPn6795ITC_4s+x5t90QX";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/CBOPn6795ITC_4s+x5t90QX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kspp tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from lib/string_kunit.c:8:
lib/string_kunit.c: In function 'test_strspn':
lib/string_kunit.c:176:25: error: format '%d' expects argument of type 'int=
', but argument 7 has type 'size_t' {aka 'long unsigned int'} [-Werror=3Dfo=
rmat=3D]
  176 |                         "i:%d", i);
      |                         ^~~~~~  ~
      |                                 |
      |                                 size_t {aka long unsigned int}
include/kunit/test.h:597:37: note: in definition of macro '_KUNIT_FAILED'
  597 |                                     fmt,                           =
            \
      |                                     ^~~
include/kunit/test.h:722:9: note: in expansion of macro 'KUNIT_BASE_BINARY_=
ASSERTION'
  722 |         KUNIT_BASE_BINARY_ASSERTION(test,                          =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:1253:9: note: in expansion of macro 'KUNIT_BINARY_INT_=
ASSERTION'
 1253 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
lib/string_kunit.c:175:17: note: in expansion of macro 'KUNIT_ASSERT_EQ_MSG'
  175 |                 KUNIT_ASSERT_EQ_MSG(test, s->a, strspn(s->str, s->a=
ccept),
      |                 ^~~~~~~~~~~~~~~~~~~
lib/string_kunit.c:176:29: note: format string is defined here
  176 |                         "i:%d", i);
      |                            ~^
      |                             |
      |                             int
      |                            %ld
lib/string_kunit.c:178:25: error: format '%d' expects argument of type 'int=
', but argument 7 has type 'size_t' {aka 'long unsigned int'} [-Werror=3Dfo=
rmat=3D]
  178 |                         "i:%d", i);
      |                         ^~~~~~  ~
      |                                 |
      |                                 size_t {aka long unsigned int}
include/kunit/test.h:597:37: note: in definition of macro '_KUNIT_FAILED'
  597 |                                     fmt,                           =
            \
      |                                     ^~~
include/kunit/test.h:722:9: note: in expansion of macro 'KUNIT_BASE_BINARY_=
ASSERTION'
  722 |         KUNIT_BASE_BINARY_ASSERTION(test,                          =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:1253:9: note: in expansion of macro 'KUNIT_BINARY_INT_=
ASSERTION'
 1253 |         KUNIT_BINARY_INT_ASSERTION(test,                           =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
lib/string_kunit.c:177:17: note: in expansion of macro 'KUNIT_ASSERT_EQ_MSG'
  177 |                 KUNIT_ASSERT_EQ_MSG(test, s->r, strcspn(s->str, s->=
reject),
      |                 ^~~~~~~~~~~~~~~~~~~
lib/string_kunit.c:178:29: note: format string is defined here
  178 |                         "i:%d", i);
      |                            ~^
      |                             |
      |                             int
      |                            %ld
cc1: all warnings being treated as errors

Caused by commit

  578914ebade8 ("string: Convert selftest to KUnit")

I have used the kspp tree from next-20240304 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/CBOPn6795ITC_4s+x5t90QX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXmlnoACgkQAVBC80lX
0GwkpwgAi2r4Y6+e6S8lbyZjW+etIihrOL0m3+c8Iu7o+kVfWKjCSSYhEZDoPWAf
LPY3wXFWU31JJeRB5OQp738DtKoagyaIO/Mai7nC/FlaI56S1iop7HrXDbkUVFuU
HhAlL4qgCPQpPtSdA1sRi/7xGwEh+WZSL2A56cUlARjYfCIo9d+hAC0RgYjMH18J
Dv4wjl0+dUW6Dz5Gi/9p07nFQm/KQbYJvldeLXLErVnXmru64pwAgHvnBHhIlunr
OOg6A8PwKjMhzkaIB+pUAb08ICxsyqL3UiNcL87BCIgZKQCcTsC/WeEx70fkzn9N
WM1gTWYGGcMxDmifkh62wMZzJMSJMw==
=C3fS
-----END PGP SIGNATURE-----

--Sig_/CBOPn6795ITC_4s+x5t90QX--

