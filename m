Return-Path: <linux-kernel+bounces-144607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A82B28A4857
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 688391F21113
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932F61EB35;
	Mon, 15 Apr 2024 06:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lUWmBAhz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742BE1D53F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713163712; cv=none; b=TJX04R2vd/IFgPkPrjrjXXpSJpY0bbaa0SQuyoR6pW2+F8d/17Sw3J5KMMIWZlLzrZEpEzdvlwdt+fNDuo9029gH6xnncMDYhPpUmoJq5TnI9NHeOuLD87bAeWRaNgjf7WHJGB3euH4EK4RlhopaXKSZNMilub4EPi8erIFFcDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713163712; c=relaxed/simple;
	bh=Ruv2VUzUQFOI1qnT4H+UzeBHKRupteXNS24ZWhvPFYA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ekf4tgk7UPaprXxJ461jOEh0iHNlt4Gr0UbWYaxt0xBFPX+2LHBB7nB6DD/GgR8AOfScL2AdO9U6QhmoIXWlpFn2UPNCboBMEIMTh6f/5AVTVxhGHQrlQE2Gk3jEkn0zMdQlZSwlCXuuceIUEjwdmrOwIKAPCNWUpNVgyqL2cks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lUWmBAhz; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713163712; x=1744699712;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=Ruv2VUzUQFOI1qnT4H+UzeBHKRupteXNS24ZWhvPFYA=;
  b=lUWmBAhzgeon3qnIyuSNscMKe441aetXKMXLB278tPtS5ScXSC2s07FQ
   AAdvHZgYF1cgGoKBZt+oX7no1v6L2s1woeYLb3B99SCG+ETuJfvOYtoJC
   RWSInuXSrBUL3x0f2sTbm2scpKlcnclJVSDtPJP137e6wd3kVvdachRGl
   UJOLzpJQFVa9Um8AFnU0oFOguT2hVJaxLRM/wFXugaLl4RArf7x+QGJ/y
   dCF8/6QvRO8+oPR+AkEkjaOYX2pCmcfUne4vfT48srN6HNGw20vB/mY7S
   8JPin3aCKuAEdUVDhhgGAkteXIcgrw9cenJje6fBNZAjh8FFTaZwsK9Tm
   g==;
X-CSE-ConnectionGUID: bgZN3EwRRDGU2DwdjoBYVA==
X-CSE-MsgGUID: pgDX/WgGQPimIXPwsqXSqg==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="8452048"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="8452048"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 23:48:30 -0700
X-CSE-ConnectionGUID: YiVkeimGSdysXLkaD0+ywg==
X-CSE-MsgGUID: FCwWRedRSzSj/F/xvX9htQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="22289533"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by orviesa007.jf.intel.com with ESMTP; 14 Apr 2024 23:48:29 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Greg
 Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 alexander.shishkin@linux.intel.com
Subject: Re: [PATCH 7/8] intel_th: Convert to platform remove callback
 returning void
In-Reply-To: <rnybbv5sddkgtnxzad7sg2jyosr77vvud6t7ii3sssfsi7td2u@3b5nbhsprcaf>
References: <20231107202818.4005791-1-u.kleine-koenig@pengutronix.de>
 <20231107202818.4005791-8-u.kleine-koenig@pengutronix.de>
 <i3oybmf3axeyk5rcef5kgfdb4cucd63h24gup6idn62nq3vvav@4mfzwzyamq27>
 <jawceotzgdydpz74qr2e5dwgfumwjmt4wxvi43qlwldlbgemzf@v3qa2hoopawv>
 <qiiln66o6uy2nsqdjcykygp3yumonn7jqp7q4wxf56i6pazics@iqfaiglmsgwt>
 <87edd5y7lz.fsf@ubik.fi.intel.com>
 <rnybbv5sddkgtnxzad7sg2jyosr77vvud6t7ii3sssfsi7td2u@3b5nbhsprcaf>
Date: Mon, 15 Apr 2024 09:48:27 +0300
Message-ID: <875xwjxgsk.fsf@ubik.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:

> Hello Alex,

Hi Uwe,

> Given there are not that many patches left (~50) as of today's next, I'd
> like to see this patch going in during the next merge window, that I can
> finalize the (next step of the) quest around platform_driver::remove.
>
> Is sending this patch to Greg still on your todo list?

Yes, as soon as I finalize other patches on my series. Should be soon.

Regards,
--
Alex

