Return-Path: <linux-kernel+bounces-41129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F9B83EC48
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 10:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77111C21D64
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 09:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AD8200DB;
	Sat, 27 Jan 2024 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Sc4R8pCU"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947F31EA72;
	Sat, 27 Jan 2024 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706347289; cv=none; b=ugdJRTbMIeIlm7r+iEIDVr4L2jTXNicEV+wo9wQTKYmP9T6T6K+BS7EMe7Et7f1KpQnIzd7mTOr2fxUOzTVuzSbHhEOYVY4bLBFj+Bkais+TQhRFr5VqNLLlUyc0lg7c10NGXCOuU0U5YpPABJQRupf9Zqh5rYmSbfcnRPEXVY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706347289; c=relaxed/simple;
	bh=welrbF5b84YUkjaFUG7wG+43+a7QFVGtWYu/cqswM3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NNgmeRS/bud4PcluKIZbQewgTAd78LcGom9/wZt2c6sVDvYzsAKfKxu2ip9sd7wOpCNoCjXI2Ei21tM8wY9haIxJOHnzzXKDp8t+el6AX9pc3nZ8MOjt6OkyB9JElWO5qgJdeqG79AX+u6MOVDVy0xFVyYTxEcvpLjBFIVHUiN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Sc4R8pCU; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qXKs7
	77YlJXMt8Y4vLlzfp04iXltM/VO9c7EPLhu6nw=; b=Sc4R8pCUrKIpDXgH3nint
	QC5KH+JKw6vI94XXIkW//286CO9ZTOUkcFsLwmlBDvcVk5bxUJleGtsoX8I/aYnv
	JSGpg+I9AbMnltWh0OLFam33344uQSgctM8Ccex0Nwi0vqkNuENx0352saCzvFnV
	B2gcMad4UevhPPCW9OaDe4=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mta-g0-4 (Coremail) with SMTP id _____wD3rzHkyrRl5GopBA--.2976S3;
	Sat, 27 Jan 2024 17:20:40 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andyshrk@163.com>
Subject: [PATCH 2/4] arm64: dts: rockchip: aliase sdmmc as mmc1 for Cool Pi CM5 EVB
Date: Sat, 27 Jan 2024 17:20:32 +0800
Message-Id: <20240127092034.887085-2-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240127092034.887085-1-andyshrk@163.com>
References: <20240127092034.887085-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3rzHkyrRl5GopBA--.2976S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZryDuFyDGr4kXF1fWF1kuFg_yoW3tFg_ta
	42ga1kJayrWr98W34Dtay8G343C34DCw1fJayYvF4kAFW3X39rJayrKa9FvF1jyF429r1f
	JrZ3ZF18Jw15CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRN-BM7UUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqApyXmVOB+QgpgAAsA

Follow others rk3588 based boards, and u-boot only use mmc0/1
as mmc boot targets, so aliase sdmmc as mmc1.

Fixes: 791c154c3982 ("arm64: dts: rockchip: Add support for rk3588 based board Cool Pi CM5 EVB")
Signed-off-by: Andy Yan <andyshrk@163.com>
---

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


