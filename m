Return-Path: <linux-kernel+bounces-143531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E648A3A96
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48EE71F23AC1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F87C18633;
	Sat, 13 Apr 2024 03:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U8AnlmLx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82634205E10;
	Sat, 13 Apr 2024 03:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712978133; cv=none; b=ecSqwBgtuzg3CH1oC/dK7/RusS89IkphDg/cHZpDklfnG64/d4sCDfrqz5T7sMKJ90iY0akXcMWf0kQbRk0msppbmFsCfhdZaLQtpTdQnuL7t384JwYfdi93EPR1NpDtCelcBDHaApb/u96P4nssCXRfWH7GfRad1YUuszDo5m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712978133; c=relaxed/simple;
	bh=6Y1blPmYVYju6oJ421vu/j3UB8tqlSX/gApNox7y5pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Po/IzSYyr66rxjCZoIGBg2JjsOPZLca+tvdSOXLMQdCL8f0XGvZTCrG6f5T0p0O/YEr8rZ12aM1UmEof/eqqeOXEAmNOnuJrX0sG1sVKpkpVLuQ8S9EdQLIitCGCufGFzbksZvg+WF7BLHlrqLA+CeLEdWkp4wlWyKcpBpFvLs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U8AnlmLx; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712978132; x=1744514132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6Y1blPmYVYju6oJ421vu/j3UB8tqlSX/gApNox7y5pQ=;
  b=U8AnlmLxPRdcct+oObD6ZZ1aE5WOUiCAt2iwX2tBuJ1OoYVBaXY/ts5x
   BseyCRE/4lCcEREhF6ZaInjDAJpJf+G0k9AbDtWHN1ADo6XHTUZ9YqiI7
   w4/47xe08uTsoz4YtXWujPuNpQUZ1c8QybsWlV610aJbV+9CiVN+vQ7I9
   t8dPyjoYC5HIeQEnktO3/6UQ9xMmVeA4SNUqVIU8gtGlCXVOwezpjqT5t
   y0LH6Y5c+vFQEO86GjNccNIxKTOtlQ0sqd5M0H+R0Wqvd1AbOiHV01iyA
   /EU3+0c35stLoJ2aowmK3kitripxfP0SfBtZXpVgKgFrYqgtTQTRtTJmU
   Q==;
X-CSE-ConnectionGUID: wfl37OF2QEaX5W2P0mZzAg==
X-CSE-MsgGUID: 2Glp4Kn9Ty+tL0oAXVULdw==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="8306173"
X-IronPort-AV: E=Sophos;i="6.07,198,1708416000"; 
   d="scan'208";a="8306173"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 20:15:31 -0700
X-CSE-ConnectionGUID: r0sgSk3xTu2Kr9Q/czL9zA==
X-CSE-MsgGUID: M9S3P+bfRUynnFhaxF83YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,198,1708416000"; 
   d="scan'208";a="25824887"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 12 Apr 2024 20:15:29 -0700
Date: Sat, 13 Apr 2024 11:10:22 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Colberg <peter.colberg@intel.com>
Cc: Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v2] fpga: dfl: remove unused member pdata from struct
 dfl_{afu,fme}
Message-ID: <Zhn3npCOy2h1SYm4@yilunxu-OptiPlex-7050>
References: <20240401184915.714603-1-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401184915.714603-1-peter.colberg@intel.com>

On Mon, Apr 01, 2024 at 02:49:15PM -0400, Peter Colberg wrote:
> The member pdata was added to struct dfl_afu in commit 857a26222ff7 ("fpga:
> dfl: afu: add afu sub feature support") and to struct dfl_fme in commit
> 29de76240e86 ("fpga: dfl: fme: add partial reconfiguration sub feature
> support"). It is set in function {afu,fme}_dev_init() but never used.
> 
> Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next.

