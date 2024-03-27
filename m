Return-Path: <linux-kernel+bounces-121899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE42888EF25
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EA20B21865
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7303515250B;
	Wed, 27 Mar 2024 19:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="cfBOblga"
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6EF150995;
	Wed, 27 Mar 2024 19:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711567621; cv=none; b=LNVr1qeYKApI31CAJ6xgqPy6IUobxpqPs1jm+iRxiZb4XerKVZvy7zchlZalPpBzXdHZ4ipktbOFkIRD1gAVBSZNXvzcWd6Rn5O4vDkd2XKH4dp7Knp8gEva1RQI2+huqTloEy/qhU/oKnku8sDV/skw5pq1Uv5evmbQHeqlDP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711567621; c=relaxed/simple;
	bh=BdGRs6qmKCqEobusizZyGL8HkF9y+wpMy7VkdRUu0rk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ouya1eX6EWgVbLRcFbg8LYmvUlxfXmecZ3ILE4F+x5Ot93V2YrK8qscdADTJ0IPmzIyR1Xc+e1r5HmmYu0TD/wBLIFI31Z3rLP3pOKw0cXfOfhdBY598Vwt6DyA2+Q/1nPY2U0UIpz/V9OyTjSFHjDXQtXyg65ICR4/qkVBh/4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=cfBOblga; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References;
	bh=ewabUOMzJnwQzsx6uM+32Ptxk3uRoq9dz5K5trAa2Tw=; b=cfBOblgaCQsVMKWXs7JvuzXIpt
	5KYTQCi9mGlYqAPuWWxGrm24kSe+DDWVQ30C72djLQTnWYRhzIK/9a9vk389Uas8F84Unksc8ZIdw
	E2I/OtC7o5MI/LqfegdkmnqysdsCiuQCctTu1SOGtIhrp4h0mBsPMO4PmHouM13JgazZ0evyYPJXj
	nM+ZyhQbo7gTQ6dPiZ9A6YKwLLCTlzZbV0XMNjtsxtS4uS+Zb/O0661CHcPLBkPboNhIeC7p0sFCc
	I++e6nX1rxgaogmbTKYecoFuISFtwPwsg93zg/trZm+HMoLs/MXQvaYj4t3pDKjouPY/bqMqr/Zi7
	tQCC02PA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1rpYvD-000IpD-Qg; Wed, 27 Mar 2024 20:26:51 +0100
Received: from [185.209.196.215] (helo=homedev.localdomain)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1rpYvD-000Iyc-5O; Wed, 27 Mar 2024 20:26:51 +0100
From: Folker Schwesinger <dev@folker-schwesinger.de>
To: Vinod Koul <vkoul@kernel.org>,
	Yogesh Hegde <yogi.kernel@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Ruehl <chris.ruehl@gtsys.com.hk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Folker Schwesinger <dev@folker-schwesinger.de>,
	Dragan Simic <dsimic@manjaro.org>,
	Christopher Obbard <chris.obbard@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 0/2] Enable internal strobe pulldown on Radxa ROCK 4 SBCs
Date: Wed, 27 Mar 2024 20:26:36 +0100
Message-ID: <20240327192641.14220-1-dev@folker-schwesinger.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: dev@folker-schwesinger.de
X-Virus-Scanned: Clear (ClamAV 0.103.10/27227/Wed Mar 27 09:33:27 2024)

Various RK3399 boards, including the ROCK Pi 4 series showed instabilities
with some eMMC modules when operating in HS400 mode [1]. Later, a missing
pull-down resistor on the eMMC strobe line was identified as the root
cause of these instabilities [2].

This series enables the internal pull-down on the eMMC PHY strobe line
for all ROCK 4 series boards as they all lack an external strobe
pull-down resistor.

Furthermore, HS400 mode is re-enabled for these boards. Previously, to
workaround the instabilities until the issue was investigated further,
HS400 mode was replaced with HS200 mode [1].

[1]: https://lore.kernel.org/all/20230705144255.115299-1-chris.obbard@collabora.com/
[2]: https://lore.kernel.org/all/20220822074139.3810-1-jensenhuang@friendlyarm.com/


Folker Schwesinger (2):
  arm64: dts: rockchip: Add enable-strobe-pulldown to emmc phy on ROCK
    Pi 4
  arm64: dts: rockchip: Add enable-strobe-pulldown to emmc phy on ROCK
    4C+

 arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts | 4 +++-
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi   | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)


base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.44.0


