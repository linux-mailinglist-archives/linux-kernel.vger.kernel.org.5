Return-Path: <linux-kernel+bounces-1656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DA98151A5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4B11C238D9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F0647F7E;
	Fri, 15 Dec 2023 21:10:41 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E14330132;
	Fri, 15 Dec 2023 21:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b61.versanet.de ([83.135.91.97] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rEFS1-0005kk-Rb; Fri, 15 Dec 2023 22:10:29 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Andy Yan <andyshrk@163.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org,
	sre@kernel.org
Subject: Re: [PATCH v4 0/5] Add 2 rk3588 based boards from Cool Pi
Date: Fri, 15 Dec 2023 22:10:25 +0100
Message-Id: <170267443962.1167098.11212690692568621616.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231212124202.1897238-1-andyshrk@163.com>
References: <20231212124202.1897238-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 12 Dec 2023 20:42:02 +0800, Andy Yan wrote:
> This series add support for rk3588s based SBC Cool Pi 4B
> and rk3588 based board Cool Pi CM5 EVB
> 
> Changes in v4:
> - split pi-cm5 as a dtsi
> 
> Changes in v3:
> - drop ununnecessary property status = "okay" for rtc
> - reorder some nodes alphabetical
> - remove disabled node
> - Add compatible "coolpi,pi-cm5" for CM5
> - drop ununnecessary property status = "okay" for backlight
> - reorder some nodes alphabetical
> - drop ununnecessary blank line
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: vendor-prefixes: Add Cool Pi
      commit: 40488a16e455ae6000ae1525bdc7e49fcf71d1a4
[2/5] dt-bindings: arm: rockchip: Add Cool Pi 4B
      commit: 473aa86338489daa332933f158f1bb03dcc2c8ee
[3/5] arm64: dts: rockchip: Add support for rk3588s based board Cool Pi 4B
      commit: 2d55c73a407a0e5cec0e97273dc1bf7b4d28cc02
[4/5] dt-bindings: arm: rockchip: Add Cool Pi CM5
      commit: 3b79d71c73c35001205556f9360c3afa4ef6d02d
[5/5] arm64: dts: rockchip: Add support for rk3588 based board Cool Pi CM5 EVB
      commit: aba89738bf7d83e47e5b6e5a4c9f452464746bbb

I've updated both board devicetrees somewhat.
Both in terms of sorting of properties and also to make the dtbs-check happy
and the board conformant to the yaml binding.


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

