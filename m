Return-Path: <linux-kernel+bounces-16576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F66682407C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28BC61C20A09
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30BC21101;
	Thu,  4 Jan 2024 11:20:25 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D1D20DF0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 11:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a56.versanet.de ([83.135.90.86] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rLLPQ-0003Kg-Tf; Thu, 04 Jan 2024 11:57:09 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>,
	Mark Yao <markyao0591@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Quentin Schulz <foss+kernel@0leil.net>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	linux-kernel@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2 0/2] drm/rockchip: lvds: improve erroring out when drm_of_find_panel_or_bridge fails
Date: Thu,  4 Jan 2024 11:57:07 +0100
Message-Id: <170436581964.3241728.17762561185162139964.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120-rk-lvds-defer-msg-v2-0-9c59a5779cf9@theobroma-systems.com>
References: <20231120-rk-lvds-defer-msg-v2-0-9c59a5779cf9@theobroma-systems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 20 Nov 2023 13:29:47 +0100, Quentin Schulz wrote:
> drm_of_find_panel_or_bridge may return a different error code than
> EPROBE_DEFER so let's not overwrite it.
> 
> At the same time, let's demote the DRM_DEV_ERROR message to
> dev_err_probe so that the scary message isn't shown (by default)
> whenever EPROBE_DEFER is returned to not mislead users.
> 
> [...]

Applied, thanks!

[1/2] drm/rockchip: lvds: do not overwrite error code
      commit: 79b09453c4e369ca81cfb670d0136d089e3b92f0
[2/2] drm/rockchip: lvds: do not print scary message when probing defer
      commit: 52d11c863ac92e36a0365249f7f6d27ac48c78bc

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

