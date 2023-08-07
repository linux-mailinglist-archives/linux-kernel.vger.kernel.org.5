Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D467717CF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 03:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjHGB2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 21:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHGB2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 21:28:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCD810E2;
        Sun,  6 Aug 2023 18:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1691371716;
        bh=9EOU9Lr1L/yLncGxZ2eseBzA+sEBN/Cq/jOgQHKB73U=;
        h=Date:From:To:Cc:Subject:From;
        b=czAMJREYCFB3ynUo407xErJS4H9iT0ZMkT6ky/Ou2CSrOmCRX5B4SeL6i4dR4JN+5
         suJoft7xOVpCBX2uB5zPlpzgBjfATgVx1iC0inHjzlogEU+wAiXWV1rln1f2lOnS1G
         LLHPKn0NUb3pZ9bFuG5RTvkz5VxaZoJaGlHiLrJLQ7OYyLkEVD2QLGWNV4jpUky/4I
         1KDV0F1D5pLNM559R+0tLpRPUe/1n8wM+WZzL/KdDeyf8H79C1pNCxPIPLVUbflF0p
         j1hvxUYIg8RdY9EA0TOTjlsohlbHOsPjKT2Pvki6RlsyWXyoQZHg/pr6C83GgEP+wX
         srD6fcIbRABTw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RJzH80wxMz4wy5;
        Mon,  7 Aug 2023 11:28:35 +1000 (AEST)
Date:   Mon, 7 Aug 2023 11:28:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Danilo Krummrich <dakr@redhat.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the drm-misc tree
Message-ID: <20230807112833.18c27533@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vXP_Tmv8IxGXgCoJ65F7EE1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vXP_Tmv8IxGXgCoJ65F7EE1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

In file included from drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.h:4,
                 from drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.h:5,
                 from drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c:22:
drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c: In function 'nvkm_uvmm_mthd=
_raw_map':
drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c:422:31: warning: cast to poi=
nter from integer of different size [-Wint-to-pointer-cast]
  422 |                               (void *)args->argv, args->argc);
      |                               ^
drivers/gpu/drm/nouveau/include/nvkm/core/memory.h:66:43: note: in definiti=
on of macro 'nvkm_memory_map'
   66 |         (p)->func->map((p),(o),(vm),(va),(av),(ac))
      |                                           ^~

Introduced by commit

  6b252cf42281 ("drm/nouveau: nvkm/vmm: implement raw ops to manage uvmm")

--=20
Cheers,
Stephen Rothwell

--Sig_/vXP_Tmv8IxGXgCoJ65F7EE1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTQSMIACgkQAVBC80lX
0GyuRwf8CLC4YuxQWPn+FtMx6gDDPL0s5OLlTE9sTygM9Ke4RR9uSZOg4+Zjpa8H
/D28couYVXEsMmJcCRD263gxpCEWVmwN5uf5/hQBu+jFlB5QQzKRApPIhER+Cpuv
HAxp9PUfdLKgxF6ZKw8GEW2SEfa2su0EcUWkZ4JqDCT1T6V+Hpye5DNCNYTxsHjD
B5eDSRBhGOT6sjFo1KpbZnw4A5LgqSPd65OnZxHlNZbBYhReT5gdOw5WALfzEfOs
sj4x8ixxEJYMBPZ/Asouo9xoyOc5qRPHAqA+1Drzc64gs1IJnj0LxJaWY1vBn9T3
d+0Y7z52aaXUNHj6Zdw7HJHCQGY31w==
=U/Y0
-----END PGP SIGNATURE-----

--Sig_/vXP_Tmv8IxGXgCoJ65F7EE1--
