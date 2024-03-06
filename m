Return-Path: <linux-kernel+bounces-93893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EFF873676
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9352D28B36C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157E0839F9;
	Wed,  6 Mar 2024 12:30:56 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D42682D69;
	Wed,  6 Mar 2024 12:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709728255; cv=none; b=mLWO2dPIJIa1UWUsgM81p1yLqGIumdVKzunythYUApIYxalWgl/hKTzeX0XWOyIN7+CRbpQ+m5HRT/WYFjEMfaK93aJMib84r7qPBdMIsrVcebZ6ilmnR41zEIawuFCrbzL5Mad8r9/F9ZZDffu/0e3VbkFUIU8fHx6M3DHEVGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709728255; c=relaxed/simple;
	bh=P9Du0y5WLoVDNKUQ0wMB6H/DoJ9htsUwYnmNAtU2w0o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ry1d5FjpCVictra4fltaZfjtT2bHLpkhFCBKnwVFUT90zG/PegGSBnfTf8t5PnkYuGStT+yoSKtdXWkL2cK9cn3jr9NDhRIVOyzVI4h4NFQW3iqh2vJ5PzZ4PVeRTiInfOLxEjaLakYv9fQd25YA9MWFw4L5WNzXArT3HqgaUzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c01:4970:eaac:ef59:d8ae:5dc6])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 6C6CC7E0168;
	Wed,  6 Mar 2024 20:30:12 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH v5 0/1] arm64: dts: qcom: ipq6018: add sdhci node
Date: Wed,  6 Mar 2024 20:30:05 +0800
Message-Id: <20240306123006.724934-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSksYVhlOSk0fGEJNTBoaSVUTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlIQUkYS0pBT0JMS0EeGhoYQR4dTkJBH0MaHkFOHxhNWVdZFhoPEhUdFF
	lBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Tid: 0a8e13be26d303a2kunm6c6cc7e0168
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pi46Pio*GDMVOUMUSA4dQk1M
	CwoaFD9VSlVKTEtCTElDSUpISkJDVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0pBT0JMS0EeGhoYQR4dTkJBH0MaHkFOHxhNWVdZCAFZQUpPQ003Bg++

Changes in v5:
  Move LDOA2 regulator patch to other series

Changes in v4:
  Change 'enable' to 'add' of the commit title.

Changes in v3:
  Remove always-on for LDOA2 regulator.
  Remove 1.8v properties of the node added in dtsi.

Changes in v2:
  Add LDOA2 regulator to support SDCC voltage scaling.

-- 
2.25.1


