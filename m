Return-Path: <linux-kernel+bounces-46876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E64844621
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC78FB33437
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A93130E29;
	Wed, 31 Jan 2024 17:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="QKEK/gQH"
Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com [136.143.188.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EE712CD9D;
	Wed, 31 Jan 2024 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720939; cv=pass; b=KoFFNpuMDgxp82KytIyKYrGeju8sQBLC4wI0AKNPYHf4yt95GYux8wXb77d0jFtAeSOU3CyfmCNupoHKBbGgOPT9U8LtH4YAVyBVCIUVbfPLE7wvlkSMVW5L3A7Yh7nZCoQftpHOePPRd3/ah/QVqh+8hAKPuFZ2x9pC414l1tU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720939; c=relaxed/simple;
	bh=4KBntWU1blLLw3C630GBwTov4hAWEfv+DbWCCvwUS3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DF5naJ5yyO8JVuSvoz/LLnTIxht0hum2sgbPxdRAuXyoGUyXNENeY1+KLxxesRCoS3bA0fdYKnVTNuhdPJwBYrWaIZZXWw+9XltzA28divDsheFcWPt9jrLHD1Wovsxn/oHCc3gBlN7rkMlZa2u6D/5Vcb31/o1CqeEgxxo5Wb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=QKEK/gQH; arc=pass smtp.client-ip=136.143.188.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
Delivered-To: dpsmith@apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1706720918; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TigL/EDKYbWiexgIWBY4p9mtoP7CT+SxHxFrqk+5Cu3SBZpyMsBk6vNd9x1S44ifE1GB5HaStua4u5QkUwdVE5QNxLoRA53BzMQtr7MNMoRFtARLosBAtmLcs4RbD0m+o+F4KYjx3+ghb+JWeJ+XVrWoP/AHp1E8ZnihefPta48=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1706720918; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qy+lvF7GALRrQcNMzdxUYaDVhh02/KHKHqHE2SY4zeM=; 
	b=FLG1qXfX15wgFjen94KAKvwW1I9D3Oa524yVcD3etXYJ8J+UCp3pqk+60VbVx/LJKFhDBKeaBokVAnSGxa30TwSfoudvJFU4sz9c45T+y1T1vhs2OSCsYFTxGlfGgb6WUUkQVGr0ny6/HYUV9m8k76nGhbHBrpfDU7DZSJW5U60=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1706720918;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=qy+lvF7GALRrQcNMzdxUYaDVhh02/KHKHqHE2SY4zeM=;
	b=QKEK/gQHDZmGw+oPs0FKy0rXaHj/D7n+HL8+Ym2aX8p4xK2zFRO+mpXwSrro3C8X
	xqPShwk9XbrZKfJpbMXvS5aSzN/VStre1DrsyaHpwZu60kCSBjlbognONUieQ198khd
	xE51kzkHDouN2dGhkgzJTIZrKXl+KlLZMtVkJJwY=
Received: from sisyou.hme. (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
	with SMTPS id 1706720917763245.2481735163061; Wed, 31 Jan 2024 09:08:37 -0800 (PST)
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Daniel P. Smith" <dpsmith@apertussolutions.com>,
	Ross Philipson <ross.philipson@oracle.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 2/3] tpm: ensure tpm is in known state at startup
Date: Wed, 31 Jan 2024 12:08:22 -0500
Message-Id: <20240131170824.6183-3-dpsmith@apertussolutions.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240131170824.6183-1-dpsmith@apertussolutions.com>
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

When tis core initializes, it assumes all localities are closed. There
are cases when this may not be the case. This commit addresses this by
ensuring all localities are closed before initializing begins.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 drivers/char/tpm/tpm_tis_core.c | 11 ++++++++++-
 include/linux/tpm.h             |  6 ++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 4176d3bd1f04..5709f87991d9 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1109,7 +1109,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	u32 intmask;
 	u32 clkrun_val;
 	u8 rid;
-	int rc, probe;
+	int rc, probe, i;
 	struct tpm_chip *chip;
 
 	chip = tpmm_chip_alloc(dev, &tpm_tis);
@@ -1170,6 +1170,15 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		goto out_err;
 	}
 
+	/*
+	 * There are environments, like Intel TXT, that may leave a TPM
+	 * locality open. Close all localities to start from a known state.
+	 */
+	for (i = 0; i <= TPM_MAX_LOCALITY; i++) {
+		if (check_locality(chip, i))
+			tpm_tis_relinquish_locality(chip, i);
+	}
+
 	/* Take control of the TPM's interrupt hardware and shut it off */
 	rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
 	if (rc < 0)
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 4ee9d13749ad..abe0d44d00ee 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -116,6 +116,12 @@ struct tpm_chip_seqops {
 	const struct seq_operations *seqops;
 };
 
+/*
+ * The maximum locality (0 - 4) for a TPM, as defined in section 3.2 of the
+ * Client Platform Profile Specification.
+ */
+#define TPM_MAX_LOCALITY		4
+
 struct tpm_chip {
 	struct device dev;
 	struct device devs;
-- 
2.30.2


