Return-Path: <linux-kernel+bounces-149538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 763318A9293
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323B52833F3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A0971B3D;
	Thu, 18 Apr 2024 05:44:43 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw1122.securemx.jp [210.130.202.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E749354BFA;
	Thu, 18 Apr 2024 05:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713419083; cv=none; b=UQkKXpzfblWgX3SJMEeIpmKf0Bi45xAnbA3amllIn+SbcXJcylfio5Tz/Q1LKlrhMI/tKdkWjq+13vU9KIXK4nIUgpXEoX7YKrq4AptsdV0nI0MzFBrGW/U7R5Vfe5O7alvEA1PqddFvkLL4A16r/SJqUp++pgfQY3+v4ctIwm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713419083; c=relaxed/simple;
	bh=5AKQlpoYM0KfuVMzu8IcfAJeK3YnU7fhWnIQ1LwmVZc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OE0pbmYtrKOD0JN+4YdeVgxz3P6IlHHD5NANpAJWX9ds+kfC0onk6PjdI4hT0IK2HzSMOjFMAvtrpoNukm+m2RgMF08R/+2Kd6wkhhHIlfLlODjean8b9JswbxJu6BKTUaSnT1A25Qk5TuEoDjKoX6ek7lyyMlrzN7spwhp4W2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com; spf=pass smtp.mailfrom=kioxia.com; arc=none smtp.client-ip=210.130.202.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kioxia.com
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 43I5iVL12466845; Thu, 18 Apr 2024 14:44:31 +0900
X-Iguazu-Qid: 2rWhYYPQE6cvIqaCBK
X-Iguazu-QSIG: v=2; s=0; t=1713419070; q=2rWhYYPQE6cvIqaCBK; m=+A0GV4v/o1qCmYQ2W8uT41Kerdyf0z7RdGhIMFF3p7c=
Received: from CNN1EMTA03.test.kioxia.com ([202.248.33.144])
	by relay.securemx.jp (mx-mr1122) id 43I5iUsF2852846
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 18 Apr 2024 14:44:30 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
	by CNN1EMTA03.test.kioxia.com (Postfix) with ESMTP id 451602FE0F;
	Thu, 18 Apr 2024 14:44:30 +0900 (JST)
Received: from CNN1ESTR03.kioxia.com (localhost [127.0.0.1])
	by Switcher-Post_Send (Postfix) with ESMTP id 1C49B1947AEC50;
	Thu, 18 Apr 2024 14:22:32 +0900 (JST)
Received: from localhost [127.0.0.1] 
	 by CNN1ESTR03.kioxia.com with ESMTP id 0002QAAAAAA01G8B;
	 Thu, 18 Apr 2024 14:22:32 +0900
Received: from CNN1EXMB01.r1.kioxia.com (CNN1EXMB01.r1.kioxia.com [10.232.20.150])
	by Switcher-Pre_Send (Postfix) with ESMTP id 10C7AAA28483C;
	Thu, 18 Apr 2024 14:22:32 +0900 (JST)
Received: from CNN1EXMB04.r1.kioxia.com (10.232.20.153) by
 CNN1EXMB01.r1.kioxia.com (10.232.20.150) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 14:44:29 +0900
Received: from CNN1EXMB04.r1.kioxia.com ([10.13.100.23]) by
 CNN1EXMB04.r1.kioxia.com ([10.13.100.23]) with mapi id 15.01.2507.035; Thu,
 18 Apr 2024 14:44:29 +0900
From: tada keisuke <keisuke1.tada@kioxia.com>
To: "song@kernel.org" <song@kernel.org>,
        "yukuai3@huawei.com"
	<yukuai3@huawei.com>
CC: "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 11/11] md: avoid conflicts in nr_pending operations
Thread-Topic: [PATCH v2 11/11] md: avoid conflicts in nr_pending operations
Thread-Index: AdqLx+onlYFlF64nSFSWBn9s8h2iIA==
Date: Thu, 18 Apr 2024 05:44:29 +0000
Message-ID: <03f55e87cd7e4fae9fad86bc70d1870e@kioxia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: ISME-14.0.0.2080-9.0.1002-28328.001
x-tm-as-result: No-10--9.404500-8.000000
x-tmase-matchedrid: y9IfzGOMTk+magT1k9kBpgrcxrzwsv5uXPK9y3z82GsPdZmyx8xAa4Ul
	JlxlTIT+tPwtczFrCbS12HagvbwDji/7QU2czuUNA9lly13c/gFezmeoa8MJ86G5P8xDq4BXoK5
	B6+qXU7BvF9oQ/B54yN5WE7eMYlPKhrD3pNcSx1aqFx2c/3V5cbs5i+al07BJUrMN6XtW1EtvXF
	TtvgJmGhSu3n/oQBOZmsmH6sEd2eHyAV/ow31xqxMxKDqgAFSzuoYFb0nRiqNULhp+W/a9mWCGk
	K2P98wo585VzGMOFzDYh0PvnvUH8AtuKBGekqUpI/NGWt0UYPCcSjlacIPfpspOLsvV7od/l+l1
	5K/AK/bhBM8s3vZTUcLAQYGtsIDO
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--9.404500-8.000000
x-tmase-version: ISME-14.0.0.2080-9.0.1002-28328.001
x-tm-snts-smtp: F1F6EA9BC13B9D1ADCD72C40C43E9525B480FF568C2E6CD717CDD52AAD9A60472000:8
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CrossPremisesHeadersFilteredBySendConnector: CNN1EXMB01.r1.kioxia.com
X-OrganizationHeadersPreserved: CNN1EXMB01.r1.kioxia.com

This patch depends on patch 10.

Change nr_pending from atomic mode to percpu mode.

Signed-off-by: Keisuke TADA <keisuke1.tada@kioxia.com>
Signed-off-by: Toshifumi OHTAKE <toshifumi.ootake@kioxia.com>
---
 drivers/md/md.c     | 5 +++--
 drivers/md/raid1.c  | 6 ++++++
 drivers/md/raid10.c | 6 ++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 18d0f214098b..4928d63209cb 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3746,7 +3746,6 @@ int md_rdev_init(struct md_rdev *rdev)
 	ret =3D percpu_ref_init(&rdev->nr_pending, percpu_wakeup_handle_req_pendi=
ng,
 		PERCPU_REF_ALLOW_REINIT, GFP_KERNEL);
 	WARN_ON(ret);
-	percpu_ref_switch_to_atomic_sync(&rdev->nr_pending);
 	nr_pending_dec(rdev);
 	atomic_set(&rdev->read_errors, 0);
 	atomic_set(&rdev->corrected_errors, 0);
@@ -9280,7 +9279,7 @@ static bool rdev_removeable(struct md_rdev *rdev)
 		return false;
=20
 	/* There are still inflight io, don't remove this rdev. */
-	if (nr_pending_is_not_zero(rdev))
+	if (nr_pending_is_atomic_mode(rdev) && nr_pending_is_not_zero(rdev))
 		return false;
=20
 	/*
@@ -9384,6 +9383,8 @@ static int remove_and_add_spares(struct mddev *mddev,
 			rdev->raid_disk =3D -1;
 			removed++;
 		}
+		if (mddev->pers->level !=3D 1 && mddev->pers->level !=3D 10)
+			percpu_ref_switch_to_percpu(&rdev->nr_pending);
 	}
=20
 	if (removed && mddev->kobj.sd)
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index c38ae13aadab..13fcb80e1cb0 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2006,6 +2006,7 @@ static int raid1_remove_disk(struct mddev *mddev, str=
uct md_rdev *rdev)
 			conf->mirrors[conf->raid_disks + number].rdev =3D NULL;
 			unfreeze_array(conf);
 		}
+		percpu_ref_switch_to_percpu(&rdev->nr_pending);
=20
 		clear_bit(WantReplacement, &rdev->flags);
 		err =3D md_integrity_register(mddev);
@@ -3298,6 +3299,11 @@ static int raid1_run(struct mddev *mddev)
 static void raid1_free(struct mddev *mddev, void *priv)
 {
 	struct r1conf *conf =3D priv;
+	struct md_rdev *rdev;
+
+	rdev_for_each(rdev, mddev) {
+		percpu_ref_switch_to_percpu(&rdev->nr_pending);
+	}
=20
 	mempool_exit(&conf->r1bio_pool);
 	kfree(conf->mirrors);
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 66896a1076e1..f8ea5ec22629 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2180,6 +2180,7 @@ static int raid10_remove_disk(struct mddev *mddev, st=
ruct md_rdev *rdev)
 		clear_bit(Replacement, &p->replacement->flags);
 		WRITE_ONCE(p->replacement, NULL);
 	}
+	percpu_ref_switch_to_percpu(&rdev->nr_pending);
=20
 	clear_bit(WantReplacement, &rdev->flags);
 	err =3D md_integrity_register(mddev);
@@ -4168,6 +4169,11 @@ static int raid10_run(struct mddev *mddev)
=20
 static void raid10_free(struct mddev *mddev, void *priv)
 {
+	struct md_rdev *rdev;
+
+	rdev_for_each(rdev, mddev) {
+		percpu_ref_switch_to_percpu(&rdev->nr_pending);
+	}
 	raid10_free_conf(priv);
 }
=20
--=20
2.34.1



