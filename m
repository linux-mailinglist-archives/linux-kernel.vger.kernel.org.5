Return-Path: <linux-kernel+bounces-165368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1282C8B8BCC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1199A1C20FA3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169A712F36F;
	Wed,  1 May 2024 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=6tel.net header.i=@6tel.net header.b="MDM/JrOa"
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E991312F364;
	Wed,  1 May 2024 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714573419; cv=none; b=Y2Jll1ADAoxqgsep3OxLxYsalgVfBTT4T6o843YG1LFPASZfG+/TzJFJG/YHdt1YnR6jP8H8kgs+fDJ1VCw58msDFqadpuOi+myaYtSbgoNgDm6gEfyRdDNYExWo4d6MK8npBYRRpK7ZI/NA6eUOed1RWxGzirMC9RkBlYPONlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714573419; c=relaxed/simple;
	bh=DPIVmDM5x1Iy+tP/TykiU5om9vU1uHp7oJ8JgjYvybg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N/L6o2y/JoJCyu7PLTewFqSkExTRoT+8V5X4DHe8rlBC2KYlIkCdltetF988jQcPvV5kb+mvUB6cxnnqxBYf457QOWVjjZ1XHy9AqKY+zvZjovsTE6bFubIK7wg2pZrXEkA7IBKg63b5jjQ6T19OUnylfX5xEisqKMIgXWdzlTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=6tel.net; spf=pass smtp.mailfrom=6tel.net; dkim=pass (1024-bit key) header.d=6tel.net header.i=@6tel.net header.b=MDM/JrOa; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=6tel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6tel.net
Received: from mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:20a:0:640:b4fe:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id 9F156608FA;
	Wed,  1 May 2024 17:23:32 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id pMTR1wbCbKo0-AkbDrtjk;
	Wed, 01 May 2024 17:23:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=6tel.net; s=mail;
	t=1714573411; bh=JYZVhcK+PoryVRvDM0TzuUIYo20LFhMUXXZ/JuqXKJ4=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=MDM/JrOaV8jDNkSaMqmaW+vH8ySq1GYfsWJIzPE6MqYXEvoDz7S31zneJfUH/ez9I
	 evy2BKGJUWdiGAJTHYHhNVkJGoku5DODSiYRLg4xPf+xqS5GwiI+0gf0JHhj+PCLUm
	 NE+dZUO1HvhQGApNHftwgHE+NuP3XIdIrNCYyuGA=
Authentication-Results: mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net; dkim=pass header.i=@6tel.net
From: efectn@6tel.net
To: heiko@sntech.de,
	linux-rockchip@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	sebastian.reichel@collabora.com,
	Muhammed Efe Cetin <efectn@protonmail.com>
Subject: [PATCH 1/1] arm64: dts: rockchip: enable GPU on khadas-edge2
Date: Wed,  1 May 2024 17:22:41 +0300
Message-ID: <20240501142241.98554-1-efectn@6tel.net>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muhammed Efe Cetin <efectn@protonmail.com>

Enable the Mali GPU node on Khadas Edge 2.

Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
index ea085abb98ec..dbddfc3bb464 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
@@ -176,6 +176,11 @@ &combphy2_psu {
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&vdd_gpu_s0>;
+	status = "okay";
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0m2_xfer>;
-- 
2.44.0


