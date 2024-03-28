Return-Path: <linux-kernel+bounces-123748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3551890D4F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE8E29A16B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6BA148305;
	Thu, 28 Mar 2024 22:07:59 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433CE1482F0;
	Thu, 28 Mar 2024 22:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663679; cv=none; b=Zx/tEtsTNPun+l8wrjJUOCJsXcmAtMLDdKaWfhfcsPDpozaQ5Bw/QrpUxYeZv8zUE5v/QFW7w7pqj5EhQ7GACYlG2oL7sPkdytMmHiciqzb7KW+MjIoIQBDIoCY6/sGRQkruEbCGJ3qH3PJQXcs63/SZJtQSm9RvJzT58By/xqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663679; c=relaxed/simple;
	bh=3+ZX9LfLbiwnPeWElrByhoSWfYsiCFtxa/TQALfD1m8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GX4nb8Z3m3Mc0Y7iMYSFCEB81qlKkDjGhR9M3tVJVkV7MkfYw7A2L27GK8aZZhheWBk/Ybz7MTvdIpW9x/gJFU8n6Fj6M2nTtaf6gJbuEet8xj+3O51T9jwOL22+f2Tt2xxK3zGDy6IH8CfcashRsR7SumMTNTKtDWUJYHzFubY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD582C43390;
	Thu, 28 Mar 2024 22:07:57 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:06:20 +0100
Subject: [PATCH 42/52] USB: serial: ssu100: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-42-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=671;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=3+ZX9LfLbiwnPeWElrByhoSWfYsiCFtxa/TQALfD1m8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenft1ZEeK2+ySaf+T6ROALAPMmHMSeMa/AJJ
 2wt4Z9pgdWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXp3wAKCRDBN2bmhouD
 11X8D/4+zwMtchMG0hDo06jYb1bFEqhGRZJJQtOuvxk2EhfPBTKzZ1lb5EGf8uxd9DVALJlZg0s
 qap/Qne2N+IexuosDsiVP3QdGRS5V82TUpFQtUnzgm5lp0vz58hHvr8bCPKF+rqpJkXUuIYhBz3
 KljtQkilMypDQaKGtLSmLo7o8XguvkkhWyU8k3jwnz0ex/P+pVEaMuguoU3OqLUOZiKXuZ0rtDf
 cOzX08gLMZFRWynin/H5+DVtuFX8YlCsTNjzrV2Zzubr7ILx3d+oQ/tMsKjCVQ+96ewMKJud/oT
 XAWIXjGkR4LUxG6KCoA6y0fGfHdzg9+TMvtvLuzeEAPhxwgG8bnGgUna5Ja36UALB27FkshwN/S
 wR6hUpMQ6XQYQhAZskJZ6lxX7mrN+2t+ZAPNuBEf8Q7sJBNr5flZS+K7c5C3YAiKMZfUoP2paFd
 1zCCXeyEM0GN6siqX1n5/a3cqH63BeIPA9AgJ2j9j3Jei6BngAbor54pp2m7Se6q/V2jns6r2MS
 FhmH99z52uXrqzaK2EXsRxMGaMFm7L2hLTH2Ny7JmSDKHbWinY+aLpe15JcBqwVN8IV3zgNGles
 joJGQzFVp2j5j+bpG7+gjRQz+r7P31fhC8laqyf6uof9DmGStSLlCVEEg/0UIufxYloqIJ5xkiG
 1ogQz2wvFvDwkPw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/ssu100.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/ssu100.c b/drivers/usb/serial/ssu100.c
index 1e1888b66305..df21009bdf42 100644
--- a/drivers/usb/serial/ssu100.c
+++ b/drivers/usb/serial/ssu100.c
@@ -500,7 +500,6 @@ static void ssu100_process_read_urb(struct urb *urb)
 
 static struct usb_serial_driver ssu100_device = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "ssu100",
 	},
 	.description	     = DRIVER_DESC,

-- 
2.34.1


