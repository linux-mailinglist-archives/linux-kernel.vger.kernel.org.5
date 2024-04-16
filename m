Return-Path: <linux-kernel+bounces-146912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D89A8A6CD6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B227C1F21E4C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF47712CD8A;
	Tue, 16 Apr 2024 13:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B3KQcMIo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E549E129A72;
	Tue, 16 Apr 2024 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713275509; cv=none; b=XzvriW7i54QCsS6Y9mxZxp4F8Ad+HDYSWWhk52H9xBKe3A+nRPxyr0hH7vcEHOSI1K8K0MyAEFGzLk6TN5TA0iU+v+dmQAMph3EBEnSmMEHmY06RXV63UkFXtSkkcU7xQZrQWiuLNsXKXBwAVdaOw9PNnoPex4WQSMO/X8gR5hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713275509; c=relaxed/simple;
	bh=Ab6ExhI50HHlXfTzEgRQO3WrIT25v+iB5W0OUeFHTs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJ+FmPVcvPtp7zvLUHx475Lz1N9YlcUFrzIYXD8mx5zkciEehBekjvk0bfb38trOJrx1IQbg9TRmd4XQGgce9bYYGLTfbEMI8KHd6vyReww8ukBFqn1MiKOK/nCIZHoetQU48eN/zNpv94BbhbJQqVoDIRJHPFG5a1qsonaXET0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B3KQcMIo; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713275508; x=1744811508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ab6ExhI50HHlXfTzEgRQO3WrIT25v+iB5W0OUeFHTs4=;
  b=B3KQcMIobTk9dI3HVShyqhCfk/szc1CA6RqM43tTk/aHiB1QpP5aF5sV
   /79cZdH4Bf4Ci+SbCpYy1heBBHhzZ63NW1gWxuHqM7QEk98R7FIWCKQgk
   K1oJo8w63pYgdsh+Lzgie8LHoefxEZIywrXH5gVGj7kh4a02fn1i80o+3
   XsAVu7H/Noqj7vUIaHmWFiMYP26xc16fSaPl9GidVArZBIpQLlLdBZ23n
   tx7uXuDjqIKQjZTFwSkHngoJFNHF4MFZCzA7g8/i9WAIJxxmgzkOXbxyu
   h550VzTdtG/fqsbjktaG6cw+l/eUq294KUDQJ3FM7/XmTEDFN3ag+gIWZ
   A==;
X-CSE-ConnectionGUID: mxKUn/M7RaqLE0d3xeEo5g==
X-CSE-MsgGUID: sG7XSuPuTROBgg/WUtIEJA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="20134949"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="20134949"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 06:51:47 -0700
X-CSE-ConnectionGUID: Q2HgK0eoSS6kDOKfyNho/Q==
X-CSE-MsgGUID: tGetGZBlQsafQxNQgcVz4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="53246815"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 06:51:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rwjDp-00000004i8a-004e;
	Tue, 16 Apr 2024 16:51:41 +0300
Date: Tue, 16 Apr 2024 16:51:40 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Guanbing Huang <albanhuang0@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
	linux-acpi@vger.kernel.org, tony@atomide.com,
	john.ogness@linutronix.de, yangyicong@hisilicon.com,
	jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, lvjianmin@loongson.cn,
	albanhuang@tencent.com, tombinfan@tencent.com
Subject: Re: [PATCH v8 1/3] PNP: Add dev_is_pnp() macro
Message-ID: <Zh6CbFv1steiQUHO@smile.fi.intel.com>
References: <cover.1713234515.git.albanhuang@tencent.com>
 <4e68f5557ad53b671ca8103e572163eca52a8f29.1713234515.git.albanhuang@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e68f5557ad53b671ca8103e572163eca52a8f29.1713234515.git.albanhuang@tencent.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 16, 2024 at 11:16:18AM +0800, Guanbing Huang wrote:
> From: Guanbing Huang <albanhuang@tencent.com>
> 
> Add dev_is_pnp() macro to determine whether the device is a PNP device.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



