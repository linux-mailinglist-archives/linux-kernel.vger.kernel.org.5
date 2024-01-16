Return-Path: <linux-kernel+bounces-28144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C7482FAC6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A937E1F27E45
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A9A15AABA;
	Tue, 16 Jan 2024 20:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZxmC1/r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BF315AABC;
	Tue, 16 Jan 2024 20:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435269; cv=none; b=PoUtmG0+0kOpLVwDMVGPlLQET6wsIcwnbj4tGhLlP7P3JoEmWhnl4YINJ3J6rRlSPZzy1tlkR954ScPasX2ljZmXkmQO10tEsBZQ1jupSj0r1wdd0RbSikE9Wd+gz+YZ9JHTDBEgBZaWBGwv0S+ZQggrZleWCYLr5oJFEHJ8H6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435269; c=relaxed/simple;
	bh=aNVForKxkPc54LZTD2rNGc5TEq3jX47b1epbe6q74ZU=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=evllfCcNClATTJuYdeCuAnTbOBIKpn+C/JOj7OcQG//CnGc7c1QhsKksowHQ7QUmdoSIm1qK/wRR34nwSu7XsdgA1SfMaeQDhBz1Jz2/d+nTIsUGPxR+DA5BKo9iVshTePDO2MyXL9xz8khVs9TgITBeigBz7ovUGFvRHag8IAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZxmC1/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747B0C433F1;
	Tue, 16 Jan 2024 20:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435268;
	bh=aNVForKxkPc54LZTD2rNGc5TEq3jX47b1epbe6q74ZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PZxmC1/rpbVecbaMpAjnS0ZVohGvGroOVjLGaBPJuW1sMDgBA0mGPO2JV7Qi5aI0S
	 8jNdaJNrok1nL++umbRbpGTAuUrFJh8K5+MMoIxuf6fp6drBtTNWRDGvJ9GKrozvuG
	 cuhax3AzAXPUBYI/SPOlZp4HSKbqS+nVaIO32jHN6h4dxJUHVIkHGNcUQMbUzsgWId
	 xwjA1hxtxQVxCFqlaLYv8INKJfIXk5uqpYONfSX52TSqUKftzE3D5Z5mXmu1HDtsQx
	 p99PPjku84cNwraXiAM7GIJpG3jvaFiJQ85UHDndgPQP0rBmhC5zOdpcPUz9jy4GMY
	 eQ8epkCOn32YQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: ching Huang <ching2048@areca.com.tw>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	jejb@linux.ibm.com,
	xiangyang3@huawei.com,
	bhelgaas@google.com,
	bvanassche@acm.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 08/44] scsi: arcmsr: Support new PCI device IDs 1883 and 1886
Date: Tue, 16 Jan 2024 14:59:37 -0500
Message-ID: <20240116200044.258335-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200044.258335-1-sashal@kernel.org>
References: <20240116200044.258335-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
Content-Transfer-Encoding: 8bit

From: ching Huang <ching2048@areca.com.tw>

[ Upstream commit 41c8a1a1e90fa4721f856bf3cf71211fd16d6434 ]

Add support for Areca RAID controllers with PCI device IDs 1883 and 1886.

Signed-off-by: ching Huang <ching2048@areca.com.tw>
Link: https://lore.kernel.org/r/7732e743eaad57681b1552eec9c6a86c76dbe459.camel@areca.com.tw
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/arcmsr/arcmsr.h     | 4 ++++
 drivers/scsi/arcmsr/arcmsr_hba.c | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/scsi/arcmsr/arcmsr.h b/drivers/scsi/arcmsr/arcmsr.h
index 5d054d5c70a5..f2e587e66e19 100644
--- a/drivers/scsi/arcmsr/arcmsr.h
+++ b/drivers/scsi/arcmsr/arcmsr.h
@@ -77,9 +77,13 @@ struct device_attribute;
 #ifndef PCI_DEVICE_ID_ARECA_1203
 #define PCI_DEVICE_ID_ARECA_1203	0x1203
 #endif
+#ifndef PCI_DEVICE_ID_ARECA_1883
+#define PCI_DEVICE_ID_ARECA_1883	0x1883
+#endif
 #ifndef PCI_DEVICE_ID_ARECA_1884
 #define PCI_DEVICE_ID_ARECA_1884	0x1884
 #endif
+#define PCI_DEVICE_ID_ARECA_1886_0	0x1886
 #define PCI_DEVICE_ID_ARECA_1886	0x188A
 #define	ARCMSR_HOURS			(1000 * 60 * 60 * 4)
 #define	ARCMSR_MINUTES			(1000 * 60 * 60)
diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 9294a2c677b3..199b102f31a2 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -208,8 +208,12 @@ static struct pci_device_id arcmsr_device_id_table[] = {
 		.driver_data = ACB_ADAPTER_TYPE_A},
 	{PCI_DEVICE(PCI_VENDOR_ID_ARECA, PCI_DEVICE_ID_ARECA_1880),
 		.driver_data = ACB_ADAPTER_TYPE_C},
+	{PCI_DEVICE(PCI_VENDOR_ID_ARECA, PCI_DEVICE_ID_ARECA_1883),
+		.driver_data = ACB_ADAPTER_TYPE_C},
 	{PCI_DEVICE(PCI_VENDOR_ID_ARECA, PCI_DEVICE_ID_ARECA_1884),
 		.driver_data = ACB_ADAPTER_TYPE_E},
+	{PCI_DEVICE(PCI_VENDOR_ID_ARECA, PCI_DEVICE_ID_ARECA_1886_0),
+		.driver_data = ACB_ADAPTER_TYPE_F},
 	{PCI_DEVICE(PCI_VENDOR_ID_ARECA, PCI_DEVICE_ID_ARECA_1886),
 		.driver_data = ACB_ADAPTER_TYPE_F},
 	{0, 0}, /* Terminating entry */
@@ -4701,9 +4705,11 @@ static const char *arcmsr_info(struct Scsi_Host *host)
 	case PCI_DEVICE_ID_ARECA_1680:
 	case PCI_DEVICE_ID_ARECA_1681:
 	case PCI_DEVICE_ID_ARECA_1880:
+	case PCI_DEVICE_ID_ARECA_1883:
 	case PCI_DEVICE_ID_ARECA_1884:
 		type = "SAS/SATA";
 		break;
+	case PCI_DEVICE_ID_ARECA_1886_0:
 	case PCI_DEVICE_ID_ARECA_1886:
 		type = "NVMe/SAS/SATA";
 		break;
-- 
2.43.0


