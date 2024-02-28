Return-Path: <linux-kernel+bounces-84729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F80586AACD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0920228A5FA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F3B44C68;
	Wed, 28 Feb 2024 09:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMnus8JN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C84932C89;
	Wed, 28 Feb 2024 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110947; cv=none; b=fZOtva4697n74/rQ3CeaxXdrHIBObONNALpy0ZbuPihS1eZ5ZD7JWX+/9b1h+Q28SBjC4N7yzElGk99JYyxXSqd8U/WmQZLcnT/qRw8Ufub4LSAMEaUkXf5YYlWX8Fb84ra+DZDZvkzU7DWwL7MyX7AwYzLx2DVLCsuW6FWBmJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110947; c=relaxed/simple;
	bh=ywfgATgm0aypyBAKMXF/GcEFRJ1Eq1C35G1C0msdK2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mpy1Ka5SuA5xoUybyewOXXmGUOwxl+/kI89mTgoNnL3kTMQIiaU+yF+UggR2XlxLl2quHT+VAes7vrfD0RCyvh79t6ih/al3bkvwIMIHaE4fVc2OlI5us4T3MaxIo9pLrXQCCqgpK9Q+Nt7GNANCxlL1AmpfUsYpbsTl23uS8KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMnus8JN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B007C41639;
	Wed, 28 Feb 2024 09:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709110947;
	bh=ywfgATgm0aypyBAKMXF/GcEFRJ1Eq1C35G1C0msdK2A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iMnus8JNl8hg8ghv241W0MXxME+nwlsS9jPgyRefGyYH1O6n+mrOSPD3c+y172cVS
	 Iu95099nB0Z5Ngv/Roltazjdykd79TpU6oh+1O0I1F1XMEk3a5FcWMn2AJa3QbICAu
	 zl4NIqY11I9fkKNimn0VH6ysIUNFC377HEUKmw+xxm9uh1/0rainVQaRCkkh2JzGfG
	 7cxsNlRdtMpzL3BUfqIb1sszp2CvrimzZewA8AVxqHzY81Sb/Ti6KB/+6kAEv9zeE+
	 NFX2fhQsxL7NCws7e1qGRYkz/yll99aNsrwT7oIpdhKZudWAzMCFDBoFNDX2LkWcmD
	 BCGEnqB9TtlPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0C9C54E41;
	Wed, 28 Feb 2024 09:02:27 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Wed, 28 Feb 2024 17:02:34 +0800
Subject: [PATCH net-next v6 10/11] net: hisi_femac: remove unused
 compatible strings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-net-v6-10-6d78d3d598c1@outlook.com>
References: <20240228-net-v6-0-6d78d3d598c1@outlook.com>
In-Reply-To: <20240228-net-v6-0-6d78d3d598c1@outlook.com>
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
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709110945; l=925;
 i=forbidden405@outlook.com; s=20240228; h=from:subject:message-id;
 bh=XyfB6lrJfMVpxxuFf+mKc/YVrgV78wZeT48FTY5wNC4=;
 b=KmG/XzGwjdslAfqMDhYtttbOdzJ8IZPE82McrlvVeKESHLF+ri2yhsn6ce4awRZJjXiMLciG4
 pmefFAqTF/ICav9k6kucrhy9DsT2/ku/kLq3viPYG/vv/1jcSpvI+CM
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=KAWv6ZzFsT54MGllOczJgFiWB+DuayEmyn24iiVVThU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20240228 with auth_id=136
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

It's hard to get the version number for each FEMAC core and it's unknown
how the version can be used. Remove them until it's really needed.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/net/ethernet/hisilicon/hisi_femac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
index 2406263c9dd3..3c5c095dad05 100644
--- a/drivers/net/ethernet/hisilicon/hisi_femac.c
+++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
@@ -945,8 +945,7 @@ static int hisi_femac_drv_resume(struct platform_device *pdev)
 #endif
 
 static const struct of_device_id hisi_femac_match[] = {
-	{.compatible = "hisilicon,hisi-femac-v1",},
-	{.compatible = "hisilicon,hisi-femac-v2",},
+	{.compatible = "hisilicon,hisi-femac",},
 	{.compatible = "hisilicon,hi3516cv300-femac",},
 	{},
 };

-- 
2.43.0


