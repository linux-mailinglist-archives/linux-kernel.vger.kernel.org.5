Return-Path: <linux-kernel+bounces-151096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5804A8AA911
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E3E28561A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EAF4AED9;
	Fri, 19 Apr 2024 07:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmatn8Uk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D08F3EA9C;
	Fri, 19 Apr 2024 07:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713511370; cv=none; b=J89kncOTixrrYhb/In0yeJ8BZC0fJ642niS6BGct+JLDbQujsZuMzBZaDar+ETQAbr8039BNpm8QbnC7HYoWLiSp1vhYG28zfcuMOb1ZN7tbedx9sskDT3DByww/p/yFBrzEMoOSL9QamzGP3cgNossRFPq62Com6E3ctvcAL9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713511370; c=relaxed/simple;
	bh=+Ki+y+oOlJkXf+8GfyodfprS3kBHMk0C/sDmofucD/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bTZptQZuP3orTHAQ21jiKFVlkqmjVfPOxPtx9PQEAHssJm/AqeQC+99MMO1kZlp6i3sYN8Q/OjLKQ802MchjMYNlU1EWR7TSEjJcoWgYyyRGQcWrxd8/nm78naUqI0QTL5AiShBeIsCLWg0zDjJ5y666FRTdore/DizqrSpeaSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmatn8Uk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D714C2BD11;
	Fri, 19 Apr 2024 07:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713511370;
	bh=+Ki+y+oOlJkXf+8GfyodfprS3kBHMk0C/sDmofucD/U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mmatn8UkCYzR5FBYz07kiMNG/59+oR99A+wtXSWoHXH7tGliw8v9LGRO3jBumO1Ir
	 iMCSEfKkEIFPYita5e/yqDcqHRSlaDuzAyTaLmy7z3Dob4XS8PKxHfwN8xFPftxOWg
	 +sx64lQCq5/xbJQrPMcLQD2DTywAouVeNeGfDUwOCv7ZK0qTs6Dc0fmCwZ/rlrFCqd
	 aL3uyqdPpJqy5CfMyL6duNjPyeOoJdDy66fZpUFMeLC7qfBLamcWP3X+ZBt0G87f3k
	 CezQ67kISQXoJ1Pbtt7Ry+x1SxlfNhs1AnKX6x5wDjx99lJGc3NEcMYuxQf8hfUc5h
	 Zk+Lc+4zPOSqw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE93C04FF6;
	Fri, 19 Apr 2024 07:22:49 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Fri, 19 Apr 2024 10:22:48 +0300
Subject: [PATCH v2 1/4] dt-bindings: arm: bcm: add bindings for ASUS
 RT-AC3200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240419-for-soc-asus-rt-ac3200-ac5300-v2-1-f95ff50c2a4d@arinc9.com>
References: <20240419-for-soc-asus-rt-ac3200-ac5300-v2-0-f95ff50c2a4d@arinc9.com>
In-Reply-To: <20240419-for-soc-asus-rt-ac3200-ac5300-v2-0-f95ff50c2a4d@arinc9.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
 Hauke Mehrtens <hauke@hauke-m.de>, Rafal Milecki <zajec5@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Tom Brautaset <tbrautaset@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713511367; l=835;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=j6C9XYG4vLVN+NzaIcMBXdgQq43KpkgAe4BMdqdb8ws=;
 b=MNGq6j4BOJlQCcbPbZetPMeufNC5JHnRgxOqk+4k1uPYhuAzDcvMtWx1IfZPhmCEh+UuE6srL
 t07TpVbcawcDQVt+AT8vwX29q78QhQpHC6MweX1HNJBpjwkTDkC4prv
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Add ASUS RT-AC3200 under BCM4709 based boards.

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
index 4cc4e6754681..215bef740aca 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
@@ -53,6 +53,7 @@ properties:
       - description: BCM4709 based boards
         items:
           - enum:
+              - asus,rt-ac3200
               - asus,rt-ac87u
               - buffalo,wxr-1900dhp
               - linksys,ea9200

-- 
2.40.1



