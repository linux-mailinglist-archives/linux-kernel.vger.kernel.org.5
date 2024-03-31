Return-Path: <linux-kernel+bounces-126040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CECF289314C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 12:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C4991C21019
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 10:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4BF1442FA;
	Sun, 31 Mar 2024 10:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABVlfCbw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682BB40C1F;
	Sun, 31 Mar 2024 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711882601; cv=none; b=HGDVbGxUTMlX0ba6TpKk22dNKC9fEjY4tvvrIhXjQYH04vkv0z4NIiC2Qtp0A2pAarZsPHxP8U36fU1oBCOwaJxRgqoo48iCjhbwZEp5I3q0DEEbGyNNcjKpu/l+Dq9P6vO49elzB0DOTzDUJ5NSawpBFacg4k+ANGPmm29bWi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711882601; c=relaxed/simple;
	bh=3JA8zXWvxduJPtSIA4N0SAo+czSCUXl4wrmxDz54JAg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A5aUFe1uzpPv6lwEhSQY3bXTKeUTlf6DpiM18adPRDNHxeIWB6h+Ks4S4G1mtsPAsDAJfmmBn81G9/x/4I2JGWQ3j8ap+D7Je57Q0mniREA00UaY6mcr5c3uVVUf5ghxcbf7Z5PmzzC3mlJpT4bWdDxwbkf+HLUnyKW8eVpZUdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABVlfCbw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 001B5C433F1;
	Sun, 31 Mar 2024 10:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711882601;
	bh=3JA8zXWvxduJPtSIA4N0SAo+czSCUXl4wrmxDz54JAg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ABVlfCbwMiW/9N4ITnMIQxVipnhX3WCOEcm5TLDqwm/gl7AqAADEMFWrXpueCob2r
	 0DefuuurTABydQhoRV81V/zBVsde3CW0qfvWMVhymniBPeTzaKH75sUkCcaj3aL6ox
	 7Qxbd+gW/EG35pflYh5oacEnij+YVMv0xV2/XQbTSHHxmm+yc4FWhH+SiEaOVbxe6J
	 d56fmXDWF8nftG9FD4u9Nkk8m+MyFVraaJebONX1ZJxpd4D+BvyBvdJBRc0jDnVMN1
	 uoza2+I5K+j10U124LlneqIUVnjo6v1vEC8U/0tzpwnDQTfvL0K7XupCBj3nCq23T0
	 dhvuYFXVLOCJg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A06CD128A;
	Sun, 31 Mar 2024 10:56:40 +0000 (UTC)
From: Alexandru Marc Serdeliuc via B4 Relay <devnull+serdeliuk.yahoo.com@kernel.org>
Subject: [PATCH v3 0/2] Samsung Galaxy Z Fold5 initial support
Date: Sun, 31 Mar 2024 12:56:38 +0200
Message-Id: <20240331-samsung-galaxy-zfold5-q5q-v3-0-17ae8d0a9fba@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGZBCWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIxMDY2ND3eLE3OLSvHTd9MScxIpK3aq0/JwUU91C00LdVOM0YxOLNDMTc1N
 zJaD+gqLUtMwKsNnRsbW1ABNhBOJrAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711882599; l=884;
 i=serdeliuk@yahoo.com; s=20240326; h=from:subject:message-id;
 bh=3JA8zXWvxduJPtSIA4N0SAo+czSCUXl4wrmxDz54JAg=;
 b=aDq6wusCtpMghuggUJWzAmv91MkJfuMGcoau1D3E95KEyBKJtJ9oK6lw6cLQ4OZDBtiQdC54p
 iWgCy20wZV4BQxlAEf220eEyC68d7ITJVC67iRmpLT1zdSFwa5aMIP5
X-Developer-Key: i=serdeliuk@yahoo.com; a=ed25519;
 pk=aWyveUE11qfDOOlRIFayXukrNn39BvZ9k9uq94dAsgY=
X-Endpoint-Received: by B4 Relay for serdeliuk@yahoo.com/20240326 with
 auth_id=147
X-Original-From: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
Reply-To: serdeliuk@yahoo.com

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
 arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts | 582 ++++++++++++++++++++++++
 3 files changed, 584 insertions(+)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240331-samsung-galaxy-zfold5-q5q-e3f348f64757

Best regards,
-- 
Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>



