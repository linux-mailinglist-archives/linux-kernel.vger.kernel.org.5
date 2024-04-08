Return-Path: <linux-kernel+bounces-135623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C35289C8B7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3C31C242EA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86D51422B5;
	Mon,  8 Apr 2024 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JNYxggT8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2EB1419AD;
	Mon,  8 Apr 2024 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591341; cv=none; b=ECtd7FYXBEw+L8kV1dbvySafdus8j9ijZhq2F7aBW2Poqa1ezR65RTIiMDeHe0J//nY6YVIAYNtMtJ+UUIM7Ex/+sKUdrKLx4SUpJrc1oP6sVyw4ApXgBKFWhKp/nCMZkC3ebTYUemMvSymdVK+ArKeokWoOsru6eWOgsveKC8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591341; c=relaxed/simple;
	bh=z7OOLivJJy3Z15llkGtgYnA7klW0jKakKsWkR3MHYA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=juVPkyq2BapQi5QVhuAzKSLVFyMGMaPcZqETy5jjVsw9nS+aFJ2kGZBgpG1hYiK22QbDJuVD0SVMvf7RhUY1dgf+ERxi8kUsmKql6TORb7QQOFD5gR5JZ/0U2ln1Z0x5gpJAErB42tZXC4XmcocudK470NUR9gymWIfRwAINcaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JNYxggT8; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712591339; x=1744127339;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=z7OOLivJJy3Z15llkGtgYnA7klW0jKakKsWkR3MHYA4=;
  b=JNYxggT8tKzNQfgDfZMrRMuUUv+Teaq9nQprEgoudBZuCGHxmlc07JZc
   blBQPOuT45VyCQ/YKdrEQcG16cwstuFcKYddxwoetJr/NYYy4g4zaQii7
   XZYR3G0WfozU2Vzb2ZIyDShawrblRXh21suOaLM63YEg/Pp6Gr9k8kjmf
   /Uwg5is3FDJWg8yYVtsCsDzfjDCFUcbvB3QO0z5QRUZHQLwykI7UadI9n
   eUXRS2clwmcyVNc1rx+U5BQcr7LWw01Fj93seT8NVIf5gAxaK5jz06UV+
   WlCvQTw/znnvgnsJDeqVy2nyxaitxmGVWllrwd6anFo5S1qJU8NFj7RXU
   g==;
X-CSE-ConnectionGUID: ZNSE4feCRPO4l2QKoA+zgA==
X-CSE-MsgGUID: fqjnHne7SUGhcodJmZAtAw==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7977085"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="7977085"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 08:48:58 -0700
X-CSE-ConnectionGUID: pXEDd6zkTM23Z6ScUmj1lA==
X-CSE-MsgGUID: fE5PX+RES+CLHGePjd8r9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="19981521"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.67.111]) ([10.212.67.111])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 08:48:57 -0700
Message-ID: <00b40925-224b-47e5-a535-a55bd7a49ec8@intel.com>
Date: Mon, 8 Apr 2024 08:48:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Fixes tag needs some work in the cxl-fixes tree
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Dan Williams <dan.j.williams@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240408080702.77f868be@canb.auug.org.au>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240408080702.77f868be@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/7/24 3:07 PM, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   c2db06c1a27e ("cxl: Fix retrieving of access_coordinates in PCIe path")
> 
> Fixes tag
> 
>   Fixes: 4d59ba915318 ("cxl: Fix retrieving of access_coordinates in PCIe path")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> The fixes tag seems to be referring to the fixing commit.
> 

Hi Stephen. Sorry about that. Should be fixed now. Thanks. 

