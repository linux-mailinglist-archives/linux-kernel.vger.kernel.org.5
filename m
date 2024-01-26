Return-Path: <linux-kernel+bounces-40059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1CB83D98B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C161F22B90
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431E117730;
	Fri, 26 Jan 2024 11:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGu+TgJE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8366816429;
	Fri, 26 Jan 2024 11:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706269538; cv=none; b=G+ASQ6WB8cNkhlcmCosHfJslzA0tB9cJim6UCLLd5H0ZuIWjGiJnDUfLLENOmki0ttwRXbA9P5kbotJ0CNXKNhPFCs2whSeLkcK5kMhRiLjzApznt8qV1Wnyd9PwF5Yhdo4DUxHYnth2kwfsOSBDbBuHEDwAPvgepqA38oj/pDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706269538; c=relaxed/simple;
	bh=Plkk/G3qZtfiuYfBXBlia7zD5fV7+rqNmYeENijFVnA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=huVT5Yjmcw92kbuIkoCaiuq0eX17+2LyhBE2CG3DtLivZT3Pmti/QYSlrSm94C+gfkku/AIADAqX3S5tjXt26Y4RozlbgWDbExdBAlb30E/3HXBEY8/3Pe9PPo1sWsiy8atY2Skt9PNJxLpfS9gwahcDfM6ibyEaDJc+1gRKrGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGu+TgJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7163C433C7;
	Fri, 26 Jan 2024 11:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706269537;
	bh=Plkk/G3qZtfiuYfBXBlia7zD5fV7+rqNmYeENijFVnA=;
	h=From:To:Cc:Subject:Date:From;
	b=iGu+TgJEUM4IrnIwMf+O+8kvgfPFdx0ryLyBr0eORd7WVHxRo3TQhYYvAXtwrHA9z
	 amMkapY5gCkVrm+xYiXIaFausgBRvk/DH3KmdOv7HbnD2AzORIORHa2Vlvjj42LWYH
	 ChDFTG+zED4dGhQLPFZcHCQcrWWKU2J8c+H2alo5oaWfSkNYKuOfzEsPmVp1mSsz7F
	 wAowdE+FC6xjJhJk9okTMd3DfN22D0Dyxs5tzonnU8iWnUeXtyFqgTFD9mwwZe4G3D
	 2pPwUIiETXjh763qVlOHGN++hd4j8A04gdWBMjSopShNkKyYrKHXQH20EMq6NVEYaU
	 PX1bRazvKMGcw==
From: Roger Quadros <rogerq@kernel.org>
To: nm@ti.com,
	vigneshr@ti.com
Cc: afd@ti.com,
	a-bhatia1@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	srk@ti.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 0/3] arm64: dts: ti: am65x: Add PCIe + USB DT overlay files
Date: Fri, 26 Jan 2024 13:45:27 +0200
Message-Id: <20240126114530.40913-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

There are 2 types of (PCIe + USB) expansion cards that are provided with
the AM654 board configurations.

1) 2 lane PCIe + USB 2.0 card is supplied with the AM65 IDK
configuration [1]

2) 1 lane PCIe + USB 3.0 card is supplied with the AM65 GP EVM
configuration [2]

Add DT overlay files for both cards.

[1] - https://www.ti.com/lit/ug/spruim6a/spruim6a.pdf
[2] - https://www.ti.com/lit/ug/spruim7/spruim7.pdf

cheers,
-roger

Kishon Vijay Abraham I (1):
  arm64: dts: ti: Add DT overlay for PCIe + USB3.0 SERDES personality
    card

Roger Quadros (2):
  arm64: dts: ti: am65x: Fix dtbs_install for Rocktech OLDI overlay
  arm64: dts: ti: Add DT overlay for PCIe + USB2.0 SERDES personality
    card

 arch/arm64/boot/dts/ti/Makefile               |  9 ++-
 .../arm64/boot/dts/ti/k3-am654-pcie-usb2.dtso | 65 ++++++++++++++++++
 .../arm64/boot/dts/ti/k3-am654-pcie-usb3.dtso | 67 +++++++++++++++++++
 3 files changed, 139 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am654-pcie-usb2.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am654-pcie-usb3.dtso


base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.34.1


