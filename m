Return-Path: <linux-kernel+bounces-88098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC6F86DD53
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF738B2218E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E348B69E00;
	Fri,  1 Mar 2024 08:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Bpj8jGdS"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EA169DE8
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 08:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709282683; cv=none; b=u3xxfiNFdtqMz5PpB0gIePBCkMtBEK1k4aBPlDz+M4bh+BnmlifC4EbKsD8pgxXcnOpHm89c1vNYNFDBhQgR5VuUJZhbbE9L0LI8ikxHF+hTEQK2UeV8bsM6ktLMWqjrJEJxi+IaF72TrYW+sYLPaOKH/I9jnV0eWzhuY/AWD/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709282683; c=relaxed/simple;
	bh=XLaLLONd4SE+7aUeLHwG5Hrbe4M4/9UkvPrdtUnAvG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aEDjAz843HWznFbpX2ljADFkq7PZQroTKFELhEckoRnebaRyS50BAz7EzLxqWc1BZGoZ9oVju0e1DzL0zfNH6S79VY7rx/z3IAS0F8+7c5bJ8EzkqDs88lS4ugnNoF/1YHk7QFj+DfWLqem2FnCvYvn68ECRLkvDuCdLOR36Pog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Bpj8jGdS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709282679;
	bh=XLaLLONd4SE+7aUeLHwG5Hrbe4M4/9UkvPrdtUnAvG4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Bpj8jGdSvexBD3DYnIrk34Uj8pozfpzurdNH7SiTFN5+2gT2uPzciPIOWewktNSik
	 D5FFGsQgofou9YcjIGM4D1d6z3HzerFDXUwyosTBm/Q1SMfRxqaxdnxvv+tubDzrG/
	 QlZYKm1OKYo+jac0r+u+fOTodMzdMR8lfnF2ScLK3U5ttKAQmwqXRwsw8ORnh6V1bx
	 MNWfTNIDp2iEmsDtqk7vT3y+TS68tSyZxfM4KnXu2by0+NB0Qn/jsJoocHS3crj53K
	 E2W9nEJBlZ7RuwVy1meiMcPazsp3gU5+qvb36hYGl8D4vOKpwqGQPoqO+hD/jn9B9s
	 cuD38kfQa74Pg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9C0CB37814A4;
	Fri,  1 Mar 2024 08:44:37 +0000 (UTC)
Message-ID: <fc12dbc9-5c0b-4bff-8754-5b9a5f7b0e12@collabora.com>
Date: Fri, 1 Mar 2024 09:44:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] drm/panel: truly-nt35597: Don't log an error when
 DSI host can't be found
Content-Language: en-US
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
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
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240229-anx7625-defer-log-no-dsi-host-v2-0-00506941049a@collabora.com>
 <20240229-anx7625-defer-log-no-dsi-host-v2-9-00506941049a@collabora.com>
 <20240301063020.GL30889@pendragon.ideasonboard.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240301063020.GL30889@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 01/03/24 07:30, Laurent Pinchart ha scritto:
> Hi Nícolas,
> 
> Thank you for the patch.
> 
> On Thu, Feb 29, 2024 at 07:12:15PM -0500, Nícolas F. R. A. Prado wrote:
>> Given that failing to find a DSI host causes the driver to defer probe,
>> make use of dev_err_probe() to log the reason. This makes the defer
>> probe reason available and avoids alerting userspace about something
>> that is not necessarily an error.
>>
>> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>> ---
>>   drivers/gpu/drm/panel/panel-truly-nt35597.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panel/panel-truly-nt35597.c b/drivers/gpu/drm/panel/panel-truly-nt35597.c
>> index b73448cf349d..d447db912a61 100644
>> --- a/drivers/gpu/drm/panel/panel-truly-nt35597.c
>> +++ b/drivers/gpu/drm/panel/panel-truly-nt35597.c
>> @@ -550,10 +550,8 @@ static int truly_nt35597_probe(struct mipi_dsi_device *dsi)
>>   
>>   	dsi1_host = of_find_mipi_dsi_host_by_node(dsi1);
>>   	of_node_put(dsi1);
>> -	if (!dsi1_host) {
>> -		dev_err(dev, "failed to find dsi host\n");
>> -		return -EPROBE_DEFER;
>> -	}
>> +	if (!dsi1_host)
>> +		return dev_err_probe(dev, -EPROBE_DEFER, "failed to find dsi host\n");
> 
> 		return dev_err_probe(dev, -EPROBE_DEFER,
> 				     "failed to find dsi host\n");
> 
> With this addressed,

I disagree. That's 87 columns, and the 80-col rule is long gone.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
>>   
>>   	/* register the second DSI device */
>>   	dsi1_device = mipi_dsi_device_register_full(dsi1_host, &info);
>>
> 



