Return-Path: <linux-kernel+bounces-164901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 735A98B84AC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A014284027
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2053E4E1DA;
	Wed,  1 May 2024 04:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcY54HJr"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18EA4C62B
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 04:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714536500; cv=none; b=FB9kIi42PiQspGHoXja17Gb7uCHOtLacZvdCwPdvjqDudcknvAZ5aIerNRqu2q1fpocQab4av2Tx5oqdRsCiGRl6x3jWbbUuSEDoRQxBM3MJTbcvfrNeeMcUiNqvu/+ciZmwx1L2dpMqfMD4w+ZSB1pwc4u1LBOyIz/csBfBLRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714536500; c=relaxed/simple;
	bh=a18PhYqa1Ej+q1OW2kx0iTG0IBRCQUyahBHrRUAGLSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bl1TVbLiHiVPfVttGku1OOX2J8z+xEquAI5fntbwCv04iVPjG2ZCkXQrDNsyq1mGQbXJ5bWkZ+phvhOYU59LqhtFVAl/mifL9SyRpUHK9BBSOPsDXzbR2qCtPj0alb8k11znWskirN14dOeqYuIfc7CASi6HMXTQtj8s9WvOncA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcY54HJr; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c70999ff96so3352187b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 21:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714536497; x=1715141297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/yrOQ0omRjz6OrQxZBXvYp0VMAxHDJp2r7BXxsg9K8=;
        b=lcY54HJr9d4VYNAoavzLqwPIwzOpgNryrfjTKU0RdDoJ2UBcty2nTwO/fHNwPN4VX3
         H/fkmVNyG6i71qkjYhWptWytm8+QHkstVKwOrovnZe73tLvGLygpAbifJFdD2njlZ6dq
         /pqwdOpl2gydu95nM0CW4AAaXrPWWuILSE0cjwPp5ZameuNGiS32qoto0yaU+v3AV9dj
         yyRVAgiNL18vv+qb97H1RDzYaOzYGQIXznD4nddGeDNQ1X6aICDwZZNmiAaO5PLRSDtD
         3FPALJRuXtkef3/gj4iaMDLvA7xyv3XfFZCkicu4vtfRzYscSJNUx64EHKy6Oc5W6u10
         aAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714536497; x=1715141297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/yrOQ0omRjz6OrQxZBXvYp0VMAxHDJp2r7BXxsg9K8=;
        b=CpPljArAI+TOZp2cr8Ny2lEPLH2cQQuYkiBt3GwUyb+dtXZr1DWXUzrWcreG5kdCl2
         FkfVknDrfZ1WWImJxauQJQ0Wkd60rxuCLCq9p7LVnOtIkjYfEoLjJ/YZtI3r+Zy0zsdh
         wdYKJIn4AtwZ/UNuuKa9BEtBlu/O77Uw509bKx+87tzC8+iu0CvOvMVDAhUveTPKY76b
         /XzO3dJpjwt1Y5yDxIO2DP7HpuwnRNy8tfL7pz+p5NGRL0wFQjI9nXDEeLMVD1zccSbP
         pJVIdjgKPaSPQwwxwRGjgHRp5ZLDJEHSLBEpMwX2RCVyMkuJwy2qVpAmbNXrbQ2d/ml8
         BAyw==
X-Gm-Message-State: AOJu0YwRtQtxxK0A+eW34923dAb50UTl2ICkOVcH0znw7DpU2O3vT40F
	1X92XfIifNzsYgDgYYbKvjS0PjJTEMuuG/uObMCSxP6tLnJGSj4yBK2JPRQ8NTw=
X-Google-Smtp-Source: AGHT+IHInKMKFCP+WPGDVOhQLHw01Gl2Tk9uPISeIbUcFLs0ZAY8E6Mih0thfV9ZOrFBhIbmzM/9HQ==
X-Received: by 2002:a05:6808:219b:b0:3c8:61a9:629 with SMTP id be27-20020a056808219b00b003c861a90629mr1906154oib.1.1714536497322;
        Tue, 30 Apr 2024 21:08:17 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id w2-20020a056808018200b003c8643f0e5csm1067872oic.16.2024.04.30.21.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 21:08:16 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: 
