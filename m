Return-Path: <linux-kernel+bounces-42886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7097284081D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262FB2903D3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5950B7CF1B;
	Mon, 29 Jan 2024 14:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="lbPOLPYR"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B216BB20;
	Mon, 29 Jan 2024 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706537970; cv=none; b=E+aN9OAVa6KbOQgqK5GR8/fSEISmMqoABnS8BbBnN6kVnFYgp6oUtJKkZtYh3C2UmvMJJP5NFuQ/FE8EcCdgU1AgcLsQOHNl6FGOTm8UCtiBW1/LvtIGAAVLFNOa4GvUQh8vyGIkEZGe+BSuX3Y6sgrAInjs7hMn65uiVIbCkn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706537970; c=relaxed/simple;
	bh=eYivng0WaDFd0Vu2WyMIJTEbBIN3RYQKrUhlxi/DlWc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=lRn6s396wIauSjQ/J7qTgpRLWlR5dMBphh3sA1u0NJMb+lLYA4waiIxUPWZkTt0jXA0wE7hQwMfJEZOmDIC+U35qporYyiOwoJCb1gHgiYHLE65v0VHrEh6szC8UKhbiwrBMVhZTuA9vKeS5Ujww6IVFWOqC8i8TQrJmJHb1Jqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=lbPOLPYR; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706537956; x=1707142756; i=markus.elfring@web.de;
	bh=eYivng0WaDFd0Vu2WyMIJTEbBIN3RYQKrUhlxi/DlWc=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=lbPOLPYR5P74yNuMHrnShtN2rw25ilrv68L1jycG17b6Q5guJzSCGXEgP75Ceftp
	 SGW5F9+VKYzO7Rgj9C8OZHWoM9D+ICdyAq45373sVbqFsk40QWpIoG7lXjgo7PcRE
	 FrU7XegcDhV3mpimY+LnCN7NGf+lRBiFRrrpPBKy7fQJlfX24AgUYI1EGSh5ErBWP
	 gMoOgHZvVt9fFNOszBBq8TE/bK92zaxX/6qJpCe7TGkpl0tqQFPqRv3wSB3Nccuq6
	 76sBzLrFCx0B6rHFnRAmVRPR1oyKq6Nlwgkhaj/+bXal9tqZPzyPywPK0O9L3srZG
	 uStkOBY4oNc2dVxCkg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Ma0Tu-1rXmNM0ne0-00W6xA; Mon, 29
 Jan 2024 15:19:16 +0100
Message-ID: <e8939703-b9a4-4ed0-ae7e-ad9a08ae96d4@web.de>
Date: Mon, 29 Jan 2024 15:19:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-s390@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 =?UTF-8?Q?Christian_Borntr=C3=A4ger?= <borntraeger@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Peter Oberparleiter <oberpar@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Vineeth Vijayan <vneethv@linux.ibm.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] s390/cio: Use memdup_user() rather than duplicating its
 implementation
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hQ7s/Dgj1zmFsnvUTN1JnmecsVLnRztFvRlxs9buzoqOIiVuJH5
 U+GScZF2QktLf+RSf9cPS6U5x6XpFh6Y20e01pAAxd7cdt0qVZW30fUp/HgMnA5bY+ySUc8
 XGwlUmAwpJFIyUldglOcZtk/mzElUiec5k3QxZgTaC+MwtzRl9IUDND9X999jhAeZu0ZKEj
 nrd55iK/b6fSgJSAy/J6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dZEMqn4WVQo=;sZnBrghKsL9L1lgCA/ryW/JqZhW
 F3VRJb5+N2692biWwI2AvMtGiLalgXPjPy4QBwbZiuBOSareIMPcI7O3CfehwMM4TdyB3Moue
 l6YjQzqZVuS8NJKlFVLY4kGe89Bop6x+9sxcGJturlGYvfpeD/ZFeFlybd9+wSsEmuirW5DiH
 X/18u07gCADOY8QEs/w2HY/71pq4g23WeP3Gsxs1EJHaLR0yEK0+roXBLyYgF99XmQKEW02QU
 HPN8e2jsLjCDbHMLbO9YR3KV/z+2CWG1aRilDmdDuMK9gsVl2HQmzlpcefVo9Xu8B7uIA7Jas
 hPvcPqNDYdNzFYRNTbtUz4MSmJ1RDyjXNdEu8M8uJISTd9kOtgl26NGntgNwDm4XbmpnvLjJg
 o2fypzj2wZhtv9tM8xXb0lXbxu/uCdj+xluHx0gL9rBiZEoI0diU/+8gYh1JHe1oOqeh/0ygP
 xkNvmZS5WgUaO/5VhKlVYlCT2do1Rea2myLEZ1gyQeXSpq8BA2gOktyRaZy4vOu3xZha66cZj
 a+uu1N2A8fJLFMTkw9jbQ/zIdfV67rE/chNRyLJ6zvqlsYxtsvTsqWPZkSa0PaRU2DZ+8cwB+
 N2bVgxq/HEVoqTOSUVO5Mn1YXjFOqAb2PuJxdPyV93VdQpPxq87qnHLD9EXJm6hEX/Q+MTQW8
 RQzd9O/4EtcwgI8WkfziKz2VlArTTb4RLriIDeIr0/0RVN3mOHAVtKixwAxr1tFGL0mWs7wWC
 iOCoz+6aBh/7GQPCvCN2p1svTt0r7bvsN3dL0h9i5rlG0YAiLvnQ2Ysc349apK8uTcF3NRFah
 hCiZo5GFESK12eM+MfDLqIGvdHqbE2LNVrRxKcIYIs0NGMtns7q9pImb3VZUAHzpXgcMddzqB
 S2vPqtV7zU6m69YjxZqrdGSojnK5nArkeTzgoOXrNgJmxzYja9W1wsK3LVR6ky8j+ACAApjYL
 Y3qih0BAxSq58M5K5fSOESoSm58=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 29 Jan 2024 15:00:36 +0100

