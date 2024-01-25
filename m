Return-Path: <linux-kernel+bounces-39217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E12D983CCFC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DAA2B23B12
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878B2135A6F;
	Thu, 25 Jan 2024 19:57:16 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CC0131736;
	Thu, 25 Jan 2024 19:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212636; cv=none; b=sLFOZkzY8TNnKNR6ZyVQVGmaHlLkmlnTdpKk+ol5ruq3QtKqP7aLjTEP0GOOPdP0IrNGEI33keti6LVcFFxXIQUG1GipyIFIHIGXlJFfMrEUHdzmxUy2UGlGdJGd2laVX0ATIxDZ+fvnASnrMrjnp0ix7IQSSDPiZramBLk9Qkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212636; c=relaxed/simple;
	bh=cZtWmGlY42vWGJe6HTabZWkMHoxV2tNOxxICLGfAIG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RcMCDWms9CcSr8sO27IXc0X3Kv4OSjT2TeXpnvr1LQnGJL5yCTt/r4g88vImek7C3AHAc1PYR/rAtXQgwYHyfo/tTvKLKD4VcGNnXRiMmYIY8NEqQZwAPilA9GM8XMieUa0Rgbn7hvZfi3jkBnjv0+9GxyH/PTx/Z6ccjj2qgAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rT5qE-0001FJ-Df; Thu, 25 Jan 2024 20:56:50 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Johan Jonker <jbx6244@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Algea Cao <algea.cao@rock-chips.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/3] Add support for RK3588 HDMI/DP Combo PHY
Date: Thu, 25 Jan 2024 20:56:44 +0100
Message-Id: <170621254052.1850726.5970136297823229036.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240119193806.1030214-1-cristian.ciocaltea@collabora.com>
References: <20240119193806.1030214-1-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 19 Jan 2024 21:38:00 +0200, Cristian Ciocaltea wrote:
> Add driver and bindings to support the Rockchip HDMI/eDP TX Combo PHY
> found on RK3588 SoC.
> 
> The PHY is based on a Samsung IP block and supports HDMI 2.1 TMDS, FRL
> and eDP links.
> 
> The HDMI link has been tested on Rock 5B and EVB1 boards.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: soc: rockchip: Add rk3588 hdptxphy syscon
      commit: 738227ab42fe0c6047f932aef11b9fd647d203f9

I've grabbed this one already, to keep my GRFs together :-)


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

