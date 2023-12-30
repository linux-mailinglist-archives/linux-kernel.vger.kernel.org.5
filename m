Return-Path: <linux-kernel+bounces-13394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A448D82048B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 12:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345AA1F218DC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 11:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CBD749C;
	Sat, 30 Dec 2023 11:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=6tel.net header.i=@6tel.net header.b="m+rfidms"
X-Original-To: linux-kernel@vger.kernel.org
Received: from forward500c.mail.yandex.net (forward500c.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E626AA8;
	Sat, 30 Dec 2023 11:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=6tel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6tel.net
Received: from mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:12ac:0:640:b64e:0])
	by forward500c.mail.yandex.net (Yandex) with ESMTP id CC5A6609F0;
	Sat, 30 Dec 2023 14:18:21 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 3IVUxO8g5Ko0-JextyKru;
	Sat, 30 Dec 2023 14:18:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=6tel.net; s=mail;
	t=1703935100; bh=NOfOR3WmGBG8VnmZCdu7/HLUZv7HTJnYt7hUccOv6xE=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=m+rfidmsZ/CdVddtHvA0jnJXUCLjwn9mQAKFeYvf8C1aCHZHgsUOA6ZACwxskwEmf
	 0G+UIkaOTaZ6Y2/qsGMvmIoFaqcfFp7OwprozFZ98nMD43FikXC0c+MLL4WLvTcDFB
	 f4CJlj58u53DO42igxCvqW76SpxmSOzw10PmnLpU=
Authentication-Results: mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net; dkim=pass header.i=@6tel.net
From: efectn@6tel.net
To: linux-rockchip@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	sebastian.reichel@collabora.com,
	jonas@kwiboo.se,
	inindev@gmail.com,
	Muhammed Efe Cetin <efectn@protonmail.com>
Subject: [PATCH v2 1/3] dt-bindings: arm: rockchip: Add NanoPi R6 series boards
Date: Sat, 30 Dec 2023 14:17:59 +0300
Message-ID: <30c1c7eac02cd32b76edb77572523f6ad8de89fb.1703934548.git.efectn@protonmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1703934548.git.efectn@protonmail.com>
References: <cover.1703934548.git.efectn@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muhammed Efe Cetin <efectn@protonmail.com>

Add support for NanoPi R6 series boards that based on RK3588S.

NanoPi R6S basically has:
- USB3
- USB2
- eMMC
- 2x 2.5GBe & 1x 1GBe ethernet
- HDMI
- SD card support

Unlike R6S variant, NanoPi R6C has PCIe M.2 M-key instead of 1x 2.5GBe.

Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index ee92f0535..07c4eb828 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -225,6 +225,13 @@ properties:
               - friendlyarm,nanopi-r5s
           - const: rockchip,rk3568
 
+      - description: FriendlyElec NanoPi R6 series boards
+        items:
+          - enum:
+              - friendlyarm,nanopi-r6c
+              - friendlyarm,nanopi-r6s
+          - const: rockchip,rk3588s
+
       - description: FriendlyElec NanoPC T6
         items:
           - const: friendlyarm,nanopc-t6
-- 
2.43.0


