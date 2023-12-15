Return-Path: <linux-kernel+bounces-1048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 929E48149BF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 339E0B21D61
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8D52EAF9;
	Fri, 15 Dec 2023 13:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=6tel.net header.i=@6tel.net header.b="OQ1VRyDs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [178.154.239.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71712C6A3;
	Fri, 15 Dec 2023 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=6tel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6tel.net
Received: from mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:96a1:0:640:9109:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTP id 81A33608F7;
	Fri, 15 Dec 2023 16:55:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id VtlX2gDOoGk0-AaWlqoYh;
	Fri, 15 Dec 2023 16:55:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=6tel.net; s=mail;
	t=1702648553; bh=ctP5Vc/yFooEeZGOcVWipv3Odg8pHuYf8VwLv1qbbZE=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=OQ1VRyDsx/HCJzpSdi+Osw43AspqBfXaOGFGnpEgTH1WSJ0ixADhzRHfxoZETps/t
	 v9egXvGUCG/xB16HMBRfD1+LBUCF+56YDOyI85TavqA/eBtW4PhcPRkkK3j50gZza0
	 p6htQ//Lk2qpZSUZyfeGbRzdqd0sKbdjUQnr/7+U=
Authentication-Results: mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net; dkim=pass header.i=@6tel.net
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
	Muhammed Efe Cetin <efectn@protonmail.com>
Subject: [PATCH 0/3] Add Support for NanoPi R6S and R6C boards
Date: Fri, 15 Dec 2023 16:55:20 +0300
Message-ID: <cover.1702647349.git.efectn@protonmail.com>
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

Muhammed Efe Cetin (3):
  dt-bindings: arm: rockchip: Add NanoPi R6 series boards
  arm64: dts: rockchip: Add support for NanoPi R6S
  arm64: dts: rockchip: Add support for NanoPi R6C

 .../devicetree/bindings/arm/rockchip.yaml     |   7 +
 arch/arm64/boot/dts/rockchip/Makefile         |   2 +
 .../boot/dts/rockchip/rk3588s-nanopi-r6c.dts  |  14 +
 .../boot/dts/rockchip/rk3588s-nanopi-r6s.dts  | 755 ++++++++++++++++++
 4 files changed, 778 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts

-- 
2.43.0


