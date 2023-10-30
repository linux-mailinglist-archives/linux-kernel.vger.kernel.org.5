Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773497DB1B8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 01:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjJ3Al2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 20:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjJ3Al1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 20:41:27 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987D1BA;
        Sun, 29 Oct 2023 17:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698626478;
        bh=2mj7Ue7X3VdITU33JDSyvBykKjLDrwy/E5N1CXz8Sno=;
        h=Date:From:To:Cc:Subject:From;
        b=BZd0zSC8wdSfJCnFQ8xTMnzI1pMLF2VUw2cP4K+Q7YE5n6Mude2d09V3/6s4j8XhC
         LoU9lyXW9WYAUDAuXvzJWb6/WE6nq7TNhJ8ADVPJLlKe41PwEmA78/DU9esl9VafzE
         ttYb3TzGJ+ucYIeKTLksSUDVimgIBccg7AZp2mSIr1m6QGN2gfjqGOxcs/61wlG1Cj
         4uMjBgV5gfVdSk0/7qE5CXgAPUjegWRVZZi/GGGt7YzOZZtfAgBMvWe9iduexTtOHd
         O97SFQX46G1azgwOP4Mu6cCvYUfi8yeDSTm3nasY/x6l+zQwh/MdBheI+SKQnDUIzd
         6L4dTsaHu0UzA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SJZFp1QQ0z4wdF;
        Mon, 30 Oct 2023 11:41:18 +1100 (AEDT)
Date:   Mon, 30 Oct 2023 11:41:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Chancel Liu <chancel.liu@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: linux-next: manual merge of the sound tree with the
 sound-asoc-fixes tree
Message-ID: <20231030114115.2a9f0260@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YTcNVtsuLsAfrlM/dTk9jrF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YTcNVtsuLsAfrlM/dTk9jrF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the sound tree got a conflict in:

  sound/soc/soc-pcm.c

between commit:

  f0220575e65a ("ASoC: soc-dai: add flag to mute and unmute stream during t=
rigger")

from the sound-asoc-fixes tree and commit:

  3efcb471f871 ("ASoC: soc-pcm.c: Make sure DAI parameters cleared if the D=
AI becomes inactive")

from the sound tree.

I fixed it up (I just used the latter) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/YTcNVtsuLsAfrlM/dTk9jrF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU++6sACgkQAVBC80lX
0GzexQf/XDnUjeGEtQ8E1cL0tGs6pJdgaxJ+0BYY0/zSRZm3BsDvXZCpCWzelXCc
uEtJ8ChFt0aAzzvUyIvyqffUQyw/o9hMV/DUP8KMNeM7fEzpbc3d1zIANngCDeNM
9DusmEc0fSDn4pR8TUyHb54b4wdj/ivCW+llatxYGcFzUbtQlYwKtWkuRv/vmq2y
VucivRBUdq+fjYil6wxHhJ3iI7D/5vg4XF4Do4M4R84vgcUSmK6sgOHbW9crhkOS
CG41uO+h+/2+O0X2YqXkFBVjjg8anz6qNmHQf+PvGc3cgu712R8GzBSvaQ+m+RGH
mQ1kYKkqzPjJoRy4eX5AqvmLYCNDZg==
=Ucar
-----END PGP SIGNATURE-----

--Sig_/YTcNVtsuLsAfrlM/dTk9jrF--
