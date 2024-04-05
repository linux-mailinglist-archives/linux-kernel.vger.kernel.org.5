Return-Path: <linux-kernel+bounces-133306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DF689A20B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB2711F23753
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AC717106A;
	Fri,  5 Apr 2024 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VoflRoZi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6978716FF5E;
	Fri,  5 Apr 2024 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712333067; cv=none; b=ZTwb/4rTKwmpa6jEfrVl5Ec9MpbSE/tlooOBrcvQ0dQwutAOf13W9DsEzhdQMm9pKW7tAwIab7vLi3pymdVhDQloHbA1/8SzXHuAEirb3+KZGhKbtQixVvheXu5DtvSveW91UEKS3TjBXoLAA6N/8yiLyE4FhUnPF51X2fyq/3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712333067; c=relaxed/simple;
	bh=HzlgdWXid2F7YZdfqpX9nxmD4r64rc5rFGKm2mra4Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSBWVQrAVhnasDE85Xvtrpd1w4/U0i2y8rKWe5jaEvqKyXVArCkP15UD6Kylae718iob09//c4komurx6lhhmGtsS8THCER4MOrkVVN7iEohN/mhSm7KT3FKJbOwNu29sO866m/UyZmmE4KDU2ODoUFoJVpTvXrixMwk52wFGvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VoflRoZi; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712333065; x=1743869065;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HzlgdWXid2F7YZdfqpX9nxmD4r64rc5rFGKm2mra4Qs=;
  b=VoflRoZi7DrSDGpgZo3SM/DQ8lfj8oZ+4fAwVH4Sugr9dgVhopPji2a4
   5mMXH3ApJV6hl2PpF/3vi8dx9wNkZBojCTvYgmRg/JgmW6V+PVjwSM/VW
   bNvpOl2XBmcunL8pKp0OqVMfzXA2BDM3W3OYY/u59kRcGmoCUhLw65dK5
   92QeBdoUmOTVv22L4vfZ/TQzsOX7A0f5Prq4HOJsdG+OYuPTfF8qhrT44
   IS+yAR1H+Wt0ysxy+F1MSeklnNLvL5h+qNA1s1U7TTY4aTGm7uYIqmeak
   l9wJhHPrIxYbDxwI1lJO5yAPFv+E6jsdYLQmaaTCWNNrj0lf+0+PLrqHJ
   A==;
X-CSE-ConnectionGUID: BZdyhfsUQk6H7tU+AFTVpw==
X-CSE-MsgGUID: s/iO4m//TuO7LPng6T9ZtQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="11487319"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="11487319"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 09:04:18 -0700
X-CSE-ConnectionGUID: FjLRRbSXQsuTGigPnwb/0g==
X-CSE-MsgGUID: ZlE1Ral/SNGMfVPx5SJR5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="50158048"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.66.105])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 09:04:18 -0700
Date: Fri, 5 Apr 2024 09:04:16 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Kwangjin Ko <kwangjin.ko@sk.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com
Subject: Re: [PATCH v2 1/1] cxl/core: Fix initialization of mbox_cmd.size_out
 in get event
Message-ID: <ZhAhAL/GOaWFrauw@aschofie-mobl2>
References: <20240402081404.1106-1-kwangjin.ko@sk.com>
 <20240402081404.1106-2-kwangjin.ko@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402081404.1106-2-kwangjin.ko@sk.com>

On Tue, Apr 02, 2024 at 05:14:03PM +0900, Kwangjin Ko wrote:
> Since mbox_cmd.size_out is overwritten with the actual output size in
> the function below, it needs to be initialized every time.
> 
> cxl_internal_send_cmd -> __cxl_pci_mbox_send_cmd
> 
> Problem scenario:
> 
> 1) The size_out variable is initially set to the size of the mailbox.
> 2) Read an event.
>    - size_out is set to 160 bytes(header 32B + one event 128B).
>    - Two event are created while reading.
> 3) Read the new *two* events.
>    - size_out is still set to 160 bytes.
>    - Although the value of out_len is 288 bytes, only 160 bytes are
>      copied from the mailbox register to the local variable.
>    - record_count is set to 2.
>    - Accessing records[1] will result in reading incorrect data.

Agree with the other comments on need to set .out_size when doing
cxl_internal_send_cmd() in a loop. Poison list retrieval can hit
this case if the MORE flag is set and a follow on read of the list
delivers more records than the previous read. ie. device gives one
record, sets the _MORE flag, then gives 5.

2 other things appeared to me while looking at this:

First, it seems that there is another cleanup wrt accessing records
with invalid data.  Still focusing on get_events and get_poison
since those loop through output data based on a device supplied
record count. The min_out check means the driver at least gets a
count of records to expect. That's good. The problem occurs::

if (mbox.size_out != struct_size(payload, records, 'record_count'))

The driver will log garbage trace events, and that could lead to
bad actions based on bad data. (like a needless scan of device based
on a false overflow flag). So, checking that size.out is the proper
multiple of record_count protects driver from bad device behavior.

I think that can be combined w the patch Dan is suggesting to
reset mbox.size_out on each loop.

Second thing is the pci-driver quiet handling of PAYLOAD LENGTH
values reported by the device. It seems like at a minimum the
pci-driver could emit an info or debug message when the device
is reporting payload lengths that exceed what the driver can
copy in. I'm referring to the mbox.size_out adjustment in
__cxl_pci_mbox_send_cmd(). Or, if it's not the pci-drivers job
to judge, pass that actual payload length value back in the
mbox structure (new field) so that the cxl-driver can use it.
The pci driver would still do it's "#8 Sanitize the copy" work,
but it would allow the cxl-driver to clearly see why it got the
size_out it got, and squawk about it if needed.

--Alison

> 
> Signed-off-by: Kwangjin Ko <kwangjin.ko@sk.com>
> ---
>  drivers/cxl/core/mbox.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 9adda4795eb7..a38531a055c8 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -958,13 +958,14 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  		.payload_in = &log_type,
>  		.size_in = sizeof(log_type),
>  		.payload_out = payload,
> -		.size_out = mds->payload_size,
>  		.min_out = struct_size(payload, records, 0),
>  	};
>  
>  	do {
>  		int rc, i;
>  
> +		mbox_cmd.size_out = mds->payload_size;
> +
>  		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>  		if (rc) {
>  			dev_err_ratelimited(dev,
> -- 
> 2.34.1
> 

