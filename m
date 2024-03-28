Return-Path: <linux-kernel+bounces-123712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D403890D01
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16AD1F21BE6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31EE13B5B8;
	Thu, 28 Mar 2024 22:06:50 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F7413E408;
	Thu, 28 Mar 2024 22:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663610; cv=none; b=UkjQMl2Iu1wblUPbrqOLdfryDryigbjUkTq/uIrfHSXIsLDHPufhr8bj70BtfUJYk8jEB8S6EN/hCxgMadGMTOyN8DcXquzIgx3CAmL8A8xNO4N6xEhQzF6wMdT1bRM6km5rn/bYcPqqgZuLnMNvDABuXehrVOU6djx5xtW6FVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663610; c=relaxed/simple;
	bh=1M1ljHwJQ2Gf6mkI4K7/mzzxbDxjFEk9xijIxqTucrg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JCqqzyJN13vWDHd8+KgVGQ3iFJZeOQ4eu8e3/TGeG1F2Gk4dSwd7Q8bjZsREe47LxJgdt1Zae49xI3yTzmZPf8vygyldTPqDITrJUxIhdi0OgmPmiYskqp8aT92jNgXNe+bkr6AaRlq3LnDsSWefsuZVdH7nrJqvm1/wpBgC71g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6481C43390;
	Thu, 28 Mar 2024 22:06:48 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:05:46 +0100
Subject: [PATCH 08/52] USB: serial: cypress_m8: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-8-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1255;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=1M1ljHwJQ2Gf6mkI4K7/mzzxbDxjFEk9xijIxqTucrg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenClNWAlsyXBT3YdOTraS7r6Lai+tDo5u6OV
 GMxoHrSDRqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXpwgAKCRDBN2bmhouD
 18DnD/9oUkYvKe/l+VqS7238PFNo0Vxxx+xjEFnzX1uKJv2nUw37Q/PFuP5ZB6iLI/BptWDifTO
 AT30mWljdpK5sY5KiTbaDEQ6+QQr3UKc3C1ye+pBDb37ySm87AqgQNU56TB2vRdlvyMjt0E9TdD
 CJK3A0siOiCjtDz8d58fla7yxVP3r4yDoSQII5OnNESrcUQiSnJYfLDfOhAGLcj2gpp5vegwK10
 GHMWKrA0mnNPe9xrZNd/Sayl5cs8Eaclz6kXjGFKwjfROTqJKpyFlFD9YfwOJ/BY//ypLoeht8t
 enU/NDSbl0KvPhZ8lML4pkOYA9hXvwyvlk8m+E/B56Zt+tZ1/DkAVIubj5n8n800fLEY4/MIpqw
 wpmRcaWE/Sy6JUDPilsUwcO5l1daQSkMd4UuxMPNOpYb6cEI7T0282DPWDTbVz+eB4SZ/L/qMnm
 jQyrMtRnpjdHf+mvyF/uMOKEmBImrn2alRJ72nbPJakFNNEoI2U7JF5JJU2MSua0yAgkGkuZ6HY
 k1OiiyWnSPG2JR7CeKPr0nLuKtdDTHgWMJfkjPckI8gAMlVjb/XQSUxlW72rmhE6pjv4iZxPNSn
 2/GGvPO9U6OZWGm2MQOeiUZ3mommuwCFPz86D3A1cvWuVYDvWxCRO7qMVV2XcYsWyVF6vEiYxCt
 cCbz+YWLhhPBt9g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/cypress_m8.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m8.c
index 1e0c028c5ec9..ce9134bb30f3 100644
--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -139,7 +139,6 @@ static void cypress_write_int_callback(struct urb *urb);
 
 static struct usb_serial_driver cypress_earthmate_device = {
 	.driver = {
-		.owner =		THIS_MODULE,
 		.name =			"earthmate",
 	},
 	.description =			"DeLorme Earthmate USB",
@@ -166,7 +165,6 @@ static struct usb_serial_driver cypress_earthmate_device = {
 
 static struct usb_serial_driver cypress_hidcom_device = {
 	.driver = {
-		.owner =		THIS_MODULE,
 		.name =			"cyphidcom",
 	},
 	.description =			"HID->COM RS232 Adapter",
@@ -192,7 +190,6 @@ static struct usb_serial_driver cypress_hidcom_device = {
 
 static struct usb_serial_driver cypress_ca42v2_device = {
 	.driver = {
-		.owner =		THIS_MODULE,
 		.name =			"nokiaca42v2",
 	},
 	.description =			"Nokia CA-42 V2 Adapter",

-- 
2.34.1


