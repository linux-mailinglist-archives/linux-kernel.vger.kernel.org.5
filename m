Return-Path: <linux-kernel+bounces-91842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4803871763
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BEDE1F21D69
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7CC81748;
	Tue,  5 Mar 2024 07:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTGjPqr7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98847EF14;
	Tue,  5 Mar 2024 07:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709625073; cv=none; b=uhgZasJXeXwHRr9RY2ZwpW2VHkA8uQTygaOh3jQnATxNxp2l/o1gupscH1JO4oOpvk7AGLfHWKwZItXrdPg5MWcDVnw4KjqVVB+YqSStElW47CKo8l1RQ2qBFgjvqZWfKQg3GLJhkWMwkJC0tmCuHwZEVhOwQJ6ob8eMwS49Y+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709625073; c=relaxed/simple;
	bh=9Khh/08IFLqiyY4llHeSF9dpSr+y2mbDaYQQexylJdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k04WKjelqdd5cjwbCWrNDZrAH6fI/2LQB71Zts5jdpYmLF5Io7IZGmtP/8VbC6xqtMdx00CYoU5gCYFt77sWbNTId2IuN++uk4rgJFwwm1MhEutJDQXMsNMtR9sK6n01C/olHwRN7wsPGxqwdxrF/WozAakWoM69awx/+zCbPuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTGjPqr7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 904D0C41613;
	Tue,  5 Mar 2024 07:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709625072;
	bh=9Khh/08IFLqiyY4llHeSF9dpSr+y2mbDaYQQexylJdQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BTGjPqr7Jt3wu8tr5nCeqHVu9ii1ohkz/vocm8RCYU4G0zuuk2vgsOPFK7RX6eE8C
	 wOcZzSi07snQNwJFidVUaHe/qeV5sh/3tzVOd5xBICaaT9SucDJh8IYlMh0ZqqyR/M
	 8nuIpWVXxxXhwIa68zMlAiOQrDqpRgTc0AE47k5GtcNwCwxA0Ec0Xto9USnHyQA+TB
	 SzMf+OL0GbpOw8cSf5LJGwX5AxdMdIQZmnW8QhAvI/gHe5/YCOtRFevO1rFkgpbMok
	 HqAZ9nt/Q/SbWoEeq/qFVjLdKUB9/cVovJ2ZKpYmKG2fHCR1zGrnZYnItkWhhPmMo/
	 JNC5MMU1rNaqA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D958C54E5D;
	Tue,  5 Mar 2024 07:51:12 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 05 Mar 2024 15:51:16 +0800
Subject: [PATCH net-next v8 7/9] net: hisi_femac: remove unused compatible
 strings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-net-v8-7-166aaeea2107@outlook.com>
References: <20240305-net-v8-0-166aaeea2107@outlook.com>
In-Reply-To: <20240305-net-v8-0-166aaeea2107@outlook.com>
To: Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709625070; l=937;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=aaQRrOl6ezTfgk2jYZxmgPEEzwU/YKquwXnutXaPBpI=;
 b=1vU1xw9mdYje6iKA4xX4QXA1ULcHxrhm/Sh+Trhc/gkCzGQm6p8f/h2Pi+1PBI65CySzmDN9Q
 hytHwzB2j4SDMdZ4sb7Gx/hp8ZCTHYCASnc8XS8hwGzHsuJQiVjjn6U
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

It's hard to get the version number for each FEMAC core and it's unknown
how the version can be used. Remove them until it's really needed.

While at it, remove fallback compatibles and only use SoC compatible.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/net/ethernet/hisilicon/hisi_femac.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
index 2406263c9dd3..9bf4beba7987 100644
--- a/drivers/net/ethernet/hisilicon/hisi_femac.c
+++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
@@ -945,8 +945,6 @@ static int hisi_femac_drv_resume(struct platform_device *pdev)
 #endif
 
 static const struct of_device_id hisi_femac_match[] = {
-	{.compatible = "hisilicon,hisi-femac-v1",},
-	{.compatible = "hisilicon,hisi-femac-v2",},
 	{.compatible = "hisilicon,hi3516cv300-femac",},
 	{},
 };

-- 
2.43.0


