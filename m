Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1894F780144
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355840AbjHQWsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355943AbjHQWsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:48:01 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5AB30C2;
        Thu, 17 Aug 2023 15:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692312469;
        bh=R9VZ7FAV5X5XmzIEdFxfsmmp5vvPCpFZptzo4lfKgq8=;
        h=Date:From:To:Cc:Subject:From;
        b=AfGXUh3zyfF7jT2O+wBStHjBgYtI8AnsdwKdho/Lssg/h92gvhEKwVj5qgdKGDtmx
         FuemGqgjoLY/IHOnnIEx2vxSpkRC3IK/NBIrNnnZK/qZe3FgH7cUZGgTAgQUyI3JzK
         HB1xOUtNItn5AK2H/iGA1bSC8xcXU/WjEYPuFh185rPKf52DIQo2Qf05sNLaWVsqIR
         N49Mq79ePEBbZqbr1nyv0pdDapUqWUG3bN/THcplz9i+hRGXZa8w98nBiM788I9RHX
         2WyzJj24ZTi0ulhk+4w70hkjxYTS530Xgh6qMQd70vcLLgJHZ3AUk9w5ac0gXj3OXU
         MsJZOxAKmgy1Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RRgBY1mtMz4wxm;
        Fri, 18 Aug 2023 08:47:49 +1000 (AEST)
Date:   Fri, 18 Aug 2023 08:47:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the perf tree
Message-ID: <20230818084736.6e5fd7c4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vpQghSVsM7ysmLBmjZyZ9Zb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vpQghSVsM7ysmLBmjZyZ9Zb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  1ce24329a46e ("perf trace: Use the augmented_raw_syscall BPF skel only fo=
r tracing syscalls")

Fixes tag

  Fixes: 42963c8bedeb864b ("perf trace: Migrate BPF augmentation to use a s=
keleton")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 5e6da6be3082 ("perf trace: Migrate BPF augmentation to use a skeleto=
n")

--=20
Cheers,
Stephen Rothwell

--Sig_/vpQghSVsM7ysmLBmjZyZ9Zb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTeo4gACgkQAVBC80lX
0GwNogf8DslHhBLyHDKGgtCnga0LJUPJqrtNlACP1NGkE82cGEsik4+SVbiYTlY3
dF6ibLBbnJxC0Q6h4ktKvojn49L+wSLzUsDRSSQzPlxA+Fkmnkv2OaI0RerqLKRg
jvZJvnFzZ/D5Ypmr+sfSM3FFB1mpdlYOdcvbhR3e2zZz30pzAbRK7L2sCAJRwolg
tW+4Z6eQWC9oUm9YgBa+Nor4bWIcut5yQnLnbMIdbyv3aYhMsBcHV6NR6ogCreIY
j1o2Wv7QmKMje7rsEgHJeKTrBK9P8HBlhpi3R0t9xjuuv1wtOQ+iHGedHnDnmsui
vpHpyaB+DWBcRplEJyntwaPQyBvfEw==
=sDPl
-----END PGP SIGNATURE-----

--Sig_/vpQghSVsM7ysmLBmjZyZ9Zb--
