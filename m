Return-Path: <linux-kernel+bounces-20903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 397AD82872F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6D5286BE9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9BA38FA8;
	Tue,  9 Jan 2024 13:36:07 +0000 (UTC)
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7151C2206B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4T8X4r2xfJzMpnRY;
	Tue,  9 Jan 2024 13:35:56 +0000 (UTC)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4T8X4q4PnjzMpnPk;
	Tue,  9 Jan 2024 14:35:55 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Quentin Schulz <foss+kernel@0leil.net>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH 0/2] arm64: dts: rockchip: add SPI controller aliases to RK3399
Date: Tue,  9 Jan 2024 14:35:42 +0100
Message-ID: <20240109-rk3399-spi-aliases-v1-0-2009e44e734a@theobroma-systems.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: quoted-printable
X-Infomaniak-Routing: alpha

There are 6 SPI controllers on RK3399 and they are all numbered in the=0D
TRM, so let's add the appropriate aliases to the main DTSI so that any=0D
RK3399-based board doesn't need to define the aliases themselves to=0D
benefit from stable SPI indices in userspace.=0D
=0D
Helios64 is the only RK3399-based device that defined aliases for SPI=0D
controllers, but since they are now in RK3399 main DTSI, let's remove=0D
the duplication.=0D
=0D
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>=0D
---=0D
Quentin Schulz (2):=0D
      arm64: dts: rockchip: add spi controller aliases on rk3399=0D
      arm64: dts: rockchip: remove duplicate SPI aliases for helios64=0D
=0D
 arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts | 3 ---=0D
 arch/arm64/boot/dts/rockchip/rk3399.dtsi               | 6 ++++++=0D
 2 files changed, 6 insertions(+), 3 deletions(-)=0D
---=0D
base-commit: 9f8413c4a66f2fb776d3dc3c9ed20bf435eb305e=0D
change-id: 20240109-rk3399-spi-aliases-a2ce468a04a3=0D
=0D
Best regards,=0D
-- =0D
Quentin Schulz <quentin.schulz@theobroma-systems.com>=0D
=0D

