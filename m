Return-Path: <linux-kernel+bounces-115764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97837889789
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87C01C2EF52
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8C72618C7;
	Mon, 25 Mar 2024 03:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDOrXlja"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477151448F5;
	Sun, 24 Mar 2024 23:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321960; cv=none; b=hjptru3TMTYQJV1LjecjwhvL9I496Akz8I3oqPZQj6UF7UuEqZWNaIprvoW9j5TXE+Rsi0CV/tMnt28sHbqOv2UkvaTbM2v8Hhg05N5xfL7HL06jdQG12rP1FY7mv9flY8V+I0F23uFOcs1ng+TIE2xC74x4zBnqjLWMTKr7duE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321960; c=relaxed/simple;
	bh=T/akRPi5ao0d12BmCz3WEgH+FPHY9KHNebOOEFBHkBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fa9sSSyMqO92BvKMHiysvbgIlfRosuhICfcgWdLO3rqQ7IWG+fqnOWMbFDQwWDE/9cwVY8Q2/z8MH8BkBb0iUl2/bide08qlHMlWS8tzfoL6iELQT29v+JQcPUC1pmCfk0yrUH3gETLp7LlxjiIxcITYW69JIHVcLjspXRIak7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDOrXlja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861C1C43399;
	Sun, 24 Mar 2024 23:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321960;
	bh=T/akRPi5ao0d12BmCz3WEgH+FPHY9KHNebOOEFBHkBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oDOrXljaPq+pQKnMtyq8/dcWg/jJVJr+rRefTUPdVRGJnLmyGY9X74HSOakFvNiTM
	 uzBceLPwbRlZSK3Ht/yUeZmfKsfOYkOZG01rZJ2VPMg6g20DFdSSpd+RdU6aDBMQgs
	 GhQ0KX2S8IGlygwg4acGLW00VKc1ezdPZ4rz8L4GwWvpfnl/Uv0Krk83BTzwQCljnH
	 3n/LSO8vf7VwF7y6kn4J8z5JHeLwXakmgTWog45lz8jUFWNwRX7NtnpPr/RG4ZUo8P
	 FaJTx0NH3iKrIYAw6yEs8LOhoUhCWvvb5qRCdKIcgJu+N4IhwZrXO55g/v3Lv9/H3e
	 exDkjrjwD/UVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 032/451] riscv: dts: sifive: add missing #interrupt-cells to pmic
Date: Sun, 24 Mar 2024 19:05:08 -0400
Message-ID: <20240324231207.1351418-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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


