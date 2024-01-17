Return-Path: <linux-kernel+bounces-28756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 236E98302AB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6CB71F21702
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513AB14A8D;
	Wed, 17 Jan 2024 09:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqns8HzL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D0E14282
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705484820; cv=none; b=lhqku1Eirc8cdLjs01oDMivvD9Sb7tMNmPwFdMQd1Oh2RQ8yCWCkOccBuixpsqtMw5NdfAR4yOyGRBmnGQhUpzdtVy+jxHGxXtzgUa8ikYGjAc2Husu+YPa6GQcjcUslqlyaN0RqfeYFWGbv7LUSh3HlSwYQROJjUBKEbO5m+YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705484820; c=relaxed/simple;
	bh=T6o5+nTzLQWlEAzpAo1HwywEQgFNbp3/JkgtLKKRTzM=;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer; b=nQNjawRJtqqqtcsEKPsF7VYAPtvJI3m/8LRZZ1DbFoZf1nBjteZQIT3pjuaJg0kT4JIpWQbU2ChkTSY6xuSEswgGl7lLFkqHjNaSur+Wu1D/inJUCAD4WrDkugZJrmMwKolaWhUbMtpKj1c/+ZaY4FplwByb+sLdw9eQks5vcok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqns8HzL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9783C43390;
	Wed, 17 Jan 2024 09:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705484820;
	bh=T6o5+nTzLQWlEAzpAo1HwywEQgFNbp3/JkgtLKKRTzM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gqns8HzL24wK05v3NJZyOYUdP9XHN8Ll7HXad1hX/ubbc2vAs+nL+qQvNLMDunFOh
	 idsUtrw+b167co4DAI0/R5EK4ERtUQ7B+Kf+uoIoiSwuMhxZldTikpq8CBBtGkbz23
	 ubyfhdyn8+R1JJFmktDiV4JvbIzKYJnm5+c5DpEV/CBklYqXEFPMe/VDfQ50HTv4Ej
	 a9pil2vVWMBurx1shW1QBl3mOB0P5iRqAdQztAzrhys1ZpClblcccrhUYV+ewByGwE
	 5zM98WbTic129I/SY0K9YSb4/HQaK0uZTzNHC+yKd1vVer69iqgUd+kyghLxR0j9Di
	 GC77OHlcBY4vg==
From: Maxime Ripard <mripard@kernel.org>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Alex Bee <knaerzche@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
In-Reply-To: <20240115092434.41695-2-knaerzche@gmail.com>
References: <20240115092434.41695-2-knaerzche@gmail.com>
Subject: Re: (subset) [PATCH] drm/rockchip: inno_hdmi: Explicitly include
 drm_atomic.h
Message-Id: <170548481754.96553.11502916321137598260.b4-ty@kernel.org>
Date: Wed, 17 Jan 2024 10:46:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Mon, 15 Jan 2024 10:24:35 +0100, Alex Bee wrote:
> Commit d3e040f450ec ("drm/rockchip: inno_hdmi: Get rid of mode_set")
> started using drm_atomic_get_new_connector_state and
> drm_atomic_get_new_crtc_state which are defined in drm_atomic.h
> Building does currently only work if CONFIG_OF and CONFIG_DRM_PANEL_BRIDGE
> are enabled since this will include drm_atomic.h via drm_bridge.h (see
> drm_of.h).
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime


