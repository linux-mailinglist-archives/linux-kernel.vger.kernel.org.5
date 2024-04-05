Return-Path: <linux-kernel+bounces-133339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4156289A27C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA8A4B22DCE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7312171640;
	Fri,  5 Apr 2024 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aM4X3W2T"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B299E171075;
	Fri,  5 Apr 2024 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712334443; cv=none; b=Pi+h7jWdgRdYWTGjP3OFCc/jtMFIAgouOmfeqrfcL2EpWKP80AaaiDz20d/M3EVnDvISeh6zse4Zy3JyPDfjds3f5L+658tQBF7sdkdk6D1uaAGoR8KNag2Vgolz9W58DAzJmilQ0U1kmqJ7AADFFKecw9Raw1WWgg0cm3bZMQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712334443; c=relaxed/simple;
	bh=1rB3/ZAXnwJsq3eNOlhvfWEklsZnNw1TyJxUJwxJNcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0EBTtdtw8e2Tz4sThYYGyW1S/wbwelXfIWzzamlu3+m1Sfa0Ai7rWFhirq0l8JZCI4hL381JRDGLcP6UnVI2rNQjqn7sNbEnliUtOwmtEfkZCGh9gaz/jgf0CSqyhPfq12eaIGNRqZa1Gp7KAmDRLkHU9OGuLMkm5DUgnyMM8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aM4X3W2T; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712334442; x=1743870442;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1rB3/ZAXnwJsq3eNOlhvfWEklsZnNw1TyJxUJwxJNcQ=;
  b=aM4X3W2T35HjHDgj9r/XMytiT1zlGxs6IReJwG3imA5X09JuSlxzFL5z
   +QmrELMvqQ06Z+DBK9OO3ASGWYm1pFTOF0ATFZit3WXO5j3OYhT6ldhGQ
   ztplw3gY0fVmuZ6i0/yxxac/zI2o8rbhDDhgmvQ3P/CZ5fFeCv+2dS+Sd
   QZclPhEpeWxmg33RFZ9tNW1+ShzjuPmav4CUwm8mna+0t1H14ddSxrphC
   pynX4ZGKZWYBwLGQ3OfFjJmZs89YtuKcd0Yjv0Bp0qVjU4rdeuUTZytFw
   wX8Evl7xgLAkjHa2EPpMzVw8A89buf5Z1iN6Oweo902KRNj37HpG1uIku
   g==;
X-CSE-ConnectionGUID: KdhQVOP8SBGNZBIKZrwQ3g==
X-CSE-MsgGUID: TSogD5UrTmimxW3dHn5H9Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7798137"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="7798137"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 09:27:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="915258518"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="915258518"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 09:27:18 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rsmPL-00000001ndJ-49Pw;
	Fri, 05 Apr 2024 19:27:15 +0300
Date: Fri, 5 Apr 2024 19:27:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"brgl@bgdev.pl" <brgl@bgdev.pl>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pinctrl: pinconf-generic: check error value EOPNOTSUPP
Message-ID: <ZhAmY8TiWcRslwqI@smile.fi.intel.com>
References: <20240401141031.3106216-1-peng.fan@oss.nxp.com>
 <CACRpkdZAuNXGyg2wwYcQG4oO9w7jPS6vj4Vt0=kqX5fJ+QpNmw@mail.gmail.com>
 <Zg7dwcFz5eD7Am2u@smile.fi.intel.com>
 <DU0PR04MB941777DA29D70013342721A788032@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZhAa3NPO19mINYJP@smile.fi.intel.com>
 <ZhAdB4T7sTa2Z7db@bogus>
 <ZhAhcI3g4xJ1ANzu@pluto>
 <ZhAj-LZWv4M3vS6F@smile.fi.intel.com>
 <ZhAlg0Zu_2uOQMk_@pluto>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhAlg0Zu_2uOQMk_@pluto>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 05, 2024 at 05:23:31PM +0100, Cristian Marussi wrote:
> On Fri, Apr 05, 2024 at 07:16:56PM +0300, Andy Shevchenko wrote:

..

> Yes, my point was simply to say to fix the retcode of SCMI pinctrl to comply with
> Pinctrl expectations, and definitely NOT to fix and move to ENOTSUPP all the SCMI
> originated errors across all protocols, since it is NOT what is expected in general
> by other susbsystems.

Yes, that's what will work for me, thanks!

-- 
With Best Regards,
Andy Shevchenko



