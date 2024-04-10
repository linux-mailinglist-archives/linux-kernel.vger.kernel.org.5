Return-Path: <linux-kernel+bounces-139367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EBF8A0213
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 076411C2171D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40FA184113;
	Wed, 10 Apr 2024 21:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nb2jYbCE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053BC181BA1;
	Wed, 10 Apr 2024 21:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712784516; cv=none; b=ppghSqfR/wjMhKMfQfneUPcjJlyXOvuNyPGRA0iEc48Xov2rM6GiGOkaZPk0dImQUpOkgUQPSuJmgoBFsXxcA99ge+QouqmRg9QzgZDZM28djwKtJKpaOetXlCWJygl5eC/IVaT+emhzNIoId4/Z/j0EAZ+rtf5i4PP1zp6hhuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712784516; c=relaxed/simple;
	bh=TUqiqernw9WGEO3cMf2cvZV3VHIcszDG5hcc58McQQw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V90iC5cFONGBginBcskKOs5kPzhugS72jpeFzMrn/+ELVx8yFD3BPIiGlIguCldTeYA1F9jJVCNXQi0eVqWGr8i7OpPnkym5H+xa3ZkCUHkRHr4G2EOVZ/9PO5QHYwb7Wi//DFIOypsTdXnYIunt/tfZoLUdgAGLlrS/IdyWPvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nb2jYbCE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C260C433F1;
	Wed, 10 Apr 2024 21:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712784515;
	bh=TUqiqernw9WGEO3cMf2cvZV3VHIcszDG5hcc58McQQw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=nb2jYbCEdrXv0NZRgQ6BNK+5Ix9HgKC0PqslETraJ39utYsxuADf0l2guLTocno+W
	 yhptP3hkGRU2R5WtAlU6pgza90maRy2oGZwbN9DPn5t6ezl7ZTO7x5HZ+wIKOTY4vi
	 XZ8FSRVuodcksNM9PuvxAugQGCG2Pyx7KlNl6J3L2Up2cRr7CV/Q7hiZO9yk3fDH91
	 AjpRtI2zAfVgbwJgZcHyPL69LAxgTNv/71W+QP5RMoeCd8hsxynUq4CoTXkumfJ3bD
	 ybJIOZS9/uakT+3jZEHnzb+N1HF3IAczYkX+MNF4gsIXUzAWQd75+vK3g4vamHqMzT
	 P2qDv4wPWuxQA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C338CD1284;
	Wed, 10 Apr 2024 21:28:35 +0000 (UTC)
From: Alexandru Marc Serdeliuc via B4 Relay <devnull+serdeliuk.yahoo.com@kernel.org>
Subject: [PATCH v5 0/2] Samsung Galaxy Z Fold5 initial support
Date: Wed, 10 Apr 2024 23:28:32 +0200
Message-Id: <20240410-samsung-galaxy-zfold5-q5q-v5-0-9311ee9a55f7@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIAEF2YC/x3MMQ6DMAxA0asgz7UUKBngKlUHK3FSSxAgVlEAc
 fdGHd/w/wXKWVhhbC7IvIvKkirsowH3oRQZxVdDZ7re9K1BpVm/KWKkicqBZ1gmb3GzG/pn6zw
 zOTMEqP2aOUj5v1/v+/4BA4Vix2sAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712784514; l=2250;
 i=serdeliuk@yahoo.com; s=20240326; h=from:subject:message-id;
 bh=TUqiqernw9WGEO3cMf2cvZV3VHIcszDG5hcc58McQQw=;
 b=QRhN4tQuLBYQVROA6KpSYR/5M2GxLW8ZFmZnPrskPmJ+rvTiuQADpNPAqKZqRwSPxJfMDQevK
 tM13mVl2blWA0ptFDwMLFzV21OVvH3MZ5Iz7wLn7ZUcEaqG6ZifVvKR
X-Developer-Key: i=serdeliuk@yahoo.com; a=ed25519;
 pk=aWyveUE11qfDOOlRIFayXukrNn39BvZ9k9uq94dAsgY=
X-Endpoint-Received: by B4 Relay for serdeliuk@yahoo.com/20240326 with
 auth_id=147
X-Original-From: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
Reply-To: serdeliuk@yahoo.com

This documents and add intial dts support for Samsung Galaxy Z Fold5 (samsung,q5q)
which is a foldable phone by Samsung based on the sm8550 SoC.

ChangeLog
	
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
  Acked-by: Rob Herring <robh@kernel.org>

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
  Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

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
base-commit: 2c71fdf02a95b3dd425b42f28fd47fb2b1d22702
change-id: 20240410-samsung-galaxy-zfold5-q5q-d31cdeeac09f

Best regards,
-- 
Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>



