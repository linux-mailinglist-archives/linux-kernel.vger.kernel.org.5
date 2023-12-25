Return-Path: <linux-kernel+bounces-10847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6265681DD52
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 01:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86C8D1C21516
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 00:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AAF62A;
	Mon, 25 Dec 2023 00:21:15 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B757E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 00:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e86193c.versanet.de ([94.134.25.60] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rHYiR-0007kx-97; Mon, 25 Dec 2023 01:21:07 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Andy Yan <andyshrk@163.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	hjc@rock-chips.com,
	s.hauer@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>,
	broonie@kernel.org,
	m.szyprowski@samsung.com,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] drm/rockchip: vop2: Avoid use regmap_reinit_cache at runtime
Date: Mon, 25 Dec 2023 01:21:04 +0100
Message-Id: <170346364423.2455794.3597954899361458023.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231217084415.2373043-1-andyshrk@163.com>
References: <20231217084415.2373043-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 17 Dec 2023 16:44:15 +0800, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> Marek Report a possible irq lock inversion dependency warning when
> commit 81a06f1d02e5 ("Revert "drm/rockchip: vop2: Use regcache_sync()
> to fix suspend/resume"") lands linux-next.
> 
> I can reproduce this warning with:
> CONFIG_PROVE_LOCKING=y
> CONFIG_DEBUG_LOCKDEP=y
> 
> [...]

Applied, thanks!

[1/1] drm/rockchip: vop2: Avoid use regmap_reinit_cache at runtime
      commit: 3ee348eb36f14e9303a7e9757efb91b0bbf3f7a9

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

