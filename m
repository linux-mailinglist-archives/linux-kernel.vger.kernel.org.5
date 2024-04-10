Return-Path: <linux-kernel+bounces-137922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AC389E995
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066AB1F23CD7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2F23F9D9;
	Wed, 10 Apr 2024 05:15:28 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ACBB676;
	Wed, 10 Apr 2024 05:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712726128; cv=none; b=Z3qry13t6KzgBlOF12GpEC6Uu1IY5w323nkQoytVi9szo2jq05IyW0HfB/RfjRkHiZnEnVwn4Iku0EDL5qnE//+Ls/k88Iyfi1UDIHMJzEA7Mc4VOmdcF31U71E0/yy/qyTV7EiNhpw7sOKPBqV6ZUZJG/nr3HwqwAGlO2Ih8HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712726128; c=relaxed/simple;
	bh=wupLBeH52WYuu08SB8OdZb8dy8SXdlV2nrfdO4R1nIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zl+mJkxCCdnacI0SZuQP5lVeA8dNQHU7CBdROvXfpTeUsVHo/LJ3AMNZlyX9G1UGNV50cUnC66OvJgQq8f8w+fziEJrq3Ikqncyd1WQC1Fl0KUNz9Mti5GmZv7pcWzQFq7HYZSenSnpW65KlhQ+LaXRg6aNXhbqAA12u+WmMHHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from ip-185-104-138-50.ptr.icomera.net ([185.104.138.50] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ruQIo-0008Ut-9s; Wed, 10 Apr 2024 07:15:18 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: hverkuil-cisco@xs4all.nl,
	mchehab@kernel.org,
	Shreeya Patel <shreeya.patel@collabora.com>,
	sebastian.reichel@collabora.com,
	jose.abreu@synopsys.com,
	nelson.costa@synopsys.com,
	p.zabel@pengutronix.de,
	dmitry.osipenko@collabora.com,
	nicolas.dufresne@collabora.com,
	krzysztof.kozlowski+dt@linaro.org,
	hverkuil@xs4all.nl,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	shawn.wen@rock-chips.com
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-media@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm@lists.infradead.org,
	kernel@collabora.com
Subject: Re: (subset) [PATCH v3 0/6] Add Synopsys DesignWare HDMI RX Controller
Date: Wed, 10 Apr 2024 07:15:07 +0200
Message-Id: <171272604798.1867483.3380752860192123035.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327225057.672304-1-shreeya.patel@collabora.com>
References: <20240327225057.672304-1-shreeya.patel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 28 Mar 2024 04:20:51 +0530, Shreeya Patel wrote:
> This series implements support for the Synopsys DesignWare
> HDMI RX Controller, being compliant with standard HDMI 1.4b
> and HDMI 2.0.
> 
> Features that are currently supported by the HDMI RX driver
> have been tested on rock5b board using a HDMI to micro-HDMI cable.
> It is recommended to use a good quality cable as there were
> multiple issues seen during testing the driver.
> 
> [...]

Applied, thanks!

[1/6] dt-bindings: reset: Define reset id used for HDMI Receiver
      commit: ca151fd56b5736a7adbdba5675b9d87d70f20b23
[2/6] clk: rockchip: rst-rk3588: Add reset line for HDMI Receiver
      commit: 7af67019cd78d028ef377df689ac103d51905518

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

