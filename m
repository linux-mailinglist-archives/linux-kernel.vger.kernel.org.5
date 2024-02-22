Return-Path: <linux-kernel+bounces-77071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB768600DF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9EC1C228FA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CF615D5B0;
	Thu, 22 Feb 2024 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gwt6aXEY"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCB715B99E;
	Thu, 22 Feb 2024 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625682; cv=none; b=asOP4m5vGQ6yhofOgPks3QTBQpJRAPh37EpvOhgh7JkcuSATvyOzvJ/Zvu6j+cgoMPSXaXtJeOgyna76WC3qepPrazXQ3RskBUyAoRxHfi7dPAsrDs1947iSuPI8MROEwlkaUzqi6m5bFoPCwIb7IQ3q0wlKMW461Fhi1p0w2zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625682; c=relaxed/simple;
	bh=NnnqUwFC1hDxEU1wgg2AtxwRiDr/uK0iWNRJB8yXi8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTacqDvbnQH7jEqqDaFMmV+1efQTWudlHH1944iVOpUhHihW3XzLtamFUaV35UocG3W1QKjBJvDHfgoY6bIlV+aidLwUFWWwBJZ4RCJWR6IVo/1Vt/Z4irNO3byJMvuuumiMZon84E07mZIwlBf8e4Ci/B7Vicy7PfuIGLzADnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gwt6aXEY; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512a85806fcso63121e87.2;
        Thu, 22 Feb 2024 10:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708625679; x=1709230479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tv0ab2lgE4guOpRcHEiI1iTXuRh4uBNVZdl4mwlt2wg=;
        b=Gwt6aXEYyG2fcrk9PnegPAXYcgo1XugNd9tW55/m/sgXIMr9amsZlEoJxayzcurURw
         X0OkIR5ieGi2yZX/UzHAzNpiryKk5zF+E5SMPhCIDCpYvKb3lMD4Zl1Pf+Hd1FW5+NZE
         gcUiKa7tKfvLEwkAb9+or5wfgtc+j7nV77+Ernf/fby459AwbXPMspMvE1aC1oga0mzr
         kFo/LOMw7TZubCK4DPnb3XbRZbyisqa360fCbIK/TBJKuSP7AhI4aTxhgzwwYX4XdR8t
         Z2kh+qZFHPyogYn4JLBRxxIapwmY8u8CQyVHL1Efts/qiDqnhK0OYUWtFV6u39l65ato
         wy6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708625679; x=1709230479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tv0ab2lgE4guOpRcHEiI1iTXuRh4uBNVZdl4mwlt2wg=;
        b=fal1cqRkgSkhVXzJC9RTuhpMQteZLGzGgRvxCsoDm3ofjXrZZig/ftJv3818ghpW/F
         743jjFr1YphukFldiucFDlY16e1HebZUHrc8Z9CmBiyblor3WAPrbDJeP06IuK/QR19P
         rLtLJizAT/t9hv62IaAg2k2YzpONSF27uCIuYunJoSupheTXw8PRJED5IzPwqCfh+2+/
         qEbYHFX6kuH+3tJ6pFtl9lSXKlXumqq5boXch/P1XeY8XfJpvyFt4LezaPXnuBkwHk5k
         +vTtXeppAHJKiV19T3tdVxjAdfTRK7TDHTVpG/j9rg/N4Xip0bAq6OERWfqX4LupDx0C
         ybJw==
X-Forwarded-Encrypted: i=1; AJvYcCUzejzu9V+o/9kSNzAYtRp69IodxrZJI0NhVJqBH2baHCPceVUkSek5s5bPdnx8UQ/STcIe6oENMWC5zhIfLjPRBo+J+XaYYb5aB1EOk1ZphwCBMLIllYzyqllakIsaAr7wvrz6IqjX+g==
X-Gm-Message-State: AOJu0YzNdO+MtzmDVctlj2AXVLYi3FwUjUjLbdsoHDmvETwBfr7Gx2uj
	KV5QpMfU5QIk7dJU2xGS0AZ+RMfz1pdSYzJZ68tUudK7ceHm89xy
X-Google-Smtp-Source: AGHT+IHA+WyWxnQ+pOSdLU4Imqh9orDNdwYCUlK6uxFXLm/wiayy7DJwE0Kc0gDTLDO3NPom4pMyow==
X-Received: by 2002:a05:6512:1244:b0:512:bf7e:ca25 with SMTP id fb4-20020a056512124400b00512bf7eca25mr7610267lfb.20.1708625678696;
        Thu, 22 Feb 2024 10:14:38 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id o5-20020ac24c45000000b00512e50c09acsm1089lfk.48.2024.02.22.10.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 10:14:38 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 10/20] EDAC/synopsys: Drop struct ecc_error_info.blknr field
