Return-Path: <linux-kernel+bounces-123710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6FC890CFD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A22FB24466
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9A113DB98;
	Thu, 28 Mar 2024 22:06:48 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9491413D518;
	Thu, 28 Mar 2024 22:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663607; cv=none; b=PjHclhCCaAxF8sk1doKgoOWA7DG/5CnJ/N0WzvkR2Ig5lEThxCdESHvuISlbqAuf90PLS8wAMBS/Owa0udxAESadSpfHi9yeoq9m34W4hKfpz67l1bFDr2UnEKiW5rqfK/zx7A0JWJiAycIAYm8KwmRMRWw4N1kW0QHVUbPNMQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663607; c=relaxed/simple;
	bh=i6aF0bN3XZSDZdoN+p7taohc4Wa1di9qerTpNHqw18o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OZeV/cRWavqc+U3M6lcmP4k7FCECugymUSydnVBXja17l9mtmNIojRoIinp2H+gxZK+kY2NE3sbMIOw1W+DcZpHgspmFoVOEoobFlrLBAGDq44//xnaoGroyBGevymeYgj4wQz/pQoKs/4sYcyReWDH4gOZOFDI7+f/P4z7wPls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4A2C43390;
	Thu, 28 Mar 2024 22:06:44 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:05:44 +0100
Subject: [PATCH 06/52] USB: serial: cp210x: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-6-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=638;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=i6aF0bN3XZSDZdoN+p7taohc4Wa1di9qerTpNHqw18o=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenAKsLcW7N4X6E8ZHR35B5cXAL84Q3bmG/Lz
 b2zBgYSQ4mJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXpwAAKCRDBN2bmhouD
 18fAEACbZARq4C1+q3szJMrkmkKHNB1rzzu7cnRzkYx4lqbf3YOyf8lbqGXQk7mFkTL+INkkbsi
 JUn5QDWhwC872nyt0TEalnt4UsDNkY0j/WN64eEmygd0Y4l2CIo0boKMjTWqSlk578bH9O0uQkz
 hX/BI7vqphWoNht/j7A654cNiMX0c5YJgZ5fG7BazV2cD5fWMnD3reV57B1ZLFtfIIgA9IhrvRv
 q08NhfxWmLmGGRQlL11KGoGotMvsKfIrKgklzUDdoHds8oDRsr8jjTwAWY8X9lFkaZjLM9Svdbu
 Z4yulzJFICXGiPXc+7XqvY48XE7asID6CCtZqPrLw/kYDBD8mrDrw4YOFi1EUu+RCci3VPddrbu
 9A/dwKenFjKSd8KIL0e5iFpJ2LkTBT4hB6PG812o8mrziu6lolfUmsYSoHP7W8ycHUSeLYJl7Qb
 mMM9XqbNayuN2bPo+xIC+949yM7SY2CT9HsaybxDI32lz2uDs8I9Z8dV9nLKndr7b9uXfVwGbTl
 Wc2DTfKlKiEWWyUnwMbU687TQ+wZImffEAr2WaZdWV0jskr87FVugiuf5nQTe98MzJHLEj8Ma2N
 /6G1iqhmQbTAvtQzhtyWwHSlzWd6ofgtechCd+7s3JQtSayf8eHdjbAVwOhvM7wSpwIbT2b0bj9
 grbJIEYbdOsht0g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/cp210x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 21fd26609252..c24101f0a07a 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -299,7 +299,6 @@ struct cp210x_port_private {
 
 static struct usb_serial_driver cp210x_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"cp210x",
 	},
 	.id_table		= id_table,

-- 
2.34.1


