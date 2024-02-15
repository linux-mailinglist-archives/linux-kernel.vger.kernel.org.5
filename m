Return-Path: <linux-kernel+bounces-67857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F718571E5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC27C1F20F71
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418C01487FB;
	Thu, 15 Feb 2024 23:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xf5w3rhj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C8C145FF8;
	Thu, 15 Feb 2024 23:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040933; cv=none; b=c42syIDJHcdWqyg5Yssci7r+Wm8ErrrbR8q2WgQp6HM0VAQUQLti/+ot5/sTziwtfWWXoy45snpZ3xsn/e0h75DVoet56Zot8szrKmDvYKlWZrrLJc8FCjOCZUmwM6JFe+ha/AyNa4SXlsW3KbeEuRbz6NTbaVTNdT3RBGxpluY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040933; c=relaxed/simple;
	bh=vtgSM7xn4vYZIyKOKZORU9qlltEYS8vu8vuE/kDiVUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m0QMskCsYYddEx9Ag2d49rfQmO4KUHpw1M0URjWzkJ+cSutSQTrwhs/xMMk+Xmp5sH2FmYZd/RKdun7ADbjhXRlPWuavYG365oqh3BYk4wn2DcEJbeq3nS6tP3omvDdrMmCe37UdbLU/SlwD0lks0lZqgeDeVMpBUKwnJM+OQJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xf5w3rhj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08C31C4166B;
	Thu, 15 Feb 2024 23:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708040933;
	bh=vtgSM7xn4vYZIyKOKZORU9qlltEYS8vu8vuE/kDiVUk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Xf5w3rhjEC8bRteZGEHMpzGCqkl6ePcJhzqPIoS9TzUzgbATtIqztY0O9LC+yhwzp
	 0z4YBU8+n3L1jloTBUTxZKKshE+j89nL5oCto7q3Frt36IqQer8FFmhuh338Z9YpV7
	 +dxXNEPBZdsvpALyDmo6S15VG79ztTg/wmiUlCqIEgaXRAVFKkTs3FVg+gDN8zcSgE
	 IHN9P/9V38XQNt45cTvMq01zlLX/9UgjG6+nRg/+pd/xqYynl8q5yPh1FmZtg6g05A
	 WBKjEo2e9//z7WYUe7MCEHa1Q0GXjEJllmiVQTh2ZWMslxejsAxQ1s7IK2YWwM5Zjc
	 AvBPoSkkEepVg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FD3C4829E;
	Thu, 15 Feb 2024 23:48:52 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 16 Feb 2024 07:48:58 +0800
Subject: [PATCH 6/6] dt-bindings: net: hisilicon-femac-mdio: make clock
 optional
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-net-v1-6-e0ad972cda99@outlook.com>
References: <20240216-net-v1-0-e0ad972cda99@outlook.com>
In-Reply-To: <20240216-net-v1-0-e0ad972cda99@outlook.com>
To: Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yang Xiwen <forbidden405@foxmail.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708040932; l=878;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=F5kHPrADx5NPlmJ1rkhSxa9z6ULOnV4wfItxfOuEBlU=;
 b=6HbzsNnWkAYAwbHHS3hcLyUnHF83hhbSg5L2TOq54PaHAnk9Ka1K2HjwZiA7DlrEZPmXrP4v7
 jwdNlMUA7JtCEQ1ky6bp7ra5L0oVS5+wgJ8w07CFJ6/fkTIprmD+tCa
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

The clock is optional.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 Documentation/devicetree/bindings/net/hisilicon-femac-mdio.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/hisilicon-femac-mdio.txt b/Documentation/devicetree/bindings/net/hisilicon-femac-mdio.txt
index 23a39a309d17..cd37f43abd45 100644
--- a/Documentation/devicetree/bindings/net/hisilicon-femac-mdio.txt
+++ b/Documentation/devicetree/bindings/net/hisilicon-femac-mdio.txt
@@ -3,6 +3,8 @@ Hisilicon Fast Ethernet MDIO Controller interface
 Required properties:
 - compatible: should be "hisilicon,hisi-femac-mdio".
 - reg: address and length of the register set for the device.
+
+Optional properties:
 - clocks: A phandle to the reference clock for this device.
 
 - PHY subnode: inherits from phy binding [1]

-- 
2.43.0


