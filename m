Return-Path: <linux-kernel+bounces-123714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2C2890D06
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15051F2671B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A44513EFE5;
	Thu, 28 Mar 2024 22:06:54 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E37A13E8A0;
	Thu, 28 Mar 2024 22:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663614; cv=none; b=iwh6MetPUO4NfxyM4zaq5JwZUTrCUfY54Dw/uDi06VMl2D7RiKBL+PDej1y7qp/KfHbYPNZpLcCJn9Woa7j327gbaUAvqEat21bFUcdsiAbXnpt/mWQ2Pw5Yz5ebURvrSZ/mnGXyk3bQ7GmnabbZzcWxp2KVO+BDdlaPxzgUfsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663614; c=relaxed/simple;
	bh=v+OJ+5vWY1GxxiRKgSjuspamCOsgWHgxoSz0ziYZWb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A+NlCPkNPh9fS+ir1KtSh+qdDYu2L/6wMXMsoyJLRtsAaX5arzWO5Ccql6rf/oMSaKJJCRq3sCMcQADmbEVYpLVW+TcxL6jVOM2DIUA/6OIe+N0MCpzRHlNRRGNYY0aNDthEaIBzvvf4SOGsTTMSgq3MQyigqlTqtSLp1fzguOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A2EC43390;
	Thu, 28 Mar 2024 22:06:52 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:05:48 +0100
Subject: [PATCH 10/52] USB: serial: empeg: drop driver owner initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-10-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=636;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=v+OJ+5vWY1GxxiRKgSjuspamCOsgWHgxoSz0ziYZWb4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenD8/WX2cK5QzxVDF7tTmE6B5cKPmHTHaNHI
 jQJ+SwFHW2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXpwwAKCRDBN2bmhouD
 1/KCEACJwUzGErAIE8+Tr1M5rGs+Xarh3p7rB23LMg5BjtQM0t4lxztgY8bzSkBEIfaUvP+OfpM
 VH5qP/nNft0ev2TDynUP7dJb4w3fkREA89Yzfob1to2Q3Mmi4S4/N1IjIAqOkYeS9sK/5VVy9xI
 Zh4prjuUnAF51LErfFJj6R/HZ5gBNyUqSo5+gAtJgItshwu1M9u4wkz+CgBP5iC2K/khCqggp9P
 MBml98v/iCy1puYXUoHLNCE2HGwf1YS9FKtwASqRtBEugopieoG2XG5OO+yQBkFJ88wO/zu/7bb
 860g8qdqW4QXHngZaZch2n9W2012j2JdCfZ0jbjMsKSJ4GUwLXsH2P6PQfS4pj98X2YFj2yUA6Y
 +vKnlKKocPtk3/AXPnYGMIRjP/esm6jbaT+OGzIM10vfk0Ye3EOPs/m/Ty1yKZaoIhOGPLpHaB7
 Kfztu7ODqt5QPbNLfLWSpctp6TEUmiuWjMVJXXSU2rFyi9cZbVJJhSu2KuIfoHEU0W7a6CaUxXg
 3nkSfG8BOLvi2vqXbQ4bNw/ip1bbQ6FawlCRTQvv8YC0C4ttaIq6Ls+TiATr9XSvGHpqigV0wng
 0fLwS0pjmRERPX6kec9620KeYMgyOIqcijT72iD0LMwwDbJxYXjiyr9V19KaPldGHwzD7pksWKZ
 yJdFxBmuNgSgAbg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/empeg.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/empeg.c b/drivers/usb/serial/empeg.c
index 405e835e93dd..aedcf7ebd269 100644
--- a/drivers/usb/serial/empeg.c
+++ b/drivers/usb/serial/empeg.c
@@ -43,7 +43,6 @@ MODULE_DEVICE_TABLE(usb, id_table);
 
 static struct usb_serial_driver empeg_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"empeg",
 	},
 	.id_table =		id_table,

-- 
2.34.1


