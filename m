Return-Path: <linux-kernel+bounces-123711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D46B890CFF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E5D28D2B6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2536513E054;
	Thu, 28 Mar 2024 22:06:49 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67507F7C9;
	Thu, 28 Mar 2024 22:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663608; cv=none; b=fAAlgq3cdvRg4UeS3S7UtYOwEZzCCHa5XiXz3toulCKHgL4A5+mkxdwGMjeY3aQT4iq927Ri67k58pCKwBoydKjwwFaSI12RRblNMC4ncm19X8Ku9SZUBdPI315Zf2BnVCob7U+zVgvfQDhpXfUOHFMT5CTUY8trAa8zbEg4UK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663608; c=relaxed/simple;
	bh=oTE1+t5ztgxEwyfIhDxEPu9aN2MFsJ60SQzynS4l3sA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lb976VP5iELIXTOKWVBqencMkjWVFj9OeGnsMQbwVHeHGOVwFHLjVRFcWY3eAy4LwrnfLnF9aEsOYMe/uIEg0pNy+4jmmVj0wOLdEsphVN/0K94eddxuU/XJ8GOQ1+pPdtew9LTdeS2b/sEA8Ljrs+cGrRtbRqgD5DmiSnt0fDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C16C43394;
	Thu, 28 Mar 2024 22:06:46 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:05:45 +0100
Subject: [PATCH 07/52] USB: serial: cyberjack: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-7-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=697;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=oTE1+t5ztgxEwyfIhDxEPu9aN2MFsJ60SQzynS4l3sA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenBKaZs8q4FtpiRfe+boddc83z4UkCJTJBMI
 i89QO8xuvSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXpwQAKCRDBN2bmhouD
 12dfD/4t4mBLplHODZH6T2uBohQ+Chv0hfKU29TIMTMTZsejbQlk2KHEVc66pvv/4lLHqoF7vct
 cFhGAEj9DyqNE4xEBs7FVH+njfVUA3DFc2A1A2guEqS4Y2JhHxlKl8BGgnLCu0aHnv7NHhsDQD8
 YgkSSnNyVI1PKoo8DFySLP49czkvndcp29rkFUqcX8+NHJD7FshiwdgsoBHJRsyd27FFGnMflJu
 VXkhZv2HaUhswxNjxeIbsjIoWWHLjiKPBGJk3BexKXTYfjj3eCUhN2fOWvkhx0Xf/SZ8P+qHHNC
 slturLLm11fJ8SThb5JTV54sxD2KWJQu543YLSntBPO/e0Gp02zE6WKz5y2BG4NuVfT5lm/bsNK
 n0XJH1T9Qy0zBl4Br9GCYXwAJmJDp0elDjVdjr+g4JR/CgieHIgIxmRfaF/375nJzZHA0uyReoF
 BudGt7GacRAYqpTeZNP2lah+YeObGbFYEhFbMyrzZthh86iTLhz7MU5QZTulgx5kTc64URgrw2/
 MUpOUSxmf5VfKiK9K4UHwtvLESedE4JpQ1OLpiGL4vpOVhLBE6RyHHxjiDt0sYXtu9gfaD8Y3YP
 ojpQtWxwMisEk+0fC6W0wnv9UdpXUn4WBagaUDGhAf+xzjdKtEMPdGyY1XkxibWtslu3Rhcxc43
 ihXnxKZ9UVW5vhQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/cyberjack.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/cyberjack.c b/drivers/usb/serial/cyberjack.c
index 51e5aac3bf4c..76dd8e7453b5 100644
--- a/drivers/usb/serial/cyberjack.c
+++ b/drivers/usb/serial/cyberjack.c
@@ -67,7 +67,6 @@ MODULE_DEVICE_TABLE(usb, id_table);
 
 static struct usb_serial_driver cyberjack_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"cyberjack",
 	},
 	.description =		"Reiner SCT Cyberjack USB card reader",

-- 
2.34.1


