Return-Path: <linux-kernel+bounces-28691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A03CF8301E0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54AFC1F266B7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D863F1400B;
	Wed, 17 Jan 2024 09:06:01 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CB5134BC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 09:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705482361; cv=none; b=ol23XUDvMAndUl0EUQRvYi2BnVQon0Z6ecl8E08n1sOuBAYNRtE96aJnmblOoCcHyC13qgET54vFszSEYfSqiGTY4qz8Ox0FYHXXj1DdBxod/C8OgKN4ckCeyL8MVWo9o5LX2092BTi0lYmp5gv6E3el1l24o+PuevR17C4w/PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705482361; c=relaxed/simple;
	bh=qwmCZTEQzfIJoPmH2a9jsKkXWTPb3LIj72q2fNLHiZI=;
	h=X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-UUID:Received:Received:X-ns-mid:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=rkuWeV9n1xa6o1vN74kwZNZyuOhNicCqq3Ra0IEGazvytKuoSdOwCSl5TZ0KQ6m6Vo9JVOqluE/v50Fl2fjTJJYDDeyuqXuW4t2SSD+2i5pM9WBi1koOz4fF9mFrM7VFL3U+P//qEn4DRGiCELW+hxP7HQ14r8QC5OGgZXDeGQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ee76e0f9ed9346d98d9002f4e6f06742-20240117
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:60c887b3-2dea-43c2-9bf1-1657082d5671,IP:10,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-18
X-CID-INFO: VERSION:1.1.35,REQID:60c887b3-2dea-43c2-9bf1-1657082d5671,IP:10,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-18
X-CID-META: VersionHash:5d391d7,CLOUDID:16dc588e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:2401171700272YDODMF1,BulkQuantity:0,Recheck:0,SF:19|44|101|66|38|24|
	100|17|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULN
X-UUID: ee76e0f9ed9346d98d9002f4e6f06742-20240117
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 819164830; Wed, 17 Jan 2024 17:00:25 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id D3324E000EB9;
	Wed, 17 Jan 2024 17:00:24 +0800 (CST)
X-ns-mid: postfix-65A79728-755627552
Received: from kernel.. (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id 67E86E000EB9;
	Wed, 17 Jan 2024 17:00:20 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: jgross@suse.com,
	boris.ostrovsky@oracle.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com
Cc: xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] x86/xen: Add some null pointer checking to smp.c
Date: Wed, 17 Jan 2024 17:00:18 +0800
Message-Id: <20240117090018.152031-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure. Ensure the allocation was successful
by checking the pointer validity.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401161119.iof6BQsf-lkp@i=
ntel.com/

---
v2: Initial rc and return errno in error paths
---
 arch/x86/xen/smp.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/smp.c b/arch/x86/xen/smp.c
index 4b0d6fff88de..0ea4f1b2ab21 100644
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -61,10 +61,14 @@ void xen_smp_intr_free(unsigned int cpu)
=20
 int xen_smp_intr_init(unsigned int cpu)
 {
-	int rc;
+	int rc =3D 0;
 	char *resched_name, *callfunc_name, *debug_name;
=20
 	resched_name =3D kasprintf(GFP_KERNEL, "resched%d", cpu);
+	if (!resched_name) {
+		rc =3D -ENOMEM;
+		goto fail;
+	}
 	per_cpu(xen_resched_irq, cpu).name =3D resched_name;
 	rc =3D bind_ipi_to_irqhandler(XEN_RESCHEDULE_VECTOR,
 				    cpu,
@@ -77,6 +81,10 @@ int xen_smp_intr_init(unsigned int cpu)
 	per_cpu(xen_resched_irq, cpu).irq =3D rc;
=20
 	callfunc_name =3D kasprintf(GFP_KERNEL, "callfunc%d", cpu);
+	if (!callfunc_name) {
+		rc =3D -ENOMEM;
+		goto fail;
+	}
 	per_cpu(xen_callfunc_irq, cpu).name =3D callfunc_name;
 	rc =3D bind_ipi_to_irqhandler(XEN_CALL_FUNCTION_VECTOR,
 				    cpu,
@@ -90,6 +98,10 @@ int xen_smp_intr_init(unsigned int cpu)
=20
 	if (!xen_fifo_events) {
 		debug_name =3D kasprintf(GFP_KERNEL, "debug%d", cpu);
+		if (!debug_name) {
+			rc =3D -ENOMEM;
+			goto fail;
+		}
 		per_cpu(xen_debug_irq, cpu).name =3D debug_name;
 		rc =3D bind_virq_to_irqhandler(VIRQ_DEBUG, cpu,
 					     xen_debug_interrupt,
@@ -101,6 +113,10 @@ int xen_smp_intr_init(unsigned int cpu)
 	}
=20
 	callfunc_name =3D kasprintf(GFP_KERNEL, "callfuncsingle%d", cpu);
+	if (!callfunc_name) {
+		rc =3D -ENOMEM;
+		goto fail;
+	}
 	per_cpu(xen_callfuncsingle_irq, cpu).name =3D callfunc_name;
 	rc =3D bind_ipi_to_irqhandler(XEN_CALL_FUNCTION_SINGLE_VECTOR,
 				    cpu,
--=20
2.39.2


