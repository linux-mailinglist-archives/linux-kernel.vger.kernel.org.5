Return-Path: <linux-kernel+bounces-87498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B965886D52B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7A9E1C21DD7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F23F16536E;
	Thu, 29 Feb 2024 20:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+zI7Bpj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD601504FF;
	Thu, 29 Feb 2024 20:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239272; cv=none; b=EUNKO0/JBWwPgfRgONWZSa0tXDYIKNMrvy4tWOQ3fw9Ep4i+gh4e87O7Pq0jigrfXmS4OufMsd/HgC+Q5vwv1aw2CkahqmRgHlC1/GDcwgepFHNHNWZOmNmuJVwgZ8X8Z9HDvIgDInuLb7Ki5Nk4+BVHxuINUc+PsmC3IrkAVxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239272; c=relaxed/simple;
	bh=lDJ/WcAUElCfR9BHJ0p9gKCvoLwlAhMexx0r5bWWcn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBmK6wQKm51b98dGEzOOrVS8lPngFoDCA5Oppxs8wxjiFj6T0/swplelfPyJmB4NjsInKjZXrJHzwjYPjcGj0GB5JJmpAFp25p56Z5ljYVmfJOFDKV0dOH6yaUYw6ORbaPa90g/fzM6NmRXSt6p1+8T9UL8NVw6KlFObWV1zoKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+zI7Bpj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCEDC433F1;
	Thu, 29 Feb 2024 20:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239272;
	bh=lDJ/WcAUElCfR9BHJ0p9gKCvoLwlAhMexx0r5bWWcn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D+zI7BpjWt3bAu2rSQ7RpMZvdJy7NEVKnrX+TSI4Y33jGY1jcDc780CPRWXe9Pu1F
	 9Wr5IUX1EnyrbfW/m7ILptwomULiLpAx82alljWVxHW6Q7BsQ1MFg7FRugaP8tOAW8
	 GEh9I7DVwLYo8oA2tR1q+VBbGUMm/jo8ExJUO9L7AItXtGcOR6BrIc0Nu7LucLenqj
	 +kPA/pLF2Na58sEGOKUzoQuLQ1VpuGSpSzZIQZKjHI3lAqx3Y5N/6o18EqKMefjUq1
	 nlfDnYRJbMEp8d14Wcs/oVGavmcxXey5aSdHxfMzBXI9i9E730nPmVUF9JnMibzdqJ
	 FANIzg1suIcDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 3/9] riscv: dts: sifive: add missing #interrupt-cells to pmic
Date: Thu, 29 Feb 2024 15:40:59 -0500
Message-ID: <20240229204107.2861780-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229204107.2861780-1-sashal@kernel.org>
References: <20240229204107.2861780-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.149
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

[ Upstream commit ce6b6d1513965f500a05f3facf223fa01fd74920 ]

At W=2 dtc complains:
hifive-unmatched-a00.dts:120.10-238.4: Warning (interrupt_provider): /soc/i2c@10030000/pmic@58: Missing '#interrupt-cells' in interrupt provider

Add the missing property.

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index b40990210fb50..3c621f31b5fd2 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -70,6 +70,7 @@ pmic@58 {
 		interrupt-parent = <&gpio>;
 		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
+		#interrupt-cells = <2>;
 
 		regulators {
 			vdd_bcore1: bcore1 {
-- 
2.43.0


