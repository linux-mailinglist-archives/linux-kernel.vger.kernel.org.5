Return-Path: <linux-kernel+bounces-77073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 858E08600E4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D0F28281A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9054315DBA2;
	Thu, 22 Feb 2024 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQXOyUwX"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A58115CD77;
	Thu, 22 Feb 2024 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625683; cv=none; b=mF/HPC0cZ5AeISElinUCCe5JT/ncMD5P+svDlnreCb0JSNppXvJafKvAb95uKAswh/VxBiLVtLi3JjS1Jdun2tYZZKsh0UO+u3JNR9I08dNtQHTihRWSfobXy16ls2BcJVSiHA8LGee7fcZ6empNzjkr1Btq4aCRJMgMONnosRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625683; c=relaxed/simple;
	bh=lWOXT7NA1+p6N2d2CSA2dMeAJHOs07TN1uQkinNb1a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eWTQxLl52k1vjtTo4DtyrfrMUzdFn7RbcZN907IySisokK8NOtc86AATBmqH30qdQAbJBPvaF3LXEzb5n1eIJGGiXvZcdCtualsok2Mnzn8nN3PcoggJzDUuAR28P2YH4r971CEJBgCGllrpWljxo8TfNl5a+4ZVywr/Q9GdfgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQXOyUwX; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512bc0e8ce1so111992e87.0;
        Thu, 22 Feb 2024 10:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708625680; x=1709230480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzoe6r6O1SQZpxBPwnEmbzP/LY9Wg9dUZAFh860tCdU=;
        b=IQXOyUwXfw5P+5bwa/pVdJCW5sWDjEw2//iOdYMfQofGh6f8XkE6bpbVtkeenDuoVf
         SNM/SXKmezVHGja+1xbDpKnZ5A8rbTgPIHXa+7PmS8SXj7QTcVkYpPdYXNU/mSqp0G9P
         t/WnOh0j6fb0YmHUelwzjKyAlZe4j1FfijFJktR0M1ffg9iEOHHb27RZ3MfehGX4QEm4
         DL31aBn73/mLBGkdeQySs4tj616JPeMJXxAPPbKLLtk0ILBTm9dKcVZtHV9v76goV2ip
         5rYGeruLZ7kS3tfFvywBlXqj1EzNcibLDcYCfAlEWOZgpxWH4+f5imIDX3EO66xjOGLi
         QbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708625680; x=1709230480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzoe6r6O1SQZpxBPwnEmbzP/LY9Wg9dUZAFh860tCdU=;
        b=xGXrvsTo4wbYvWXZXjOkze0M+DYUIu+RJvY06Q8Dfi8uQLc5tLqj9mVvwFz9nOneJ8
         6iXlTYp8xq/ii4enhpXvhgNVLU6XwYw1k2Rvx8plDHPPL3adc6BWQVz3tjIHytBWWweO
         a4koTBj4Gspm/q1fHpWmp0TUM7GtGYsPIEavc9Apc+/SHlJlIOCKV2RlbLeu0dpfstF3
         eBfXvhY91P5VYWMHIVj14UJ4o08FOdnQlKFIsJjdkBYykvrlELRgHMVrd0DgaNZrhI/E
         L9nzEqfoRIi7HouApfqt/+bugPKNYLuYc0NdgdhZM2N0tUlNyPjZVMIW7zbx/xRus9ww
         LxLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyfmqc7Z0Fdqju43sqevCPPZ7yf2Pv3dpA3k3NTjDZvJ5AUWDnnQCYPrH/+86CNO8JcHhWjgV6MlTzn9ms91RFtXnnuGxc3roTrOH2H53BlARo2FrVo44xcJJF/ptsIbmeRDbTUvvUWQ==
X-Gm-Message-State: AOJu0YzJRyXmC6WFpk/z/imVuUKkFd1n4myvEhn8OIH6+j9iNxtWlbB8
	b2XVHt6GPzt88nendmOEY+YiV2+QLnHkKb0H/wkFOcd9n7eAKArv
