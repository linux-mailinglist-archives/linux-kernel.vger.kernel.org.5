Return-Path: <linux-kernel+bounces-139368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BCA8A0215
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73775B23EB8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40BA184112;
	Wed, 10 Apr 2024 21:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpUVRp/k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0540D1836CE;
	Wed, 10 Apr 2024 21:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712784516; cv=none; b=IakBvXwzRVdWBgDDBivSAWP2gdCgvOPLnnlJw7PI7a0BBe9FtL6AQOFADh7+9hulMm3X/OHWAOyOnJ4iFCs8oDnLiISUFGDBFm95gBQVIsvZV5jYda0jA0dcdN9Es5ApxfvQml+Z/I34kwevPhMhzgBazDufUEtl64gZLlV3bOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712784516; c=relaxed/simple;
	bh=WxN+zQMqWorvDIVyazPuArT1yO5iezAJvm7LrCMATsc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MRwRuqSmcSrskhF1+Kb6GVY0De9v3n8t7IPHWND9pQlzPXSZxBV9c2OHVIUCYc7gCGL42TiSAjV2q9YFkphyufgf96SCkZgI5Q0VfFgVKCDLu1E0dohjYWwmjYjUOwK5YcbohdbVNHoXYJCEmXgWc/JSsvh3zpQCovU3+vR+Fns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpUVRp/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F290C433C7;
	Wed, 10 Apr 2024 21:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712784515;
	bh=WxN+zQMqWorvDIVyazPuArT1yO5iezAJvm7LrCMATsc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hpUVRp/kkSvMaXXxWcSvR7sfA29e6PapRgOEqXTHuUf013K/aZ0pHC/DZHhuzU8VE
	 cRTZYyqzjSj97OO0mf7NTiXIM4CTsSxGbhJTtueFOox9McX3uDDnFAIcIp2GkvrXyf
	 iXQHBBKkEOGSjMSfxuNa0ePNt61fGZVHsilmmOs+6u4iPJID1T1pPevWv0E6NqKYJd
	 R1SO4bO2Va6knLgkV5wLrI6SD/dX0sNhIhq+oAPGrCWrLMpNCbG2qjQ6X5OCQzhCy7
	 Wxfu6ivRm/Zll/fAVXBPDH8tr0yieHPRu4zoaB0G1OI8kDZZZ44/zzY5Nnp04GSxv9
	 NFK+U2Bi3NG/g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B816CD129C;
	Wed, 10 Apr 2024 21:28:35 +0000 (UTC)
From: Alexandru Marc Serdeliuc via B4 Relay <devnull+serdeliuk.yahoo.com@kernel.org>
Date: Wed, 10 Apr 2024 23:28:33 +0200
Subject: [PATCH v5 1/2] dt-bindings: arm: qcom: Document the Samsung Galaxy
 Z Fold5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-samsung-galaxy-zfold5-q5q-v5-1-9311ee9a55f7@yahoo.com>
References: <20240410-samsung-galaxy-zfold5-q5q-v5-0-9311ee9a55f7@yahoo.com>
In-Reply-To: <20240410-samsung-galaxy-zfold5-q5q-v5-0-9311ee9a55f7@yahoo.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712784514; l=775;
 i=serdeliuk@yahoo.com; s=20240326; h=from:subject:message-id;
 bh=dteE03ftQTWuAaSunQzfzVFBG+o3qpWAgjOTDgSMFBI=;
 b=gFhHuMi+Aa4MRQ63VwEnnwcUUOx6KS8kiDUmC/lRtxDx8FnvozqMpokdb9CBh1lOjskam53NQ
 w07hAXDH0GfDrXElDxWN1Mhj2XXlro3j/J2LUu5U1rpkqVkEjbKwcwY
X-Developer-Key: i=serdeliuk@yahoo.com; a=ed25519;
 pk=aWyveUE11qfDOOlRIFayXukrNn39BvZ9k9uq94dAsgY=
X-Endpoint-Received: by B4 Relay for serdeliuk@yahoo.com/20240326 with
 auth_id=147
X-Original-From: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
Reply-To: serdeliuk@yahoo.com

From: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>

This documents Samsung Galaxy Z Fold5 (samsung,q5q)
which is a foldable phone by Samsung based on the sm8550 SoC.

Signed-off-by: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 66beaac60e1d..dea2a23b8fc2 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1003,6 +1003,7 @@ properties:
               - qcom,sm8550-hdk
               - qcom,sm8550-mtp
               - qcom,sm8550-qrd
+              - samsung,q5q
           - const: qcom,sm8550
 
       - items:

-- 
2.34.1



