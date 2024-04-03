Return-Path: <linux-kernel+bounces-129474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C730896B54
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DF591C268CC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7831369A0;
	Wed,  3 Apr 2024 10:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+TBujWd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE42F136E27;
	Wed,  3 Apr 2024 10:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138512; cv=none; b=m67uvU2OeAUULhU5vhLmCAx23ZvXFL5SH9+1K/FqwDTtz1xaAc48XLvx51qHqBQKiDF4r9ldgLQrvjdocxsK6FPMdcWKlwMcIk4yJDO65Vn/I1nF8QhiH+NP+LyCg7I+DgCwaxWRcOGJOzQ3RnEEc0XZySTj4FMIqDWIIzLkEFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138512; c=relaxed/simple;
	bh=EA+ZFPZ6jRivlcUtUTudg4JSB1pCqc/k6F6TD0Ho0BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5a8EZ9KrMlih6eQ7sKMpzZNxen8iwHtECeItdb6HHy6n1QXkQjbYtm7LkGJ9lNiIsiIU7B4jQlb0Ssxes31i9Kvx11CrtR2o3mVlbjzW+e5cjVgcE7axZDfJ+d0/jX0SbAV6PiR569P1jmaNMsat7odDebfTfWgOYLAmY9FtSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+TBujWd; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712138510; x=1743674510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EA+ZFPZ6jRivlcUtUTudg4JSB1pCqc/k6F6TD0Ho0BQ=;
  b=J+TBujWdF5w1MY0YubeYJ2MsUeq4zIvq//MA8tmnp2aHkFna0TX7Mg2w
   xm6Fr8aFQ6vNhZLHpCFs3rXWTHz9ResetDyfxvQ+qRVeH2mQ4n9O6WtHZ
   +wLqiKxEf8TtVh5xf/r389YVqiyf5QgcRLPqkcWW80ZBp+3qjQoO4t8n9
   NDLkja4wa63ZcbUBOhaTiHb60JlneCn4uV/yKcT78oZJJF9cjj5zNd5PP
   i5w5PW4JZwu0ZSaKbxDxr37ysbl5k11YJY0l9LrDlbp+gXy67x8pnjjgP
   /zT77WAlFVjr39Zq/JwRmUhxQQXwReMatIAqSm0F0xZwLMyRwOyw99nTT
   w==;
X-CSE-ConnectionGUID: Pbn02PEaSLC7IrcEsp0brw==
X-CSE-MsgGUID: N3zAB50zQ0u5BwhfoFQ/mA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7485125"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7485125"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:01:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915177150"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="915177150"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:01:46 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rrxRA-000000015D0-0K6U;
	Wed, 03 Apr 2024 13:01:44 +0300
Date: Wed, 3 Apr 2024 13:01:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guanbing Huang <albanhuang@outlook.com>
Cc: gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
	linux-acpi@vger.kernel.org, tony@atomide.com,
	john.ogness@linutronix.de, yangyicong@hisilicon.com,
	jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, lvjianmin@loongson.cn,
	albanhuang@tencent.com, tombinfan@tencent.com
Subject: Re: [PATCH v4 0/3] serial: 8250_pnp: Support configurable reg shift
 property
Message-ID: <Zg0pBzp5IRPkrZeQ@smile.fi.intel.com>
References: <PSAPR06MB49524F135EBF81C4F2D181BCC93D2@PSAPR06MB4952.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSAPR06MB49524F135EBF81C4F2D181BCC93D2@PSAPR06MB4952.apcprd06.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 03, 2024 at 03:41:27PM +0800, Guanbing Huang wrote:
> From: Guanbing Huang <albanhuang@tencent.com>
> 
> The 16550a serial port based on the ACPI table requires obtaining the
> reg-shift attribute. In the ACPI scenario, If the reg-shift property
> is not configured like in DTS, the 16550a serial driver cannot read or
> write controller registers properly during initialization.
> 
> To address the issue of configuring the reg-shift property, the 
> __uart_read_properties() universal interface is called to implement it.
> Adaptation of pnp devices is done in the __uart_read_properties() function.

Thank you!

I have a few comments, mostly cosmetic except a couple in the last patch.
Most likely the v4 will be good enough for merging.

-- 
With Best Regards,
Andy Shevchenko



