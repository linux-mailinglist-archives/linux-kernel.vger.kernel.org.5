Return-Path: <linux-kernel+bounces-28012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7191382F90C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03F8EB26B6E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3915D13E22A;
	Tue, 16 Jan 2024 19:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhFQJmx0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7622513E216;
	Tue, 16 Jan 2024 19:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434833; cv=none; b=Ly3Us7YF+JOclufMpYGC6zqhIlMEeMZqPXsYn6SOY9gHz0a6OH89OB3BvrlYVaBpMuz/sJm8Kav5SmL7ZB8VgPdpTZIcCkqnk5JP3bP/2H5S9uwOfgdKnMYTyo+Vw6r+0vgxcG7mNm+ZzNzS5L6G6rkhHHS1owGTjUaCEf2Ie4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434833; c=relaxed/simple;
	bh=1IIOulkQDN13tdGFSOGwHqIlVziots8gO/o/4wKI6Bc=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=VvkHyBM66UOXqaotu3Z4ET7eR66m46QDLK66XRBBNkY1o0AgwSmzKobhx+hnDtgMkxzqPv3OodaKvZ+ATqZU5nnUk0SBQKklKoHTfU++4foNkYVLa0wXvjA8PciKVlTytP7dTl453ZQhtMX8VoukAiGrBXhrgUfv4JWF/BiUqhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhFQJmx0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47579C43141;
	Tue, 16 Jan 2024 19:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434833;
	bh=1IIOulkQDN13tdGFSOGwHqIlVziots8gO/o/4wKI6Bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FhFQJmx0fbu/G0iI8K1z1seEoALfJErk4xh5prrDKUSQOE+B4qtxIvZI7cahgtbWR
	 rcycrN18Romi1/Bppmfb12yMWO2bBtM5WAfjES2sTyILKtQd/JAEklxhjRSYAU6zC/
	 lSe7IEb4Y7zv/BzrUTnpwuiZGZpvDLnUz8J6tD3GVIABJzDw1ru3Bi3Bjzo5NGfURm
	 lxQp6/dtX5Jkhxy3Cc8teQDBEIf4aLCks28mrPfirlwewOh9a5NI+6YdR/zEKLXINH
	 pXadPI9SP8x9VrofTc0x9XW8ko9Tc51emg7Dr2WhYPKLhpWDSAlQ9RcROrLa19piWH
	 vUn00dsik19dA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chunyan Zhang <chunyan.zhang@unisoc.com>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	orsonzhai@gmail.com,
	zhang.lyra@gmail.com,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 100/104] arm64: dts: sprd: Change UMS512 idle-state nodename to match bindings
Date: Tue, 16 Jan 2024 14:47:06 -0500
Message-ID: <20240116194908.253437-100-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

[ Upstream commit 1cff7243334f851b7dddf450abdaa6223a7a28e3 ]

Fix below dtbs_check warning:

idle-states: 'core-pd' does not match any of the regexes: '^(cpu|cluster)-', 'pinctrl-[0-9]+'

Link: https://lore.kernel.org/r/20231221092824.1169453-3-chunyan.zhang@unisoc.com
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/sprd/ums512.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/sprd/ums512.dtsi b/arch/arm64/boot/dts/sprd/ums512.dtsi
index 7984492ef651..b85be1034554 100644
--- a/arch/arm64/boot/dts/sprd/ums512.dtsi
+++ b/arch/arm64/boot/dts/sprd/ums512.dtsi
@@ -113,7 +113,7 @@ CPU7: cpu@700 {
 
 	idle-states {
 		entry-method = "psci";
-		CORE_PD: core-pd {
+		CORE_PD: cpu-pd {
 			compatible = "arm,idle-state";
 			entry-latency-us = <4000>;
 			exit-latency-us = <4000>;
-- 
2.43.0


