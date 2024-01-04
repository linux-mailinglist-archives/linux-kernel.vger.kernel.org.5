Return-Path: <linux-kernel+bounces-16356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E15B3823D3E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50172B24547
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34637200CA;
	Thu,  4 Jan 2024 08:15:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712BB2030A;
	Thu,  4 Jan 2024 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a56.versanet.de ([83.135.90.86] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rLIs8-0001V5-P4; Thu, 04 Jan 2024 09:14:36 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Sandy Huang <hjc@rock-chips.com>,
	Alex Bee <knaerzche@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	David Airlie <airlied@gmail.com>
Subject: Re: (subset) [PATCH v4 00/29] Add HDMI support for RK3128
Date: Thu,  4 Jan 2024 09:14:33 +0100
Message-Id: <170435598418.3166964.9367277671989164237.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231222174220.55249-1-knaerzche@gmail.com>
References: <20231222174220.55249-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 22 Dec 2023 18:41:51 +0100, Alex Bee wrote:
> This is version 4 of my series that aims to add support for the display
> controller (VOP) and the HDMI controller block of RK3128 (which is very
> similar to the one found in RK3036). The original intention of this series
> was to add support for this slightly different integration but is by now,
> driven by maintainer's feedback, exploded to be a rework of inno-hdmi
> driver in large parts. It is, however, a change for the better.
> 
> [...]

Applied, thanks!

[23/29] drm/rockchip: inno_hdmi: Add variant support
        commit: 5f2e93e6719701a91307090f8f7696fd6b3bffdf
[24/29] drm/rockchip: inno_hdmi: Add RK3128 support
        commit: aa54f334c291effe321aa4b9ac0e67a895fd7b58
[25/29] drm/rockchip: inno_hdmi: Add basic mode validation
        commit: 701029621d4141d0c9f8b81a88a37b95ec84ce65
[26/29] drm/rockchip: inno_hdmi: Drop custom fill_modes hook
        commit: 50a3c772bd927dd409c484832ddd9f6bf00b7389


For reference, Rob has applied the rk3128 compatible in
https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/commit/?id=21960bda59852ca961fcd27fba9f92750caccd06


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

