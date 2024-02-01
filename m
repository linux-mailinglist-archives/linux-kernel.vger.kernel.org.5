Return-Path: <linux-kernel+bounces-48090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB21845717
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 567A51C25013
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376D615DBB0;
	Thu,  1 Feb 2024 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GI+6UBnh"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F308915D5C1;
	Thu,  1 Feb 2024 12:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789544; cv=none; b=pMe1osHfHQcC3ZVyeWUZEnEULqpqZaALotubzW4zSozZRhPOjBUrb3fmEVOdxw0TS2+1GglX8Y2tOu1WOn6+GYiCPO0ICJJCSYXv+al0AHAgITUpYvcwX3biF3OC5hBXkNsbSe1d6Iswxgpd/w4rBnAPON0S/ICxOne24B87WRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789544; c=relaxed/simple;
	bh=okPepgnUSuWPFcxkxKchMFOdJW58v3hgIwyezLk2Emg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=flpxsGu3CZduZck05yLSaC6gIj78MqpSXHO2TkTUR6hHKxxHHvmKB71BBHaE/WUr3ckJkpfDPny//oJzlI1HEWWR078C1YkrVFOzHPkysN/3uPXUNdl4srRjXZeR/nWQjQo6VBZtX7AAQzw2OZc/QhBQXMRyYnGeIfBF9JP+qEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GI+6UBnh; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=KvYmw
	ZNEjvb9A83FVmZYX/sRC9FmnLhMGuA9Gda7q+0=; b=GI+6UBnhwGYod5utkzp3j
	DEGfcPT4QO8ODjHm6fzt30kdYkPEAEQ9Az9+9c9WSaJsB+4ahzU9zDig1oxzheKk
	KydstvaX2FVA3k3WGWywQUiSfoHShf5QHrNo8AwJgvPvUrd+oJyOCRQpg62jn4Fm
	MveMgKc9/wrKkJ3aMQa3IA=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wDX_35birtlKEO5AA--.30092S2;
	Thu, 01 Feb 2024 20:11:12 +0800 (CST)
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
Subject: [PATCH v2 1/4] arm64: dts: rockchip: aliase sdmmc as mmc1 for Cool Pi 4B
Date: Thu,  1 Feb 2024 20:11:03 +0800
Message-Id: <20240201121106.1471301-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX_35birtlKEO5AA--.30092S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZryDuFyDJw1kuFyDZFyxZrb_yoWfWFX_ta
	47Wr1kXa93Jry3Z3s8tay5Gay7Gayq9w4fK3yYva95JF1Yqan7Jay5Ja9293WUAF4jkrs3
	JrZxZF1xGw1a9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR3n5GPUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEAZ3XmVOCDl11gABsH

Follow others rk3588 based boards, and u-boot only use mmc0/1
as mmc boot targets, so aliase sdmmc as mmc1.

Fixes: 3f5d336d64d6 ("arm64: dts: rockchip: Add support for rk3588s based board Cool Pi 4B")
Signed-off-by: Andy Yan <andyshrk@163.com>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>

---

(no changes since v1)

 arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
index 3fae40b9ae1b..3b9d21a6f8bf 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
@@ -20,8 +20,8 @@ / {
 
 	aliases {
 		mmc0 = &sdhci;
-		mmc1 = &sdio;
-		mmc2 = &sdmmc;
+		mmc1 = &sdmmc;
+		mmc2 = &sdio;
 	};
 
 	analog-sound {
-- 
2.34.1


