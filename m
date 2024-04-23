Return-Path: <linux-kernel+bounces-154430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9524F8ADBFE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 04:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B6C1B2232E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8E517C67;
	Tue, 23 Apr 2024 02:38:35 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E297E574
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 02:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713839915; cv=none; b=AFliS4AuDdovMD51pzRYtnhHJDQ+qarDcUU4+7uuu4uJrtZMF68u4yEc6e5cCz0+V7gQkn7s2GcCZhMYSImk980BlELoOidv7wvIfVVlypmSn5lIOaxISS7s9mqGrONF1IFJYySIbpSy5MS+BsLO1IsbN6ikug4Z+KwiWOoYg98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713839915; c=relaxed/simple;
	bh=72ISYMgYcH/hJnavh8OwAPK3MBwCs2j8TIcB/OecvrU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EIsVfHOgGTO2uvBkwdBH3NGF3CvN4yEvVvcDOcMDr9BDHa/+TRf+1Mv/8NfJ1072+j2j+ghih1WZ7LUNG8gzVwFgINI94R3v00QHE4P98Dyg/C5V1f2qTkRX29syeSzD30/nRpTbRJCCzk0JToxNNbWgufS2iCUDG2CuyStdv4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8c857364011a11ef9305a59a3cc225df-20240423
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:41fd526f-4937-4f1d-9b2d-d002553a07a6,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:14,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:34
X-CID-INFO: VERSION:1.1.37,REQID:41fd526f-4937-4f1d-9b2d-d002553a07a6,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:14,FILE:0,BULK:0,RULE:Release_HamU,ACTION
	:release,TS:34
X-CID-META: VersionHash:6f543d0,CLOUDID:b4e00f20e07243cb81903c0aeb9f233c,BulkI
	D:2404231038211QRCVG5F,BulkQuantity:0,Recheck:0,SF:19|42|74|66|38|24|16|10
	2,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_USA,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: 8c857364011a11ef9305a59a3cc225df-20240423
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw.kylinos.cn
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 209557155; Tue, 23 Apr 2024 10:38:21 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id B8934E000EB9;
	Tue, 23 Apr 2024 10:38:20 +0800 (CST)
X-ns-mid: postfix-66271F1C-542924498
Received: from kernel.. (unknown [10.42.12.206])
	by mail.kylinos.cn (NSMail) with ESMTPA id D3BB6E000EB9;
	Tue, 23 Apr 2024 10:38:18 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: oakad@yahoo.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	kunwu.chan@hotmail.com
Cc: linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] tifm: constify the struct tifm_bus_type usage
Date: Tue, 23 Apr 2024 10:38:10 +0800
Message-Id: <20240423023810.1889264-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now that the driver core can properly handle constant struct bus_type,
move the tifm_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/misc/tifm_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/tifm_core.c b/drivers/misc/tifm_core.c
index d2eb31f39aa7..fd9c3cbbc51e 100644
--- a/drivers/misc/tifm_core.c
+++ b/drivers/misc/tifm_core.c
@@ -148,7 +148,7 @@ static struct attribute *tifm_dev_attrs[] =3D {
 };
 ATTRIBUTE_GROUPS(tifm_dev);
=20
-static struct bus_type tifm_bus_type =3D {
+static const struct bus_type tifm_bus_type =3D {
 	.name      =3D "tifm",
 	.dev_groups =3D tifm_dev_groups,
 	.match     =3D tifm_bus_match,
--=20
2.40.1


