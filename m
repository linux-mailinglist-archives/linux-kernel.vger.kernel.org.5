Return-Path: <linux-kernel+bounces-27878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CFA82F71E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06241F2225E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4540745E0;
	Tue, 16 Jan 2024 19:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJBUNBQT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BC77318A;
	Tue, 16 Jan 2024 19:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434416; cv=none; b=fvFq7QFXM+/gih3qMfVsgGlrzFXbQF+enqsGIwau6oWNl7CPVFblZR0iK6QWx6aASPopPAT+OIbqMp3y9YoOsB/MzraOOknsoTM05sgLyvlYSyaoKJz2CMNfqJFWigU0zf1E/wDEvOJ5GN92tlxKZ5wk7GRYidM5GhXJ+am14C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434416; c=relaxed/simple;
	bh=1IIOulkQDN13tdGFSOGwHqIlVziots8gO/o/4wKI6Bc=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=BGIPK4dBXE8Zm8Yb9AjeJlTWCuRHEMoVHWqUQQadEEcocnvVGT/Mw0ptWx3m+e4iBefgSkLfAvpj1T6tmkOIvOT28yuzzdNL6SyK9pRjoqIvhaQ722s5C+ar0evpmH6BRbgHlEjpMaJ2t7A9yHz0hRuC89vpMs21X53XrC4/yZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJBUNBQT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A804C433A6;
	Tue, 16 Jan 2024 19:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434415;
	bh=1IIOulkQDN13tdGFSOGwHqIlVziots8gO/o/4wKI6Bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PJBUNBQTdI6WvzFk2ptI41uEK4Rchx7v+MZN7Q1f+1UFBwAYpR3TSHkEs4GLkpIJl
	 pcnOhF9pBkbbUwphBZHiZL4eWkpnSjc4oOX1dpDvzP+0PuEfmRD/gZmW96Wy9v4Wmp
	 KgypR9PcsSx5ot/WBTBVeyBvBOH9lxg2l2zq5BEKjOedrvYhcjH1Jhy8xhFi2xCWk5
	 9BNzMkwFZmBI5JjrbXk0cU3SMSrra18uN/yXYBQgeOKF0XY6UeXjtchfcuONC+wXWU
	 hpyPtWUK5569YUfnKii51Pae+0TGQo8xj+AO8Rus+v8q44ft8C+WE8KfZ3GFvakQB8
	 vz711roBlivOg==
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
Subject: [PATCH AUTOSEL 6.7 103/108] arm64: dts: sprd: Change UMS512 idle-state nodename to match bindings
Date: Tue, 16 Jan 2024 14:40:09 -0500
Message-ID: <20240116194225.250921-103-sashal@kernel.org>
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


