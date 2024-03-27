Return-Path: <linux-kernel+bounces-120665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D29188DB3D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB79E2978CD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4334CE0F;
	Wed, 27 Mar 2024 10:28:45 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819AB29D03;
	Wed, 27 Mar 2024 10:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711535325; cv=none; b=ZWc4PSOOtuLfJSB2y/hFXQRHYrBk3Xs/hYL9jdpnvbKIT5cu8lc74O0UeCr2l791lg9JDHlzJjv4ra2ngwW6YYc8W8H/UiDzytG684Cya1tJdXItRxdM/ilV2JHPugFvEokUtCdB4eQbbJiDv7FWXgaqgG+i6Ptg8NGYsHovUtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711535325; c=relaxed/simple;
	bh=49buyaZ7tkx3sFaFT0a0idxYxcwFS3xZAjKv55+Jpf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BOn40BNLUrdpBuNvAv9C02tMBpz/dnTRe8LDztXe5ZujUUoS2hEgxqJ1p/WRteMmbCZ0y3+4+7+Y3qtHmJFMBoMqqt685TcbLRoMfKBq9U477qiblXXxKRUMiVceKxPNKl7cHROotPZlcTKGgeGX7Dq6YtSLOSk+EX0MF1kbBVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875aaf.versanet.de ([83.135.90.175] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rpQWC-0005wd-RD; Wed, 27 Mar 2024 11:28:28 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	kernel@collabora.com,
	devicetree@vger.kernel.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 0/4] RK3588 GPU support
Date: Wed, 27 Mar 2024 11:28:26 +0100
Message-Id: <171153529297.1177019.4688944301157400463.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326165232.73585-1-sebastian.reichel@collabora.com>
References: <20240326165232.73585-1-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 26 Mar 2024 17:52:04 +0100, Sebastian Reichel wrote:
> Panthor has landed in linux-next including the DT bindings, so it is
> time to add the necessary DT changes to support the GPU on RK3588.
> This adds support at SoC level and support for the EVB1 as well as
> the Rock 5B, which covers both variants found in RK3588 boards:
> 
> 1. Having dedicated regulators for GPU core and GPU memory. This
>    is handled by coupling both regulators.
> 2. Having a shared regulator for GPU core and GPU memory.
> 
> [...]

Applied, thanks!

[1/4] arm64: defconfig: support Mali CSF-based GPUs
      commit: e6968faa33ce754bbe36dd6d9fe6951ec10616b1
[2/4] arm64: dts: rockchip: rk3588: Add GPU nodes
      commit: 6fca4edb93d335f29f81e484936f38a5eed6a9b1
[3/4] arm64: dts: rockchip: rk3588-rock5b: Enable GPU
      commit: 038347286941148b6fd0cc2c40afcd540315aa6f
[4/4] arm64: dts: rockchip: rk3588-evb1: Enable GPU
      commit: 75a287219a782951e671026ed4fbe611e4629c83

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

