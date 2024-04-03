Return-Path: <linux-kernel+bounces-128940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD324896211
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FDF81F254DB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A37115491;
	Wed,  3 Apr 2024 01:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONo16Ut1"
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92331D29B;
	Wed,  3 Apr 2024 01:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712108417; cv=none; b=T+6P2Hrywf11wHtaZ/TI40aPFkbXCGaX/RXkEsZlgUTQTP2li3uycMF7IobygT11Z70r2LTcv0Z83aWxiSsrrkbeE0c/nK5WaQeYDl+T9W3WLV08KKSq6P3G1hvxCIdgxChGVfgx2FsvkHjSO9Bt5YwfaKuuopbtGGJs00E4Jj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712108417; c=relaxed/simple;
	bh=+R0L3fbUAwMuP4zU+FqvteBWJzn7D8l7WzQcKHfHy7M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dNkNS92SBj3Wh2Y+ATL2lgHmS750H8UEfr24afzqsMWesfIo0LiXSyoAVE6vNVU8yMQmIJKtoS6d02eyjhNezvWRxNIonMBlj/SDNuPPI9Un+i/+OpTPT5IVxosCG8U9y+2fyiOvavZvkp6BdTYwvHqld+/5Lg4ehkhb6blBc74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONo16Ut1; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-2a2601f0562so999097a91.0;
        Tue, 02 Apr 2024 18:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712108416; x=1712713216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fh/SNg739z3tPcMMVWuLhLjyN3VYUDkGO69sFSfgsFE=;
        b=ONo16Ut1dVhWDeUHDSuCHctJNk0aZhyp6BbnpwEqzAFQMpc7h/lpsr6uxtYDYtdRtc
         HPcQEgwnRWexGmRmDst+POkXjMGB/291up1Jr3G2ZBWTUCVDlq2j94KfsOq7ns29wCy+
         6+/ZT5sKjtPrAZVmIclZW1owJe/OWcwPbQ2FhrrQbJx0lsLgjpXanZUX2fjy44/TtLvj
         KbCDeAPJpdnAYfUB25EwYHCuVUG1Hq5q7pT/3zD+3yvYkrSX6GsKMl+IxH5A6l5tRDp7
         kg2On3fNUxssZPX1QJ02Ci6qDGpELE2bIP3STdx6yh0oFNY7smgrazQXddrBp37j8l5G
         oyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712108416; x=1712713216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fh/SNg739z3tPcMMVWuLhLjyN3VYUDkGO69sFSfgsFE=;
        b=QspKFxB6ymUUK2vz7jXrZUuJSS3g8uz/5ftob/CweKC4bS7KxSYk1B+In+X5+yToSy
         7cTXXSajtHC+nyNo7vTGSg6WFGqJeBfgZs6puBHxCWTuPDunL1BXB2RoLilMrepD0805
         8hZde1tfRJhoom+xqj3ZspT0iijAT4RSXKtMPBTUrZyuaCBO7Z2kQYVFsbevEKRIXGxV
         RbR5Vld+cRtxcRo+w8L8/8oeQpUbsmhZYPdx9SLfr7RhlqbMf3Vl+cQuGNwgFuMn72sv
         6wHOIzN0gBcnGXc1SMUoPNHMxp0jVNtyZwELufroEANmEqzyFZ8LzyDlJjqvyXaIXLH3
         Fsgw==
X-Forwarded-Encrypted: i=1; AJvYcCXwQZGqu55d3MN/ZIUk6fYVUFMAe/mjoJ1Z/eoMq6RIfGef0iF22XTBsI7KuTOvLiFYODJuut1Eqjk4QtE06/d85/+prVBgoiSFyaUo
X-Gm-Message-State: AOJu0YzgpEqaXNGozNIiEb/I6b83nzi40U4GyX7lqdQD/HSpO/4+BV+R
	owN9D5cLfWt6Q31cRvvNRVhrq99Sn0y2Ak3bvBydzIzlU1i7weo0ZHQamVS2pocV6MVO56c=
X-Google-Smtp-Source: AGHT+IEGIwvBOEybaWEwLmntVJFoPa1TyRl5IIAhnhkIdUZb4xQk5nSUcwRBkDqFAirNCPgj+dvcOQ==
X-Received: by 2002:a17:90a:62c5:b0:2a0:8f31:a359 with SMTP id k5-20020a17090a62c500b002a08f31a359mr13185913pjs.39.1712108415773;
        Tue, 02 Apr 2024 18:40:15 -0700 (PDT)
Received: from lhy-a01-ubuntu22.. ([106.39.42.164])
        by smtp.gmail.com with ESMTPSA id m14-20020a17090ab78e00b0029c68206e2bsm10246894pjr.0.2024.04.02.18.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 18:40:15 -0700 (PDT)
From: Huai-Yuan Liu <qq810974084@gmail.com>
To: james.smart@broadcom.com,
	dick.kennedy@broadcom.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@outlook.com,
	Huai-Yuan Liu <qq810974084@gmail.com>
Subject: [PATCH] scsi: lpfc: Fix a possible null pointer dereference
Date: Wed,  3 Apr 2024 09:40:06 +0800
Message-Id: <20240403014006.969441-1-qq810974084@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In function lpfc_xcvr_data_show, the memory allocation with kmalloc might
fail, thereby making rdp_context a null pointer. In the following context 
and functions that use this pointer, there are dereferencing operations,
leading to null pointer dereference.

To fix this issue, a null pointer check should be added. If it is null, 
write error message and jump to 'out_free_rdp'.

Fixes: 479b0917e447 ("scsi: lpfc: Create a sysfs entry called lpfc_xcvr_data for transceiver info")
Signed-off-by: Huai-Yuan Liu <qq810974084@gmail.com>
---
 drivers/scsi/lpfc/lpfc_attr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index b1c9107d3408..b11e5114b7f2 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -1904,6 +1904,11 @@ lpfc_xcvr_data_show(struct device *dev, struct device_attribute *attr,
 
 	/* Get transceiver information */
 	rdp_context = kmalloc(sizeof(*rdp_context), GFP_KERNEL);
+	if (!rdp_context) {
+		len = scnprintf(buf, PAGE_SIZE - len,
+				"ERROR: Not enough memory\n");
+		goto out_free_rdp;
+	}
 
 	rc = lpfc_get_sfp_info_wait(phba, rdp_context);
 	if (rc) {
-- 
2.34.1


