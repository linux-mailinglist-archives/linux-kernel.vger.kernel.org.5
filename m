Return-Path: <linux-kernel+bounces-80051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379BA862A32
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 13:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2489281C71
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 12:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FB114276;
	Sun, 25 Feb 2024 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYb8dOuQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F5212E47;
	Sun, 25 Feb 2024 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708862643; cv=none; b=XYEPW/basY+H3xTP42PVH0EVdhs98x3j2Jv1y/q7qFYFrvhZvBsxRM/a0vRJeVwU/CaIQFwFRmPSM65SaWfBSDcROVZ8sExJL5Ocsbzk7dznl040NwaTrpcu683izDzV1BJyDOSV606OZBlAqo2UnF0Ory6YOzRw0ar15LSp9b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708862643; c=relaxed/simple;
	bh=A+X94K8nLPrBsMOn/w5jdCaGJfXT7yw62EcicOP2vgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LjO3p7NH/bYBzuVmV5P/QGuWzoNG5GVDhWRAAIiByQoO1fSGxy2pwTW/x8Fr5CoRLxUGOzBEK6ykefm7mH2P2sGO5xO88gWGSGn4BauhvsYn3piQWa17OT7UhLD9Io/QEMcBdUqO/cUCRY2NpY+4IYC9tgDTcOIvYZlEGv7X/tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYb8dOuQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70B0EC43390;
	Sun, 25 Feb 2024 12:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708862643;
	bh=A+X94K8nLPrBsMOn/w5jdCaGJfXT7yw62EcicOP2vgo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fYb8dOuQulxc9W33hGk0+CnBFtpLHEIXsXUnENQNOa38sz4DHex6miv5lnsPS4Syc
	 p5nkXiA+V8iTHx3GxjkNyQahU4l0hkk25wBO4f5J7U3jhoSYTcrCnFO8a82/KkK9Gl
	 1+d3EfRqKBrv/TDGjnVG8qi6qcCf2BinvNYvIBcWb8fIExsUq8tp+CQmI67YWDMNHW
	 Tn4PjNOawtJ2GVxBULw+pH683maWPW0e+2wxD9CSg9C9GECc4+MadqeIREYNHot7s+
	 PlnuZXhIyK9yK+r3ISLgepIbKsDly/8KoNmKTjj2wrXanHGxT8D9XYdsXsnREsvxIZ
	 v2Cy08PxJe+Yg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FC8C54E49;
	Sun, 25 Feb 2024 12:04:03 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sun, 25 Feb 2024 20:03:49 +0800
Subject: [PATCH v4 2/2] usb: dwc3: of-simple: Add compatible for
 hi3798mv200 DWC3 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240225-dwc3-v4-2-8c1fd6c6f615@outlook.com>
References: <20240225-dwc3-v4-0-8c1fd6c6f615@outlook.com>
In-Reply-To: <20240225-dwc3-v4-0-8c1fd6c6f615@outlook.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708862628; l=809;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=CsDB1ujYdciRCCnGm2g0rfxKORwEFR6rPwogWA69oCs=;
 b=PwZtfboAq7YOk3NgbRb4laCVeHt4Rc3146+HViWjMIXMOL5QnQPhJOPq/e41hU2/5DE320UdL
 deQbRycxI90B2LG1iPh7/W0ZrqAdyKwZenzj5AN3jd104gsLefAZE3v
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


