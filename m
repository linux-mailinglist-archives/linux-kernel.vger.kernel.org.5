Return-Path: <linux-kernel+bounces-68862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BCA858117
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C025280A18
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C37130E2E;
	Fri, 16 Feb 2024 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8WSu/vW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD2212F588;
	Fri, 16 Feb 2024 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096887; cv=none; b=lI0Vjzxse7dFaTUvTDnGB6Xj50ibck8zL/dCDuYT5cb884K27RI5l0Qw0/HmkyY+fh9mAH/sGwlXAjYBEb4H5rO0WQTOIq8QspGuIskSFeDLEZk+zDDzgtH9vMSABTjZbzG2X7ePrif/ck4R+nm2uJe1JVdYAnymm42IWaVgNdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096887; c=relaxed/simple;
	bh=IxnSWTB2sBXQF0390u8a976PN+j85jvd6/lGGofC8VY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=durNq1Usy8ycXEIB5IyPqp8CBDhtm25OabWQ652YEgmKA+mooBCXQa4qp7HO/f+saKChORjlID/7mbxU3knRAJ60zWt3OfGg1iJNRG9gowP8EcD1xL/G7ahUlDcwnZbxsfdOTRWIKkGckf1KS8kEpqldJZ5vJbwphgAqn9b1AEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8WSu/vW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46FDDC433C7;
	Fri, 16 Feb 2024 15:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708096887;
	bh=IxnSWTB2sBXQF0390u8a976PN+j85jvd6/lGGofC8VY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=t8WSu/vWzA3RAuEKVApWeF6Dn0DnVniiHCrLWnfntoku88Vb4Y4mz6lsLI+iafxcj
	 kWAwRes8UHJnyXfUA1go2QS5nTZP6X50jjefqD8QpTvzmWEXr8giiaAtac90S3vVZp
	 Wa+71Tp7fjI90vI8iIOx0XTN102gI82qtTK7n7ca3hOE8BMkULDF6DCzlayADLyJ23
	 0Yaq1kP+aujvX1aonwgNiC1nUsySQ1ZSNfPMx/ehkd416Iks+baHt9zkSeABW39DzP
	 xAB4c9ySq2sGW/c8sYuaE+4AHfA6gzFlifDdF9nkZQS+ALJiqtjWKFXcqjv0RfYuLI
	 gkB1Qdkr4YqXQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA8AC48260;
	Fri, 16 Feb 2024 15:21:27 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH RFC 0/4] phy: hisi-inno-phy: add support for
 hi3798mv200-usb2-phy
Date: Fri, 16 Feb 2024 23:21:00 +0800
Message-Id: <20240216-inno-phy-v1-0-1ab912f0533f@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFx9z2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDI0Mz3cy8vHzdgoxK3USjFAtzozSzJHOTJCWg8oKi1LTMCrBR0UpBbs5
 KsbW1AO6AnyJfAAAA
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jiancheng Xue <xuejiancheng@hisilicon.com>, 
 Pengcheng Li <lpc.li@hisilicon.com>, Shawn Guo <shawn.guo@linaro.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, 
 David Yang <mmyangfl@gmail.com>, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708096886; l=1304;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=IxnSWTB2sBXQF0390u8a976PN+j85jvd6/lGGofC8VY=;
 b=jVZPCURmpgkvsGh4pmLptz411OscyhZfFOxAAmB4AKycoTJpCK24CwzaBAjfCCKBgjM8qYArr
 uVTzXRcqYHvCIgzGWjYN3cP73jcSNBzIRH0pfkqv/yg6MlQsD8aC2Eo
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

This should be considered a dirty hack. The proper solution would be
extracting write_reg logic to a separate regmap driver. Leaving only
"write BIT(2) to address 0x6" to the PHY driver.

The initial commit is already doing things wrong. The following patches
adding hi3798mv100 support is also very confusing. The name of the
enumeration "PHY_TYPE_x" is very misleading as if it's the phy which is
different across SoCs. But actually it's the bus (i.e. how to write to a
given address) which is different, not the PHY.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Yang Xiwen (4):
      dt-binding: phy: hisi-inno-usb2: convert to YAML
      phy: hisilicon: enable clocks for every ports
      phy: hisi-inno-usb2: add support for direct MMIO
      dt-binding: phy: hisi-inno-usb2: add compatible of hisilicon,hi3798mv200-usb2-phy

 .../bindings/phy/hisilicon,inno-usb2-phy.yaml      | 125 +++++++++++++++++++++
 .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt |  71 ------------
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c         |  57 ++++++----
 3 files changed, 161 insertions(+), 92 deletions(-)
---
base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
change-id: 20240216-inno-phy-a2d872f6b74b

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


