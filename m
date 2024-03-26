Return-Path: <linux-kernel+bounces-119298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C74688C6C8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E7CC2C827E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098D313C831;
	Tue, 26 Mar 2024 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eqKLm1My"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A0813C80C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466662; cv=none; b=aQW5aVUjsBnFshdmgW+BwvzfyRXrYe0HCyY04SwID5VjcpayXOVgF9BnsgXIUWntS0gdz4mjA9CR4MO7h2yzrfaABXw00FBaABT2nc2G2eahw9TWlDPyAI5bPHRdeTEE5Qs10bpGVt9ID956U+HwKVzuIzDHB7tc9/M3JbLMF2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466662; c=relaxed/simple;
	bh=7HHxTYsZehACgXN3N2grpypYbpYs9/6vgZAbivJU8Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIk3leqfugCQKhIQcu60enVTp0XCSN3YESazeWURcaG66KG+j+Gkh7NL0QFOaM1bDd5bJ24rf8EvNvnOxHs/pRX+oqlhelXTCB8hdhP98Pr97qta9/LwqAkaj+RtKZAJlHlgeEZshuOJt1hEOAweQkO0SwJpfz5gSmhZ28QUPtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eqKLm1My; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711466660; x=1743002660;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7HHxTYsZehACgXN3N2grpypYbpYs9/6vgZAbivJU8Cg=;
  b=eqKLm1MyCbeX3l7LGeGudQVWyrrUkxOYsYNXLCZ1snFh0QjYxtxWCXt2
   krXY+qNFCu/vlYTWnmdSVdaqu4FGmE/kSJOeM0v7o/JtH6vrljrP1iBC5
   aAFhns+FA0o1OHat6u3NDAbnTiim0b6dRBSmtxoG5uX0e/9EJpdWsfhbw
   D9ZrX3MkCWKPQ5namQtNci5zl4heVcl9Y4UmmQYm9F4VSN9UJzQgdgfDK
   k9xeM/XsC4lflYstnwGpGnFNiX1iw9UNmVJTrSPP7EyQEjKenqHB4m4Qs
   WN0DBbqHEwOsrVDd6FVoRZvbUnRJ4xQAOQr6BT5exinLWw1RfSaP4v6sV
   w==;
X-CSE-ConnectionGUID: cXkjuM3jRXe/auKwDkANig==
X-CSE-MsgGUID: RlfhmAvkTymUYBHfEeBhYw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6419977"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6419977"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 08:24:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914883216"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="914883216"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 08:24:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rp8eu-0000000GL2J-3O1Q;
	Tue, 26 Mar 2024 17:24:16 +0200
Date: Tue, 26 Mar 2024 17:24:16 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mateusz K <mateusz.kaduk@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Switch over to MSI interrupts
Message-ID: <ZgLooJa1JVKEMOtf@smile.fi.intel.com>
References: <20240312165905.1764507-1-andriy.shevchenko@linux.intel.com>
 <20240325211915.GA1449994@bhelgaas>
 <CAPf=4Rc2vQrWqcs=-ND3iOZFJyKE7FdPoqU9w6DKjoSaJo6KaQ@mail.gmail.com>
 <ZgLefFQanbq-ozKM@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgLefFQanbq-ozKM@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 26, 2024 at 04:41:01PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 26, 2024 at 11:06:38AM +0100, Mateusz K wrote:
> > I tried the patch that changes PCI_IRQ_LEGACY into PCI_IRQ_ALL_TYPES
> > and it seems I get some other error now
> > 
> > [    1.477341] intel-lpss 0000:00:15.0: enabling device (0004 -> 0006)
> > [    1.477466] intel-lpss 0000:00:15.0: can't derive routing for PCI INT A
> > [    1.477468] intel-lpss 0000:00:15.0: PCI INT A: not connected
> > [    1.477488] intel-lpss 0000:00:15.0: probe with driver intel-lpss
> > failed with error -2147483648
> > [    1.489572] intel-lpss 0000:00:15.2: enabling device (0004 -> 0006)
> > [    1.489688] intel-lpss 0000:00:15.2: can't derive routing for PCI INT C
> > [    1.489689] intel-lpss 0000:00:15.2: PCI INT C: not connected
> > [    1.489715] intel-lpss 0000:00:15.2: probe with driver intel-lpss
> > failed with error -2147483648
> > [    1.501886] intel-lpss 0000:00:19.0: enabling device (0004 -> 0006)
> > [    1.502034] intel-lpss 0000:00:19.0: can't derive routing for PCI INT A
> > [    1.502036] intel-lpss 0000:00:19.0: PCI INT A: not connected
> > [    1.502067] intel-lpss 0000:00:19.0: probe with driver intel-lpss
> > failed with error -2147483648
> > [    1.514288] intel-lpss 0000:00:19.1: enabling device (0004 -> 0006)
> > [    1.514535] intel-lpss 0000:00:19.1: can't derive routing for PCI INT B
> > [    1.514538] intel-lpss 0000:00:19.1: PCI INT B: not connected
> > [    1.514570] intel-lpss 0000:00:19.1: probe with driver intel-lpss
> > failed with error -2147483648
> > [    1.526291] intel-lpss 0000:00:1e.0: enabling device (0004 -> 0006)
> > [    1.526555] intel-lpss 0000:00:1e.0: can't derive routing for PCI INT A
> > [    1.526557] intel-lpss 0000:00:1e.0: PCI INT A: not connected
> > [    1.526604] intel-lpss 0000:00:1e.0: probe with driver intel-lpss
> > failed with error -2147483648
> > [    1.538130] intel-lpss 0000:00:1e.3: enabling device (0004 -> 0006)
> > [    1.538233] intel-lpss 0000:00:1e.3: can't derive routing for PCI INT D
> > [    1.538235] intel-lpss 0000:00:1e.3: PCI INT D: not connected
> > [    1.538253] intel-lpss 0000:00:1e.3: probe with driver intel-lpss
> > failed with error -2147483648
> 
> Hmm... I have a unique board to test :-)
> Let's revert it then.
> 
> Bjorn, in such case your tree should keep conversion one.
> 
> Lee, do you prefer a revert or can you simply drop this from the queue?

Hold on, but IIUC this is the report about new hardware that never had
a support by Linux before.

-- 
With Best Regards,
Andy Shevchenko



