Return-Path: <linux-kernel+bounces-43321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7467A84121C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E032B2517F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97D3157055;
	Mon, 29 Jan 2024 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBaflHIP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50D62E84D;
	Mon, 29 Jan 2024 18:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553286; cv=none; b=iFwjrjsZQE9y49qqPVCqs2qJPEWMSQD+7Fbm8RVmY7/TJvTXrTwLGOXIaPDtDlB3TgTFh/Z5LnEp54Gg1tQMBERwQ+ijdS12/yIeBvsXoDWNwfCpReVAYXAzIcQ8dpD8C+tw314/5wsy2PWwY9G+Sj7JdYvt4+voRajcYlRvcqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553286; c=relaxed/simple;
	bh=RWFv5O6mjvQd+XT2CxCk6ZTbTdaqnjyK0fjydI5p3Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMq7F7X1q3SCRNCoXVxYSXadjmFAFBg0N+dMghtFFBIlidhrVb0/JBWNebrRV4bkWLweMreCPmx7sDyhO8FFI65lyx9eUU5FLTp9hbtJ3vAtmt7vPzUCvwvlgKuM+hxkTN8AUVK4sPe21B+54Wy0R5niw5tzwmq3XR7XmyAnYfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBaflHIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5216C43399;
	Mon, 29 Jan 2024 18:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706553285;
	bh=RWFv5O6mjvQd+XT2CxCk6ZTbTdaqnjyK0fjydI5p3Pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rBaflHIPitwKDsR38tZUIdaN4rey8g09pWsnZcPvC/GIiL8byvTSeLHOt/B02ZYok
	 OykWK/6SyZHKcyfM5P7k4vuUT+CMIx9L8Gps6+q/OvhoJFyC+ZPJHJBW/aHlQ0sOlQ
	 TIvl77N0Grx/GhFDl0pe3Qujt/0L+RCjhRjfkOcbgIsx8gB2LeUZpPcbcFGrRRcqwv
	 G4GnZ1kGNT+jmn/yMjsKAeFjmHV8RTO+j9Ogje/kI9xHgNF0V7vZU+L8dbzoOyMRd1
	 ipPn8uDsBOzMwvkf9WvKz1lyOLnDccw9F2npt1CRVES36laRt3ZsByciOtQhELFpfu
	 BAIQ9D2uAVCeg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Strahan <david.strahan@microchip.com>,
	Murthy Bhat <Murthy.Bhat@microchip.com>,
	Mahesh Rajashekhara <mahesh.rajashekhara@microchip.com>,
	Scott Teel <scott.teel@microchip.com>,
	Scott Benesh <scott.benesh@microchip.com>,
	Mike McGowen <mike.mcgowen@microchip.com>,
	Kevin Barnett <kevin.barnett@microchip.com>,
	Don Brace <don.brace@microchip.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	jejb@linux.ibm.com,
	storagedev@microchip.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 02/12] scsi: smartpqi: Add new controller PCI IDs
Date: Mon, 29 Jan 2024 13:34:11 -0500
Message-ID: <20240129183440.463998-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129183440.463998-1-sashal@kernel.org>
References: <20240129183440.463998-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.2
Content-Transfer-Encoding: 8bit

From: David Strahan <david.strahan@microchip.com>

[ Upstream commit c6d5aa44eaf6d119f9ceb3bfc7d22405ac04232a ]

All PCI ID entries in Hex.

Add PCI IDs for Cisco controllers:
                                                VID  / DID  / SVID / SDID
                                                ----   ----   ----   ----
        Cisco 24G TriMode M1 RAID 4GB FBWC 32D  9005 / 028f / 1137 / 02f8
        Cisco 24G TriMode M1 RAID 4GB FBWC 16D  9005 / 028f / 1137 / 02f9
        Cisco 24G TriMode M1 HBA 16D            9005 / 028f / 1137 / 02fa

Add PCI IDs for CloudNine controllers:
                                                VID  / DID  / SVID / SDID
                                                ----   ----   ----   ----
        SmartRAID P7604N-16i                    9005 / 028f / 1f51 / 100e
        SmartRAID P7604N-8i                     9005 / 028f / 1f51 / 100f
        SmartRAID P7504N-16i                    9005 / 028f / 1f51 / 1010
        SmartRAID P7504N-8i                     9005 / 028f / 1f51 / 1011
        SmartRAID P7504N-8i                     9005 / 028f / 1f51 / 1043
        SmartHBA  P6500-8i                      9005 / 028f / 1f51 / 1044
        SmartRAID P7504-8i                      9005 / 028f / 1f51 / 1045

Reviewed-by: Murthy Bhat <Murthy.Bhat@microchip.com>
Reviewed-by: Mahesh Rajashekhara <mahesh.rajashekhara@microchip.com>
Reviewed-by: Scott Teel <scott.teel@microchip.com>
Reviewed-by: Scott Benesh <scott.benesh@microchip.com>
Reviewed-by: Mike McGowen <mike.mcgowen@microchip.com>
Reviewed-by: Kevin Barnett <kevin.barnett@microchip.com>
Signed-off-by: David Strahan <david.strahan@microchip.com>
Signed-off-by: Don Brace <don.brace@microchip.com>
Link: https://lore.kernel.org/r/20231219193653.277553-2-don.brace@microchip.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/smartpqi/smartpqi_init.c | 40 +++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 9a58df9312fa..d56201120087 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -10142,6 +10142,18 @@ static const struct pci_device_id pqi_pci_id_table[] = {
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 				0x1014, 0x0718)
 	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1137, 0x02f8)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1137, 0x02f9)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1137, 0x02fa)
+	},
 	{
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 				0x1e93, 0x1000)
@@ -10198,6 +10210,34 @@ static const struct pci_device_id pqi_pci_id_table[] = {
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 				0x1f51, 0x100a)
 	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1f51, 0x100e)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1f51, 0x100f)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1f51, 0x1010)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1f51, 0x1011)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1f51, 0x1043)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1f51, 0x1044)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1f51, 0x1045)
+	},
 	{
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       PCI_ANY_ID, PCI_ANY_ID)
-- 
2.43.0


