Return-Path: <linux-kernel+bounces-77059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDADF8600A4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52EE2B23540
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4F0158D7E;
	Thu, 22 Feb 2024 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJRcBuLb"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E4C157E9E;
	Thu, 22 Feb 2024 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625668; cv=none; b=giQqpQrNUmpjdXq2z9vGD30GV7kJRNpwMqu+yyMniPFe/0zORJYjvpN6RjBEdtA7ggr9B4VfBCUdhuW99fpoSVMb3R+NS0kcNMdnb7ChlDs3SH26KgRLljPp0N74wToLuYsKSqF3JKNRYgPQeGkJiCkydfxB8M17hcHWYEwu9p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625668; c=relaxed/simple;
	bh=YzCbWthFnZoVbBTFuXK4fwe/Z//BvPsDRf2GmSlj8Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oUBT2kiuxP3jRFbYL9dpw2xXX63KF0yZzi/R9bGzBTDe7HCGh7ntQH4X9O8zThazTp9uuXLclbwZZDyCTA+RV4TCPq2PuzG5NOeNyP/rthie2IzAMIaRSNpwyL3xOIK9hjPTpMcxQw0+h8raN7/Yzrs6A8n4QX9d3dkMhxFbYYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJRcBuLb; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51294b40a52so82633e87.0;
        Thu, 22 Feb 2024 10:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708625664; x=1709230464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4DYckUBnyYVrA7U82dE/dSUDjWpjIV6W2v0tQMwU8w=;
        b=VJRcBuLbC1fm+9F1FAGEPr9128tyXq/dh9NxBT+YTw0JvLcwZ3r/Hcc9j63Rwts0Ku
         P0xqv+lZsg2ub79sCS+UW53ImfknduVuZW9TdaRtLNexHaecrsvZtpt/jMvPSiZDzE/t
         bneBOGF5OcxRGESzReYaW8qo7Uf6RtWEUbYbQtJuySrfVLLPzUK6d0DQ91DWfM/Z+wn+
         4S8S+ipH0liAA94QlkQjtSAGEfWyVb6VLCuzFL3P+1fC7+Q65Al338C8krfgChieLqYr
         EZLIV+0YjkqULqN+FXuQ8tHx1TBUHxrbza67+sj6r7LIYkciNqMCNOkWRX+1DvL8ijt+
         TdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708625664; x=1709230464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4DYckUBnyYVrA7U82dE/dSUDjWpjIV6W2v0tQMwU8w=;
        b=sz+5S4KXiRkhrSKLgGBhjFBmgoBI08uVVbCyQoyPkUU+OXr3uuCRTR4SDpRqBlrYG4
         yXNXEkXE3bDGjZ+LFzer1CMoAN6JPm22VZSi0S3TAMbgkehmY5TsR295dXuVmEtF0SZx
         J0ugqlz4bwa9ZFX7ek53oCt4pVYMHtwM9K6rGd5XELADtq+kHtJgMfzwe2uBTRsbq2db
         fwYwNt9dddCgCaZZQ9y4ngfxnNEXmB1ThF5I3lwBYTkjnI3dv8SxnOXxiB6kaAbBDBrN
         0Q583QDeS+gi8NXEo5kQqwrNI1o2hGj6f57b4oaGX4jQz23Oq7TKmZUV0ef0G6iHfv8r
         8+GA==
X-Forwarded-Encrypted: i=1; AJvYcCWgAJOpfE4WrLnCDr0pqRI0gXdy8CUhfutQrbeIFR7EqUJ1MtrhEdrfNlDrTZIITDQrwawrvXafqKfC2mZ0tiGYSM6srv+4jjI43RZ/z5t0jQYDqfVwLdTfC4N56BYqmpSruVuskCXExg==
X-Gm-Message-State: AOJu0YwXyF/b4C5gOT4vIc8It4M0urFy4MBEsGFaPscT3IIGxtsLDi09
	Yo/tNsu5eBS18YvcSk/D9WUXC3rp9BQaPoPJz4USkvjr5qmQF4Vk
X-Google-Smtp-Source: AGHT+IGJ/nsuVLRKc8FXj1WcjDvwWPQJBicyowF64SttTvyGSeLfyGnnezM8knKtZRAhXGeFbwZldw==
X-Received: by 2002:ac2:4ac2:0:b0:512:cd90:221d with SMTP id m2-20020ac24ac2000000b00512cd90221dmr1228096lfp.33.1708625664597;
        Thu, 22 Feb 2024 10:14:24 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id m15-20020a19520f000000b00512c8ef474asm1042885lfb.270.2024.02.22.10.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 10:14:24 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Manish Narani <manish.narani@xilinx.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Borislav Petkov <bp@suse.de>
