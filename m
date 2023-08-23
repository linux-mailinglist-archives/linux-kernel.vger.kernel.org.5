Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3DC78503C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 07:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjHWF4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 01:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjHWF4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 01:56:24 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2D1E47;
        Tue, 22 Aug 2023 22:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692770176;
        bh=s0jcs2PDwhapmAxUa71vGBcWcNRy8+N69eAS7sRXC6M=;
        h=Date:From:To:Cc:Subject:From;
        b=WGTzTZmGCiCNgOeyfzHdIIb528kVlHZYu5PdjL000BO/XV2Wv+c96Vivdtz20kD9m
         vWEIA8nuaTWOigdg0PuTVrNTLhFfJe9p5wZjBP0/tPA8aiehqXfN5QZvTDU+rcUiWu
         q6Vk/zlc+Awx6LMXDd4w67xstnqutzMh8MjxiecOxsd/z9aXv0j740KJz3YK/1dJA5
         Ur0VgZVbBEIreXPFneims38K/H/DR96OZv87rDxBJYAnkqsZ+9E32A0CCPMpguJP6P
         Ap2v87s6N9D3qunWmIOaDJ9B1+0mMvz/gfGaQ3kIXT/ZGC9T01GXGZcBGpO+RDojH7
         Zti9CtwERWCTw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RVwSc2zBvz4wxQ;
        Wed, 23 Aug 2023 15:56:16 +1000 (AEST)
Date:   Wed, 23 Aug 2023 15:56:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Helen Mae Koike Fornazier <helen.koike@collabora.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the drm-ci tree
Message-ID: <20230823155614.707c3d37@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RomWDYRS2LPo92GR64z7PoA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RomWDYRS2LPo92GR64z7PoA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-ci tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/gpu/automated_testing.rst:55: WARNING: Inline emphasis start-=
string without end-string.

Introduced by commit

  882a25ee2005 ("drm: Add initial ci/ subdirectory")

--=20
Cheers,
Stephen Rothwell

--Sig_/RomWDYRS2LPo92GR64z7PoA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTln34ACgkQAVBC80lX
0Gx7pggAk4iqtuwdyWiDauP4NGPFOv/rfWoqnW22N+uEiMmPlG2/syIV9aromcLA
tP1YVJkO3/WLN2ahmC2nTeguK/efN165MrO+e+PF3LDgUwpzZhezCAnSIuOGVXQM
YPV1l+m7kmem4Wav/ruDHwjnTs40TqbxWLGmda86U8g6O+Ev4uR7at6+5eyTlP1a
AoU2dMx9nbe9B4KmhftxSe8IbPjpO9m576FiA0UbbkZRaNCwujMkbTcfpt6e/O9Q
SvEPNylK9IbIrK1pRY34cOVOCOT/ldjqSIKMt04kvo3iXbvYvOtGnh9CK6YjvV29
0SAyOdqkwY4uAE53G/+gtXZytOKDfA==
=kNG9
-----END PGP SIGNATURE-----

--Sig_/RomWDYRS2LPo92GR64z7PoA--
