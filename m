Return-Path: <linux-kernel+bounces-58189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BFB84E288
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0208C1F290E0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCD97B3CC;
	Thu,  8 Feb 2024 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvjRVa/P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EFF7AE62;
	Thu,  8 Feb 2024 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400341; cv=none; b=K5DLiD2VFKXIopCboQ89suN7bRTkkMzC9Pby9Jw50uCpG8tKLp4/qJnioa3E8ZPI3E33BGems7kLCdypMlpxX9jrn0TdPltSBLuOG1PjNeHtphis/o7EbVsDtD3m18F7dlvO/56oV3Lh4FxuruOMWMOqCoc7hqG9lNGu9Cg1PqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400341; c=relaxed/simple;
	bh=9J6hs2cF1PTZz9x7RaAYnxiP2LNQddxpTIQiNApPAzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VpgQqV869AAt4FDrDZ1ZoYXoKVi/VaViMwRW1dQhgyBd1Czvvp9cczSYYRrDj9Qv+PY/EoiMxZCjOgjvu0sE8P0laxOl0TwtW7jTw1sb7jkLHKmZ6+HGzc272+cuY1r6HTNTQoRFkcG0YkRDpfLTA7bTTlq4UsYsf4F1AtB2eJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvjRVa/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA9FC43399;
	Thu,  8 Feb 2024 13:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707400341;
	bh=9J6hs2cF1PTZz9x7RaAYnxiP2LNQddxpTIQiNApPAzw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tvjRVa/PV7O+xZRYX3k77JzS4rQtYx1qcnz1SquOWtrdDOdoWrSMZnxWRRmRMO92d
	 tuDUeDvg2nDV0ioQAjScNmCFqhzx7iA6GETU8+au7IdV1FxuVGUqndT8NlDf2lzjkL
	 WrAa//27OIFu1wFmNzsQV5xG7B+W0oadKogZDDLUehEYEZusEVbwxtNTXqz7B2RTU+
	 8/i5hudJ+PEWDFBId0YHeuqUNqOw82986NW6LFerQkxWjNcdKs8m9WEajPCY6oUJml
	 vCzGoMogf3G6LzeAjqXPW9Rb7MPU4ypfBbz9oN30dIBBgIEZYKQ2qfWnDSEqiMuRL6
	 EdJ2HnVhRwLdw==
From: Roger Quadros <rogerq@kernel.org>
Date: Thu, 08 Feb 2024 15:51:43 +0200
Subject: [PATCH v2 1/3] arm64: dts: ti: am65x: Fix dtbs_install for
 Rocktech OLDI overlay
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-for-v6-9-am65-overlays-2-0-v2-1-70bae3e91597@kernel.org>
References: <20240208-for-v6-9-am65-overlays-2-0-v2-0-70bae3e91597@kernel.org>
In-Reply-To: <20240208-for-v6-9-am65-overlays-2-0-v2-0-70bae3e91597@kernel.org>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Andrew Davis <afd@ti.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Aradhya Bhatia <a-bhatia1@ti.com>, Nikhil Devshatwar <nikhil.nd@ti.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>, srk@ti.com, 
 r-gunasekaran@ti.com
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1031; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=9J6hs2cF1PTZz9x7RaAYnxiP2LNQddxpTIQiNApPAzw=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBlxNyMI3N0hea6elrgcUCo2pgDgfkaWLgL3RVur
 w3OdJDZwKmJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZcTcjAAKCRDSWmvTvnYw
 k1ByD/9cXF5sSs+pVNvHL9HwYu3v8oeNmVN4sPOuWVzaiX3+6RsNGqgggmbrl9Dqg2mXm6KsKup
 oj+xl+Yrb/ls+EzbvJYoRkNdwsUoPsVCqD+KyhbAvx7Nt/d+Uv+8xOow0nEHNxS9Wa8iklIEmCP
 mONFEnmo/mT4SXFjU+pTjYUU9KpKBWb2iHzl7fqbyu3FkCsl39AKzOv3c8BagSKSmmd5jjmbHpF
 MT9y0GyIZDDyiBbeKCS6qrge74IkaK1Ems4dgARv49QQTwVSlyuNRs7BIeHUU50U0pkFvl1EZiM
 /Hv0b/Jgqjh2zlWfdTe8Lq6/b+L6KYVnPnw6rsnmLKFsE6Gm7TGKXvcMu315hv8mLOVOTw4WtYT
 UE4XHHfxpPDFQqszcFBW12+tWx0S+9vth1hcIyLLERZQdhWyB1mtyZ2FhhDmZNECOdI9GmwP3dp
 xerVNimL5m3sPnmnRw9lFNimG5trQTffqiaysFByc9yati5/W3tKZfbIED85LOQ5NUgDRM2CcP3
 rE8qMx6MHH46EVuPaqAj9QHKrPNPfXaELO8k6pDsn9GtRd6CHf5jSSGYSnoGwzP8hZ/HoqEhRK7
 F7cS3HaWd+50tESVoKW5xSurspnGzPNQXvVXVH6MCre5wPLmQ+fGVj2/OH40Um2OlmTdVvbU4oe
 q5bZjQrFudlqWBg==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Add the overlay dtbo file to a Makefile target so it can be
picked by the dtbs_install command.

Fixes: b8690ed3d1d1 ("arm64: dts: ti: am65x: Add Rocktech OLDI panel DT overlay")
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Changelog:

v2: no change
v1: https://lore.kernel.org/all/20240126114530.40913-2-rogerq@kernel.org/
---
 arch/arm64/boot/dts/ti/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 4a570dffb638..bfcc86ff8e24 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -57,6 +57,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am654-base-board.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am654-gp-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am654-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am654-idk.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am654-base-board-rocktech-rk101-panel.dtbo
 
 # Boards with J7200 SoC
 k3-j7200-evm-dtbs := k3-j7200-common-proc-board.dtb k3-j7200-evm-quad-port-eth-exp.dtbo

-- 
2.34.1


