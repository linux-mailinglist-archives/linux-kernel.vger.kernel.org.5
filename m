Return-Path: <linux-kernel+bounces-165255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC72B8B8A1E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6D2DB22679
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E25112E1C6;
	Wed,  1 May 2024 12:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3QKPWsC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8B422313;
	Wed,  1 May 2024 12:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714566914; cv=none; b=qRd07diz6iF3owWZ7hhfMwaMR8sJn6ObjBVhYK/l8BuXL0NceCqBeU9ZzmhT0AsF5R6C6hNBm2p16fD80qBJh4ifVoBXGoWaouR50HrElhUQx+8VaHZw4Ztyy8Oo/qZ7UqpIyVfahcVWV1Odp5EjvwreXOqDLRUw9pEyEld9Rsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714566914; c=relaxed/simple;
	bh=38GjNkh+bP9qOQWBippcQ8WykGLhFZV02w+RzMyVR7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fiezs14/oN/dsSQNsUu5ugA0/45X2fib9gas3RjOAj8WvXzmAhSxL/Z9Lw1kSkYc/lb60rQbHzpuLipA2TeKz16+mdd4FanhoDPOebV/RUHXBVBdfBapaLQf/KxwxGIqdbUjLv6N5ZNCSkCQWPqEZxIiDg9/FW+npIjbEojt/S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3QKPWsC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3485DC4AF1C;
	Wed,  1 May 2024 12:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714566914;
	bh=38GjNkh+bP9qOQWBippcQ8WykGLhFZV02w+RzMyVR7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A3QKPWsCEt+N/9hYwDUIfmI03tymgX5lslI9OoJrD9pGWK1jegwFxPi7Ud11B4BJX
	 nxJMsZGmXdpkcxkQgFWHx5HkK75pakwIq2vMnVUTc23kx2pfB6UHVLIA0piUed7klh
	 Nk55tOh8w+M/n+87TIOPYXkG5Q4EzV/+2XJ/HyzfyueKuJB1fvxtM2OLflev+mEMqp
	 y0KqvZUgFDmtuibhM2Y9CIg7FjA2MwsWyB3u8PhyNmItzOy7wPCZoXi8Ssouuk4vvo
	 DRyYxgiwyDWOrK39AnptFeDnKe72k/c0CgedpFuz1pDv0jXQ2LkPflIroAAuP1FXjZ
	 0vXbE6o0gpZxg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1s29B7-000000001l9-0iYI;
	Wed, 01 May 2024 14:35:17 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 5/5] Bluetooth: qca: clean up defines
Date: Wed,  1 May 2024 14:34:56 +0200
Message-ID: <20240501123456.6712-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240501123456.6712-1-johan+linaro@kernel.org>
References: <20240501123456.6712-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up the QCA driver defines by dropping redundant parentheses around
values and making sure they are aligned (using tabs only).

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/bluetooth/btqca.h | 60 +++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index 215433fd76a1..bb5207d7a8c7 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -5,33 +5,33 @@
  *  Copyright (c) 2015 The Linux Foundation. All rights reserved.
  */
 
