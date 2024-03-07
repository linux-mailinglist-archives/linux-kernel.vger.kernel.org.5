Return-Path: <linux-kernel+bounces-95433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 015CC874D96
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D5F1F26788
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A16012C81E;
	Thu,  7 Mar 2024 11:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHoekiVR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FD0129A66;
	Thu,  7 Mar 2024 11:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811290; cv=none; b=sT1ijt6/4myVLZyKx1se8sVHSOF+WEPBKGOMdzvM6cD6adfqMI9P3pXZr2wZFkHLM6J9hq91a1B2E1y5hMT4BV5+EPtRmzRwue63eyakzP3gZi7wyFEvTtlAIU0y+X8eUFTIAfbB26BkiSaCzyjgAIPQQlCZOXLrQUA8kRy5aHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811290; c=relaxed/simple;
	bh=B0C5pNXKXvOavXw/bCS49aMctGs7Fg8+eH4NhCckLqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JRVJEL3Q54egK3PY6EM3ne/Xk8K4dhSV0soeVDwJ8Sr93de0Grj2x1Jz5q+t18AtESmksiZ0cNGySSzHS3M5SpULJmYrCAoNT907MZ3njVGMTt5+M6SzHjq1+5ulaDTL+FWHerCiDYQFg9yXHSCuwkZZHmpYRXadOMocYt+dmrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHoekiVR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F69BC4166A;
	Thu,  7 Mar 2024 11:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709811289;
	bh=B0C5pNXKXvOavXw/bCS49aMctGs7Fg8+eH4NhCckLqs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nHoekiVRZ4LQ0UR+l9YEo8O68A/Ym2y9D+3cQAMPDlboJjJrvtnhVbqLf1dcoshKA
	 /FEJZNTd/3+/On5WG49RiwLooAaw5rhlycwYy5a8jk72II8gp0LqJPEmUBfxZ84vce
	 kRURLSOcr/xdh3eUMGArMrCSFvcH28PkZI9m+DDuXNMH+ZkuiHWtx7z+OrXt3E4iyS
	 j0iTa7nJ51R0y6saExjSbPxdNA3j/CDeI6A/rvOM/1ryrOEVvARjL9jtZFqPEdaVvh
	 dg8UatMTpr/xgSbpaQwsu2iROzx522C/Owi/7sKQwoQXZ2SSLVnqMCs7Q4EJY8G0kH
	 fW9lFV10tAODA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8F8C54E5E;
	Thu,  7 Mar 2024 11:34:49 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Thu, 07 Mar 2024 19:34:52 +0800
Subject: [PATCH net-next v9 6/9] dt-bindings: net: hisi-femac: add binding
 for Hi3798MV200 FEMAC core
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-net-v9-6-6e0cf3e6584d@outlook.com>
References: <20240307-net-v9-0-6e0cf3e6584d@outlook.com>
In-Reply-To: <20240307-net-v9-0-6e0cf3e6584d@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709811287; l=834;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=5BWYBEwUYlHXBQkC5dFDbigUBgjxRE1IxBueme4TLEM=;
 b=O7e98hdy3R+731XT9ZPwOAQuxiBXV4WY8pe3OHfvOCGqHGRoOfdNunvoz8YVLFIYZuHYaJYVW
 HlRCy8ZUgYwBO8oLM3xwKsbnJVp+JtfzsFr4shlniFRc/SAHppWe4yR
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

HiSilicon FEMAC core is also found on Hi3798MV200 SoC. Document it in
binding.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>

# Conflicts:
#	Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
---
 Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
index 5cd2331668bc..4f8a07864eb4 100644
--- a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
+++ b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
@@ -16,6 +16,7 @@ properties:
   compatible:
     enum:
       - hisilicon,hi3516cv300-femac
+      - hisilicon,hi3798mv200-femac
 
   reg:
     items:

-- 
2.43.0