Subject: [PATCH v5 02/20] EDAC/synopsys: Fix generic device type detection procedure
Date: Thu, 22 Feb 2024 21:12:47 +0300
Message-ID: <20240222181324.28242-3-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222181324.28242-1-fancer.lancer@gmail.com>
References: <20240222181324.28242-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

First of all the enum dev_type constants describe the memory DRAM chips
used at the stick, not the entire DQ-bus width (see the enumeration kdoc
for details). So what is returned from the zynqmp_get_dtype() function and
then specified to the dimm_info->dtype field is definitely incorrect.
Secondly the DRAM chips type has nothing to do with the data bus width
specified in the MSTR.data_bus_width CSR field. That CSR field just
determines the part of the whole DQ-bus currently used to access the data
from the all DRAM memory chips. So it doesn't indicate the individual
chips type. Thirdly the DRAM chips type can be determined only in case of
the DDR4 protocol by means of the MSTR.device_config field state (it is
supposed to be set by the system firmware). Finally the DW uMCTL2 DDRC ECC
capability doesn't depend on the memory chips type. Moreover it doesn't
depend on the utilized data bus width in runtime either. The IP-core
reference manual says in [1,2] that the ECC support can't be enabled
during the IP-core synthesizes for the DRAM data bus widths other than 16,
32 or 64.  At the same time the bus width mode (MSTR.data_bus_width)
doesn't change the ECC feature availability. Thus it was wrong to
determine the ECC state with respect to the DQ-bus width mode.

Fix all of the mistakes described above in the zynqmp_get_dtype() and
zynqmp_get_ecc_state() methods: specify actual DRAM chips data width only
for the DDR4 protocol and return that it's UNKNOWN in the rest of the
cases; determine ECC availability by the ECCCFG0.ecc_mode field state
only (that field can't be modified anyway if the IP-core was synthesized
with no ECC support).

[1] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
Databook, Version 3.91a, October 2020, p. 421.
[2] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
Databook, Version 3.91a, October 2020, p. 633.

Fixes: b500b4a029d5 ("EDAC, synopsys: Add ECC support for ZynqMP DDR controller")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v2:
- Include "linux/bitfield.h" header file to get the FIELD_GET macro
  definition. (@tbot)
---
 drivers/edac/synopsys_edac.c | 49 +++++++++++++++---------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 0168b05e3ca1..455d2fcfd8c1 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -674,26 +674,25 @@ static enum dev_type zynq_get_dtype(const void __iomem *base)
  */
 static enum dev_type zynqmp_get_dtype(const void __iomem *base)
 {
-	enum dev_type dt;
-	u32 width;
-
-	width = readl(base + CTRL_OFST);
-	width = (width & ECC_CTRL_BUSWIDTH_MASK) >> ECC_CTRL_BUSWIDTH_SHIFT;
-	switch (width) {
-	case DDRCTL_EWDTH_16:
-		dt = DEV_X2;
-		break;
-	case DDRCTL_EWDTH_32:
-		dt = DEV_X4;
-		break;
-	case DDRCTL_EWDTH_64:
-		dt = DEV_X8;
-		break;
-	default:
-		dt = DEV_UNKNOWN;
+	u32 regval;
+
+	regval = readl(base + CTRL_OFST);
+	if (!(regval & MEM_TYPE_DDR4))
+		return DEV_UNKNOWN;
+
+	regval = (regval & DDRC_MSTR_CFG_MASK) >> DDRC_MSTR_CFG_SHIFT;
+	switch (regval) {
+	case DDRC_MSTR_CFG_X4_MASK:
+		return DEV_X4;
+	case DDRC_MSTR_CFG_X8_MASK:
+		return DEV_X8;
+	case DDRC_MSTR_CFG_X16_MASK:
+		return DEV_X16;
+	case DDRC_MSTR_CFG_X32_MASK:
+		return DEV_X32;
 	}
 
-	return dt;
+	return DEV_UNKNOWN;
 }
 
 /**
@@ -730,19 +729,11 @@ static bool zynq_get_ecc_state(void __iomem *base)
  */
 static bool zynqmp_get_ecc_state(void __iomem *base)
 {
-	enum dev_type dt;
-	u32 ecctype;
+	u32 regval;
 
-	dt = zynqmp_get_dtype(base);
-	if (dt == DEV_UNKNOWN)
-		return false;
+	regval = readl(base + ECC_CFG0_OFST) & SCRUB_MODE_MASK;
 
-	ecctype = readl(base + ECC_CFG0_OFST) & SCRUB_MODE_MASK;
-	if ((ecctype == SCRUB_MODE_SECDED) &&
-	    ((dt == DEV_X2) || (dt == DEV_X4) || (dt == DEV_X8)))
-		return true;
-
-	return false;
+	return (regval == SCRUB_MODE_SECDED);
 }
 
 /**
-- 
2.43.0


