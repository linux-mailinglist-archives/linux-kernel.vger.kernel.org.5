Return-Path: <linux-kernel+bounces-123758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0132890D63
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF6C1C31194
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7949F14A0A2;
	Thu, 28 Mar 2024 22:08:19 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C59149DF1;
	Thu, 28 Mar 2024 22:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663699; cv=none; b=DkmjuLbh3wXtw2kitnctp9LtVGjLfqSwzMt0oCSJz0qK7HrTEHKFJ3psf708Of8WBxPKlzzcXZCM9oedGxvgywI6pv6Hlw0GDm0ph3wjnuGON+fOByD8z0hNWt2bcepcIC5q3qYHDo6lbmEnTdc6FlrYlqCfT26R2kjuYDaz8wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663699; c=relaxed/simple;
	bh=LLgiLkEII5evsgK2AeBKp1W4Vw206VrKkeb0L7m1FcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ElCOk//0r2s0J9rqci5S0HCCzyG90qgoK4QwCYMyF1Pxhe5Q+g5PnHBIweZW99cJ8/5Xf9LdK+gCzBXQ4mdBiH/DhtBiXzuZNaS/vfjAbUwPUQwQFTRX5gt7OPq4sYjEe1blL4HH6kxHioTsXsbiStS4vvoOvQ2R8usxJGqlO2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7A9C433C7;
	Thu, 28 Mar 2024 22:08:17 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:06:30 +0100
Subject: [PATCH 52/52] USB: serial: xsens_mt: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-52-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=672;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=LLgiLkEII5evsgK2AeBKp1W4Vw206VrKkeb0L7m1FcA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenomRGUsL6cULpwOBe0G2bVuRPfxmlAfgNA+
 2cWHgqoT3aJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXp6AAKCRDBN2bmhouD
 1/g2D/9fX5oDeyuAqMHK3i1Su4fUJkok1yK3RHtQTFrpbA1qln3eumD102qFjnVBiHhunYN1mq0
 LBOue/jhu7eFeGMiFLUex6gx7kctOD3Tj4V02cIdV5C8OGwQZmhGAGHexnlDxNMGjYIdqZjY5u+
 QlSDDigE30r7Ydh/ue+6Dr/9kK9G1hDbA8OserSt0wckd+Lyaa/YRtilgupADpmOZGtQSAeN4xl
 nQLQBXTT2q1NKbgT4h6/dUOQ4D6HyMLN7yclKdPFEPmM/Zn4eBUWy2SSVrgU8t35jpHCYQ5hvmy
 Uk4UhTJeQwPIOk09ZC1I9u2q+wcM9M4rRItSJjV6DvW4DDDeljtoe6Xz+9ymq0o088jZnWej3Zl
 TXlOEI4UzjUPQi2ONSfcBgD9vYKleUVmwZIjTQcP76fgfY60hCuYUzfb6qy8+0FjwWSjMjDPjwe
 xuxCugPHIQL8bvqsxNC90xFYF/x7h1nBDLIXZQsBqn5xmSKbtXNgvQk3OS+BWHmn4nb2hGs4Y7F
 L+SyTh0DPfYcv5oeidnTOzDdrF7SG1w+iJ5VQidawuyI3oHprrWic5CdJg/JXGQHd3C+Cp8wilv
 qj1csNu7CL/o9HDe2pUTgXdNLNCM1GZDRRSPaTJA+z3TqBmQ4vFITzK6hNBgB5f/GK1W5Cz8rhu
 SI8fYbC8zRfnfIA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/xsens_mt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/xsens_mt.c b/drivers/usb/serial/xsens_mt.c
index cf262c9a9638..382b3698c1d5 100644
--- a/drivers/usb/serial/xsens_mt.c
+++ b/drivers/usb/serial/xsens_mt.c
@@ -49,7 +49,6 @@ static int xsens_mt_probe(struct usb_serial *serial,
 
 static struct usb_serial_driver xsens_mt_device = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "xsens_mt",
 	},
 	.id_table = id_table,

-- 
2.34.1


