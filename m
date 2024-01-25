Return-Path: <linux-kernel+bounces-39293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 785B383CE40
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BA5D1F238CB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C459E13BE9E;
	Thu, 25 Jan 2024 21:12:35 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6275B210;
	Thu, 25 Jan 2024 21:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706217155; cv=none; b=JIIgiuD8Y70AZTZXitdf5JUutDD2ZXdA8RE+Bl0QNueiBFDrapvGJCrrLDlq7u8JYgKN2aFw/fJc4oN5J34O3jo/YhkEieW/gMKVjT5TvHuWsqomdyDprXpriNFwD2MEnRVG9beiMpsncsWrBW3I5CdRAH1TwoACnrITvIGFxOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706217155; c=relaxed/simple;
	bh=s9IYWH7Pmaaacc9m9635n0Z6EhqPV4SJcptmGOlUG8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XG7m2zLHHQY1JFtZauzzn+9Y1LpvlgtepC+echonKkkQGmysfU1YhgQSbXYw411/tEpwwYAiek/siNDt25aiudPCVSEBT6U1wmE+UUOSezu+Z4X85IXyqIjOjuAEVPRZQtIq6kWH8F+9s3J6upe9A2gV5371GsVvscsVhZTVTK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rT71I-0002EX-8a; Thu, 25 Jan 2024 22:12:20 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	efectn@6tel.net
Cc: Heiko Stuebner <heiko@sntech.de>,
	jonas@kwiboo.se,
	conor+dt@kernel.org,
	robh+dt@kernel.org,
	sebastian.reichel@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Muhammed Efe Cetin <efectn@protonmail.com>,
	krzysztof.kozlowski+dt@linaro.org,
	inindev@gmail.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Add Support for NanoPi R6S and R6C boards
Date: Thu, 25 Jan 2024 22:12:07 +0100
Message-Id: <170621707732.1872080.11289354696658306428.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1703934548.git.efectn@protonmail.com>
References: <cover.1703934548.git.efectn@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 30 Dec 2023 14:17:58 +0300, efectn@6tel.net wrote:
> From: Muhammed Efe Cetin <efectn@protonmail.com>
> 
> Hi, this series add support for RK3588S based NanoPi R6S and R6C boards.
> 
> Changes on v2:
> * Add commit message to dt-bindings patch.
> * Fix dtbs_check warnings.
> * Rename vcc_3v3_s0 -> avcc_3v3_s0 and create new fixed vcc_3v3_s0 regulator.
> * Rename vdd_ddr_pll_s0 -> avdd_ddr_pll_s0.
> * Rename vdd_0v85_s0 -> avdd_0v85_s0.
> * Fix rk806_dvs1_null and rk806_dvs2_null on pmic node.
> * Add system-power-controller property to pmic node.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: arm: rockchip: Add NanoPi R6 series boards
      commit: 2eaa5e73f51ff5abce18d58f6d0635880df1b8d0
[2/3] arm64: dts: rockchip: Add support for NanoPi R6S
      commit: f1b11f43b3e983b26d8010fc43ba6c2b979826f2
[3/3] arm64: dts: rockchip: Add support for NanoPi R6C
      commit: d5f1d7437451dbd86a91747793ecd7842e0ce88f

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

