Return-Path: <linux-kernel+bounces-118622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB94588BD61
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EAA92C306D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B93481BA;
	Tue, 26 Mar 2024 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddWie6LM"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F118912B82;
	Tue, 26 Mar 2024 09:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444446; cv=none; b=rdmeWM9+3fXAPPnATwNZZXfwZt5+CnHK1IzYKuS1qBPI/vCdhytt4DTqi+6rEXrBhb8thBjqB4khMmbk1UdfJp0WEOpCzuJg3sQy6HQGRE4r/g6+U8crTaZqwHVcUDyifaZptSKJfLcEyl+U0Gj712yIHWD+xMEb9ZaeAmPBn6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444446; c=relaxed/simple;
	bh=ns+m5sBGOsc+xV6bVd6vI8caudqeY3gv11EbyVl+W0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lm/nSe4q8wuMEmV43G57ucWNH3YNNr15G3ueLpodI3t5DMsXkU+CKi23+RSqNHVM/BOTEllQLEeO1ov/nKvLSimjvgD7lef+7VZ8W8dSABR+03q2JSHbQL6cQrNvdVxQiVOONtStY9zHLBqbK7OrEh8P6naA/xHPUGtzqCKXVbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddWie6LM; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a467d8efe78so627543666b.3;
        Tue, 26 Mar 2024 02:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711444443; x=1712049243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dkZOXYkAE9iOGn5hAd1Ui45j7SFP54iM6pKPed3Bge4=;
        b=ddWie6LMHw4UmNgsLzv2sTPt6KkJRmR5m1XSwdmxWstsofwNDHJHdq+xcMR1seZmwp
         k5tAJ0TUP2o4pe057DUZ4zD5TcMGhJLjgrwJgbxf8y/NGI+6qM/GJTfwPj9ZMZKkEmyB
         8oaGTZB4CUknuZ6c1f2dlPhwOTRu9syR5oQb94UZpe4jwFlQafBXpNmFGIlhTTlpRKqV
         FA0bwyDIX+shn8nmkLukXm92X7CTyXf29NswgPtKtJ6AJ+dy+QikT0oljEBe80B8Z/Ut
         wUk7AFap3SkdelRYB18Z4flxZmlZCZ/hwFFAo9sGYX2ffvPPNGZjwNAA8Akkj3NDlxj4
         VQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711444443; x=1712049243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkZOXYkAE9iOGn5hAd1Ui45j7SFP54iM6pKPed3Bge4=;
        b=qu9j7jTk1UP3Xo6WsN+uDdAM0OqYs8xb3dUQSP3a52rf3YJH8KoGFhKTCeE+MVDTm5
         i31CplzFjDVvCBtW5HAuepNwjvR1DmTeEQvAWUCZQI1+NJMaeNYfawguONvUaw/cNpR9
         r+sALWaYnaJPaVfTzVmQhaxv5D2vJyUOzFGGemp3fcYxXs42Wfk3HAxCblcINZw/BRu2
         NiprEr+9ESn61KC+Un/d6cIcNhTScdnCD0G9+f2QVQJv9HM6hfBKwODczPJk3ZDCBPs1
         bIEeQsdDK1yhnoweu/aScHW+CrjPskOSQ3/MOPAN/2UU5ysERemYnWgqjWVOVGC+BSAU
         JVqw==
X-Forwarded-Encrypted: i=1; AJvYcCVIo+PCpNUAZg8G6DI/20iwhq8DZLyLmZiduZS0l3SMJ9/g31eYOEGrLQb3w24trZjSVbVF2iRc4y+lJWy66KIX50PLvtLCk6X/ZR0qrENSO4qNmP5CYpHvkPVOuTUSkgraFqVMnoW3tA==
X-Gm-Message-State: AOJu0YwG5NwYVwZ1T60sdoGJLD1+upt2XS7IrVD8V6M9v3F/mEiQgoU3
	SvcECUSGCXqCn8BUeYeL028mhkW31Jz4yMYAabBK8VgU7qMDicRZ1qfNZK6v5Q8=
