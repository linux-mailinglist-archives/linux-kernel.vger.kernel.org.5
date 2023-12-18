Return-Path: <linux-kernel+bounces-3391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4672F816BB3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9C51C22D5B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239A71A59B;
	Mon, 18 Dec 2023 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XPqW6oTY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB6419447;
	Mon, 18 Dec 2023 10:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=gwe4z
	CDjtQz1QKeidqQfolK+ZN+4nQnHqxy78omjQGE=; b=XPqW6oTYieu8ROm5Akl3l
	jMmVSzu99c8+QMhO68cwiIQmDLML2nrU38ZjLiJNFalFhCN1/oFL6Xsm+galhFIZ
	BmFvUDtAvVmMZB/Hz3K8RZjbXpKHKNXmDju3R4uZbUFJHd6GqjrSCMG6b1mLItm0
	Twq1MXzgRS3/zyoTvJs0bs=
Received: from ProDesk.. (unknown [58.22.7.114])
	by zwqz-smtp-mta-g2-2 (Coremail) with SMTP id _____wDn72EdJYBln1v+Bg--.7214S5;
	Mon, 18 Dec 2023 18:55:31 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	zhengxing@rock-chips.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v2 3/3] ARM: dts: rockchip: Remove rockchip,default-sample-phase from rk3036.dtsi
Date: Mon, 18 Dec 2023 18:55:23 +0800
Message-Id: <20231218105523.2478315-4-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218105523.2478315-1-andyshrk@163.com>
References: <20231218105523.2478315-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn72EdJYBln1v+Bg--.7214S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw15tr48GFy8uF4kWF1fXrb_yoW8Cryxpw
	13ZrZrGw4xKr1fZasrtwn5Ca9Yyrn8Ga1F9r4xJw1Iqr12qr95GF1a9rZ3XFyUXw42vayY
	9F43Xry2ya9rZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jdZ23UUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEgVKXmVOBAp8owABs4

From: Andy Yan <andy.yan@rock-chips.com>

This should be a per board property, should not be put in
a soc core dtsi.

And when this property convert from default-sample-phase
in linux-5.7 by commit 8a385eb57296 ("ARM: dts: rockchip: fix
rockchip,default-sample-phase property names"), the emmc
on rk3036 kylin board get a initialising error:

[    4.512797] Freeing unused kernel memory: 8192K
[    4.519500] mmc_host mmc1: Bus speed (slot 0) = 37125000Hz (slot req 37500000Hz, actual 37125000HZ div = 0)
[    4.530971] mmc1: error -84 whilst initialising MMC card
[    4.537277] Run /init as init process
[    4.550932] mmc_host mmc1: Bus speed (slot 0) = 300000Hz (slot req 300000Hz, actual 300000HZ div = 0)
[    4.664717] mmc_host mmc1: Bus speed (slot 0) = 37125000Hz (slot req 37500000Hz, actual 37125000HZ div = 0)
[    4.676156] mmc1: error -84 whilst initialising MMC card

I think the reason why the emmc on rk3036 kylin board was able
to work before linux-5.7 was that the illegal property was not
correctly identified by the rockchip dw_mmc driver.

Fixes: faea098e1808 ("ARM: dts: rockchip: add core rk3036 dtsi")
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

(no changes since v1)

 arch/arm/boot/dts/rockchip/rk3036.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/rockchip/rk3036.dtsi b/arch/arm/boot/dts/rockchip/rk3036.dtsi
index 5344803442a1..466952bf9db4 100644
--- a/arch/arm/boot/dts/rockchip/rk3036.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3036.dtsi
@@ -287,7 +287,6 @@ emmc: mmc@1021c000 {
 		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
 			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
-		rockchip,default-sample-phase = <158>;
 		disable-wp;
 		dmas = <&pdma 12>;
 		dma-names = "rx-tx";
-- 
2.34.1


