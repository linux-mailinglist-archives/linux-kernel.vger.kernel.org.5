Return-Path: <linux-kernel+bounces-142964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A64E8A329D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E533286FBC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B59D1487C6;
	Fri, 12 Apr 2024 15:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SY/TX+nY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40D81411F4;
	Fri, 12 Apr 2024 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712936311; cv=none; b=SOe65tljuMxZ/z5PPvrYCv4oLGS3Q28bfbbB8PgXv8NcgOrdKizsfBkFBRibykHu9Of9AKDp9TDq3IWSpfnCFFjSGHyPsL2qEQqNt1bDi2uZnZ8PQWMneXqaf6AZkzxEixzwaJ3btWLsXsGM3yhNnktwjuz4vu2epxue86f/eU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712936311; c=relaxed/simple;
	bh=o0Ohfuc9FmFgVm+WRikyirOa0zfzgYOUHOXxIW7s4Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWoRzPEfRqF7UrBRA5nM/k9qe8TE7WE59MsM9Mge6qQW7aEHtlBc7RSan/uKZNxtd0J15yACVX4+K6hZ9A7symt5brAPP4ItnHzEnO2vd+3NmzFWRIpO0qD3xqgp91B5dN4y7ZfUiGeN2vQ+Gv3PIDx1Ms2ETBNhwagmn3IlkVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SY/TX+nY; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712936310; x=1744472310;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=o0Ohfuc9FmFgVm+WRikyirOa0zfzgYOUHOXxIW7s4Uo=;
  b=SY/TX+nYIcHlVlmuYzfP5BqRb2r/fDNIG9W3GInFyIIpekQsq/pcSGjg
   Qa1FKpSP+QDQZBiWfJIKwtmZc6X7F6RUFBGPWvQJlVMPG7JwpPCyVMsXT
   L9o0QrKmpaTWfio1/A+GdasgmLWPzUnWzzQKOrnMMgj0Io1xZ84NYb7qx
   xbuyorP3V7k/9Dke8p+tzJ8OYsYnXs/HmMyC5D/uEetqETiyvF80n5FgC
   KM1G2WF8Rs2A8kr51zIzYVHQEp+GRPDQQ9Z+gyo1/t3FKZoW/dBpgs100
   zqHRJ0kICLZcYWkC1KwD6Rp76oHCfPt4IaOn0nm40xB7z8mAHO9z1sfto
   A==;
X-CSE-ConnectionGUID: SxgHU3KRRbiLds1JFPeLhA==
X-CSE-MsgGUID: yniKpg+ZQYyG5dGPwRCbTA==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="12187226"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="12187226"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 08:38:30 -0700
X-CSE-ConnectionGUID: rC/3ktDzS+O1TKFpUz9EjQ==
X-CSE-MsgGUID: ijfHJG9yT9uMjig0fGakig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="21330663"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 08:38:27 -0700
Date: Fri, 12 Apr 2024 18:38:24 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pwm: dwc: allow suspend/resume for 16 channels
Message-ID: <Zhk-7Tp4HzF41Is5@black.fi.intel.com>
References: <20240412060812.20412-1-raag.jadav@intel.com>
 <zf74jdjza2kfgmiecmlwlws46fmy3rtxvcocmkwewgx64oewpm@xfyq2zt6ts5u>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <zf74jdjza2kfgmiecmlwlws46fmy3rtxvcocmkwewgx64oewpm@xfyq2zt6ts5u>

On Fri, Apr 12, 2024 at 01:12:48PM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Fri, Apr 12, 2024 at 11:38:12AM +0530, Raag Jadav wrote:
> > diff --git a/drivers/pwm/pwm-dwc.h b/drivers/pwm/pwm-dwc.h
> > index a8b074841ae8..c6e2df5a6122 100644
> > --- a/drivers/pwm/pwm-dwc.h
> > +++ b/drivers/pwm/pwm-dwc.h
> > @@ -38,6 +38,12 @@ struct dwc_pwm_info {
> >  	unsigned int size;
> >  };
> >  
> > +struct dwc_pwm_drvdata {
> > +	const struct dwc_pwm_info *info;
> > +	void __iomem *io_base;
> 
> .io_base is only used during init time and so doesn't need to be tracked
> in driver data.

It will be useful for other features which are WIP.

> Otherwise I (only slightly) dislike
> > +	struct dwc_pwm_drvdata *data;
> because "data" is very generic. I'd call it ddata. But I don't feel
> strong here. I'm happy if you change to "ddata" in v2, I will silently
> apply anyhow if you prefer "data".

I think "data" is more readable, something like "ddata" would make me
re-adjust my glasses ;)

Raag

