Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB5580BEA7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 02:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjLKA7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 19:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjLKA7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 19:59:49 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BE4EB;
        Sun, 10 Dec 2023 16:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1702256391;
        bh=shDzPGsI1oIYMZnAXANSyf2zj/GNqcqt9dxPVu+6vRk=;
        h=Date:From:To:Cc:Subject:From;
        b=Rgtw5RzQ0tWCPeWHxsPUDmYp32Ud4cAKry/Vtf2OGs6nZXlAKK2c2wJP33uPXy6fX
         J7rHzagQrQeMqQBSJEWHCvsLWg0Z6O0DHoxNXeyWUYCM5elY9YQBkr2o8WhEvvYJYT
         gp0XJEtu+92xdC8LMlihJKb4nszcMu7YRzyIuZEQ5ccICv09HcTgwRIz8x8DN/unCQ
         qv4aavLCjwycCn9ClVEjNkO38RNzQ9rsLjH2m/H69Nh6o56n6Qbc6O6ebnbO/bNeoA
         voovJTFsp4gjYsC4eeH4k8ifqoARojmorsYteauI9Y4oyTWUgIoXs6BBoyfUH0SyNf
         XuwtXh+87o6pQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SpNgp6ymYz4wdD;
        Mon, 11 Dec 2023 11:59:50 +1100 (AEDT)
Date:   Mon, 11 Dec 2023 11:59:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <seanpaul@chromium.org>,
        Dave Airlie <airlied@redhat.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm-msm tree
Message-ID: <20231211115950.3918d572@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/D.DO5vP1SYbCYe/YR4_jk2s";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/D.DO5vP1SYbCYe/YR4_jk2s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-msm tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c: In function 'amdgpu_seq64_map':
drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c:64:9: error: too few arguments to=
 function 'drm_exec_init'
   64 |         drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
      |         ^~~~~~~~~~~~~
In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c:28:
include/drm/drm_exec.h:138:6: note: declared here
  138 | void drm_exec_init(struct drm_exec *exec, uint32_t flags, unsigned =
nr);
      |      ^~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c: In function 'amdgpu_seq64_unmap':
drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c:125:9: error: too few arguments t=
o function 'drm_exec_init'
  125 |         drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
      |         ^~~~~~~~~~~~~
include/drm/drm_exec.h:138:6: note: declared here
  138 | void drm_exec_init(struct drm_exec *exec, uint32_t flags, unsigned =
nr);
      |      ^~~~~~~~~~~~~

Caused by commit

  05d249352f1a ("drm/exec: Pass in initial # of objects")

interating with commit

  c8031019dc95 ("drm/amdgpu: Implement a new 64bit sequence memory driver")

from the drm tree.

I have applied this merge resolution patch for today;

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 11 Dec 2023 11:53:17 +1100
Subject: [PATCH] fix up for "drm/exec: Pass in initial # of objects"

interacting with
"drm/amdgpu: Implement a new 64bit sequence memory driver"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_seq64.c
index f3de02193138..7a6a67275404 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
@@ -61,7 +61,7 @@ int amdgpu_seq64_map(struct amdgpu_device *adev, struct a=
mdgpu_vm *vm,
 	if (!bo)
 		return -EINVAL;
=20
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
 	drm_exec_until_all_locked(&exec) {
 		r =3D amdgpu_vm_lock_pd(vm, &exec, 0);
 		if (likely(!r))
@@ -122,7 +122,7 @@ void amdgpu_seq64_unmap(struct amdgpu_device *adev, str=
uct amdgpu_fpriv *fpriv)
=20
 	vm =3D &fpriv->vm;
=20
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
 	drm_exec_until_all_locked(&exec) {
 		r =3D amdgpu_vm_lock_pd(vm, &exec, 0);
 		if (likely(!r))
--=20
2.40.1

--=20
Cheers,
Stephen Rothwell

--Sig_/D.DO5vP1SYbCYe/YR4_jk2s
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV2XwYACgkQAVBC80lX
0Gz8ywgAny8DYR8SFjTyjQEElkjqApzSTwQQpBg8OVMI5PUnPpdrdG2uzf9Rk+xF
KppdRoLeF3pMTFzzsQ43nvcZynzQ+92bu4kV2tzP/cIOqLevDAdC+bGqORa9d7T8
No5/VVoPXKrU6MvlSwtYAlvPQpCaneAOCW+PwiEv3krVECgNzJZvEiDnykOHXCoD
DlEkn67Q28JQyvogx7pvIlGwLKqqDgUoBXd/r1kcgD5m96vpgiNtDbHCvL+w8fhO
/i/le0KZ8LNDfNr+glcNXKSyiZ1jYoOzSNNyo98dLU5dm4Ors6HODqsdrM0d80D9
kiVJe0/AG5fJvNcPRCZkV/8gTkSCGg==
=w7iH
-----END PGP SIGNATURE-----

--Sig_/D.DO5vP1SYbCYe/YR4_jk2s--
