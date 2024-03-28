Return-Path: <linux-kernel+bounces-123739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D37890D39
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51F3F1C306F1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE2D14601C;
	Thu, 28 Mar 2024 22:07:44 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC6413C3C5;
	Thu, 28 Mar 2024 22:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663663; cv=none; b=LwpP+QTXgpQjD79EbuV4SeV4c7euZpel3EQ/KfeoybsiuI2u24UjVaZHN6xIbpUzfZkvsMyfZcNQslXFtb0Qs+wvWzD1ZwDfAsqD1RHXn5LQ5LsN4uEngv2iSszzcDOZiB/q8CH6t27Kc1YODvUfwqzUaOMFjDnUuwmtiVCxAyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663663; c=relaxed/simple;
	bh=wVkFcZKa/vCi3itCxyB0aMBENCVuNbE92FaBNZD6CZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ImEc0U5r9+MAHrgHo/W8ySdrgow3Z0naPTSO1PlGvKg1Wjhd5qehKtarRwSihOc1R7QZ/okpog/3oqIsZItnOA3Zl3jYCoWrLWVJXvfjievOOTUsCz6y1DTsX6iyqqv04ejd/73D+cEKPu51P7LpW/QTRzndKr0liTpfecq3Pt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06E3C433C7;
	Thu, 28 Mar 2024 22:07:41 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:06:12 +0100
Subject: [PATCH 34/52] USB: serial: oti6858: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-34-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=696;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=wVkFcZKa/vCi3itCxyB0aMBENCVuNbE92FaBNZD6CZc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenYJRmtRyR8DFsv+hy9paBbspCwSmBeGPMsV
 aVKiND0tP6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXp2AAKCRDBN2bmhouD
 1/DID/92OK7Hp6muBrKkOIiMEvU6wqV3K9Xh2lHiE4sUgNOrTelaqzW7gKuX/1vA9cSzeJH1/+O
 cQ9Aq5m2dyiGOcLx29gptpQAsAFn9YZy3EdmDTjI7joTTQ2vj/jsmmGpCPVieX840nwaSz7jwQg
 9ZnsURR2F0jlyzTAJMqq0LesCHNzAFm3AXXeq1+XfBCHIQ94Qf1ZEtYwnb4jHzAZVUmZbzLWO71
 sXsGCJNkK8vCrqwRmMaVZuPfDXgHJJakA9UL9Em9XTay8gMf+cEf79kb2P5R1mnvDF7bXLZqEPE
 WOF1+GaPAVwgxsbPlitbHW5PVvvogDj+f9GuROVea2Z4qxYC1KcKLaLphIrg8+1sCRu4SMkGZ/Q
 vP+TrBxp5Vbb2ehHPaQNE9dmTV5b9AECGNQHQKmGvI5cNsky3yg3mIM0Akr01UV6xRxhXzG+l+R
 8Dg2ibW1H9+ay/aO3SpFrqQoqllNy7kBCVWcLo5c/fcSay5YsBWeqc0W2IbjaAcT3ENuXxWeG4B
 z7qxUuAir8j4oQRo5IYwl/IIHFEZSApbhYMdARlvUiVDZffb+LvHIAXwEEqzHDSLqce4L0BHSdQ
 adF4tRahhqkf9qXxvAS7VIzxrThrp9cg5vDW9gnivPyk38CkzNB/aKB4rNpEdZQ6AiKO+EzGAOl
 c6YfR7UyH2ZNyVA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/oti6858.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/oti6858.c b/drivers/usb/serial/oti6858.c
index fa07f6ff9ecc..24068368892c 100644
--- a/drivers/usb/serial/oti6858.c
+++ b/drivers/usb/serial/oti6858.c
@@ -138,7 +138,6 @@ static void oti6858_port_remove(struct usb_serial_port *port);
 /* device info */
 static struct usb_serial_driver oti6858_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"oti6858",
 	},
 	.id_table =		id_table,

-- 
2.34.1


