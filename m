Return-Path: <linux-kernel+bounces-96675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40D5875FD6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F365283B40
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D8055E41;
	Fri,  8 Mar 2024 08:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfd6CgSc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E54524D4;
	Fri,  8 Mar 2024 08:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887186; cv=none; b=lmaKtkXHglwYff52TrrviHg/aIsb5CXnmJMTa3BPcMVWHq2NSUq1Q4Ou4QYh+MyqwpitgcS3WuWYNZCSt9RTffNxctx2Fp7cUzOnpH+cN5w33PXt9zPFN0ixlSfqcV2KWB6tqNbCFE3099GvHgjprCDoyBtyo8Z35IDx5Mwqui8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887186; c=relaxed/simple;
	bh=6GLdR1NzwuN3vF74pRPb7zqnKBAq4A6IwVQqiGNp8do=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cyKKiGXZZpvhkBfQEReVlYzG4Aam7ldtkr0gDjWII+NDIvEQi7ApycO03Ap0c8jAOhg7RjDqfJBArGIrx+IVZ/MsuzgyXGKmEVAWmiSKkiBFBZYUE4uqUJQvO/yRdhzG+vAc5yQrGrk8vBnwT7dPH6OfD3NwhDhdMZROdbDIwkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfd6CgSc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71C6FC3277C;
	Fri,  8 Mar 2024 08:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709887185;
	bh=6GLdR1NzwuN3vF74pRPb7zqnKBAq4A6IwVQqiGNp8do=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dfd6CgScdrDkOenNuOa6Nw05rhzkLG+DhIQyadkwxNqpxgThpdUmRP8O25RQzQL7Q
	 ejO8GQ33AY7NYceho5ONm9slNAmY7RJRiaBA4Sb+5FzJLFyMi5RiO2nnds4gdqlBW3
	 ZU1WPzl8kaHxyPoKdj8UU7Xf64F3Tgg4gEL1lNJlJE2YUBIjuU9inIQUiFAymjWEmJ
	 Bh7LPIeD1oDiNAVQsz73wwjL3abHRRXVU61uuQ2WLkulhS047go2gh3ShfWX+Hgmx4
	 74WgYa8wr32YwntKdeMDUaX01c8AiYg5RRsXJ/LzisHHjuVh4/HsdT0akWC/2cqmn4
	 4Dz7LdhySSZMw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C57C54E5D;
	Fri,  8 Mar 2024 08:39:45 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 08 Mar 2024 16:39:48 +0800
Subject: [PATCH net-next v10 6/8] dt-bindings: net: hisi-femac: add binding
 for Hi3798MV200 FEMAC core
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240308-net-v10-6-3684df40897e@outlook.com>
References: <20240308-net-v10-0-3684df40897e@outlook.com>
In-Reply-To: <20240308-net-v10-0-3684df40897e@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709887184; l=1017;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=UOldq5CRtsm/LbzVGbDAknoLyxLVr+a/RNgHhOeLLzY=;
 b=UjLXcDkC1iGFxi4r1mMdTBtvkykYwtbSeS3izlFvAwHbVZVcNHy9Ytu+vGzY+PRDPV8xlTyEn
 Eni2Eu0RJFpAO/Wuqel4d92H1pW0z83RdLmqmmF+4pOr9ysOIsBI19t
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

HiSilicon FEMAC core is also found on Hi3798MV200 SoC. Document it in
binding. While at it, make "hisilicon,hi3516cv200-femac" as the fallback
compatible.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
index 5cd2331668bc..cee10d263d0b 100644
--- a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
+++ b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
@@ -14,8 +14,12 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - hisilicon,hi3516cv300-femac
+    oneOf:
+      - items:
+          - enum:
+              - hisilicon,hi3798mv200-femac
+          - const: hisilicon,hi3516cv300-femac
+      - const: hisilicon,hi3516cv300-femac
 
   reg:
     items:

-- 
2.43.0


