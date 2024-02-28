Return-Path: <linux-kernel+bounces-85817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C4486BB7D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0ABD1C215E3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AE17D095;
	Wed, 28 Feb 2024 22:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lfdc8E+d"
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7F176F00
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 22:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709161155; cv=none; b=c5EEt3cN38vO+JXZm/VbeG7S+iffsWFSXTVO+21vuzkDa9pS9EvfnpZIoSjL1l/KAdrZgW1E2V2scupFq4CQOmKnLn5MC4gy5FBxju1IDrUdRjjjqpHsT8WA0fgDJlRiu1pu28jU9xMLf3AoVF+5zgAeGDqOQ7UM+1D+fynIJNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709161155; c=relaxed/simple;
	bh=Z4BBGV1hOFa3fzm1HmN99JMRiPAbNeMi55KlfreDQa8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wq/dR/bRtVsJWXIacAzegh7hMTlY2f8h3X6Ef1QSboxbnmOQ/jj9kvNf1V3hRCayImniTbU8N6ibruGvvGACInk3P1+BUXowl1H+wbGwDUJFSxkGfOzwKzDddJ2nWKf/3npReQJ1hQRSnVYnt0RUScMK5U+0bf44SYAjbUDrLUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lfdc8E+d; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-7c7e21711d0so22731139f.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709161152; x=1709765952; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bLU58cNsxIxmo5SOnpWD9TRuTE/p29tGp2T+p0X/qao=;
        b=Lfdc8E+dQoKRZ7UHjmCxuuOCumZf+bKJYPFI7mWFMp8y5FPX5nCz/UWCRuj8Gsy7Gr
         BNA1IvYFd3bY77T0Z3nEf46fSrjzrlVajbo23836z4u9v5kCNMImaCvBcrlrqU6QM887
         NX8ESr1CljoU4xv200pQ8AjyDHloSLdlOysohwNX20ovzauRXq/BeqOm1eurEgaGSaj2
         Ot48kC+Qi9E8Ii8hQs4fdy8THRHkO3IgO4rKaRm7g+T/ClmKkCcHtRTw1QNAxV4xAolE
         v8CJrzUo2gJoehB+gRq9bCeuUW2NtaA/JrgCrbSfNuOcPU96a5llrYIcBl5nwqWj/UYx
         KvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709161152; x=1709765952;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bLU58cNsxIxmo5SOnpWD9TRuTE/p29tGp2T+p0X/qao=;
        b=Qi2WWqqyghZF7siAJtUDllFNLwWdV6e2150FlVLCrncF+BowYOTLMRrYXLr2AVqAbO
         C2Sp/wNq63ZJsbhOlHLLNEEQ7Ahd1NMGBuZH+uUM/nLdcDGrRRefsungP8OA5WHnf8G9
         YyBWTkMcarGe8e/dhJPLJJ1cu6FsOWa8qiG8h27ID31jU50HwptktaXR3kWu8t35jqU1
         61uMNGJT+gizeywHUNq1hb5W/ECdYFeTUJnhO+vwKe9yEZErPLqnp8BVaTAW4Me6BYtF
         UFCVydwrRLtLvkTU3J0KKTAJRmSEldL9xNROZW7reMBaGS1RI4LQEkyssHokiRvBjkLg
         l4Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUAgQaiLRHyAflmgpzPfHzc1fnw/8i39NpV6JdW2xKsKocec+/N48FzmH/x7y20ObI/AyQqPItK2idHanX+iQNLiH123SeBbuyhe1Lk
X-Gm-Message-State: AOJu0Yx9mrksAB8o4Vwfp5v2dYmuzXYI9UIXGMHVoZkgUSq6yPVj/1ee
	/3iFm5BqVxaOKaTRtq6Wl6uRAEQgX44msndwaxWYCAP/M55sBaSwVnD616cixU8SrH1ggp8I1NV
	bHIa13G8tKtAqFu1195jZRg==
X-Google-Smtp-Source: AGHT+IHTJ2N2HYiEZpScC7YV/vYj8U8pCK1Y7mZmAc8fgA3K6ISVopKJKW42yQLgS0wMzPSfp0V4NfKW8t2emz9eHw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a5e:8c15:0:b0:7c7:edf3:3c74 with SMTP
 id n21-20020a5e8c15000000b007c7edf33c74mr2714ioj.1.1709161152300; Wed, 28 Feb
 2024 14:59:12 -0800 (PST)
