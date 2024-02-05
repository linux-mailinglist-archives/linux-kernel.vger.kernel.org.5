Return-Path: <linux-kernel+bounces-52359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D7184971B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2451C212C8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C660412E75;
	Mon,  5 Feb 2024 09:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TE429pwO"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C742B13AD8;
	Mon,  5 Feb 2024 09:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707126992; cv=none; b=jd6BPUoRBzEs1NFC5FymUpbs4R3ZszqwHJtMtD517eW6DcG2brvAGIlDPUmEIAQ1kypO3b6vnHo8LR3x7HXuk54TKVSO5N4PxlTiHbUHJtXnVsDY7wao2DuBKroZ9MdQRaWD7MS6nsF9AYsDDH/0oWHsTfoNsuejX0xDCSGSTIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707126992; c=relaxed/simple;
	bh=/wv9Rf93hbnFf6X+ri5DbCVOqUduDCDLA+jV3qDNS8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7LqUe7lmJQLHE3eAZPLDSVLMsWxssX3k6Amhrkz5josavFyT8RVTWA+tRhaU09dvRHxX5OZx+GSbf+NYK+ZPToqSiuaEnbl8vDPLUvXhD718267kL22SUuAISEQgX9prZpoedY4N0xjFUQ1v2vZwMGv2XVRhgRUjWHvlhyIOd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TE429pwO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d8ef977f1eso31039525ad.0;
        Mon, 05 Feb 2024 01:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707126990; x=1707731790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=znALwfGxdDn3x/LE27VGHxvTW226DUgCiFFeUoauvLA=;
        b=TE429pwO2rwmE0yWhqKpRmzrczb5fp2xV82f2cRaIGu/ogXVseCPatz6xhhJO4iWE0
         oy0ddkem5kH9FlQ/0uyXkgL+EEYzoFNIcnNhlha4ZQk2IKUkJXZjK53HLqr8XZf4Q1V3
         T+uuD5MkFtvVUGKDIA6tqUTObXmljuUI1W0XiAuWuFJVZSwc7KgCHZ1tjsGD6mKazWvE
         1+9b9c4pUZNKbZ7zADrM99BWewHBKNVX/C0RMYZar5GdTgRA8rpi4M0C9Gt9oENGHe1h
         utou8jc6RWgQHOo76yWNdmmbEmkOi6G2uFbnk0aGLj5RBub9y0bqUGpNlmMRzy4W/nsw
         EHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707126990; x=1707731790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znALwfGxdDn3x/LE27VGHxvTW226DUgCiFFeUoauvLA=;
        b=DA3SOyP0lG40gq1zCOx/vqZ6vhgwsEaSApvegASf8+K5rlea2D5QAf8yTk55ldkh2h
         D7D5hfdMbzKOva0IyyufpRL+l+BQesLzLLUPnWVuCq+sj0KLIxw2ScOUhODsneMO3PKc
         KvbjjsWiomB02pia0dAuq1931gXjCFKMWaoSAc1T9lTWJ0K43a5IiFT8HZBTfNN9h+sA
         RO3RlyCCylv8g19+aG6rOL64XOzFR8lFtKt/HHGiDs9ct3AJ+GmBjyM3TNKPfObcZtpy
         4zGbqWzwrplc+4SbH6jpjR2OVvaiF/BRXkorOnu90h/8ZLuz9Wn2aGsr3w7pR+hET83A
         q63w==
X-Gm-Message-State: AOJu0Yxisd10MFXCjo5telwkCNUE65Rghoif+FBkUQlPXJylOpblp4ew
	FFS6sWfpqVI5XdP7E9ObJnzK89T1Lg5dcK1q1cb9CP1bDT/tRTdr
X-Google-Smtp-Source: AGHT+IE6AxLTQd39G/QzUznMUdXV//XzdKzvgkMUmcM9pAc2NhW4sl1wSJNKkRJ4TN2uus5IXsKwow==
X-Received: by 2002:a17:903:11d0:b0:1d6:f1cb:7a95 with SMTP id q16-20020a17090311d000b001d6f1cb7a95mr16663864plh.57.1707126989871;
        Mon, 05 Feb 2024 01:56:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU5wnvszN9S/yYiGGCNkcX8Uj3Ay33T7zAog0dceJAu92SpkL7b/V0oPGDxhQw3rpoTMxonyC+eYTBVebOnGPD6ey/IeJt2HtES0NSYnn5MspMxWIG+dwrE33ZcpBT21TJmjX05IFQUTEJJV+sYfJWtC+Mzsw33pVus57yvWjd5qeWJeVP6+734KrSBgLzsv3B0zu64c133xMaziiby6pMESsGiRPLw58E2+Y3xSCioQdQh8bpCLeZGiVezlmtJpBMImMJYwWdbIvieKxWnugPUeybUuf2zrJdZ7DGVCGQn1ipi8v4GqkS7d2QMDkn19bXrv//RKtRY873yolTfa4F+GThlIrN2sCIe/bBiIIkeJsseNIDcRiO1RA2q+lyqqjnfSoInUGqu1a++llliIW8TjqSYHUH2GaYKEfJVeJB2Y9vyWXpdmk54aUDz1CBNc7WQ3p0QZhlJIKaifOWTTTGwZm1E8y35sL2UyF2xxzElg4DvdFk=
Received: from t480 (89.208.247.201.16clouds.com. [89.208.247.201])
        by smtp.gmail.com with ESMTPSA id ku12-20020a170903288c00b001d7284b9461sm5917081plb.128.2024.02.05.01.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:56:29 -0800 (PST)
Date: Mon, 5 Feb 2024 17:56:24 +0800
From: Shawn Guo <shawn.gsc@gmail.com>
To: Josua Mayer <josua@solid-run.com>
Cc: Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Jon Nettleton <jon@solid-run.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6qdl-hummingboard: Add rtc0 and rtc1
 aliases to fix hctosys
Message-ID: <ZcCwyKQ4KrtlCCkv@t480>
References: <20240118-imx6-hb-primary-rtc-v1-1-81b87935c557@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118-imx6-hb-primary-rtc-v1-1-81b87935c557@solid-run.com>

On Thu, Jan 18, 2024 at 04:01:10PM +0100, Josua Mayer wrote:
> HummingBoard has two RTCs, first integrated within SoC that can be used to
> wake up from sleep - and a second on the carrier board including back-up
> battery which is intended for keeping time during power-off.
> 
> Add aliases for both, ensuring that the battery-backed clock is primary
> rtc and used by default during boot for restoring system time.
> 
> Fixes keeping time across power-cycle observed on Debian,
> which sets RTC_HCTOSYS_DEVICE="rtc0".
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Applied, thanks!

