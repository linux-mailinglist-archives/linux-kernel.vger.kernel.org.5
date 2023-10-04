Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2967B773B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 06:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241163AbjJDEqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 00:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjJDEqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 00:46:14 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E33AD;
        Tue,  3 Oct 2023 21:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696394768;
        bh=cFaj5Bc5AFjxB0/1LnCLFLbRkGT3ogIkiKD3IpaEukw=;
        h=Date:From:To:Cc:Subject:From;
        b=EBkPw8jIWRisFm4lAi6ZXtuJGdK2ZJO592OHb9b11+DAMsOT/AEYfCIvvz2jq69jf
         p/D6f9XkwkCjfp3bbEyP9hM++dBAszc7aGa0frhkAAIWcyVL9pkV11E3SysAnZ9apm
         2GV9jWSDi41vZEz7VDBQzpDEZWhYUpBuf1vlJIwaYo+eqOBJsGbMh/tv9o5Pe6UumW
         1IN5f8qKLF04AqdNTolW/rgmyXt/iRow7aX4vULzJTvb8PPZh681V/Fh4mU00NtNx9
         LSO/5+YbaUyLokPXoNkXMZj9pt6xRSaU+2wdc9970x4epSlKm9FZntSTU3HaePGy30
         me0jaSye1TRxA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S0hwJ21z0z4xG0;
        Wed,  4 Oct 2023 15:46:08 +1100 (AEDT)
Date:   Wed, 4 Oct 2023 15:46:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mm tree
Message-ID: <20231004154605.240e409b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yrCjYMCTk4jl4LToaq7j8q=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yrCjYMCTk4jl4LToaq7j8q=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (htmldocs) produced
this warning:

mm/rmap.c:1140: warning: Function parameter or member 'folio' not described=
 in 'folio_move_anon_rmap'
mm/rmap.c:1140: warning: Excess function parameter 'page' description in 'f=
olio_move_anon_rmap'

Introduced by commit

  35c5f94a6269 ("mm/rmap: convert page_move_anon_rmap() to folio_move_anon_=
rmap()")

--=20
Cheers,
Stephen Rothwell

--Sig_/yrCjYMCTk4jl4LToaq7j8q=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUc7g4ACgkQAVBC80lX
0GyCKwf/bWElX3nUKnQHpZA+KQgEI44/YA+J4thASXZbPAn/l1NDbsEUFJZEQKWc
cRwFfA7k22yWKWngV602pNioYAnU2+v/JC7lNcfHw7c3/JikNpKMAppaPGasQqD7
rP6Yirm70bbSXkx8aovbhr4m1ntqwOtV6xn86cCgARftp6ZPhOvzwQWdM1g72zIV
6UL8WxuLMHsMDidE3fmRnKMAcxccV1OEOmzfYoHW4SLy1Gcqe5OU+th1cTlNFFaM
AXS/pmsL8UMEs16C6KU0d1dNkJRo8wsPSofawbdhKd3f/CL9CHJjZuAFy4bXA2JL
RX43hcfeZ5mNAT8Sj9DLRXLMWkf+7Q==
=e+Fb
-----END PGP SIGNATURE-----

--Sig_/yrCjYMCTk4jl4LToaq7j8q=--
