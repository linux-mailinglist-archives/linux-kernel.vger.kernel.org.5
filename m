Return-Path: <linux-kernel+bounces-118863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3EA88C06B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D7E299348
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1114738FB9;
	Tue, 26 Mar 2024 11:18:17 +0000 (UTC)
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1120.securemx.jp [210.130.202.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831D7819;
	Tue, 26 Mar 2024 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711451896; cv=none; b=qIVDTq3tO3rtOy+gGERpzQ+4zaaA0Fj7/qFLXDK68RyvGTiygwpI+tImPTPkl94lWhkTfCrSt1WkSsDQgE5iUIXK7oAmRSjygrUQcEkVu/uwzBYf3qNxd00vXiZdZ4SFDyo1YnDWrL0V+YDkF6O2HREoGinTRjaeHqiClEUWE0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711451896; c=relaxed/simple;
	bh=RXxVwB++RfdUZm7ZxVwICwWyDkmPGasgS6OIKXv04vw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NRLTKPR2MfDeelrxbz43qb5pPj8TppKcP08MnUTHaI/2gLFGe4aAt7kK5qPyodaULyzYhQ+KnzEZgMoALn/UwiWMuKWTAvHKEXm6/Wo5k9mk+DRJN1QMVtThUQGrIxTy2tL7PpG4KeQN2TvaLqLPweIhQyQ7yflrYkebig7O7ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com; spf=pass smtp.mailfrom=kioxia.com; arc=none smtp.client-ip=210.130.202.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kioxia.com
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1120) id 42QATs4b671700; Tue, 26 Mar 2024 19:29:54 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 42QATVpK2610903; Tue, 26 Mar 2024 19:29:31 +0900
X-Iguazu-Qid: 2rWglQcuMYmTG5ydZz
X-Iguazu-QSIG: v=2; s=0; t=1711448970; q=2rWglQcuMYmTG5ydZz; m=qMipVdnTgwUQK90bAw3dCRXuz+LfD9mEaB3kpyrVuPQ=
Received: from CNN1EMTA01.test.kioxia.com ([202.248.33.144])
	by relay.securemx.jp (mx-mr1121) id 42QATTe02222074
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 26 Mar 2024 19:29:30 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
	by CNN1EMTA01.test.kioxia.com (Postfix) with ESMTP id A16ED2F015;
	Tue, 26 Mar 2024 19:29:29 +0900 (JST)
Received: from CNN1ESTR04.kioxia.com (localhost [127.0.0.1])
	by Switcher-Post_Send (Postfix) with ESMTP id 697D01900001E2;
	Tue, 26 Mar 2024 19:17:03 +0900 (JST)
Received: from localhost [127.0.0.1] 
	 by CNN1ESTR04.kioxia.com with ESMTP id 0003VAAAAAA01M15;
	 Tue, 26 Mar 2024 19:17:03 +0900
Received: from CNN1EXMB03.r1.kioxia.com (CNN1EXMB03.r1.kioxia.com [10.232.20.152])
	by Switcher-Pre_Send (Postfix) with ESMTP id 5E55EA29B6838;
	Tue, 26 Mar 2024 19:17:03 +0900 (JST)
