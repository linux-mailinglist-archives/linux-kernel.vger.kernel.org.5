Return-Path: <linux-kernel+bounces-128632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D66ED895D43
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 753701F224D7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DFC15CD70;
	Tue,  2 Apr 2024 20:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzAZHfZe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9459215B0E8;
	Tue,  2 Apr 2024 20:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712088472; cv=none; b=OAu7N0fbtccNlmD95rEmMI/jp6+F0BGX6rcO66nwBlT48kB4OQBJEx0MetCIfPNMKty4AIXRKq/40Y83QEir8QLxoNwxC9leyGkCykfO12qivVMN1BmhIKHPB/gOQqKZeLoUsxG9e1mWQLJXGOEPCt8cjK6v2zqYk5NEoPxaCbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712088472; c=relaxed/simple;
	bh=GZGpoqpZc5Vz/JZITMvQIiJJ+GUZcOu7aGmv2hLnV1I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K7r8O/x4KE2402obpoxnlIUKfbvmPYJ6xknE4JMU+t9VOEG1K/MPcTS3PArwbjG6nM1WQuBI1IsApB1D6Nita1bvhpmmHn9NZwBbHw0YTzgAmTG+Uk0YSTJWWOdOB39CBd+lL2EQ2dyMEvP9xx1RDlyqrufbODGdWU1aWurWFv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzAZHfZe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61650C433C7;
	Tue,  2 Apr 2024 20:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712088472;
	bh=GZGpoqpZc5Vz/JZITMvQIiJJ+GUZcOu7aGmv2hLnV1I=;
	h=From:To:Cc:Subject:Date:From;
	b=pzAZHfZeeiAxGwE0yjw/O+Mdpjp5ApBQfreuzXoA5cgVkfy7jEh7rbn/czDRvtck6
	 s54WyyvALVzeWfpBBMRnCn4CUZlVjvTDs+p6+il1TsKSA62df+JXa58okUIt2AqrEX
	 8C+tRdjoOp1MwNwUIkMm8ufahysR82UiM63aAi4F8OJhHLaS9aXqCKJiMdC0O9f1Vv
	 3IzgTyCEizgkv4uTUwsX4nN2sa9/fwbEHewDt9J2Ug7iMiPSDIrz0OVCpr1zvnPL02
	 QliSEE7TjqenrIiZyLEQdAHzF7/U8jLl3baIj4Hmn6ZjPAkZmfsRAHNxrV/5YWCQuk
	 dfhDyIgRKmc2w==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tsahee Zidenberg <tsahee@annapurnalabs.com>,
	Antoine Tenart <atenart@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/5] arm64: dts: amazon: alpine-v2: add missing io-fabric unit addresses
Date: Tue,  2 Apr 2024 22:07:40 +0200
Message-Id: <20240402200744.79349-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add io-fabric unit address, because it has ranges property.  This also
fixes dtc W=1 warnings:

  alpine-v2.dtsi:153.13-229.5: Warning (simple_bus_reg): /soc/io-fabric: simple-bus unit address format error, expected "fc000000"

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/amazon/alpine-v2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amazon/alpine-v2.dtsi b/arch/arm64/boot/dts/amazon/alpine-v2.dtsi
index dbf2dce8d1d6..32b6ac8a5352 100644
--- a/arch/arm64/boot/dts/amazon/alpine-v2.dtsi
+++ b/arch/arm64/boot/dts/amazon/alpine-v2.dtsi
@@ -150,7 +150,7 @@ msix: msix@fbe00000 {
 			al,msi-num-spis = <160>;
 		};
 
-		io-fabric {
+		io-fabric@fc000000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.34.1


