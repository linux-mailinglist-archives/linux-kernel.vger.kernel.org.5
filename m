Return-Path: <linux-kernel+bounces-134179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F6B89AEB5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 07:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A623283121
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 05:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D090BA4D;
	Sun,  7 Apr 2024 05:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vu8qdBq4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B53617F0;
	Sun,  7 Apr 2024 05:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712468295; cv=none; b=beAzKIsAxASCL1FY3w2WTEMIsuilJSGyFwhUPw/eOyLLmcXtU8ykyo6VnWsyPTZfm/xGngbSQAu/fspqMrQ8SArYY1sjNPgswKOsoVi2m3OewvEo59tTJ/DgcIQbLeeFxpFAkcIbPA1NRIucqys1mucyW5pzjXFE+mOVxMlDF0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712468295; c=relaxed/simple;
	bh=WxN+zQMqWorvDIVyazPuArT1yO5iezAJvm7LrCMATsc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ri1GbhMlOiI20+ZeJ1zWQDaJxDLG/kz7dpPaEHqgsSEKhv6DD6cK8A1czL3Mym2YSatx7jGfryWdiNlSY+BJF5ASFT3AhDpRTKgTntr/FaoIsgQB/p5cUF2cr1rTDtK5YvK+ekaGHcLR9nmhpElmVQe+eTHPTNfy4BVBli6WrdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vu8qdBq4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE713C433F1;
	Sun,  7 Apr 2024 05:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712468295;
	bh=WxN+zQMqWorvDIVyazPuArT1yO5iezAJvm7LrCMATsc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Vu8qdBq4pmjNHiqiNVfvxGiEGiOCFvqLudqEl1VUJEACjuO5OVY32RJp17dt/LU4s
	 gIs3NBcI/fkclRXYzEWVrBTpFBDwRTNn0vNVoTkr/pcM/7Z9TM+mEMv8QspDgNf1/Z
	 Up3vwLxCy5cZM/xo29dDDQYa1eeJN7v4urgY/nBqwy47n9aOHSib9/U5RDWB2cqWxR
	 gpKJvQ+pwrsd+UTmzfHxbnvg3p2WF0asFBOtQD313m0v7TxKyqzuGB6Z00cvkPC22M
	 Cb0S2q09WN0cPXU9zMBHdX+rpZliE+55IMbx7EBVRwP4SS2zra4m+zpvqfAJYLvl8m
	 0P6Va282VYLSQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A4ECD11C2;
	Sun,  7 Apr 2024 05:38:14 +0000 (UTC)
From: Alexandru Marc Serdeliuc via B4 Relay <devnull+serdeliuk.yahoo.com@kernel.org>
Date: Sun, 07 Apr 2024 07:38:13 +0200
Subject: [PATCH v4 1/2] dt-bindings: arm: qcom: Document the Samsung Galaxy
 Z Fold5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240407-samsung-galaxy-zfold5-q5q-v4-1-8b67b1813653@yahoo.com>
References: <20240407-samsung-galaxy-zfold5-q5q-v4-0-8b67b1813653@yahoo.com>
In-Reply-To: <20240407-samsung-galaxy-zfold5-q5q-v4-0-8b67b1813653@yahoo.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712468293; l=775;
 i=serdeliuk@yahoo.com; s=20240326; h=from:subject:message-id;
 bh=dteE03ftQTWuAaSunQzfzVFBG+o3qpWAgjOTDgSMFBI=;
 b=ztK1WVk1ZLDBmmUEmFKSUpP+2yA7M5/9O8mt+eJAupQiBnEF/ouskP2ilC0kKB8hI34tIfa1U
 ZJh9KenqUAtBfK+XhKyrG2ebqSMQ1zXBDdOmMoyOAB7o+BuzBB35tfX
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



