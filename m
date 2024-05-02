Return-Path: <linux-kernel+bounces-166297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFE48B98B6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2E41F23FE2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E976358229;
	Thu,  2 May 2024 10:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EWXd4KH6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2D156B92
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714645353; cv=none; b=mRs+WEpu/f3uocDIPK3DNoZLbydPxVSm1wLVi+iiUgGn/SynERWBfyEfBkAFfUuP8BjLv7OlIKgKBUaw3T46AOsS9rlMa3XnXFB0/aQNeBauRYY+3Xw3JCRxkoZQAwvS9sRwkbIIhdErfLOOaOx9j8yFLKP1a+hL0Xfk19rXxXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714645353; c=relaxed/simple;
	bh=AvAVxcbuo3Sx2lLGX3xwFNmeRI8WgjtQjlrG/vXHx/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfabllU2C+X8Ja3J9ZRIn1EXlBiAkzllWTFv5bBdSDgzhbdfGmX9ASHGtS6dQZ192U4zSUxpjM9d7UF/XeJ+ASlFrL+rifq89EeGfAPMw/f6acyfhPC66f9f678DFQr7WfpQbXxRGwzfMEkUEreE27cEDCX3E+dbLlIQG/352cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EWXd4KH6; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714645352; x=1746181352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=AvAVxcbuo3Sx2lLGX3xwFNmeRI8WgjtQjlrG/vXHx/M=;
  b=EWXd4KH6Znr7aextucC8dUHuAwZlE9R/NRYO6ZORTiobWNb5durfN7+2
   O4B86AxXMPTdFWbjK5RQtPPE0/0uNGq9SJAGyB++B8y0xc0u7siR5JT2l
   tizz8q85nTZQebcDVnwA+3uvJRMvCjCvly6YabHWgmKDhb6w/tLGcJFx9
   q6wM2clgYjc60QWT+e3miXwVldMAJ+Tn7KJPmVFse8B6qApKWTqQDPqEB
   CRWfjHLvy5SEB7XbjKPw889Z91nOJ9HTI99tQYoFk/ER78Frsrge/+o93
   nByqZ7GJHEE1k4fTlwLdes8uYS+6WQQBYb5663NardxgYXmS1oxhvhaNA
   Q==;
X-CSE-ConnectionGUID: PO2OL6quSq2l0eEi2I2SAw==
X-CSE-MsgGUID: 4q6QA1q5R2Cs9piHOBUPpw==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="10533636"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10533636"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 03:22:31 -0700
X-CSE-ConnectionGUID: Ng2PHk+GSbepSh3GnXNZMQ==
X-CSE-MsgGUID: ZDXuDu7SSouRUtNzWjIBCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="64515040"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 03:22:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s2Ta3-00000003HQk-3iDD;
	Thu, 02 May 2024 13:22:23 +0300
Date: Thu, 2 May 2024 13:22:23 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Xu, Baojun" <baojun.xu@ti.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"perex@perex.cz" <perex@perex.cz>,
	"pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>,
	"Lu, Kevin" <kevin-lu@ti.com>,
	"Ding, Shenghao" <shenghao-ding@ti.com>,
	"Navada Kanyana, Mukund" <navada@ti.com>,
	"13916275206@139.com" <13916275206@139.com>,
	"P O, Vijeth" <v-po@ti.com>,
	"Holalu Yogendra, Niranjan" <niranjan.hy@ti.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
	"yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"soyer@irl.hu" <soyer@irl.hu>
Subject: Re: [EXTERNAL] Re: [PATCH v3 1/3] ALSA: hda/tas2781: Modification
 for add tas2781 driver for SPI
Message-ID: <ZjNpX6TvB4Vv1akq@smile.fi.intel.com>
References: <20240418040240.2337-1-baojun.xu@ti.com>
 <20240418040240.2337-2-baojun.xu@ti.com>
 <ZiEKc4OTVlOt8llU@smile.fi.intel.com>
 <0c7b29075dc347299602668660adb4b6@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c7b29075dc347299602668660adb4b6@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 25, 2024 at 07:54:41AM +0000, Xu, Baojun wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: 18 April 2024 19:56
> > On Thu, Apr 18, 2024 at 12: 02: 37PM +0800, Baojun Xu wrote:
> > On Thu, Apr 18, 2024 at 12:02:37PM +0800, Baojun Xu wrote:

..

> > >  sound/pci/hda/Kconfig                           | 15 +++++++++++++++
> > >  sound/pci/hda/Makefile                          |  2 ++
> > 
> > Is this correct? You are adding a dead "code", isn't it?
> 
> What's mean "dead code"? After add CONFIG_SND_HDA_SCODEC_TAS2781_SPI=m
> in my config file, the whole patch code has worked.

Is that file already in the repository?
If not, I don't see it in this patch either --> dead code.

-- 
With Best Regards,
Andy Shevchenko



