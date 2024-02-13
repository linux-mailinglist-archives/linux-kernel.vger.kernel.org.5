Return-Path: <linux-kernel+bounces-63844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ED3853564
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A2E1C22E3C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248EB5F85B;
	Tue, 13 Feb 2024 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="tGeW53s8"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807E05F575;
	Tue, 13 Feb 2024 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839797; cv=none; b=a2DHRJopFfduj/exlErDUYhxGKf/ulGygMFf9ujcEGtKRg8VXG2PJTuQHaVmv5wsxXIV1e21i/KuCM2DTFVZzPksSwLegKIzTEQhniSPEAWQ2qT1tp/7RzEAgWa6toy9f1OuJtL7C0VQgkNWSfh4MmdE+Yo6qtxEkrA1R7uwtHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839797; c=relaxed/simple;
	bh=aGW69Re24Ac9DrkEU8cjI1zLJwxtRXil2UUBGGZdN60=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G83BOYNxN/k/kkR55PyxjiAqDHeCxPTQixTwAQiJItJGOAa+1qBpQ32IsCfJv4PkN6Ys2NkveDig+ryty/azb8YKaLgGX8B+AUyZoHXO3QCWOLoVJh+PCITXiVUkv9/pvDMAG09pAw8/L1BxwxtPLcSKUdz63QsGstDkVKXRM+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=tGeW53s8; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 78721212AD;
	Tue, 13 Feb 2024 16:56:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1707839789;
	bh=55Mx92Mb4FtSWcKrsXEpSDBFfNUrq19PhogvHS4N8cA=; h=From:To:Subject;
	b=tGeW53s8bp67QTKN/BG89r80BpPoFc2goaiHNs0EW6LPycV0sJigyHKjUSFsoHfXW
	 PMp+YSAsSCdVGO0VTXCs8t2wRHLB5P+mFYjL0LTp/fEujxOOrkuClwIY8Ypg8IuB+q
	 e1+fJpLVzeApIjY8xcR8hIMx/MslEDO8UX1iEhOiY6EKoUVhA3OAqxc49Li3hagSkb
	 w6a1n04uLnBt8bNZUJGxk1sN5DmORLPy2UMa3dDc4CC53K8LR2uWbUaszmigKmwkIR
	 1z2rqwFqyFkZxLGNAst8JDxBH5SJMb5orGXp9macBGzFUq7wj4VlcWWs2NoVhcCsjh
	 J0kWoJGRF3fjQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: dts: ti: verdin-am62: Set VDD CORE minimum voltage to 0.75V
Date: Tue, 13 Feb 2024 16:56:22 +0100
Message-Id: <20240213155622.18309-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Set VDD_CORE minimum voltage to 0.75V, TI AM62 can run at either 0.75V
or 0.85V depending on the actual speed grade and on the maximum
configured speed (1.4GHz frequency requires 0.85V).

The actual value is programmed into the PMIC EEPROM during manufacturing
(according to the SOC speed grade) and this ensure that both the voltage
values are valid and therefore the OS will not overwrite the value
programmed into the PMIC.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
index 6a06724b6d16..4129566172a2 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
@@ -1118,7 +1118,7 @@ reg_vdd_core: buck1 {
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-max-microvolt = <850000>;
-				regulator-min-microvolt = <850000>;
+				regulator-min-microvolt = <750000>;
 				regulator-name = "+VDD_CORE (PMIC BUCK1)";
 			};
 
-- 
2.39.2


