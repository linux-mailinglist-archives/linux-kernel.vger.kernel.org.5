Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E36F7BF1F4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 06:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442013AbjJJEeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 00:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376523AbjJJEeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 00:34:03 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10559F;
        Mon,  9 Oct 2023 21:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696912439;
        bh=b4dmO715+PkY75cuPttmUofJoX043FDKuWoDSSEaTis=;
        h=Date:From:To:Cc:Subject:From;
        b=pud/NdiLgAzVm/W96EGueq7lbhqtPJHL2/eE2fgengt7kUXMIR1Eovy+aIyWMUfl3
         nfAD6iWR+BeyUmQOlzjiL6jzXtbHxxTNMIq/uM8rM4wwLaapXkjhTXYSm4bwJV5Dhn
         75Wn+TZtdj8fDjGzbFI4Q9GT6wi5/vxhypXNJZ3MZ6uGo1816rx10x1x64IA+S69Rb
         +Ydj1j+2GqlY3a9bCUnHHqavWrgxAxqxHraLEe8vYfpjIQd7YGG4iLgc4e7rOgOZ6U
         g9s/S36K4lll9ADrv+aYkQbhB/G/nOyvFoXyv6LkAlyG4YRoPzVucPlwUx5nRTLGV/
         wRssDtFohqjdA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S4NMS34xlz4xMC;
        Tue, 10 Oct 2023 15:33:56 +1100 (AEDT)
Date:   Tue, 10 Oct 2023 15:33:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shuah Khan <skhan@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>,
        Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas@t-8ch.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the nolibc tree
Message-ID: <20231010153354.2357ee1c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fLdljhEBZ4LW/Yu/a3VVNac";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fLdljhEBZ4LW/Yu/a3VVNac
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the rcu tree as different commits
(but the same patches):

  1b831eb43176 ("tools/nolibc: string: Remove the `_nolibc_memcpy_down()` f=
unction")
  3a7296c94dfa ("tools/nolibc: x86-64: Use `rep stosb` for `memset()`")
  3f79a57865b3 ("selftests/nolibc: libc-test: avoid -Wstringop-overflow war=
nings")
  9e9dcee894f8 ("selftests/nolibc: use -nostdinc for nolibc-test")
  a04fd4052251 ("tools/nolibc: add stdarg.h header")
  ab663cc32912 ("tools/nolibc: automatically detect necessity to use pselec=
t6")
  bd216cb8d814 ("tools/nolibc: don't define new syscall number")
  c6a15707d1c3 ("tools/nolibc: string: Remove the `_nolibc_memcpy_up()` fun=
ction")
  d09e2b033a9f ("tools/nolibc: avoid unused parameter warnings for ENOSYS f=
allbacks")
  d7f2a69857ce ("MAINTAINERS: nolibc: update tree location")
  dbb6448b4263 ("selftests/nolibc: allow building i386 with multiarch compi=
ler")
  e6401064e32b ("tools/nolibc: x86-64: Use `rep movsb` for `memcpy()` and `=
memmove()`")

--=20
Cheers,
Stephen Rothwell

--Sig_/fLdljhEBZ4LW/Yu/a3VVNac
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUk1DMACgkQAVBC80lX
0GxT8Qf/dFIcGfKYxHGeJDx4KTS4Dw+2toLuNxxwA7OfRnBGMaH1Tzn6cr8iLWGr
JsVyYrQamnfrbVPmWDixYaO5Bz7zOOKbVNkCj5nL0ZBmivgwThEu7YOOVbehE9V2
IKPVkrXNzx5d8cm9/cqFHziyDOWvDat8/FU+SThHKPd7uQZpvQ9O5kAKFxUY42Ir
z9FggyjjQbRaS4wvuzKUdx+iIdTkg7s0wDmhTJ0uAEN8fBu/IrHEqUCt5CorHySj
djIX6hiMPvhxsesgoBensxwfdLdCmVwz9iM8Y/YaA1I+OXR6UbSjY/2gOWEVQV1n
QcmlcMDZnRSj+xCr27EzfkQSAy4wEw==
=/LsU
-----END PGP SIGNATURE-----

--Sig_/fLdljhEBZ4LW/Yu/a3VVNac--
