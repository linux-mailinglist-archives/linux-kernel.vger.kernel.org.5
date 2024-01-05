Return-Path: <linux-kernel+bounces-18331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E035C825BAF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E9CC285024
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319F61DFF3;
	Fri,  5 Jan 2024 20:38:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F3722EF1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 20:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a56.versanet.de ([83.135.90.86] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rLqwi-0007ui-8H; Fri, 05 Jan 2024 21:37:36 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maxime Ripard <mripard@kernel.org>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	David Airlie <airlied@gmail.com>,
	Andy Yan <andy.yan@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	kernel@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/rockchip: vop2: Drop unused if_dclk_rate variable
Date: Fri,  5 Jan 2024 21:37:34 +0100
Message-Id: <170448704129.3462688.7176944458440903061.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240105174007.98054-1-cristian.ciocaltea@collabora.com>
References: <20240105174007.98054-1-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 5 Jan 2024 19:40:06 +0200, Cristian Ciocaltea wrote:
> Commit 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
> introduced a variable which ended up being unused:
> 
> rockchip_drm_vop2.c:1688:23: warning: variable ‘if_dclk_rate’ set but not used [-Wunused-but-set-variable]
> 
> This has been initially used as part of a formula to compute the clock
> dividers, but eventually it has been replaced by static values.
> 
> [...]

Applied, thanks!

[1/1] drm/rockchip: vop2: Drop unused if_dclk_rate variable
      commit: 196da3f3f76a46905f7daab29c56974f1aba9a7a

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

