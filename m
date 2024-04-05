Return-Path: <linux-kernel+bounces-133431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBD489A393
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD8C1F2324C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984F0171672;
	Fri,  5 Apr 2024 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fNKG4nTQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC00F1D530;
	Fri,  5 Apr 2024 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712338667; cv=none; b=E0D1wBTwEgp2GzdtqkG8zZZvP/Gds1RU1NBlDv+eZXbKAIj3T1sARMzhjvabLSkPB1TbwRuEMqqCDNT4Zv4vU4xyg4iBGMwFlxE8UMbAhvJ2IQZrikItp22jxcYzxm0yGp1aSiHQNN5a6nhhJ0TWK/Kt7wWi0WWwBXY5HQkmGMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712338667; c=relaxed/simple;
	bh=UZDUh0kTXbBmXdiKJI1X1pCk4d0HwfR5a/OaqtzZ9wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxBek03RcK4oHW6X9UOsAIOmRaY5ReqLhGO2tS5uKPIg4Dl9T/Y3+kaKubYHHUCFf2Q7cd2DMJLn8ITX9ltXa2Cmrl1bR2LyIdjJEA7Hcshpn5+eCzHgHUjk2lmHGa3jQ8FSgqwCABJ+IQoEAsDGtOygk0X5+VJf1IW5/MN3tc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fNKG4nTQ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712338665; x=1743874665;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UZDUh0kTXbBmXdiKJI1X1pCk4d0HwfR5a/OaqtzZ9wg=;
  b=fNKG4nTQt41lqXAuIuxAfIonTkpQUNVAMfmYjmbljsnhE0d4z8EM59qp
   wn7RRR2xj839EhI8mBEodhjDJS12ELU2Z9+qtvT7afxmtkMkfl8zLQsCY
   bRdxHRi4Oo6ZPKUU0xX1LmdFj/QQxmBEa4FxZhzMXiSYY4X2+tq5pq6NW
   3G5TvxkDtcDsQ/LXGSU1Jx7+8ztXrGsjkRJ1yccZ31uHqoYXZtOppQbau
   leBbNnZl2scyz/uZwHYE1abMNk5VBi0c+zik7M3ZHIXIlE1jVGQVC5FZ4
   l2lTpoTPqi/BYjvuxJ0q/Sva/hj3E03mt6x4uYv7zkLfqvOFwxYlWa4jJ
   Q==;
X-CSE-ConnectionGUID: PZj0jjzuTL2RHVKhS+jwLQ==
X-CSE-MsgGUID: MqEwxBUqRFidUYYoPYH0yA==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7845016"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="7845016"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 10:37:44 -0700
X-CSE-ConnectionGUID: x1oKsbpiR1uCciUdQHgOzQ==
X-CSE-MsgGUID: Z8VcpAFQSJq+wtQ8yzIQFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="23959315"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.66.105])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 10:37:43 -0700
Date: Fri, 5 Apr 2024 10:37:42 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Kwangjin Ko <kwangjin.ko@sk.com>, dave@stgolabs.net,
	dave.jiang@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com
Subject: Re: [PATCH v2 1/1] cxl/core: Fix initialization of mbox_cmd.size_out
 in get event
Message-ID: <ZhA25pRuyiHJWcLj@aschofie-mobl2>
References: <20240402081404.1106-1-kwangjin.ko@sk.com>
 <20240402081404.1106-2-kwangjin.ko@sk.com>
 <ZhAhAL/GOaWFrauw@aschofie-mobl2>
 <20240405174056.00005422@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405174056.00005422@Huawei.com>

