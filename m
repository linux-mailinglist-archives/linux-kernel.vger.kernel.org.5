Return-Path: <linux-kernel+bounces-150731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D19388AA3D8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83E4F1F2290D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C811318412C;
	Thu, 18 Apr 2024 20:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwMahGrJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06694181BB4;
	Thu, 18 Apr 2024 20:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713471007; cv=none; b=kl8NgjGJ+lKShNHfpths5K576LmqpM/JYq/v2eZs6RRKCbUrYUcDJ8nkZiYCGIqHfNRfLzgbWTB9ekONq0nJbEJmSISsGRoV4H78LMS71bpo4lzFSGoNcDFfkMSEdXkaCQyIsCrQHxCXUcFEmo0GLQUZkZgPBuBl5MnmbsuhqdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713471007; c=relaxed/simple;
	bh=qRoYmSL0DQSLl2Yl7BjLTHnNTQJGudUCPAZpXc4XmB0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ap69I8TsPKFaTCZZh4l12MlQHm9kdoAZkzcz2u0OqJykuoS+kWZLkK0AqCpQ/8nDD3Pk6RWmy9C53l90npDJtWLwioysTTPzP6Wpo/H4GkpQuDhy+EX2IS2haxx794U/2ibESKXbP/qYKIRfR9bgwTXFDbssEvNFTQqRdd72oQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwMahGrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EEC5C32781;
	Thu, 18 Apr 2024 20:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713471006;
	bh=qRoYmSL0DQSLl2Yl7BjLTHnNTQJGudUCPAZpXc4XmB0=;
	h=From:Subject:Date:To:Cc:From;
	b=pwMahGrJT3FspVu8/X/7nvzrlxkrA5P5tsNLYqt8NnkEBzagU5/ScHiRT99ZChZxE
	 uQXw4PtfMFQYPSQ4+AQ6fhhWybbgdHCrFqneUHGlqVSsOKSCwEIzgf0hB/DV3iwlnJ
	 CY4APq7QOjFx4jwIqnrHP6tfsU9ymlv5TaKnQwfMUf9uyz37ZgzXUlBYu5YoFCB4Jz
	 snA7eiyKsRiI+LWtJnM+rx3t1QXxidQLJeg6ApTDiQBmKbdOmFPTsEHhjvmyvQx2/E
	 r43IS5pQG5K0dV1jHqS0AnmWbiYlrMXK2Mzd5HopAtRD/2e2uOdd1+3C9IbByqhzGw
	 6+DfssY9fz7PQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 0/2] arm64: dts: freescale: LS1028a PCI fixes
Date: Thu, 18 Apr 2024 15:09:24 -0500
Message-Id: <20240418-dt-ls1028a-pci-fixes-v1-0-95f17405e481@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPR9IWYC/x3LQQqAIBBA0avErBtQMbCuEi3MphoICyciEO+et
 Hx8fgahxCQwNBkSPSx8xgrdNhB2HzdCXqrBKGOV1Q6XGw/RyjiPV2Bc+SXBzq7BBDv3znmo65X
 oD/Ucp1I+myJnZGYAAAA=
To: Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-Mailer: b4 0.14-dev

This short series addresses a couple of schema warnings with the 
embedded PCI devices in the LS1028a:

pcie@1f0000000: rcec@1f,0:interrupts:0:0: 0 is not one of [1, 2, 3, 4]
pcie@1f0000000: rcec@1f,0:interrupts:0: [0, 94, 4] is too long
pcie@1f0000000: mdio@0,3:compatible: ['fsl,enetc-mdio'] does not contain items matching the given schema
pcie@1f0000000: ethernet@0,6:compatible: ['fsl,enetc'] does not contain items matching the given schema
pcie@1f0000000: ethernet@0,4:compatible: ['fsl,enetc-ptp'] does not contain items matching the given schema
pcie@1f0000000: ethernet@0,2:compatible: ['fsl,enetc'] does not contain items matching the given schema
pcie@1f0000000: ethernet@0,1:compatible: ['fsl,enetc'] does not contain items matching the given schema
pcie@1f0000000: ethernet@0,0:compatible: ['fsl,enetc'] does not contain items matching the given schema
pcie@1f0000000: ethernet-switch@0,5:interrupts:0:0: 0 is not one of [1, 2, 3, 4]
pcie@1f0000000: ethernet-switch@0,5:interrupts:0: [0, 95, 4] is too long

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Rob Herring (Arm) (2):
      arm64: dts: freescale: ls1028a: Fix embedded PCI interrupt mapping
      arm64: dts: freescale: ls1028a: Add standard PCI device compatible strings to ENETC

 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240418-dt-ls1028a-pci-fixes-54fc2c4b988a

Best regards,
-- 
Rob Herring (Arm) <robh@kernel.org>


