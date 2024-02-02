Return-Path: <linux-kernel+bounces-49933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6868471BC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1320FB265FB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFB114077C;
	Fri,  2 Feb 2024 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ef1CH6qH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E4147A4D;
	Fri,  2 Feb 2024 14:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706883496; cv=none; b=PS3ifwbFBuPDL+IpV3Z/1y9zUQRnUAkKRCf8leXSzYCmAuO881B+8ZN2rf/k3+FrJe/3q6xhdDwyVbMBFfG/jZWGTFN68f696S7dxDpKMrxmUIoFufW9UIdVqUHO1D2Pp5iB3TZe7j+hnNhhEq07hrXvCwU7Tqn/Cq3OD6cIX8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706883496; c=relaxed/simple;
	bh=HzNWvLqFNq5/KR4E32uIR72ZaR/BALczY1b4w4LjKGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCVRY6/24DEMKsT/hmyOM8pOsKEH70hdu222pBpAfkdumHe2aZ47s0GLQiAk6Q1cgVTkOuIb4i8a9ZWUdhXFkA0sfwkaav7Y7XTqUAFrKAg7QTscypj41zIjbQaot8/NjEy01J0+gylvfaBI23YcBelPLulrBEM81lbWihlNhqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ef1CH6qH; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706883495; x=1738419495;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HzNWvLqFNq5/KR4E32uIR72ZaR/BALczY1b4w4LjKGI=;
  b=Ef1CH6qH2VeRv3cLhcnCaoT0nfPH+V7I4OmwcN2Ve36J/cd29GHyfmHP
   ua2Hiq6iqaQfBWPOIHHhwgUVP7nZV8Na+kevw7t/cPsscsl2bFmUT3Vh/
   j2jkPGBHaMCaziWTHSLM7WmKp4WWxWHU0iD6CDaeRWTenM1iCIJ0305GN
   0y+0ysxREyXddVeIg3xNGxy7o/TPU3vqhWZafwZYH1ip92qhrsPIuDmnL
   V2WDmn2fo2Zw0YRbZkJPQKsjiAah1vJ3Wi/R0Kiny9bGy05NqFGnO8GnD
   ETDebdncoF0neQMkSBdw3uYPLMrayS3aavF4FP3j4PMwxV5s1TZJ3emj+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="351097"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="351097"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 06:18:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="908584636"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="908584636"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 06:18:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rVuMr-00000001I5f-0dcD;
	Fri, 02 Feb 2024 16:18:09 +0200
Date: Fri, 2 Feb 2024 16:18:08 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Flavio Suligoi <f.suligoi@asem.it>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Lee Jones <lee@kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v2 0/3] backlight: mp3309c: Allow to use on non-OF
 platforms
Message-ID: <Zbz5oPKS4ZdeMOaP@smile.fi.intel.com>
References: <20240201151537.367218-1-andriy.shevchenko@linux.intel.com>
 <DU2PR01MB80349345B0C1757C6958107FF9422@DU2PR01MB8034.eurprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU2PR01MB80349345B0C1757C6958107FF9422@DU2PR01MB8034.eurprd01.prod.exchangelabs.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 02, 2024 at 10:52:32AM +0000, Flavio Suligoi wrote:

> > Andy Shevchenko (3):
> >   backlight: mp3309c: Make use of device properties
> >   backlight: mp3309c: use dev_err_probe() instead of dev_err()
> >   backlight: mp3309c: Utilise temporary variable for struct device

> I've just tested again all your three patches (using the last 8.8.0-rc1
> for-backlight-next )  on my board and all is ok.

Thank you!

-- 
With Best Regards,
Andy Shevchenko



