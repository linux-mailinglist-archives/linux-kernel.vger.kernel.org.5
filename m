Return-Path: <linux-kernel+bounces-68865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C07A858116
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D28B1C20F8D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6A0130E2D;
	Fri, 16 Feb 2024 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCHjbjmK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C317B12F5AF;
	Fri, 16 Feb 2024 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096887; cv=none; b=UwRdUTNKSGZOJSZ7Jgs6GsH6Pm/zh/gaY8w9wc2Co0R2PKrp14xpTZdKyu4NuzNGJDaxvyJ3lMNe28BraTrsq1Ny9ZR7vFBOpq5h+lEjhU9G8y+AC8JcXTKdt0i+lhjrCXPrLNKe2T4umUK3866nYhExqqFSoR4O/xYQeJjz2yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096887; c=relaxed/simple;
	bh=TJXbzU7JZHJbMmgN7bpYmAVa1HZD9kd+YoDIdRJkXjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m6PZnYbQ1/Wr/5Es+6gtOVjr75yoMw+hd8c9iIHkg8uT+XAVORQsv2uwtjaKK7ShikxUyiezUrV2h6frde8sEtnUxLCgurZpmNeXMfLO88iUsKfnWFcrfp5JjAk9yhQNLPhmKOabRUsmQzi7Szaa/kmU6dlOmNRqY1Y075SyAwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCHjbjmK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74B98C43330;
	Fri, 16 Feb 2024 15:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708096887;
	bh=TJXbzU7JZHJbMmgN7bpYmAVa1HZD9kd+YoDIdRJkXjw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WCHjbjmKO6YpsXPAvIB3jwb70NDs1r6NM0Ewj2I1BTJ2Q7CnZqrkgf0v6TgMJebGJ
	 MUZopDAm7uPE2TaxE63eESFuEB741w59iP4kpGunq/m/dx4E9VFpRQ4FduuhFjLmth
	 oEtqTj3SMp8LIUFHqZwDN55PTsWuuhWH1NOuCRTHDXpkpwE2QtnrZBhDpwdcMIDl6e
	 t74fVs2nVzHdn68cuA5y0+r0+g4+mHeyDjO+tqgZ1kVOGGnd2OIK4u679civO6qpyk
	 6LJlbaUjlRGsY8tqAXNbcHptBu6lZjYMTWPLX4ZYIcdbkBjK+ywj5rdM24u3AhkGak
	 nkb7j28cF9RFQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CADC48BF5;
	Fri, 16 Feb 2024 15:21:27 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 16 Feb 2024 23:21:04 +0800
Subject: [PATCH RFC 4/4] dt-binding: phy: hisi-inno-usb2: add compatible of
 hisilicon,hi3798mv200-usb2-phy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-inno-phy-v1-4-1ab912f0533f@outlook.com>
References: <20240216-inno-phy-v1-0-1ab912f0533f@outlook.com>
In-Reply-To: <20240216-inno-phy-v1-0-1ab912f0533f@outlook.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jiancheng Xue <xuejiancheng@hisilicon.com>, 
 Pengcheng Li <lpc.li@hisilicon.com>, Shawn Guo <shawn.guo@linaro.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, 
 David Yang <mmyangfl@gmail.com>, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708096886; l=1106;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=rtHmhLoIl6mBEauH6cAKAA937JKk+tiYVqJ8GZyksSY=;
 b=CgorBV2nYcl95Vm5KnS8MREH8rEe9KkH0P/N7GKmgaLXjwaD3aDCrLwkQ6JOuju+7zmYqBWr0
 3U5xWGbglDxAsFtxFZYVxT810mAEkzarmD0QzBM6T5DwTQUoJwGkI5Y
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

It is accessed by direct MMIO, making "ranges" property mandatory for
it.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 .../devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml       | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
index 73256eee10f9..d702878b8e6e 100644
--- a/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
@@ -16,6 +16,7 @@ properties:
       - enum:
           - hisilicon,hi3798cv200-usb2-phy
           - hisilicon,hi3798mv100-usb2-phy
+          - hisilicon,hi3798mv200-usb2-phy
       - const: hisilicon,inno-usb2-phy
 
   reg:
@@ -64,6 +65,15 @@ required:
   - '#size-cells'
   - resets
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: hisilicon,hi3798mv200-inno-usb2-phy
+then:
+  required:
+    - ranges
+
 additionalProperties: false
 
 examples:

-- 
2.43.0


