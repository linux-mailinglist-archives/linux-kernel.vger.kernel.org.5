Return-Path: <linux-kernel+bounces-128636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25591895D4B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B083C1F22591
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4286E15E209;
	Tue,  2 Apr 2024 20:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VW1unQAR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8167815E1FD;
	Tue,  2 Apr 2024 20:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712088484; cv=none; b=QrS7/BMapg+f/fy27DAO61ZfTqxzt09lKHHyzFx9OxABPnTBt40GHgdsFgJ3nk8rwACirR/jxYgaeibkyrXTyZm3bB/h4ySLLgSRPgkRcWLZsYCPS5a9rFRnDGoBijE6/CtzIdk4o7AzS4ZEiBKbOeJtRKPohVsKYB/azY99RI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712088484; c=relaxed/simple;
	bh=3bQzp/n5u/i9acgblOr3IwMEUNiy+bSBcvu4wAJE5i4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kUi21KKUb3zhFXaqGwOBXR4k/Ymq+GSh+jW3pzwv1nrHCeNQpF1fN5/cc4gBov6ioFkUobG+MPfrpbIDD9wUPsKv9NuCzR3CbNoxo0vuYYr4rkhA/nNv9z8dCk+qFk+4VfL6jaW59xFdEoLyN4nd+elerSf5Zwzohh5jpROG7so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VW1unQAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC89C433C7;
	Tue,  2 Apr 2024 20:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712088484;
	bh=3bQzp/n5u/i9acgblOr3IwMEUNiy+bSBcvu4wAJE5i4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VW1unQARxMvDjrpnvQo/CzmwW0DVHA9htop2SYnPif439CkVHkCQGqO1AWN+F0Ont
	 fwRBLbCh24HPHh9wHTg1Bf6RcbIED9npehZCSFlP5Tq7Ta8ghILsaWAaavNBuDzO9m
	 tyXezZHXmnX6DQmzjMMOqxdILIz4OSDtE7qXfFb23x/2OTUVIoqX0GN0IVVSLR04U6
	 4ZkHrU2FFpsxVvftR1eY4VAAwcyqynnuCliNgjQHzHcOG92xkkUy0btkBBBHak2BhA
	 aTJW4nATrieI5reQR/IDy7JkETuc8cTN78PH5dv/SL65enleNg5HRRxhUA+jVQjFZJ
	 6MjgO8xkIJGog==
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
Subject: [PATCH 5/5] arm64: dts: amazon: alpine-v3: correct gic unit addresses
Date: Tue,  2 Apr 2024 22:07:44 +0200
Message-Id: <20240402200744.79349-5-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402200744.79349-1-krzk@kernel.org>
References: <20240402200744.79349-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct gic unit addresses to fix dtc W=1 warnings:

  alpine-v3.dtsi:321.38-331.5: Warning (simple_bus_reg): /soc/interrupt-controller@f0000000: simple-bus unit address format error, expected "f0800000"

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/amazon/alpine-v3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amazon/alpine-v3.dtsi b/arch/arm64/boot/dts/amazon/alpine-v3.dtsi
index 3099fdfa9520..8b6156b5af65 100644
--- a/arch/arm64/boot/dts/amazon/alpine-v3.dtsi
+++ b/arch/arm64/boot/dts/amazon/alpine-v3.dtsi
@@ -318,7 +318,7 @@ soc {
 		#size-cells = <2>;
 		ranges;
 
-		gic: interrupt-controller@f0000000 {
+		gic: interrupt-controller@f0800000 {
 			compatible = "arm,gic-v3";
 			#interrupt-cells = <3>;
 			interrupt-controller;
-- 
2.34.1


