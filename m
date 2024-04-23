Return-Path: <linux-kernel+bounces-155244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F928AE74A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B890928CCD6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14049134CEC;
	Tue, 23 Apr 2024 13:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NvuhISo7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28911332B0;
	Tue, 23 Apr 2024 13:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877438; cv=none; b=JnclXTCpovp1sRqJYugVI7jU+u13O8N1Z3MH+FbVyH8vc4Q1cpGKrBC2/lwfdBShA4GUTFaaa4rO35wEaOcLleMtzcvOiA5EWV3GtewUbOivnZKajx6mwfzmhKzRKul6oIQwxUm2fWpbNqNGnlAYaqOgPrOKq/83QruaSQjetYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877438; c=relaxed/simple;
	bh=Li9/WpJDpV2KfWklmIjfsUxBpoGOgyh0/7ysFbfEd3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=am9l1Nqrrh0xVOSfhwPpuhLZPofDRIE4DHzJ4IuzKGUooVJejSidI+vtSS/jQhD+Iznr9HEpLrrQaIwpPI6PjJNctnulfcnSohz8G5kd0XaBN4S421u67uofB3gnJrxtyL3uypklSfY/9ATNa7baXMDXTbbnI3DFJf6/tI3T3ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NvuhISo7; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713877437; x=1745413437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Li9/WpJDpV2KfWklmIjfsUxBpoGOgyh0/7ysFbfEd3g=;
  b=NvuhISo7bVv4fgkJ6WR+TN/oCCNTg5JLGsCo2oSyV8fbDv6zuoq4ALw/
   ie/88DkVLLO7kpj6DrVGQ7iaXLGf88hYch3//2fGTe5hGArFp0goN4Pdg
   LlRxGnfsJvPoDoDBgtwysaNxOj8LnKfs6uFcib+TrhA0mQ+jd6HEeFCHv
   H8IYbZ4pP/N7NKgWfH94eKbKh/dvQC0qMnt8CRO3GIgUFVaBQAtWcTlpq
   G5plRLhf7cMHvAKHA0ssSnN7oyxGgoTd+FNlYTndW2Ip9K1Xm7LkzZY4z
   KuQ5vhH7NUWUm6064T7gRySmzElKYS+H94CJw6YEwm/5JgenW1w7IBMKX
   w==;
X-CSE-ConnectionGUID: ZBR72mTVTHCA5njhc4vZMQ==
X-CSE-MsgGUID: rhKlHzDxSkOagkvJuurYpQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="20155859"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20155859"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 06:03:56 -0700
X-CSE-ConnectionGUID: BiqgyUWQSXKSwIAaWAJOsA==
X-CSE-MsgGUID: YN2U+YB/SPm3Qv3KGXQjvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24344034"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 06:03:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzFoN-00000000L5i-1beZ;
	Tue, 23 Apr 2024 16:03:51 +0300
Date: Tue, 23 Apr 2024 16:03:51 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v1 1/1] platform/x86: classmate-laptop: Add missing
 MODULE_DESCRIPTION()
Message-ID: <Ziext29Er2PHb4Ud@smile.fi.intel.com>
References: <20240422151238.2051330-1-andriy.shevchenko@linux.intel.com>
 <ZiegXwf0zK_cIhdR@siri.cascardo.eti.br>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiegXwf0zK_cIhdR@siri.cascardo.eti.br>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 23, 2024 at 08:49:51AM -0300, Thadeu Lima de Souza Cascardo wrote:
> On Mon, Apr 22, 2024 at 06:12:38PM +0300, Andy Shevchenko wrote:
> > The modpost script is not happy
> > 
> >   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/classmate-laptop.o
> > 
> > because there is a missing module description.
> > 
> > Add it to the module.

..

> > +MODULE_DESCRIPTION("Support for Classmate PC ACPI devices");
> 
> How about "Support for Intel Classmate PC ACPI devices", like the
> Kconfig devices?

Whatever maintainers prefer.
Thank you for looking into this.

-- 
With Best Regards,
Andy Shevchenko



