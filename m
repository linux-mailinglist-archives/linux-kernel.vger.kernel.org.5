Return-Path: <linux-kernel+bounces-16912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E4A8245F3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D46D1C2227F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23B224B3D;
	Thu,  4 Jan 2024 16:14:57 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6355C24B21
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a56.versanet.de ([83.135.90.86] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rLQMe-0007JC-IQ; Thu, 04 Jan 2024 17:14:36 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Quentin Schulz <foss+kernel@0leil.net>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/2] drm/panel: ltk050h3146w: error-path debug message improvements
Date: Thu,  4 Jan 2024 17:14:34 +0100
Message-Id: <170438486164.3319207.5285287906784250172.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240104-ltk-dev_err_probe-v1-0-8ef3c0b585d8@theobroma-systems.com>
References: <20240104-ltk-dev_err_probe-v1-0-8ef3c0b585d8@theobroma-systems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 4 Jan 2024 13:41:56 +0100, Quentin Schulz wrote:
> This hides an error message if EPROBE_DEFER was returned when trying to
> get the reset GPIO.
> 
> This also makes use of dev_err_probe in lieu of hand-crafted logic
> inside the driver.
> 
> Thanks,
> Quentin
> 
> [...]

Applied, thanks!

[1/2] drm/panel: ltk050h3146w: only print message when GPIO getting is not EPROBE_DEFER
      commit: 65afd91e8d70e10c7f99126d61bf0045ef52d271
[2/2] drm/panel: ltk050h3146w: use dev_err_probe wherever possible
      commit: 056a9965e58e47928e8afd4dc017221f9221b3d3

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

