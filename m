Return-Path: <linux-kernel+bounces-13278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6298202D7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 00:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BFCE283845
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 23:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83A514F63;
	Fri, 29 Dec 2023 23:37:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1140A14AB8;
	Fri, 29 Dec 2023 23:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a56.versanet.de ([83.135.90.86] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rJMPN-0004lD-SV; Sat, 30 Dec 2023 00:36:53 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>,
	Alex Bee <knaerzche@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: Heiko Stuebner <heiko@sntech.de>,
	David Airlie <airlied@gmail.com>,
	linux-rockchip@lists.infradead.org,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v4 00/29] Add HDMI support for RK3128
Date: Sat, 30 Dec 2023 00:36:52 +0100
Message-Id: <170389300283.2698513.7009749210069050452.b4-ty@sntech.de>
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

[02/29] drm/rockchip: vop: Add output selection registers for RK312x
        commit: 407eaa4aa64a8429094fa75fac00fff5e471138d
[03/29] drm/rockchip: inno_hdmi: Fix video timing
        commit: 47a145c03484d33e65d773169d5ca1b9fe2a492e
[04/29] drm/rockchip: inno_hdmi: Remove useless mode_fixup
        commit: 099be7b6718685ebafb417e74bb637abf992474a
[05/29] drm/rockchip: inno_hdmi: Remove useless copy of drm_display_mode
        commit: 8f0df2012b8a94aed0cc450016f7592c24e92cfb
[06/29] drm/rockchip: inno_hdmi: Switch encoder hooks to atomic
        commit: ff4d4fa76fcc19f7d5d261f717121f0a88ec4e30
[07/29] drm/rockchip: inno_hdmi: Get rid of mode_set
        commit: d3e040f450ec8e46ff42fa495a433b976ab47686
[08/29] drm/rockchip: inno_hdmi: no need to store vic
        commit: d7ba3d711cf537ef0ece14cd85d2113ca338a00b
[09/29] drm/rockchip: inno_hdmi: Remove unneeded has audio flag
        commit: f8723484e045ff2d176124484907ec0199c55a0c
[10/29] drm/rockchip: inno_hdmi: Remove useless input format
        commit: c1ceee3248742149d1a602fd913bd88857da1d52
[11/29] drm/rockchip: inno_hdmi: Remove YUV-based csc coefficents
        commit: 139771b8239c43ad1bd6c2976aa12788096a5483
[12/29] drm/rockchip: inno_hdmi: Remove tmds rate from structure
        commit: 5f92474844a4fcb7997da20dd1de2031aed1d794

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

