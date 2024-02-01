Return-Path: <linux-kernel+bounces-47390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D18A9844D41
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1099F1C22DCE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326943B2AD;
	Wed, 31 Jan 2024 23:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLWnSFN4"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B183B18C;
	Wed, 31 Jan 2024 23:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706744601; cv=none; b=P21PpbdQ0ECSj9Jsmmw12e3UcAaXcv7n83kQVV+OHdBTEotI+OymQK+AnXKauWx5BmOewj6pqjXMrUqwHwVzBzkbYvlaQH5mAF1FME6mjwdxOs5+r00EUqPQQFR8ppjAp2bwfsRhPD4dx7DQQqCex7LfIkcB7TqbMhTHBvnX4XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706744601; c=relaxed/simple;
	bh=SewAFr4bPu+Lhyx/z6EWMEwTisOjNDlCx4omV1kFgNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWLKcJdU6n2Q7iOBynHmUmFEwlJTNPEsj4+/JVMA1T6Ijkf0j5EIrUySFaAtgK/PEmRIe0GWc6zrxysMeTIGQ3wFVIPCDhw05TlIcdHfBV18bHpVjweEYPyPYj53qfMcBWASlMtr3bF5W8JFs/u6+hlyr2eJweTSu3ChwgSY09k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLWnSFN4; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ddb1115e82so191462b3a.0;
        Wed, 31 Jan 2024 15:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706744599; x=1707349399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xxn4ihDOE6z0ST3ffWk22KtYMRkFrMur7Pj62WhcijA=;
        b=iLWnSFN4KxenjwC9txMAyy73R2ING+hRmCwygabu2dDXWy/kwKvVPOIjzpUK7aLw+9
         RBg+EllxKrqHOAuMbZdb8yftJ5wb1B+TdrQiH6rCdOOhOnk1NQHDh/jDAb8JcBJYINb+
         rsGMj6tBssOFRJLFLNTNolkoakqqavoWxfD0GnHYIbwd65jV1dnX7IraaFuaL96CQ1yB
         XHt+lMdp5HEsfCmUrA5FzN3L5eRtdQRFX1PFDmsqieMBzh/b01tU+4P/O/mq/i3PuOFG
         aEQkTPlyfh2cAFxHzFXuLmh6Pc66xUfwgvq/Pu9T0eze00ExxnkoWAybmLWSB0gpD++d
         NJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706744599; x=1707349399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxn4ihDOE6z0ST3ffWk22KtYMRkFrMur7Pj62WhcijA=;
        b=Yxz6a0SM2KzzDcdLKsXKB+DiWHvoEaUmJDjrii7DLnySm0RIMAqk18+IVo2hfNNqJT
         eB0UnvjrJ0z04PDw59yR1vCS95vve15IJfD7NFyvhhQ93/Dz3NLqEVq6wiGUiYWTsHwu
         r7K9CYlbyq5yC+37he8VxVYHfcfxu1MdILB4/RRRrmRk8bBqLzNuC+alH1qpwH7jOo5w
         mCJhVFkefQHa5ocggTTs2XoYAx/zs6pImFJ/4eoQURO8OwRTrKUnejDfLtFlhrBMgqoS
         LRBEiozKGIc0Mf4+DUK0rRE9OCok8Taoh6Qkp29w8mGEcIcb6nY6dl9/Yyh+d3QNXOeX
         7jhQ==
X-Gm-Message-State: AOJu0Ywoe75fRrQEU9jsmg6RfRD2hnsmqIEmFLDjRUGHcVxAN6TspxeC
	BesLgRMEi8duD2NC+BaJnMQfHEKkva4pn+2/RzHgbSTaeRoociwt
X-Google-Smtp-Source: AGHT+IG12ShFssnmDhowtvlRu/PeZj1bzh7IuwUwMPYLopCQUYz8u/YflVcMMRTR7jZ8L6FXUj7EUw==
X-Received: by 2002:a05:6a20:d48a:b0:19c:80af:2fa8 with SMTP id im10-20020a056a20d48a00b0019c80af2fa8mr3517618pzb.48.1706744599240;
        Wed, 31 Jan 2024 15:43:19 -0800 (PST)
Received: from dragon (173.242.119.193.16clouds.com. [173.242.119.193])
        by smtp.gmail.com with ESMTPSA id v19-20020a056a00149300b006ddb0b0ff0dsm5775406pfu.34.2024.01.31.15.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 15:43:18 -0800 (PST)
Date: Thu, 1 Feb 2024 15:42:10 +0800
From: Shawn Guo <shawn.gsc@gmail.com>
To: Frieder Schrempf <frieder@fris.de>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	NXP Linux Team <linux-imx@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v4 00/12] arm64: dts: imx8mm-kontron: DT updates
Message-ID: <20240201073833.GB463595@dragon>
References: <20240108084945.75356-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108084945.75356-1-frieder@fris.de>

On Mon, Jan 08, 2024 at 09:48:57AM +0100, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> This patchset contains several improvements and updates for the devicetrees
> for the i.MX8MM modules and boards by Kontron Electronics GmbH.
> 
> * Misc cleanups and small fixes
> * OSM-S i.MX8MM module refactoring and update to latest HW revision
> 
> Changes in v4:
> * Rebase to Shawn's imx/dt64 branch
> * Drop patches 1 and 2 (display support) as there are unresolved DTC warnings
>   and I am not sure how to resolve them at the moment.
> 
> Changes in v3:
> * Address Shawn's review comments for patch 1, 2 and 14 (thanks!)
> 
> Changes in v2:
> * Rework DSI mux GPIO logic to be compatible with overlay
> * Switch from 4 to 2 DSI lanes for LVDS bridge to fix non-working display
> 
> Frieder Schrempf (12):
>   arm64: dts: imx8mm-kontron: Disable pullups for I2C signals on OSM-S
>     i.MX8MM
>   arm64: dts: imx8mm-kontron: Disable pullups for I2C signals on SL/BL
>     i.MX8MM
>   arm64: dts: imx8mm-kontron: Disable pullups for onboard UART signals
>     on BL OSM-S board
>   arm64: dts: imx8mm-kontron: Disable pullups for onboard UART signals
>     on BL board
>   arm64: dts: imx8mm-kontron: Disable pull resistors for SD card signals
>     on BL OSM-S board
>   arm64: dts: imx8mm-kontron: Disable pull resistors for SD card signals
>     on BL board
>   arm64: dts: imx8mm-kontron: Fix interrupt for RTC on OSM-S i.MX8MM
>     module
>   arm64: dts: imx8mm-kontron: Fix OSM-S devicetrees to match latest
>     hardware
>   arm64: dts: imx8mm-kontron: Disable uneffective PUE bit in SDIO IOMUX
>   arm64: dts: imx8mm-kontron: Remove useless trickle-diode-disable from
>     RTC node
>   arm64: dts: imx8mm-kontron: Add I2C EEPROM on OSM-S Kontron i.MX8MM
>   arm64: dts: imx8mm-kontron: Refactor devicetree for OSM-S module and
>     board

Applied all, thanks!

