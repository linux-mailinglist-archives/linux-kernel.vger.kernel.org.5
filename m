Return-Path: <linux-kernel+bounces-164844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1B28B83E4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 03:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56B6AB227B7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C694C66;
	Wed,  1 May 2024 01:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LFH541BA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7382FB2;
	Wed,  1 May 2024 01:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714525787; cv=none; b=iX+tdBkKjR7KPtlBRkR1KCqo0MT/0WZtiXdwqQaVNBj/l/6EteP4gLolKMs/wEvweFstlcnoN0JRSnnirYsPgHwz1Mz8z/q+/ediC2O+R8WAYbEXGvkPO+KR1N7P53auXsKkkoS0Ybe0C49PWcDCnYrFB3UD3M04E2SJxKD/HP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714525787; c=relaxed/simple;
	bh=E0IpsGQKX/17ZdBYyaU+WSWYiem1DQecMnV3/CgDERs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXJFwRFx5Phymd7s4slDw1O+0ARBAJ7pRMLgGVvJtfBJgKzK+VlxgUYd+f9iPfJB9ywDQAHaUwOOMiiaidv4MW5APFdQQn9OM5l8ExIZxnwTgXKMVYlq5Hhwp5dIqSEHlxe4+dLxOc+iq6VytAlmBMsT+PNbDb79K44QMhPG7vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LFH541BA; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714525786; x=1746061786;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E0IpsGQKX/17ZdBYyaU+WSWYiem1DQecMnV3/CgDERs=;
  b=LFH541BAsdGgz6UaBnUX0LiHZo47EPhRB1EXEn1lIT2TstS+cdozjH/i
   l/BVCZpicwGw/AvhJPtg168vGcEnE8Vj/Sm2BhzykdrXQE7ZSeHEHdCsf
   DIxXKLOgw5F0+u2l307rQ3gPLpgQbaebw7EyEqklCZNDcidICkSXMY4RA
   ImvKcZ/NYJyPFVwr0fCX7FBu7NY3SfmM50k5jPGoJgzPvXin1zV9c+B9o
   OEuclaeKJAbcKrrar2rbdAgghtCEst0re1/6Nu3iXzqKAZ1Ak2CCQ/OL/
   fVLRuujTuYtfGpSx8QttdUcO5fxZD/iJ3Di+YIwo0ibH+vKQZoDWyH2t2
   Q==;
X-CSE-ConnectionGUID: QeCPmTouTlKDfzV3hW2J5w==
X-CSE-MsgGUID: rZCUp0fITj+QvO0/lvJm/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="32756884"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="32756884"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 18:09:45 -0700
X-CSE-ConnectionGUID: 8gMlKynWTUeuMJDunR9Xgw==
X-CSE-MsgGUID: Kv2vWbl4RduSP1SD9vXxcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="31256275"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 18:09:45 -0700
Date: Tue, 30 Apr 2024 18:16:29 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	"srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
	"Brown, Len" <len.brown@intel.com>,
	"stanislaw.gruszka@linux.intel.com" <stanislaw.gruszka@linux.intel.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Neri, Ricardo" <ricardo.neri@intel.com>
Subject: Re: [PATCH 4/4] thermal: intel: hfi: Tune the number of CPU
 capabilities per netlink event
Message-ID: <20240501011629.GB29652@ranerica-svr.sc.intel.com>
References: <20240429234152.16230-1-ricardo.neri-calderon@linux.intel.com>
 <20240429234152.16230-5-ricardo.neri-calderon@linux.intel.com>
 <849b5bd75707433c6a7d9b854f8e3b5fd17dcba0.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <849b5bd75707433c6a7d9b854f8e3b5fd17dcba0.camel@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Tue, Apr 30, 2024 at 05:07:54AM +0000, Zhang, Rui wrote:
> On Mon, 2024-04-29 at 16:41 -0700, Ricardo Neri wrote:
> > The number of updated CPU capabilities per netlink event is hard-
> > coded to
> > 16. On systems with more than 16 it takes more than one thermal
> > netlink
> > event to relay all the new capabilities when processing an HFI
> > interrupt.
> > This adds unnecessary overhead.
> > 
> > Make the number of updated capabilities per event tuneable via
> > debugfs.
> > Users can then experiment with different values.
> > 
> Is there a limitation about the number of CPUs supported in one netlink
> event?

IIUC, the only limit is the size of the buffer for the message. intel_hfi
allocates the message based on the number of CPUs of the HFI instance.

> 
> IMO, we still have to use a fixed number here because debugfs can be
> changed by someone else, and userspace application like intel-lpmd
> cannot make assumption that the netlink message follows what it set.

but you don't know how many messages with 16-CPUs payload you will receive
for a single update, no? Yes, you can infer it from the number of online
CPUs, but still.

But yes, now lpmd would receive an unknown number of messages with payloads
of unknown size.

> 
> or can we append one magic item in the end of one update?
> userspace can just check the magic item no matter the number of CPU per
> netlink event.

AFAIK, only HFI and lmpd use the CPU capabilities thermal netlink message.
I guess it could be done.

