Return-Path: <linux-kernel+bounces-134178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8414789AEB4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 07:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DCD8282F24
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 05:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFADBA42;
	Sun,  7 Apr 2024 05:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoTqsrAS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B509816;
	Sun,  7 Apr 2024 05:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712468295; cv=none; b=K8apAiKbKjSUgI4sA3n0WrGQ6vn4NQc3x6tuLEKRxyBjxC5L1+1FVjbcElN4x8toIzqXXk2sr/iIT+qkbfH/t5tEW01yHeEUJWckuAT1LRpedivH73nSEjTAY3NsbYNevG0EfuuhZc+1vIw5AkiVsGYcynVjPahKSEgy61OFKp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712468295; c=relaxed/simple;
	bh=gNaMHU635ETfkv5s8GiZH8o0VGPbI5LP8wCGPGKhkTs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cRTBAgbFMEGAMEADitCk72+8pWHyHq0xNQzA9WmzDx3P7EmNUGN19k3SmBAn+OCbgPUEFvFqrhlScr3UXjv8MNQ9/Nc2oT1ciazeBW2kPlDV4HaKG3VgwP5RgVqCyL84HRXExmeLMSr8Idrr7tXPCaSa5K0JzwVPzpGHITxByuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JoTqsrAS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3339C433C7;
	Sun,  7 Apr 2024 05:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712468294;
	bh=gNaMHU635ETfkv5s8GiZH8o0VGPbI5LP8wCGPGKhkTs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=JoTqsrAS+oIsfn06HYIfeWZoopaD83kTYuAZnjyWV4EPBtVA1G2UhHCB7Y5kuGm7F
	 nBWcFLPi8Kugq2gA741v190ewYl1ABpi/GlKKxDYyRWxpbSZzGB0GzMXAUyq5z6Y8f
	 n2/h+09EqWHK4xQcg1ttvx7+XnhtrlUQ3QVkv3t8gtI5mqSnjjiXO5VZVz8o3wyG4r
	 qRdlnxiD3Lp50sjdwSBudrJkooeC3qRGCWhbHj8FNxwKArRW3r6/iUOQlNH0kDhMu+
	 M1X5J5T3fLbSNtCl9Md5k38SYIkAkt7rm4+Rh1q8n4FNxOLOl00oQFdKTASNxcWEAE
	 p4eq+00WyQ8xQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AB4CD128A;
	Sun,  7 Apr 2024 05:38:14 +0000 (UTC)
From: Alexandru Marc Serdeliuc via B4 Relay <devnull+serdeliuk.yahoo.com@kernel.org>
Subject: [PATCH v4 0/2] Samsung Galaxy Z Fold5 initial support
Date: Sun, 07 Apr 2024 07:38:12 +0200
Message-Id: <20240407-samsung-galaxy-zfold5-q5q-v4-0-8b67b1813653@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEQxEmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHQUlJIzE
 vPSU3UzU4B8JSMDIxMDEwNz3eLE3OLSvHTd9MScxIpK3aq0/JwUU91C00LdxCTDtJQk45Q0SzM
 zJaD+gqLUtMwKsNnRsbW1AK52YrxrAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712468293; l=974;
 i=serdeliuk@yahoo.com; s=20240326; h=from:subject:message-id;
 bh=gNaMHU635ETfkv5s8GiZH8o0VGPbI5LP8wCGPGKhkTs=;
 b=dmeCCXklsmwJ+mRqpko33fvgv3kX/Kr0q8edP8OQAo+0QYmb/eemYtJ38X0TvyQ/AbMJBPnw+
 6lIAktN0khUDbyI0gXurXGWsuYyt6wkuONkSMt6+RHXCroYmJZ72qCE
X-Developer-Key: i=serdeliuk@yahoo.com; a=ed25519;
 pk=aWyveUE11qfDOOlRIFayXukrNn39BvZ9k9uq94dAsgY=
X-Endpoint-Received: by B4 Relay for serdeliuk@yahoo.com/20240326 with
 auth_id=147
X-Original-From: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
Reply-To: serdeliuk@yahoo.com

- removed extraneous new line
- removed pcie_1_phy_aux_clk
- removed extranous pcie1

This documents and add intial dts support for Samsung Galaxy Z Fold5 (samsung,q5q)
which is a foldable phone by Samsung based on the sm8550 SoC.

Currently working features:
- Framebuffer
- UFS
- i2c
- Buttons

Signed-off-by: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
---
Alexandru Marc Serdeliuc (2):
      dt-bindings: arm: qcom: Document the Samsung Galaxy Z Fold5
      arm64: dts: qcom: sm8550: Add support for Samsung Galaxy Z Fold5

 Documentation/devicetree/bindings/arm/qcom.yaml |   1 +
 arch/arm64/boot/dts/qcom/Makefile               |   1 +
 arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts | 593 ++++++++++++++++++++++++
 3 files changed, 595 insertions(+)
---
base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
change-id: 20240407-samsung-galaxy-zfold5-q5q-ab1fdb3df966

Best regards,
-- 
Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>



