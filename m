Return-Path: <linux-kernel+bounces-123705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A96890CF3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711991F2149F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E8E13BC02;
	Thu, 28 Mar 2024 22:06:40 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7D513BAE8;
	Thu, 28 Mar 2024 22:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663599; cv=none; b=MhiNewomMSi93a2XvRULDCptfd2IfKyDM3SFs7IXfCtZM2Vt1+j84J7k81i1Xc5EcQHCgD45oLwKrM1TUUmF62bmhTBy8ORXbBUSp5/PAY0hHQvxkBp9USn311HmT7T9tHCyQim+8d5ToQrAob3DUNVuVfFyoDe79TIlWJ+8l2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663599; c=relaxed/simple;
	bh=ewN2wWZclXps4ZoRXAjHLqCdnJ0ALobijGP+WOjRNwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CHd2uqNENbI8rffE18ZaUm1332MoIX2XPMabLDnLOgBzLWEwvJW86xkwdIF0vlpJqVKgkSjBLIBc68mpWJXwzx2nyW9N6X7sXfcAPZudrFSM7aTnaGHL5dXrrkxnypf69sqReuKruprnqwmMQOc+E30WKtLS8UGr8plSlnDwhi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CA0C43390;
	Thu, 28 Mar 2024 22:06:37 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:05:40 +0100
Subject: [PATCH 02/52] USB: serial: aircable: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-2-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=679;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ewN2wWZclXps4ZoRXAjHLqCdnJ0ALobijGP+WOjRNwU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBem8vZfDaWE1cfxcMoo/La3ZecS4WXsHtcZCr
 gGmwzec8wqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXpvAAKCRDBN2bmhouD
 13r5D/wIenlftGXqsBDE8qfpqONpGs9bhK185q0kLEetIQ0L/PTsP4VwvxtqkoLSkq0BM1ON+gJ
 4JNuQ1qGe8tHIfnKTaiCjwXLfirNf0I2O8fpsCRoc7Td2/gwGK9sBhwMmEkpZtHm3Jj39C9qrxF
 GrUEjZVJHYaitUu5Jv4Ime/8nsrz9cSZU5zXcGRxuAv0cdZDfgbvqe/A6Rnh0chqPLEHQ6DlzwB
 Xhb24iKbPGvM7l4ffsepdwzJyMTEWFWnrLw/mNbr8TXd99ZsOKtGT8cjH5X41NWjUK6A0NgYq68
 e4STSWFSzrdHGrVUrIgk1hwRPaHyLy3JpJ3ZYtQL4zZpT3TklMHkdSQSvHDiHqRFGv2f+0tHg1Z
 QdHhNaTZlpfW/Z/RZP2j9RA6cS7kIjNZM4/TI65wpm+p76cjprz/PMfC9cYp7yaYN18+pToJT4x
 qAH12/MgTf7yT4Gk4FcsxxCFVwJx+pX76+MGsIluc2hwR/eHS9dK383pViJyzwwsFgXXxSYtIxb
 TolOK7pDs8QJKskb92wdP+fywA94gKQMqqvra4laNdFcslY1DS5efuAnZht0Gxj7Pcq00Xl4R1j
 R5/3EPrCXBdrqyQ6s4fYtZkUM4Zx2Mqdv1cuHc2Feb2N020BQB0rHud1x1SVTjPAfVJiahG5T1X
 9Uh11/2wd22ALwQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/aircable.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/aircable.c b/drivers/usb/serial/aircable.c
index a1df686c3066..aa517242d060 100644
--- a/drivers/usb/serial/aircable.c
+++ b/drivers/usb/serial/aircable.c
@@ -138,7 +138,6 @@ static void aircable_process_read_urb(struct urb *urb)
 
 static struct usb_serial_driver aircable_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"aircable",
 	},
 	.id_table = 		id_table,

-- 
2.34.1


