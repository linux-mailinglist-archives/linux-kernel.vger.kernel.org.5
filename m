Return-Path: <linux-kernel+bounces-46513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B698A8440DA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A239B30EA9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D148C8287C;
	Wed, 31 Jan 2024 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwUo7kYA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF4782873;
	Wed, 31 Jan 2024 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708341; cv=none; b=fr+czYPym3IZa+E+htcLL0G1sYH1zDukfcL/o0OMnns7Kc3KDmY+EsV9Iu64lfMZG69Oinzx6fymkYKeKOYLpR8OXg7467uRor3GfoSIYSqSbKU8pTavKjXnZWdojLrMBEH7HRFo/9pH3MI4cfo7yWwbjREvH+1SQDMYTRrjEVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708341; c=relaxed/simple;
	bh=nT7t1XLpap1ul5rw857k0oXQhboz5a3rxYW5uzDwgG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzsaMeBjvkO9MZDGUuQz1QcFjz6VAI7qT981Y7r1f2XzKzQU9QmAL4BFBbmvHaltNfXuYqVdnVCGrrZv4R5lTnyIxHIIEMY3aqZ04XCGTmbinRTSrCERNWPhFvYOHXHCMNeHxVJ0Np+nDtJKsof/N+bk66AIYc65222knGh/Yow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwUo7kYA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18641C43399;
	Wed, 31 Jan 2024 13:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706708340;
	bh=nT7t1XLpap1ul5rw857k0oXQhboz5a3rxYW5uzDwgG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fwUo7kYA7TwG/OOhXVdApV3nqAOmy00VRVZJlU4sJyC9nDmDJH6pgEi24h2pIrXX7
	 XBH0RY5F1vseRIOicRyw5LFZzVaBZS9gewLc3rWYBhJza19ZUtCHQ3SXVPwoH5Xf2N
	 +7uXsD4Zx5nhx3GrNIJmT43iuM1ESY3dCTdrfoeR/ILjwrWoiiyqiZZ+pJme4ifV12
	 KGbGx5yZIWOLWF2xwxLSV9eejVi3VXMjBzuUb+F6jk7COUVTHiO8Ud99eUsS5sbw9V
	 esxOLPVJ1cdof1ugoCp6G1N+yUhFPRlhp2+OjUmb11+MlOxGBoAbhGhQersYrGD4uG
	 WLy62blC7XgAw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Emil Renner Berthing <kernel@esmil.dk>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 3/6] riscv: dts: starfive: visionfive 2: update sound and codec dt node name
Date: Wed, 31 Jan 2024 21:25:57 +0800
Message-ID: <20240131132600.4067-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131132600.4067-1-jszhang@kernel.org>
References: <20240131132600.4067-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use "audio-codec" as the codec dt node name, and "sound" as the simple
audio card dt name.

Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index b89e9791efa7..11db93966dd6 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -41,12 +41,12 @@ gpio-restart {
 		priority = <224>;
 	};
 
-	pwmdac_codec: pwmdac-codec {
+	pwmdac_codec: audio-codec {
 		compatible = "linux,spdif-dit";
 		#sound-dai-cells = <0>;
 	};
 
-	sound-pwmdac {
+	sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "StarFive-PWMDAC-Sound-Card";
 		#address-cells = <1>;
-- 
2.43.0


