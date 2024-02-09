Return-Path: <linux-kernel+bounces-59449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 554AB84F743
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073DD1F21D67
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D09A69966;
	Fri,  9 Feb 2024 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LsAzeNAI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A8A364D6;
	Fri,  9 Feb 2024 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488922; cv=none; b=oN6vQEsbqu0wTsMN2u0tB0fgw8/FRRi3+FW/dOYv8+lKxcY/yOK6Pe6CUm2x7Bk8Jd6jRJNw2Mvb9jvGCgUMyX+bybIPOZ4g/DEeptoyrcPCI4ah4yab4r9nQVcuSuGhQ+AYqjuTd0G2mnhcf54dvnue+n1CDoutwmFf/mOJpu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488922; c=relaxed/simple;
	bh=MV+1wvgJoYMaUdrs8Los4PA1gEmATP0tanOe8YKLDG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGpuIGKnppRtzKwXd7of2J88iosA1ZV5o/g3Oeu6EYqemtMblmqNb4fgFWPY9oltl2d+w/CsqtSQBShJH7W2FBJc9ibFiI0XF18whEdG6k3b2d5JIBBz2RcmncNi1vt3mCCYEQ56rU4UIlPS46Zfx5Zhi70EBeAqREvQM4ySv3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LsAzeNAI; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707488921; x=1739024921;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MV+1wvgJoYMaUdrs8Los4PA1gEmATP0tanOe8YKLDG0=;
  b=LsAzeNAI+nCi7J2XAQLOPUVqW5HR48sfvJAWMciQ0sZqv1tgjsK+auAg
   5a2Zlv+eymLnnsd9l/nmGJqLXog4jQIZMx/waX4Z7ieu2jowJcc/JcbKk
   8PmhTPzHJEm9d9aUUALM1MBTmHx9zj3EGNy3z5Yp1pdzbgGxxm9VSZwq7
   /4FRGtg6DDEKJroGdZzZx355IjTAO3KMqtij7fxc3JrEz86+y/TSYCTtt
   aQWoZK3TXlTt5DdpbUFazCTc0eWqA3qRmVbAXgwoBsF9VENy4w+6V0n+Q
   Cuv9w2dLYT0AgOm9Ly7A7Qxl5mXkdsBHHiCNBGc8azYq5C9DVlmz9thtu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1295384"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1295384"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 06:28:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="934437689"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="934437689"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 06:28:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rYRrl-00000003AfQ-2i2i;
	Fri, 09 Feb 2024 16:28:33 +0200
Date: Fri, 9 Feb 2024 16:28:33 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org, jthies@google.com, pmalani@chromium.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Rajaram Regupathy <rajaram.regupathy@intel.com>,
	Saranya Gopal <saranya.gopal@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] usb: typec: ucsi: Limit read size on v1.2
Message-ID: <ZcY2kVlUn7SJ5pW8@smile.fi.intel.com>
References: <20240209060353.6613-1-abhishekpandit@chromium.org>
 <20240208220230.v4.1.Iacf5570a66b82b73ef03daa6557e2fc0db10266a@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208220230.v4.1.Iacf5570a66b82b73ef03daa6557e2fc0db10266a@changeid>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 08, 2024 at 10:02:38PM -0800, Abhishek Pandit-Subedi wrote:
> Between UCSI 1.2 and UCSI 2.0, the size of the MESSAGE_IN region was
> increased from 16 to 256. In order to avoid overflowing reads for older
> systems, add a mechanism to use the read UCSI version to truncate read
> sizes on UCSI v1.2.

..

> +	if (ucsi->version <= UCSI_VERSION_1_2)
> +		buf_size = min_t(size_t, 16, buf_size);

Please, avoid using min_t(). Here the clamp() can be used.
Shouldn't magic number be defined?

-- 
With Best Regards,
Andy Shevchenko



