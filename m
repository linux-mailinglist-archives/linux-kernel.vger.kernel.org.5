Return-Path: <linux-kernel+bounces-88194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5872786DE62
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B84A1C21472
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2486A8AD;
	Fri,  1 Mar 2024 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aQu+fAO0"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DE06A8A1
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 09:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285859; cv=none; b=DgBpR9SYOC4fMr3Svsq+RD8ZxVHChPGWMFwmCOV8rjAz5OqFVCZg0rjSqCp+skk9d8yVAJPoPRMDlIw4R58Vw1pagDnE31dYXgMfOKeiAyfQnL+yhcRGxFFLlGNiuHSzgwQBworklF3j1x/PeRh3lEkk6xt6UdzJz5a6May4QQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285859; c=relaxed/simple;
	bh=A2uxSw1vnaAuTLjXCJFn//797EKTGWb7p7s59bXgVD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qSTwb26CJbm18cgQK7QwjK9SQ7ZJ7V1BIO/V1ybRiJT7Od+MGH8rb7oNkAzYKsaGeXb76Ws9udj4Igf67rES8zJNtgC2qiGr4Mno5WOfJ2Obbyv9NE5UQ6BPRbN8XWV5JrUiNPfJ0oia7ATVl8WVg7+SEv+b/EaKiuhueYYTnng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aQu+fAO0; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709285855;
	bh=A2uxSw1vnaAuTLjXCJFn//797EKTGWb7p7s59bXgVD0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aQu+fAO0bPL8+YFsKX3mSWSa5uB5OEd5PCitGYbZzqfHR/pUjWtD1pPZ0f8dTU6iP
	 Hjj+rl2h1dn9TPQUlyOPxUc85GNm9AVjdrOHBgA5T5RCQfwgqAc/W02wQ0ubHhpb3J
	 Lh0XtaoRjGEjDKCf7yfi9crQBk7ORK0xzDU+oCOur5CtlHicWc1c4hDskoHum7jqB+
	 HRfVFKVCNptlYS66D41niOb/Ii1X2gMTtken8+qFilIlXqhAcxMwvrc6SupLVSPKA5
	 3Rl0waHceUsrd73R89atI88yXK3TtEdqduEqoBqMkO14OxVC3JmG5Iwewvh5DNt83q
	 khH1jLFBb/VVQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 29E6037810CD;
	Fri,  1 Mar 2024 09:37:34 +0000 (UTC)
Message-ID: <ceee318c-1d57-4b3d-9754-1a9ee53fc4e2@collabora.com>
Date: Fri, 1 Mar 2024 10:37:34 +0100
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
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
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
 <fc12dbc9-5c0b-4bff-8754-5b9a5f7b0e12@collabora.com>
 <20240301085624.GC30104@pendragon.ideasonboard.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240301085624.GC30104@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 01/03/24 09:56, Laurent Pinchart ha scritto:
> On Fri, Mar 01, 2024 at 09:44:36AM +0100, AngeloGioacchino Del Regno wrote:
>> Il 01/03/24 07:30, Laurent Pinchart ha scritto:
>>> On Thu, Feb 29, 2024 at 07:12:15PM -0500, Nícolas F. R. A. Prado wrote:
>>>> Given that failing to find a DSI host causes the driver to defer probe,
>>>> make use of dev_err_probe() to log the reason. This makes the defer
>>>> probe reason available and avoids alerting userspace about something
>>>> that is not necessarily an error.
>>>>
>>>> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>>> ---
>>>>    drivers/gpu/drm/panel/panel-truly-nt35597.c | 6 ++----
>>>>    1 file changed, 2 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/panel/panel-truly-nt35597.c b/drivers/gpu/drm/panel/panel-truly-nt35597.c
>>>> index b73448cf349d..d447db912a61 100644
>>>> --- a/drivers/gpu/drm/panel/panel-truly-nt35597.c
>>>> +++ b/drivers/gpu/drm/panel/panel-truly-nt35597.c
>>>> @@ -550,10 +550,8 @@ static int truly_nt35597_probe(struct mipi_dsi_device *dsi)
>>>>    
>>>>    	dsi1_host = of_find_mipi_dsi_host_by_node(dsi1);
>>>>    	of_node_put(dsi1);
>>>> -	if (!dsi1_host) {
>>>> -		dev_err(dev, "failed to find dsi host\n");
>>>> -		return -EPROBE_DEFER;
>>>> -	}
>>>> +	if (!dsi1_host)
>>>> +		return dev_err_probe(dev, -EPROBE_DEFER, "failed to find dsi host\n");
>>>
>>> 		return dev_err_probe(dev, -EPROBE_DEFER,
>>> 				     "failed to find dsi host\n");
>>>
>>> With this addressed,
>>
>> I disagree. That's 87 columns, and the 80-col rule is long gone.
> 
> It's still a maintainer's preference. I soft-enforce it in drivers I
> maintain. In this case I'll let Neil decide, as he's listed as the
> maintainer for drivers/gpu/drm/panel/.
> 

Yes, that's right. Comes down to personal opinion.

Cheers

>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>
>>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>>
>>>>    
>>>>    	/* register the second DSI device */
>>>>    	dsi1_device = mipi_dsi_device_register_full(dsi1_host, &info);
> 


