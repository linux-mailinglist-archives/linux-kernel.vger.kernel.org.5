Return-Path: <linux-kernel+bounces-103228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B9887BCA5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B22A1F226FF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874676FE32;
	Thu, 14 Mar 2024 12:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bva8kgpV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27A46F060;
	Thu, 14 Mar 2024 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710418833; cv=none; b=pFo2kf5DZ8MF+1sDjGlritFSyetY21KrIBCXbRbxq85a/Dmlfet1xsybGNB6rWtfVAJ+AKnwYFVegRQZu9GtU90Gwnt4hNFzxTYSgN+uqEd2ojVES4TdC0lB68QF+P3ABJOAr5qwktreFQfoG4+rWzY1htib+4P6K1oHAqy0ols=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710418833; c=relaxed/simple;
	bh=Lrp2iOUWubwRXDT8fn4ZYwC2hYGdTr2JrwFF4kKzDM8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P/MifWE7WZgIuLQ0aO5VsIYpvre9MfcyIZHtzGTGj2pBeTFG78OGy/FyLuOzpkJiF/sD00xPSEUSAyHKrcc/Z7rVvj+8S7Zf3p9ryHdByd3QmcLhHUrsr17rvMisa3390IHcby4y44WECr7nO2uCxk7mdBt5xSUXvXRRdvkYfHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bva8kgpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DF3CC433C7;
	Thu, 14 Mar 2024 12:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710418833;
	bh=Lrp2iOUWubwRXDT8fn4ZYwC2hYGdTr2JrwFF4kKzDM8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=bva8kgpVNnYUfFN8DdvzjJ54ErkDSTrnQ4BLOKrEHjkOIz0fsn/iNB8P58nbFLZ4m
	 yMd6i8c1BAs0eXh+yGWiZobX1Q+PISdpTK/tMDZhQzVeniYN9qnuU3gBeIi0rejTpl
	 zMhL8appR/uQfszGC1L6StWxbL9p/KdxtXIushnMcA/7cP5F/1NNU8/Gx5CejWwZNz
	 S3BvmqIy9lCn5lHRI5JDzm02pBUnXK6MjH36eUF972K4luk0AIMvSqxSKyZpRCijw9
	 fAeVDpDfnmZ/hJiskz4CBSK9/0ssKoU/7VgV1Ljolueeqc4n1pq84qUklX/BQB/cAK
	 WVrC0GbguLddg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D51FC5475B;
	Thu, 14 Mar 2024 12:20:33 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Subject: [PATCH 0/2] Set PHY address of MT7531 switch to 0x1f on MediaTek
 arm64 boards
Date: Thu, 14 Mar 2024 15:20:03 +0300
Message-Id:
 <20240314-for-mediatek-mt7531-phy-address-v1-0-52f58db01acd@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHPr8mUC/x3NTQqDMBBA4avIrDuQxBRpr1K6SDMTHYo/zIgo4
 t0buvw2751grMIGz+YE5U1M5qnC3xrIQ5p6RqFqCC5E1/qIZVYcmSSt/MVx7e6tx2U4MBEpm+G
 D3CfmwjkFD7WyKBfZ/4fX+7p+k3d7onEAAAA=
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: mithat.guner@xeront.com, erkin.bozoglu@xeront.com, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710418818; l=938;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=Lrp2iOUWubwRXDT8fn4ZYwC2hYGdTr2JrwFF4kKzDM8=;
 b=cZgt4TQjE+rDWx2SQqBS405Ixkn/oDpThaOqJKxN8BxUVkJNynIapl7jq/9Qm+A+fsgw7lThl
 P0tFBRvHLvjAa/EUuhPdhovNPfzqDO5V/Jc75hGFx9ZKfr0m5Gd/nXl
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

Hello.

This is a small patch series setting the PHY address of MT7531 to 0x1f on
all boards that have the switch.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
Arınç ÜNAL (2):
      arm64: dts: mediatek: mt7622: set PHY address of MT7531 switch to 0x1f
      arm64: dts: mediatek: mt7986: set PHY address of MT7531 switch to 0x1f

 arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts | 4 ++--
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts             | 4 ++--
 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts | 4 ++--
 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts             | 4 ++--
 arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts             | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)
---
base-commit: ba90af39ba57b3fe3ecfdba0c87a80d20c7b788d
change-id: 20240314-for-mediatek-mt7531-phy-address-9d0b4cfeca21

Best regards,
-- 
Arınç ÜNAL <arinc.unal@arinc9.com>


