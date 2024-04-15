Return-Path: <linux-kernel+bounces-144547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0488A47A1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001301F21D2F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 05:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065866125;
	Mon, 15 Apr 2024 05:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="PzYoFki4"
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AB04C8D;
	Mon, 15 Apr 2024 05:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713159602; cv=none; b=PWGwGfSFgtfCwQ3mKWjnIiZokWdJMd3cEsecNHmFxY6/y7/U5IucAyOf8Wv4tty8dT/AGJY+Se4/MLMGk4PIwYQyySwOlsA78yCdSt6uHASWqmR+sgRFRrsxAjsfAShaiKhKy19+ulchV90vRK7OlN9RJjIfHGBD9boHcvD91K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713159602; c=relaxed/simple;
	bh=ZF+VlMWof4THuXVKtLsY3NwOapkk05y8L6NMm7eH744=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/Kq1pJXQtgvWO9T8bPprH7wfMy/eGA/7L43Aw+a19ncrnQRy5isLHKcAyJrCEDJDpaZKqXpXkTg8yRyvaBijFq7uAXq+D6y4k52/1zAE51jMySXBA/zywqxqFiA3oGDsCgaz6jI/GVp0MjRpWGrYevmCWR8mAArRjWvlGRLTSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=PzYoFki4; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id wF4LrfRtmA2vSwF4LrsC4D; Mon, 15 Apr 2024 07:39:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713159597;
	bh=BY4nt4wdNHlCRY/QePQsMxBf9RDvOOCW1ziuSGFdVAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=PzYoFki4L95iMHMRsC05dAMyOm0K3a5H1ePrbXEdjVOMPlIPB0/5qG78g9tam6Fih
	 4BSmWLv4mCi/w/9Axj3MFw9C1NAi0i7Z94SE8I2ym1zrWtFenklV8Uu5mFzE8zUtUx
	 Dwa4Jj2PYdWAMf9KL7QgHX4ZeK4K7aiiof+yvHQ7/lSfL/dVgqHN/Q770y/6hpw5Yk
	 LMpPTw73RU8xvAggzbcty0l+4o6ELAMeSB4ivgU5laaq6ZKkKCZLwUgrhDgrP88+Kn
	 jFEKNk2DsmOyulmsZ/FhOx4TeLnh84YZF3txrKybeD1Rttmi4AtjW3KJ7uv+Urlcd4
	 8bdHGtBmp0FEg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 15 Apr 2024 07:39:57 +0200
X-ME-IP: 86.243.17.157
Message-ID: <4b23fab6-3241-4f97-bdef-ece53d24574a@wanadoo.fr>
Date: Mon, 15 Apr 2024 07:39:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/panel: Add driver for EDO RM69380 OLED panel
To: david@mainlining.org
Cc: airlied@gmail.com, christophe.jaillet@wanadoo.fr, conor+dt@kernel.org,
 daniel@ffwll.ch, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, konradybcio@kernel.org, krzk+dt@kernel.org,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 marijn.suijten@somainline.org, mripard@kernel.org,
 neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, robh@kernel.org,
 sam@ravnborg.org, tzimmermann@suse.de, ~postmarketos/upstreaming@lists.sr.ht
References: <20240414-raydium-rm69380-driver-v1-0-5e86ba2490b5@mainlining.org>
 <20240414-raydium-rm69380-driver-v1-2-5e86ba2490b5@mainlining.org>
 <d0db78dd-c915-41f3-b1be-b30a0266741d@wanadoo.fr>
 <7529f14b292c7173d4a60a7dca8af92b@mainlining.org>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <7529f14b292c7173d4a60a7dca8af92b@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 15/04/2024 à 07:37, david-vu3DzTD92ROXwddmVfQv5g@public.gmane.org a 
écrit :
> W dniu 2024-04-14 22:22, Christophe JAILLET napisał(a):
>> Le 14/04/2024 à 17:22, David Wronek a écrit :
>>> Add support for the 2560x1600@90Hz OLED panel by EDO bundled with a
>>> Raydium RM69380 controller, as found on the Lenovo Xiaoxin Pad Pro 2021.
>>>
>>> Signed-off-by: David Wronek 
>>> <david-vu3DzTD92ROXwddmVfQv5g-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>
>>> ---
>>>   drivers/gpu/drm/panel/Kconfig                 |  14 +
>>>   drivers/gpu/drm/panel/Makefile                |   1 +
>>>   drivers/gpu/drm/panel/panel-raydium-rm69380.c | 378 
>>> ++++++++++++++++++++++++++
>>>   3 files changed, 393 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/panel/Kconfig 
>>> b/drivers/gpu/drm/panel/Kconfig
>>> index 154f5bf82980..84cbd838f57e 100644
>>> --- a/drivers/gpu/drm/panel/Kconfig
>>> +++ b/drivers/gpu/drm/panel/Kconfig
>>> @@ -542,6 +542,20 @@ config DRM_PANEL_RAYDIUM_RM692E5
>>>         Say Y here if you want to enable support for Raydium 
>>> RM692E5-based
>>>         display panels, such as the one found in the Fairphone 5 
>>> smartphone.
>>>   +config DRM_PANEL_RAYDIUM_RM69380
>>> +    tristate "Raydium RM69380-based DSI panel"
>>> +    depends on BACKLIGHT_CLASS_DEVICE
>>> +    depends on DRM_DISPLAY_DP_HELPER
>>> +    depends on DRM_DISPLAY_HELPER
>>> +    depends on DRM_MIPI_DSI
>>> +    depends on OF
>>> +    help
>>> +      Say Y here if you want to enable support for Raydium 
>>> RM69380-based
>>> +      display panels.
>>> +
>>> +      This panel controller can be found in the Lenovo Xiaoxin Pad 
>>> Pro 2021
>>> +      in combiantion with an EDO OLED panel.
>>
>> combination?
>>
> 
> Yes, this is just one of the examples where this driver IC can be found. 
> It can also be used with panels other than those from EDO.

Hi, sorry if i was unclear.

Is there a typo: s/combiantion/combination/ ?

CJ

> 
>>> +
>>>   config DRM_PANEL_RONBO_RB070D30
>>>       tristate "Ronbo Electronics RB070D30 panel"
>>>       depends on OF
> 
> Best regards,
> David Wronek <david-vu3DzTD92ROXwddmVfQv5g@public.gmane.org>
> 
> 


