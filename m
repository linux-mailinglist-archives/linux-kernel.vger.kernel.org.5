Return-Path: <linux-kernel+bounces-119531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BA388C9F4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD0E300C09
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547EF13D514;
	Tue, 26 Mar 2024 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KitKWoco"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2C413C91F;
	Tue, 26 Mar 2024 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472446; cv=none; b=Lc4ztSzNV1v61j8z+FATGfq5GGRYTfdahzwp5ABOdfuqBBd8bC/yQrpNJjpLc2qCgaY7TRQVr6O3GcoL7SQTK4040wqxScVOP+WnF/dkfqbe2H1628oX8bgPtmUFgq1Tt8ZNpAhV7OamFifRlhr6UrIxH3fTH2SeXiwPZ2eJkRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472446; c=relaxed/simple;
	bh=VcQPvmo4VU6C5+jXx9/sQvdk6EoaPM38qN5xUSOSE7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxE+Mqqv+7YOICmPkhJoPlBpzcjGZL6CeGLeZBvxkg0r9II7wTgl2hXwrTNnOh4nxKujubD0VMSi7TlqpqW0HKGHeAgO2yDRebfTBhYwPetOCWy21uat0dYN+Joah3wD+inSQGZCN1KApNtwwFpbtLYtH43sYKDZP99IA5Pyvrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KitKWoco; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711472445; x=1743008445;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VcQPvmo4VU6C5+jXx9/sQvdk6EoaPM38qN5xUSOSE7o=;
  b=KitKWocogFjeMfkFnkeJIWtamtZot8ODM6jyovUgUltLu3a+HwfiGq1B
   /IeMpYuQj1j1WbY8GhpCWlLOgtRTRCOHhQ1TEv/e4cq1rr5q1XHwbRiO+
   lT/z4vfh4MSvgQtUMKetS+zzvdl3HEqyr6IvCEXIt9vFVwBvf9aNJszNr
   Pd6cF3wXlfnMHzv0q5NTgC1N/7X7DfD8oP5LffdwcYe0TFuBIrzZZ2i1G
   oWGyOeVFlj0jnLekxe74HLMnnjU7wliuFJUvOkuGv8TPPmET0EF3EIMkJ
   8zd7pgIk4Mtt5AWutuM1pcvjtWD2dOq1lECQzbtzMjkIUupFS9r5WxHeE
   g==;
X-CSE-ConnectionGUID: Bps2R4MpQUmAD8EVYXuB9Q==
X-CSE-MsgGUID: tYxNSVOZTEeruWiWUJM1HQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="24025825"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="24025825"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 10:00:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914885315"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="914885315"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 10:00:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rpAAB-0000000GOVR-2L8i;
	Tue, 26 Mar 2024 19:00:39 +0200
Date: Tue, 26 Mar 2024 19:00:39 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v2 1/1] ASoC: soc-jack: Get rid of legacy GPIO support
Message-ID: <ZgL_N1aMQiju3yaI@smile.fi.intel.com>
References: <20240325143654.3305498-1-andriy.shevchenko@linux.intel.com>
 <ZgGvev-Wh7SkYnI7@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgGvev-Wh7SkYnI7@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 25, 2024 at 07:08:10PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 25, 2024 at 04:33:50PM +0200, Andy Shevchenko wrote:
> > No more users.
> 
> FSL code needs to be cleaned up (there is a leftover that makes this fail).
> :-(

Okay, since the fix-patch had been applied, this one now is clean to go.
Do I need to resend or any other work needs to be done?

-- 
With Best Regards,
Andy Shevchenko



