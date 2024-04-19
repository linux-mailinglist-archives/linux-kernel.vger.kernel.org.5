Return-Path: <linux-kernel+bounces-151096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D963F8AA910
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF8DA1C20B74
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E3E4AECF;
	Fri, 19 Apr 2024 07:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rb0Plfef"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D041BE4B;
	Fri, 19 Apr 2024 07:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713511370; cv=none; b=dh4xCk6Mk0ImhaMPvi73SANa3Ayj7KLpFbdjq2JIACETm8fefHOZh5blSaR7TA/VvfiG5F5o0f9aePaYprF4UW88cCOwDTuuqS318GGqz8Yrqg/nWSfNpy3zcc41vYIYIcfRe7wBCTZnHB4gaQ8ooAeHKwXdi2XCqcKxUvWNAEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713511370; c=relaxed/simple;
	bh=D58bpNiwkjigEqu3orXa0dwljJSDDM8OT7oG26JXKrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dt8f0pSa83WKbWFxzygwVhR9diP63Uhmlqd9XwlXiUTCE3jiH3IYPBU2aa1DGmFiSNuFp5mXEfcloPzUxchkBcvr25lUrM1zPpF8OvOiChtpji2+kWFVcd9ssJqfR7ZwOZeLbK8i8iQWBUUde4vwiilOv3DA1uNwFVZU5p+ZNoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rb0Plfef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1BB6EC2BD10;
	Fri, 19 Apr 2024 07:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713511370;
	bh=D58bpNiwkjigEqu3orXa0dwljJSDDM8OT7oG26JXKrk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Rb0PlfefTV2Rco8ASZ0ZKuhtpyi+LFclW78Z28ndeawgjuyDMwWaiFgLtgh7La1dq
	 tmsvTa7EX5r70JIWwwUk/c+rWBMOvyHFpmgP7fZLp9p87rK4IO/667i3KqsftSzPt1
	 rHzOj5fdrliV5kVXoxpRohAFiqK7WX5nCz9fwkPtRztqEJNcVi7y++UfwMEauf6wej
	 5Tl8fYr+uAC20ImWuzeHgtU5Sj2AaDtkFj7pOS/jpDc5bJxDTcPTS24xlXoEMjy5HS
	 pfQLf1avoJe+n+XIAG3fMbiD5hepS7yqMlHQjkKVPBeohdj5T64Jw7uhBG4y9tD0wF
	 QmkHAtpooh51A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFEFC05052;
	Fri, 19 Apr 2024 07:22:50 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Fri, 19 Apr 2024 10:22:49 +0300
Subject: [PATCH v2 2/4] dt-bindings: arm: bcm: add bindings for ASUS
 RT-AC5300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240419-for-soc-asus-rt-ac3200-ac5300-v2-2-f95ff50c2a4d@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713511367; l=820;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=bR3OtlLxsoLW4OgOTwPQgCaooezqCeVMoRpFlbGyxMw=;
 b=OlRqBDfb2AcCU+yrrWP0o9JW7VASoPbD5oYxLhHuz/jzORKs2vF12oeyD2ytzUHsFzuNOl3zG
 RCgRyCTWR5SDLQYrCZgk9V7+rB4aMiNiQeH7fMjMFavUe8KTY++61Z9
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



