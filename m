Return-Path: <linux-kernel+bounces-14329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 296D6821B71
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9B01F228D7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E45DEED2;
	Tue,  2 Jan 2024 12:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LueyfKT3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFBBF9C4;
	Tue,  2 Jan 2024 12:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704197532; x=1735733532;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NAXdnv7wxx/86Nl5GgSJyrQJ/CbWX3F7vF2KMB17XcU=;
  b=LueyfKT3c5hw5lW4dsuvxlIOBvf2yAwivXUk7X0CEHk7DMoWfPQn7vjQ
   BP336a55USl6TwUte0sAKWr2Sl6zsTNm/ac1qB/tkPZxvDxOncoLUO+qN
   lcnNUBKGCvtMV0dfHCxq/1Ycc5MfWR5aFaRaJGQ2ACtXZt2R/16nwesm2
   8SLdOUGfxZCjenjAsOb3DNhmzi+aQVAa7VWY4O1XtFtTDqbdDjtGN851z
   gK8hhh2CYIBPX7Jdue7i2/yzQK58zUTSm1eor/s+28R0DCe1dGEYZQE81
   NRbnGTcZc1SwyJbw+62b8iokqk01dTdkBdO5cn0IyySgrAyloUdERO03K
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="4210089"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="4210089"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 04:12:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="898517234"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="898517234"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 02 Jan 2024 04:12:10 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id C340224D; Tue,  2 Jan 2024 14:05:44 +0200 (EET)
Date: Tue, 2 Jan 2024 14:05:44 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com,
	gregkh@linuxfoundation.org, jirislaby@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v1] serial: 8250_lpss: copy dma_param using devm_kmemdup()
Message-ID: <20240102120544.GJ2543524@black.fi.intel.com>
References: <20240102055006.27256-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240102055006.27256-1-raag.jadav@intel.com>

On Tue, Jan 02, 2024 at 11:20:06AM +0530, Raag Jadav wrote:
> Use devm_kmemdup() helper to copy dma_param instead of doing it manually.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

