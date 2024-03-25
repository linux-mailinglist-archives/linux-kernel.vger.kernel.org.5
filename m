Return-Path: <linux-kernel+bounces-118060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3237788B63B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B45BB444F9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CC66FE11;
	Mon, 25 Mar 2024 21:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYIdts/I"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343A06EB6A;
	Mon, 25 Mar 2024 21:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711403344; cv=none; b=URieejPEAv5oZV/di6DSjS6Zd/9EySgnIiYrp7NpD/kqObGmZzloWUhYsDs/cPl3eZ2oJh2EmOy5f9rrtcGXdkCR/rbKdwGXMQXYzn026pwzY6Y6MFkJ2mpPVVPxwed8DiI5RA5Zz0nwptTw4/nULQIuwc45eMX0wKacNfW/8R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711403344; c=relaxed/simple;
	bh=v34Hl2d2E4vR+PopgFPmlL1rrpBU/J/HWmTPc8VwUYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQ+OD0F/r1cU9hf9eU0JNqKv8yeKOUIlkD9dJ5cx78r9BrBP7Dw1XxA21KvZCp6JK0nIOGTP9iMulrqUEo7XSoHhHh722xt12RyePoxQd6RDa6zUvPaWsrwdBRcVnzg+nB/+0dLUK65WJtdZjKBwEnDZV2DV+pR9QrTdl4Xl2Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYIdts/I; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56b0af675deso5987099a12.1;
        Mon, 25 Mar 2024 14:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711403340; x=1712008140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qUM4vmKmjA1gYO0tbm7KTA4LmIiK39ngypqIHIOvMUY=;
        b=kYIdts/IIOJ+5D+ZFUyt/S3BRrk695DSNkqdQcfjbDk2+am8Uqgayhc+Yzzh90Nzwg
         o3dEL+Id7Zv95s4lS4sLEbixmLNDPTMDPiImN3azc5sEhxnJDwoJZZiSfjN8+rPwbQNF
         b0CBjtqticSD5MIIWpGo7r1mFX0+KXRqxX4m/fajkel3SpCEo+NpKYjleSAZT8TCJwyR
         SO2WZ2OEw8IpDCKMRJf88+fgzudaZq487g+hmHz+0QMGwTf1QGWTULyj//UJjHk6eA2o
         5C9ySS0tgXC+Jvyu8oM/I6YRcXCZTiXBuWYr8z45iEbrRZjh77M3EJqz2qFH4jzxKHDN
         uvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711403340; x=1712008140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUM4vmKmjA1gYO0tbm7KTA4LmIiK39ngypqIHIOvMUY=;
        b=M5CtCR2tJjWHfD+kiYJC+5A0ooo8943xC+vRF9yj95fdcwJNuFnTfZ6ZdKVm6l2dxK
         2mHY2iBNxLN/m+0nS3W7e8UJAMUabJDxyEZ4beUcBZ/HTUOl9SpeYGO2YAFwB/j5mEct
         ckva+bQauIXHqeO5ufhMgFyPvrQY0VL/ydwTf13erqHGUgPV4KOZmkxgyBWIl1YL8mqN
         mRAev6Lp7CC3bwhxctg3MuASvxw25jSKJnSqmKiYQn/mikFCwvjlvcwfrXkYTTgutNSR
         b8NUnJ3KMkRkK7ccWQbZZV28DjAyTyb9PkJogrcqWrX1PcZCPu2OrGTe99jPdUDiOJct
         zsXA==
X-Forwarded-Encrypted: i=1; AJvYcCV7MiYdV2NQ8ixf/4gMGF4pwLS6JhJde6WP5ON5l5aHy+RL1icFPkrwHiKyTVjBpTiWfTUurcCrQ+R91G5/3eEIwqU3MG/WZ0PFYIBOyxZzXrMN3MZmM0DfUVMEp+nunzQOTH/w9pWkVaClLEckerua2qjGJxuKASKaxrslK3/x3uQQ
X-Gm-Message-State: AOJu0YxPDPzmGKYDrIgH0dRpGcsDO1FyfhXGkvBclxIpnufzmuhZ9NhJ
	861MvArhqDssp8uuro6XNhbg+DcAmhW7TJqAtlnNGYrQy6y8nSj6
