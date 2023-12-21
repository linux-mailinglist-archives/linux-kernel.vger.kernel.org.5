Return-Path: <linux-kernel+bounces-8364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F7681B645
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85276B21C38
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28BF73174;
	Thu, 21 Dec 2023 12:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XZkV1rhn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E706EB63
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 12:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703162775; x=1734698775;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ueOxSUYUNpzkAbxZtMHnsRkshPGRS5UFRpg4fa2vTlM=;
  b=XZkV1rhnx+337L80J5RBC+KWavF9/kwpPA97MtqEnwzKUhF+mnbZqasX
   Zo+QsjxPeqiiY/W66W6f3tfrNAyNsi6j2HUkcduevqxlSvvUgxJkBXIXg
   X5jNh5mjLEFIzrjPAGCvpgr6QcCC6JVLZTV6BLkkpH4KHoq08cIpWlrsT
   PxBNELmItX4/6G41z3eaNcmSFwxRq20wvbG3I572e1TZfRcO3M2FBnAxD
   LXgNPeAbZMzW5OB1rz7g9rKUDDdrsajpLuZiXP0fIVn6myLt0Qxs7hVaA
   uaQJeygbcDPQiRYv/rC9LiYzCwMHRuZ08vw+aD9DYqCr5dqPw3XMnMgZX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="394860766"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="394860766"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 04:46:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="867295521"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="867295521"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 04:46:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rGIRH-00000007qw9-0k6r;
	Thu, 21 Dec 2023 14:46:11 +0200
Date: Thu, 21 Dec 2023 14:46:10 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: hdegoede@redhat.com, lee@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mfd: intel-lpss: Switch to generalized quirk table
Message-ID: <ZYQzkli0HkN93Ag1@smile.fi.intel.com>
References: <20231220073148.19402-1-alex.vinarskis@gmail.com>
 <20231220205621.8575-1-alex.vinarskis@gmail.com>
 <20231220205621.8575-2-alex.vinarskis@gmail.com>
 <ZYQydxWHmKSQgZN4@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYQydxWHmKSQgZN4@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 21, 2023 at 02:41:28PM +0200, Andy Shevchenko wrote:
> On Wed, Dec 20, 2023 at 09:56:20PM +0100, Aleksandrs Vinarskis wrote:

...

> Also I'm not sure about "}, {" style. Lee as the maintainer can clarify
> on this.

JFYI:

$ git grep '^[[:space:]]\+}, {$' -- drivers/mfd/ | wc
250     750    8008

$ git grep '^[[:space:]]\+},$' -- drivers/mfd/ | wc
1898    3796   55230

-- 
With Best Regards,
Andy Shevchenko



