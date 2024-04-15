Return-Path: <linux-kernel+bounces-144550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB868A47AB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164861C213EB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 05:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4736125;
	Mon, 15 Apr 2024 05:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="CxugAGu8"
Received: from mail.mainlining.org (mainlining.org [94.241.141.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B266D6FB8;
	Mon, 15 Apr 2024 05:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.241.141.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713159884; cv=none; b=UIvfpp1aukfZ13UmccrwZ+4NYDVv0Vpc9jDgZPXuwT9gYacYEYc7BR8/n2hfexHDzBEypQNAER1WDF3zvsC9sEoScTp52gAbL/t6AA+UxOzR+ZXUaOSCf9wj29YgF03HoF3KFVzn9O45sngdAc0dL9UeWjgFcKGuSGMzHY2gr74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713159884; c=relaxed/simple;
	bh=7P4l52Y+1wSfmqDVe+Eo7LWoDOv15PEl6DkRISZjT8E=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=scLePYChSvfFysGZCUZxy+nl+7GkQKF8Mj1QkDjUmWcVhGNoRzuact9DRM77s/seK2LBLvy1iQpX6/HL6p0d/nENuIUt6K6A2E2HivbYqt8+fjhVqnwEbLnIPpdOLrmPJXbGZUnBk/A4m68JABYJtKqmpk4y/iOZmS3qjvmDSoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=CxugAGu8; arc=none smtp.client-ip=94.241.141.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from localhost (docker-mailserver-web-1.docker-mailserver_default [172.18.0.7])
	by mail.mainlining.org (Postfix) with ESMTPSA id 52EF3E2087;
	Mon, 15 Apr 2024 05:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1713159880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KTtrr/VzZwXSnm5TpdjpUbMbnQJ9QSIm6FgjTM/8acw=;
	b=CxugAGu8TXPUYyw4u8cY0z0h546GPF3nj5+5ovr9lboKR6JinwAUIieyYqL5NBHCgs8ULn
	Y3ifeLygOPWTeYTG8JzpuH0PYL7XEf5g4S2SN4I0Z4QpsGldTPm1CSL3U4UVEnOPifJ5px
	zCVWwsbKz09IZ/Gyhca4svqMZWRmiLPjZI7PkyG0tz0kdCXSrtqCyVCsDEBO5TLv197kxf
	tuv34C6tG3Pw9/+o5qKhIk0+eeF5MGqZxK7XVFDiZU+4VgYFUZ85AHX7/a7WrwHVu/Uvho
	H05CmSXjSgqDFNITn0fWPUebbfo07fCaeuMXAKF3AKm8R+yxojsCuPpIL7Yb9A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 15 Apr 2024 07:44:40 +0200
From: David Wronek <david@mainlining.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: airlied@gmail.com, conor+dt@kernel.org, daniel@ffwll.ch,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 konradybcio@kernel.org, krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, marijn.suijten@somainline.org,
 mripard@kernel.org, neil.armstrong@linaro.org, quic_jesszhan@quicinc.com,
 robh@kernel.org, sam@ravnborg.org, tzimmermann@suse.de,
 ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 2/2] drm/panel: Add driver for EDO RM69380 OLED panel
In-Reply-To: <4b23fab6-3241-4f97-bdef-ece53d24574a@wanadoo.fr>
References: <20240414-raydium-rm69380-driver-v1-0-5e86ba2490b5@mainlining.org>
 <20240414-raydium-rm69380-driver-v1-2-5e86ba2490b5@mainlining.org>
 <d0db78dd-c915-41f3-b1be-b30a0266741d@wanadoo.fr>
 <7529f14b292c7173d4a60a7dca8af92b@mainlining.org>
 <4b23fab6-3241-4f97-bdef-ece53d24574a@wanadoo.fr>
Message-ID: <254c4d068576edc914b63d26fedb3b22@mainlining.org>
X-Sender: david@mainlining.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

W dniu 2024-04-15 07:39, Christophe JAILLET napisał(a):
> Le 15/04/2024 à 07:37, david-vu3DzTD92ROXwddmVfQv5g@public.gmane.org a 
> écrit :
>> W dniu 2024-04-14 22:22, Christophe JAILLET napisał(a):
>>> Le 14/04/2024 à 17:22, David Wronek a écrit :
>>>> Add support for the 2560x1600@90Hz OLED panel by EDO bundled with a
>>>> Raydium RM69380 controller, as found on the Lenovo Xiaoxin Pad Pro 
>>>> 2021.
>>>> 
>>>> Signed-off-by: David Wronek 
>>>> <david-vu3DzTD92ROXwddmVfQv5g-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>
>>>> ---
>>>>   drivers/gpu/drm/panel/Kconfig                 |  14 +
>>>>   drivers/gpu/drm/panel/Makefile                |   1 +
>>>>   drivers/gpu/drm/panel/panel-raydium-rm69380.c | 378 
>>>> ++++++++++++++++++++++++++
>>>>   3 files changed, 393 insertions(+)
>>>> 
>>>> diff --git a/drivers/gpu/drm/panel/Kconfig 
>>>> b/drivers/gpu/drm/panel/Kconfig
>>>> index 154f5bf82980..84cbd838f57e 100644
>>>> --- a/drivers/gpu/drm/panel/Kconfig
>>>> +++ b/drivers/gpu/drm/panel/Kconfig
>>>> @@ -542,6 +542,20 @@ config DRM_PANEL_RAYDIUM_RM692E5
>>>>         Say Y here if you want to enable support for Raydium 
>>>> RM692E5-based
>>>>         display panels, such as the one found in the Fairphone 5 
>>>> smartphone.
>>>>   +config DRM_PANEL_RAYDIUM_RM69380
>>>> +    tristate "Raydium RM69380-based DSI panel"
>>>> +    depends on BACKLIGHT_CLASS_DEVICE
>>>> +    depends on DRM_DISPLAY_DP_HELPER
>>>> +    depends on DRM_DISPLAY_HELPER
>>>> +    depends on DRM_MIPI_DSI
>>>> +    depends on OF
>>>> +    help
>>>> +      Say Y here if you want to enable support for Raydium 
>>>> RM69380-based
>>>> +      display panels.
>>>> +
>>>> +      This panel controller can be found in the Lenovo Xiaoxin Pad 
>>>> Pro 2021
>>>> +      in combiantion with an EDO OLED panel.
>>> 
>>> combination?
>>> 
>> 
>> Yes, this is just one of the examples where this driver IC can be 
>> found. It can also be used with panels other than those from EDO.
> 
> Hi, sorry if i was unclear.
> 
> Is there a typo: s/combiantion/combination/ ?
> 
> CJ
> 

Ah, now I get it. Yes, that is indeed a typo. Thanks for pointing this 
out.

>> 
>>>> +
>>>>   config DRM_PANEL_RONBO_RB070D30
>>>>       tristate "Ronbo Electronics RB070D30 panel"
>>>>       depends on OF
>> 
>> Best regards,
>> David Wronek <david-vu3DzTD92ROXwddmVfQv5g@public.gmane.org>
>> 
>> 

-- 
Best regards,
David Wronek <david@mainlining.org>

