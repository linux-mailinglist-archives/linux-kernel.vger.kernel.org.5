Return-Path: <linux-kernel+bounces-154813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 680848AE158
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9970B1C223FD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269D060279;
	Tue, 23 Apr 2024 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ddv5C7Jc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5D45A788;
	Tue, 23 Apr 2024 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713865860; cv=none; b=gP7xuJPgylxKixjgy50NoZ3LYxRKDv2JJmB/tSXNAZloFEcrCx4In5lhSAsP/iGMCfZc9toTAVGjh1wTXG62uRX+c2d5xRZjMonaqCk2ZgpTDnURidaslnKaOhlmmX0Qybl0LUbMT/+dWLqRPKSBXBOfsZhC6aBsWO2YynOYqO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713865860; c=relaxed/simple;
	bh=D58bpNiwkjigEqu3orXa0dwljJSDDM8OT7oG26JXKrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RHpjcN5gbMPPOv9DluVLGHXyoWaoXogVrE+6Hp1XlnSDJF5NIsWmW1Ct2cvl10TRaM+Ruey+L1hzJPH1httzl3mM9q9XgVxgIYZwFnQnKKGz6CBFnto4Bnf9Ibg45/A4TX6K5xDEbcVNEoo378nij1gPdPFWS5yw8yp2rYvimTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ddv5C7Jc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A190C32786;
	Tue, 23 Apr 2024 09:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713865860;
	bh=D58bpNiwkjigEqu3orXa0dwljJSDDM8OT7oG26JXKrk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ddv5C7JcA0imZoNoMYVgKdxrakT4mZUUfMFBmjpa43/M329RD2BJ9V3cVTZIvyJfX
	 v4qnhKDIClS6k461R6gR53N9b6bnPrMCeRoP49bjDdstejI4uDw5pZl7DX5nFL4P0Z
	 tV2Oxwg9SrTUf73IWYup+lbXJF6szxLACaBa0I9rDDg6BXtKQXE9bf1k0otfDyJ3w5
	 Jn6Fgdgqd8Jen4ssWKCxlvdcK42aSn5j+h4dqtpTCxozLsniOx7BNozVZIaUDWYiMv
	 pFf3R+rI0Q2l/Q5KN9GB0mLwkZ+W9mXTNlWG5RO99JtmjdA/Bd4/r8JH50kaZb/ysr
	 nDNGt2KqryK6A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB85EC18E72;
	Tue, 23 Apr 2024 09:50:59 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Tue, 23 Apr 2024 12:50:46 +0300
Subject: [PATCH v3 2/5] dt-bindings: arm: bcm: add bindings for ASUS
 RT-AC5300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-for-soc-asus-rt-ac3200-ac5300-v3-2-23d33cfafe7a@arinc9.com>
References: <20240423-for-soc-asus-rt-ac3200-ac5300-v3-0-23d33cfafe7a@arinc9.com>
In-Reply-To: <20240423-for-soc-asus-rt-ac3200-ac5300-v3-0-23d33cfafe7a@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713865858; l=820;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=bR3OtlLxsoLW4OgOTwPQgCaooezqCeVMoRpFlbGyxMw=;
 b=sZPI9h9sXXvsKJQNzYSAKsug3RZfz3KggVOvyq+m6a/+7Vd0fOL1c/GIPTxShzMus2Ervcq+F
 PsjcdxDIddzBbAaTjrGn9+pqRtJ1zbxYHeGXoiKdV1AizhCqgan7exg
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Add ASUS RT-AC5300 under BCM47094 based boards.

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
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