Date: Thu, 22 Feb 2024 21:12:55 +0300
Message-ID: <20240222181324.28242-11-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222181324.28242-1-fancer.lancer@gmail.com>
References: <20240222181324.28242-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even though the ECC(C|U)ADDR1 CSR description indeed says it's a "Block
number" in the DW uMCTL2 DDRC IP-core databooks, the corresponding
register field is named as ECC(C|U)ADDR1.ecc_(un)corr_col (which means ECC
(un)corrected column) and in the rest of the document it's referred as the
SDRAM address column. Thus use the already available ecc_error_info.col
field to read the column number to and drop the questionable
ecc_error_info.blknr field for good.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 21b0d791cb8b..6ca119459bd3 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -173,7 +173,7 @@
 #define ECC_CEADDR0_RNK_MASK		BIT(24)
 #define ECC_CEADDR1_BNKGRP_MASK		0x3000000
 #define ECC_CEADDR1_BNKNR_MASK		0x70000
-#define ECC_CEADDR1_BLKNR_MASK		0xFFF
+#define ECC_CEADDR1_COL_MASK		0xFFF
 #define ECC_CEADDR1_BNKGRP_SHIFT	24
 #define ECC_CEADDR1_BNKNR_SHIFT		16
 
@@ -271,7 +271,6 @@
  * @bitpos:	Bit position.
  * @data:	Data causing the error.
  * @bankgrpnr:	Bank group number.
- * @blknr:	Block number.
  */
 struct ecc_error_info {
 	u32 row;
@@ -280,7 +279,6 @@ struct ecc_error_info {
 	u32 bitpos;
 	u32 data;
 	u32 bankgrpnr;
-	u32 blknr;
 };
 
 /**
@@ -433,7 +431,7 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
 					ECC_CEADDR1_BNKNR_SHIFT;
 	p->ceinfo.bankgrpnr = (regval &	ECC_CEADDR1_BNKGRP_MASK) >>
 					ECC_CEADDR1_BNKGRP_SHIFT;
-	p->ceinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
+	p->ceinfo.col = (regval & ECC_CEADDR1_COL_MASK);
 	p->ceinfo.data = readl(base + ECC_CSYND0_OFST);
 	edac_dbg(2, "ECCCSYN0: 0x%08X ECCCSYN1: 0x%08X ECCCSYN2: 0x%08X\n",
 		 readl(base + ECC_CSYND0_OFST), readl(base + ECC_CSYND1_OFST),
@@ -449,7 +447,7 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
 					ECC_CEADDR1_BNKGRP_SHIFT;
 	p->ueinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
 					ECC_CEADDR1_BNKNR_SHIFT;
-	p->ueinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
+	p->ueinfo.col = (regval & ECC_CEADDR1_COL_MASK);
 	p->ueinfo.data = readl(base + ECC_UESYND0_OFST);
 out:
 	spin_lock_irqsave(&priv->reglock, flags);
@@ -480,10 +478,9 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 		pinf = &p->ceinfo;
 		if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type:%s Row %d Bank %d BankGroup Number %d Block Number %d Bit Position: %d Data: 0x%08x",
-				 "CE", pinf->row, pinf->bank,
-				 pinf->bankgrpnr, pinf->blknr,
-				 pinf->bitpos, pinf->data);
+				 "DDR ECC error type:%s Row %d Col %d Bank %d BankGroup Number %d Bit Position: %d Data: 0x%08x",
+				 "CE", pinf->row, pinf->col, pinf->bank,
+				 pinf->bankgrpnr, pinf->bitpos, pinf->data);
 		} else {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
 				 "DDR ECC error type:%s Row %d Bank %d Col %d Bit Position: %d Data: 0x%08x",
@@ -500,9 +497,9 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 		pinf = &p->ueinfo;
 		if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type :%s Row %d Bank %d BankGroup Number %d Block Number %d",
-				 "UE", pinf->row, pinf->bank,
-				 pinf->bankgrpnr, pinf->blknr);
+				 "DDR ECC error type :%s Row %d Col %d Bank %d BankGroup Number %d",
+				 "UE", pinf->row, pinf->col, pinf->bank,
+				 pinf->bankgrpnr);
 		} else {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
 				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-- 
2.43.0