X-Google-Smtp-Source: AGHT+IGcYWp+ryzNnOE+1eySElC1nrZpk/ByoTpbeCgHQM0hU5MtdJZ4f5r0RBCPz3VjbsW6XtHv6A==
X-Received: by 2002:a05:6512:1384:b0:512:cb9f:a25b with SMTP id fc4-20020a056512138400b00512cb9fa25bmr6050995lfb.28.1708625680264;
        Thu, 22 Feb 2024 10:14:40 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id y10-20020ac255aa000000b00512c531ffe4sm1081849lfg.180.2024.02.22.10.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 10:14:39 -0800 (PST)
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
Subject: [PATCH v5 11/20] EDAC/synopsys: Shorten out struct ecc_error_info.bankgrpnr field name
Date: Thu, 22 Feb 2024 21:12:56 +0300
Message-ID: <20240222181324.28242-12-fancer.lancer@gmail.com>
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

None of the ecc_error_info structure fields have "nr" suffix even though
each of them do represent some number (row number, column number, bank
number). Drop the suffix from the bankgrpnr field name for the sake of
unification then. Similarly drop the word "Number" from the CE/UE error
messages too since it doesn't give any helpful info there.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 6ca119459bd3..b0ff831287f5 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -268,17 +268,17 @@
  * @row:	Row number.
  * @col:	Column number.
  * @bank:	Bank number.
+ * @bankgrp:	Bank group number.
  * @bitpos:	Bit position.
  * @data:	Data causing the error.
- * @bankgrpnr:	Bank group number.
  */
 struct ecc_error_info {
 	u32 row;
 	u32 col;
 	u32 bank;
+	u32 bankgrp;
 	u32 bitpos;
 	u32 data;
-	u32 bankgrpnr;
 };
 
 /**
@@ -429,7 +429,7 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
 	regval = readl(base + ECC_CEADDR1_OFST);
 	p->ceinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
 					ECC_CEADDR1_BNKNR_SHIFT;
-	p->ceinfo.bankgrpnr = (regval &	ECC_CEADDR1_BNKGRP_MASK) >>
+	p->ceinfo.bankgrp = (regval & ECC_CEADDR1_BNKGRP_MASK) >>
 					ECC_CEADDR1_BNKGRP_SHIFT;
 	p->ceinfo.col = (regval & ECC_CEADDR1_COL_MASK);
 	p->ceinfo.data = readl(base + ECC_CSYND0_OFST);
@@ -443,7 +443,7 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
 	regval = readl(base + ECC_UEADDR0_OFST);
 	p->ueinfo.row = (regval & ECC_CEADDR0_RW_MASK);
 	regval = readl(base + ECC_UEADDR1_OFST);
-	p->ueinfo.bankgrpnr = (regval & ECC_CEADDR1_BNKGRP_MASK) >>
+	p->ueinfo.bankgrp = (regval & ECC_CEADDR1_BNKGRP_MASK) >>
 					ECC_CEADDR1_BNKGRP_SHIFT;
 	p->ueinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
 					ECC_CEADDR1_BNKNR_SHIFT;
@@ -478,9 +478,9 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 		pinf = &p->ceinfo;
 		if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type:%s Row %d Col %d Bank %d BankGroup Number %d Bit Position: %d Data: 0x%08x",
+				 "DDR ECC error type:%s Row %d Col %d Bank %d Bank Group %d Bit Position: %d Data: 0x%08x",
 				 "CE", pinf->row, pinf->col, pinf->bank,
-				 pinf->bankgrpnr, pinf->bitpos, pinf->data);
+				 pinf->bankgrp, pinf->bitpos, pinf->data);
 		} else {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
 				 "DDR ECC error type:%s Row %d Bank %d Col %d Bit Position: %d Data: 0x%08x",
@@ -497,9 +497,9 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 		pinf = &p->ueinfo;
 		if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type :%s Row %d Col %d Bank %d BankGroup Number %d",
+				 "DDR ECC error type :%s Row %d Col %d Bank %d Bank Group %d",
 				 "UE", pinf->row, pinf->col, pinf->bank,
-				 pinf->bankgrpnr);
+				 pinf->bankgrp);
 		} else {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
 				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-- 
2.43.0


