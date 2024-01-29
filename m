Return-Path: <linux-kernel+bounces-43333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AA2841242
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F966286295
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDD015B2FC;
	Mon, 29 Jan 2024 18:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaOkBNFy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6B77604D;
	Mon, 29 Jan 2024 18:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553335; cv=none; b=dfwsDBd8r0TTzABwEOK/CV+zqvz3tkv4AK06cI2A0iwV7QXTMMo1tFsTjmSjZG7raM7cYSug14jaw0NJV/cBZFQ9haI5q2iF5fKJyg91YUsgnmGVs+LCe9IT0b4VV28Q5beXi7z0yfg8q0Hit7MjmBmJzKVza/NdwedAEBcLjVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553335; c=relaxed/simple;
	bh=RWFv5O6mjvQd+XT2CxCk6ZTbTdaqnjyK0fjydI5p3Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iqxo98wZITad4mrM7h0E1cwQHu5aRn883fQtaJLTKEobizucPyWSJB9DuWA2jKEIZWxJZYQYr+v3g/8r9cCm1BYARqz2Zyvq9tKYnzdCx2nfySRTZu/Or0sl6EnPZgIBTaHvRQ+98MOzZUVrI+gsJbluSVVUIM1DMroIeFJL4BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaOkBNFy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AEE1C433F1;
	Mon, 29 Jan 2024 18:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706553334;
	bh=RWFv5O6mjvQd+XT2CxCk6ZTbTdaqnjyK0fjydI5p3Pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gaOkBNFyHz3hyNVXx2LAeqhxTguDnj1nJ/nQGf7tMvwB+j0LZ26Nbi4mX8fkRQfeh
	 ADeaAJuPoRZCpdsu4oIE9poPBbqcqij1ihNt6sq00dzQoAgQsDKYaXjMZJxJ1VW9Y/
	 fxO7aNAebK4YjQZoJXgJUKnns0belbQI7bWB54N3RnyDap6dsUr7DfaWh9oZUvCClp
	 HoVzKnpTw+yNRnKX2JtsxFtb65G4tI+F3zPNT41A/hw6yrmEOdLrnuHGhDWAgfFc4B
	 CneiQES0/c1gJGsYMFeTiBuDcSWotHpnqIy9jVrMlRTTnq9c5hvuP3bZEjOPNb5hrE
	 LbS/31CXDDCkw==
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
Subject: [PATCH AUTOSEL 6.6 02/10] scsi: smartpqi: Add new controller PCI IDs
Date: Mon, 29 Jan 2024 13:35:10 -0500
Message-ID: <20240129183530.464274-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129183530.464274-1-sashal@kernel.org>
References: <20240129183530.464274-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.14
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


