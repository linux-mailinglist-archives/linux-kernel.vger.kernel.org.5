Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0087EA78A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 01:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjKNAhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 19:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjKNAhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 19:37:00 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4FED53;
        Mon, 13 Nov 2023 16:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1699922215;
        bh=U/j0SYvk3GviJyacvFPrMyZQgCXuN+SoJpI8XVVDb6I=;
        h=Date:From:To:Cc:Subject:From;
        b=BdUv7MQjeIP9/d8mll3mWAtnAoh/UX2HhBlHdcxrx3fpZmpr0HddDzwKKc3FxOAY+
         ik3SpZZqeA+OS83T4YU4O9L4jCIvijAvJewdTcGs/AAC9OHEb7tfgiNptQof+p8kke
         cqvJFtSR/hxMvo+txjjNmqFjvjyVjO55GzjwWr9yYG9f6P0/TpLA1rxJ9+7+haYLlU
         s0xukJHju+xq+yjddrtPTCZ40HXhN/6a0GrJCdlcsIQ9PuM1Ef7TBURVKoWNi7raoj
         yxFEuCE7hgn+wRLn+5qcjqKd4DNovGgKlEEEd4yaHAG9BuecdupQtmORjoFVlOaBms
         CVXlvN30FLoEA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4STnRq42VMz4xNH;
        Tue, 14 Nov 2023 11:36:55 +1100 (AEDT)
Date:   Tue, 14 Nov 2023 11:36:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: linux-next: manual merge of the drm-misc tree with Linus' tree
Message-ID: <20231114113654.3bd7f0ee@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XHi3bVwgPviu_TrdtL3I=pP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XHi3bVwgPviu_TrdtL3I=pP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc tree got a conflict in:

  drivers/accel/ivpu/ivpu_job.c

between commit:

  6309727ef271 ("kthread: add kthread_stop_put")

from Linus' tree and commit:

  57c7e3e4800a ("accel/ivpu: Stop job_done_thread on suspend")

from the drm-misc tree.

I fixed it up (I just used the latter version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/XHi3bVwgPviu_TrdtL3I=pP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVSwSYACgkQAVBC80lX
0Gw+Nwf/evrsIdeTi1bCKKyBiKp8YtGSHng4DUjF1yWVmESZ+dwkUG1hG8kyrog5
5KhFcClTqb8SuWvwiPqJHQZiEaHsa2XE5YaLgbtV/1BwsB90U0oaDSZQcEXmpWYj
X28qgdTTrkqdQgd38LcKEokH23yANL0D/H1bTkv3Y1jZ8D8NKqkeBFpIDbCLRvAf
AyJpV+cuDW77XRgCu/VK7mwEvctEnsEFr8C4wUfCJ2lMuEoSxWdHGgM/lvfpn9pK
adKL7ab/OH0fwSWGGVSuNn1QWEUVZW3thfUdV/Rj5knECDwvEexG7aQsU8jPxc1J
JyyGrtk72M6P9OxNqf/8s7krottU+Q==
=m5+T
-----END PGP SIGNATURE-----

--Sig_/XHi3bVwgPviu_TrdtL3I=pP--