On Fri, Apr 05, 2024 at 05:40:56PM +0100, Jonathan Cameron wrote:
> On Fri, 5 Apr 2024 09:04:16 -0700
> Alison Schofield <alison.schofield@intel.com> wrote:
> 
> > On Tue, Apr 02, 2024 at 05:14:03PM +0900, Kwangjin Ko wrote:
> > > Since mbox_cmd.size_out is overwritten with the actual output size in
> > > the function below, it needs to be initialized every time.
> > > 
> > > cxl_internal_send_cmd -> __cxl_pci_mbox_send_cmd
> > > 
> > > Problem scenario:
> > > 
> > > 1) The size_out variable is initially set to the size of the mailbox.
> > > 2) Read an event.
> > >    - size_out is set to 160 bytes(header 32B + one event 128B).
> > >    - Two event are created while reading.
> > > 3) Read the new *two* events.
> > >    - size_out is still set to 160 bytes.
> > >    - Although the value of out_len is 288 bytes, only 160 bytes are
> > >      copied from the mailbox register to the local variable.
> > >    - record_count is set to 2.
> > >    - Accessing records[1] will result in reading incorrect data.  
> > 
> > Agree with the other comments on need to set .out_size when doing
> > cxl_internal_send_cmd() in a loop. Poison list retrieval can hit
> > this case if the MORE flag is set and a follow on read of the list
> > delivers more records than the previous read. ie. device gives one
> > record, sets the _MORE flag, then gives 5.
> > 
> > 2 other things appeared to me while looking at this:
> > 
> > First, it seems that there is another cleanup wrt accessing records
> > with invalid data.  Still focusing on get_events and get_poison
> > since those loop through output data based on a device supplied
> > record count. The min_out check means the driver at least gets a
> > count of records to expect. That's good. The problem occurs::
> > 
> > if (mbox.size_out != struct_size(payload, records, 'record_count'))
> > 
> > The driver will log garbage trace events, and that could lead to
> > bad actions based on bad data. (like a needless scan of device based
> > on a false overflow flag). So, checking that size.out is the proper
> > multiple of record_count protects driver from bad device behavior.
> > 
> > I think that can be combined w the patch Dan is suggesting to
> > reset mbox.size_out on each loop.
> Hi Alison,
> 
> I'd split it.  Dan's one is a bug fix, this is hardening against
> a device bug. Good to have but not really backport material unless
> we think there are devices like this out there.

Agree, not aware of actual device behavior.

> 
> > 
> > Second thing is the pci-driver quiet handling of PAYLOAD LENGTH
> > values reported by the device. It seems like at a minimum the
> > pci-driver could emit an info or debug message when the device
> > is reporting payload lengths that exceed what the driver can
> > copy in.
> 
> When does this happen?
> 1. New fields on end of a fixed length message.
>    Correct to silently eat it as the spec is buggy if we don't
>     have backwards compatibility.
>     I don't think the spec has had that particular type of bug yet,
>     but maybe I'm forgetting one.
> 2. Device bug.  Can't tell that is different from 1.
> 

My thought was 2) device bug. Bad device is returning payload length
that exceeds what pci/cxl-driver can consume, so gets ignored. Am I
worrying about debugging the hardware needlessly? 

--Alison

> So maybe dev_dbg(). I'm not sure why the cxl-driver would ever want to
> know.
> 
> > I'm referring to the mbox.size_out adjustment in
> > __cxl_pci_mbox_send_cmd(). Or, if it's not the pci-drivers job
> > to judge, pass that actual payload length value back in the
> > mbox structure (new field) so that the cxl-driver can use it.
> > The pci driver would still do it's "#8 Sanitize the copy" work,
> > but it would allow the cxl-driver to clearly see why it got the
> > .size_out it got, and squawk about it if needed.
> > 
> > --Alison
> > 
> > > 
> > > Signed-off-by: Kwangjin Ko <kwangjin.ko@sk.com>
> > > ---
> > >  drivers/cxl/core/mbox.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > > index 9adda4795eb7..a38531a055c8 100644
> > > --- a/drivers/cxl/core/mbox.c
> > > +++ b/drivers/cxl/core/mbox.c
> > > @@ -958,13 +958,14 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> > >  		.payload_in = &log_type,
> > >  		.size_in = sizeof(log_type),
> > >  		.payload_out = payload,
> > > -		.size_out = mds->payload_size,
> > >  		.min_out = struct_size(payload, records, 0),
> > >  	};
> > >  
> > >  	do {
> > >  		int rc, i;
> > >  
> > > +		mbox_cmd.size_out = mds->payload_size;
> > > +
> > >  		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> > >  		if (rc) {
> > >  			dev_err_ratelimited(dev,
> > > -- 
> > > 2.34.1
> > >   
> 