Received: from CNN1EXMB03.r1.kioxia.com (10.232.20.152) by
 CNN1EXMB03.r1.kioxia.com (10.232.20.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 19:29:28 +0900
Received: from CNN1EXMB03.r1.kioxia.com ([10.13.100.22]) by
 CNN1EXMB03.r1.kioxia.com ([10.13.100.22]) with mapi id 15.01.2507.035; Tue,
 26 Mar 2024 19:29:28 +0900
From: tada keisuke <keisuke1.tada@kioxia.com>
To: "song@kernel.org" <song@kernel.org>,
        "yukuai3@huawei.com"
	<yukuai3@huawei.com>
CC: "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 03/11] md: workaround for inconsistency of config state in
 takeover
Thread-Topic: [PATCH 03/11] md: workaround for inconsistency of config state
 in takeover
Thread-Index: Adp/ZBwVAi9WlQnMTJC02G7SaeeULA==
Date: Tue, 26 Mar 2024 10:29:28 +0000
Message-ID: <df3a5e85db254f2ab44b93734cac27bb@kioxia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: ISME-14.0.0.2080-9.0.1002-28274.000
x-tm-as-result: No-10--9.492700-8.000000
x-tmase-matchedrid: 13nEecSBt9GmagT1k9kBpgrcxrzwsv5uXPK9y3z82GtXGTbsQqHbkkog
	3hT9f/oCJ2spf+DCeJzmn3xyPJAJoh2P280ZiGmRupDIC9422DoWUg/hm489yO+sdQufriAS4aS
	bGEJzu4sESV4es7KJNx8GSwQM8TG4+qIQ7qDJ9P+AwosDBeuPwZki3iIBA3o/rhnpK05RvESFFj
	ccLWe/lssDZ/QWaNswKDX7UR/i5drv4tNJ1H3OMBJo06V2lHTeBGvINcfHqhe52DlOQbIerXeYf
	bSrjau6JciLWd+sUhmbKItl61J/yZkw8KdMzN86KrauXd3MZDWkkQPcJHKMTx+KTZxSwIuuqgWO
	R64FI8BOK/uOxPTRF+tu2l1+ba2/A2TBCP7SkgN+3BndfXUhXQ==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--9.492700-8.000000
x-tmase-version: ISME-14.0.0.2080-9.0.1002-28274.000
x-tm-snts-smtp: BED65E495F77F5F10E61A2D081FCFEEEED0BF200A2CBF3F097802F4240FA06132000:8
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CrossPremisesHeadersFilteredBySendConnector: CNN1EXMB03.r1.kioxia.com
X-OrganizationHeadersPreserved: CNN1EXMB03.r1.kioxia.com

This patch depends on patch 01.

An inconsistency occurs between config state in takeover and percpu_ref sta=
te.
Differentiate percpu_ref state setting for takeover and other to avoid the =
inconsistency.
Therefore, add percpu_ref state setting to match config state in takeover.

Signed-off-by: Keisuke TADA <keisuke1.tada@kioxia.com>
Signed-off-by: Toshifumi OHTAKE <toshifumi.ootake@kioxia.com>
---
 drivers/md/raid5.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 118dfed9695f..c7186ebcd299 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7405,7 +7405,8 @@ static unsigned long raid5_cache_count(struct shrinke=
r *shrink,
 	return max_stripes - min_stripes;
 }
=20
-static struct r5conf *setup_conf(struct mddev *mddev)
+
+static struct r5conf *setup_conf(struct mddev *mddev, bool quiesce)
 {
 	struct r5conf *conf;
 	int raid_disk, memory, max_disks;
@@ -7416,6 +7417,7 @@ static struct r5conf *setup_conf(struct mddev *mddev)
 	int group_cnt;
 	struct r5worker_group *new_group;
 	int ret =3D -ENOMEM;
+	unsigned int percpu_ref_init_flags;
=20
 	if (mddev->new_level !=3D 5
 	    && mddev->new_level !=3D 4
@@ -7486,6 +7488,10 @@ static struct r5conf *setup_conf(struct mddev *mddev=
)
 	init_llist_head(&conf->released_stripes);
 	atomic_set(&conf->active_stripes, 0);
 	atomic_set(&conf->preread_active_stripes, 0);
+	if (quiesce)
+		percpu_ref_init_flags =3D PERCPU_REF_ALLOW_REINIT | PERCPU_REF_INIT_DEAD=
;
+	else
+		percpu_ref_init_flags =3D PERCPU_REF_ALLOW_REINIT;
 	atomic_set(&conf->active_aligned_reads, 0);
 	spin_lock_init(&conf->pending_bios_lock);
 	conf->batch_bio_dispatch =3D true;
@@ -7666,6 +7672,23 @@ static struct r5conf *setup_conf(struct mddev *mddev=
)
 	return ERR_PTR(ret);
 }
=20
+static struct r5conf *setup_conf_for_run(struct mddev *mddev)
+{
+	return setup_conf(mddev, false);
+}
+
+static struct r5conf *setup_conf_for_takeover(struct mddev *mddev)
+{
+	struct r5conf *conf;
+	bool quiesce =3D false;
+
+	if (mddev->level =3D=3D 4 || mddev->level =3D=3D 5 || mddev->level =3D=3D=
 6) {
+		conf =3D mddev->private;
+		quiesce =3D false;
+	}
+	return setup_conf(mddev, quiesce);
+}
+
 static int only_parity(int raid_disk, int algo, int raid_disks, int max_de=
graded)
 {
 	switch (algo) {
@@ -7893,7 +7916,7 @@ static int raid5_run(struct mddev *mddev)
 	}
=20
 	if (mddev->private =3D=3D NULL)
-		conf =3D setup_conf(mddev);
+		conf =3D setup_conf_for_run(mddev);
 	else
 		conf =3D mddev->private;
=20
@@ -8661,7 +8684,7 @@ static void *raid45_takeover_raid0(struct mddev *mdde=
v, int level)
 	/* make sure it will be not marked as dirty */
 	mddev->recovery_cp =3D MaxSector;
=20
-	return setup_conf(mddev);
+	return setup_conf_for_takeover(mddev);
 }
=20
 static void *raid5_takeover_raid1(struct mddev *mddev)
@@ -8689,7 +8712,7 @@ static void *raid5_takeover_raid1(struct mddev *mddev=
)
 	mddev->new_layout =3D ALGORITHM_LEFT_SYMMETRIC;
 	mddev->new_chunk_sectors =3D chunksect;
=20
-	ret =3D setup_conf(mddev);
+	ret =3D setup_conf_for_takeover(mddev);
 	if (!IS_ERR(ret))
 		mddev_clear_unsupported_flags(mddev,
 			UNSUPPORTED_MDDEV_FLAGS);
@@ -8726,7 +8749,7 @@ static void *raid5_takeover_raid6(struct mddev *mddev=
)
 	mddev->new_layout =3D new_layout;
 	mddev->delta_disks =3D -1;
 	mddev->raid_disks -=3D 1;
-	return setup_conf(mddev);
+	return setup_conf_for_takeover(mddev);
 }
=20
 static int raid5_check_reshape(struct mddev *mddev)
@@ -8804,7 +8827,7 @@ static void *raid5_takeover(struct mddev *mddev)
 	if (mddev->level =3D=3D 4) {
 		mddev->new_layout =3D ALGORITHM_PARITY_N;
 		mddev->new_level =3D 5;
-		return setup_conf(mddev);
+		return setup_conf_for_takeover(mddev);
 	}
 	if (mddev->level =3D=3D 6)
 		return raid5_takeover_raid6(mddev);
@@ -8824,7 +8847,7 @@ static void *raid4_takeover(struct mddev *mddev)
 	    mddev->layout =3D=3D ALGORITHM_PARITY_N) {
 		mddev->new_layout =3D 0;
 		mddev->new_level =3D 4;
-		return setup_conf(mddev);
+		return setup_conf_for_takeover(mddev);
 	}
 	return ERR_PTR(-EINVAL);
 }
@@ -8874,7 +8897,7 @@ static void *raid6_takeover(struct mddev *mddev)
 	mddev->new_layout =3D new_layout;
 	mddev->delta_disks =3D 1;
 	mddev->raid_disks +=3D 1;
-	return setup_conf(mddev);
+	return setup_conf_for_takeover(mddev);
 }
=20
 static int raid5_change_consistency_policy(struct mddev *mddev, const char=
 *buf)
--=20
2.34.1


