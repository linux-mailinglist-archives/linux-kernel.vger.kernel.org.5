Return-Path: <linux-kernel+bounces-76887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCBE85FE2A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2A11F27D37
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B6C15098B;
	Thu, 22 Feb 2024 16:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="oN71bRA/";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="He4/NDRD"
Received: from mailrelay3-1.pub.mailoutpod2-cph3.one.com (mailrelay3-1.pub.mailoutpod2-cph3.one.com [46.30.211.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06AE15351B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619800; cv=none; b=i51xTJnTARO/wFMobn8mGc4xwUbKJmgtYhJrtEzrSbdTqmTdfciLAKXYVUdhE88z5IfW/WJ/yrP2gceEWU292dZEW3v37d7pfdx6chzNU1pNiDjBY4NbzN7mNcJMZWGrDFaT5UxCa/x1cPdizxxTdudnFJn8sFJRlWtY1UeQYJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619800; c=relaxed/simple;
	bh=fobWBsHnHsMqjobnRhhlP0JyZXT6AFPCB3//dsJOvhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7BBRzTTV3ZGsejzfzqzYNXJ1Ts5iG4SLw9CQwJOtXgnGMcj+Kmr5PRmf0fQRIAsyxiXZjlC0FBAz0MI0cvN2xt60XSIteZZc8h1gWX1JhZtQw0Hnhgk/cnD6C6WWpZmPngLHpiE1roLQe/S3RlZFMjs7BxMv65JhKpLNIGUT5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=oN71bRA/; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=He4/NDRD; arc=none smtp.client-ip=46.30.211.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=oPosSnn8fY/rzwoj/enVOe6Z1lYkcpcW6DlSnIgh43M=;
	b=oN71bRA/GdVuiyK3Lm7p5ns8VDRbrxtghimDZZRESD8wDbM7vxVxGFYy4XOe8Na2eQyXH3I5QEbbg
	 SpOqsNwjGFTrTe/uReYFWC+mXa1KFcR896X1z7u3nzc4hQVIzBDRxiPRo+0o4s8KEcf9ysR+AbyKiT
	 37xW8Aai5fUpTe6k6PVtFWLpANxR9E0YEreOdwBmESjSmW5EoNtdckdDV181f6f6O07NB148fRUZGx
	 Gw1w4FuW7cNhjGaxa8WYriqbERmdEdBFj1FA/ojC3WyEJ8EPdS/3hPtujsyKi0B8z2q/jgXAni9RZ2
	 wb76wUoo7dl+fpYgr4MkkCPgvs9Kc8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=oPosSnn8fY/rzwoj/enVOe6Z1lYkcpcW6DlSnIgh43M=;
	b=He4/NDRDpeD/qMSy1N3MbaIIOcwhK8T8p3QrJ/Cig9R6zIrylKCqOwmiHepFhFPGyxcheaHrFcZHL
	 E5FyMPxAA==
X-HalOne-ID: 61dee748-d1a0-11ee-8c36-119507214a65
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay3.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 61dee748-d1a0-11ee-8c36-119507214a65;
	Thu, 22 Feb 2024 16:35:27 +0000 (UTC)
Date: Thu, 22 Feb 2024 17:35:26 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: bbrezillon@kernel.org, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	daniel@ffwll.ch, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	lee@kernel.org, dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Hari.PrasathGE@microchip.com,
	Balamanikandan.Gunasundar@microchip.com,
	Durai.ManickamKR@microchip.com, Nayabbasha.Sayed@microchip.com,
	Dharma.B@microchip.com, Varshini.Rajendran@microchip.com,
	Balakrishnan.S@microchip.com, Charan.Pedumuru@microchip.com
Subject: Re: [PATCH v8 0/7] Add support for XLCDC to sam9x7 SoC family.
Message-ID: <20240222163526.GA2576040@ravnborg.org>
References: <20240221053531.12701-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221053531.12701-1-manikandan.m@microchip.com>

On Wed, Feb 21, 2024 at 11:05:24AM +0530, Manikandan Muralidharan wrote:
> This patch series aims to add support for XLCDC IP of sam9x7 SoC family
> to the DRM subsystem.XLCDC IP has additional registers and new
> configuration bits compared to the existing register set of HLCDC IP.
> The new compatible string "microchip,sam9x75-xlcdc" is defined for sam9x75
> variant of the sam9x7 SoC family.The is_xlcdc flag under driver data and
> IP specific driver ops helps to differentiate the XLCDC and existing HLCDC
> code within the same driver.
> 
> changes in v8:
> * Re-arrange the patch set to prepare and update the current HLCDC
> code base with the new LCDC IP based driver ops and then add support
> for XLCDC code changes.
> * Fix Cosmetic issues.
> 
> changes in v7:
> * LCDC IP driver ops functions are declared static and its 
> declaration are removed.
> 
> changes in v6:
> * Fixed Cosmetic defects.
> * Added comments for readability.
> 
> changes in v5:
> * return value of regmap_read_poll_timeout is checked in failure
> case.
> * HLCDC and XLCDC specific driver functions are now invoked
> using its IP specific driver ops w/o the need of checking is_xlcdc flag.
> * Removed empty spaces and blank lines.
> 
> changes in v4:
> * fixed kernel warnings reported by kernel test robot.
> 
> changes in v3:
> * Removed de-referencing the value of is_xlcdc flag multiple times in
> a single function.
> * Removed cpu_relax() call when using regmap_read_poll_timeout.
> * Updated xfactor and yfactor equations using shift operators
> * Defined CSC co-efficients in an array for code readability.
> 
> changes in v2:
> * Change the driver compatible name from "microchip,sam9x7-xlcdc" to
> "microchip,sam9x75-xlcdc".
> * Move is_xlcdc flag to driver data.
> * Remove unsed Macro definitions.
> * Add co-developed-bys tags
> * Replace regmap_read() with regmap_read_poll_timeout() call
> * Split code into two helpers for code readablitity.
> ---
> 
> Durai Manickam KR (1):
>   drm: atmel-hlcdc: Define XLCDC specific registers
> 
> Manikandan Muralidharan (6):
>   drm: atmel-hlcdc: add driver ops to differentiate HLCDC and XLCDC IP
>   drm: atmel_hlcdc: Add support for XLCDC using IP specific driver ops
>   drm: atmel-hlcdc: add DPI mode support for XLCDC
>   drm: atmel-hlcdc: add vertical and horizontal scaling support for
>     XLCDC
>   drm: atmel-hlcdc: add support for DSI output formats
>   drm: atmel-hlcdc: add LCD controller layer definition for sam9x75

Hi Manikandan

thanks for your paitent follow-up on this patch set.
Everything looks good and all patches are:
Acked-by: Sam Ravnborg <sam@ravnborg.org>

We are at v8 now and if there are additional comments we can handle them
in-tree.
I have asked Thomas Zimmermann to apply the patches to drm-misc as I
have lost my push infrastructure atm.

	Sam

