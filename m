Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B1F75A507
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 06:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjGTEQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 00:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGTEQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 00:16:20 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B1E172A;
        Wed, 19 Jul 2023 21:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689826576;
        bh=vQu5/LUOeP+25OJGN4Hx/Qv5s4HbEcDpwb9jzTjaGhY=;
        h=Date:From:To:Cc:Subject:From;
        b=Q/9prB7vcQGAnW8XiYCQl4SzN4xOd/Y3GHnzveskj42nkNV7hCNH0fmVAmgMWgTB6
         yOSveBLTP9e/kR1Yu8j5y+/y33l8wLgpzCNNsK0E23mpreWRY+wY4uwB38Y+LASiYF
         J/e77Mvzfg+FVmLxXBP4kjX+HxrIrIP5yzzcIAgixBGWvao+QBZRk8i4SAQVQra7/f
         wGfnZn0y27ujsZY1K60i8Gc22N0KNFsKr3o0H/nIa44QJMusqYDChQlHeu8U/bEoMj
         6wRCgYXCLp5TpzJz5zTOUtJZL+Onk0lcT9p7ios2SemHEweq9wT/Vp9dRluGbYSIKu
         x5Z8q2zBBE73w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R5zrv61Zqz4wqW;
        Thu, 20 Jul 2023 14:16:15 +1000 (AEST)
Date:   Thu, 20 Jul 2023 14:16:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the net-next tree
Message-ID: <20230720141613.61488b9e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IXyzaoArFY=brprErVUCnaI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IXyzaoArFY=brprErVUCnaI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (htmldocs)
produced this warning:

include/linux/netdevice.h:2415: warning: Function parameter or member 'xdp_=
zc_max_segs' not described in 'net_device'

Introduced by commit

  13ce2daa259a ("xsk: add new netlink attribute dedicated for ZC max frags")

--=20
Cheers,
Stephen Rothwell

--Sig_/IXyzaoArFY=brprErVUCnaI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS4tQ0ACgkQAVBC80lX
0GxFWQgAiLB7gitEM5GlErUQOnpSVBHqhHbjRhaFngInRmym8UIhHxuaas1r17gv
THHG/wX+GoJVu1c/xYeJ/s6trsKTShTqZce23BUo3rAgQ64am+uxKzqGdTt8/ZEn
Fn7WrkbaZdMn9T+bdC7/ownNrmw1jgG2M9Rp2HM68n0SdZm181HiDssrKom0fQcq
BEmfpotAYhs6KoPVt3G59X/dgTxSx1jRH7MwynaldrTYFEXQ4fh5p1uytVb3wRPA
pdJEJNTcQhiRCUrQKuc+7QasODxYlZDGmKKiHhuaH5ptwtmjBWwapO6uRj3jCiVm
zSVK/2KLyqtbGDFGfT7aZ9qxkIajEQ==
=zf69
-----END PGP SIGNATURE-----

--Sig_/IXyzaoArFY=brprErVUCnaI--