-#define EDL_PATCH_CMD_OPCODE		(0xFC00)
-#define EDL_NVM_ACCESS_OPCODE		(0xFC0B)
-#define EDL_WRITE_BD_ADDR_OPCODE	(0xFC14)
-#define EDL_PATCH_CMD_LEN		(1)
-#define EDL_PATCH_VER_REQ_CMD		(0x19)
-#define EDL_PATCH_TLV_REQ_CMD		(0x1E)
-#define EDL_GET_BUILD_INFO_CMD		(0x20)
-#define EDL_GET_BID_REQ_CMD			(0x23)
-#define EDL_NVM_ACCESS_SET_REQ_CMD	(0x01)
-#define EDL_PATCH_CONFIG_CMD		(0x28)
-#define MAX_SIZE_PER_TLV_SEGMENT	(243)
-#define QCA_PRE_SHUTDOWN_CMD		(0xFC08)
-#define QCA_DISABLE_LOGGING		(0xFC17)
-
-#define EDL_CMD_REQ_RES_EVT		(0x00)
-#define EDL_PATCH_VER_RES_EVT		(0x19)
-#define EDL_APP_VER_RES_EVT		(0x02)
-#define EDL_TVL_DNLD_RES_EVT		(0x04)
-#define EDL_CMD_EXE_STATUS_EVT		(0x00)
-#define EDL_SET_BAUDRATE_RSP_EVT	(0x92)
-#define EDL_NVM_ACCESS_CODE_EVT		(0x0B)
-#define EDL_PATCH_CONFIG_RES_EVT	(0x00)
-#define QCA_DISABLE_LOGGING_SUB_OP	(0x14)
+#define EDL_PATCH_CMD_OPCODE		0xFC00
+#define EDL_NVM_ACCESS_OPCODE		0xFC0B
+#define EDL_WRITE_BD_ADDR_OPCODE	0xFC14
+#define EDL_PATCH_CMD_LEN		1
+#define EDL_PATCH_VER_REQ_CMD		0x19
+#define EDL_PATCH_TLV_REQ_CMD		0x1E
+#define EDL_GET_BUILD_INFO_CMD		0x20
+#define EDL_GET_BID_REQ_CMD		0x23
+#define EDL_NVM_ACCESS_SET_REQ_CMD	0x01
+#define EDL_PATCH_CONFIG_CMD		0x28
+#define MAX_SIZE_PER_TLV_SEGMENT	243
+#define QCA_PRE_SHUTDOWN_CMD		0xFC08
+#define QCA_DISABLE_LOGGING		0xFC17
+
+#define EDL_CMD_REQ_RES_EVT		0x00
+#define EDL_PATCH_VER_RES_EVT		0x19
+#define EDL_APP_VER_RES_EVT		0x02
+#define EDL_TVL_DNLD_RES_EVT		0x04
+#define EDL_CMD_EXE_STATUS_EVT		0x00
+#define EDL_SET_BAUDRATE_RSP_EVT	0x92
+#define EDL_NVM_ACCESS_CODE_EVT		0x0B
+#define EDL_PATCH_CONFIG_RES_EVT	0x00
+#define QCA_DISABLE_LOGGING_SUB_OP	0x14
 
 #define EDL_TAG_ID_BD_ADDR		2
-#define EDL_TAG_ID_HCI			(17)
-#define EDL_TAG_ID_DEEP_SLEEP		(27)
+#define EDL_TAG_ID_HCI			17
+#define EDL_TAG_ID_DEEP_SLEEP		27
 
 #define QCA_WCN3990_POWERON_PULSE	0xFC
 #define QCA_WCN3990_POWEROFF_PULSE	0xC0
@@ -39,7 +39,7 @@
 #define QCA_HCI_CC_OPCODE		0xFC00
 #define QCA_HCI_CC_SUCCESS		0x00
 
-#define QCA_WCN3991_SOC_ID		(0x40014320)
+#define QCA_WCN3991_SOC_ID		0x40014320
 
 /* QCA chipset version can be decided by patch and SoC
  * version, combination with upper 2 bytes from SoC
@@ -48,11 +48,11 @@
 #define get_soc_ver(soc_id, rom_ver)	\
 	((le32_to_cpu(soc_id) << 16) | (le16_to_cpu(rom_ver)))
 
-#define QCA_HSP_GF_SOC_ID			0x1200
-#define QCA_HSP_GF_SOC_MASK			0x0000ff00
+#define QCA_HSP_GF_SOC_ID		0x1200
+#define QCA_HSP_GF_SOC_MASK		0x0000ff00
 
 enum qca_baudrate {
-	QCA_BAUDRATE_115200 	= 0,
+	QCA_BAUDRATE_115200	= 0,
 	QCA_BAUDRATE_57600,
 	QCA_BAUDRATE_38400,
 	QCA_BAUDRATE_19200,
@@ -71,7 +71,7 @@ enum qca_baudrate {
 	QCA_BAUDRATE_1600000,
 	QCA_BAUDRATE_3200000,
 	QCA_BAUDRATE_3500000,
-	QCA_BAUDRATE_AUTO 	= 0xFE,
+	QCA_BAUDRATE_AUTO	= 0xFE,
 	QCA_BAUDRATE_RESERVED
 };
 
-- 
2.43.2


