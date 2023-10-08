Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A817BD03D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 23:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjJHVWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 17:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjJHVWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 17:22:03 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330329D;
        Sun,  8 Oct 2023 14:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696800113;
        bh=NIPp7qa77EEcjTVDJ+U30nCovPstS57FpHksGRlizt0=;
        h=Date:From:To:Cc:Subject:From;
        b=NxZdKa4PuFUSYKsl+vbRxNaj8/YKuD4C9w17YhwqPGGSGE/rh6zxEx9xkLnHKCNHL
         3aY659djBQWoPsGShTIDON5nUumJklxFhqMdsLxcyVS2xD2q4YAVYSzJKDJwFz0Y4a
         S9dUWjuHfBI0fmzOiup+OlxrTebWOx8OrvNs4rlCwMav4/xOIQe0pF8YziuIRmKiRO
         3S6tenRCnBljm+i1tmOvwqVGPYEP4cF1YmCZye1j1fmFVnXQ+gdf7jpH42tYUF1FLq
         7zKbeZC7opOmQ1vkkNfuts1b/HjFcFLJ7wfoQEdmStK+fvzT6I+kBJqiFTCmxMRiYu
         gBmZm1eZWbCAA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S3ZqP1LLYz4x5K;
        Mon,  9 Oct 2023 08:21:53 +1100 (AEDT)
Date:   Mon, 9 Oct 2023 08:21:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Wang Jianjian <wangjianjian0@foxmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the ext4 tree
Message-ID: <20231009082151.70a630a2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LirgHqgOfDIsIyfuLba7E40";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LirgHqgOfDIsIyfuLba7E40
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  ebf6cb7c6e12 ("ext4: no need to generate from free list in mballoc")

Fixes tag

  Fixes: 7a2fcbf7f85('ext4: don't use blocks freed but not yet committed in=
 buddy cache init')

has these problem(s):

  - missing space between the SHA1 and the subject
  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/LirgHqgOfDIsIyfuLba7E40
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUjHW8ACgkQAVBC80lX
0GwXwgf/aw1U5tNKtPjfpvdqozLgodvYTSjPjqdgeL5J1gbGTHIKEZf3Tk12qU4M
NxKDxDIND8vI8/DQ9eP8oLpXD7C/8beH5zxngrj9WzNvFSudC0qv82qpRsnEVzID
3kDGbHSA88J0o11i2z858hJPajjcZ0q6kc4CxjJiAqAiWYGW3DLkKIpjeEDcXAbk
agy+p7lru9mtniDI+FKgscF3vDtuOkw/uG0aEhB5o9rAM3hMXrnlYdyDC+QDV8Mu
1rYewqUGjN8/GYwHum1BEB6WYWlEbhBoXYTA1XwhysHL2bLgRbO5j4J6Vn8eUHfZ
3g6A785sCKhhmh4nW47X9aTgJPYEjA==
=g7j8
-----END PGP SIGNATURE-----

--Sig_/LirgHqgOfDIsIyfuLba7E40--
