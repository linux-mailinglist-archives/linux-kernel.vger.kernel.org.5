Return-Path: <linux-kernel+bounces-123757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E713D890D61
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F29D1C30FB1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586FD149E0D;
	Thu, 28 Mar 2024 22:08:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6415149DF1;
	Thu, 28 Mar 2024 22:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663696; cv=none; b=A+TWcHRL4DpujPwsWCunMqET33dPEogjPE++I/3Yd7xFUWXWkLNeZv9yqPSbPvtnmenB4FQ1l5ls3mWooVgWtnrHlX46T+fkz+g/vICbda/loDKdxpsUwPMo+5msTEXfNg6aBzX1QY+/0LRX7w5Um2IKdeHwlup9pmRiNdHq3zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663696; c=relaxed/simple;
	bh=/xYrha54uJFPxVN5x8QB5L3NGL5ccb8m4VpQnRJW1Rw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lz+ceadtxFg+KYRy6FAVuH+hPCKHJsH/qX1M3xVxQxyayx/jw9WIMXuYygKg5BAPPrYj+xhESA/y29btgxI6nCXa02j5jks5c30YEtsdBHm1BJLc+tLgynm6tbKDQrfyciP4MpWMNJw98/uvA31xtyoA1RPOvbxWyhtGlici3Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC81EC43394;
	Thu, 28 Mar 2024 22:08:15 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:06:29 +0100
Subject: [PATCH 51/52] USB: serial: xr: drop driver owner initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-51-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=660;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=/xYrha54uJFPxVN5x8QB5L3NGL5ccb8m4VpQnRJW1Rw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenn5MvC/FywybRVvo4fyIpww0rThcc659VZx
 FrCK8Q+IZWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXp5wAKCRDBN2bmhouD
 1+JOD/9IYKUnRG881nM/y2edWqOi6GQIHckwBhDdYUb/B/p7NXzQCksw2Wazg1HtOvbScPa9Fiu
 q2Vu04doRoIkBrcIMWFCFyST7eP6+Aflo4kihOzIRRk0Fnrf0cQSzrKO/XGLF0F/2j7Pn97OAkI
 zs5xx7piUFocYVGbkzFRsvAwAY9+bPLbexYKyDQ7OiwsUcIEUSRj2J1ncA/xVQvy+JZC2PteH45
 Zpu8a+/Cqm7iLwj6etkfTUOlKGK6+UmJ/Tay47j15HGEuA15LL0TJVAOLAxYG61RnwKrk20o41L
 jXv1OpDF8uk0E7nJl8SQAFYs+BZOlZgS7s9TA6aDB7goRD3XONFCUov6bMyi5IZrC96QmqnuZ+8
 vBiLE36dtmBUhhqLG4B9emNrVa1PVV5CjIIGF2nWoohdivBZBKe9OkEUJD7OYgPLT4xeBUvgIjU
 Xyso0mhLekTQcib8M08FyvK5UhKyDhRb/xLsnGZYYnHe7mz4hrazrKjaAWny7ZAc8cZNNy+q8eD
 L7nED9+PXU4zwc5uFwtybKL/bbPzq2ABGu5GcDQ90/TQvtN0bPBH8sEy1caxTHH0HwXmEzz1Kai
 Ud7cKPD6eBiNx8JtfGvxVM5RUiCHivgHjY2raVy810zyI2dBxNH//u33K7nA3nTezwvNFM8D92H
 S0sXT9uEIA5Xx5g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/xr_serial.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index 1d9a12628f81..4186e791b384 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -1082,7 +1082,6 @@ MODULE_DEVICE_TABLE(usb, id_table);
 
 static struct usb_serial_driver xr_device = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name =	"xr_serial",
 	},
 	.id_table		= id_table,

-- 
2.34.1


