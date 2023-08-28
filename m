Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE5478A506
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 06:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjH1E6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 00:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjH1E5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 00:57:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE55126;
        Sun, 27 Aug 2023 21:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1693198659;
        bh=xzcWS4xbblnmzh9BDVKUzSrvAXiDh/Jq9s6eq1yg0UY=;
        h=Date:From:To:Cc:Subject:From;
        b=nuMsWYrUxBnhCPViwrnCnaXSMnXqmJbgWWuES9pgjFSNhFeDRd5quj9eCyZBbUw46
         V9E3GveRbwrYPeEhph09GIYQGpQtwOFP6ihmBHvbOfRrjuPq3hLcj7QhDfpEVmCVKR
         HD/FZgUFyAA09Xxc32XrCMEcFFCDN0IB1S2yb+CmmJ1JY3Nx2JnjTO5n7QBodT4K3/
         m1rFR36b3zBBVAj8kEcmeD3Q2NOiN0Qg4GhEOQ97Hl47aw1YrSDdJL+2s9m0IdTWnJ
         icLG73zIbt5it0+PZun2yh1yZGELAVkCUM8sy1H3FLwz6mEwVIEzHTf8E2IRG/mQGP
         zE+ItVYizXZYA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RYywf6YqBz4wb2;
        Mon, 28 Aug 2023 14:57:38 +1000 (AEST)
Date:   Mon, 28 Aug 2023 14:57:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the kbuild tree
Message-ID: <20230828145737.6ff53bc9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/afJSlTj1Wktr/9qqg4Pfn_H";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/afJSlTj1Wktr/9qqg4Pfn_H
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kbuild tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/kbuild/llvm.rst:127: ERROR: Unknown target name: "reprocible_=
builds".

Introduced by commit

  bda09c0e14a4 ("Documentation/llvm: refresh docs")

--=20
Cheers,
Stephen Rothwell

--Sig_/afJSlTj1Wktr/9qqg4Pfn_H
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTsKUEACgkQAVBC80lX
0GwlkAgAiotMmZ8OLo5NSL3nYkLbHrOayLu/3FDc6j/kvXgb/PiluQEmSPID64uB
hB7VzuV5bmL2o3g79dgsoYPCXi0A095DC9jP9PCKebqtrt+Sc81Pi92ULGdlsdT3
NxrbCKlhNWRMDJh9T1Dm1UrJGbAAiThnHQRb1d1fZkjWQPP2fLsOMj4fIqZyoezb
eJtQHKwUmtW+VPC+Rjx/drFBKqbqrIPTWom4nZL+qw72CVYozxcXo9w0CwxaXtJh
kvOIOsjObNR8iu+B+fsdjJEsbbAPahmStCLU+PeOEDD1IjJ5E8O7Lt+jdWSWnrSZ
765Br4Y7kabm1GOdNMlrhC2JvtE/Nw==
=sszU
-----END PGP SIGNATURE-----

--Sig_/afJSlTj1Wktr/9qqg4Pfn_H--
