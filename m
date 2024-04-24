Return-Path: <linux-kernel+bounces-157539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CA28B12AB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE4F2879A7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED65E2B9C4;
	Wed, 24 Apr 2024 18:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9L+IuEX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC9B1A716;
	Wed, 24 Apr 2024 18:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713984157; cv=none; b=hg8NtY5AApA20IIqBBZNizwT+RMLgvEau8XEW77qWehWlmZKAFfjhNEj8I/b73jpu8h4b/k7dp11Biz//gZU//mAOGFpxcz+jXI9aw7ZoqUJI1sx3rwTxn56RPXiFcDXQjFLaV5McBMvUy9jyqCDcbtWCAEgpb0umKWpW3sWQbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713984157; c=relaxed/simple;
	bh=YV1l+NL1MbUX6QcpNEWpuWiaO5iXzK1TAEsfxx+4Rzo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VchuClR5HAhzFnfn30tjnBCYt81oEhvO5mfBCdPgYi2pGaOmsbBTM2yz/2+N9cni+rqwYvICACiwYKPEc22GOAAwGZEZiMD67UJngW28eEPVdaJoug9XG0PJ5LcQvvu0b4Jzf3aVbdAneNXpppJsoCoCB3C/Z8JWwyiQqhxHLd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9L+IuEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D91BC4AF0A;
	Wed, 24 Apr 2024 18:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713984156;
	bh=YV1l+NL1MbUX6QcpNEWpuWiaO5iXzK1TAEsfxx+4Rzo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=L9L+IuEXthD0lvZJQZ/7HP25GnMBy36ColtjVo6argejgpPv3vA8uPUb01EIwMolm
	 Iot9t2n0Ip3laYvHESrOxkQrxQP9ljf8qUIUgE7JwY76Sf2l5aDSj2a3537n1+e7iM
	 3aCLYJRKnuPkoKnjoqtH+FT7i4iFfNh39AdjVX1uRAmyAtYQEwZ7zGBRZgxDDV1qXU
	 WbujykTSL6ffoEuPEgU6k+6qPzuE3uwbq6/NX+M81bONSYez3+hmp4K5cxl8L6XayH
	 zYR15lTfEhmkqCs5Q8TJ3tTUTQlB0KOWrmD2LmYJjH/cBpUy+hBjfksn5TlInwttFy
	 ST/as7qk63S8g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8109FC19F53;
	Wed, 24 Apr 2024 18:42:36 +0000 (UTC)
From: =?utf-8?q?Duje_Mihanovi=C4=87_via_B4_Relay?= <devnull+duje.mihanovic.skole.hr@kernel.org>
Date: Wed, 24 Apr 2024 20:42:29 +0200
Subject: [PATCH v10 02/12] dt-bindings: pinctrl: pinctrl-single: add
 marvell,pxa1908-padconf compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240424-pxa1908-lkml-v10-2-36cdfb5841f9@skole.hr>
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
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=989;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=KkKUaK2SeDyP20scuUXm7oVk+QfHUL3F87v8Iwvt8qk=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBmKVKUl27/OG+PLk3ZXfgd+Slke19f6jnwssT/t
 Ej89zrVxnmJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZilSlAAKCRCaEZ6wQi2W
 4SowD/9Z1fBqrqZtXeWdIrjCtAVge6G3+6l00V8MVHqJpjOnSCPTo0EcDaXOrSMZZCwnjUwbWCB
 GNFzU1sFeYBEp2Tmk7RT+wAB+UAaJNA8AlkPSF15DJhezdiHfVMibW+BEil7/kzolcSbDB+Pm6A
 xOBtQ59I1r4XmyohtVaZFqs7qJVrDv6z9ZmwdZL0RmCB9BrjxTRkv3lO3BjFT9dVpphNsNfmLpf
 u/6U/LV4hV6D1swBbDqcOKscS29SJ2ISMgZL6ipRApB8Wbk3w8GsvMzjWszGQ6LfezGspxehlnm
 sF5j5u281gFYzB/LuKOp/Uzw/PCNmDUyt+258QCusRnb/dHbsN6cfzkctobk15383Tw2PggaXhj
 7gxaN3kxLc1Rg5Lf84/mQotyLApkzZH4eTId86jd+ApYSq22XPNUd4CmJ6Aev6Mwy1NTFV8wPZ2
 djYLmYFDLQ/FJm6+EraY1bEjt06Iy3b2yPV4SVHQrSZ1mIyPb0+BmcAUvuSXXi0EhD1rLuxJMHe
 jLSK+d8peMZMiQiG3mIEqvlBYyjfPY3acounggQo0FgQEWq2XfF2tlpxgCZ6Eh9TTRulxFHN3lP
 5tuZK0cb/UYhlcwkUerOevSEyW0BYqcrw4y/NFfKMoaXfD4l8+g/JzniMGs21McWMPACio0R39k
 x5KLyWuowS7cLvg==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Endpoint-Received: by B4 Relay for duje.mihanovic@skole.hr/default with
 auth_id=112
X-Original-From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Reply-To: duje.mihanovic@skole.hr

From: Duje Mihanović <duje.mihanovic@skole.hr>

Add the "marvell,pxa1908-padconf" compatible to allow migrating to a
separate pinctrl driver later.

Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
index c11495524dd2..1ce24ad8bc73 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
@@ -33,6 +33,10 @@ properties:
               - ti,omap5-padconf
               - ti,j7200-padconf
           - const: pinctrl-single
+      - items:
+          - enum:
+              - marvell,pxa1908-padconf
+          - const: pinconf-single
 
   reg:
     maxItems: 1

-- 
2.44.0



