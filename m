Return-Path: <linux-kernel+bounces-79225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5B2861F35
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF071C23927
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A08614CADC;
	Fri, 23 Feb 2024 21:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2jlm2LS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C08514AD1C;
	Fri, 23 Feb 2024 21:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708724595; cv=none; b=BNcU+ekZf+24To0mQXfDYBxri1KLHvOyYh+Qce3uTEuOHppnWe2+gLnqcslUtB3YcFPomnCYkgMCVffnW3dCUg4iA9L6RH6sn/wjD272ioymshZpLYQXpenARqaSjaZ/vVoJs9Cn+86V1LUUY9D4hjeBHijiXl/fu4BKJ7CFb78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708724595; c=relaxed/simple;
	bh=A+X94K8nLPrBsMOn/w5jdCaGJfXT7yw62EcicOP2vgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aWCt6+EkXyfijJ9mSUWwC8cLhyqSc4+wewE5iSaLPG/+TXcJnzOfG2icMO24loIiV5aoHo/Akx8bJvtW0b6vuljnSwL3lMSO1rg8xnTfxKKpTYAoIOPCE+LGP0Zx/AmV5ynX54XjJz5qJ1ToQwsxbULrKT0N/XsjhPFO1m10B0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2jlm2LS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE18EC433A6;
	Fri, 23 Feb 2024 21:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708724594;
	bh=A+X94K8nLPrBsMOn/w5jdCaGJfXT7yw62EcicOP2vgo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=N2jlm2LSWwpWIgQoD2l01K7mN4xxRkgRZBgd+l0Cqdsz+VOLi2UbuJy8ULla2QKWZ
	 y8vbwvVJNyKjbOcv6i2i8OoSYPfo9OM7WJ39iHF3ypRYbJF+XODLfs55puUdc4pOkc
	 E9qLwZ8nycmdTg0g7Yvrym/Bz+xtfWy9Sr7kh5sZENMPIiZwAA7ahWyaxwAJJ34Z/S
	 60wALmy6wrprfOFSzAK8yfpLTzOVmBg7NYDWdhUULw+RGnoEROhuISuQu+YqK5dORi
	 T3NzRddP6PXPbycU0EZND5Ztti2TOnZ8c+RJBR8mju+k/8MK/tTTj5zY0Xvtyb6rfu
	 MlXuO0h1Y/osA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA6CC54E4F;
	Fri, 23 Feb 2024 21:43:14 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 24 Feb 2024 05:43:13 +0800
Subject: [PATCH v2 2/2] usb: dwc3: of-simple: Add compatible for
 hi3798mv200 DWC3 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-dwc3-v2-2-8e4fcd757175@outlook.com>
References: <20240224-dwc3-v2-0-8e4fcd757175@outlook.com>
In-Reply-To: <20240224-dwc3-v2-0-8e4fcd757175@outlook.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yang Xiwen <forbidden405@foxmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708724592; l=809;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=CsDB1ujYdciRCCnGm2g0rfxKORwEFR6rPwogWA69oCs=;
 b=KkKHeuyBlpvQfJvXcl1xGd95Gd6boVNpwtooXy/M1MormomR7w53c6GZkvmN48t1alclr7B73
 bw3agINaGzkBq1DUqv68Eq1RJ+15RdleLVe9rBI4JL4uf8Wuix8qZgx
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


