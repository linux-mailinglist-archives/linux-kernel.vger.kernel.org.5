Return-Path: <linux-kernel+bounces-106001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8269C87E751
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20A11C21D6E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41FE2E630;
	Mon, 18 Mar 2024 10:25:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060152D05E;
	Mon, 18 Mar 2024 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710757545; cv=none; b=Fu6W9sFtk1m9UNTjgqHat7XVm6CHOH/RiQobEGAI6Kdivypj+tLJunprEDqV+X0UHDVhOD6U3sVnZ7ojhpcqnj3qowHGmiqxqRwVc1u7i+ACRk5v1LjEC4cmBoZAj6wHCvoT9C6Zj4mKtxgq7KZ9L8bLqUHjRwre/JCRQ/V61AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710757545; c=relaxed/simple;
	bh=D3i4B1/kUtjh2CpcNv1sVfMNLfGhvfY5mN0F46ju5IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMxlnVcmkVeEnheHgvGYojELVZCnGNMPhfL26sqgNx0qtQxZxbOcaaOimniSHs2wxOx3+bSfwJoKFEe44hoGRcd5qiVW8VSK4skpjqBfYniEg2c+vO6Efgqf+OFhlgAFr5AzcjfQJ05Dp2ai7p5ArI3gxMIvL6yeSPw0uc+x8xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="17008645"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="17008645"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 03:25:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="914587837"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="914587837"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 03:25:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1rmABX-0000000DufE-0yl7;
	Mon, 18 Mar 2024 12:25:39 +0200
Date: Mon, 18 Mar 2024 12:25:39 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"brgl@bgdev.pl" <brgl@bgdev.pl>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpiolib: use dev_err when gpiod_configure_flags failed
Message-ID: <ZfgWo3ZTHAAhWZ_D@smile.fi.intel.com>
References: <20240315011015.3106272-1-peng.fan@oss.nxp.com>
 <CAHp75Vf42b8uo+7c+WEQj5Kj8LRf3PxXeEpwEJScyw-PMeYn9A@mail.gmail.com>
 <DU0PR04MB94177BC9D193116C9B4435D0882D2@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DU0PR04MB94177BC9D193116C9B4435D0882D2@DU0PR04MB9417.eurprd04.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 18, 2024 at 02:03:12AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH] gpiolib: use dev_err when gpiod_configure_flags failed
> > On Fri, Mar 15, 2024 at 3:02 AM Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > wrote:

..

> > It's unclear what the use case is and how this does make life easier.
> > We need to know more!
> 
> I forgot to add gpio-ranges in gpio node, then it always fail in my driver
> probe to configure pinctrl. So if using dev_err(), it will be easier for
> me to locate the error point.

At least make sure something like the above is in the commit message of the
next version.

-- 
With Best Regards,
Andy Shevchenko



