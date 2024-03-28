Return-Path: <linux-kernel+bounces-123741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1090B890D3C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ADA01C303B0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7994146A6F;
	Thu, 28 Mar 2024 22:07:48 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D616146596;
	Thu, 28 Mar 2024 22:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663668; cv=none; b=asLRAofeavFvsfiQ0lpYBBXZwd4m0OTc37yvuZCxTggkDYVlRpVJAqSmzNmmreeatQbfDla1cjMwbFDw7Uv3d7zw9y3wuNVrWN7FTnV2hXDSaZQs4mXmaZBNQ7E3CpI4YZJQPbc61nJF/kR3qr4YOOOcK84cvojw4h6FKlyL/YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663668; c=relaxed/simple;
	bh=0ZIeeo/w7wOjuvwZJyGeFbiEUsgjOPmHLmdo8AlJfRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZKhMjTpzXEwVHSr3KPzU9CkqZZ8jVkT6Yytfwn2XzNqSrUBYZfqnSDNFtS9Zg0IFPL89gX7D7ItL0eAfsa7/Hm+23q1rTgSDBQN/S75oCLxJQwiOWHuTI4ISV0V0sjPGTI/z5ryWRPvnZJeD2YQQV4liZoUjp1NCAnst//dJb1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3754FC43390;
	Thu, 28 Mar 2024 22:07:46 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:06:14 +0100
Subject: [PATCH 36/52] USB: serial: qcaux: drop driver owner initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-36-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=636;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=0ZIeeo/w7wOjuvwZJyGeFbiEUsgjOPmHLmdo8AlJfRc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBena0PfgRtQ75629khrdHHNSLd1B3H/2zt1mY
 ZvvMMyiHUqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXp2gAKCRDBN2bmhouD
 17HgD/0boQc63AiuSW02R6NPNqlN4O8HhYLiygIauxJnI9ojluFswRqjSUlRjtyL9nNoW7yFYhe
 YaF2sDRRvPBslgnWebAZTBieNesGCpkFLxmNyayZXJ8RkowJUjCIhbDMsu42sjgd8hdWTLMFBzc
 akpSbAU5rNQ5k1PSLb2y33YcdX5IRkSjFS5Znrk3WDQLDK5tjEMgMsXP4akqqjqwi5ZmtMIyhhp
 xh6WV4G3kAe1zChh9j63YWW+XKPEyBNg3ZU/pI+SLtKnFI8wKZjtNNr+W5jowGtadgJdh+5A18R
 qsqO7j09xfaeBXuUAA4NGZK19H/eYiowg48ySiNFWlt+hvpDAe4RJlpWvM5gM3Oa5LFf27Zz/mh
 XbOW8cgTV04/U0RtMn2Qb6Cr5boXMDnnIZ8NVKiVPm5jUm2PCr2m/LAJSbG3GSClea8YzTmYWtW
 8mTVGmOlbChXtVXNR0pUx6IyWnpghBoeWDhyG3SM+rM1o9AskMzuQMPAr+sXnmo4WrxCAEo/3b/
 bCrSfL3g28jMLjSz/Wr5Jd5ullbSBHbxdr02rNChO13BxKW9uwNdV+5UC7M6Tc6YGEwFtJChGkC
 avOarTl7pTQ18pLBBPmZHXuWt5m5ig4mhkGmhjH7wXV4cWmpolRTcOWH7AeVBEz9WvYU1MY/vIP
 9xCaFbXFJ+rrSBg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/qcaux.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/qcaux.c b/drivers/usb/serial/qcaux.c
index 929ffba663f2..fd34f7e48e53 100644
--- a/drivers/usb/serial/qcaux.c
+++ b/drivers/usb/serial/qcaux.c
@@ -72,7 +72,6 @@ MODULE_DEVICE_TABLE(usb, id_table);
 
 static struct usb_serial_driver qcaux_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"qcaux",
 	},
 	.id_table =		id_table,

-- 
2.34.1


