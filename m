Return-Path: <linux-kernel+bounces-87872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2E886DA34
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B634B238DA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B75156472;
	Fri,  1 Mar 2024 03:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRN6nwjS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1731F47F6F;
	Fri,  1 Mar 2024 03:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709264161; cv=none; b=mA88+jZ2F8hUPssgq3ytHMJ2mk/ExoXQBJlbhzkwlJ7DHpsr4jpPor7bNdt7oTb8x6mqgmPO2p7+3Zb09AHIptuWKcD3+qkYgz0vmed7DIJzCWhyAso5FpflwMofyNIoDTMpwY5bxs8b6LEqye/ZQCkB25j+PwCFx6A6/d8iVbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709264161; c=relaxed/simple;
	bh=gkNA5inb3gzyItpjdDTlzlxSK3vaHY84ceRjoy9uGP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OvnHQphB9QEGfx4cPYGT2AFwQtx3qfY4nmRDi+go7AEfKagBigAF3QLqjBelP3qznUZvhCQkESx6EkyUPdFTvUQ07OhqkayE1NGw1Gc99sGXhdf/3nPUgIvWgQH5bjOOP/Dk03A0MlEzZhmCD4j/jz+VHO7KXkytOgQ2RA5V6L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRN6nwjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD2FAC43143;
	Fri,  1 Mar 2024 03:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709264160;
	bh=gkNA5inb3gzyItpjdDTlzlxSK3vaHY84ceRjoy9uGP4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rRN6nwjSY8W9oUqoiGm9U/WOqprIr7VnSLSDpS04r5EbIU8zSSoxgsnoNCdDrWhxm
	 kqWuCHy3oEtsXmyse0wwm1G45h/nOzrQOZpEW37epnvc/5TYUis67utcLIICUP4Lr9
	 NlQZK5ffSZ2sakLRkM58AIC3hL4EjH8aLEA2QSNPkEHhblNef5F+7qkaUUl6y2AZGl
	 x1auCO/4caIN10+mO8AxmWYlNJpiZqsUR5kOivhpFi3H0Eomm4DQnKkC2wjdo21F9p
	 VQI3YwYl2CPDh2az3YMYpn5hL1GhK2kkPxHIgeqCoLJDCgAx95uuQPQisgMeDmrOkU
	 EGrVvDbvF5VcQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4A5C48BF6;
	Fri,  1 Mar 2024 03:36:00 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 01 Mar 2024 11:35:59 +0800
Subject: [PATCH net-next v7 6/9] dt-bindings: net: hisi-femac: add binding
 for Hi3798MV200 FEMAC core
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-net-v7-6-45823597d4d4@outlook.com>
References: <20240301-net-v7-0-45823597d4d4@outlook.com>
In-Reply-To: <20240301-net-v7-0-45823597d4d4@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709264157; l=785;
 i=forbidden405@outlook.com; s=20240228; h=from:subject:message-id;
 bh=oXZR+lwkSXsM/Qjr88QbgRS9lNfkCukHdVr29JA1ajo=;
 b=Xe2EbEmxy306rUj0zxTs1+ZIHcBeTzy6aBpoU+vjM15EPa4WcnOXJ4gQXix5klVOt6vaLbR0d
 BrieYEBsQrtAkM6rV7RqoqGr3eUFHKcdLkHEV9rJqG1uDiyrtlIEkh3
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=KAWv6ZzFsT54MGllOczJgFiWB+DuayEmyn24iiVVThU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20240228 with auth_id=136
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

HiSilicon FEMAC core is also found on Hi3798MV200 SoC. Document it in
binding.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
index ff6b090ed34e..4f51c5ec90b3 100644
--- a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
+++ b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
@@ -17,6 +17,7 @@ properties:
     items:
       - enum:
           - hisilicon,hi3516cv300-femac
+          - hisilicon,hi3798mv200-femac
       - const: hisilicon,hisi-femac
 
   reg:

-- 
2.43.0


