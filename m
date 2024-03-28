Return-Path: <linux-kernel+bounces-123722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1EA890D15
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE751C300D7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F8A1422AE;
	Thu, 28 Mar 2024 22:07:09 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167DA1411FE;
	Thu, 28 Mar 2024 22:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663629; cv=none; b=heZ8DxmKUqSr2NENizoNIusJ6O0YfDySGWAA/8kjojLN+7JDn2NUMd8w8G/vruvCWHteGHQU4qIOd+0+P4nt7SUyEl/oF6QrFveUB3qdHa9VaPPXb3Du1+LxCCeRxKJou/BFdpCaiBRItl+cguiAxFkHYJcE+tuHC5gGXVHzZA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663629; c=relaxed/simple;
	bh=E1wNP0x2B+VCiO9Wongzl3US5X5oerxX0ktMb+ESJz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SNtUbSVMyuiRXxGN0mbaHENd3bfaT5LvH7LHMeEZLxUwyMdRYTYpIB8Sc/K2Ja8FQMP07gZMa6anx5slSVrc8XzjQ2HKt8MyrDAXYBtAu3523dfa4qPHk1PD6B+Q7u6tLDcpYEhL9qPk/MYEO6gn5G/yrADMmoiVeAMtaadAzPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC63C433F1;
	Thu, 28 Mar 2024 22:07:07 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:05:55 +0100
Subject: [PATCH 17/52] USB: serial: ipaq: drop driver owner initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-17-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=700;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=E1wNP0x2B+VCiO9Wongzl3US5X5oerxX0ktMb+ESJz0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenJsELtoiGLCKxtXhuYoU3GNAX5SRtN5PeAv
 xdCbqBZTlKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXpyQAKCRDBN2bmhouD
 1/jeD/4htcBjCBq8VZl6K1QIgjgbI2rHaDpeHBPPq/hGk+V+kNP/bXq3jFKZK5yH1lg+Zr3MGqm
 5kb9hX+a9SPrWZ0eQd31HKiMLWmc5gv5SkrlyL4V0RfkzaT/K4c1lgL8Na8YYE73UpAbYhtd5G8
 w5sqvtfMpTeCBDwHj8vhvt4tlPOT7M26GzJWONrbioXbatfO/3It613+HHqvA+VoTsD5YqUEk3d
 pwQCth4zU9NoTVx39k8Szo4gxQiVqlhoV1ns52au3DVwbTYJ6ZtC5sfU7XIBZ0SAH+2YDbAhC3V
 h2MTnSf5Xy4Y/+SM5V5hupWsiOv7RynJFUxl/LaCMzE2/rwyDb9fRvZjv7A4nIgEDcfPtoeYHiC
 kwwcFA19z5j1wuf80KtGb3XoMeimlgEOwA6Q4GNEO6JpyTlMSU+WqUmf4qBHcFunk3RDEnei3JM
 g2YnyRfGOJhFu5guF6ef+Etk90YaGZo9qjcKn2vtX486R4p7/ry06a5Y/csMi8DwbCFRRD+AwFQ
 oJyv5yWdnNY6CNTGW0BUgi+jbA5vNDHoW/QFSUoJoX9lrkTWR09Wt+QC/OAr/4Li5ONoTLIZFNk
 qJSimdNgh2/rdkBXk+X6kaMIaTxlLJvhJp4969/HtIMqLLnMk0YOz3F8dC41STwgJpqZTAmBEwg
 NvUHLjiDQYxZncA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/ipaq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/ipaq.c b/drivers/usb/serial/ipaq.c
index e11441bac44f..3c6a9b9b9c2b 100644
--- a/drivers/usb/serial/ipaq.c
+++ b/drivers/usb/serial/ipaq.c
@@ -496,7 +496,6 @@ MODULE_DEVICE_TABLE(usb, ipaq_id_table);
 /* All of the device info needed for the Compaq iPAQ */
 static struct usb_serial_driver ipaq_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"ipaq",
 	},
 	.description =		"PocketPC PDA",

-- 
2.34.1


