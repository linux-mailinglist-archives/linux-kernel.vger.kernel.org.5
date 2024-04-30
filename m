Return-Path: <linux-kernel+bounces-164035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4BD8B7774
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FFBC1C223E0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2DF171E73;
	Tue, 30 Apr 2024 13:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qn2eUTG+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62287171E4D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 13:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714484738; cv=none; b=ngqbowy6R0WYJ1cLZf2x1QIse5Ev9+07l30JM4E+bL/B3s0d7q3ff2yzXWdDykPmPF7YHts0dNxCFc0qmWIoI8tHBU4AmWETEFLs+T/PjgPTxBM2pPuH9APru2BJrSLxP0MfN9SlclFw9LZxs1zamnlOWnhm9ed1OSW26EdBH7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714484738; c=relaxed/simple;
	bh=LE1sqgYmaqkjrr/mtuHnyNHvplOITrygz2qQHL+C+T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qX6i3okq9kg871LBBagopZYhKnzAw3aNYRIxvNNHnCvoeyAP84jLAnzXxRQvHHnmmz/JpmgnQFlxv03QZEwboLFpsfV4SQDPhVMmuFOLU7aCJxhHCYlEHf1PoINuwIEWXNNMzlJQ/WCN0DFPM+t2qZdGrO/x5vS+cjUT0nipoGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qn2eUTG+; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714484737; x=1746020737;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LE1sqgYmaqkjrr/mtuHnyNHvplOITrygz2qQHL+C+T4=;
  b=Qn2eUTG+eCqhmWo20QRk30BdlmpXHlEVHz6ma6mKESBNAk2oZMUY7+8h
   wrlzFK72+dCycljemaOiDcWCL607eFdYwHgFbR2ZYBy3FpShbtYWBbr7M
   kw1CIj7/DfHS1iuJlSvtQzbn5mAufMOKiEqGLurmeb/7XOgnX7BtAu9TO
   zxty79DPDm35MWdOpvcjWpAPljxhuH7wHDNtx3y3xkkzfPzzcuDPH09Ks
   Bx9OxP1dUf0OMkM7zN4qN58aNX/WMifRZ7sCy9FFK2ta1vQlAu3wVZ1PQ
   cbMERlvlwpPbLRdqHbaut69FQIaJwwCPoDfF14SyW/xzUqVFU/QHeKPdA
   A==;
X-CSE-ConnectionGUID: y+IvXVZkSvui8rV21TW2Vg==
X-CSE-MsgGUID: 63r+CTJWSvydy1ogpd2/dg==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10313261"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10313261"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 06:45:37 -0700
X-CSE-ConnectionGUID: 1etnQxgPSYi82DvgybKGUw==
X-CSE-MsgGUID: ZIwCsDaxQN2rgsGx2ATvpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="63954693"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 06:45:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s1nnU-00000002g31-3uty;
	Tue, 30 Apr 2024 16:45:28 +0300
Date: Tue, 30 Apr 2024 16:45:28 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Baojun Xu <baojun.xu@ti.com>, robh+dt@kernel.org, lgirdwood@gmail.com,
	perex@perex.cz, pierre-louis.bossart@linux.intel.com,
	kevin-lu@ti.com, shenghao-ding@ti.com, navada@ti.com,
	13916275206@139.com, v-po@ti.com, niranjan.hy@ti.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, yung-chuan.liao@linux.intel.com,
	broonie@kernel.org, soyer@irl.hu
Subject: Re: [PATCH v4 1/3] ALSA: hda/tas2781: Add tas2781 hda driver based
 on SPI
Message-ID: <ZjD1-NSC3X_7JcQg@smile.fi.intel.com>
References: <20240430072544.1877-1-baojun.xu@ti.com>
 <20240430072544.1877-2-baojun.xu@ti.com>
 <87jzkfm2hp.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzkfm2hp.wl-tiwai@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 30, 2024 at 02:58:10PM +0200, Takashi Iwai wrote:
> On Tue, 30 Apr 2024 09:25:42 +0200, Baojun Xu wrote:

..

> >  snd-hda-cs-dsp-ctls-objs :=		hda_cs_dsp_ctl.o
> >  snd-hda-scodec-component-objs :=	hda_component.o
> >  snd-hda-scodec-tas2781-i2c-objs :=	tas2781_hda_i2c.o
> > +snd-hda-scodec-tas2781-spi-y :=	tas2781_hda_spi.o tas2781_spi_fwlib.o
> 
> A nitpicking: better to align with other lines (i.e. with *-objs
> instead of *-y).

I object this. The better approach is to have a precursor patch that switches
to y over objs (the latter is for user space code / tools).

-- 
With Best Regards,
Andy Shevchenko



