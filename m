Return-Path: <linux-kernel+bounces-88100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 564E086DD57
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB0B1C215F7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC4A6A036;
	Fri,  1 Mar 2024 08:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UoFYyOsX"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B326A027
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709282697; cv=none; b=NgaDSvm/DFpojQBABG2VsUapx0J31rCM+HCJDdSzERZDEGL9QRxKvvNNzk3T6Yns6rANZ0YouDWEpFrgxdGTbi0SGLe2hn8yX9zm/Q3huSaBNxtSI6vT7AjOLdJadvio5irzRDQPcKsdbhajktEkCrxHUhdbQ0YKdtWrWnB89mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709282697; c=relaxed/simple;
	bh=bXBAHFeGCu5O4TJ5J4wr9CD9SH6dew1YR9J2IBlw2SQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XO6FzG1ZHdg0KONq+Csx2jfGHREyiBArwIklvze/lvG9zgEz8OXsdLJcysxCt3Vr+jZmf/zDJQcGvpQ4cGSSGl5rAP09MukKczUIP+kVML27Bdk3Db7RFq7lL5AGcSsFqRSJb9OsHMa1KuznKWX5kpXFWUDbVvLyEBLFNroK0u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UoFYyOsX; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709282693;
	bh=bXBAHFeGCu5O4TJ5J4wr9CD9SH6dew1YR9J2IBlw2SQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UoFYyOsXGvP6eOUCadzQZ6Dd1dR37f30iYer+MbmQhzQUIgDLHaBp2Yo5fjZigkHx
	 c56yxoEMhemHzOK0STONN90KbX3X/pRg0/EXYcgnLIrv8Xoo0HML36lxcHpSJYDdGj
	 Ex9xsUY+rpxun87oQpnpuZQM4sGesFWuB7E3Pvcbq8WAityzJUgBtGeiXFRaPo46ea
	 pRHsGY1x8yLzA/PEtLmz6g8OZ7HpA5oxJSPJW4rNlMj67dDe8ok//bUzNGd89vID8d
	 k4erXZOHANTm3z3NBjni0DRROwUlo1Xrm9AdiGF62Yoot875zmLjDRWV2YPrrjGl2B
	 lB4QqUtkSOUoQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D938837814A4;
	Fri,  1 Mar 2024 08:44:51 +0000 (UTC)
Message-ID: <924fdd72-93ef-47dc-bd7f-37ccba2f83f1@collabora.com>
Date: Fri, 1 Mar 2024 09:44:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] drm/panel: novatek-nt35950: Don't log an error
 when DSI host can't be found
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 owen <qwt9588@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>, Adrien Grassein <adrien.grassein@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Sam Ravnborg <sam@ravnborg.org>, Bjorn Andersson <andersson@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Vinay Simha BN <simhavcs@gmail.com>,
 Christopher Vollo <chris@renewoutreach.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240229-anx7625-defer-log-no-dsi-host-v2-0-00506941049a@collabora.com>
 <20240229-anx7625-defer-log-no-dsi-host-v2-8-00506941049a@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240229-anx7625-defer-log-no-dsi-host-v2-8-00506941049a@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 01/03/24 01:12, Nícolas F. R. A. Prado ha scritto:
> Given that failing to find a DSI host causes the driver to defer probe,
> make use of dev_err_probe() to log the reason. This makes the defer
> probe reason available and avoids alerting userspace about something
> that is not necessarily an error.
> 
> Fixes: 623a3531e9cf ("drm/panel: Add driver for Novatek NT35950 DSI DriverIC panels")
> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>   drivers/gpu/drm/panel/panel-novatek-nt35950.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35950.c b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
> index 648ce9201426..028fdac293f7 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt35950.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
> @@ -556,10 +556,8 @@ static int nt35950_probe(struct mipi_dsi_device *dsi)
>   		}
>   		dsi_r_host = of_find_mipi_dsi_host_by_node(dsi_r);
>   		of_node_put(dsi_r);
> -		if (!dsi_r_host) {
> -			dev_err(dev, "Cannot get secondary DSI host\n");
> -			return -EPROBE_DEFER;
> -		}
> +		if (!dsi_r_host)
> +			return dev_err_probe(dev, -EPROBE_DEFER, "Cannot get secondary DSI host\n");

Nicolas, this is going over 100 columns, which is not ok.
Please fix.


>   
>   		nt->dsi[1] = mipi_dsi_device_register_full(dsi_r_host, info);
>   		if (!nt->dsi[1]) {
> 



