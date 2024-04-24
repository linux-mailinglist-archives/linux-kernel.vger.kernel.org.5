Return-Path: <linux-kernel+bounces-156343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B54138B0190
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0B881C21B28
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2BF156C61;
	Wed, 24 Apr 2024 06:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVrgq/H5"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7433A15687B;
	Wed, 24 Apr 2024 06:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713939016; cv=none; b=ATupNJeMKfS1syXd3ONnPX9vk2cawpika2hVbfUvKxzCUpYIxybvy8iICqamXBW8dp/82lUDs0/f+L8la2btq2UTnouOmIbG6Sy2bHyQ+kPlyEPiSkJpfeohVeGmzEFe+KjkHuPI0WzkZWP+Hhk5sCLpYh0tYb1JrlVqr3D8C/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713939016; c=relaxed/simple;
	bh=spACtKyCxDu9sb7L5eQSroWOYRxhtjHU/Rf9P9IGhHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6578IpFbgW+IBek+fUva94vg+9rCyCnJ1yqdKUsrss/D5n5Z7ABumHbjsaQlASpi1g3m0UQN5jj4sD9hfnYx2CX5M6jHl0CdA8yon5gPp5s9fSHa47KnxCBPFJGNQ/8xGzvJS+FMCECZs8WL8QDhIzkQLjxWVFDU1R6MBcNjYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVrgq/H5; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-de4654c3423so908514276.0;
        Tue, 23 Apr 2024 23:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713939013; x=1714543813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CQD62Ewa/Pm8/wvoE00gVyYTVUY/vDTMKiupQNjrTRQ=;
        b=VVrgq/H5slxrTDD9y1tqk9B6/Vw5XCsusz3eX+mQOXROIDr9dBZbpMYHbmbUIrfAKB
         YRoliZS9CQsALBQR7eaHutpVAtW4y97mL8LNgOAHXooWAbQ6Az5J7871nyg+6P4DQoVJ
         +z60S7WpuvJkX/6LY4/oIsATNyh6YqoZcSg5GJoaF2ikG9nhkAePb35iZCwNly0/ll2i
         KQ5SwuMPXKycFqoi1kDn/NrhUaxeOG0EEnj87lsoIg7JZ/dls2nvgp5zrvzjSLO/peSN
         HNtIGffZOPh12XYmdayMexLSqdN7dprOEQ+UfaSixLtrUtEMcfLzrSXdAcrjAPkJXucK
         ghuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713939013; x=1714543813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQD62Ewa/Pm8/wvoE00gVyYTVUY/vDTMKiupQNjrTRQ=;
        b=tEdktRGTGRHi5sFTiw7vraIg3L0IokFoNmBiPzx3IJVY+BFaYUYPx5WqguRSjgNlLm
         joEMuZCPur3bZQEFYRs9FFEXT9gC2Oh1y6YpvKp29K2R/iSnFWCaKzmpbVIvXsa7Ztfd
         uwwKl79dArucph2cHhiXTj6miaRAsKhTj0nXtCOIgqD/Z323H93acGP9JhD5X5aq0Kff
         V492OiKUzY/CTTBxBdPva+TYfy7BG8A1DhOFVX/xym6MBmKTBkcqgohKUit06WDHSYPL
         5woNdRRI1LztUPtJAIHwskh+duxyG6ydQiAd6ccME5C6EOtTlttdaisJ1XIz9Bsni1VI
         KMMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+vxAB79HqSPjQwYbmuQzVGX7T5J+qzcQB5Yr4H8QRbYx7Hj0x8gpWnYhf7RnPnMSoZNC6CGb9uBugWvjnBVgMtTHcEKe9BU7Hb2Ds+CnxzKG79HPNg/+WaLuqwej0+z2E3a2U
X-Gm-Message-State: AOJu0YwpsMTUfjXCEnqvQmVVDHwLiT6D/aAbzh76j395ss+nX50p+vxZ
	2lDnMYbjNFH7zuX4fTTGSAPeSyux/8iaSVgIu+YC99dPSf2vwjrI
X-Google-Smtp-Source: AGHT+IEaOALM/yuZxT0gddoKfUFAo2OImPPHSqyQT2w2gYutI2hgjCyWDDRGbA+qwsEQlonnW4QUSA==
X-Received: by 2002:a0d:f385:0:b0:618:55bf:d023 with SMTP id c127-20020a0df385000000b0061855bfd023mr1127114ywf.5.1713939013421;
        Tue, 23 Apr 2024 23:10:13 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id dg13-20020a05690c0fcd00b0061b0f6d3e4esm2802120ywb.128.2024.04.23.23.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 23:10:12 -0700 (PDT)
Date: Tue, 23 Apr 2024 23:10:09 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Russell King <linux@armlinux.org.uk>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next v1 2/4] net: phy: micrel: lan8841: set default
 PTP latency values
Message-ID: <ZiiiQY9Z5-uyGZxR@hoboy.vegasvil.org>
References: <20240417164316.1755299-1-o.rempel@pengutronix.de>
 <20240417164316.1755299-3-o.rempel@pengutronix.de>
 <c8e3f5d0-832b-4ab1-a65f-52f983ff110a@lunn.ch>
 <ZiAtREiqPuvXkB4S@pengutronix.de>
 <b44a4aee-f76f-4472-9b5c-343a09ed0d33@lunn.ch>
 <ZiITWEZgTx9aPqIy@hoboy.vegasvil.org>
 <ZideTxpOcPTbR9yt@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZideTxpOcPTbR9yt@pengutronix.de>

On Tue, Apr 23, 2024 at 09:07:59AM +0200, Oleksij Rempel wrote:

> Are the recommended FOSS projects managing calibration values per-
> linkmode/port/device in user space?

No, I haven't seen this.  I think the vendors should provide the
numbers, like in the data sheet.  This is more useful and flexible
than letting vendors hard code the numbers into the source code of
device drivers.
 
> What is recommended way for calibration? Using some recommended device?

You can try the "Calibration procedures" in IEEE 1588-2019, Annex N.

Or if you have end to end PPS outputs (from the GM server and the
client) then you can simply compare them with an oscilloscope and
correct any static offset with the ptp4l "delayAsymmetry"
configuration option.

Or if you have auxiliary event inputs on both server and client, feed
a pulse generator into both, compare time stamps, etc.

Also linuxptp supports Meinberg's NetSync Monitor method.

Also there are commercial vendors that rent/sell test equipment for
PTP networks.

So there are many possibilities.

HTH,
Richard



