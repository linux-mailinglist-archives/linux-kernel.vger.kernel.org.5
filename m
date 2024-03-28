Return-Path: <linux-kernel+bounces-123708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3312C890CF9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBCA31F221D8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223D513CF98;
	Thu, 28 Mar 2024 22:06:45 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912AD13B599;
	Thu, 28 Mar 2024 22:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663604; cv=none; b=NyQesnZPNgJWoMGIppj5wwu6IgjcADmKFa7o/hZT+A3rgw+1BQ0bvKufJjExVGzG9EiuNPciulZMfpbScUzzYD/vnauvM48r/EdYU0vEP4bvnlMnDQZyCErppacbUSWy9+aYJQzwVDPAl+gNhMPrgPiXBuBzkjG9vwOr6K2hXIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663604; c=relaxed/simple;
	bh=s4C+SKuKnbuWnrrTdyEnQy/9DjIiXPnGtzQ4yIPkO9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lsxawQe+hriFwtwWRcrcgYjFjcLUMOj/fzNmVgDC9QtPhC42IFi8mHAuxUyT4MNWR8vobyHcqEXS4KTOnnay9IQPNIuCzd1QG4Rt9mo+g1Q9RlUQx70lIaoYiPAl8XoqE2byNCSmDsE3MsXuIU7HbmJta+0v3xCF5N78gNyqTU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD1DC433F1;
	Thu, 28 Mar 2024 22:06:42 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:05:43 +0100
Subject: [PATCH 05/52] USB: serial: ch341: drop driver owner initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-5-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=671;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=s4C+SKuKnbuWnrrTdyEnQy/9DjIiXPnGtzQ4yIPkO9s=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBem/iGZ6D+lHq2GEABp1KowV9BKHp0aeZNH8X
 xOC/f/yuj2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXpvwAKCRDBN2bmhouD
 12veEACSkT+n7pD4UsewmrGmiQBcRARtwyiRn1iZialJSLbzSpDE1CyqFaRuIAvbhJO+J5+nUfx
 omTwA7UDertUf0pRFH7ene2getmX5rOWOUEDz9rtbt3IH4Y2n73vergblkORTU1BnxEmBukMwFJ
 YkUjR1VjzN3R3WfoJ0MNdjykw2NYv55UaNIFfFhCPvAV7nIrESb63cCA96BaU5HrQ4GNSFOwgWJ
 5rL5G4Zg1VkBfT4grU+RMcSZ3LM0bM0dNsTA9/bt1tJuWtQ0Q272dVhc5Tqkp1UC0vRWodQJ9Pq
 M1eO2NSxuIrrTlbykSiXdhoIbsD2DuJyTUhvcCZ29PQTuCQGaBUvsLbxvEPjWpDqedwlSEvHzuq
 ZefsqHjxKhq+ffS/r5qvy11VEied77AnvaHg3fM/HN84m7pD3SPBUvnNlHQH4D/DgOkLQqt6+lK
 McZpdiu9RgHItD2bjdrf/SeS0qC0KT/qNoo8RtUEbzOsRToitpYAg+kVAv2INMsTAbtlxnpA0gN
 oNsciDpiAkKSkXFUjvS2ACpQPPEm+pExptF+kyjvwNXTDxhRXN649pyhy/lIv0GDD5aJ0JSLnYf
 cbcGNlWJcyYFOwVep5U9K9BwD/1xXSkLFmtFVrlBsVPv/sKCIB2woLcqjBjB4+gzCrrn5iVu3mJ
 5ZC7Nhq8rf7OKDQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/ch341.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/ch341.c b/drivers/usb/serial/ch341.c
index 612bea504d7a..26d48a4f7036 100644
--- a/drivers/usb/serial/ch341.c
+++ b/drivers/usb/serial/ch341.c
@@ -837,7 +837,6 @@ static int ch341_reset_resume(struct usb_serial *serial)
 
 static struct usb_serial_driver ch341_device = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "ch341-uart",
 	},
 	.id_table          = id_table,

-- 
2.34.1


