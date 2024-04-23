Return-Path: <linux-kernel+bounces-154812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5318AE157
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA90A287AE5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2269960275;
	Tue, 23 Apr 2024 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObGKp8j/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B59C59B4E;
	Tue, 23 Apr 2024 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713865860; cv=none; b=r+nOzwSRgN8TGCCGvOYBmZslFRDFsVLWacXrIF/IIC9oR/MSMFYmDr9MvmXJqlchdwn4ivldwiRJM9BPIPdbZQ9JGju3eB6dsYd/A4zammvlGi5+uTHhR/6peMy3gEnFOZhBj869fD5JfDselFpnv/SN+uewM9VGw1Pvum9W9ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713865860; c=relaxed/simple;
	bh=+Ki+y+oOlJkXf+8GfyodfprS3kBHMk0C/sDmofucD/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TQwEP99H3tJtwdPrqyWxQ6hNvhJuRZyYv+Hn0JDMjO6d6T92XyoOifT1AtjPF1J6fOOu0hHMbaEYq6wZijMCZOLIGjOe60T2SCocwnw4jED7JpF1qbGt8U0ZFEln0v750QPIPPAPwDYHKoIAkDVhzuOxp/QdkH5b8AvJAnOfHnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObGKp8j/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8F70C3277B;
	Tue, 23 Apr 2024 09:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713865860;
	bh=+Ki+y+oOlJkXf+8GfyodfprS3kBHMk0C/sDmofucD/U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ObGKp8j/USdRDtAAEhm/egqMYmyTpWFbl1/bdAAKnCe066ywX+VTFMjzM5wIc9leH
	 oeU0xPzxc1s9kfKdaiHAbscKJVxLLMablsj+VX+jffA1lH50a+hyyqxeqMuUMc2MEF
	 7ufhPjm1f90B3QawGtgqllm14ffxpS4YpG+ZiDabRaO7+bIPUMpqwD27d0ixpL4ApU
	 pnONa+fTq+/U5i8duLrUj0K1uw0bnMWHF0T9rDHsg3vEtr/Fy7+5w8hTx0Zd5ro2uo
	 KhgK5EBlX5RmaGJHIK8ogzHotaZLNPoacXjeuhc4cTJxlWlnXwPncQxdYPEqPn8xS7
	 mPX0HHco/8K9w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA135C10F15;
	Tue, 23 Apr 2024 09:50:59 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Tue, 23 Apr 2024 12:50:45 +0300
Subject: [PATCH v3 1/5] dt-bindings: arm: bcm: add bindings for ASUS
 RT-AC3200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-for-soc-asus-rt-ac3200-ac5300-v3-1-23d33cfafe7a@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713865858; l=835;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=j6C9XYG4vLVN+NzaIcMBXdgQq43KpkgAe4BMdqdb8ws=;
 b=4lpXT3JtgHo8WW9dJStKgQ72i4VdH+Pnh8JAzHn23gA0zLUNFd+Qr/F0bi7hgDQA1jMxzhlhp
 BlkLDxbR8H/D91gx7jG1BolX5QO0T8XLM1gLW+Qczej3mlUQzJSAnsA
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



