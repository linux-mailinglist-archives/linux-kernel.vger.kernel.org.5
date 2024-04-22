Return-Path: <linux-kernel+bounces-153393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7C38ACD8E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FB981C21CA4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91969150992;
	Mon, 22 Apr 2024 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PVCNnR30"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796EE14F13C;
	Mon, 22 Apr 2024 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713790301; cv=none; b=KCTe65n4N0Vwy8eC90bP+hLMfnkNxUBiVyAD650DAeCdwDgD0mmYjgqe8AVMlzozXDDhmf/2/s0lTHvep47ktZcozJBAfmFozZGxmNeqhSk1WL0405zSJ0FfX2DfanDIuTKMgR6Z3cU+2NQh4mFlFM6UfK6z7UrplbI86/0upJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713790301; c=relaxed/simple;
	bh=H2hE3mC9J7qbq04JHpgJXxD81wXq96N5Ndy05W4JHwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuXAtXg/UW76rSjAcoKMqynr72BrPql/0c6jBaFYNs/xyLPh5YTWs+P1itMIieNl5AuMpVvxiKoaRjpwzc9fGPoe+eHOk78SBHBGzI2gBTMbM8yKPWVtls84Log2sMZir9hnHlv7tovUOokhJkyvniKFpFptKl1ENkVefi4b0ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PVCNnR30; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713790300; x=1745326300;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H2hE3mC9J7qbq04JHpgJXxD81wXq96N5Ndy05W4JHwI=;
  b=PVCNnR30ZzlJ7Oh2CEhZ5hpWX/9zIsOMEaWdLqLe3GIGKgnjbeCtpP9b
   Zxer6/4QE2ksjLQZosNvAokoGRwfkAkxKCD6chqONjXaKjQAv+HZZDXuK
   xfwf2jYM/TxNvNzsqOmnuyKUPhBVl4lZEwOk28+/j7+Llz6IZywlw3gVD
   8WEMqfibspTu6sJIVzrdvxpPM/WUAUKT0Lddrtt7Zdv4ZGV1KFOFX2E70
   hsfE3y1PNdhEoLRG9VaV/NK2mbpaoyXDnRPdx+Sb2EFl8LZ80cJsdwxJ1
   llWUyn24jY75RHVh7VKhGC7kToW3t/sY5hw+7XnQ8yzHLeEDqStkh37Fs
   A==;
X-CSE-ConnectionGUID: 35GpE87MSoOMOiWJAYTJIA==
X-CSE-MsgGUID: BgnyHvAYSouitRvy/TpWqg==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="26840911"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="26840911"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 05:51:39 -0700
X-CSE-ConnectionGUID: MEkVPW2YSxWPFlETaVbT6A==
X-CSE-MsgGUID: bUSTTiBFSKObV+YMNTf7Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="24610747"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 05:51:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ryt8q-000000003gL-3Y4K;
	Mon, 22 Apr 2024 15:51:28 +0300
Date: Mon, 22 Apr 2024 15:51:28 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Konstantin Pugin <rilian.la.te@ya.ru>
Cc: krzk@kernel.org, conor@kernel.org, lkp@intel.com, vz@mleia.com,
	robh@kernel.org, jcmvbkbc@gmail.com, nicolas.ferre@microchip.com,
	manikanta.guntupalli@amd.com, corbet@lwn.net, ychuang3@nuvoton.com,
	u.kleine-koenig@pengutronix.de, Maarten.Brock@sttls.nl,
	Konstantin Pugin <ria.freelander@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v6 3/3] serial: sc16is7xx: add support for EXAR XR20M1172
 UART
Message-ID: <ZiZdUD5J86QTBij4@smile.fi.intel.com>
References: <20240422123801.2695129-1-rilian.la.te@ya.ru>
 <20240422123801.2695129-4-rilian.la.te@ya.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422123801.2695129-4-rilian.la.te@ya.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 22, 2024 at 03:37:57PM +0300, Konstantin Pugin wrote:
> From: Konstantin Pugin <ria.freelander@gmail.com>
> 
> XR20M1172 register set is mostly compatible with SC16IS762, but it has
> a support for additional division rates of UART with special DLD register.
> So, add handling this register by appropriate devicetree bindings.

LGTM, but I leave it to Hugo for testing and other comments, if any,
as I don't have a HW.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko



