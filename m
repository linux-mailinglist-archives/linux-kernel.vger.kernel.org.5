Return-Path: <linux-kernel+bounces-166774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE3C8B9F5D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B71281D3D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1577E16FF39;
	Thu,  2 May 2024 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PGZZtTEb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A042EB11;
	Thu,  2 May 2024 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714670408; cv=none; b=A1CcFQufdytz9KfamUaAIJsgf3TjeUhL39n/QuCgqg5IoRPV/pA2AGyGA4ebEQCAFJrH0EWPoMVLKmO+PJlBmz7tH5iIZgLxC+Ex8Shw6MdjUUc2GOwzePoKZXjxOnJQ3uJWTtQO9WW4W45z9mS8drzrgYemAscDt/A9saPEWqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714670408; c=relaxed/simple;
	bh=H1r0dFqw/FdPrkaepk5MGTXmiIihWSraJ3Ov/oH+da0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQkwPW3LL4rmcFPWoFyNp/K5hzWgJq5idEd1xYHwbJSfVxtPz+XtSC/qwDRbNtdrslqthuDhpr3ZYFBZmSh+5VTXDW/xOTI/FWOcjk2VzRihHSvj5XjG7+zqgYoB5pd2738HYyhtaEOtmpmyal69HW4tvb4hT6DVfVhdleQnBRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PGZZtTEb; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714670407; x=1746206407;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=H1r0dFqw/FdPrkaepk5MGTXmiIihWSraJ3Ov/oH+da0=;
  b=PGZZtTEbFu92asBvm4whCR6akWTrRynjGP1lm/5hUVUpZw9W00Fph4s9
   RlHZfWHkF9ThpsMjcOihmH1aUEmZ7buRFBjp+AOIVgA84BAOJlF6wK6bk
   HbaYXPp1cBAWrloNm5TiR5ctOvHBT2ukFYOvmM3vpS9OhdOzquNIVllzI
   hg4UahUWzqVUYNPxZU3mkNosYCeSoorop+F9UU89CeuiyzBrzYs6NvnBF
   uCAd8fROcDqQ2KZowIkZv2CNpMCNKnDcxPDHqYl/SgxCGIyghua/mjPX5
   Zb6SyNr0Ozethrwk7lom6nfmpnR0e8gLEHG/+gZ0JMqUb6H2ntgTVSeqT
   Q==;
X-CSE-ConnectionGUID: oZO9deo4Sa2KyDcGbr8pOg==
X-CSE-MsgGUID: wxMmL3vdTEurMObksBOcXA==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10672867"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10672867"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 10:20:06 -0700
X-CSE-ConnectionGUID: GwxzvMC6RVuJch4h+jyxeQ==
X-CSE-MsgGUID: oV/NS6ryRR6Jhdam4E7xMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="32000691"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 10:20:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s2a6D-00000003Ogg-1sUg;
	Thu, 02 May 2024 20:20:01 +0300
Date: Thu, 2 May 2024 20:20:01 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Parker Newman <pnewman@connecttech.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 11/13] serial: 8250_exar: Use BIT() in exar_ee_read()
Message-ID: <ZjPLQeTEKvt7B3mj@smile.fi.intel.com>
References: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
 <20240502144626.2716994-12-andriy.shevchenko@linux.intel.com>
 <702a9145-5bc1-c765-a1fa-278702741637@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <702a9145-5bc1-c765-a1fa-278702741637@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 02, 2024 at 07:08:21PM +0300, Ilpo Järvinen wrote:
> On Thu, 2 May 2024, Andy Shevchenko wrote:

..

> >  	// Send address to read from
> > -	for (i = 1 << (UART_EXAR_REGB_EE_ADDR_SIZE - 1); i; i >>= 1)
> > -		exar_ee_write_bit(priv, (ee_addr & i));
> > +	for (i = UART_EXAR_REGB_EE_ADDR_SIZE - 1; i >= 0; i--)
> > +		exar_ee_write_bit(priv, ee_addr & BIT(i));
> >  
> >  	// Read data 1 bit at a time
> >  	for (i = 0; i <= UART_EXAR_REGB_EE_DATA_SIZE; i++) {
> > -		data <<= 1;
> > -		data |= exar_ee_read_bit(priv);
> > +		if (exar_ee_read_bit(priv))
> > +			data |= BIT(i);
> 
> Does this end up reversing the order of bits? In the original, data was left
> shifted which moved the existing bits and added the lsb but the replacement
> adds highest bit on each iteration?

Oh, seems a good catch!

I was also wondering, but missed this somehow. Seems the EEPROM is in BE mode,
so two loops has to be aligned.

-- 
With Best Regards,
Andy Shevchenko



