Return-Path: <linux-kernel+bounces-134209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B1389AEFC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7061B1F22C74
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 06:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E308D1119A;
	Sun,  7 Apr 2024 06:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+muyBuH"
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFE4D304;
	Sun,  7 Apr 2024 06:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712473101; cv=none; b=gvP3bQl7biphnW1XyjLDqxuHHgtU7DlfIgMVrSA5VLGApbPrluyMQ4lYIOuqein9r8EQjesesyhI/9hyHrwWHxObRKRGBd8k6JjT+gWNdIfk9xmu0VdhWlFrQgwus8XIBk6vMydE3aSDNLWjiHuJvbMyCUKOeLVQy0SUppilXko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712473101; c=relaxed/simple;
	bh=6haZaBoCzYDbs6gYHymH85S6kUGBAmgTaEwCfRsPvpM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FLpMXVl8766E5fg1rQbxgLqj2AUpfhiVXiXYwSCRXIbw38RvEHn1xzlJ92bYeaDNpnZPfRp9hmEje4d9FUhdDd7Bg4jw7CJeoR6ITwZ1O2A5FbdARQVE6ocQH2OHIaOzi7P+soG41lH++3tqTIrqpzUY5+p3Fb9BbSyY8PHsjGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+muyBuH; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-6e6b01c3dc3so2393783a34.2;
        Sat, 06 Apr 2024 23:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712473099; x=1713077899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ID8vcKMAuhxPQfV9/bb6FKbXp3VjWvrumIK/fNKJqMQ=;
        b=G+muyBuHgNcRvwZc2Yx2hyUSOTnulxD1Lq9Oi4rO49qDsHapwYrr0MjmwjA+lLHiVR
         syvOdkxjtRn+dgV1ncYnCy1wpKHUdDLtqu6bS8x+7Fcr/ZLOkCpQDzANpvHvDPL7Va5M
         XOlJDehLQoXjW51N4l9s8RIYZAwNX0eVKjCcqj/tFHcMeGKan0PIkplKE/FoKW0DKT1V
         lPTwMv5+0MVJB3QhurXrkOtZAv6w2qEbKhB3IVZm895MJKuleu+lzKdsCEknhqETkmsQ
         N9JkwnZKDxTRbLaO1dFzPrW4ivtldj1JSKnu7DTsr4Uygyrxbos2C9umnM2TQtcvg463
         shkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712473099; x=1713077899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ID8vcKMAuhxPQfV9/bb6FKbXp3VjWvrumIK/fNKJqMQ=;
        b=BYWZ0gUJ6khpPGry+G9OOtZrGRVlEK6Fq+Eq8UPkdxVTDNlVFMBsI8CR6o6dfPu+GG
         CVCT+kMFOPkPEFzblkMUQHpng6eTIoZR5vLAmcfYh8GNeQHaVSVjRBoFoTfQ70/bbHb3
         sKpgp50riDkizCtF/YzwGq7jAEwJ6V2La8hhGRpsX/5haE7SG1otQr8BTxzI4HsXFa1D
         DYgvR0P+cmxq4p/EkKKRChBBNhx/fS5oLmZgvEw9lsZVm1C0fxOLIAeWUpTKCnocA+6L
         lFtUq1p6TYpoWdgJQjc7wudRNznt9DTPAiQdnBI2r/JwJDr72053n7VPlvY6q3GfQt7m
         bRoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbtyLkFodQITTUchniBty0/6XslcNtJpdCpAl6qKImksl3VGnOwTcQ8gIghA0vk7wNVuizZlJtznu3g++ObWQ8mL+TbMcm89zQygiO
X-Gm-Message-State: AOJu0Yzr7erUhKWAjA4ZWDilU7d1eVxR5lfIhy6o66YVu/SFdrq5bMFQ
	gLeahcdsnPt1EGDWiojFnHNGBI2j1xRlxpMhqwbq3ynbE0t1EMhC
X-Google-Smtp-Source: AGHT+IHFyUwUjUTWVe+jiqevLdXiWRZ6OUMoVNDPFUObFESfZrrr48ewx0Zt8+KUub5k2GpUTabcDQ==
X-Received: by 2002:a05:6870:2052:b0:22e:8647:7570 with SMTP id l18-20020a056870205200b0022e86477570mr6854479oad.54.1712473098776;
        Sat, 06 Apr 2024 23:58:18 -0700 (PDT)
Received: from lhy-a01-ubuntu22.. ([106.39.42.164])
        by smtp.gmail.com with ESMTPSA id g10-20020aa79dca000000b006ea80883ce3sm4095645pfq.133.2024.04.06.23.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 23:58:18 -0700 (PDT)
From: Huai-Yuan Liu <qq810974084@gmail.com>
To: james.smart@broadcom.com,
	dick.kennedy@broadcom.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@outlook.com,
	Huai-Yuan Liu <qq810974084@gmail.com>
Subject: [PATCH V2] scsi: lpfc: Fix a possible null pointer dereference
Date: Sun,  7 Apr 2024 14:58:09 +0800
Message-Id: <20240407065809.6373-1-qq810974084@gmail.com>
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
just jump to 'out_free_rdp'.

Fixes: 479b0917e447 ("scsi: lpfc: Create a sysfs entry called lpfc_xcvr_data for transceiver info")
Signed-off-by: Huai-Yuan Liu <qq810974084@gmail.com>
---
V2:
* In patch V2, we have removed the unnecessary 'out of memory' message.
  Thank Bart Van Assche for helpful advice.
---
 drivers/scsi/lpfc/lpfc_attr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index b1c9107d3408..94d968a255ff 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -1904,6 +1904,8 @@ lpfc_xcvr_data_show(struct device *dev, struct device_attribute *attr,
 
 	/* Get transceiver information */
 	rdp_context = kmalloc(sizeof(*rdp_context), GFP_KERNEL);
+	if (!rdp_context)
+		goto out_free_rdp;
 
 	rc = lpfc_get_sfp_info_wait(phba, rdp_context);
 	if (rc) {
-- 
2.34.1


