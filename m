Return-Path: <linux-kernel+bounces-123721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CABE0890D13
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0828D1C2F15A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD24130AD4;
	Thu, 28 Mar 2024 22:07:07 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05371411FE;
	Thu, 28 Mar 2024 22:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663627; cv=none; b=cJO3mBJzmGwCPTUn2lS9Qr8DmL6EmjSFnGNeTGPdTsob187VEfpISVEUirTNIhoL56GCTQl1uTQAlnaqlMzEiL0nxIt6xEzZiEKZ7sC6ouXEk+jF+DlIWHf1ViScQlRelhtom+UOaCI4Pjg+ZhyRgBcfU4h+sV6zohRRv9+d3x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663627; c=relaxed/simple;
	bh=3w5UjVlu+kR7HybmIw25RKh6vQkxCboPO/K0fwcE9cI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O/MFDuilBCPfj8jC4PuDSHeI8VTD8+eH8C/KIe1NHuzLFDEd+I8Pk0buxA5VBYF6lhEzjR2K9en3SX+97qsLEuACvnlP7NdEBYWrLTgMcFMis8bdrLKU9ubFJ53s3iGn35p99NP+WJDFxApvUfvmUfbln3GYB1alrQBDBNclNX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103D3C43394;
	Thu, 28 Mar 2024 22:07:04 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:05:54 +0100
Subject: [PATCH 16/52] USB: serial: io_ti: drop driver owner initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-16-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=968;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=3w5UjVlu+kR7HybmIw25RKh6vQkxCboPO/K0fwcE9cI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenJ7oIwbOCtyMJl3E6Oc49bx0yZtt++aY4hk
 cc7+zjvHkKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXpyQAKCRDBN2bmhouD
 11rZD/9O0bI6E9GQj0wOAE3y0nxO8lLvr8e4IHJZFyFOH771/SGaQM0tyUZVKXnuh5RxTmp5ubN
 kZ2JN96j8Ym5YzZ1J5BKLNVh8Y3t8+PL+kVF4xe0LFqEZmaANUd5Bj3WAoMbsMqJVtc2b/gy+hN
 rygy4wm+EPC9MW+c3+o4rWoK01JpY9ltON/y5buHiIJwtBZakFX5z7lUYwJ1u7a14CHlho56I3J
 FfshP80nDrP2bv8hHrF+6dNF27DK1EO/y8t/kxVR2UyRVJqVTQsnYu0m0W8kAAfnhiSoJDphrsj
 cbD65ziZDSWSqveMEOxELWRbFJkJZZHIrWqjOyDYgCGNNykKkp5VSBf+iBaFAbA+vaHjPBRS5BT
 t/jGPmtXTDczys6Ju+wqlo/HQx1faoC0g0qJ6V5FvI9e/ppxw2NeSM0exRKWNOslmtz7RiZKl12
 2Dbc+nqv792WgQcJL9YrIhIZB8OjJcDb55peJEpYfq6UDtwGZVQDKlv6OGeHOdVktq9DajqDfe9
 Z+voO6LfvMOtRYZ5T26yQ9pQz7Hszd1qAWtDwABDrZj3USoNJvSJh73HihTUYdl8igqXjC0Xub/
 zQiK7WXAxasDocFupVwvi0isNNip89JhQfDZq0Km2H0Rt5MRsWo7L8bbUPPOSq5gEXwUS2CKIxV
 ksZDAccLXRKOngA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/io_ti.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
index 7a3a6e539456..7d0584b2a234 100644
--- a/drivers/usb/serial/io_ti.c
+++ b/drivers/usb/serial/io_ti.c
@@ -2670,7 +2670,6 @@ static int edge_resume(struct usb_serial *serial)
 
 static struct usb_serial_driver edgeport_1port_device = {
 	.driver = {
-		.owner		= THIS_MODULE,
 		.name		= "edgeport_ti_1",
 	},
 	.description		= "Edgeport TI 1 port adapter",
@@ -2708,7 +2707,6 @@ static struct usb_serial_driver edgeport_1port_device = {
 
 static struct usb_serial_driver edgeport_2port_device = {
 	.driver = {
-		.owner		= THIS_MODULE,
 		.name		= "edgeport_ti_2",
 	},
 	.description		= "Edgeport TI 2 port adapter",

-- 
2.34.1