X-Google-Smtp-Source: AGHT+IGqzF3fHuQAIWMVhReRKPOloiG3GIJOv/fRY7SrojJhBUXyuiPBtXLwZklMVo7FZ83sKnItLQ==
X-Received: by 2002:a50:d685:0:b0:56b:83ff:e044 with SMTP id r5-20020a50d685000000b0056b83ffe044mr5778673edi.1.1711403340182;
        Mon, 25 Mar 2024 14:49:00 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-49-82.cust.vodafonedsl.it. [188.217.49.82])
        by smtp.gmail.com with ESMTPSA id c13-20020a056402100d00b00568abb329a3sm3403484edu.88.2024.03.25.14.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 14:48:59 -0700 (PDT)
Date: Mon, 25 Mar 2024 22:48:56 +0100
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: Adam Ford <aford173@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, marex@denx.de,
	alexander.stein@ew.tq-group.com, frieder.schrempf@kontron.de,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Liu Ying <victor.liu@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH V8 00/12] soc: imx8mp: Add support for HDMI
Message-ID: <ZgHxSHDAt7ytqDC1@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20240203165307.7806-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203165307.7806-1-aford173@gmail.com>

Hi Adam, Lucas,
Thanks for this series.

This series make HDMI work on evk.
All is working properly on my side.

Tested on: Linux imx8mp-lpddr4-evk 6.9.0-rc1.
Hope this help.

Tested-by: Tommaso Merciai <tomm.merciai@gmail.com>

Thanks & Regards,
Tommaso

On Sat, Feb 03, 2024 at 10:52:40AM -0600, Adam Ford wrote:
> The i.MX8M Plus has an HDMI controller, but it depends on two
> other systems, the Parallel Video Interface (PVI) and the
> HDMI PHY from Samsung. The LCDIF controller generates the display
> and routes it to the PVI which converts passes the parallel video
> to the HDMI bridge.  The HDMI system has a corresponding power
> domain controller whose driver was partially written, but the
> device tree for it was never applied, so some changes to the
> power domain should be harmless because they've not really been
> used yet.
> 
> This series is adapted from multiple series from Lucas Stach with
> edits and suggestions from feedback from various series, but it
> since it's difficult to use and test them independently,
> I merged them into on unified series.  The version history is a
> bit ambiguous since different components were submitted at different
> times and had different amount of retries.  In an effort to merge them
> I used the highest version attempt.
> 
> Adam Ford (3):
>   dt-bindings: soc: imx: add missing clock and power-domains to
>     imx8mp-hdmi-blk-ctrl
>   pmdomain: imx8mp-blk-ctrl: imx8mp_blk: Add fdcc clock to hdmimix
>     domain
>   arm64: defconfig: Enable DRM_IMX8MP_DW_HDMI_BRIDGE as module
> 
> Lucas Stach (9):
>   dt-bindings: phy: add binding for the i.MX8MP HDMI PHY
>   phy: freescale: add Samsung HDMI PHY
>   arm64: dts: imx8mp: add HDMI power-domains
>   arm64: dts: imx8mp: add HDMI irqsteer
>   dt-bindings: display: imx: add binding for i.MX8MP HDMI PVI
>   drm/bridge: imx: add driver for HDMI TX Parallel Video Interface
>   dt-bindings: display: imx: add binding for i.MX8MP HDMI TX
>   drm/bridge: imx: add bridge wrapper driver for i.MX8MP DWC HDMI
>   arm64: dts: imx8mp: add HDMI display pipeline
> 
>  .../display/bridge/fsl,imx8mp-hdmi-tx.yaml    |  102 ++
>  .../display/imx/fsl,imx8mp-hdmi-pvi.yaml      |   84 ++
>  .../bindings/phy/fsl,imx8mp-hdmi-phy.yaml     |   62 +
>  .../soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml     |   22 +-
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  145 +++
>  arch/arm64/configs/defconfig                  |    1 +
>  drivers/gpu/drm/bridge/imx/Kconfig            |   18 +
>  drivers/gpu/drm/bridge/imx/Makefile           |    2 +
>  drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c  |  207 ++++
>  drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c   |  154 +++
>  drivers/phy/freescale/Kconfig                 |    6 +
>  drivers/phy/freescale/Makefile                |    1 +
>  drivers/phy/freescale/phy-fsl-samsung-hdmi.c  | 1075 +++++++++++++++++
>  drivers/pmdomain/imx/imx8mp-blk-ctrl.c        |   10 +-
>  14 files changed, 1876 insertions(+), 13 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/fsl,imx8mp-hdmi-tx.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8mp-hdmi-pvi.yaml
>  create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8mp-hdmi-phy.yaml
>  create mode 100644 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
>  create mode 100644 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
>  create mode 100644 drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> 
> -- 
> 2.43.0
> 
> 

