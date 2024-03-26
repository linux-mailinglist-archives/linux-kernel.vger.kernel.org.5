Return-Path: <linux-kernel+bounces-118699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D8688BE2D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE87E2E2AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC35C67A01;
	Tue, 26 Mar 2024 09:40:28 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B629482E2
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711446028; cv=none; b=Iuc9OK1tDV/G7/xuEpI9JUrjdp/LfFanJ84KvXD05gAelZK1PG0w1VUQ1j6T9t0eAf4WBVZGhIF0B5BKCnk53Cqlvug3grilzKFYiTTr66pYoChAg2yy49Y4QCYTkpnuIqvLRtmYEQJMBiDEsxmiYIgWmeS8yEk+RPy7JQ9vgBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711446028; c=relaxed/simple;
	bh=dy5+4IjR6YMVgmJELKcy7ArkXCIFzoqeEnhI6PVo1QU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGE/4A+AkBM5fbiQ6SZqc25vYkArXSgUQOBi0iY97yHWgybD3AxuItDCJXptCZaMFlgAG8hGzU3um7QAxQ7GXkd3fT0XMyNSI5r31y2pcl19rxaOQRv2QmSAI7y7bp5E2TlmNsO3Nr93no+sGJV4XKHdukDuqSfsGOSiOTXLAyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875aaf.versanet.de ([83.135.90.175] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rp3Hw-0001HT-FA; Tue, 26 Mar 2024 10:40:12 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Heiko Stuebner <heiko@sntech.de>,
	quic_jesszhan@quicinc.com,
	neil.armstrong@linaro.org,
	sam@ravnborg.org
Cc: tzimmermann@suse.de,
	klaus.goger@theobroma-systems.com,
	dri-devel@lists.freedesktop.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	quentin.schulz@theobroma-systems.com
Subject: Re: [PATCH 1/2] drm/panel: ltk050h3146w: add MIPI_DSI_MODE_VIDEO to LTK050H3148W flags
Date: Tue, 26 Mar 2024 10:40:10 +0100
Message-Id: <171144600424.1118335.2717050705855214232.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240320131232.327196-1-heiko@sntech.de>
References: <20240320131232.327196-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 20 Mar 2024 14:12:31 +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> Similar to other variants, the LTK050H3148W wants to run in video mode
> when displaying data. So far only the Synopsis DSI driver was using this
> panel and it is always switching to video mode, independent of this flag
> being set.
> 
> [...]

Applied, thanks!

[1/2] drm/panel: ltk050h3146w: add MIPI_DSI_MODE_VIDEO to LTK050H3148W flags
      commit: 80cc8c0d09e6bab3bd016ddaccd0570cadbe1891
[2/2] drm/panel: ltk050h3146w: drop duplicate commands from LTK050H3148W init
      commit: 55679cc22e60e8ec23b2340248389022798416cd

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

