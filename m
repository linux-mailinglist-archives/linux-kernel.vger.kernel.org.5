Return-Path: <linux-kernel+bounces-27829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9395A82F679
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B111B1C244E4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02E1374FC;
	Tue, 16 Jan 2024 19:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meOmRU26"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D468360B3;
	Tue, 16 Jan 2024 19:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434299; cv=none; b=LeePMrIuCV1/GugMfRKce9zCk6vQApmUmEXdhWfjLoqsVsppOevAMP7UG0gsKWXySReT8vY0IX43QoRb6TQny2j275FxGqZGwq7OCMcd9Ljpg2fJWrQybPumETfh6AsrWRn24Q1mPdjJe7zoPG0c2NMXP2grULhZK7fdXZe7k/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434299; c=relaxed/simple;
	bh=QoZWa/ZhPaxQYd196ykS7x8fPnYHIQxjy2Is77FyoUA=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=KOHT9VyzqwGLm/tdnFw9/D8XCNsIv3+nScwa+drIHVt+uYd12qsXkJhM3sDiUTivBIPjV9H9N4Y/r0NcE543NEVveLUej/VTp/CWDuHKqGg5st2hUdARZoV5OpOUyY8T3JnNY2yskjEYLc2a9DYdwLxewVziA8ulgmHmPAvsyZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meOmRU26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D871CC433F1;
	Tue, 16 Jan 2024 19:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434299;
	bh=QoZWa/ZhPaxQYd196ykS7x8fPnYHIQxjy2Is77FyoUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=meOmRU26jizW5fGc+QJHEJgiF371aRvwAnEFofdCpEzxXoKVnT/Limf9AN58ZAMA5
	 OVNFZBH6a68MMGILKvoatS9UWZXrGX/sfsMQBSvhTWzv8vmL2ISsPP8+MUbqcIkMEN
	 sVUKr9Db40hFOTMo3sPKf0/DgwwXI1aNNuZd3r997Yyy08jqyKtj2ggHCLkTtqIsvV
	 OJyNVeiK7KegR4RsaB77oUg9EtWgTdwjZjk8ypfabRMd8cwdUDkuxQFZBF648Iw12w
	 7OOl7jsum7SdkujngffiVtgnAXpIRaKnEL7gZwMLsjYE4XET+6py8D+XWkQLcy5kKW
	 3ECtPl5XHSnvg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fabio Estevam <festevam@denx.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.7 058/108] ARM: dts: imx27: Fix sram node
Date: Tue, 16 Jan 2024 14:39:24 -0500
Message-ID: <20240116194225.250921-58-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit 2fb7b2a2f06bb3f8321cf26c33e4e820c5b238b6 ]

Per sram.yaml, address-cells, size-cells and ranges are mandatory.

Pass them to fix the following dt-schema warnings:

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx27.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx27.dtsi b/arch/arm/boot/dts/nxp/imx/imx27.dtsi
index faba12ee7465..cac4b3d68986 100644
--- a/arch/arm/boot/dts/nxp/imx/imx27.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx27.dtsi
@@ -588,6 +588,9 @@ weim: weim@d8002000 {
 		iram: sram@ffff4c00 {
 			compatible = "mmio-sram";
 			reg = <0xffff4c00 0xb400>;
+			ranges = <0 0xffff4c00 0xb400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
 		};
 	};
 };
-- 
2.43.0


