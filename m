Return-Path: <linux-kernel+bounces-144546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BEA8A479E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8201C20F1F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 05:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FA46125;
	Mon, 15 Apr 2024 05:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="tEkTfund"
Received: from mail.mainlining.org (mainlining.org [94.241.141.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF7328F5;
	Mon, 15 Apr 2024 05:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.241.141.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713159429; cv=none; b=S69UDQPgBcP4uEsAzBhvnid/IzPKEr+7AtgjVQl84JagKOJgg8mB4LcetKBnERgyhiyi5lMOp42YBlKFxo1MxFD1Ade2pm/tFiOXld7W4GEdsZg7YXj+Zas460fHFbx1iwb8fEZg6K4h8Rhveuk5UQbdViouwPQOEg1hqE00aSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713159429; c=relaxed/simple;
	bh=aXvS0yWlwJ12TqixZZEyDBq8aMauFTeamtAcebGj+3s=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=LCzfdLW74bBUNG16IdF4A2ZhArZVfqSD3f+lVF3gvnhp/fUJt8xQR1B793i1eO3PZNS/4tBpvnBk9E/cALKFJJeLNZYCOq9yf5Z1x9a+Z8akETnYGD9OyuX3Rs33pGBqH6smNEWkV2/98NHKUHbCizolr9etvIlZ1u9CtWkSyPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=tEkTfund; arc=none smtp.client-ip=94.241.141.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from localhost (docker-mailserver-web-1.docker-mailserver_default [172.18.0.7])
	by mail.mainlining.org (Postfix) with ESMTPSA id EB9A1E203B;
	Mon, 15 Apr 2024 05:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1713159423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h7W3LbTdue4pSYiwFamrqkStaJfMW6q25cCT+vst61s=;
	b=tEkTfund5YDbUgpUAoub7p15puwDZJOfiQb+OQ6sf8BKo95YGNJ9IMXL311zprn+s5CnKe
	nBZEGphrKP8w+Aqz2BlQQtm0w/qfAo/1R0kNLqIx63Wnzz7PjqUprovX75Dk55ax8RSdGS
	vWnaSrseaghF7O6PnXptFFFXEdnye8gbJ8mLkxfAPiQz3VKAFdP+qGz3FYuOgJdcNc4oVP
	aG+mS84Xtgmp5VZMzPV/TbPRIdUAUI0zMhIY+mXlFBxGKVsT8sax9F7EvAGEtaZo7Aku9C
	ThvvdA11LL6wQBr4UcjBd+CkI9P8byPJhoswaURD9cTnsINzP2Bfox+y6tltEQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 15 Apr 2024 07:37:02 +0200
From: david@mainlining.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: airlied@gmail.com, conor+dt@kernel.org, daniel@ffwll.ch,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 konradybcio@kernel.org, krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, marijn.suijten@somainline.org,
 mripard@kernel.org, neil.armstrong@linaro.org, quic_jesszhan@quicinc.com,
 robh@kernel.org, sam@ravnborg.org, tzimmermann@suse.de,
 ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 2/2] drm/panel: Add driver for EDO RM69380 OLED panel
In-Reply-To: <d0db78dd-c915-41f3-b1be-b30a0266741d@wanadoo.fr>
References: <20240414-raydium-rm69380-driver-v1-0-5e86ba2490b5@mainlining.org>
 <20240414-raydium-rm69380-driver-v1-2-5e86ba2490b5@mainlining.org>
 <d0db78dd-c915-41f3-b1be-b30a0266741d@wanadoo.fr>
Message-ID: <7529f14b292c7173d4a60a7dca8af92b@mainlining.org>
X-Sender: david@mainlining.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

W dniu 2024-04-14 22:22, Christophe JAILLET napisał(a):
> Le 14/04/2024 à 17:22, David Wronek a écrit :
>> Add support for the 2560x1600@90Hz OLED panel by EDO bundled with a
>> Raydium RM69380 controller, as found on the Lenovo Xiaoxin Pad Pro 
>> 2021.
>> 
>> Signed-off-by: David Wronek 
>> <david-vu3DzTD92ROXwddmVfQv5g@public.gmane.org>
>> ---
>>   drivers/gpu/drm/panel/Kconfig                 |  14 +
>>   drivers/gpu/drm/panel/Makefile                |   1 +
>>   drivers/gpu/drm/panel/panel-raydium-rm69380.c | 378 
>> ++++++++++++++++++++++++++
>>   3 files changed, 393 insertions(+)
>> 
>> diff --git a/drivers/gpu/drm/panel/Kconfig 
>> b/drivers/gpu/drm/panel/Kconfig
>> index 154f5bf82980..84cbd838f57e 100644
>> --- a/drivers/gpu/drm/panel/Kconfig
>> +++ b/drivers/gpu/drm/panel/Kconfig
>> @@ -542,6 +542,20 @@ config DRM_PANEL_RAYDIUM_RM692E5
>>   	  Say Y here if you want to enable support for Raydium 
>> RM692E5-based
>>   	  display panels, such as the one found in the Fairphone 5 
>> smartphone.
>>   +config DRM_PANEL_RAYDIUM_RM69380
>> +	tristate "Raydium RM69380-based DSI panel"
>> +	depends on BACKLIGHT_CLASS_DEVICE
>> +	depends on DRM_DISPLAY_DP_HELPER
>> +	depends on DRM_DISPLAY_HELPER
>> +	depends on DRM_MIPI_DSI
>> +	depends on OF
>> +	help
>> +	  Say Y here if you want to enable support for Raydium RM69380-based
>> +	  display panels.
>> +
>> +	  This panel controller can be found in the Lenovo Xiaoxin Pad Pro 
>> 2021
>> +	  in combiantion with an EDO OLED panel.
> 
> combination?
> 

Yes, this is just one of the examples where this driver IC can be found. 
It can also be used with panels other than those from EDO.

>> +
>>   config DRM_PANEL_RONBO_RB070D30
>>   	tristate "Ronbo Electronics RB070D30 panel"
>>   	depends on OF

Best regards,
David Wronek <david@mainlining.org>

