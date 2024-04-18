Return-Path: <linux-kernel+bounces-149536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8B58A928F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C23D1F2163E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5B058129;
	Thu, 18 Apr 2024 05:44:34 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw1120.securemx.jp [210.130.202.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CFE2207A;
	Thu, 18 Apr 2024 05:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713419073; cv=none; b=GrwG7kOXHJcfdtX8LzSXzOcuzzK+S99aBk6tnDEig3mB+Qaubfvf5MvYZ5XgZLhOsmOs8+gtFu5jP/oLoGh6TzeKSQ5WU/C7GjnSQNFudN3yGRymOSdzJQa667rUhuMmYuZF89KNRWFfiM7COlPnY75GZiWD2FBJh3MTilC58Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713419073; c=relaxed/simple;
	bh=QaN/FwwxLxgD/eNrmiHrOkKp2TdxHm9YHgRtIBHbloc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LrwgwOrcix7KrNPlAds8B3l3BcuydTV8hJKDnqfzO6OJXXQeBfdAyz/9+u8npQ7KjpKiIPuzboOAVZJAmyvxbInEqM4+NlXZbSlRWJEQoSqG2YPLSkO/0M4rA/kc8jhRLE7aX55smLT9gwBb1mUi2tzopYJspX1fM+3z+RniK2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com; spf=pass smtp.mailfrom=kioxia.com; arc=none smtp.client-ip=210.130.202.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kioxia.com
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 43I5iP131975285; Thu, 18 Apr 2024 14:44:25 +0900
X-Iguazu-Qid: 2rWhyQ027DO2N9iLK4
X-Iguazu-QSIG: v=2; s=0; t=1713419065; q=2rWhyQ027DO2N9iLK4; m=Mt2wR6H6xjw2q0sCmoQEI6I6joL35fOEulPFNL/GHnM=
Received: from CNN1EMTA02.test.kioxia.com ([202.248.33.144])
	by relay.securemx.jp (mx-mr1123) id 43I5iOGF2720705
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 18 Apr 2024 14:44:24 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
	by CNN1EMTA02.test.kioxia.com (Postfix) with ESMTP id 7DD7E2F02C;
	Thu, 18 Apr 2024 14:44:24 +0900 (JST)
Received: from CNN1ESTR03.kioxia.com (localhost [127.0.0.1])
	by Switcher-Post_Send (Postfix) with ESMTP id 5E6C71947AEC50;
	Thu, 18 Apr 2024 14:22:26 +0900 (JST)
Received: from localhost [127.0.0.1] 
	 by CNN1ESTR03.kioxia.com with ESMTP id 0002QAAAAAA01G6B;
	 Thu, 18 Apr 2024 14:22:26 +0900
Received: from CNN1EXMB04.r1.kioxia.com (CNN1EXMB04.r1.kioxia.com [10.232.20.153])
	by Switcher-Pre_Send (Postfix) with ESMTP id 53248AA28483C;
	Thu, 18 Apr 2024 14:22:26 +0900 (JST)
Received: from CNN1EXMB04.r1.kioxia.com (10.232.20.153) by
 CNN1EXMB04.r1.kioxia.com (10.232.20.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 14:44:23 +0900
Received: from CNN1EXMB04.r1.kioxia.com ([10.13.100.23]) by
 CNN1EXMB04.r1.kioxia.com ([10.13.100.23]) with mapi id 15.01.2507.035; Thu,
 18 Apr 2024 14:44:23 +0900
From: tada keisuke <keisuke1.tada@kioxia.com>
To: "song@kernel.org" <song@kernel.org>,
        "yukuai3@huawei.com"
	<yukuai3@huawei.com>
CC: "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 09/11] md: add atomic mode switching when removing disk
Thread-Topic: [PATCH v2 09/11] md: add atomic mode switching when removing
 disk
Thread-Index: AdqLx+cUYgqWX3MjQN2rrEDmXmwOEg==
Date: Thu, 18 Apr 2024 05:44:23 +0000
Message-ID: <415ab1a1454a44129e997d51822ed533@kioxia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: ISME-14.0.0.2080-9.0.1002-28328.001
x-tm-as-result: No-10--8.269100-8.000000
x-tmase-matchedrid: SD3TfnVbAUqmagT1k9kBppTQgFTHgkhZKQNhMboqZlrGZbX3v50Wrzos
	Lf1kH5Cf9KYkbDev+bE52p2V9wXr31gyUUCO8mz8gnMtC97jHVTBOVz0Jwcxl6vCrG0TnfVUg9x
	e4gtUJtop7xmDsiWI7eSkRJ+6d2nBY+Xr17aLI9mWsmW9lDx463Fd5+Cf9M1DywYoiKCn+q+jxY
	yRBa/qJUl4W8WVUOR/joczmuoPCq10cYT4S+XRd6bHdlf3vR79QLl5NGHbunXMUg19c6LynGCQd
	ykTnIAa
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--8.269100-8.000000
x-tmase-version: ISME-14.0.0.2080-9.0.1002-28328.001
x-tm-snts-smtp: 74E5A45F46303C720AC2985D8927258BC727B23F1A5A878ACCE478F47854666A2000:8
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CrossPremisesHeadersFilteredBySendConnector: CNN1EXMB04.r1.kioxia.com
X-OrganizationHeadersPreserved: CNN1EXMB04.r1.kioxia.com

This patch depends on patch 08.

To minimize the number of execution of atomic mode switching, not only addi=
ng atomic mode switching, but also remove judgment is divided into two stag=
es.
Latency is minimized because only rdev to be removed is switched to atomic =
mode, not all rdevs.

Signed-off-by: Keisuke TADA <keisuke1.tada@kioxia.com>
Signed-off-by: Toshifumi OHTAKE <toshifumi.ootake@kioxia.com>
---
 drivers/md/md.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 7e6966e65d0d..5f785353353d 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9291,8 +9291,11 @@ static bool rdev_removeable(struct md_rdev *rdev)
 		return false;
=20
 	/* Fautly rdev is not used, it's safe to remove it. */
-	if (test_bit(Faulty, &rdev->flags))
-		return true;
+	if (nr_pending_is_percpu_mode(rdev) && test_bit(Faulty, &rdev->flags)) {
+		percpu_ref_switch_to_atomic_sync(&rdev->nr_pending);
+		if (nr_pending_is_zero(rdev))
+			return true;
+	}
=20
 	/* Journal disk can only be removed if it's faulty. */
 	if (test_bit(Journal, &rdev->flags))
@@ -9346,6 +9349,11 @@ static bool md_spares_need_change(struct mddev *mdde=
v)
 {
 	struct md_rdev *rdev;
=20
+	rdev_for_each_rcu(rdev, mddev) {
+		if (test_bit(Faulty, &rdev->flags))
+			percpu_ref_switch_to_atomic_sync(&rdev->nr_pending);
+	}
+
 	rcu_read_lock();
 	rdev_for_each_rcu(rdev, mddev) {
 		if (rdev_removeable(rdev) || rdev_addable(rdev)) {
--=20
2.34.1