* Reuse existing functionality from memdup_user() instead of keeping
  duplicate source code.

  Generated by: scripts/coccinelle/api/memdup_user.cocci

* Use another label in six function implementations.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/s390/cio/chsc_sch.c | 90 +++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 48 deletions(-)

diff --git a/drivers/s390/cio/chsc_sch.c b/drivers/s390/cio/chsc_sch.c
index 902237d0baef..2ad4264589d9 100644
=2D-- a/drivers/s390/cio/chsc_sch.c
+++ b/drivers/s390/cio/chsc_sch.c
@@ -442,15 +442,13 @@ static int chsc_ioctl_info_channel_path(void __user =
*user_cd)
 	scpcd_area =3D (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!scpcd_area)
 		return -ENOMEM;
-	cd =3D kzalloc(sizeof(*cd), GFP_KERNEL);
-	if (!cd) {
-		ret =3D -ENOMEM;
-		goto out_free;
-	}
-	if (copy_from_user(cd, user_cd, sizeof(*cd))) {
-		ret =3D -EFAULT;
-		goto out_free;
+
+	cd =3D memdup_user(user_cd, sizeof(*cd));
+	if (IS_ERR(cd)) {
+		ret =3D PTR_ERR(cd);
+		goto out_free_page;
 	}
+
 	scpcd_area->request.length =3D 0x0010;
 	scpcd_area->request.code =3D 0x0028;
 	scpcd_area->m =3D cd->m;
@@ -477,6 +475,7 @@ static int chsc_ioctl_info_channel_path(void __user *u=
ser_cd)
 		ret =3D 0;
 out_free:
 	kfree(cd);
+out_free_page:
 	free_page((unsigned long)scpcd_area);
 	return ret;
 }
@@ -504,15 +503,13 @@ static int chsc_ioctl_info_cu(void __user *user_cd)
 	scucd_area =3D (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!scucd_area)
 		return -ENOMEM;
-	cd =3D kzalloc(sizeof(*cd), GFP_KERNEL);
-	if (!cd) {
-		ret =3D -ENOMEM;
-		goto out_free;
-	}
-	if (copy_from_user(cd, user_cd, sizeof(*cd))) {
-		ret =3D -EFAULT;
-		goto out_free;
+
+	cd =3D memdup_user(user_cd, sizeof(*cd));
+	if (IS_ERR(cd)) {
+		ret =3D PTR_ERR(cd);
+		goto out_free_page;
 	}
+
 	scucd_area->request.length =3D 0x0010;
 	scucd_area->request.code =3D 0x0026;
 	scucd_area->m =3D cd->m;
@@ -539,6 +536,7 @@ static int chsc_ioctl_info_cu(void __user *user_cd)
 		ret =3D 0;
 out_free:
 	kfree(cd);
+out_free_page:
 	free_page((unsigned long)scucd_area);
 	return ret;
 }
@@ -567,15 +565,13 @@ static int chsc_ioctl_info_sch_cu(void __user *user_=
cud)
 	sscud_area =3D (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!sscud_area)
 		return -ENOMEM;
