Return-Path: <linux-kernel+bounces-489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1110D8141E5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 924BAB221EA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B630D266;
	Fri, 15 Dec 2023 06:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I9qfQm4r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E97ADDA6;
	Fri, 15 Dec 2023 06:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702622663; x=1734158663;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=63EgPcBRFaJVMnMAE03v+S8ALEccu0QFpneLzykEYp0=;
  b=I9qfQm4rA5TBElwi+ephzaPsj/ay/+PRZJTW7oib2r34vON2ollTR7Lr
   iyNIv3d3dBqEmtrAXOsz27n+1c9Xm6iLqGo11GYhN5jCF5l2IIpOLdNLE
   N1MYXwEYs9rijdBKr9fNumbbSC7G12FFaDWjzBCGV7o/uWh4xl1TrueLk
   0BA2r2oUbSMGDoSg88Mig9+U8fm38JVuI/wGvdvpef8DjCBhDI8yQGaYn
   u3gPMm//GA/29GgZUBfNNH889e7GfzElWKd5bYj8NM7uAHm66Ci2ZItg6
   8MvMoJQoLmRDUflHZq4UUiFjiznSMWq78LOMev04ZocDLfxqTpb19RCya
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2090602"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="2090602"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 22:44:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="767868433"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="767868433"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 14 Dec 2023 22:44:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id E664F3A3; Fri, 15 Dec 2023 08:44:17 +0200 (EET)
Date: Fri, 15 Dec 2023 08:44:17 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Raag Jadav <raag.jadav@intel.com>, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: intel: Add Intel Meteor Point pin
 controller and GPIO support
Message-ID: <20231215064417.GV1074920@black.fi.intel.com>
References: <20231214154653.1087747-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231214154653.1087747-1-andriy.shevchenko@linux.intel.com>

On Thu, Dec 14, 2023 at 05:46:53PM +0200, Andy Shevchenko wrote:
> This driver supports pinctrl/GPIO hardware found on Intel Meteor Point
> (a Meteor Lake PCH) providing users a pinctrl and GPIO interfaces
> including GPIO interrupts.

This is driver for Meteor Lake-S and related, correct? Why it cannot use
pinctrl-meteorlake.c instead? Same way we do for other desktop CPUs
whose PCHs have the GPIO/pinctrl block.

