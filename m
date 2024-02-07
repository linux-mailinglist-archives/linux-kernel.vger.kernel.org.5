Return-Path: <linux-kernel+bounces-56638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDEB84CD12
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D111F23988
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FD27F7C7;
	Wed,  7 Feb 2024 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ByAuNcuj"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE4D7E77C;
	Wed,  7 Feb 2024 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316961; cv=none; b=E0jC0JARdYGpkkLuVOW9g/gLJk4hNehPDUbBv8MBEOaMo6M/tjweYgEITidyUz1q1k4yjbn3QOnA0i8VGGUC/UwBcC2t+dwcHUXUd8NjfvRTaBmgtjh/Q9j89jT6PO6m71270DZj1JxSsj7JgF3TPGgbJU3fjO15uZeXwEvv8+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316961; c=relaxed/simple;
	bh=lgwC+nQacpQt17RsMVSyGHUSSBjw2SwJRYu3FKz012I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rm89eAQS4ndnf72Swe8/McxlPJju2WgtCsR/2Na9IWw2gajlYG99KhDNHjWTLifTVuZVYjOnQOt9GxWiqhCg32FeTwhGfZJQwYplsc4nqgPYHMaOKKpXWdMdbf+aHd+h4Iiz4G1wPXmzvbZ21Un4fz+G+7VT45+YTHuBEkUaz5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ByAuNcuj; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707316958;
	bh=lgwC+nQacpQt17RsMVSyGHUSSBjw2SwJRYu3FKz012I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ByAuNcuj3mlohoOnzvl7BmdLkgeOwehNmhTKZVdeqQBeznicf4Zw/sVSNXOThDjBM
	 zcN654bub8cEGpt1kCxTHDioCOR5AnYbxSEwVPv0akvQXtpAs7DcI4CCgFDt6aRQNF
	 l7UUtrqbUtH+470b0VC/OBbmtVrQbIJswD6ouu7A4Qo/RxWwEc+UkdHFoHAshLZ2yo
	 BR25qkuB1WJSz4lsFxjwUZ9YJL0/hCvJMlK2jiOLaqnt+K2TW9+A7OQbMqj60XNs/Y
	 l3NiXMG3YrupnomL5/2KEjMYhX3oNrp3BDiVaRptVsVTBvwYpgVbT2VUCOIORKO2v+
	 P5d7mSnz85pTA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 368913782059;
	Wed,  7 Feb 2024 14:42:36 +0000 (UTC)
Message-ID: <420ee120-2962-4848-b76f-b32ed70e70b0@collabora.com>
Date: Wed, 7 Feb 2024 15:42:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] media: dt-bindings: i2c: add GalaxyCore GC08A3
 image sensor
Content-Language: en-US
To: Zhi Mao <zhi.mao@mediatek.com>, mchehab@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, sakari.ailus@linux.intel.com
Cc: laurent.pinchart@ideasonboard.com, shengnan.wang@mediatek.com,
 yaya.chang@mediatek.com, 10572168@qq.com,
 Project_Global_Chrome_Upstream_Group@mediatek.com, yunkec@chromium.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com, jacopo.mondi@ideasonboard.com,
 hverkuil-cisco@xs4all.nl, heiko@sntech.de, jernej.skrabec@gmail.com,
 macromorgan@hotmail.com, linus.walleij@linaro.org, hdegoede@redhat.com,
 tomi.valkeinen@ideasonboard.com, gerald.loacker@wolfvision.net,
 andy.shevchenko@gmail.com, bingbu.cao@intel.com,
 dan.scally@ideasonboard.com, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240204061538.2105-1-zhi.mao@mediatek.com>
 <20240204061538.2105-2-zhi.mao@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240204061538.2105-2-zhi.mao@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/02/24 07:15, Zhi Mao ha scritto:
> Add YAML device tree binding for GC08A3 CMOS image sensor,
> and the relevant MAINTAINERS entries.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



