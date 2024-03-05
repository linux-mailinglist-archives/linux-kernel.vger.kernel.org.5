Return-Path: <linux-kernel+bounces-92584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 255B587227D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFAE71F2343D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF131272B6;
	Tue,  5 Mar 2024 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osasysteme.de header.i=@osasysteme.de header.b="YKwE2vlv"
Received: from secondary.pambor.com (secondary.pambor.com [46.38.233.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666DD1272A0;
	Tue,  5 Mar 2024 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.233.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709651689; cv=none; b=OO8FAzJ2gosK47WkgDSPC/BfUOT6nTrb8jWTAgap+ZzIgV0GXMiwNDVW3RfAw6upGEL0cbKeOHWzI1kuxUaJvRoI/z0w7QFxSMvRNIHItK0UlGMsIROHCX0nijBzuRucVWzdu2LkGyMUluZ7TsDNQ1K9wwLV+JfWzhbl6EfC/Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709651689; c=relaxed/simple;
	bh=VOYq/MFTo0yEAHpbuYHcwnTD5HvVjidlBhWkaXa2qP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f052fS0W4Rej+TocanB+uLAhR0+iDZDX6k9AIi2xx23Lbvhz8Ev6s4FoQZrXd/d7y5PivMKk6QTTgrxhjJXTuuwh3z/xAZXv0vhzD+ReUc/OkdTi0glAaDzPuc25nKL/6E6WnggbNkGEf516K2OggqjDxRdOfwg80q0jCyAq6XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osasysteme.de; spf=pass smtp.mailfrom=osasysteme.de; dkim=pass (2048-bit key) header.d=osasysteme.de header.i=@osasysteme.de header.b=YKwE2vlv; arc=none smtp.client-ip=46.38.233.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osasysteme.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=osasysteme.de
Received: from localhost (localhost [127.0.0.1])
	by secondary.pambor.com (Postfix) with ESMTP id 5A24E6F03B4;
	Tue,  5 Mar 2024 16:14:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=osasysteme.de;
	s=19022017; t=1709651682;
	bh=VOYq/MFTo0yEAHpbuYHcwnTD5HvVjidlBhWkaXa2qP8=;
	h=From:To:Cc:Subject:Date:From;
	b=YKwE2vlvRdJoqi6l+wjPZe/8ZFrPXzXlssXOhHNFBFJ/Fu0OgEWmeXQg2u9BUr4gl
	 Lu/6ROceiY85q6HQaBHEapUe39htU+nilNP53HixffXqhjIJEKtU/NSjEklWx5DG1h
	 JQShK0YX3E1GajudwFGkc8rZ9A8dJi+lDU3D7ZbJD99GzijGnm4DWXvOGgdk/4fFjB
	 fXiBi+XXphofSQ9qDrFNmbDmZ5xZSzzqPyS1ovNSrw+yvFVqjbDrjXOgc1Hyj4qrvm
	 YCW+lLTr+zVFZDdZZxG+50uQcIu9BNjNsyShdJwXnPEgmAnC9fe7SQFTAY2yI22hh3
	 FiY25YXR4dE3g==
X-Virus-Scanned: Debian amavisd-new at secondary.pambor.com
Received: from secondary.pambor.com ([127.0.0.1])
	by localhost (secondary.pambor.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id upWvgw96FKnx; Tue,  5 Mar 2024 16:14:40 +0100 (CET)
Received: from chromebook.fritz.box (dynamic-2a02-3100-5dd1-2001-a8cd-25c2-d6af-d5f4.310.pool.telefonica.de [IPv6:2a02:3100:5dd1:2001:a8cd:25c2:d6af:d5f4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.osasysteme.de (Postfix) with ESMTPSA id 1E9796F03A5;
	Tue,  5 Mar 2024 16:14:40 +0100 (CET)
From: Tim Pambor <tp@osasysteme.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tim Pambor <tp@osasysteme.de>
Subject: [PATCH] arm64: dts: r9a07g044: Add complete CPU cache information
Date: Tue,  5 Mar 2024 16:13:36 +0100
Message-ID: <20240305151336.144707-1-tp@osasysteme.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on ARM Cortex-A55 TRM and RZG2/L user's manual, each Cortex-A55 has
- 32 KB of L1 4-way, set-associative instruction cache
- 32 KB of L1 4-way, set-associative data cache

Each cache has a cache line length of 64B and therefore there are
32768B/(4 * 64B)=128 sets for each cache.

RZG2/L are not configured with the optional per-core L2 cache but only
have a L3 cache shared among all cores. In this case, the L3 cache appears
as a L2 cache to the system. Therefore, specify "cache-level = <2>" for
the L3 cache.

Signed-off-by: Tim Pambor <tp@osasysteme.de>
---
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 9f00b75d2bd0..6379c850526a 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -89,6 +89,12 @@ cpu0: cpu@0 {
 			reg = <0>;
 			device_type = "cpu";
 			#cooling-cells = <2>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R9A07G044_CLK_I>;
@@ -99,6 +105,12 @@ cpu1: cpu@100 {
 			compatible = "arm,cortex-a55";
 			reg = <0x100>;
 			device_type = "cpu";
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R9A07G044_CLK_I>;
@@ -109,7 +121,7 @@ L3_CA55: cache-controller-0 {
 			compatible = "cache";
 			cache-unified;
 			cache-size = <0x40000>;
-			cache-level = <3>;
+			cache-level = <2>;
 		};
 	};
 
-- 
2.43.0


