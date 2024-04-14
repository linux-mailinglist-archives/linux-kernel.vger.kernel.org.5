Return-Path: <linux-kernel+bounces-144127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6468A421E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 13:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18DEC1C20F0B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D32A44374;
	Sun, 14 Apr 2024 11:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1CYieYs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DC736B1C;
	Sun, 14 Apr 2024 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713095180; cv=none; b=qAcsC89GI6J0ItcsvdiejZRFRQzqmkSjqH3bpGPHg61xHzsk7P8hBudmCPqkNabhoD/kd9vKEuAoqWXFLXvqhDWLKZm0CcTOZXd41eokPpP15zDSK3P7W+Db1m9qAu5bOoa/YVw2kIUdAqQkUw6yLUxvnm24Vmg4y7qVUO5yvLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713095180; c=relaxed/simple;
	bh=VtSh8GgT91MvWTH7D+XogmTxktb7ZjbbxLqSixs0+g4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CIpFwTMqQWnpE6qYr8TTK5E4pTGjzPmPvXjM1o4hJN8vQozP07sfyq+PPU/oEB2Pcl3gS64aZSSVLgPHo/vyqaMvrYzpMtlrWnaV8k9wP9JVLFqZgqtKfrdbHCnrFH53b8JWRvUpouIyq5nAOxBdjoFwU8r5cjshZl6Gdmt0QCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1CYieYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F5F1C32783;
	Sun, 14 Apr 2024 11:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713095180;
	bh=VtSh8GgT91MvWTH7D+XogmTxktb7ZjbbxLqSixs0+g4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=p1CYieYsIyzac/czlQceN/EQWbEgZ2m19gUAeVQaV0VmPDOLue2nf6MeFt+ceRx8D
	 lIkHvHwt0cBgQDBHRYWjZwoVVOWSON4Yrosbpns+npiyInuITf9oeVU2wRMA/WAWAh
	 2sD1aCbH5WReJo0Z9VOxDToWVOQG8Fq37GluBGFS9BMfiy8RCe2BFK/I7l+JWVEKk7
	 uMnG8iJUnxkrzYIelnS2xSEbgcpXaYKY4Up3TnizauHS5aJGGC4ls4g1aA2h+ZjRKQ
	 b3Y7/6JIclVP4cBXWdAQZ1RZZR1qGu3XmlLFYP9s7a24u37iVVeZ4oj9DgmhYtS1P+
	 ufnLuXf0as+xQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E37C04FFF;
	Sun, 14 Apr 2024 11:46:20 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Sun, 14 Apr 2024 14:46:01 +0300
Subject: [PATCH 2/4] dt-bindings: arm: bcm: add bindings for ASUS RT-AC5300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240414-for-soc-asus-rt-ac3200-ac5300-v1-2-118c90bae6e5@arinc9.com>
References: <20240414-for-soc-asus-rt-ac3200-ac5300-v1-0-118c90bae6e5@arinc9.com>
In-Reply-To: <20240414-for-soc-asus-rt-ac3200-ac5300-v1-0-118c90bae6e5@arinc9.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
 Hauke Mehrtens <hauke@hauke-m.de>, Rafal Milecki <zajec5@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Tom Brautaset <tbrautaset@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713095170; l=771;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=fzGThLw8t/XG2JnsphMo88X0nVs2eVDvx1mTdRhk0vU=;
 b=UIMEGH8FpZhR92Z7th/HwS/UfrESpub4N7ji6oCgrjtXW9xHgEvrW3i1QtIFaENCB+pbLTeMp
 Ed9gfTdAfDEBGQ3BM/IH2wdBecR2YNSZ8h7KdI68LVr0GmqsUdLBZPL
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt
 with auth_id=115
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Add ASUS RT-AC5300 under BCM47094 based boards.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
index 215bef740aca..d925e7a3b5ef 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
@@ -68,6 +68,7 @@ properties:
         items:
           - enum:
               - asus,rt-ac3100
+              - asus,rt-ac5300
               - asus,rt-ac88u
               - dlink,dir-885l
               - dlink,dir-890l

-- 
2.40.1



