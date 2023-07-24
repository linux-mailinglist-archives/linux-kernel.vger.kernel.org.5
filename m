Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E39F75E631
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjGXBP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjGXBPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:15:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B80E6D;
        Sun, 23 Jul 2023 18:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690161281;
        bh=HktgO5vl0G8C9YUbjPBosi8STA1pHpsO3kbIOf94AMA=;
        h=Date:From:To:Cc:Subject:From;
        b=Gb7iizTfYzIsg+YV8piLq5lx3+Aj0JWfU5wPWsm5f6QafFEEIV2TwusDe1FZ7nl9r
         dGlRvRFMdfLcdCyL0TCCtiqL4ir3z4NUHFV0+xLlSnldDQxRMobRGLK3q9ebNyIiqz
         bEIX08yvklTOBE91zRmq0+LO/zn2txkNu2Z2CoDtzXJ/6yLhalNc/BllMNPWBK6/7w
         ji/uDSqnYkT3yvD5T+8Wwp/4sw/rymm/9xSw0RgsOyC1lRov1gTFD72DQP+UH/P3uh
         R0+ws3EFp+tSGtDr59Ni/O5A4T17Pg69oYwkpO9dKC9HoPwA0JLbstGmApOP2ctLEC
         I6tE7FqjjtSPA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R8MdY1Plyz4wyZ;
        Mon, 24 Jul 2023 11:14:41 +1000 (AEST)
Date:   Mon, 24 Jul 2023 11:14:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: linux-next: manual merge of the amdgpu tree with Linus' tree
Message-ID: <20230724111439.572dc274@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sH0=iM1FqtxAIdANAVmW=Ms";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sH0=iM1FqtxAIdANAVmW=Ms
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the amdgpu tree got a conflict in:

  drivers/gpu/drm/amd/amdgpu/atom.c

between commit:

  992b8fe106ab ("drm/radeon: Replace all non-returning strlcpy with strscpy=
")

from Linus' tree and commit:

  adf64e214280 ("drm/amd: Avoid reading the VBIOS part number twice")

from the amdgpu tree.

I fixed it up (the latter removed the line updates by the former, so I
just used the latter) and can carry the fix as necessary. This is now
fixed as far as linux-next is concerned, but any non trivial conflicts
should be mentioned to your upstream maintainer when your tree is
submitted for merging.  You may also want to consider cooperating with
the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/sH0=iM1FqtxAIdANAVmW=Ms
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS90H8ACgkQAVBC80lX
0GxM1wf/XLdl4hKitJtv2dj6XaBUCAGjV3XA3nimtUShbdu6EUsci2mCIBVIPmiJ
pGViVk11DRbVp9ozTv9KRaukjWODu3CBfyQAzqDtK/9CBv1LXuwMAVirAznkaJ+s
qHEbqUUYdlbm0Vmz3dLe73ZVhD8efsZqlroLC7EXPGNUPBEoSu0BXhr6qF9lVxeS
vkVl+v39J9YSk6jA2+T0uuv1nPKDAsN7GLZ+6O48/+oXoL7OFN8N3jui0TyAzJqe
lDeXfjIBRH4J+lR7OAHKBc45sVfE7kBO7yuFz0mAkUs9c1N+m1zJ+pq4N0tBwjBH
qww2btwR7mgoKSV5qwLGEyIWT+Gsvg==
=qYcI
-----END PGP SIGNATURE-----

--Sig_/sH0=iM1FqtxAIdANAVmW=Ms--
