Return-Path: <linux-kernel+bounces-39565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F0583D2E6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 04:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13866B20A22
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E2CBA56;
	Fri, 26 Jan 2024 03:14:01 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C32179DC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 03:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706238841; cv=none; b=QOjTb8rJnwA9aS2O4HBEXsc9odSwGznl4A9QAZw4zABhHrDsFC0y4wTpJjE4lS5nOrWVaC+6HOGKyPBYI2Shv1GmxDgDaluNImzAU9SeFU4Jmr1To0sw5yOShsZIeQIHDSa+/nrltlQ4f8/y0Ma/5nGrsNdI1jzYW/w/q3pzIuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706238841; c=relaxed/simple;
	bh=GA2esvBeTd8mIHQDCojpMhHZgpxt4CAt2QMHSJ7L6D0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f26/ukKIPDxyJN3n8dYM+X9Yc6qej01bIUD7b1MJpKUUYS2Hb3NZ6Zf/5SyAGVWn83+Q2ciQ+Kc+GurGcOdVywafCKKJ2y1BeXRr31Eh3Wfkgc8/TR6FKO5yvsWLw0o/Sg8Cg/LBNUwS0swIg1eT5rMiu4tD8qTfyyTwhroL2WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3f32920ad6d54839b17c7a1696437518-20240126
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:4cc8e827-b5ee-435d-9187-76a4d0ecba94,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:7
X-CID-INFO: VERSION:1.1.35,REQID:4cc8e827-b5ee-435d-9187-76a4d0ecba94,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:7
X-CID-META: VersionHash:5d391d7,CLOUDID:0c9cac8e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:2401261108302ZZLIXV5,BulkQuantity:0,Recheck:0,SF:100|17|19|44|101|66
	|38|24|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: 3f32920ad6d54839b17c7a1696437518-20240126
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1448486289; Fri, 26 Jan 2024 11:08:28 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id BE96CE000EB9;
	Fri, 26 Jan 2024 11:08:27 +0800 (CST)
X-ns-mid: postfix-65B3222B-540941805
Received: from kernel.. (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id CF41CE000EB9;
	Fri, 26 Jan 2024 11:08:25 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: jikos@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com
Cc: linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] x86/apm: Code cleanup
Date: Fri, 26 Jan 2024 11:08:24 +0800
Message-Id: <20240126030824.579711-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This part was commented in about 19 years before.
If there are no plans to enable this part code in the future,
we can remove this dead code.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 arch/x86/kernel/apm_32.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index 76a5ced278c2..b37ab1095707 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -1055,35 +1055,6 @@ static int apm_get_power_status(u_short *status, u=
_short *bat, u_short *life)
 	return APM_SUCCESS;
 }
=20
-#if 0
-static int apm_get_battery_status(u_short which, u_short *status,
-				  u_short *bat, u_short *life, u_short *nbat)
-{
-	u32 eax;
-	u32 ebx;
-	u32 ecx;
-	u32 edx;
-	u32 esi;
-
-	if (apm_info.connection_version < 0x0102) {
-		/* pretend we only have one battery. */
-		if (which !=3D 1)
-			return APM_BAD_DEVICE;
-		*nbat =3D 1;
-		return apm_get_power_status(status, bat, life);
-	}
-
-	if (apm_bios_call(APM_FUNC_GET_STATUS, (0x8000 | (which)), 0, &eax,
-			  &ebx, &ecx, &edx, &esi))
-		return (eax >> 8) & 0xff;
-	*status =3D ebx;
-	*bat =3D ecx;
-	*life =3D edx;
-	*nbat =3D esi;
-	return APM_SUCCESS;
-}
-#endif
-
 /**
  *	apm_engage_power_management	-	enable PM on a device
  *	@device: identity of device
--=20
2.39.2


