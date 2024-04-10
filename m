Return-Path: <linux-kernel+bounces-139294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C588A0110
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC36E1F21BB4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39792181B96;
	Wed, 10 Apr 2024 20:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WfDrQoNg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF0A28FD;
	Wed, 10 Apr 2024 20:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712779848; cv=none; b=Lyfk1XcYt9FU3pWFGCgESl+8upKhtkzZ8BmbU9vB3/j3rLfR0iIwTwmWePe2E8iOHqdn+GUdVCIwPXvWhUu5LK0KYGSL+bXI5kjsiU8QGHf6VO8JW/Ij0V/yVZMWmBg1kLlSOah7uBpq332eYAHO6hIEIqQ2lSHvXCW620ezkYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712779848; c=relaxed/simple;
	bh=Lvp9C+/2tkQ8H72hXF7SOu0qhZLSHoqXm+5nJr6knyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRMwRrxtuQ8glq5rzEG8bo0yt6V3TWLWyL5E2LToO+Qx9Od+tAk2+aSLNs2LRs79uMkggIOexEKg8FjwxOVthLCXAfb5svS3NHpM0cgajLcwJSaGgaBvkCB7VM9ZgnyJYwWm2SmuCaLBdo/qdF4FcKhHlF5qURjX0H+eFwDARoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WfDrQoNg; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712779846; x=1744315846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lvp9C+/2tkQ8H72hXF7SOu0qhZLSHoqXm+5nJr6knyU=;
  b=WfDrQoNgTN/pc1qz1NpB+EkuEaH3KnVmJXtoGA4KvSA9PSKi8dFaS8Mu
   BrSn5vfaxtfraYUKWbqGUfJk7HAuQCzsih+9nmvAWxER90tpbFaszWjVY
   t02QexevgaXV1OYs4Oj3Qmp9qMdmmCmvQ/x4qBTQWDxcirtmqxGgblV5N
   fFQqlWlhyUDR7qQ7eom+0MiVY5j/wrgcldPp2ioixLVXwQJhPEAPwQFn+
   T6rP40wkXOSHJgt7n1C157QPj7pLTGLJLmGgnZ5GZJhhDSe+ZICnG64Vn
   jKuc39uxiFG7WzUGqtyE5TalVl7PbCRHOB1Putv9yiIb6RpR/fJszaatv
   A==;
X-CSE-ConnectionGUID: 2gvv5+oiT+e/yitvyyAGhw==
X-CSE-MsgGUID: cdhoo1blShKrPu7uOJgaDw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8024767"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="8024767"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 13:10:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="915441955"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="915441955"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 13:10:43 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rueHJ-00000003BAI-1Pqc;
	Wed, 10 Apr 2024 23:10:41 +0300
Date: Wed, 10 Apr 2024 23:10:41 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Subject: Re: [PATCH v1 1/1] fpga: ice40-spi: Remove unused of_gpio.h
Message-ID: <ZhbyQSUzQ0wdqpcU@smile.fi.intel.com>
References: <20240304175723.1200249-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304175723.1200249-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 04, 2024 at 07:57:23PM +0200, Andy Shevchenko wrote:
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it, simply remove the unused header.

Any comment on this? Can it be applied?

-- 
With Best Regards,
Andy Shevchenko



