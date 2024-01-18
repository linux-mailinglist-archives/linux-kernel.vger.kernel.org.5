Return-Path: <linux-kernel+bounces-30092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC50C831908
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4327281966
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F09624B37;
	Thu, 18 Jan 2024 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yy14tb4L"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287EE241F5;
	Thu, 18 Jan 2024 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705580444; cv=none; b=oBIvmPJazWc4taZUgGKF4iAT+ma3RQU7qEB4/n25SCtzCdfk/pbdtlwmfzUVm+3+7VmksKkexjUDgurpYu12+zrdNp/ZTH4wKOVJXWX3X5MqjAjt+H9BdU0UcAzpIQO8qnTSExqyJ0GbmpBkf3qntBeMgrPOZWgQR13dQk30F2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705580444; c=relaxed/simple;
	bh=wKeRRvwusUw6uM5fiDp+NNumKfPCuSxZTnfq0P5ovz0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=mCidjmLvqlda09fyrK2jbY2UNkBnRDs14jdbxvCUWPG01zlWrjZJ+1xsnpt4Ncn/wrlmFXC0U598UzGSaW5W4gq5DMwLUq0tHt8P9Q6dXzw244jAO7P0Un7HbPx0emSVrsY4b/vVyDt5aFzUdhDTkdgKZ0MVGCxWFp2u8y/9oFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yy14tb4L; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e76109cdeso45685345e9.0;
        Thu, 18 Jan 2024 04:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705580441; x=1706185241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m0nHhjrzFZM7Cc/aJje9RV5MSdJX0vTi3w7er5mHZ94=;
        b=Yy14tb4LrOT9YvrkDgpRLpxOEJlwMvZj2S0lxCVHgfvhEmMW5cVUq2s/5S3jNDIqC5
         YPA+13fPGdiuUh2Xb3a9dz1PyshhdnX1YKgCwjimxLPgqo7o7LcJgAnXYG/vHzuck0Du
         g3333MuWL+DrTrPfoqbarFAQW9SBQpF2ntKgEn7/3kVApGD41f4f6qUhzCFpBbpbqO5A
         NJ2udb9Vsdf0WrMgULhuV0jdyaoMiXjumdA+un6kpSDyGTTlwqgW5nAZ0iaMEQNv2wLy
         MJllzyoMsfL83hH9YvxVqSgmtQ6rGb0XnG7E7u4cXtFH33UUEO4Su3WALPdxWrwh1IoO
         NJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705580441; x=1706185241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m0nHhjrzFZM7Cc/aJje9RV5MSdJX0vTi3w7er5mHZ94=;
        b=E/MfG0IatHeRLznmBxIwPRBRY5GDmTGV/Jz+VkiPX0VEHV1T/GHc2u1vp3H9/BOYC9
         nL49MX4BN2xW+QBHhZPEbEFOuuuWX3iw0not1/PvkQKIV6DyzJyqsyI2F/e9ZQ6oodag
         JYAp3dXCqiV+yvnonVg2kwOozI6q/1XzH1t62ewDCJp4oiXfMtx4znd277cLmhfDyYCZ
         zwuWaVJnMzDRQG83NaVaOffmCMYPs5Rtb2vs7fhhjSOywb4eKaFjI0dcmVYHshNoF/Vh
         A17zmWoZ6jf4ioWYYPxksl4FtE3nA7z3/4yBnINR0b3pS2/gWtfKAAI88PKyDf9v8aEf
         zJMQ==
X-Gm-Message-State: AOJu0Ywa9i7aON7CsuggnQGwUw6Aa5YN/TJTVLhb7RFYSgyFdlygx/6k
	a3K62qZ1u8qIimEU1K6AORl3ap6pNuvPujOQJVPtD821knP4X9R9
X-Google-Smtp-Source: AGHT+IE1li7/tNfuLhhzIfuUktoc+UB/iW/Ffzt1JDUrO6Lg7Nbep8IaJTaabEGGhpnnb3Faob3EQg==
X-Received: by 2002:a1c:7508:0:b0:40e:7734:ead2 with SMTP id o8-20020a1c7508000000b0040e7734ead2mr483857wmc.177.1705580441142;
        Thu, 18 Jan 2024 04:20:41 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id v4-20020a05600c470400b0040e45799541sm29398014wmo.15.2024.01.18.04.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 04:20:40 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	MPT-FusionLinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] scsi: message: fusion: remove redundant pointer hd
Date: Thu, 18 Jan 2024 12:20:39 +0000
Message-Id: <20240118122039.2541425-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The pointer hd is being assigned a value that is not being
read later. The variable is redundant and can be removed.

Cleans up clang scan build warning:
warning: Although the value stored to 'hd' is used in the enclosing
expression, the value is never actually read from 'hd'
[deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/message/fusion/mptfc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/message/fusion/mptfc.c b/drivers/message/fusion/mptfc.c
index 0581f855c72e..c459f709107b 100644
--- a/drivers/message/fusion/mptfc.c
+++ b/drivers/message/fusion/mptfc.c
@@ -1401,7 +1401,6 @@ static struct pci_driver mptfc_driver = {
 static int
 mptfc_event_process(MPT_ADAPTER *ioc, EventNotificationReply_t *pEvReply)
 {
-	MPT_SCSI_HOST *hd;
 	u8 event = le32_to_cpu(pEvReply->Event) & 0xFF;
 	unsigned long flags;
 	int rc=1;
@@ -1412,8 +1411,7 @@ mptfc_event_process(MPT_ADAPTER *ioc, EventNotificationReply_t *pEvReply)
 	devtverboseprintk(ioc, printk(MYIOC_s_DEBUG_FMT "MPT event (=%02Xh) routed to SCSI host driver!\n",
 			ioc->name, event));
 
-	if (ioc->sh == NULL ||
-		((hd = shost_priv(ioc->sh)) == NULL))
+	if (ioc->sh == NULL || shost_priv(ioc->sh) == NULL)
 		return 1;
 
 	switch (event) {
-- 
2.39.2