Cc: linux-kernel@vger.kernel.org,
	quic_kathirav@quicinc.com,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH v4 0/8] ipq9574: Enable PCI-Express support
Date: Tue, 30 Apr 2024 23:07:51 -0500
Message-Id: <20240501040800.1542805-10-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240501040800.1542805-1-mr.nuke.me@gmail.com>
References: <20240501040800.1542805-1-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are four PCIe ports on IPQ9574, pcie0 thru pcie3. This series
addresses pcie2, which is a gen3x2 port. The board I have only uses
pcie2, and that's the only one enabled in this series. pcie3 is added
as a special request, but is untested.

I believe this makes sense as a monolithic series, as the individual
pieces are not that useful by themselves.

In v2, I've had some issues regarding the dt schema checks. For
transparency, I used the following test invocations to test:

      make dt_binding_check     DT_SCHEMA_FILES=qcom,pcie.yaml:qcom,ipq8074-qmp-pcie-phy.yaml
      make dtbs_check           DT_SCHEMA_FILES=qcom,pcie.yaml:qcom,ipq8074-qmp-pcie-phy.yaml

Changes since v3:
 - "const"ify .hw.init fields for the PCIE pipe clocks
 - Used pciephy_v5_regs_layout instead of v4 in phy-qcom-qmp-pcie.c
 - Included Manivannan's patch for qcom-pcie.c clocks
 - Dropped redundant comments in "ranges" and "interrupt-map" of pcie2.
 - Added pcie3 and pcie3_phy dts nodes
 - Moved snoc and anoc clocks to PCIe controller from PHY

Changes since v2:
 - reworked resets in qcom,pcie.yaml to resolve dt schema errors
 - constrained "reg" in qcom,pcie.yaml
 - reworked min/max intems in qcom,ipq8074-qmp-pcie-phy.yaml
 - dropped msi-parent for pcie node, as it is handled by "msi" IRQ

Changes since v1:
 - updated new tables in phy-qcom-qmp-pcie.c to use lowercase hex numbers
 - reorganized qcom,ipq8074-qmp-pcie-phy.yaml to use a single list of clocks
 - reorganized qcom,pcie.yaml to include clocks+resets per compatible
 - Renamed "pcie2_qmp_phy" label to "pcie2_phy"
 - moved "ranges" property of pcie@20000000 higher up

Alexandru Gagniuc (7):
  dt-bindings: clock: Add PCIe pipe related clocks for IPQ9574
  clk: qcom: gcc-ipq9574: Add PCIe pipe clocks
  dt-bindings: PCI: qcom: Add IPQ9574 PCIe controller
  PCI: qcom: Add support for IPQ9574
  dt-bindings: phy: qcom,ipq8074-qmp-pcie: add ipq9574 gen3x2 PHY
  phy: qcom-qmp-pcie: add support for ipq9574 gen3x2 PHY
  arm64: dts: qcom: ipq9574: add PCIe2 nodes

Alexandru Gagniuc (7):
  dt-bindings: clock: Add PCIe pipe related clocks for IPQ9574
  clk: qcom: gcc-ipq9574: Add PCIe pipe clocks
  dt-bindings: PCI: qcom: Add IPQ9574 PCIe controller
  PCI: qcom: Add support for IPQ9574
  dt-bindings: phy: qcom,ipq8074-qmp-pcie: add ipq9574 gen3x2 PHY
  phy: qcom-qmp-pcie: add support for ipq9574 gen3x2 PHY
  arm64: dts: qcom: ipq9574: add PCIe2 and PCIe3 nodes

Manivannan Sadhasivam (1):
  PCI: qcom: Switch to devm_clk_bulk_get_all() API to get the clocks
    from Devicetree

 .../devicetree/bindings/pci/qcom,pcie.yaml    |  37 ++++
 .../phy/qcom,ipq8074-qmp-pcie-phy.yaml        |   1 +
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 178 +++++++++++++++++-
 drivers/clk/qcom/gcc-ipq9574.c                |  76 ++++++++
 drivers/pci/controller/dwc/pcie-qcom.c        | 164 +++-------------
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 136 ++++++++++++-
 .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h   |  14 ++
 include/dt-bindings/clock/qcom,ipq9574-gcc.h  |   4 +
 8 files changed, 469 insertions(+), 141 deletions(-)

-- 
2.40.1


