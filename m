Return-Path: <linux-kernel+bounces-123720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63463890D11
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951731C2F450
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C471411F5;
	Thu, 28 Mar 2024 22:07:04 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897191411DB;
	Thu, 28 Mar 2024 22:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663624; cv=none; b=VPBSRQzy5vrmx1izYbKVM+WBWBq22PBPqM1I31KvCLyUVexy/Bte/LPjcSLQn5wTItaixumSYJGz+J2jlEETOQ1xKFK8qrxcqHx4u21n1AkcpE0QvLDUgyB1cR4NKuC0CD5nvnnX4IWu2O1gTX7wuaVClxiOxMarPzuVnTv8jq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663624; c=relaxed/simple;
	bh=V7u8Oe5cz0lMDWAYpN8ZF7BxoJGt2w3Huvu3TewSHck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JszBZCSFomzxvPUxiYtHFG0I9IQMLUapjdyDJtaRkH94CJqEGWuvgWtn8rkTJ7F4IQFAg66tG2s6+Un71BAaW5SDxRYRpW8KOrzoPHGOO5FnKZFXMtGLUbZgIIXUCDfaeNQ3EGTuC7JVJkvffdJ8PD389XrwzWQ0WnMao4yT07c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E653C43390;
	Thu, 28 Mar 2024 22:07:02 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:05:53 +0100
Subject: [PATCH 15/52] USB: serial: io_edgeport: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-15-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1499;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=V7u8Oe5cz0lMDWAYpN8ZF7BxoJGt2w3Huvu3TewSHck=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenIcDaO6sXoFRKhQKr6oPc06DYPL1FR1ioej
 pG9rQQpSiaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXpyAAKCRDBN2bmhouD
 14lcD/wLfn8UAYahHCQZo9ucaxTW378bCVPb/ePn7Z7dKp/ox8582iPf4j8y/4+KTT5sPRPazMr
 UVrc5PSJvw0BneFoMQ3Zv4frdDewf4kGgoRtuF87yENiK1C2CcKEmBdvZCocPBqN6dFeADjotpv
 FBNQQ4o1m1yHN4BWHE6i+MfcYUWYws7eSAwuEpYU9GyJ/4kVTCLf39gKHAxnpzBpaUXCSXYYPhv
 x2gIakH3qTnv8ELLi+y3a2IVqLCH3UQBNqSBhi5aGcvudd8xxb+XFJ59GKshKpeM/IbUsQ9tbJZ
 qD/euQO1HCqFDiMHJsrp0PQY+x1+TghgrF+1i8jeXdC+GyhJPz6Iz25Te1IoA3HvXI7H42e5YfK
 rsJ78GIpGAs3123UMVsxSWLZ+9DrmbFff2/4s//SDIYViLTqqdqXvYmDuU4Mh6QBUD0VHG6YG7E
 B5PoVVm1Mz+3AgTfaUCbKUIi8iYBlCEWV7pDAAZUmbeGpQkcXf1GoZ+aFfIjrJLeRg1oVI1XbJI
 iA9R3HR0QROROMFozbeoB4EjxTWniJFcDqqHx7hFErcBfqjjBRidM64hQx31kwJiuWf9tMmvS5V
 MHdP1nu/jLVtyoCVkvBf+2nSW3nztEBTh90uDeg4aXC11R5Ve3kRhXi3DbwuSV/+WnN/kep5nWr
 tB1nApRZOAAcxJA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/io_edgeport.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index abe4bbb0ac65..c7d6b5e3f898 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -2978,7 +2978,6 @@ static void edge_port_remove(struct usb_serial_port *port)
 
 static struct usb_serial_driver edgeport_2port_device = {
 	.driver = {
-		.owner		= THIS_MODULE,
 		.name		= "edgeport_2",
 	},
 	.description		= "Edgeport 2 port adapter",
@@ -3013,7 +3012,6 @@ static struct usb_serial_driver edgeport_2port_device = {
 
 static struct usb_serial_driver edgeport_4port_device = {
 	.driver = {
-		.owner		= THIS_MODULE,
 		.name		= "edgeport_4",
 	},
 	.description		= "Edgeport 4 port adapter",
@@ -3048,7 +3046,6 @@ static struct usb_serial_driver edgeport_4port_device = {
 
 static struct usb_serial_driver edgeport_8port_device = {
 	.driver = {
-		.owner		= THIS_MODULE,
 		.name		= "edgeport_8",
 	},
 	.description		= "Edgeport 8 port adapter",
@@ -3083,7 +3080,6 @@ static struct usb_serial_driver edgeport_8port_device = {
 
 static struct usb_serial_driver epic_device = {
 	.driver = {
-		.owner		= THIS_MODULE,
 		.name		= "epic",
 	},
 	.description		= "EPiC device",

-- 
2.34.1


