Return-Path: <linux-kernel+bounces-141356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FB18A1D32
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7EE1F23F64
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F1B1CD790;
	Thu, 11 Apr 2024 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htF9RWAO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8A71CD766;
	Thu, 11 Apr 2024 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854293; cv=none; b=I8O/vm+C7dsDT++h8MpJ3Uvp/qPPPSS3GoExXLIazqkOHojFZ7bn2+8Jv1xHYKE7AZ0ogZRhNhKUmmnSts/5o5sRhN3RR5jvN+Lle7NlQ5w+gidQ0/sH790VDIKVnyf32oNAUeGx9+xaSOxGGC2ctJL4BK6ajgBv+WXiefjteb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854293; c=relaxed/simple;
	bh=HdJWqY+cT9Wg0DNZCMwiGF32/wMzBDVcbxPbdkcsEBY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Hur4e/yuLoJmtpvFXgsHNskCB2BXmd+u9QNJq7qG/fqhndMsVvs7/tBF31Kf+2YSHJh2L3CkxVCOK8N93U1tRph4TEgZCQOv7C8bWnZik3Ag3EkVpf7P4vgKc7gDw2U/raD1JBMgupquiDsFJldr11WZPMReunbF0pHW7WZDsWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htF9RWAO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C07CAC072AA;
	Thu, 11 Apr 2024 16:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712854292;
	bh=HdJWqY+cT9Wg0DNZCMwiGF32/wMzBDVcbxPbdkcsEBY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=htF9RWAOGNeJRA4iazBHtr27jK6sB39DdiJS50fG/FooQA/3Ys4amm6Q1grcKzgn4
	 Z7KGx97pq8sz7tz+X9X0+YZt5JUQw//8Ju2A6zmxLwbq6fw/a+vNinAq3gbjglSkGe
	 ihSXpbkTO2DxcWR8oxNPFxiy7NMXUVgbV3qF4He9WvUyfX/+H/g13N6SZmVERaCVGq
	 wYL+jrj/P0p/S+IftuXCuG+eGUIgOND4HzOiuQnjWa3qdi6npVSUwgVqYVeNgJwCOO
	 mtOHM5+64hZxFFlVVzwFMO/q1edy+BF1ITT0m2vvdwNII1//Dhtv6EmHnenuEo/JvU
	 4gehB687WER9Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C55C4345F;
	Thu, 11 Apr 2024 16:51:32 +0000 (UTC)
From: Alexandru Marc Serdeliuc via B4 Relay <devnull+serdeliuk.yahoo.com@kernel.org>
Subject: [PATCH v6 0/2] Samsung Galaxy Z Fold5 initial support
Date: Thu, 11 Apr 2024 18:51:29 +0200
Message-Id: <20240411-samsung-galaxy-zfold5-q5q-v6-0-8142297515aa@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABEVGGYC/x3MQQqDMBBA0avIrDsQRS16ldLFYCbpQIw1g8Uqu
 bvB5Vv8f4JyElYYqxMS/0RliQX9o4LpQ9Ezii2GxjStaesalWbdokdPgfY/Hm4JtsO1W9EYR9N
 gB0f0hNJ/EzvZ7/frnfMFs0ZDE2sAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712854291; l=2612;
 i=serdeliuk@yahoo.com; s=20240326; h=from:subject:message-id;
 bh=HdJWqY+cT9Wg0DNZCMwiGF32/wMzBDVcbxPbdkcsEBY=;
 b=tWsbPLyQmpQyjFvwnABEfa9uAjhfxfiObu93xMSFuRFwZax/St/PczWlm+K7uavDBtpjkiJHv
 8V2sj+u2NoeBWPy9wuEQZiIHkbYlBIt0hsxZt+Do8olW8atm3ddjgU8
X-Developer-Key: i=serdeliuk@yahoo.com; a=ed25519;
 pk=aWyveUE11qfDOOlRIFayXukrNn39BvZ9k9uq94dAsgY=
X-Endpoint-Received: by B4 Relay for serdeliuk@yahoo.com/20240326 with
 auth_id=147
X-Original-From: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
Reply-To: serdeliuk@yahoo.com

This documents and add intial dts support for Samsung Galaxy Z Fold5 (samsung,q5q)
which is a foldable phone by Samsung based on the sm8550 SoC.

ChangeLog

- v6
  . Moved Acked-by to the right  place

- v5
  . Added ChangeLog
  . Added missing Acked-by tags in their respective section in ChangeLog

- v4
  . removed a spurious new line
  . removed pcie_1_phy_aux_clk as requested
  . removed secondary pcie1 which does not exists on the device
  . changed firmware extension from .mbn to .mdt
  . added missing reserved memory regions required by firmware to properly load

- v3
  . added b4 version 3
  . removed address and size cells in device description

- v2
  . added both but added an extra v2 in the subject line instead to b4 subject header, was requested to send the patch again, along with following mods:
  . removed whole bootargs line
  . fixed underscores in reserved memory by removing all reserved memory regions
  . added missing idetation to  spash_screen remark
  . validated the dts with "dtbs_check"
  . removed all comments at the end of nodes
  . moved status of the node at the end of the node
  . reversed pin control name with control numbers
  . ordered the  nodes alphabetically

- v1
  . The initial request was split in two patches sent due to the following checkpatch warning, was requested to re send them together:
    WARNING: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst

To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
---
Alexandru Marc Serdeliuc (2):
      dt-bindings: arm: qcom: Add Samsung Galaxy Z Fold5
      arm64: dts: qcom: sm8550: Add support for Samsung Galaxy Z Fold5

 Documentation/devicetree/bindings/arm/qcom.yaml |   1 +
 arch/arm64/boot/dts/qcom/Makefile               |   1 +
 arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts | 593 ++++++++++++++++++++++++
 3 files changed, 595 insertions(+)
---
base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
change-id: 20240411-samsung-galaxy-zfold5-q5q-00fac9d9faa7

Best regards,
-- 
Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>



