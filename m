Return-Path: <linux-kernel+bounces-157544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C89C8B12BE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6296AB27ADB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627483BBED;
	Wed, 24 Apr 2024 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEXBG6G1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707921DFFC;
	Wed, 24 Apr 2024 18:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713984157; cv=none; b=K3bSeLB3ZvBqKNQco3fDmSMnQnA08rZeJy9OdJlCYWrmrLs2cNcN7oBUuK7FnV4YeGpa1Qw8gr/LcoT3eGR47GWVnzwZGy7zptfAzWs1Tvnsn5x2YNlWNUR4XMOziQQIFl09b9T2fU7zCuyp3kOop8RINNSymezox9L3wRUrOUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713984157; c=relaxed/simple;
	bh=m+jGkXmz/06xN/vTyIiIQoo5inOHPhkIHkuPPQhvSMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FPa874nU/4AWyUegGxsY46DQ8HhOYEn4Pqh3Ir9+ai7EwTKbTzFS8DT6+QX6pp5Lhri68P/cxGTtajVwFeqjN0BDUvi4H6TbRfYHHHaawPUOGAuzxKUaSxF8/ONZemb1JTfQJLiYr/YNSVb9GTzGDfEOkfmLrlrW1MzQHxcZJrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEXBG6G1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DE92C2BD11;
	Wed, 24 Apr 2024 18:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713984157;
	bh=m+jGkXmz/06xN/vTyIiIQoo5inOHPhkIHkuPPQhvSMk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YEXBG6G1zFjNzwhPz9Zs0YhppH2UHsYWARknfv8YGwPcqWoI3KbMspBhlxR/V3VXB
	 M3KGnnZRfaM6MgHqeuLLZzWAZl7RgYgoAIYa9QQ8MERkEE53hDsnvXJ3+YQKDCxzIS
	 +Gv9MV0oR+aTWiiJJxuuEoGrAYD5oahAte4pci/zBftuM1ih/7jEh4zvUvq/JrtNG9
	 VcmeDzg0/E/BN/jjFStBBSC9EEzu3YIeYbyy1RBkrDsbbKrtxC9mcwi/LvlvIbgHm6
	 i3D6s5zgNOt6RJoieDNeG411sJz2VS4tUyVDYlXB1yfvywxsYvxaX8tv0CpE4ipZL+
	 Wx/lwIukaABaQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30094C19F4F;
	Wed, 24 Apr 2024 18:42:37 +0000 (UTC)
From: =?utf-8?q?Duje_Mihanovi=C4=87_via_B4_Relay?= <devnull+duje.mihanovic.skole.hr@kernel.org>
Date: Wed, 24 Apr 2024 20:42:36 +0200
Subject: [PATCH v10 09/12] dt-bindings: marvell: Document PXA1908 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240424-pxa1908-lkml-v10-9-36cdfb5841f9@skole.hr>
References: <20240424-pxa1908-lkml-v10-0-36cdfb5841f9@skole.hr>
In-Reply-To: <20240424-pxa1908-lkml-v10-0-36cdfb5841f9@skole.hr>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Haojian Zhuang <haojian.zhuang@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 Lubomir Rintel <lkundrak@v3.sk>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Rob Herring <robh@kernel.org>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=890;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=+wdJL/Vtg+IC9uzo2i9e96b+dkkyPr63PvOur5KT8gc=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBmKVKVIBYsEytUyJd8oGqAJAOqjbQngyPWzrdYK
 7HGB2hqFqWJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZilSlQAKCRCaEZ6wQi2W
 4USaD/wLLRbFPuTWEtYuyS5px4fRWghtgdvUbmHh0SjsuF5PL7R95OhGodO9nJQquwTcYHAwZwP
 5fLe40LbmCrOIquAF3I3vUcr3JnQIAiHAg/Scn1UkjBT1GlCQK4/NifXF8s9qEd6OZjyNhTvtS1
 HSpDuL7E2VTKSOKDDa9H42yHvK57U5/jLxE/q/kp5vXjTXWs6x0p6Hds2qR+fs7QnVJ09T7wszg
 SDIssc8btUJcppyPDS9mhVh53nCFRZbO0GgRaG2VWnFlHUvGp3gODcdlH1P2D7SN9x/dHf0Sji4
 vXbqRU6A8d7cVhBshStPGkeLknJXkpfUh/23gZJUJh68lCy2nWxiYP9DMLE7c1tfAFu0E5dtGuQ
 rQ7o9s+egoo6J+cLHBA+nuvTXMoZCQuey4FTaoIpi7Wn1QJP5lxxfc+VdhTH44oCVDx6ppP0LNQ
 D09I1axki7uYB93o6wQ6IvUGJItfbV92EOHUMB5b0PYoOjScyeWmuDQN3iAs8I1eHG+Kosa8qvg
 fqIQapFwT72KQAhi+S1uJNsHTayN/ZNLwb1dKFH/ANpg7sHtRw8cEvsvykwDyV76nh1DMwC9fM5
 BAUO9NRSilRLPIXZvttvXP+zV7uE6c2KuQJzZAyDSwSPFlyN6c2kTmzNuIiviDrtZ3Rn67eYtLB
 W+u8pOhSkSzSK1w==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Endpoint-Received: by B4 Relay for duje.mihanovic@skole.hr/default with
 auth_id=112
X-Original-From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Reply-To: duje.mihanovic@skole.hr

From: Duje Mihanović <duje.mihanovic@skole.hr>

Add dt binding for the Marvell PXA1908 SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml b/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml
index 4c43eaf3632e..f73bb8ec3a1a 100644
--- a/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml
+++ b/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml
@@ -35,6 +35,11 @@ properties:
           - enum:
               - dell,wyse-ariel
           - const: marvell,mmp3
+      - description: PXA1908 based boards
+        items:
+          - enum:
+              - samsung,coreprimevelte
+          - const: marvell,pxa1908
 
 additionalProperties: true
 

-- 
2.44.0



