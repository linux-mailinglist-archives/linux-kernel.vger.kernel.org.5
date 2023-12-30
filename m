Return-Path: <linux-kernel+bounces-13393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B0E820488
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 12:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F061F21837
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 11:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9AE749C;
	Sat, 30 Dec 2023 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=6tel.net header.i=@6tel.net header.b="uh7D3nPX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from forward200b.mail.yandex.net (forward200b.mail.yandex.net [178.154.239.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD43863A5;
	Sat, 30 Dec 2023 11:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=6tel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6tel.net
Received: from forward101c.mail.yandex.net (forward101c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d101])
	by forward200b.mail.yandex.net (Yandex) with ESMTP id 1019B63FAD;
	Sat, 30 Dec 2023 14:18:25 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:12ac:0:640:b64e:0])
	by forward101c.mail.yandex.net (Yandex) with ESMTP id 5534360911;
	Sat, 30 Dec 2023 14:18:16 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 3IVUxO8g5Ko0-nZJ5XVfj;
	Sat, 30 Dec 2023 14:18:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=6tel.net; s=mail;
	t=1703935095; bh=BkLXxvkZcvlWzWwt5EukMwaJ6+KICat66IUTEiv4y1Y=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=uh7D3nPXvD5cJR2HJ/2mZATHQyI3x116PPhqevg22Jc1qmJlFoIWmbPW5gUtaUpYD
	 4maKQJDgkKnFBg0cdd/s1ONMABLoX7eCG+n29SFxGGK9+/WAb7rRt56C5Lne7PNBtJ
	 HBXgDAZDl7TQk/XPoZqeT7hxd+W2q+O4GkVDe0Ac=
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
Subject: [PATCH v2 0/3] Add Support for NanoPi R6S and R6C boards
Date: Sat, 30 Dec 2023 14:17:58 +0300
Message-ID: <cover.1703934548.git.efectn@protonmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muhammed Efe Cetin <efectn@protonmail.com>

Hi, this series add support for RK3588S based NanoPi R6S and R6C boards.

Changes on v2:
* Add commit message to dt-bindings patch.
* Fix dtbs_check warnings.
* Rename vcc_3v3_s0 -> avcc_3v3_s0 and create new fixed vcc_3v3_s0 regulator.
* Rename vdd_ddr_pll_s0 -> avdd_ddr_pll_s0.
* Rename vdd_0v85_s0 -> avdd_0v85_s0.
* Fix rk806_dvs1_null and rk806_dvs2_null on pmic node.
* Add system-power-controller property to pmic node.

Muhammed Efe Cetin (3):
  dt-bindings: arm: rockchip: Add NanoPi R6 series boards
  arm64: dts: rockchip: Add support for NanoPi R6S
  arm64: dts: rockchip: Add support for NanoPi R6C

 .../devicetree/bindings/arm/rockchip.yaml     |   7 +
 arch/arm64/boot/dts/rockchip/Makefile         |   2 +
 .../boot/dts/rockchip/rk3588s-nanopi-r6c.dts  |  14 +
 .../boot/dts/rockchip/rk3588s-nanopi-r6s.dts  | 764 ++++++++++++++++++
 4 files changed, 787 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts

-- 
2.43.0


