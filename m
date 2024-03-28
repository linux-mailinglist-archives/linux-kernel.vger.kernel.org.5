Return-Path: <linux-kernel+bounces-123733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C532890D2D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E6D91C3002D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C680144D17;
	Thu, 28 Mar 2024 22:07:31 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9751448FF;
	Thu, 28 Mar 2024 22:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663651; cv=none; b=cK4W7/DiDje9njX5/ffODv5zTup5PADHoGb5Ug3fxeZHaBs9IoUzDo6WCOZDVKd7oCg/6YxJw/ODli5FmPUWUkT3hwZLsFOnFRFPyqeKUln+vXkbRBFmjeoICtr1Bj1l4ND7Yj6gZQqTnlWJe7tzKH8Dsj1LmVnT9X/PmqeVDWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663651; c=relaxed/simple;
	bh=63JQIxo5ati836KA0JjEZkyzzIzrCwSP8zMVj5GCA9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UbUBcNo3dqMPPzRTw0lO7kKU7ZQSdb/0IjihQHI/qC99hn7wr0Qe3FxUBAVT9LYHkJYlLfex+DfvRNu5g2nL7i3ILUsBsYuXY49TvuJMopIidNMkJx7lAqRvkBFja9IKaEimY2ymhXvvrZOZm7Ja4Cp9GvzsUcmGPMfeTzo8D0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8206BC43399;
	Thu, 28 Mar 2024 22:07:29 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:06:06 +0100
Subject: [PATCH 28/52] USB: serial: mos7840: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-28-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=704;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=63JQIxo5ati836KA0JjEZkyzzIzrCwSP8zMVj5GCA9Y=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenTAxzmItIFKn+vW6dIQS8TE2OkLnrIWGGpH
 7t61Bckb/iJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXp0wAKCRDBN2bmhouD
 17zLD/9FJVttt+gZY0mDSLwZWScCRQ/1L3ajpPUqRf5l1T1JyyFQEq5I/eqjVxUbMcu7ZTS2lgO
 leHILuQTxxCvE5dJ46UsMZrxczuRCouqswTsfaD3X+O5drjTbkFd1sCjHLmuKZYy0JN8ZbjsEoM
 Mj+Fv9uUvoGiSdbigiqBYDQNOM8gXtw9aQsSa3MUTB5RIL1xHWCt5AvB3hacpsOc5hB6WyVv9IW
 +zXSd8nDTv404e47AzgfgrS1FownCDrkDOh4Vc0xqRQd8a1DAc0deVvnXH74KdvaDMR8zO9//ei
 bnP7ksx0wVdVeLLtzOj4GVO3HK+R+DLYZr8kErDlfZoAbs0P4P3+6O2Fvx9t/+HKIGDspMciiM5
 qMTsnNJJFf5kXScrvidVqPo9kovrVq01I12TcJak9yGE7NX7VCF3W5Er/C6Lw9biwL7aJtvmWyr
 szcQqIe8pW8dao5UUhOumcCZ41/yNDizGn3kTP+KLS6UO8v8PlwmpFawDdnblQrKx9G5JQ8nA9L
 2Z2LSh3Bsdpo1AMa3NSwGqevyLrkyAQFBdnL3qE7P6y1IKniAHoe53/rv1qvJsPYUEzFP0+UEdn
 TE0TOr8crQR21/bZv2NdzrOIY14UurOXoTSpvfEIDhOCpYQYC6MxZNobSp6/EurxcpqblHJj27M
 0Aj0hoaUTkNcWrQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/mos7840.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index 8b0308d84270..70ff2408b99a 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -1739,7 +1739,6 @@ static void mos7840_port_remove(struct usb_serial_port *port)
 
 static struct usb_serial_driver moschip7840_4port_device = {
 	.driver = {
-		   .owner = THIS_MODULE,
 		   .name = "mos7840",
 		   },
 	.description = DRIVER_DESC,

-- 
2.34.1


