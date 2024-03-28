Return-Path: <linux-kernel+bounces-123707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606C4890CF6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B33F1C248BD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F4713CAA1;
	Thu, 28 Mar 2024 22:06:43 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDF313B591;
	Thu, 28 Mar 2024 22:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663602; cv=none; b=ZyVZFo7mG1tY9JNfAXxR97FHLSp58DDBpRZnqh5jvHtSPHqAbKtmEWg6Db5CLEjOQblsrJosdJdt4rVvEUZuFAhVrobIl57G/Olx79DMtgCSlPqvhSAagJJyzHgvkSoLEMiySfAIrMpW3SLrMMRt0GUrhd+ozC6oaHbXdq7GT1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663602; c=relaxed/simple;
	bh=S2FB7xSHShvsH63CVgMl3qjp0VaPJ9IpVHHBhIe0PjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NAUdEAyz3+pss/9VjJUU97oOq+p6+U2T2Vf9Ni4X29tBfEXElTLZwqfrPbR/FUF3NjF+ES5kJL5p6BB8HS/5Xjg/jiGBDQsvtZqYEpa5rU3ofxJbU6kQXBTlwFCVKNgHTfbbfuCVm0qNmjgEY2RXbuuvxaV6bP1ZdQ9k1003rU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BA2C433F1;
	Thu, 28 Mar 2024 22:06:41 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:05:42 +0100
Subject: [PATCH 04/52] USB: serial: belkin_sa: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-4-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=760;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=S2FB7xSHShvsH63CVgMl3qjp0VaPJ9IpVHHBhIe0PjQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBem+ZGg1OW6AvoJdz6yXeTYfa4pvrpl/z2+H0
 3g9j8rSZgiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXpvgAKCRDBN2bmhouD
 11YWD/9sfHgJamsqfpDpoQPkQ4mv34K6j9OnN/dsya4PMUQddYe9I0UzEfc4xmFdYBlAV2pPwbR
 1jiTOEqBXHzNnf98ZMt+WIj7m9j/lRSpJQusWHAInwOAp+WWP/SDpzqwvhjoUfyFKLcYLmOKJRd
 x9UndlzD3YvqXs9X4mPZOVpUjB+NsX4uaE5KXubQ+k/C5nJGQkwpXcLU//JYaONPBC8nge8fW4l
 W+hJzVdLulSOwUiH4uzTAl/ZRjqd65g2elKvF4jTkaGOIik14upoEaNVvTmV1l1F2wLArd+zWqa
 z+JN7T6Y2xVSLeXYAhRtVZhkVR901oZR4qJrVGVYUZJmdkHjD+90hjXRpkUXu2cy/cENIveUrKJ
 me8LZjAjkBlvKFgp9nSkB3+kGizh11gDMe1L1hbJEgU8iHKKiIXLFSJqLhMk2uk5EJXq/k70dru
 8SOJ3LtIssFmqxxuWPVt63GHwW/0FbEyT79m9AuL2/zGdyP3bhXnkJn9Ck8WNmzMsi2hzwy28jL
 rTP0/P7qU39ObZIsX6EBseNdOhHymgQUaPEcSBiY3/CnMhkFwyuXeJd6UFJ/5L1OaIE4pIWYsdT
 B1NDmZN75y7wRXHKFpjLr4I5ThB5CGZAxdV0KljnvBNZraDoUveICieP6j8yAAZjh8oZi03u2jN
 5emCh4Y2AtK2Txw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/belkin_sa.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/belkin_sa.c b/drivers/usb/serial/belkin_sa.c
index cf47ee4ae5d3..44f5b58beec9 100644
--- a/drivers/usb/serial/belkin_sa.c
+++ b/drivers/usb/serial/belkin_sa.c
@@ -66,7 +66,6 @@ MODULE_DEVICE_TABLE(usb, id_table);
 /* All of the device info needed for the serial converters */
 static struct usb_serial_driver belkin_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"belkin",
 	},
 	.description =		"Belkin / Peracom / GoHubs USB Serial Adapter",

-- 
2.34.1