-	cud =3D kzalloc(sizeof(*cud), GFP_KERNEL);
-	if (!cud) {
-		ret =3D -ENOMEM;
-		goto out_free;
-	}
-	if (copy_from_user(cud, user_cud, sizeof(*cud))) {
-		ret =3D -EFAULT;
-		goto out_free;
+
+	cud =3D memdup_user(user_cud, sizeof(*cud));
+	if (IS_ERR(cud)) {
+		ret =3D PTR_ERR(cud);
+		goto out_free_page;
 	}
+
 	sscud_area->request.length =3D 0x0010;
 	sscud_area->request.code =3D 0x0006;
 	sscud_area->m =3D cud->schid.m;
@@ -603,6 +599,7 @@ static int chsc_ioctl_info_sch_cu(void __user *user_cu=
d)
 		ret =3D 0;
 out_free:
 	kfree(cud);
+out_free_page:
 	free_page((unsigned long)sscud_area);
 	return ret;
 }
@@ -629,15 +626,13 @@ static int chsc_ioctl_conf_info(void __user *user_ci=
)
 	sci_area =3D (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!sci_area)
 		return -ENOMEM;
-	ci =3D kzalloc(sizeof(*ci), GFP_KERNEL);
-	if (!ci) {
-		ret =3D -ENOMEM;
-		goto out_free;
-	}
-	if (copy_from_user(ci, user_ci, sizeof(*ci))) {
-		ret =3D -EFAULT;
-		goto out_free;
+
+	ci =3D memdup_user(user_ci, sizeof(*ci));
+	if (IS_ERR(ci)) {
+		ret =3D PTR_ERR(ci);
+		goto out_free_page;
 	}
+
 	sci_area->request.length =3D 0x0010;
 	sci_area->request.code =3D 0x0012;
 	sci_area->m =3D ci->id.m;
@@ -663,6 +658,7 @@ static int chsc_ioctl_conf_info(void __user *user_ci)
 		ret =3D 0;
 out_free:
 	kfree(ci);
+out_free_page:
 	free_page((unsigned long)sci_area);
 	return ret;
 }
@@ -700,15 +696,13 @@ static int chsc_ioctl_conf_comp_list(void __user *us=
er_ccl)
 	sccl_area =3D (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!sccl_area)
 		return -ENOMEM;
-	ccl =3D kzalloc(sizeof(*ccl), GFP_KERNEL);
-	if (!ccl) {
-		ret =3D -ENOMEM;
-		goto out_free;
-	}
-	if (copy_from_user(ccl, user_ccl, sizeof(*ccl))) {
-		ret =3D -EFAULT;
-		goto out_free;
+
+	ccl =3D memdup_user(user_ccl, sizeof(*ccl));
+	if (IS_ERR(ccl)) {
+		ret =3D PTR_ERR(ccl);
+		goto out_free_page;
 	}
+
 	sccl_area->request.length =3D 0x0020;
 	sccl_area->request.code =3D 0x0030;
 	sccl_area->fmt =3D ccl->req.fmt;
@@ -746,6 +740,7 @@ static int chsc_ioctl_conf_comp_list(void __user *user=
_ccl)
 		ret =3D 0;
 out_free:
 	kfree(ccl);
+out_free_page:
 	free_page((unsigned long)sccl_area);
 	return ret;
 }
@@ -800,15 +795,13 @@ static int chsc_ioctl_dcal(void __user *user_dcal)
 	sdcal_area =3D (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!sdcal_area)
 		return -ENOMEM;
-	dcal =3D kzalloc(sizeof(*dcal), GFP_KERNEL);
-	if (!dcal) {
-		ret =3D -ENOMEM;
-		goto out_free;
-	}
-	if (copy_from_user(dcal, user_dcal, sizeof(*dcal))) {
-		ret =3D -EFAULT;
-		goto out_free;
+
+	dcal =3D memdup_user(user_dcal, sizeof(*dcal));
+	if (IS_ERR(dcal)) {
+		ret =3D PTR_ERR(dcal);
+		goto out_free_page;
 	}
+
 	sdcal_area->request.length =3D 0x0020;
 	sdcal_area->request.code =3D 0x0034;
 	sdcal_area->atype =3D dcal->req.atype;
@@ -835,6 +828,7 @@ static int chsc_ioctl_dcal(void __user *user_dcal)
 		ret =3D 0;
 out_free:
 	kfree(dcal);
+out_free_page:
 	free_page((unsigned long)sdcal_area);
 	return ret;
 }
=2D-
2.43.0


