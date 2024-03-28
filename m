Return-Path: <linux-kernel+bounces-123726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C99890D1D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3AA1C24EAA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F492142E7A;
	Thu, 28 Mar 2024 22:07:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C7413B797;
	Thu, 28 Mar 2024 22:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663636; cv=none; b=AczDTm13h84TfgSnlkExRmhMaj+FTTWWmVeVfXBsyAGC9Muvf9U1h9xNjHt4e/fX8KxbYHWMYicwMKojvvmAqLmszE+56KGaxYcjvh485ZWNPBJWfGporgmZfwFY8sy+ImCUyGJGskfeU7KMwZQfSesLoslP7FAc9jLUZjRnfO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663636; c=relaxed/simple;
	bh=IpGcYcLzgRC5PSJ66z/Lc0HfykDwMwVl2mxnZGyBrZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BOCQBPuDcnzIEOKyoEEhyssCDGu/9+ZeNkz1iOhFebPn7B4f0VKbp6T3FydqIKkvuAAfNR7niWjhtwzv22SAEoUOsq53kFYq2EW4b3dGEE4JEDGJIEShpS1P1llOGp0RDbEZc03rNKzOX0xwpn7hvhN69SpsvIvmsBEoJGDhdtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB89BC433C7;
	Thu, 28 Mar 2024 22:07:14 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:05:59 +0100
Subject: [PATCH 21/52] USB: serial: keyspan: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-21-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1560;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=IpGcYcLzgRC5PSJ66z/Lc0HfykDwMwVl2mxnZGyBrZc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenNsDRM9Xi7pmcUW0AEfHCI9zbRow/dYFgKm
 sxF9yY/OeKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXpzQAKCRDBN2bmhouD
 13o9D/9pXxP5Zlmy1jSD1QwEBL8SXA3jzQzl4P7YRvS+y2IYtWqOydMxTq2yUAIkIEeAHVb0TPm
 eQ202EaWDl5NKaLtr9QnqURunkFwuI98KKGa+0J0WtjM4ynSToZHOxPQs7VMrTXZkDNiSckWIm9
 THVYSNGz/uzzjIFP9AIPtMwCnyaS6hncaLCgT1lqvm3b6yzSNMsg0Or+SMspalhIbQX+JFLqjQV
 cjri1RJZvqQ5RZH5g0wiWSpu9fHW+dBq9LsOANH9wI+DZnwbZhix8JohaWDPC38AqO6OtIxQ4Xr
 kXggDuJKemzwAs4pA6Cypd+3EaRpc0UllMCOjax1K9cr289gP1ngIjL4A/tsAp2vfMRPHq36YXz
 EVoHcLrv5jRDKpxLj4ahbDVl8Y9ifm/6Zz29UBQirCqGQIsGXwu2uWodsYwWPh8SvC2vGTZxxFr
 IjNPn3o1ofMJ4WVxpzUISLVMfqYYaq8c58o/MmOiOmp2kchww4h8n2z3ACaMok9KLUxd++fwoSg
 4Nk4U+se26gfJFalXmgFNctvkKVivCA+4Ub0U7jbU7Fjafw2DsJJumwDSzaP+KFHb0sgppj6p7l
 nkwwupa3C0bRdyv6ZKbRLni9JnCasE8DVunMksYmb1jyPXHHWFiog+9OSxjpzOCcYeG3IaScmM3
 QCw8uBIlTc/V5SQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/keyspan.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/usb/serial/keyspan.c b/drivers/usb/serial/keyspan.c
index 0a783985197c..9129e0282c24 100644
--- a/drivers/usb/serial/keyspan.c
+++ b/drivers/usb/serial/keyspan.c
@@ -3001,7 +3001,6 @@ static void keyspan_port_remove(struct usb_serial_port *port)
 /* Structs for the devices, pre and post renumeration. */
 static struct usb_serial_driver keyspan_pre_device = {
 	.driver = {
-		.owner		= THIS_MODULE,
 		.name		= "keyspan_no_firm",
 	},
 	.description		= "Keyspan - (without firmware)",
@@ -3012,7 +3011,6 @@ static struct usb_serial_driver keyspan_pre_device = {
 
 static struct usb_serial_driver keyspan_1port_device = {
 	.driver = {
-		.owner		= THIS_MODULE,
 		.name		= "keyspan_1",
 	},
 	.description		= "Keyspan 1 port adapter",
@@ -3036,7 +3034,6 @@ static struct usb_serial_driver keyspan_1port_device = {
 
 static struct usb_serial_driver keyspan_2port_device = {
 	.driver = {
-		.owner		= THIS_MODULE,
 		.name		= "keyspan_2",
 	},
 	.description		= "Keyspan 2 port adapter",
@@ -3060,7 +3057,6 @@ static struct usb_serial_driver keyspan_2port_device = {
 
 static struct usb_serial_driver keyspan_4port_device = {
 	.driver = {
-		.owner		= THIS_MODULE,
 		.name		= "keyspan_4",
 	},
 	.description		= "Keyspan 4 port adapter",

-- 
2.34.1


