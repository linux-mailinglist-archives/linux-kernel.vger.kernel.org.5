Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254C17F9587
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 22:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjKZVcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 16:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjKZVcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 16:32:22 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7296CE8;
        Sun, 26 Nov 2023 13:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701034344;
        bh=m4c3MMaM5Jb7y6O4jt1oh7KB9TXWPcvGPoYTaAvC0B8=;
        h=Date:From:To:Cc:Subject:From;
        b=SzyGJoTLFpWl6ZtOWy5XSVpRhF0kxQbLmQCcOwunKR4x48vZDuCHejxKAk/ihRGDb
         ieFkZTlUSEOuTIM+Z4NHeZCxMIrHXEjFXPYcAra5ltQoY15e6b70CmL4ivOHnCSkqW
         tBrVpFSmYaG21ujFXIVHNKQZrW57Ry2E8BtnZfPH29yZ+8DSUvMXjAze+TB7VvEPwb
         w0WD0meVuy3z3BiQoFPpzNkTokCwitPgWyKD5tX6Ra54EfhKRhiz7jXmyNKUOW23C3
         KOB4JZTtpsb28HIk0BUVz/Qw4uh2ssZXb6rRV27H91gELqHq2f1RfiUrNhVk6ZUS5w
         lJJVaJ8b3Gftg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sdhkv0QBJz4wc8;
        Mon, 27 Nov 2023 08:32:22 +1100 (AEDT)
Date:   Mon, 27 Nov 2023 08:32:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Liu Ying <victor.liu@nxp.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm-misc-fixes tree
Message-ID: <20231127083205.44b25fa8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hIMrf_P/ckwsQ.=GozpjKyq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hIMrf_P/ckwsQ.=GozpjKyq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc-fixes tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: modpost: "device_is_dependent" [drivers/gpu/drm/drm_kms_helper.ko] u=
ndefined!

Caused by commit

  39d5b6a64ace ("drm/bridge: panel: Check device dependency before managing=
 device link")

I have used the drm-misc-fixes tree from next-20231124 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/hIMrf_P/ckwsQ.=GozpjKyq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVjuVUACgkQAVBC80lX
0GyZ8Qf/QyUqgY9MYX9H3CKy5c82Isrenp7R03/3/+WZDEg0qyGKST7nbmdXMuqo
gYIS9KqTd7NDY/S/D+cBHq/7ih8U1cwPLZwDPONhWMkGTuGAYKb2lHAORvVG34f8
v2IFY0337RvARAO+tg2sRZSCS9y0xZRAls6sx9q3zeT0MIMw3tn/z46aZrSCxta4
rIZhRvNXby0/zG2IIUt3CaD8keFjJAP7foNVyXWMpqjc9BCO5VfS8eRvgyEzARVR
6BCTWs0P7oMsBxTyGd/Q0PVZqm0lhOuVNuaW9fSAfpSI8W3cH1/2Amt+23XyXycg
4Q5kCiernY7N5w4NSh+mx+RlwJXHPg==
=y/AT
-----END PGP SIGNATURE-----

--Sig_/hIMrf_P/ckwsQ.=GozpjKyq--
