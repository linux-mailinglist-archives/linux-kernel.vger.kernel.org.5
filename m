Return-Path: <linux-kernel+bounces-148120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8854D8A7DF6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9AF01C2196E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6AE7D3F5;
	Wed, 17 Apr 2024 08:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJxw78Xg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1C96A8D0;
	Wed, 17 Apr 2024 08:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713341923; cv=none; b=RfKLXv6VgAOxPFdGE3hbQmnXr307eCiBbDaHjgemhw1fylRafmWnzYULRPBvXNSDV43jtVRHPEHvXL99UwCazboGutNWg+Crh8RXrxTl5SYURtiqwGibPMIltYbhM3qKBlm5sSZwaxRiyP2N1zfpiQ5OfE5u9csJiIF65qBC1uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713341923; c=relaxed/simple;
	bh=a3P9nelLo/PDdkDikvNisOmc9OwfBNQXroeq20WsmG4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Mk35jLO28Q/184ORKhjZh8Jpbp8uxTmj7/tRB3ZeqExpDi/R69E2XDWymFYBUhYtLWTICIZ5RSeFw+6GuflOQ6ayhdbiajN7j3wNOT6+5ssrbxJCR11l1YdXkVDkShrOPTYBfxkhkxySCqKd1P6RrqkZFmJD/+4MhbdTL8C1N7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NJxw78Xg; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713341922; x=1744877922;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=a3P9nelLo/PDdkDikvNisOmc9OwfBNQXroeq20WsmG4=;
  b=NJxw78XgoZvaNBxPtbupMFflS24SGXY/RQ7Ultm3QNkUuA1CblNnuiRC
   yT7EqW904HwEvYFZkMIRurgc/VBkigML0vIOIJ3FdOzw7HHqPugBs3f6r
   z9TLtgDlFcbDt7xAE1WXbmmFcD7sbYL0ZG1Ce2X/jIlNTkfJYNrG37xej
   fjVXosNqd0bH273CaqFzTZ/oMiZXw4VMJKo0L9rOL7zmPub/a11ZMOD+0
   PeMnejblOPD1pPIIaVeYxesdBdIMq565DaK7D/3oyf1B1ssSzosIgg05u
   dxN+TTQKdJD15E7wRqCkDpvq/v5pAXU4tVGrHefux99XS0dD4f3VTpetz
   Q==;
X-CSE-ConnectionGUID: GKsHBWpfT/C98SRjXpf6tQ==
X-CSE-MsgGUID: SgJsr82XT1WORxOQ1j6Umw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="20209618"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="20209618"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 01:18:40 -0700
X-CSE-ConnectionGUID: Q4Xhe7nSTmGgIbThMNYtYQ==
X-CSE-MsgGUID: o+pWPl+fSAOWLovgwsIK7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="22552533"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.35])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 01:18:37 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 17 Apr 2024 11:18:33 +0300 (EEST)
To: Michael Pratt <mcpratt@pm.me>
cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    Wander Lairson Costa <wander@redhat.com>, 
    Vamshi Gajjela <vamshigajjela@google.com>
Subject: Re: [PATCH v2 1/3] serial: core: Store fifo timeout again
In-Reply-To: <zTaajAZtS59Hv5offvbHJV1ptivBxD4WaZP_M-zQkicUtDb4mokpuKCFGIzUVL3p2yDSqHx9Uf2vIYVlbGeHN8xMJ6H3VWxwH3MPe1cH5a4=@pm.me>
Message-ID: <35bd3e50-8a60-7c0e-23a9-ae483e293a15@linux.intel.com>
References: <20240416182741.22514-1-mcpratt@pm.me> <20240416182741.22514-2-mcpratt@pm.me> <Zh7KV0FuM2B56J7w@smile.fi.intel.com> <zTaajAZtS59Hv5offvbHJV1ptivBxD4WaZP_M-zQkicUtDb4mokpuKCFGIzUVL3p2yDSqHx9Uf2vIYVlbGeHN8xMJ6H3VWxwH3MPe1cH5a4=@pm.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 16 Apr 2024, Michael Pratt wrote:
> On Tuesday, April 16th, 2024 at 14:58, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > > + if (port->fifosize > 1)
> > > + port->timeout = uart_fifo_timeout(port);
> > 
> > 
> > else
> > port->timeout = port->frame_time;
> > 
> 
> 
> Consistent with what I said in the other reply, the only reason that
> I have an if statement here, is to avoid doing extra math for devices
> without a fifo, as a specifically calculated timeout value would be useless
> in those cases.

Please benchmark to show this actually matters if want to make this claim. 
Otherwise just do the math always.

> However, if you don't like the 10 ms default timeout, perhaps port->frame_time
> could actually be a more reasonable default value? That is, provided 
> that we have a process 
> for calculating the proper value already in place...

While it would be a step toward the correct direction, you'd still need to 
add the safety there which is already done by uart_fifo_timeout(). So no, 
I don't think there's advantage of using port->frame_time over just 
calling uart_fifo_timeout() and ensuring uart_fifo_timeout() is always 
using at least 1 as the FIFO size when it does the calculations.

-- 
 i.


