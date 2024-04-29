Return-Path: <linux-kernel+bounces-162324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE078B5962
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F4D028B273
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81AE6A8DC;
	Mon, 29 Apr 2024 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZGLK+uE9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18CC74BFC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395906; cv=none; b=D6HTv58JIqZ0rGHUD1q7Km6q2LzUYeh82vAVIagGKxqKd5tyYnVVfeSkW0O1u+12sKXvQQuSP3yDRleSk6pXznhtMa9N9BtMxR2EteGH3DcSBh173dEaqaY81xPdZmDZU6FPbWphNyY7ScVvo7cNVfzsrJmv6nblhhcTgsMiDT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395906; c=relaxed/simple;
	bh=ctMt9O9c91QSbBG7JKVG7wzgRYW+9O8FtYinueT83aA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XIPp4WZ/n+fOju+fuqOlQ19eIvVTb9Ro843vr9pcc2Grig+UzX7wC8VykjbsxOa/aE8wxtPsFoLNNmBXuhzPB2g3hPLq/vWgSxtVnsHnAnrpELACdcmmbLdrcgZEPo5f41RijLZZED36CepgXxT7jLcrUsJGlRTDKw16adEEg5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZGLK+uE9; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714395905; x=1745931905;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ctMt9O9c91QSbBG7JKVG7wzgRYW+9O8FtYinueT83aA=;
  b=ZGLK+uE9PNdmN+tH0N1PSeCwO6zmkg5huP8cF6MDLOebZDi53+fJu6k4
   pSJsrlgxouT/SB+lUUx+Kux7SNEXF2knFdk2UwpryfdKqRw/j5LtMJT3T
   LZCerujL4GtaT6KqhyeJryC+HgXJ1aNj5XDEd5GV1yrtD0HiS7RZLHZVH
   nXPCPJwSDRqOLP/I5W0CNfeQrqZaWDc9JP/7wx0fn6xxhcVo3Q/STN431
   vsgpawGGmv/4L4y/2GeMVz8Q3gnhOWhnny+dhy3YJs9gwInp/Lal+tDXB
   4s+GABQmT5xlOzorQcvOSEBQAt1FCXq2um8WYz4zyiZF/k+gjX0FwXS73
   A==;
X-CSE-ConnectionGUID: EHTM0LHRSNmbWsvsXiVfeQ==
X-CSE-MsgGUID: IO0Zw3wCSIGv53uIglrCZw==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="20603333"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="20603333"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 06:05:04 -0700
X-CSE-ConnectionGUID: L0UqLGndRi+7S8Hn7wItFA==
X-CSE-MsgGUID: iDaiiXGERJy+LEIZP1vWwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26117561"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by fmviesa008.fm.intel.com with ESMTP; 29 Apr 2024 06:05:03 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH 00/14] stm class/intel_th: Updates for v6.10
In-Reply-To: <20240429120908.3723458-1-alexander.shishkin@linux.intel.com>
References: <20240429120908.3723458-1-alexander.shishkin@linux.intel.com>
Date: Mon, 29 Apr 2024 16:05:02 +0300
Message-ID: <87v840uxoh.fsf@ubik.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexander Shishkin <alexander.shishkin@linux.intel.com> writes:

> Hi Greg,
>
> Here are the patches I have for the next cycle. The bulk of them are new
> PCI IDs. Besides that, there are cosmetic changes, one actual bugfix and
> a new feature added to the SyS-T protocol driver that uses a specially
> designated format for ftrace data. I dropped Uwe's patch as he'd resent
> it himself earlier today.

Please disregard this series. Dropping Uwe's patch was me failing at
email. I've sent a new one that includes said patch [0]. Please consider
that one instead.

[0] https://lore.kernel.org/all/20240429130119.1518073-1-alexander.shishkin@linux.intel.com/

Thanks,
--
Alex

