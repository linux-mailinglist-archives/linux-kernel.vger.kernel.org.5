Return-Path: <linux-kernel+bounces-158469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D644D8B2093
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 140231C23373
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05D412AACB;
	Thu, 25 Apr 2024 11:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZ53i8ZW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B351E497;
	Thu, 25 Apr 2024 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714045416; cv=none; b=IDeUuyyIShoTIbvm/N7BzN/GcKmjimNsnvoYwInDREjqHTI3S4ROPqAxubQBdhq8bEY6mARm4XwQ7jVUXAHEzguSappqoCy8Hcmrc1m5sWXnGsei+dgC+J0ClqiEtKjCAce8tjZfDj63o36vs36VNCq9LYb1AezrDCSh+LVKHlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714045416; c=relaxed/simple;
	bh=6hbuEo73qBv0jvZBozo1DEDhJftdYqQqfhBq3uTN4Wc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JO5sbwJ/29PB3sCDuC+vYp+U6Kn38auZjknrgsAtpK9wCIvIhsSHLtpwUtCM7HB6Qduvhp/Xy6dq02o/ab2Lmhk7CcdM2HkPaozp163+FEoZMis60fOndCTAJI053U+rqpqUdqLmOj97rEXVfzc9SihHOEfsQFQYraFfVbqfmOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZ53i8ZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999EEC113CC;
	Thu, 25 Apr 2024 11:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714045415;
	bh=6hbuEo73qBv0jvZBozo1DEDhJftdYqQqfhBq3uTN4Wc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fZ53i8ZWjxv2puTITm4U5wtba2pLlmhRXa0CGan/vm3jNACET538J4co1YWOd5R3A
	 eQszDLjlEB5Xqw5HPnsNq67mGyAsQIUbTl+S17SVawU+hZZhbJS2fGmfmhIYWrhV0K
	 JXjSDOo2As9Bemr/GzPVFmtxaYYsuiGD3bAd/OG20ltzZ6zXhUKkLj2PvCNN+xT+JD
	 +msfZ4kyNburoymGfRgBNdM3X8T8LOAvJvsAdhcMcX68AFoZu7tg+V/gj/japRFyxT
	 +Zg0K+KB/8IGL74r+uhz2OubhGuAA3grUW/uP6xK9XKzzMTvcRCWqiGsq8XC/sF6g+
	 xrsxBiBBpi6bQ==
From: Robert Foss <rfoss@kernel.org>
To: Adam Ford <aford173@gmail.com>, linux-arm-kernel@lists.infradead.org
Cc: David Airlie <airlied@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Daniel Vetter <daniel@ffwll.ch>, Fabio Estevam <festevam@gmail.com>,
 Liu Ying <victor.liu@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 linux-kernel@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 Andrzej Hajda <andrzej.hajda@intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 aford@beaconembedded.com, Lucas Stach <l.stach@pengutronix.de>, Jonas Karlman <jonas@kwiboo.se>,
 kernel test robot <lkp@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20240422103352.8886-1-aford173@gmail.com>
References: <20240422103352.8886-1-aford173@gmail.com>
Subject: Re: [PATCH V2] drm/bridge: imx: Fix unmet depenency for PHY_FSL_SAMSUNG_HDMI_PHY
Message-Id: <171404541028.1834748.16197484610982972035.b4-ty@kernel.org>
Date: Thu, 25 Apr 2024 13:43:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1

On Mon, 22 Apr 2024 05:33:52 -0500, Adam Ford wrote:
> When enabling i.MX8MP DWC HDMI driver, it automatically selects
> PHY_FSL_SAMSUNG_HDMI_PHY, since it wont' work without the phy.
> This may cause some Kconfig warnings during various build tests.
> Fix this by implying the phy instead of selecting the phy.
> 
> To prevent this from happening with the DRM_IMX8MP_HDMI_PVI, also
> imply it instead of selecting it.
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: imx: Fix unmet depenency for PHY_FSL_SAMSUNG_HDMI_PHY
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=cbdbd9ca718e



Rob


