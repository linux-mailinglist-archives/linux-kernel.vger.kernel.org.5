Return-Path: <linux-kernel+bounces-30084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B758318F5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3EF91C211ED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0766324A1C;
	Thu, 18 Jan 2024 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDgY2O6t"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0451121A12;
	Thu, 18 Jan 2024 12:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705580086; cv=none; b=D8NCYyQfcVw4My2oiu+cuNeuug3MnGD51lW4vrfYnpO8ABHOdH5ld07Lw4ohPf2FOmAVsWJ/fSt5yiGWJyHwhRWn4ECaKVwD5/ewJp1FRiBu/TEpzx5EHhFpneXWrT5aruJ+Sw4ly10f34jSO0ISZWUdqDUQ7lA6T0Q7Nz1Tzek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705580086; c=relaxed/simple;
	bh=djjsCtBMT3J7UQOghwFQYVRaBkgwuoLsuZnOcqi4QpI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=H2pzjd4CAcDTvr5GrPJBwJe9byieXE/p0JDFOeorU2BtxKGSeVnw302S28nhxfnhd2oyDk0A2YvDgFMe0p+3ZpWhPd4p93ki1REJIsWgwCUIgp/mNJfozrvrvRZVpb9IFVZB1/stTVDpdfgDWImSQw0nXm5kr2/bWlQpWzH9bJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDgY2O6t; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3376555b756so391909f8f.0;
        Thu, 18 Jan 2024 04:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705580083; x=1706184883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jl/QSyVeENwFqZo45P+/HN9QAR9bTLqt+HneRrWN0b4=;
        b=VDgY2O6t8TdVP4MrzqqVuzPKVEEBTfJFaS/EjrLgrUjBWNWFlV5ZVhow/V9e3ZdKsq
         OaCmjOFq8CRse0IBpVlW+ebWkph5zl6EO9hJFlJzvtG+IwlMYztNyLwFkn+hLsjLWrGF
         aPvjqk72GryflMsi4F9IuPdZU4/fAPD/s9ijQUUf1YD6Wu0XiSfwhiufXBuvVojOCYIB
         gyBuQz/zrWPE6HOj7vQB9i6vXM66v5aPt6eDnm/6JA3n65pATT5ryEm6172kuJvwjuER
         pmuIXnaLeoEORGD5Jx7l8L1uc1VPb4bEX1s61+8x2KY/4lZsxmE3dcZNoBdJEp3F+64Q
         msFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705580083; x=1706184883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jl/QSyVeENwFqZo45P+/HN9QAR9bTLqt+HneRrWN0b4=;
        b=iXBx+EhzeNDDziRcRy/VzKfGKrgaJdJcsuXKCDY6jdSP+FM++OclDfVLZw3rbXmxdh
         RQT9DWYGlXgFHSwITSaSxBteHMHUG1PfwCQcIQHIKGKK8+WxHR6IFM6GqhsSg/5UN61k
         FUYN15AVDRMPxoDdQ5rC2d/V7H10q3o6WHwvB4bWIoIKesj+PYycgqhhw4whWm0Fm4Zm
         PomrPT//Ddc6wZojzT2jNtoDJR8yqDo+Jkf5U+Iue1qrOgIHJY+yYY96n7Xmj7JQ31yw
         Qu0qcZufdE37u71OsKp+YUHcovMQoWjTGgcILkS6Upj8ij8R1L/3I9QtB9JrPzqklq57
         LFoA==
X-Gm-Message-State: AOJu0Yy2NOqfiJkVhYkmuylid56L4RMQjBNrpeMr8QyqllHU7TL2kbCm
	3xl7RUUsCMYi0Kl8qm317tgW+YIa1eVSKmrAbTk4bRd/dUh4sApp
X-Google-Smtp-Source: AGHT+IFx5xTOFom6VFy3Gwjtnx2Y2dSjQF2XhfvoIBTOEE5VVzcwGfLtjHAp2ikwIViBbBEGwrVHHw==
X-Received: by 2002:a5d:6d47:0:b0:337:6208:99df with SMTP id k7-20020a5d6d47000000b00337620899dfmr486497wri.20.1705580083143;
        Thu, 18 Jan 2024 04:14:43 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id y14-20020a5d4ace000000b00337bfc796a6sm3920976wrs.87.2024.01.18.04.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 04:14:42 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Chandrakanth patil <chandrakanth.patil@broadcom.com>,
	"James E . J . Bottomley" <jejb@linux.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] scsi: megaraid: remove redundant assignment to variable retval
Date: Thu, 18 Jan 2024 12:14:41 +0000
Message-Id: <20240118121441.2533620-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable retval is being assigned a value that is not being
read afterwards. The assignment is redundant and can be removed.

Cleans up clang scan warning:
Although the value stored to 'retval' is used in the enclosing
expression, the value is never actually read from 'retval'
[deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/scsi/megaraid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
index 66a30a3e6cd5..38976f94453e 100644
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -219,7 +219,7 @@ mega_query_adapter(adapter_t *adapter)
 	raw_mbox[3] = ENQ3_GET_SOLICITED_FULL;	/* i.e. 0x02 */
 
 	/* Issue a blocking command to the card */
-	if ((retval = issue_scb_block(adapter, raw_mbox))) {
+	if (issue_scb_block(adapter, raw_mbox)) {
 		/* the adapter does not support 40ld */
 
 		mraid_ext_inquiry	*ext_inq;
-- 
2.39.2