X-Google-Smtp-Source: AGHT+IGr2s/mEz4UE0baOahUGNeF8qNja14tSi6th+awBG0zaVYu2NirebKexudRl4KswKxgvAQtwQ==
X-Received: by 2002:a17:906:3b02:b0:a47:38ba:d24a with SMTP id g2-20020a1709063b0200b00a4738bad24amr6299188ejf.18.1711444442910;
        Tue, 26 Mar 2024 02:14:02 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-49-82.cust.vodafonedsl.it. [188.217.49.82])
        by smtp.gmail.com with ESMTPSA id hy8-20020a1709068a6800b00a46c0191306sm3988446ejc.213.2024.03.26.02.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 02:14:02 -0700 (PDT)
Date: Tue, 26 Mar 2024 10:13:59 +0100
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: Adam Ford <aford173@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
	aford@beaconembedded.com, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Lucas Stach <l.stach@pengutronix.de>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 0/6] soc: imx8mp: Finish support for HDMI
Message-ID: <ZgKR18zbZKV9p8tP@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20240227220444.77566-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227220444.77566-1-aford173@gmail.com>

Hi Adam,

Thanks for your work.
For all the series:

Tested-by: Tommaso Merciai <tomm.merciai@gmail.com>

Regards,
Tommaso

On Tue, Feb 27, 2024 at 04:04:34PM -0600, Adam Ford wrote:
> The i.MX8M Plus has an HDMI controller, which depends on several
> other systems.  The Parallel Video Interface (PVI) and the
> HDMI-TX are already in the Linux-Next staging area 20240209, but
> the HDMI PHY driver and several device trees updates are still needed.
> 
> This series is adapted from multiple series from Lucas Stach with
> edits and suggestions from feedback from various attempts, but it
> since it's difficult to use and test them independently,
> I merged them into on unified series.  The version history is a
> bit ambiguous since different components were submitted at different
> times and had different amount of attempts.
> 
> The previous attempt I did used the wrong starting point for the PHY,
> so this update includes a newer starting point with tags from that version
> and fixes from various people's feedback.  I hope I caught them all, but
> I apologize if I missed something. Any tags from the previous attempt I
> made were intentionally dropped, because of the significant change,
> but I kept tags from the newer version I grabbed from patchwork.
> 
> Because several items from the last attempt were merged, this
> series is only focussed on adding the HDMI PHY driver, and enabling
> the power domain, irqsteer interrupt controller, and HDMI pipeline
> in the device tree. The version numbers are a bit strange since
> these all got pulled from various attempts with different versions,
> but I wanted to push them together as a series to complete the pending
> work.
> 
> This series restarted at V4 based on the version of the PHY driver and
> the other drivers and power-domain changes have been applied already.
> 
> V7:  Patch 5/7 marks the PVI driver disabled by default to prevent
>      EPROBE_DEFER errors.
> 
>      No other changes to other patches in the series
> 
> V6:  Make the PHY driver depend on COMMON_CLK to fix build errors
>      Make LCDIF3 disabled by default since it depends on hardware.
> 
> V5 primarily updates feedback from the PHY driver itself, but a small
>    adjustment was made to the register size in the device tree.
> Adam Ford (1):
>   arm64: defconfig: Enable DRM_IMX8MP_DW_HDMI_BRIDGE as module
> 
> 
> Adam Ford (1):
>   arm64: defconfig: Enable DRM_IMX8MP_DW_HDMI_BRIDGE as module
> 
> Lucas Stach (5):
>   dt-bindings: phy: add binding for the i.MX8MP HDMI PHY
>   phy: freescale: add Samsung HDMI PHY
>   arm64: dts: imx8mp: add HDMI power-domains
>   arm64: dts: imx8mp: add HDMI irqsteer
>   arm64: dts: imx8mp: add HDMI display pipeline
> 
>  .../bindings/phy/fsl,imx8mp-hdmi-phy.yaml     |  62 ++
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 147 ++++
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/phy/freescale/Kconfig                 |   6 +
>  drivers/phy/freescale/Makefile                |   1 +
>  drivers/phy/freescale/phy-fsl-samsung-hdmi.c  | 720 ++++++++++++++++++
>  6 files changed, 937 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8mp-hdmi-phy.yaml
>  create mode 100644 drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> 
> -- 
> 2.43.0
> 
> 

