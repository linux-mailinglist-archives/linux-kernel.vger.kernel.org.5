Return-Path: <linux-kernel+bounces-83642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D09869CB6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4F52818A1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5240F48CFD;
	Tue, 27 Feb 2024 16:47:25 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385B32032A;
	Tue, 27 Feb 2024 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052444; cv=none; b=tLyYjPVq0GDD9DmaykZupTXekBDwGmXIgLS88rXvms+FZtggJ3aZQvnpKhGYZICwPYaDEZL1H3L3DDfCb4mKLmuUoVSv8lrobs4wZBVM2C3Uyvfppqa0eF/WoDr/re6igmpTJpA01tXtYf1Qk/ndc9BfFEMxG/MS4edvdWPtidg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052444; c=relaxed/simple;
	bh=6wkv0tRf+s87vJlDw1bJ7uah+LboAfu8BoSh0Jah+eE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nYFJ0QSn+XH/2kLc7cZLxvDFrE/ZKldktrKeZ+EoL9rHyRrLeB8/fJHheMoFd4gJjNEcoXgdJFhkO1z2Dw96u58W/3pp3f86YylJZfKVdW0oZKyb6n7amsRKLYperKqixUu3qbyOVdYcrzVf44UxeITdUFEFjfWDN2RPkfYBB+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6c.versanet.de ([83.135.91.108] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rf0bk-0006qV-0g; Tue, 27 Feb 2024 17:47:08 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	quentin.schulz@theobroma-systems.com,
	heiko@sntech.de
Subject: [PATCH 0/4] Add support for Theobroma-Systems Tiger SoM
Date: Tue, 27 Feb 2024 17:46:55 +0100
Message-Id: <20240227164659.705271-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This adds support for the rk3588-based Tiger system-on-module from
Theobroma Systems and includes support for the combination with
the Haikou-baseboard.

Included is also a fix for the rk3588's i2s nodes to remove a
yet-unsupported devicetree property that slipped in.


Heiko Stuebner (4):
  arm64: dts: rockchip: drop rockchip,trcm-sync-tx-only from rk3588 i2s
  dt-bindings: arm: rockchip: Add Theobroma-Systems RK3588 Q7 with
    baseboard
  arm64: dts: rockchip: add RK3588-Q7 (Tiger) SoM
  arm64: dts: rockchip: add Haikou baseboard with RK3588-Q7 SoM

 .../devicetree/bindings/arm/rockchip.yaml     |   6 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3588-tiger-haikou.dts | 266 +++++++
 .../arm64/boot/dts/rockchip/rk3588-tiger.dtsi | 691 ++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     |   2 -
 5 files changed, 964 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi

-- 
2.39.2


