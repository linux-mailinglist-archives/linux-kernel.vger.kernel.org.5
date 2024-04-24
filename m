Return-Path: <linux-kernel+bounces-157200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 989D48B0E60
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DFFD1F237FD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA1B16D4EA;
	Wed, 24 Apr 2024 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQZYzapv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0464A160873;
	Wed, 24 Apr 2024 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972571; cv=none; b=ZISuj3HeD3e3zX3Ji9rOBtlG96SgK37RoHI/1S8OvyDO/U5SmWwRZNyOuXLCBTvhDsPj5iSGGGJvSYYBwi9jHi3mtVATCLWFw4L9yDD39Dgztgeu/dgCkPwUlwU9ZrULp/AUkzImxlQ6Rgx1A2s0F8G6OlFKYqZdJPiPAs4/G2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972571; c=relaxed/simple;
	bh=GHuQ1HT+FCoEdjc3sTAOaE6jN4Sii4ShQFjHbxCz/4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vbi96qvTNOeFELpXNWQW0Vqph9HMP8aLoHaKVz5B7cFebO8UETO8uWmJdbS8qR9FwCJPkmHAAGk3b5JQEBlYHdl32Tjzc7aYJhPzZphm1/74AqJugOBI125qZeMEF2Fx/TWhYT0KE/0UoYiwhx34JjABRasOcO+yRG8FiAKPYnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQZYzapv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB173C4AF67;
	Wed, 24 Apr 2024 15:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713972570;
	bh=GHuQ1HT+FCoEdjc3sTAOaE6jN4Sii4ShQFjHbxCz/4g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FQZYzapvKPsStieqUCu1gfkOJ3Hl63RXAFnRMHTtB3ebc+OmeGPVe7Y/CngvMGqal
	 M49hFPk5N/CPqn+dzlnHP8aZWz3OcYqcvoee7gRWkk4idwNM55Do6xS9TTv9DaiCyT
	 IoumS4hPT5gXpKOgdP1TjLHyXYVyFf29CsKmDZWfVLiEb7CFCZ70sHSjzGUhY+23Ic
	 Ew97MMdfmAiTJe3GFumxmZ4oWCGa2637ImEGul2TspgxEub2InP8lPtKrLCgOLGcUb
	 JShv/xwCtCZfCrpWYhdpXMkiBUf1cviouDhU9VW2Vglis+fkx62TaHqe9SXO5kCbW9
	 ZdfDIjV6d34Mg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2681C4345F;
	Wed, 24 Apr 2024 15:29:30 +0000 (UTC)
From: Xilin Wu via B4 Relay <devnull+wuxilin123.gmail.com@kernel.org>
Date: Wed, 24 Apr 2024 23:29:14 +0800
Subject: [PATCH 09/10] dt-bindings: arm: qcom: Add AYN Odin 2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-ayn-odin2-initial-v1-9-e0aa05c991fd@gmail.com>
References: <20240424-ayn-odin2-initial-v1-0-e0aa05c991fd@gmail.com>
In-Reply-To: <20240424-ayn-odin2-initial-v1-0-e0aa05c991fd@gmail.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Junhao Xie <bigfoot@classfun.cn>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Tengfei Fan <quic_tengfan@quicinc.com>, 
 Molly Sophia <mollysophia379@gmail.com>, Junhao Xie <bigfoot@classfun.cn>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, Xilin Wu <wuxilin123@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713972563; l=733;
 i=wuxilin123@gmail.com; s=20240424; h=from:subject:message-id;
 bh=IWMEwTxqsDx0Pa+feRUvwg8F4G6cj6QTAKgbPe9K9dg=;
 b=iD8DU0abmJ2QjedN04FauD4gidVpA+VEmLsIeXWjq4WakuoBBDP8fgdmXR8tOuuCLrz2NnT7r
 64ShVrCrXD7BVvnsjrEyKIz1oDbYkgB17nJGRA3pr/Nbocbh+33xUJm
X-Developer-Key: i=wuxilin123@gmail.com; a=ed25519;
 pk=vPnxeJnlD/PfEbyQPZzaay5ezxI/lMrke7qXy31lSM8=
X-Endpoint-Received: by B4 Relay for wuxilin123@gmail.com/20240424 with
 auth_id=157
X-Original-From: Xilin Wu <wuxilin123@gmail.com>
Reply-To: wuxilin123@gmail.com

From: Xilin Wu <wuxilin123@gmail.com>

This documents AYN Odin 2 which is a gaming handheld by AYN based on
the QCS8550 SoC.

Signed-off-by: Xilin Wu <wuxilin123@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 090fc5fda9b0..8e991f2bd9d8 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1003,6 +1003,7 @@ properties:
 
       - items:
           - enum:
+              - ayn,odin2
               - qcom,qcs8550-aim300-aiot
           - const: qcom,qcs8550-aim300
           - const: qcom,qcs8550

-- 
2.44.0



