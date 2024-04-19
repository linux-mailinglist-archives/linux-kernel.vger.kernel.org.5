Return-Path: <linux-kernel+bounces-151449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DF38AAF19
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 449711C20FAB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDD886642;
	Fri, 19 Apr 2024 13:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T3ruHu/x"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C811685C66;
	Fri, 19 Apr 2024 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713532288; cv=none; b=kE5UDEIksfhPrUkPDnzzci5R2sG8niuzFLzv5G4obdOC1h74uNgvTTtv9G7dIMUruGvyQUXpZN1Bj1X3p9g0wk7pPP+ewxSd/EDk8+nFACKc8cJnO+YdPXUV8d4TyB+MEpRyJsj8j5ZxE012QWgDnQT8HDZoUR+rv5PfvcbQMSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713532288; c=relaxed/simple;
	bh=5XGX/Ye8FpOuF+a1rEVVlIlT5QIHfcDllEy08pVVaDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+4GtPBGqWSrNG3W6QvYzcCYH0iEJAwjw4V0WlaCvnsqjZbYCchVqt6f41HmF2RtMZyer1L62Sy/7LUB4sR62X9ajTc+8P5cgCsZp/8RSmBFweHzzgs1JSjvKa/igF/525lxIE3KlDr9iOL1VTP8rW+bBFN7uP2UoDl9Gbxv/sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T3ruHu/x; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713532287; x=1745068287;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5XGX/Ye8FpOuF+a1rEVVlIlT5QIHfcDllEy08pVVaDw=;
  b=T3ruHu/x9PYunZyUVswdPybpSuaa0LedY01Wm/YHuWZ8Pj7M/tVnYq36
   5yagbxSk2jqNSTVva/UPEDfybLggVEY/vzoC2SbyltUw/48co9ZMdbF3B
   Pdiq1uEy+ikGAudw1eP3AaVRrxo0n1ly/5xwR4CqsBLDeBV5AnrWeAERV
   73SAXOCh5oC3f1D9FRCc04c31YsX+84iddwwVhPxETiTVwvGr6MLRmiqI
   pTVaqR5dW5my/WlkpgiRhfzxfi4E9rQ3mBAEJI6stk4F9h4TIN9aq2714
   deMP9wNf0UxoAuzblSSBRlzQa/Ap8Hj5dCWPi1Fblc04lIbsOKqmV/awC
   Q==;
X-CSE-ConnectionGUID: 2wQkTeToQzaYNp3hrMXIlA==
X-CSE-MsgGUID: 4041bUk/RE+pQFZ4foLuZw==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="20523359"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="20523359"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 06:11:26 -0700
X-CSE-ConnectionGUID: uMT1LSi8QI2zQ61+kp8WmQ==
X-CSE-MsgGUID: f4lR2tpMSlaLoliVJUp49Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23355879"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa009.fm.intel.com with ESMTP; 19 Apr 2024 06:11:24 -0700
Message-ID: <2b704ce4-1626-1227-213c-11bce35cf7b9@linux.intel.com>
Date: Fri, 19 Apr 2024 16:13:14 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v1 0/2] xhci: pci: Little PCI IDs refactoring
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Niklas Neronin <niklas.neronin@intel.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@intel.com>
References: <20240418154928.3641649-1-andriy.shevchenko@linux.intel.com>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20240418154928.3641649-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.4.2024 18.48, Andy Shevchenko wrote:
> Just a couple of updates to the PCI IDs in order of better maintenance.
> No functional change intended.
> 
> Andy Shevchenko (2):
>    xhci: pci: Use full names in PCI IDs for Intel platforms
>    xhci: pci: Group out Thunderbolt xHCI IDs
> 
>   drivers/usb/host/xhci-pci.c | 30 ++++++++++++++++--------------
>   1 file changed, 16 insertions(+), 14 deletions(-)
> 

Thanks, added to my for-usb-next branch

-Mathias

