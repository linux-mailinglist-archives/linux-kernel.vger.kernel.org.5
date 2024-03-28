Return-Path: <linux-kernel+bounces-123801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA25890E4B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22DB61F24A21
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE94139CF1;
	Thu, 28 Mar 2024 23:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPp3gMub"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70E912D1FC;
	Thu, 28 Mar 2024 23:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711667318; cv=none; b=JHw2IUEpgpEaFf67T84aKjHAZQ/ZpaMVckfVCvgfKv7EIl6xo8K3oDUwVl3IieJaUDopNHRhi3dKmsTrusz25h6qE6rNYz3TDLm7PIhGlAThDeySEpw5BWSIwukR6G6hHPqpyf0VYWIxWVFDdirY6RnBLq5KI554BTP5OyoFvCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711667318; c=relaxed/simple;
	bh=yKtN/chtZvSsUKpLS81BSY2M2urVq2drSpl99l0QSBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SKzVqzd2LvcH5VS0jM+ikE3VfxH8wG42LWn/siL5OiJgt4VYs49JwbQlTyqDsXMohD5FOT9AGulU6v0wPzFIC9psPa/BFqafqWoO+sz91MTr4ECIl4j3itgzPWhZWvZVwgANo2lAJ1BTgOWxrMHQ5kDxAEXcGOBN99ATb1Hszuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPp3gMub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FB5FC43399;
	Thu, 28 Mar 2024 23:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711667318;
	bh=yKtN/chtZvSsUKpLS81BSY2M2urVq2drSpl99l0QSBY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kPp3gMubvO6oMdKyf5jUY5kXA4BT5rz/1R0RLtS5ybmz8IQjGj/l+yKX7bdhskCHl
	 0B1prLWawFgP4THfKGlAYEU21se4BAPqXObO3iQuXA8CLMHgA9kaxdq8bCayx0Exem
	 3r86+oWWzxXpdCKquzHS20TvIcSQbRPx2mKkaf8rsBqk+iW32DtUICs8YRE2u0yy92
	 XUn3noToPi8OYejB8acwCm1pIB76+XGlB47LPsi1T3anLnQWp+QvBWt7JUJ0Idm0ue
	 DLnBXbjcJc6wR9W9DAQxwDhZ3Zm3YcQM+n/JGtrS4/JB9EfFsYHM2thGT8VGXKzJlo
	 QG8U/oYh8WtZQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D6CCD128A;
	Thu, 28 Mar 2024 23:08:38 +0000 (UTC)
From: Alexandru Marc Serdeliuc via B4 Relay <devnull+serdeliuk.yahoo.com@kernel.org>
Date: Fri, 29 Mar 2024 00:08:35 +0100
Subject: [PATCH 2/2] v2 arm64: dts: qcom: Add support for Samsung Galaxy Z
 Fold5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-v2-dts-add-support-for-samsung-galaxy-zfold5-v1-2-9a91e635cacc@yahoo.com>
References: <20240329-v2-dts-add-support-for-samsung-galaxy-zfold5-v1-0-9a91e635cacc@yahoo.com>
In-Reply-To: <20240329-v2-dts-add-support-for-samsung-galaxy-zfold5-v1-0-9a91e635cacc@yahoo.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711667317; l=791;
 i=serdeliuk@yahoo.com; s=20240326; h=from:subject:message-id;
 bh=aP9dXZCNUEWuwg/1mNlC5AwvYPo1MGxaQ74pQNFY26I=;
 b=xmnoLEDkl6vJkXWr6FR5M8j03ap1+Mo4ohgcJr/BB8+OJVHOAxTAMBX8YR/oB/VWjWuHd0WtK
 aBTJB18F0ArC59xMy8TEOo07U7jqQZWPjIkaM8XjjnZt8GKDsbXzXpr
X-Developer-Key: i=serdeliuk@yahoo.com; a=ed25519;
 pk=aWyveUE11qfDOOlRIFayXukrNn39BvZ9k9uq94dAsgY=
X-Endpoint-Received: by B4 Relay for serdeliuk@yahoo.com/20240326 with
 auth_id=147
X-Original-From: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
Reply-To: serdeliuk@yahoo.com

From: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>

Add support for Samsung Galaxy Z Fold5 (q5q) foldable phone

Currently working features:
- Framebuffer
- UFS
- i2c
- Buttons

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



