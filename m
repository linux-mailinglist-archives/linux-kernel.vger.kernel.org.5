Return-Path: <linux-kernel+bounces-84178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6290686A367
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44F46B2A1B2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB90857326;
	Tue, 27 Feb 2024 23:13:34 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E2856766;
	Tue, 27 Feb 2024 23:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075614; cv=none; b=k5xCrjSNgHroRsryHbT28QU2ZnHusjxSpkWsD6Dwhug25RWu3D/6f5dsb/eTODedc+WlshkvD0BaA+Gjg2rLbgw1YyKiCA+zU2tnMcfJYdxCmtjccVYs5GGBNiLJs7CEiJfL8AQ2lKkCY02/tPPJOTxG+m1r+noJdlCirw7FCvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075614; c=relaxed/simple;
	bh=B4DKrRNSUjPldZnmQy7qW35XpULDoHvXd5QTDp2J6fw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IVz2CCfcC9HNW2Tt6OeMtwRl7hJXLROtjMRm6/oG0bGpJTfExMe6HymgG1lvbFB0jX4C7HSwlhEPC1MGX1o/EUN6bWL/2FgMGRH5F7X1Cr14/VkAl6OdfNy5RNuVtVWA6H/C4gUgQ2pGYLsHU4T+KMeLehT0icxv1tUU+tKNoBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6c.versanet.de ([83.135.91.108] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rf6dY-0002LS-HQ; Wed, 28 Feb 2024 00:13:24 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	Elon Zhang <zhangzj@rock-chips.com>,
	conor+dt@kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	weizhao.ouyang@arm.com,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] arm64: dts: rockchip: Add devicetree support for TB-RK3588X board
Date: Wed, 28 Feb 2024 00:13:21 +0100
Message-Id: <170907558763.800427.16777226137397657885.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240221022902.751528-1-zhangzj@rock-chips.com>
References: <20240221022902.751528-1-zhangzj@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 21 Feb 2024 10:29:01 +0800, Elon Zhang wrote:
> Add board file for Rockchip Toybrick TB-RK3588X board.
> 
> Specification:
> 	Rockchip Rk3588 SoC
> 	4x ARM Cortex-A76, 4x ARM Cortex-A55
> 	8/16GB Memory LPDDR4x
> 	Mali G610MC4 GPU
> 	2× MIPI-CSI0 Connector
> 	1x 2Lanes PCIe3.0 Connector
> 	1x SATA3.0 Connector
> 	32GB eMMC Module
> 	2x USB 2.0, 2x USB 3.0
> 	1x HDMI Output, 1x HDMI Input
> 	2x Ethernet Port
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rockchip: Add devicetree support for TB-RK3588X board
      commit: 8ffe365f8dc798a08bf21d5050f7b21bd6a855a4
[2/2] dt-bindings: arm: rockchip: Add Toybrick TB-RK3588X
      commit: 7140387ff49d0f44648d26f975c6fead1c5055b0

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

