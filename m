Return-Path: <linux-kernel+bounces-52661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8698A849B25
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4344E283DBF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235D7405FF;
	Mon,  5 Feb 2024 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GHPlFK0r"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEDE405EB;
	Mon,  5 Feb 2024 12:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137501; cv=none; b=BuhoWQIUzDegj9QSAO1CQc+I9mc4xXaWzxkrhjwGfTxHSZG5GGPnsj+GxwWrJCHw4FORYbYQpIYMrwIbzUSdqYzP3vUpMqBdszziflZ3UE61l1chU1h9PAHlR4K51ExfvkzgdyLs6rejubF3nS8w/CnsSdx6a3WqPrb+V5zOwTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137501; c=relaxed/simple;
	bh=bP9ZnCfCpTt/rbFHJ4W2dlbUkjm0HFaJsGuoyQtjz0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CzTuh00L8WNeh//SmUmbJN5F3lQfs/SP57i8t3fyTs4OV7tZ0G5jRdhk9AT64KUANJe4Sw2zazmn4vsHiIefq6EsWJfk/mn//m2s85FLZ5KSmxXTr/AOEgw8Aj5Y0+zCBHwG0FAT4DzOpV+I/GX5xh//qaEkijjuMWmolnfvZuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GHPlFK0r; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707137499; x=1738673499;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=bP9ZnCfCpTt/rbFHJ4W2dlbUkjm0HFaJsGuoyQtjz0k=;
  b=GHPlFK0rqwEFpSVBOSd4fBmetFOFqx2qNpi1FT/CBr+CHHXjhFx50dzH
   izl9TL97W3fyKG3kdTCJE+E6HmdloPk2GdY0TFr0qQ6m/IQq5RZPQKUC5
   LD9IKGAb5dLiFKK0qoHAu/vlAqhG4diZwh1YHJxpOGkVzCKt2HZvocHrF
   X3NZttAxobXOH3Loo1eIzElGaKsXYry2nKhF3AiwEMW/zL9y+hDF6QF0T
   yfAI6Ygidog5QrJSs4scheJ7xgYwcwsJ9RRTxldeVQGUtv3hgEV13xXaO
   Rqs10h+k9LN1pDMhYy12RI9UMXMc1g5I8vujsFkf40bqBBbY+RQNWjnmv
   A==;
X-CSE-ConnectionGUID: +9XfpNPRTg+UlDr0fHTZpQ==
X-CSE-MsgGUID: q0fQlXMbT3mAJDCiZ/C8Ew==
X-IronPort-AV: E=Sophos;i="6.05,245,1701154800"; 
   d="scan'208";a="17127417"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Feb 2024 05:51:37 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 05:51:24 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 5 Feb 2024 05:51:19 -0700
Message-ID: <8b43b2b9-e77c-479f-9ed8-58554f372d06@microchip.com>
Date: Mon, 5 Feb 2024 13:50:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux][PATCH v2 4/4] ARM: configs: at91: Enable LVDS serializer
 support
Content-Language: en-US, fr-FR
To: Dharma Balasubiramani <dharma.b@microchip.com>, <andrzej.hajda@intel.com>,
	<neil.armstrong@linaro.org>, <rfoss@kernel.org>,
	<Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <dri-devel@lists.freedesktop.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux@armlinux.org.uk>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <geert+renesas@glider.be>, <arnd@arndb.de>,
	<hari.prasathge@microchip.com>, <Jason@zx2c4.com>, <rientjes@google.com>,
	<rdunlap@infradead.org>, <vbabka@suse.cz>, <manikandan.m@microchip.com>
References: <20240205110609.217022-1-dharma.b@microchip.com>
 <20240205110609.217022-5-dharma.b@microchip.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20240205110609.217022-5-dharma.b@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 05/02/2024 at 12:06, Dharma B - I70843 wrote:
> Enable LVDS serializer support for display pipeline.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> Acked-by: Hari Prasath Gujulan Elango <hari.prasathge@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   arch/arm/configs/at91_dt_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
> index 71b5acc78187..6a7714beb099 100644
> --- a/arch/arm/configs/at91_dt_defconfig
> +++ b/arch/arm/configs/at91_dt_defconfig
> @@ -143,6 +143,7 @@ CONFIG_VIDEO_OV2640=m
>   CONFIG_VIDEO_OV7740=m
>   CONFIG_DRM=y
>   CONFIG_DRM_ATMEL_HLCDC=y
> +CONFIG_DRM_MICROCHIP_LVDS_SERIALIZER=y
>   CONFIG_DRM_PANEL_SIMPLE=y
>   CONFIG_DRM_PANEL_EDP=y
>   CONFIG_FB_ATMEL=y


