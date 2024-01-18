Return-Path: <linux-kernel+bounces-29992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A34B383165A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3A01C21FAA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800552030E;
	Thu, 18 Jan 2024 10:02:24 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9807320B0B;
	Thu, 18 Jan 2024 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705572144; cv=none; b=DoaElumEAyowmwYhDNkPblPtwCLCxfhjzKGZDSb5axC2aHvl1OCgaWXTJTS3SfShYOPMxbo6kx3XQSLaSIr6ckxWF5Lm267L1iYpjr/i/faK0VjfiMgF+DtoGR+QGwVBr6D4Myjhp0C4+Udpt944WWpIyidBLjKDp5EW5if4Y2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705572144; c=relaxed/simple;
	bh=OB9o0jiUtNKehJapIrC/Pp6m/oKy2ANatHpFJ/5DvbM=;
	h=X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-UUID:Received:Received:X-ns-mid:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=Nq1+ivXPbDvbp3jM1d94pANy2nw6SfmtjfF0AITUo1rr8Z2P+yZ28kHVAj6Lta9dWxuHjyEGkhzqmX2xIK46rHU85XmjZrA6jpq2HQJw0k4K2rsymecLBQrYZvVUBrfcyrfzmel2idYnZJ6rlPdHzoS6UyuoCoUkYcUaH68KxhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4d6849fc017b4a24b9e2b5ba77e007b3-20240118
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:1010ab24-0c46-46a6-a1be-87945ca9a23a,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:1010ab24-0c46-46a6-a1be-87945ca9a23a,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:63797d7f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240118180212MAVKV8H4,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|66|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 4d6849fc017b4a24b9e2b5ba77e007b3-20240118
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 742518887; Thu, 18 Jan 2024 18:02:10 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id C0AA2E000EB9;
	Thu, 18 Jan 2024 18:02:09 +0800 (CST)
X-ns-mid: postfix-65A8F721-215790310
Received: from kernel.. (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id 3D926E000EB9;
	Thu, 18 Jan 2024 18:02:07 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: keescook@chromium.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] pstore/zone: Add a null pointer check to the psz_kmsg_read
Date: Thu, 18 Jan 2024 18:02:06 +0800
Message-Id: <20240118100206.213928-1-chentao@kylinos.cn>
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
---
 fs/pstore/zone.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index 2770746bb7aa..abca117725c8 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -973,6 +973,8 @@ static ssize_t psz_kmsg_read(struct pstore_zone *zone=
,
 		char *buf =3D kasprintf(GFP_KERNEL, "%s: Total %d times\n",
 				      kmsg_dump_reason_str(record->reason),
 				      record->count);
+		if (!buf)
+			return -ENOMEM;
 		hlen =3D strlen(buf);
 		record->buf =3D krealloc(buf, hlen + size, GFP_KERNEL);
 		if (!record->buf) {
--=20
2.39.2


