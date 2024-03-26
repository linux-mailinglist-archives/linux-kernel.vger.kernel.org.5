Return-Path: <linux-kernel+bounces-118802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E6588BF8B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225B31F3B3B0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370386BFC0;
	Tue, 26 Mar 2024 10:30:03 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw1120.securemx.jp [210.130.202.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C8B5C90B;
	Tue, 26 Mar 2024 10:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711449002; cv=none; b=H/IGWutCypr92MPaGrcNLvdTjcS4SRdCcgePK9RmgADhpqnBxMuLqwSh3f+J3GeExwJgppBwE5FNruLRmCBUSykWO2Ub9yOiWVrAhf7UApzwHfalb65xS9wwhEYaycbVMobED/5XRRXzfv7MIyLYsQZyp33wBgnkxYXGhkWEiuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711449002; c=relaxed/simple;
	bh=M0BjFWay9RW56DcTyI8VhWYWKwj3d1u/51hugxS02FI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pfXebLl8pmUIPAL7Xra5mbhBT1qy0aEe5c0105x6IgANNZ+xsq75XSMGJwOlzF6t8D9EA/9td7miFT1fs/WHbwaWpSjdBPTeTtA/X3sCELKheWCjDMgtSZ7A+PFtykhqUnSoI6w6M3NmMOc4pYgXFQQ9s6ErBGqi/67ZjEr/MT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com; spf=pass smtp.mailfrom=kioxia.com; arc=none smtp.client-ip=210.130.202.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kioxia.com
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 42QATq9K2209751; Tue, 26 Mar 2024 19:29:52 +0900
X-Iguazu-Qid: 2rWg9o4uinxIZo6huv
X-Iguazu-QSIG: v=2; s=0; t=1711448991; q=2rWg9o4uinxIZo6huv; m=8Tw/BXHkkoj6j3cmE/J7d5JyB0KYQsLU2Fgyl+o/4Zw=
Received: from CNN1EMTA03.test.kioxia.com ([202.248.33.144])
	by relay.securemx.jp (mx-mr1120) id 42QATpWK2928151
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 26 Mar 2024 19:29:51 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
	by CNN1EMTA03.test.kioxia.com (Postfix) with ESMTP id 066B432440;
	Tue, 26 Mar 2024 19:29:51 +0900 (JST)
Received: from CNN1ESTR03.kioxia.com (localhost [127.0.0.1])
	by Switcher-Post_Send (Postfix) with ESMTP id 77A981938D7224;
	Tue, 26 Mar 2024 19:08:24 +0900 (JST)
Received: from localhost [127.0.0.1] 
	 by CNN1ESTR03.kioxia.com with ESMTP id 0002VAAAAAA012JI;
	 Tue, 26 Mar 2024 19:08:24 +0900
Received: from CNN1EXMB02.r1.kioxia.com (CNN1EXMB02.r1.kioxia.com [10.232.20.151])
	by Switcher-Pre_Send (Postfix) with ESMTP id 6C44DA035DC28;
	Tue, 26 Mar 2024 19:08:24 +0900 (JST)
Received: from CNN1EXMB03.r1.kioxia.com (10.232.20.152) by
 CNN1EXMB02.r1.kioxia.com (10.232.20.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 19:29:50 +0900
Received: from CNN1EXMB03.r1.kioxia.com ([10.13.100.22]) by
 CNN1EXMB03.r1.kioxia.com ([10.13.100.22]) with mapi id 15.01.2507.035; Tue,
 26 Mar 2024 19:29:50 +0900
From: tada keisuke <keisuke1.tada@kioxia.com>
To: "song@kernel.org" <song@kernel.org>,
        "yukuai3@huawei.com"
	<yukuai3@huawei.com>
CC: "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/11] md: add atomic mode switching when I/O completion
Thread-Topic: [PATCH 10/11] md: add atomic mode switching when I/O completion
Thread-Index: Adp/ZJXld54bLap0S/C/8U6V7u3sKA==
Date: Tue, 26 Mar 2024 10:29:50 +0000
Message-ID: <2b9cfb893d5b40478182a8f93d0463a8@kioxia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: ISME-14.0.0.2080-9.0.1002-28274.000
x-tm-as-result: No-10--8.850000-8.000000
x-tmase-matchedrid: WBjkmIX+tHCmagT1k9kBppTQgFTHgkhZKQNhMboqZlrGZbX3v50WrzPn
	4yDW5yf3GSNOWaKP4s2t2un08Qrrt3EWVXH5btzQTuctSpiuWyUUi4Ehat054zdlsYL2g/87GyQ
	B1oR95AqsIJcbcumfxGPKQgbIX4yuhcAT8+NWWH8jRwcsjqWGAh90OsLQe4vlyIKHzIGoT62k16
	eVRb8rL5dhlAAXYT7M7YL9OFIRb909S7tGIPO8TQ55FEYgJX09SKtHZwIquEv+Aw16GgqpO+m57
	3tusZjQTqumDQCn8tgrsSQ3gQbaomwp3fcRm9P4HWBogl1oa71ftuJwrFEhTY2j49Ftap9Eymsk
	/wUE4hq54HgM8GZx2SMFB0oG7nHS31EhHiJb6BsE+431M+6R1X3P4jWY9z7S59+FXOE8fLM=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--8.850000-8.000000
x-tmase-version: ISME-14.0.0.2080-9.0.1002-28274.000
x-tm-snts-smtp: 72FE3221312B6410F6B4AE800173FE40C97901191C27C1544272DB2841FBE76B2000:8
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CrossPremisesHeadersFilteredBySendConnector: CNN1EXMB02.r1.kioxia.com
X-OrganizationHeadersPreserved: CNN1EXMB02.r1.kioxia.com

This patch depends on patch 09.

If percpu mode in softirq context, switch to atomic mode in delayed executi=
on.
Move from softirq context to a context where RCUs are available and switch =
to atomic mode.
This patch completes the addition of atomic mode switching.

Signed-off-by: Keisuke TADA <keisuke1.tada@kioxia.com>
Signed-off-by: Toshifumi OHTAKE <toshifumi.ootake@kioxia.com>
---
 drivers/md/md.c | 16 ++++++++++++++++
 drivers/md/md.h |  6 ++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 8c0c48a3a585..1c7b774dbb48 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9566,6 +9566,7 @@ void md_check_recovery(struct mddev *mddev)
 		return;
 	if ( ! (
 		(mddev->sb_flags & ~ (1<<MD_SB_CHANGE_PENDING)) ||
+		test_bit(MD_RECOVERY_PERCPU, &mddev->recovery) ||
 		test_bit(MD_RECOVERY_NEEDED, &mddev->recovery) ||
 		test_bit(MD_RECOVERY_DONE, &mddev->recovery) ||
 		(mddev->external =3D=3D 0 && mddev->safemode =3D=3D 1) ||
@@ -9576,6 +9577,21 @@ void md_check_recovery(struct mddev *mddev)
=20
 	if (mddev_trylock(mddev)) {
 		bool try_set_sync =3D mddev->safemode !=3D 0;
+		struct md_rdev *fault_rdev;
+		bool faulty_some =3D false;
+
+		rdev_for_each(fault_rdev, mddev) {
+			if (fault_rdev->raid_disk >=3D 0 &&
+			    test_bit(Faulty, &fault_rdev->flags) &&
+			    nr_pending_is_percpu_mode(fault_rdev)) {
+				percpu_ref_switch_to_atomic_sync(&fault_rdev->nr_pending);
+				faulty_some =3D true;
+			}
+		}
+		if (faulty_some) {
+			clear_bit(MD_RECOVERY_PERCPU, &mddev->recovery);
+			goto unlock;
+		}
=20
 		if (!mddev->external && mddev->safemode =3D=3D 1)
 			mddev->safemode =3D 0;
diff --git a/drivers/md/md.h b/drivers/md/md.h
index ee84c4b5ee87..15e10205b578 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -605,6 +605,7 @@ enum recovery_flags {
 	MD_RECOVERY_FROZEN,	/* User request to abort, and not restart, any action=
 */
 	MD_RECOVERY_ERROR,	/* sync-action interrupted because io-error */
 	MD_RECOVERY_WAIT,	/* waiting for pers->start() to finish */
+	MD_RECOVERY_PERCPU,	/* nr_pending when faulty needs to be switched to ato=
mic */
 	MD_RESYNCING_REMOTE,	/* remote node is running resync thread */
 };
=20
@@ -886,6 +887,11 @@ static inline void rdev_dec_pending(struct md_rdev *rd=
ev, struct mddev *mddev)
 	int faulty =3D test_bit(Faulty, &rdev->flags);
 	nr_pending_dec(rdev);
 	if (faulty) {
+		if (nr_pending_is_percpu_mode(rdev)) {
+			set_bit(MD_RECOVERY_PERCPU, &mddev->recovery);
+			md_wakeup_thread(mddev->thread);
+			return;
+		}
 		if (nr_pending_is_zero(rdev)) {
 			set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 			md_wakeup_thread(mddev->thread);
--=20
2.34.1


