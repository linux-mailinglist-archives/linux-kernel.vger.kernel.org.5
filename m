Return-Path: <linux-kernel+bounces-48089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B50F845715
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3191B24F58
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C1E15DBD0;
	Thu,  1 Feb 2024 12:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mz0FM6Fx"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A8A4D9EC;
	Thu,  1 Feb 2024 12:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789542; cv=none; b=HZhJTH4EpBQdJcBFvQGZ7AlxB3JDKAgF0S0AdcLmpt0uhZoSXN6cu973Kj+hvzQYV0eVjmf6OTPRKJ3fhFjh0FcEP+GiqQFsr3CAWELpKr0VKpi8G4HCIrRE5i6olICoTkmdPHlaJv6nQL6W7Q+/0pWPq0Fay/4dtj36ujDekvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789542; c=relaxed/simple;
	bh=IcNFHFPT4z7p9hMCFdJ5xS2iAoBrnfgoWef+2li6rOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fcUTGP5w9U0jrpm0vI1n+F4gzk4Kwm/Avl82A3+5VFZVMcKJ97jvL0+weaLfmxgulT3vZlycTROrystSRAlALRzx8chpD7jxvE+vd85PsfF17T7dPQa7wNmWUvksyYnKJf2AzC2nd/hhz/5BI1UYlP2eJ169/hlod5GV2DPqPus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mz0FM6Fx; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=1SUtL
	q72uZ85U/njlejKUSRLnfESJ7Xgoity5J6Gns0=; b=mz0FM6FxJs/naHJbIoQce
	8l37kZYWwW8vvN5DNB2llmW8i1o21fuZEwXELoWOOgK+FDs8cJi43AzYcTKuIHtc
	eCTx5F/p30aoF+IFqTp+BsmQuoP4MVr5dOJVxqc+btrqIpCAIKUWWssvW2YnTPdG
	cACDlQkQnwJHj+fLD9S4wE=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wDX_35birtlKEO5AA--.30092S3;
	Thu, 01 Feb 2024 20:11:13 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andyshrk@163.com>,
	Dragan Simic <dsimic@manjaro.org>
Subject: [PATCH v2 2/4] arm64: dts: rockchip: aliase sdmmc as mmc1 for Cool Pi CM5 EVB
Date: Thu,  1 Feb 2024 20:11:04 +0800
Message-Id: <20240201121106.1471301-2-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201121106.1471301-1-andyshrk@163.com>
References: <20240201121106.1471301-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX_35birtlKEO5AA--.30092S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZryDuFyDGr4kXF1fWF1kuFg_yoWfAFX_ta
	42ga1kXa1rXry5Wwn8tay8G343C34qkw1fJ3yYvF4kAFy5X39rJayrKa92qr1jyF129rn3
	JrZ3ZF18JwnxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRMVby7UUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqAN3XmVOCDrNTgAAsY

Follow others rk3588 based boards, and u-boot only use mmc0/1
as mmc boot targets, so aliase sdmmc as mmc1.

Fixes: 791c154c3982 ("arm64: dts: rockchip: Add support for rk3588 based board Cool Pi CM5 EVB")
Signed-off-by: Andy Yan <andyshrk@163.com>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
---

(no changes since v1)

 arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi
index 0b02f4d6e003..cce1c8e83587 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi
@@ -16,8 +16,8 @@ / {
 
 	aliases {
 		mmc0 = &sdhci;
-		mmc1 = &sdio;
-		mmc2 = &sdmmc;
+		mmc1 = &sdmmc;
+		mmc2 = &sdio;
 		serial2 = &uart2;
 	};
 
-- 
2.34.1