Date: Wed, 28 Feb 2024 22:59:02 +0000
In-Reply-To: <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-0-dacebd3fcfa0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-0-dacebd3fcfa0@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709161149; l=2731;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=Z4BBGV1hOFa3fzm1HmN99JMRiPAbNeMi55KlfreDQa8=; b=BOIy+NBZ13y8jyxOGBEgcwe8EF98T+FHbRweiZOnkmVQdW7WTrX+fu+j+rrLs66UCEio/Mkue
 H7xxvi3ZGOJBzQK3h6BnUCO4CthpnvTF1Ubw473+zhoe1wq7ZYz2lx/
X-Mailer: b4 0.12.3
Message-ID: <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-2-dacebd3fcfa0@google.com>
Subject: [PATCH v2 2/7] scsi: mpt3sas: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>, Kashyap Desai <kashyap.desai@broadcom.com>, 
	Sumit Saxena <sumit.saxena@broadcom.com>, Sreekanth Reddy <sreekanth.reddy@broadcom.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>, Ariel Elior <aelior@marvell.com>, 
	Manish Chopra <manishc@marvell.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Saurav Kashyap <skashyap@marvell.com>, Javed Hasan <jhasan@marvell.com>, 
	GR-QLogic-Storage-Upstream@marvell.com, Nilesh Javali <njavali@marvell.com>, 
	Manish Rangankar <mrangankar@marvell.com>, Don Brace <don.brace@microchip.com>
Cc: mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, MPT-FusionLinux.pdl@broadcom.com, 
	netdev@vger.kernel.org, storagedev@microchip.com, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

The replacement in mpt3sas_base.c is a trivial one because desc is
already zero-initialized meaning there is no functional change here.

For mpt3sas_transport.c, we know edev is zero-initialized as well while
manufacture_reply comes from dma_alloc_coherent(). No functional change
here either.

For all cases, use the more idiomatic strscpy() usage of:
strscpy(dest, src, sizeof(dest))

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c      |  2 +-
 drivers/scsi/mpt3sas/mpt3sas_transport.c | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 8761bc58d965..c1e421cb8533 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -4774,7 +4774,7 @@ _base_display_ioc_capabilities(struct MPT3SAS_ADAPTER *ioc)
 	char desc[17] = {0};
 	u32 iounit_pg1_flags;
 
-	strncpy(desc, ioc->manu_pg0.ChipName, 16);
+	strscpy(desc, ioc->manu_pg0.ChipName, sizeof(desc));
 	ioc_info(ioc, "%s: FWVersion(%02d.%02d.%02d.%02d), ChipRevision(0x%02x)\n",
 		 desc,
 		 (ioc->facts.FWVersion.Word & 0xFF000000) >> 24,
diff --git a/drivers/scsi/mpt3sas/mpt3sas_transport.c b/drivers/scsi/mpt3sas/mpt3sas_transport.c
index 421ea511b664..76f9a9177198 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_transport.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_transport.c
@@ -458,17 +458,17 @@ _transport_expander_report_manufacture(struct MPT3SAS_ADAPTER *ioc,
 			goto out;
 
 		manufacture_reply = data_out + sizeof(struct rep_manu_request);
-		strncpy(edev->vendor_id, manufacture_reply->vendor_id,
-		     SAS_EXPANDER_VENDOR_ID_LEN);
-		strncpy(edev->product_id, manufacture_reply->product_id,
-		     SAS_EXPANDER_PRODUCT_ID_LEN);
-		strncpy(edev->product_rev, manufacture_reply->product_rev,
-		     SAS_EXPANDER_PRODUCT_REV_LEN);
+		strscpy(edev->vendor_id, manufacture_reply->vendor_id,
+			sizeof(edev->vendor_id));
+		strscpy(edev->product_id, manufacture_reply->product_id,
+			sizeof(edev->product_id));
+		strscpy(edev->product_rev, manufacture_reply->product_rev,
+			sizeof(edev->product_rev));
 		edev->level = manufacture_reply->sas_format & 1;
 		if (edev->level) {
-			strncpy(edev->component_vendor_id,
-			    manufacture_reply->component_vendor_id,
-			     SAS_EXPANDER_COMPONENT_VENDOR_ID_LEN);
+			strscpy(edev->component_vendor_id,
+				manufacture_reply->component_vendor_id,
+				sizeof(edev->component_vendor_id));
 			tmp = (u8 *)&manufacture_reply->component_id;
 			edev->component_id = tmp[0] << 8 | tmp[1];
 			edev->component_revision_id =

-- 
2.44.0.rc1.240.g4c46232300-goog


