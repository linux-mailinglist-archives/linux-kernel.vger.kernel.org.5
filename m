Return-Path: <linux-kernel+bounces-28159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D77682FAF6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BFE61F29916
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C8C15E260;
	Tue, 16 Jan 2024 20:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1MUvMvo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BD915DBD3;
	Tue, 16 Jan 2024 20:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435299; cv=none; b=Gn2mrBcPG6b0LtOI/Vk/CA4SlNucJce3H9hdy1lQsBeDRTd1BSJ7BDV/qrKUkP1qT7BgfL39kEDwjFvIDiG0pjujNMUavpAznNI84PVLyZ9d0dZHozlh6USzeNWC5GyWBiunxd1BftB5zidAN+srg2LnnxuyoaJXlBvyyO65t+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435299; c=relaxed/simple;
	bh=TpIn0sYzDKTNLyjxVZQbjcwV6P26TV7ODmfiYNVZeqI=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=qMys2iZBQU+eVr0KRzhSHaXf4AfFwDTl4huJhklVLxqppefcQ6J4hOwIEMFaFKVROKgDBrptY+RROo34dS8k2LinmuMa71ld8IFb8579A9wwNdAuE0YKfwNwV6eNMou+dhGfYjg8jTe0olBrCTfvXUvXNfvF9txFp3sEIILLvvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1MUvMvo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5D8C433B2;
	Tue, 16 Jan 2024 20:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435299;
	bh=TpIn0sYzDKTNLyjxVZQbjcwV6P26TV7ODmfiYNVZeqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z1MUvMvoE6I5SYJzPv444veBTTCZSMjh+ABSOMnLt80cPzvkztOJlT6ppRu2wyS6V
	 MRJGvE2q7P6azyyol7LgycCgFPWAyN9GWVcKAt4CkDx2jatRjaNpjpI1P92LDBi0m9
	 P9TZmMLmd5Wf3OpA9jxWJGv23EAph/e4d4K/oy7iv7JEB7NOH8HMuHLTSU7nLKx16R
	 Hm6EWk5BNbzwMiWRojT0KMf4XJPUqveocD0cLSaH1HwYEmfCJbQIeZaxENg1SwR0Y3
	 nikf7AstaH0qChgn/Wrtfnfs8bgb8viczSMuxUWc23V6N+/4RoE02h5v4RKWUErTIR
	 8KMYzdRYqqOug==
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
Subject: [PATCH AUTOSEL 5.10 23/44] ARM: dts: imx27: Fix sram node
Date: Tue, 16 Jan 2024 14:59:52 -0500
Message-ID: <20240116200044.258335-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200044.258335-1-sashal@kernel.org>
References: <20240116200044.258335-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit 2fb7b2a2f06bb3f8321cf26c33e4e820c5b238b6 ]

Per sram.yaml, address-cells, size-cells and ranges are mandatory.

Pass them to fix the following dt-schema warnings:

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx27.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 7bc132737a37..8ae24c865521 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
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


