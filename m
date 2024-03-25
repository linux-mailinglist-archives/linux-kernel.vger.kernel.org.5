Return-Path: <linux-kernel+bounces-116774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E838C88A3BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254161C396DF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A8017CF6F;
	Mon, 25 Mar 2024 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPLnk0eU"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED05144D3C;
	Mon, 25 Mar 2024 10:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711362674; cv=none; b=FMjLVngamspqpWvod6bNqxGDMI42zoz6+d64LK7EDw9SWPo11gS50nWEXyQd2S8pHXXJK9u1aevs+bKrFuwTrPNl8q0KV/btldqvwMmNlFpCLrHwXvyVsNrhlno/Mb8+qAK5SMV/F1LEfp2TUybTbIo+YzNylDfLEpRGcqrcc0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711362674; c=relaxed/simple;
	bh=wIOMwu8LBbR6d05AA5Ev9i3suo88eYpc1/q507nhQKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UuQGLYUh8rM5wYw9XUcevJJa5CQSamN7uJ8oGo4sjPVByZNFY3Kxj5Cf81Wq0MsbXmFGpIvcOmX35gHtf857CgsCRGwjfdklrvwEzOMjaGmlpOQkQVdow4mgAzQjyQ10jAIzoxId3Js1v+fRxvBCvxQC6oKluzDqzbcoNVwLI8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPLnk0eU; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4141156f245so28856885e9.2;
        Mon, 25 Mar 2024 03:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711362671; x=1711967471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R6+pvzCVufm3Mx2KSZCT9a/GYJoxBfWf9J7OYkciu00=;
        b=ZPLnk0eUUbvBttpo20fnVfdSoqE5vqObJau7qrLicxcwygGw1+ealSbqgPvQQxkuo+
         U0t9K3Jtb0ZWqNO5SIaYKI9ZS3Ht16Ao+v31eyIXYh+TgJXVUaZGwHIaA8abYjfNGIQ4
         HBw4BRpaKY1p6nTzpi6evVcqADUSrM4ZZMN82g+qiXgD84UQFCZ1HHCgEbpthMwyOTq9
         mzaFbPPkKMiKtLIUNKKCVk8dIY/HhOSC7pKk3ootjM9konnu8P4fmNoDvdQSB1+1GvrN
         IeAUuJD06WGH3t19IwD3a/eRndrE8fChjyohWpSWc03XSUILVUTdKYWRfyoVk3ZEI/JN
         uTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711362671; x=1711967471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R6+pvzCVufm3Mx2KSZCT9a/GYJoxBfWf9J7OYkciu00=;
        b=oUoNqksn/8eRO6/5psegkNGYoyXNhtN70KxOv72Htt4sP5hW0KLmFxtRBLMLaL0Cgc
         O3bKs+9mNuBBiecvjS/IHsAt151SuccO/bBIVjuqeXabgKU2OMzay73JKiXrepiMOpwP
         5rULt/npUojdRDjL7oKm2NOAIlUxuK84Fb4nGQ2A7xutNuNbDnG4Gd2DOGuweLzB5Etz
         64psggjbQ8Cf2v1D1kV6mJgpbHYb3qgGk37bbKbN0n5tEYpONRs6BWlU1I6mbM5xsToN
         iv+viy3VpaovWVGL+pVScnwFFkdJTYv8i8q/WuKCpcVvxB5UltmRK36hseoO3LJqjFz0
         DjYg==
X-Forwarded-Encrypted: i=1; AJvYcCXZb0wTpHHLnm898nn51oX2cwpa/yZVUBep892CQUI2rHUXQxhXVpOdsQ6baPQhZe8DX9lHltkSE2vEl2tkdg9CKGXhVPZN/z+TiNgi95Il6AMbfI/m5y6vsYQmPiAdBsh2d83/RBQjY5TQlhYsEvSoN+TY3gLP3dnKE6faiI32KdHXrg==
X-Gm-Message-State: AOJu0YzFwSrysdaYsEZ970/dCEuJrFHtZ8/CuSRSoN4/ETZMPbij46dM
	2z6LHI/H/OyIne9yrtOIfCxHX1nJg4rAjNNkQR51KdvuCkwiadz7
X-Google-Smtp-Source: AGHT+IHy1HIusGGKPe5ZeiznWlk+PCo+gWmMgpHFaNOPq2HgywsUWU0pqUTA/+5Cc977DgMX3TN+Xw==
X-Received: by 2002:a05:600c:4713:b0:414:8865:bebb with SMTP id v19-20020a05600c471300b004148865bebbmr2474707wmo.7.1711362670527;
        Mon, 25 Mar 2024 03:31:10 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id be3-20020a05600c1e8300b004140e701884sm8063878wmb.22.2024.03.25.03.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:31:10 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	linux-mtd@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] mtd: rawnand: qcom: Fix broken erase in misc_cmd_type in exec_op
Date: Mon, 25 Mar 2024 11:30:47 +0100
Message-ID: <20240325103053.24408-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

misc_cmd_type in exec_op have multiple problems. With commit a82990c8a409
("mtd: rawnand: qcom: Add read/read_start ops in exec_op path") it was
reworked and generalized but actually broke the handling of the
ERASE_BLOCK command.

Additional logic was added to the erase command cycle without clear
explaination causing the erase command to be broken on testing it on
a ipq806x nandc.

Fix the erase command by reverting the additional logic and only adding
the NAND_DEV0_CFG0 additional call (required for erase command).

Fixes: a82990c8a409 ("mtd: rawnand: qcom: Add read/read_start ops in exec_op path")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Split this and rework commit description and title

 drivers/mtd/nand/raw/qcom_nandc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index b079605c84d3..19d76e345a49 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2830,9 +2830,8 @@ static int qcom_misc_cmd_type_exec(struct nand_chip *chip, const struct nand_sub
 	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
 
 	write_reg_dma(nandc, NAND_FLASH_CMD, instrs, NAND_BAM_NEXT_SGL);
-	(q_op.cmd_reg == OP_BLOCK_ERASE) ? write_reg_dma(nandc, NAND_DEV0_CFG0,
-	2, NAND_BAM_NEXT_SGL) : read_reg_dma(nandc,
-	NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
+	if (q_op.cmd_reg == OP_BLOCK_ERASE)
+		write_reg_dma(nandc, NAND_DEV0_CFG0, 2, NAND_BAM_NEXT_SGL);
 
 	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
 	read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
-- 
2.43.0


