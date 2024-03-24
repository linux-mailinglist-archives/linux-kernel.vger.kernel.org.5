Return-Path: <linux-kernel+bounces-113146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FDB8881D3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4A01F218DE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967CF16EC10;
	Sun, 24 Mar 2024 22:39:12 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A8516F27B;
	Sun, 24 Mar 2024 22:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319952; cv=none; b=JlvgOaEmILgv0bDupDKZDgmhfnbMp/J/YFmIWMYhj21PD5K/FyAT5oLw+mtIq7TsIlZjkRdWZSTjNYmQAAg9/M0jEHgRmxTa7Q2jW0BNbDt/pbXbRR16XRYjp18QYQ3n/xcgvWhN4a7bj9ZRHeqGp9Qtc9hwB9uPeyFtlHsWoEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319952; c=relaxed/simple;
	bh=I0mhYcl8koJcmMr0smHHtwWOzozd5ZColjHDquYJP78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tfwQib2Obx+DcqBO+qKGUWeDxT3nYkQD/fOxs/MKT4lB6WLVMQmkSUJu8rfaA40pEvYLujS0vas+grFmBiSlY0INAydoIWuu6+7iDLeSEBCuht03ckeJsZ92zC5lwsEC9b1Bc6USDQVndReHkSbammWIvrJVoGhBzvkfau11Qmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a9e.versanet.de ([83.135.90.158] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1roWUX-0007sn-QW; Sun, 24 Mar 2024 23:39:01 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Iskander Amara <iskander.amara@theobroma-systems.com>,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	conor+dt@kernel.org,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	dsimic@manjaro.org,
	alexander.stein@ew.tq-group.com,
	vahe.grigoryan@theobroma-systems.com
Cc: Heiko Stuebner <heiko@sntech.de>,
	quentin.schulz@theobroma-systems.com
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: enable internal pull-up for Q7_THRM# on RK3399 Puma
Date: Sun, 24 Mar 2024 23:38:56 +0100
Message-Id: <171131986743.918919.2940634887265030927.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240308085243.69903-1-iskander.amara@theobroma-systems.com>
References: <20240308085243.69903-1-iskander.amara@theobroma-systems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 8 Mar 2024 09:52:42 +0100, Iskander Amara wrote:
> Q7_THRM# pin is connected to a diode on the module which is used
> as a level shifter, and the pin have a pull-down enabled by
> default. We need to configure it to internal pull-up, other-
> wise whenever the pin is configured as INPUT and we try to
> control it externally the value will always remain zero.
> 
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rockchip: enable internal pull-up for Q7_THRM# on RK3399 Puma
      commit: 0ac417b8f124427c90ec8c2ef4f632b821d924cc
[2/2] arm64: dts: rockchip: fix alphabetical ordering RK3399 puma
      commit: f0abb4b2c7acf3c3e4130dc3f54cd90cf2ae62bc

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

