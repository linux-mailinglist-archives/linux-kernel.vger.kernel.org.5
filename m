Return-Path: <linux-kernel+bounces-27313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDE682EDAB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6160428525A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA141B81F;
	Tue, 16 Jan 2024 11:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCzbQc35"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CD11B7F9;
	Tue, 16 Jan 2024 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3376f71fcbbso7600644f8f.1;
        Tue, 16 Jan 2024 03:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705404367; x=1706009167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rd13aHdzvpA1cQQpKKJML11iFW4QAvlqVov/cDPqTuI=;
        b=jCzbQc35dmVmE+dRLux6Fm22kaJVSLE2oXf+6X3PqglGZi54iTU/+ye1npWs59tKYl
         9AvQBe8/qDxn4domnDYkolddWTR2f1XTCXI1nXrj2jqGKVBLVPKj7khk3GV9KJt4Jzz8
         e82a5NPMzsdAewzYeiPEhMXZFI/fHECXzI/B4BnnT4eLHUmvS+ybyf3DU2yoNeNDp6MU
         +pRLYVe1mkzlKFH0t1i9UrzOub5x34FUo+B/qY19AAPJPcGXf558G0Avk4W9iPPnL9xM
         mKlccNRbKZzn0qCg2CjU5KnrLrDrzR0fvX32QQm7Hifm98eFCGoOjmqAeKF+7kjTQuEI
         Uydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705404367; x=1706009167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rd13aHdzvpA1cQQpKKJML11iFW4QAvlqVov/cDPqTuI=;
        b=oHtkSvVez4CPwr0s5HAP5oP62C7mf/nwXSwkDFJtkTPbFAIVUzwUbaKSaI7Pkyw9kq
         6XL9b+tB5qhLdHwoVMB++aOzSi59ABo6ecjkWqJkuETVF8+gw6fhPBXCUVsXBy2YcvBw
         WIpzNPZccZfMXPxSlwNiOrrvs99OMuK8x7LP3k9KO2g1PDORHeVdMY79fN1DmqZwd5PS
         84rJ4yHdHfboRXACFM/fuNiNBULwpCagqp9UUiycJbyv8stDUU/6vJP+I790VN2D16Mc
         TLie1lxuo9fkK9Z2NM8oaC/uwj7OAqra5Ov+pEA84Z063eo+5hUYuRgbLCpXCq3Gbxkq
         OLlQ==
X-Gm-Message-State: AOJu0YxYACl92b3DaXPcNSeQmN5URw2EjJk3teNjLjn4y3GXg7Y6OHBN
	xVuih+oXmqFuqP5/QRDDPjg=
X-Google-Smtp-Source: AGHT+IH7Czaq9aUpYXYr1UNQB66OJul5DEB33rVwCyhVTVTz0OVOgwmXW/56IN/WuPB/euQrJn02pw==
X-Received: by 2002:adf:f687:0:b0:337:4e86:ebe1 with SMTP id v7-20020adff687000000b003374e86ebe1mr2749965wrp.42.1705404367367;
        Tue, 16 Jan 2024 03:26:07 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id m14-20020adff38e000000b003379b549a00sm9629444wro.10.2024.01.16.03.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 03:26:06 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: initio: remove redundant variable rb
Date: Tue, 16 Jan 2024 11:26:06 +0000
Message-Id: <20240116112606.2263738-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable rb is being assigned a value but it isn't being
read afterwards. The assignment is redundant and so rb can be
removed.

Cleans up clang scan build warning:
warning: Although the value stored to 'rb' is used in the
enclosing expression, the value is never actually read from
'rb'[deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/scsi/initio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/initio.c b/drivers/scsi/initio.c
index 2a50fda3a628..625fd547ee60 100644
--- a/drivers/scsi/initio.c
+++ b/drivers/scsi/initio.c
@@ -371,7 +371,6 @@ static u16 initio_se2_rd(unsigned long base, u8 addr)
  */
 static void initio_se2_wr(unsigned long base, u8 addr, u16 val)
 {
-	u8 rb;
 	u8 instr;
 	int i;
 
@@ -400,7 +399,7 @@ static void initio_se2_wr(unsigned long base, u8 addr, u16 val)
 		udelay(30);
 		outb(SE2CS, base + TUL_NVRAM);			/* -CLK */
 		udelay(30);
-		if ((rb = inb(base + TUL_NVRAM)) & SE2DI)
+		if (inb(base + TUL_NVRAM) & SE2DI)
 			break;	/* write complete */
 	}
 	outb(0, base + TUL_NVRAM);				/* -CS */
-- 
2.39.2


