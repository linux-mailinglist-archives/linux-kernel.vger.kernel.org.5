Return-Path: <linux-kernel+bounces-141356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F1A8A1D31
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3133E28699A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1A41CD78F;
	Thu, 11 Apr 2024 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUopm/Xp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8F11CD767;
	Thu, 11 Apr 2024 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854293; cv=none; b=WNB6aCYhcxxakSLzrk/6ICSB3DeXyni/hmGjpVSKrFmeMVDt88y895Fjc3H84NLYRl8nABMF7AfoZrnXIvAj4fecsvn+ffJVSWp1O7EG37lnPd4WS3ro/Mx8FQwGmFVDqSUqxEk+dLKJLW1FqVOxRPBORv4x9S1Is4+1xwSQIRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854293; c=relaxed/simple;
	bh=FYySerEVyxAANRgwbcY5kk9JJxQ+XKSqpf8jmMBQ6fQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jp3oxeuAAt5JkL6PhGV68/KNiR+Nx4bpyY7/t49jvEvjGO1PibrmjrFGbml4WDbO9OGN62qiXe3uM79w0C9ihjk+cfHaIbIGUWEknjzf99gTd1p6aARVdpMne+GP1ipGatNBc713vIXwpOQUdRRwUsM6jDGgjyh6Db3bNXdMKIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUopm/Xp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D26E4C113CD;
	Thu, 11 Apr 2024 16:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712854292;
	bh=FYySerEVyxAANRgwbcY5kk9JJxQ+XKSqpf8jmMBQ6fQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SUopm/XpBbnNFw4DfBIfabmlKLb3QvPx5QIat4nEPnEVdSa9hlqYYrccoccpMZrTT
	 KaXTw1Uvda/t1dIJVH7p44L/wG/nhRsPzE9zEKYW22EAQY1R+9r6D/KERMH2GjSH5q
	 XAPoS+EoeldKla6EAB3hL3DiCLr6BSa0GrpqqC5LL51ullWE2sC2k19I25GtOz4WpT
	 CjKD2VouBMSs14oX8eQPNIgEEieop5c3zDktsGTGzsq4XCf7YzVCks9wgaMWhdwyQj
	 buvvFSY5kHnxa46LAhHOKulagfYgCqyhOybrYg1orZ9zB9SeJjL+uR96prVBPoIEs9
	 D/rUk3DaW0/Jw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4DFC04FF0;
	Thu, 11 Apr 2024 16:51:32 +0000 (UTC)
From: Alexandru Marc Serdeliuc via B4 Relay <devnull+serdeliuk.yahoo.com@kernel.org>
Date: Thu, 11 Apr 2024 18:51:30 +0200
Subject: [PATCH v6 1/2] dt-bindings: arm: qcom: Add Samsung Galaxy Z Fold5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-samsung-galaxy-zfold5-q5q-v6-1-8142297515aa@yahoo.com>
References: <20240411-samsung-galaxy-zfold5-q5q-v6-0-8142297515aa@yahoo.com>
In-Reply-To: <20240411-samsung-galaxy-zfold5-q5q-v6-0-8142297515aa@yahoo.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712854291; l=880;
 i=serdeliuk@yahoo.com; s=20240326; h=from:subject:message-id;
 bh=rbDG1dSELlka8CHOFtXAwuR4DJTaBLOcUGeig6bRpXg=;
 b=uZy1vrriVfkXbit7KGtAKdP07y4/PCTJ4Far8/gTqz02K8SZkn49X7gGbDj63CB6OG83XrmK8
 eNOU1PyY9TWCMEF1zg2KAPmNrLZkSrrLsvSQRqoWAly9nAZ+BEvNFGy
X-Developer-Key: i=serdeliuk@yahoo.com; a=ed25519;
 pk=aWyveUE11qfDOOlRIFayXukrNn39BvZ9k9uq94dAsgY=
X-Endpoint-Received: by B4 Relay for serdeliuk@yahoo.com/20240326 with
 auth_id=147
X-Original-From: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
Reply-To: serdeliuk@yahoo.com

From: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>

This documents Samsung Galaxy Z Fold5 (samsung,q5q)
which is a foldable phone by Samsung based on the sm8550 SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
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



