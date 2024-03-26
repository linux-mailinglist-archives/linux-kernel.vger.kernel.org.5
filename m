Return-Path: <linux-kernel+bounces-118801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D7D88BF89
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EFBD2E3CF4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D59E81ABA;
	Tue, 26 Mar 2024 10:30:02 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw1121.securemx.jp [210.130.202.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5F080C18;
	Tue, 26 Mar 2024 10:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711449001; cv=none; b=tzcqo+H9cn34+JTYz79kqihT6EuIHAU9XBiQTewnlOxwZNWpwFiBOiMdJwPliAXlczRNE7F1kIfFYIN3fAR+zMshptsjPM4+Ob76eE8285NmreLnXgIeUQkkv0nTzpTgFiKkCNNmY/8tPd8mBR4QjewDuaB/pnRxlk7QLGspkIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711449001; c=relaxed/simple;
	bh=4QZLmSbm1MLXhr0qJmXOhyAfwyRRkmgsv34pized0xw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=F663h/EKqV4kv2BL9NrdTMzgvU23VscWrbyJddcJBTtiUw/II5Mx++bD9NM1jqMRvD2MPfUd2OoRJ62xCNVwi6Bvwf2s00CHTvWgCr6UJJ5KHq5TcKy8+TOFlRgpN/fRCfi3pLWyRrTtHkoE0Q3qIN5vAeR327lKbEoCiJmwUew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com; spf=pass smtp.mailfrom=kioxia.com; arc=none smtp.client-ip=210.130.202.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kioxia.com
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 42QATnt32378260; Tue, 26 Mar 2024 19:29:49 +0900
X-Iguazu-Qid: 2rWh11C4gmtKNHpm0e
X-Iguazu-QSIG: v=2; s=0; t=1711448988; q=2rWh11C4gmtKNHpm0e; m=wHAkRlTPynDlSN95zkryN8yupJQcpu7OLqPlrTvtLmA=
Received: from CNN1EMTA02.test.kioxia.com ([202.248.33.144])
	by relay.securemx.jp (mx-mr1121) id 42QATlth2222415
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 26 Mar 2024 19:29:48 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
	by CNN1EMTA02.test.kioxia.com (Postfix) with ESMTP id D9D6C2F028;
	Tue, 26 Mar 2024 19:29:47 +0900 (JST)
Received: from CNN1ESTR03.kioxia.com (localhost [127.0.0.1])
	by Switcher-Post_Send (Postfix) with ESMTP id 5E8261938D7224;
	Tue, 26 Mar 2024 19:08:21 +0900 (JST)
Received: from localhost [127.0.0.1] 
	 by CNN1ESTR03.kioxia.com with ESMTP id 0002VAAAAAA012HK;
	 Tue, 26 Mar 2024 19:08:21 +0900
Received: from CNN1EXMB03.r1.kioxia.com (CNN1EXMB03.r1.kioxia.com [10.232.20.152])
	by Switcher-Pre_Send (Postfix) with ESMTP id 532FCA035DC28;
	Tue, 26 Mar 2024 19:08:21 +0900 (JST)
Received: from CNN1EXMB03.r1.kioxia.com (10.232.20.152) by
 CNN1EXMB03.r1.kioxia.com (10.232.20.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 19:29:47 +0900
Received: from CNN1EXMB03.r1.kioxia.com ([10.13.100.22]) by
 CNN1EXMB03.r1.kioxia.com ([10.13.100.22]) with mapi id 15.01.2507.035; Tue,
 26 Mar 2024 19:29:47 +0900
From: tada keisuke <keisuke1.tada@kioxia.com>
To: "song@kernel.org" <song@kernel.org>,
        "yukuai3@huawei.com"
	<yukuai3@huawei.com>
CC: "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 09/11] md: add atomic mode switching when removing disk
Thread-Topic: [PATCH 09/11] md: add atomic mode switching when removing disk
Thread-Index: Adp/ZIq7EnQH8Y/+QBWXhs+ct+FbWA==
Date: Tue, 26 Mar 2024 10:29:47 +0000
Message-ID: <e95e7cea71d1465496a9502b4de49e75@kioxia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: ISME-14.0.0.2080-9.0.1002-28274.000
x-tm-as-result: No-10--5.650100-8.000000
x-tmase-matchedrid: 5V0fm+sVFB2magT1k9kBppTQgFTHgkhZKQNhMboqZlrGZbX3v50Wrzos
	Lf1kH5Cf9KYkbDev+bE52p2V9wXr31gyUUCO8mz8gnMtC97jHVTBOVz0Jwcxl6vCrG0TnfVUg9x
	e4gtUJtop7xmDsiWI7eSkRJ+6d2nBY+Xr17aLI9mkkQPcJHKMT+ovpkXHOUFXv1l2Uvx6idqu65
	UDD0aDgsRB0bsfrpPIFT1PBs+MVY3ocuK7+JBlJKynSBuJdXzfLdINTQrDOxQdkq5G9RbsCnc6Y
	nBhjO9btRkNxJ2JyUw=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--5.650100-8.000000
x-tmase-version: ISME-14.0.0.2080-9.0.1002-28274.000
x-tm-snts-smtp: C84AFBBFA731F091C7A1F930C85F5F89732CE1C1BAF081C83AA8472DD88FC65F2000:8
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

This patch depends on patch 08.

To minimize the number of execution of atomic mode switching, not only addi=
ng atomic mode switching, but also remove judgment is divided into two stag=
es.
Latency is minimized because only rdev to be removed is switched to atomic =
mode, not all rdevs.

Signed-off-by: Keisuke TADA <keisuke1.tada@kioxia.com>
Signed-off-by: Toshifumi OHTAKE <toshifumi.ootake@kioxia.com>
---
 drivers/md/md.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 30fbba38ea58..8c0c48a3a585 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9277,8 +9277,10 @@ static bool rdev_removeable(struct md_rdev *rdev)
 		return false;
=20
 	/* Fautly rdev is not used, it's safe to remove it. */
-	if (test_bit(Faulty, &rdev->flags))
+	if (test_bit(Faulty, &rdev->flags)) {
+		percpu_ref_switch_to_atomic_sync(&rdev->nr_pending);
 		return true;
+	}
=20
 	/* Journal disk can only be removed if it's faulty. */
 	if (test_bit(Journal, &rdev->flags))
--=20
2.34.1


