Return-Path: <linux-kernel+bounces-81862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA45867B1D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3681F29063
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48E612C814;
	Mon, 26 Feb 2024 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="Bb8irr0I"
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A96F12C547;
	Mon, 26 Feb 2024 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.198.35.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708963510; cv=none; b=kCOQyWlemhCzCK0h2HyPaB0oCQe+uhPUorBBufjiEVREQ0WF0dDvvRyM/fm1pgZyr/VLFrMyq81IjhnK8k5HPojNlWoIasWKEBpEyevb1MLKbj4u0bzFicxzZlhnRynwWqhXDaj9dk0G2j/0DXTMPGO4GrmXaw0oSq0bamGLu4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708963510; c=relaxed/simple;
	bh=thP/qrj7uMkjSVxts1RK1BXictk3p7xFgucV+Uip45c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To; b=OH2Yfw1vNepo3JLFpPop9jZuK0/nZJDMZtvlewS5RWtuZ1TCiX1O+LoFoRo4nOk4AhrrssIovDh2Y8mvWXNbx+UUH5QHr7w/bG5Lr+69kQMR0frxaGSYA16dQLCLyal53YqjNt/I7VllkuK6NzkWu+iFszlBUB5UC7bq0DW9U9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=Bb8irr0I; arc=none smtp.client-ip=92.198.35.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Date: Mon, 26 Feb 2024 17:04:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
	t=1708963503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
	 references:references; bh=my0PEDa0k0ziVwc0VTyV85bWDxYwPP0Y8LGXCUo7Iso=;
	b=Bb8irr0ITsejK7apGvbacbNwF6sCnh+Zu4m/PDjvzCZECMKNxf2qzIvxOq1MCFYvG/C7vo
	cFRjQW/9/ntfcPtyqHC0gW3v6ETFOIjpl0RFbaktjPvQTsH0AhBp3DiJaI82ygnJx4Bzb6
	F9IgnYjBN9BSU4yhfDtllQe40XtdBCUFaim3eYDdz2l8oLHvCvekZTbTJSO8PMpJsEaE5G
	4ZYqXKzBwykjAY7raDXsSgfyStwmZxupMmeSELrZzp28Bxo52lPu9uM4vz/bvOnfs5rSU1
	tr6ukVSFgwfnTcevHeZNizN6GAetOQnyLG5ggNX8Y0MVVbrJFbsbYW2VJlokVg==
From: Alexander Dahl <ada@thorsis.com>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: ojeda@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, andy.shevchenko@gmail.com,
	geert@linux-m68k.org, pavel@ucw.cz, lee@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH 0/3] auxdisplay: 7 segment LED display
Message-ID: <20240226-scabby-fiber-87d5d6e45028@thorsis.com>
Mail-Followup-To: Chris Packham <chris.packham@alliedtelesis.co.nz>,
	ojeda@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, andy.shevchenko@gmail.com,
	geert@linux-m68k.org, pavel@ucw.cz, lee@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-leds@vger.kernel.org
References: <20240225213423.690561-1-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225213423.690561-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello Chris,

Am Mon, Feb 26, 2024 at 10:34:20AM +1300 schrieb Chris Packham:
> This series adds a driver for a 7 segment LED display.
> 
> I'd like to get some feedback on how this could be extended to support >1
> character. The driver as presented is sufficient for my hardware which only has
> a single character display but I can see that for this to be generically useful
> supporting more characters would be desireable.
> 
> Earlier I posted an idea that the characters could be represended by
> sub-nodes[1] but there doesn't seem to be a way of having that and keeping the
> convenience of using devm_gpiod_get_array() (unless I've missed something).
> 
> [1] - https://lore.kernel.org/lkml/2a8d19ee-b18b-4b7c-869f-7d601cea30b6@alliedtelesis.co.nz/

Read that thread out of curiosity and I'm sorry if I'm late to the
party, but I wondered why this is limited to LEDs connected to GPIOs?

Would it be possible to somehow stack this on top of some existing
LEDs?  I mean you could wire a 7 segment device to almost any LED
driver IC with enough channels, couldn't you?

Greets
Alex

> 
> Chris Packham (3):
>   auxdisplay: Add 7 segment LED display driver
>   dt-bindings: auxdisplay: Add bindings for generic 7 segment LED
>   ARM: dts: marvell: Add 7 segment LED display on x530
> 
>  .../auxdisplay/generic,gpio-7seg.yaml         |  40 +++++
>  .../boot/dts/marvell/armada-385-atl-x530.dts  |  13 +-
>  drivers/auxdisplay/Kconfig                    |   7 +
>  drivers/auxdisplay/Makefile                   |   1 +
>  drivers/auxdisplay/seg-led.c                  | 152 ++++++++++++++++++
>  5 files changed, 212 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/auxdisplay/generic,gpio-7seg.yaml
>  create mode 100644 drivers/auxdisplay/seg-led.c
> 
> -- 
> 2.43.2
> 
> 

