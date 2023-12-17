Return-Path: <linux-kernel+bounces-2546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B36F7815EB4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 12:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D76282966
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 11:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E9832187;
	Sun, 17 Dec 2023 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XsL+IJrg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E66E30FB9;
	Sun, 17 Dec 2023 11:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=7zV/f
	rDYtvFPjeU9CMSJb6opdJPp9s+18alUIaxSRyg=; b=XsL+IJrgrIHBJSzUGoAJu
	KNwU55ItKydoFPED/sMRQrDuBOnEbSkXoA3MX/1olSPmOuzFIbfHbPIjas/XOXp9
	SGiSos3okJPFzJQy2RAhQeZnrcl/xVg88nXkLONtq3uHKhuBTLxJuapG5hHiiCJj
	r0PsAr/3T1XgKTEmMUxqjI=
Received: from ProDesk.. (unknown [58.22.7.114])
	by zwqz-smtp-mta-g5-3 (Coremail) with SMTP id _____wD333AB0H5lTn2nFw--.50366S3;
	Sun, 17 Dec 2023 18:40:05 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH 2/2] arm: dts: rockchip: Add stdout-patch for rk3036 kylin
Date: Sun, 17 Dec 2023 18:39:59 +0800
Message-Id: <20231217103959.2380661-2-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231217103959.2380661-1-andyshrk@163.com>
References: <20231217103959.2380661-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD333AB0H5lTn2nFw--.50366S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFWDZF47tw1xuw4fZFyUGFg_yoW3Cwb_ta
	4fG3Z5KFs7GF15Xw1Dt3yfW343Cwnakay3Gr1vyr1UJF1qqw4kXF4kAas3tw1YyFW7KrZ3
	AFW3Xa1qqayakjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0dwIDUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBnAxJXlghmCkkNwABsd

From: Andy Yan <andy.yan@rock-chips.com>

Add stdout-patch to get a uart console when system boot.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 arch/arm/boot/dts/rockchip/rk3036-kylin.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3036-kylin.dts b/arch/arm/boot/dts/rockchip/rk3036-kylin.dts
index 67e1e04139e7..f12fa3831bbf 100644
--- a/arch/arm/boot/dts/rockchip/rk3036-kylin.dts
+++ b/arch/arm/boot/dts/rockchip/rk3036-kylin.dts
@@ -8,6 +8,10 @@ / {
 	model = "Rockchip RK3036 KylinBoard";
 	compatible = "rockchip,rk3036-kylin", "rockchip,rk3036";
 
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
 	memory@60000000 {
 		device_type = "memory";
 		reg = <0x60000000 0x20000000>;
-- 
2.34.1


