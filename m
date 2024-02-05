Return-Path: <linux-kernel+bounces-52669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CE3849B3B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDD731F273C8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D067B2C6A4;
	Mon,  5 Feb 2024 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jhJ8oTpe"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6197D2E635;
	Mon,  5 Feb 2024 12:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137800; cv=none; b=ILZfvPEObcOnCcKU143kLmxo3OwkPyzGbQpc6YNXLduJ4lriNIQIUlaCIA20JmGNqH630GOW8evYC4BdATvYm6Kpx9rCaa5TP+gGZKVl/Mp0Hh5Llm9liEnC3uQKvO/mJ/fNhIBEEtPJFyhFsAGsAfPkamVSj2o5ofp8aY3TPhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137800; c=relaxed/simple;
	bh=lSuPX0mNqwFU6zNkfMxkdvbdFd4yWz3j9e89k4x3+Xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Wx/tlCvBAI2gAv7rGilOO687R6Nzh01Qxc+D1eIBDBKdTXqsmeamaRjtEO3DI9uYT2WVmRA903BEtjVVcrgvVPPBFXITFnCitumVxcwHVX6moL4sKpMCEY+tN8rZcyORotH5bAZwWo8PAnIgc1K3wu+k1QGatiTKp/qtBMXagnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jhJ8oTpe; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707137798; x=1738673798;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=lSuPX0mNqwFU6zNkfMxkdvbdFd4yWz3j9e89k4x3+Xw=;
  b=jhJ8oTpel8qS7pyJnoBksYRGwi0BS3mKGD6OCnBdUwyJ7OuXWsstGriv
   5fuIbBXpB6PMc9swQpGS2eGoj8HXt6yMQ52CCvo7fzw5Z8f5jIzLPRlsr
   4aht2dWSsK5VcV8N7c4pPYifa9BFBWfkuPbgP8dDgqNjpIO+G4ZDm/4Oe
   940IDADZSRGEUkeNptx6efLDin3YyF7Y4uhlovDj5h7Q9xZQpLRNzna+v
   A8wZwWuEugLfXOMHYE1+MlnfgSWIXODcYMT5tnKyXntQYbs+jWf/cD7ep
   MOlS+aROhdUBBEnWcuYumvCpvvJ7QmD4T511I3QUFnDnH0JPFMvAvDku8
   w==;
X-CSE-ConnectionGUID: vkCC3fSQQzSATfQ0PhcR1w==
X-CSE-MsgGUID: kIk9RWttQhaJv1roY+CkyQ==
X-IronPort-AV: E=Sophos;i="6.05,245,1701154800"; 
   d="scan'208";a="15768033"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Feb 2024 05:56:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 05:56:34 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 5 Feb 2024 05:56:29 -0700
Message-ID: <f67e7264-aeb7-4210-9d01-28c2c9eefe54@microchip.com>
Date: Mon, 5 Feb 2024 13:55:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux][PATCH v2 3/4] MAINTAINERS: add SAM9X7 SoC's LVDS
 controller
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
 <20240205110609.217022-4-dharma.b@microchip.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20240205110609.217022-4-dharma.b@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 05/02/2024 at 12:06, Dharma B - I70843 wrote:
> Add the newly added LVDS controller for the SAM9X7 SoC to the existing
> MAINTAINERS entry.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>

If new series is to be done, this entry should be placed before this one
"MICROCHIP SAMA5D2-COMPATIBLE ADC DRIVER"

Otherwise:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Regards,
   Nicolas


> ---
> Changelog
> v1 -> v2
> - No Changes.
> ---
>   MAINTAINERS | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a7c4cf8201e0..24a266d20df6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14230,6 +14230,14 @@ S:	Supported
>   F:	Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
>   F:	drivers/power/reset/at91-sama5d2_shdwc.c
>   
> +MICROCHIP SAM9x7-COMPATIBLE LVDS CONTROLLER
> +M:	Manikandan Muralidharan <manikandan.m@microchip.com>
> +M:	Dharma Balasubiramani <dharma.b@microchip.com>
> +L:	dri-devel@lists.freedesktop.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/display/bridge/microchip,sam9x7-lvds.yaml
> +F:	drivers/gpu/drm/bridge/microchip-lvds.c
> +
>   MICROCHIP SOC DRIVERS
>   M:	Conor Dooley <conor@kernel.org>
>   S:	Supported


