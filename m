Return-Path: <linux-kernel+bounces-123723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE63890D17
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9893C1F23695
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D6D1422D1;
	Thu, 28 Mar 2024 22:07:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07DD1411FE;
	Thu, 28 Mar 2024 22:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663631; cv=none; b=FpXQD9F03e6zxVLWT4WFfyBnpEY1d+yKMgk90sxk1VItOOWTXFYuQqn5AzGCNNLpapc3NQCKezl0nQatKXX50YpyUSNcZBl1dugRbR9coNlaSPlTF9gGMAwxk4zEJ1LdxSmFx56jmPFkydhZLxvFD+6Hm9xOYw7ROO/Rj1A5sCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663631; c=relaxed/simple;
	bh=+cC149UgTFZjt05huCIUXTgsp344khYTy+738S/Rvp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XTSAHP5li4KPSVJ/ALBIdtffPSXOnXVtw5fuUkn6Kx7O9kdRKEW6FdSD/fZ52YFmSimuli6HWZoaSF6hNa0Sb+idIF9lMyNxymtn9xy7xcsITv+EnCOoF7kpfmMRpQlR9SHGrzNTsQFnSSQI9CjacUbNfjfFmIIqy9uRftCgc/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAB4C43394;
	Thu, 28 Mar 2024 22:07:08 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:05:56 +0100
Subject: [PATCH 18/52] USB: serial: ipw: drop driver owner initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-18-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=657;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=+cC149UgTFZjt05huCIUXTgsp344khYTy+738S/Rvp8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenKfcI6RdiYNMRzThQjkRDkrFeaxejTHvbGG
 P5BsbebjxmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXpygAKCRDBN2bmhouD
 1+PQD/4pVsrmPyn3Q9G9O3tug5B9nm7BMtbzTO4A7GGUmAUER4LzpoNphuJhDnBYk13iZm2glQq
 m1yqpsn4RF+yvbfwDyPCoxE+7f4CX3QoAF8DjNIO4ftyIhfqDc3eZgGbMd3nMtt7aGRDGdewgI5
 U1ojtX8q5ZjKLT7U0oS61HPtxpHwIqTgORq0r4x+6/oZk4jJrjdwoC0CpGKFNye6ZZynxx9qlb7
 P0lNI5EkZhBEd4+2pvCWsFqJISKfwvxgdCmut5GpmpBn9k5n5n1cJed2djQHz5KS6TSBM953VEn
 ifv95GUnkWfFPp2w2e77/WDpRTRmOXdcZ+QhHFPKB86+I723A/m3ulUUpmmXK2Aw22QIwjCeUMH
 KnIK+uvN3Y/PQ+KjhWDE4/2cUfCXS/TBbTtyUNTJPIqj/+V3hzIb08AjStG6q7QQRYz98Xezr/E
 B9WeIBZb1Ugmb+PbsVDhAlGbPj8roXmLBP4xjgZ6VYvKrjMbyew66H/uSUFcHBhy67CLHehDqpD
 6LwqeWb019JoGwwnZ7D8G3+1cvZ7W2bAn93AA4gp+WzhzX8hqOBcFXDL/eKTA4RQRwTGwiioLOo
 QsNAH+TvvoSIScK2ALUYUCJcPJPY4nVbmaNpyIQxtvROiailnjf2sz/JBpp5NA2F5EA8j38BhR3
 fP/fFyFmgCxpCzA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/ipw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/ipw.c b/drivers/usb/serial/ipw.c
index d04c7cc5c1c2..b1e672c2f423 100644
--- a/drivers/usb/serial/ipw.c
+++ b/drivers/usb/serial/ipw.c
@@ -285,7 +285,6 @@ static void ipw_close(struct usb_serial_port *port)
 
 static struct usb_serial_driver ipw_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"ipw",
 	},
 	.description =		"IPWireless converter",

-- 
2.34.1


