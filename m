Return-Path: <linux-kernel+bounces-161637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C19178B4EE9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 02:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DEE5281255
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB93A8BE7;
	Mon, 29 Apr 2024 00:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfzXQFNa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA8DC13B;
	Mon, 29 Apr 2024 00:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714350416; cv=none; b=KpIXbqEqFEkTDwSVITFAvHn4QOW2wjQqSUHLw3EtgVqZKfSNlUkJCPHyfCEUfNorFFetdDlcdpNlrqFXoT010VTJEYPOAkjb1cTIFYqaPI9kAfRF/3r/lHw9ID3og+YHb+3DjxNbSE27Ij61+f2HdHngfsVUpFt7M6caLAfJS4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714350416; c=relaxed/simple;
	bh=oTgkNFvfPsJNNr6c8qJP0JFAmo0sDPa2N3exYAFyIsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXeDZ1f9Pqq363uy89KY2hK9i7PW15Tyc8d32GfKU+Xgvcv8vb3Gi+jXwCkxTkMYgS9LoLBlu0JFzG89UgveyAoUVmez8+Q8/qW60W57Ac1lPXuY19uYKacmw9APGCjNh0X00lJvSV/pxpfaBkkbXIKrdei6AJLS7dqBzdCXOPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfzXQFNa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD60C113CC;
	Mon, 29 Apr 2024 00:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714350415;
	bh=oTgkNFvfPsJNNr6c8qJP0JFAmo0sDPa2N3exYAFyIsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YfzXQFNaEpaUPyw1zspe5HQciNWWa4VCRsIcmNAj003gvqq9L1h9jiEBmTAp5Hq7T
	 lE0nV/tFIGHi2JdquFbfROkub1yHMRJUs2TbwIfKnoYwgXZhelhDFpCbSU9VFnCL6v
	 V0Uy7KbAw8LMglYp9As57LKOYmCgMUSvGUFJL/Qh+2CDOeC6FQiArbuYDyzhhZ6AVE
	 gJIfL0m7UPlj7SHXGr8ebpJDA1BsXnYXoVdBS8B8lV92mkTAwMxt7cg/tSOItSjPVA
	 qOud96fm40NcZB1Bfow84LjBiAYMhf1MUYOiFvjbpFSG+zOSdcmIxnMQ8HcdDwKqD4
	 Mhz5yQQGxoOdQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Emil Renner Berthing <kernel@esmil.dk>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: [PATCH v4 3/8] riscv: dts: starfive: visionfive 2: update sound and codec dt node name
Date: Mon, 29 Apr 2024 08:13:12 +0800
Message-ID: <20240429001317.432-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429001317.432-1-jszhang@kernel.org>
References: <20240429001317.432-1-jszhang@kernel.org>
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
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 .../riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index ccd0ce55aa53..50955cc45658 100644
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


