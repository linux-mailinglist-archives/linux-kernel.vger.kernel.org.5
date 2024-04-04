Return-Path: <linux-kernel+bounces-131108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4393D89832E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F280D28601B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A8271B3A;
	Thu,  4 Apr 2024 08:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBsjuUzk"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478CE7173C;
	Thu,  4 Apr 2024 08:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712219531; cv=none; b=uGbvTwEATzpzcdOe6+nei6Od8YboAH8pVr/njd3Wv0d6AnbAxH7E8FIOAu0EULme1CKto4Oyqm30bubgjPfrykIgVlzwxJqFHyY94XnZJ0Y6zBc9KaYXtGTgQmeCNVb9gugVOmfs/8T1XbMpvCed6cyC7sQptF0fdfqXorH/+qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712219531; c=relaxed/simple;
	bh=CohMLq3cFButffA+6piuYF94WaoM5Mh+aDxSwhAKkFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T246bctvYyKrcA7l+y+sSA1fl9neZmN41Y0qmjE2CmxACNbO2PqAv1CW43HtJN4ZbSqbVoLRnLtGmkd3UW/CmqilhBuMtFNcYjhhhtCYhLSCGmRumV+vrokatR8VJZx8WiQX/j3/NAscQH1fd/uHd6hW43Sb9haS+W+9QiDfHis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBsjuUzk; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-343cd236779so42883f8f.3;
        Thu, 04 Apr 2024 01:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712219527; x=1712824327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ooJENRerkoGv8RC2dqQyR7rICIVbxFIMSkiHPTOG8iI=;
        b=SBsjuUzkruYTyTjy65947WdCEdB3nr6YwCZmLSxtxCfUZW2B/Wri1Vo5OOV/PQBJV/
         9sYzzvmBm3JpyqrU+pJzsdVYL0Urx1lTZ2peofrk+fvNGntWasVFEoXRa2sDQYs2Heo6
         4yTmMfJH8ZmE089LhCycTzFm82HTNAJ+YzMFuUxf9cGEcfhZF60Th7/9/13KDvf3OrJn
         5UJhVI1smFo0U7h9Js82BaJPT2kyu9MgEv1oVHk09Jjzp6mgXzCVuMVallIs0vYDwwFL
         EZ6BRNi2gj9W+ps7b3Cr57cK6lLarrFpZljrQyH7z0db2EhuZThVud7jsQFA4NM7PTVU
         lX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712219527; x=1712824327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ooJENRerkoGv8RC2dqQyR7rICIVbxFIMSkiHPTOG8iI=;
        b=waQXN/j//vkni4AXcvR10DRoTH+VLMRmf9F7JvC9vY4MCkaH5FTqI2++TOYPVajBfH
         m/YhYhv8mPjcks0a3LH0XOh6f/o4UKgp8ZTSmfhjIw1wHpVkWgyn65ITHUzTArkZClwh
         uW8EjzH522kPkyHgW6Olaj2NfRaHqF+lV/f6R53kugmIgQob+lK8rQCF2hlXbKD2EBQc
         fqcX8+6ejhwViAVfSspNExCV5b7LjvxmdXhdMHbNxc7TkYYjNq2rLhVnlwBmuQ+zYbCU
         91zOXtYqfyR82gcBiayGLpdFr4vs9vFqjiW5R1Na5mscLxjDcBWslBR+GPbEd/d0WX3a
         6DCg==
X-Forwarded-Encrypted: i=1; AJvYcCWU/wZah4e1z2lUDIbOI6KRBsxtyl4teZmLLW7i3mRv41JCZIlCiWG8MANwgXJV4r8TZrCvYGZXq8z7lg4Pf61vTQDK/bCi8zCJd4cUEbuVAPz0qyUUdiG6jkgmFYDt96GWxAPeOvzwcKTWPMBcmjkPHJP+bgbA/Z3TVE/MGlc6+e5oAA==
X-Gm-Message-State: AOJu0Yy8mIRXPbJ5ikS2La3B1Zghl3p4daL0Nm9Rv6SmcxHCg3K09kDD
	qNAOf6pr3ZpJ/dzHqHJl7X1EsJpULz8bd6mE5Zw3V+PpBdYgTrC9
X-Google-Smtp-Source: AGHT+IHMYG3JmAlvLO/BWsvlKYgpaEbWbKyheePdqiabhMh4InIyJ6wQlfooDCFT3M3D6bhH2Wi1RA==
X-Received: by 2002:a5d:568a:0:b0:33e:cf4d:c583 with SMTP id f10-20020a5d568a000000b0033ecf4dc583mr1575171wrv.16.1712219527113;
        Thu, 04 Apr 2024 01:32:07 -0700 (PDT)
Received: from localhost.localdomain (host-79-35-252-101.retail.telecomitalia.it. [79.35.252.101])
        by smtp.googlemail.com with ESMTPSA id dj13-20020a0560000b0d00b0033e9fca1e49sm19279707wrb.60.2024.04.04.01.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 01:32:06 -0700 (PDT)
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
Subject: [PATCH v4] mtd: rawnand: qcom: Fix broken OP_RESET_DEVICE command in qcom_misc_cmd_type_exec()
Date: Thu,  4 Apr 2024 10:31:55 +0200
Message-ID: <20240404083157.940-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While migrating to exec_ops in commit a82990c8a409 ("mtd: rawnand: qcom:
Add read/read_start ops in exec_op path"), OP_RESET_DEVICE command handling
got broken unintentionally. Right now for the OP_RESET_DEVICE command,
qcom_misc_cmd_type_exec() will simply return 0 without handling it. Even,
if that gets fixed, an unnecessary FLASH_STATUS read descriptor command is
being added in the middle and that seems to be causing the command to fail
on IPQ806x devices.

So let's fix the above two issues to make OP_RESET_DEVICE command working
again.

Fixes: a82990c8a409 ("mtd: rawnand: qcom: Add read/read_start ops in exec_op path")
Cc: stable@vger.kernel.org
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v4:
- Rework commit title and description as suggested.
- Add Reviewed-by tag
Changes v3:
- Merge patches
- Rework commit description
Changes v2:
- Split patches

 drivers/mtd/nand/raw/qcom_nandc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index b079605c84d3..b8cff9240b28 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2815,7 +2815,7 @@ static int qcom_misc_cmd_type_exec(struct nand_chip *chip, const struct nand_sub
 			      host->cfg0_raw & ~(7 << CW_PER_PAGE));
 		nandc_set_reg(chip, NAND_DEV0_CFG1, host->cfg1_raw);
 		instrs = 3;
-	} else {
+	} else if (q_op.cmd_reg != OP_RESET_DEVICE) {
 		return 0;
 	}
 
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


