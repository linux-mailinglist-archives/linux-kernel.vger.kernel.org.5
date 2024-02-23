Return-Path: <linux-kernel+bounces-78815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7291861937
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480D51F24A7D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F061339B0;
	Fri, 23 Feb 2024 17:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYQ5S7ir"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61022129A76;
	Fri, 23 Feb 2024 17:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708674; cv=none; b=t2pEA3Llbhd1+E3pRacgwVXZfX8YQwpfwDD5LjgEmTUJZXJF1U2T0yZ4Fr9rHgNzbg96KtaW6vYajIE5W5WtZ/DI20NaSbrwXYogXyeLJmRxguDPaV/Gzy7BpBhCRZUTKgdyuDGG1UuUEV0VHYqyIwkropBEwcoAFW1h0QB5TNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708674; c=relaxed/simple;
	bh=A+X94K8nLPrBsMOn/w5jdCaGJfXT7yw62EcicOP2vgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=deCf+VdQMHTow24+/vNStUYdyOJPRgLimVB25iSjJuL1L5mhyTFuPXKB4FcEi2REoMQvHPsDofsp8vyqv6qDX6ae+MEWW2ok63XN7hxB+q+rHyQh3eJJWkTTjq1wXtBaonQuWBOZ1pUqF5Xx1sr0T9duNc9suY4bbwkMYOqjLlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYQ5S7ir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 052AEC433A6;
	Fri, 23 Feb 2024 17:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708708674;
	bh=A+X94K8nLPrBsMOn/w5jdCaGJfXT7yw62EcicOP2vgo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AYQ5S7iriLvhFbkr/s9vYpH8cXsRC1cZ4/ae1w1dBxqHwQ6iD/VbchoYrbNhTJvZA
	 Q8hqlaA5pv6yChIuz3I6wynk5u+t2qZQJt+BN/xNzqUDx2Mpu/IkvbLdsZV/o7U87E
	 P6zL9hYXaBdI4uRzLaF4dn0F47p1ECEAovP12KPY8xBLguMYmQs924BU98GRksVbR4
	 6bfpvvtPNiW4wcl11KA+p8yriwAdHuUahQEdky1ycD4XQbQ6XyQDpRlzDhPbTN84NH
	 wU5Ke2akhOhPqKnhPYCYCKBwtzZ7W1OD0Z0lNY0Oh30xkGA58VYTC3ALgGE1/xVlUp
	 Bwm+7X8pHdWMQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5ECC54E4C;
	Fri, 23 Feb 2024 17:17:53 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 24 Feb 2024 01:17:50 +0800
Subject: [PATCH 2/2] usb: dwc3: of-simple: Add compatible for hi3798mv200
 DWC3 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-dwc3-v1-2-7ffb2e2baa73@outlook.com>
References: <20240224-dwc3-v1-0-7ffb2e2baa73@outlook.com>
In-Reply-To: <20240224-dwc3-v1-0-7ffb2e2baa73@outlook.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yang Xiwen <forbidden405@foxmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708708670; l=809;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=CsDB1ujYdciRCCnGm2g0rfxKORwEFR6rPwogWA69oCs=;
 b=kcoh+3OR2yb6Nda5qLA0fxQS1yg/KkgJopIiTZA9dyseQ3jAdY9OS150JxrtO5PGYvCJVh8PM
 wHTXeFJgFoZBNcKqFyUxan0nOs1qU67GVQjo2ooc6Bn3y90cbwKsR2a
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

Hi3798MV200 uses dwc3 controller with a few more clocks and a dedicated
resets. Use of_simple driver for it.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/usb/dwc3/dwc3-of-simple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index d1539fc9eabd..158acae08af5 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -173,6 +173,7 @@ static const struct of_device_id of_dwc3_simple_match[] = {
 	{ .compatible = "sprd,sc9860-dwc3" },
 	{ .compatible = "allwinner,sun50i-h6-dwc3" },
 	{ .compatible = "hisilicon,hi3670-dwc3" },
+	{ .compatible = "hisilicon,hi3798mv200-dwc3" },
 	{ .compatible = "intel,keembay-dwc3" },
 	{ /* Sentinel */ }
 };

-- 
2.43.0


