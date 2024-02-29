Return-Path: <linux-kernel+bounces-87487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACD886D507
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A971C226DC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F068157AC3;
	Thu, 29 Feb 2024 20:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFQol4sV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54E41527B8;
	Thu, 29 Feb 2024 20:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239245; cv=none; b=WguoM6ysEZpZ9ewgO4j7CbCgNih11Tu8Cv9Ok2ja4Dcj4xwAt0GEhAx9xJWQ6psiQt7nF+2hn43JyXrdALRX7C7JZjQlPkow+VUKR6f7hxkys0TrarfTK5ltGD6vBf3gpcLbuoQQL+XEx/KGqGCdXoxmpWkMFbpIRnXBy4xqRhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239245; c=relaxed/simple;
	bh=T/akRPi5ao0d12BmCz3WEgH+FPHY9KHNebOOEFBHkBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/xOGmfB+TEl71fEVOpK/1Z5KoyZhIZMIMRS/HsmeRwzOG72L7NCki0y8XP/LKkj8VPdSH6+KEuZD0t/fJU3iHGbCj8ZIvf0iYGX9WlIOCdNis8tBrlo1ohOwRJrZKxF4mI2zWBu7WdZCUPlFUE5kexsp7El9w2+VHTS8KX0OTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFQol4sV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022D6C433F1;
	Thu, 29 Feb 2024 20:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239245;
	bh=T/akRPi5ao0d12BmCz3WEgH+FPHY9KHNebOOEFBHkBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EFQol4sVU2+K8g+pqLmbEc0eSBftT1N/OQVdjBoQHD8OUWSy3KNVThXj4t/Iar+dY
	 lm9MvfkkypkxUdm7mJhSPsI6a3MF7ptGoteFFCSoVnJ57YudlGN72MVVItxStLqyen
	 JBzdEeKE8B29IiMX+tYc5RE8KzhCLf9i1Ctnr8s/1ItScvVHX2YPb+cgnjfWUpWKHg
	 +v+0kJaLIshKRyNcIEkuo56DoXTegBIJOm0kxd18v/Q3+II7V5V/4eF9rzlTqX/D/5
	 1C9f8lq8+bGSAeIyvt1lnvQgk2GmiEJ18wpwG7f6WAY9V80tirZJrP5pB0avoNTI5M
	 +F/nWzJ5crBBg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Sasha Levin <sashal@kernel.org>,
	conor@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 04/12] riscv: dts: sifive: add missing #interrupt-cells to pmic
Date: Thu, 29 Feb 2024 15:40:26 -0500
Message-ID: <20240229204039.2861519-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229204039.2861519-1-sashal@kernel.org>
References: <20240229204039.2861519-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.79
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
index 07387f9c135ca..72b87b08ab444 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -123,6 +123,7 @@ pmic@58 {
 		interrupt-parent = <&gpio>;
 		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
+		#interrupt-cells = <2>;
 
 		onkey {
 			compatible = "dlg,da9063-onkey";
-- 
2.43.0


