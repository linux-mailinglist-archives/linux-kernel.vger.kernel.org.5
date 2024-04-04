Return-Path: <linux-kernel+bounces-132036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E3C898F01
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D8661F20CAA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE23137775;
	Thu,  4 Apr 2024 19:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YPMARq/w"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DE8135A4C;
	Thu,  4 Apr 2024 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712258813; cv=none; b=EuGEgIBDw87IGNGB+DDxYE5vH9A1MZ/ohzMW+s43jVtAlbOI+folnQ94lNKdrXUqXc/2wb3st/JMcLfXJTNb+giXSHq0XC3s5LWgxDXBfbDJBBomjyg3jO+VTfJJg5xMGQEnPIzz4MqV92AfjfihVAOynOzZ13VvNFLfxwh9bfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712258813; c=relaxed/simple;
	bh=UYUzD7T4Jph7nLu+kUWLGhaquNztQP+/2JKuOZkr4Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQRVrxQ8IymHIC9+qk4q0WNr0CHjy3FtryhfOoApR4WpCNAv2TPT7AItoLVE1ePXTXT7Nf9s0vps1hSmZvaJUqUx+7FFOyZQAdrlh/lchapP87yps7R6lZwecX9e9ngMgGqtoixba+gI67y8TVv4cgUsuSaBdkDU2Z2SvQ8soYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YPMARq/w; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712258812; x=1743794812;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UYUzD7T4Jph7nLu+kUWLGhaquNztQP+/2JKuOZkr4Xs=;
  b=YPMARq/wKp/ULCGTSLFFtGfp7iY8R7jrPpVgdStvSTlxLXaa63DGMTl2
   kkMRZXarG2EqG3QrxGTTKIw6DG7/+HTEyLhJdRnuJfAJklvFAhg0t8MOb
   7nHWjoIXt7yPgQI8OF3iBUuPxuZxm6poQSSJa67Yn9mjwvvGYyrIUw1fB
   F95Zslrebb4n4yxm+axLT0PDGFaVGPM2HvO4p5bhvkCtT9pqpA4ZT3Dkl
   WLbPHgXhYT9/koLpgExsG9cjH05cq5HGrbSD1OEh9hnUb4CHyDDgmtKSV
   W2vMoTn9pubgBfWjEjSnhSoEkSqUQ27nENuIPZCw3MkEUFH1c4nJkXrEu
   g==;
X-CSE-ConnectionGUID: rBhp0tOkRPOx7Q7PdcJUiA==
X-CSE-MsgGUID: PLc86ybZQcKrpXb4s+OZJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="18178258"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="18178258"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 12:26:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="915227545"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="915227545"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 12:26:48 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rsSjW-00000001YZ7-04j3;
	Thu, 04 Apr 2024 22:26:46 +0300
Date: Thu, 4 Apr 2024 22:26:45 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev, Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>
Subject: Re: [PATCH v1 3/7] ACPI: scan: Replace infinite for-loop with finite
 while-loop
Message-ID: <Zg7-9QFnaDzb53tt@smile.fi.intel.com>
References: <20240325123444.3031851-1-andriy.shevchenko@linux.intel.com>
 <20240325123444.3031851-4-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0g6bn4k2Sv+SRC1fiDoXU+hZ2iUR6GuL5O1Eny=Pxmh0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0g6bn4k2Sv+SRC1fiDoXU+hZ2iUR6GuL5O1Eny=Pxmh0w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 04, 2024 at 09:22:29PM +0200, Rafael J. Wysocki wrote:
> On Mon, Mar 25, 2024 at 1:34 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

..

> I don't quite agree with this one, sorry.

No problem.

> The rest of the series has been applied as 6.10 material.

Thank you!

-- 
With Best Regards,
Andy Shevchenko



