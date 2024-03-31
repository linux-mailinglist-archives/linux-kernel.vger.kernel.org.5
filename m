Return-Path: <linux-kernel+bounces-126041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E25A389314D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 12:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BCE8281FA7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 10:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F24C1442FB;
	Sun, 31 Mar 2024 10:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7zS87A1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA6476F1D;
	Sun, 31 Mar 2024 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711882601; cv=none; b=Vw7JYwTvVrhrRqXu2DA5GRLQUIptOyAILCQaQOQkY3f2QNZ0kCd94fakVJpnhVZwPARFgO/Fl5+d/mrvNFP6dbbd7B3CVVdtumaeGplPVNMnRnya4lPo+ee3dRsp0KCbTfKfvmO8ZYLHDxFnR7wyxibMHccJDdgwf3xBv1q7JFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711882601; c=relaxed/simple;
	bh=WxN+zQMqWorvDIVyazPuArT1yO5iezAJvm7LrCMATsc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GbPHPDJ8CQ+Rcns0BYwPsiqWjM0O59X20YlrHncSSfidi/Xx4K/eLKNttekduSirC15LaBwQNdHV52eg6m6gdWxMDl8K3Tf/ZM+NABjhD4PEcjdPSRgPpuxd7yL9leAILYkUgZMJPertJN3P5epcAh5YK2O9RJZ46tDbBIFrCQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7zS87A1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BCC1C43390;
	Sun, 31 Mar 2024 10:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711882601;
	bh=WxN+zQMqWorvDIVyazPuArT1yO5iezAJvm7LrCMATsc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=V7zS87A1lTxRCmdz8bdU2yGdPm7Hf5CaYBQCc5J+dMwZ6t60j58Deu3XTHD/wZb2P
	 aomfYhJvVXLuq47ajjm14S8lgeAXOIz9ZYDSb0MAIhNVlkDtnn5SzYWJ9bBx9K4vQD
	 go90u+wJBg7OVAgeyy2bpSOdfUAdW4N6X11JmuK8dUhQQeB0KJsdb/K0BmJNEo8G2e
	 J1AkvmDX9fI8i9zb9tit4ihrgSqt0PwA1LykVouURmLeJHjyfGk8OS3bkhxzsw58oM
	 +0eK0ubuysEP3VNxI3VxAyzRP3mY9A617wbtVimuO5PG7sCvMuA/s3xP6H0yiH8X4Q
	 pe0RSG39twkjw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3ED7CD1284;
	Sun, 31 Mar 2024 10:56:40 +0000 (UTC)
From: Alexandru Marc Serdeliuc via B4 Relay <devnull+serdeliuk.yahoo.com@kernel.org>
Date: Sun, 31 Mar 2024 12:56:39 +0200
Subject: [PATCH v3 1/2] dt-bindings: arm: qcom: Document the Samsung Galaxy
 Z Fold5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240331-samsung-galaxy-zfold5-q5q-v3-1-17ae8d0a9fba@yahoo.com>
References: <20240331-samsung-galaxy-zfold5-q5q-v3-0-17ae8d0a9fba@yahoo.com>
In-Reply-To: <20240331-samsung-galaxy-zfold5-q5q-v3-0-17ae8d0a9fba@yahoo.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711882600; l=775;
 i=serdeliuk@yahoo.com; s=20240326; h=from:subject:message-id;
 bh=dteE03ftQTWuAaSunQzfzVFBG+o3qpWAgjOTDgSMFBI=;
 b=xYqDIpsZ9ID82RmGb5Ey4X4KDB18chWlCV3ssprYr35R3vK6ZbHoXypol2hFVVkq1rZA7bvVJ
 yBMBQFYRly0CjjYADtQiydYLX92iEwBbyBX6+OK0wfvN2pgcGUex4K8
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



