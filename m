Return-Path: <linux-kernel+bounces-155582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D060F8AF459
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EC2D1C21F3B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E7413D287;
	Tue, 23 Apr 2024 16:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M0mj0Msd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CD01C2A1;
	Tue, 23 Apr 2024 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713890261; cv=none; b=n7O6WkfEqZwbc5N5Nmnto1WEq4QBAi/SStKvYpaDf+q4exSSkB0hRW8bcKKB9LLOlK6R2S/ymfit2a+SY46OCqA0yQFtaBo9X20d/eyIp06LQCUVDco477Ye/eP7e5nbQuoevHjVuYjZh/LRTJElTacSDW5h3K2IoENA3EOQctQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713890261; c=relaxed/simple;
	bh=jcoffr9WY3/d3x6oetEKDOZKC0RQWO53Pa9fb8E9jd0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WV6Us4NWR1RypUJRKe9uKq1wyJFaQkKBKkNH+6RfVd4a/j/P3fWdnJ+Qpro2hoMxbzXbpYylpzHpDZNc26afpZcXQlJ57C2AL4C0im9tUWgGsrbl2OYOEDrX14JdoOUZwOI4MSDFnIJFKGKwZe7M/tWBU8yuTapEjUsC/NT1/oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M0mj0Msd; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713890260; x=1745426260;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=jcoffr9WY3/d3x6oetEKDOZKC0RQWO53Pa9fb8E9jd0=;
  b=M0mj0Msd215TpGcm3MniVsag8ltI3EDE/lxUIG0ufCUED6wUo3qEwI+i
   ipdox0stTzHmzYA3HIZ/zHrmbUFpmrk+3kmn7nJecZfE5bSMp1sc0iciY
   srMu3caYRWuk09sRrONezRXQUnEU4IRx26lMG0lMG11Xngz9ejb1YINPa
   yVExJOMb37G1vhEZBOobSuwcQdOIV36D9CtweFg5iGsi+tlYvKiqJGHuq
   bydbxao2qAivj5AQeYphe6fiIjJRbX/DxRdeQTGG7zXPONDucnDBw+PjP
   hn1xQ2nxBZYUP4crc553EYU3zDoX4viFYh0zQNX+MOhLo4xxLv4xcqHmI
   g==;
X-CSE-ConnectionGUID: UlDGN24ySOieZLlPAfw3LQ==
X-CSE-MsgGUID: x6A/NDiMTIGDzIx3KgHbiA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20181915"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20181915"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 09:37:39 -0700
X-CSE-ConnectionGUID: IAXcuwD7TyiCFXANqaXGIw==
X-CSE-MsgGUID: G5sy/S12TEGA8sgl2siN3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="28881762"
Received: from fpirou-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.46.117])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 09:37:37 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1 2/2] Documentation: process: Recommend to put Cc:
 tags after cutter '---' line
In-Reply-To: <ZifHnw1cxgP77MKx@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240423132024.2368662-1-andriy.shevchenko@linux.intel.com>
 <20240423132024.2368662-3-andriy.shevchenko@linux.intel.com>
 <871q6wrw12.fsf@intel.com> <ZifHnw1cxgP77MKx@smile.fi.intel.com>
Date: Tue, 23 Apr 2024 19:37:34 +0300
Message-ID: <87ttjsqbld.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 23 Apr 2024, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> On Tue, Apr 23, 2024 at 05:30:49PM +0300, Jani Nikula wrote:
>> The Cc's on the mailing list archive are harder to dig up, and do not
>> accurately reflect the same information.
>
> How comes? These Cc: are 1:1 mapped to the Cc: email headers.

Patch Cc's get mapped to email Cc's depending on personal git sendemail
configuration.

People can add more Cc's in the emails when sending.

Mailing list Cc's actually present in the archives depend on mailing
list manager configuration, and, in some cases, even the personal list
preferences of individual subscribers.


BR,
Jani.


-- 
Jani Nikula, Intel

