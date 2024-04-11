Return-Path: <linux-kernel+bounces-139667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 121DB8A0629
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB491F25318
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9743013B2A4;
	Thu, 11 Apr 2024 02:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OyT+DI/j"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87359626DD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712803828; cv=none; b=ZAQlqSCB2TO1dlNc2AOblvqy0Q21L1RTDOTZ93IGvj14h/Q3iyXazBv+6shWv4uvRa/vWLgOknaeoLzKjMx8083CjN31BAxrCL0nmrvcAuGfinzRgaV0wdtNfRVBdBoEoHpblOcI2in9HHzfx05py2PbghLLrNfmlGCmr+75e9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712803828; c=relaxed/simple;
	bh=4LcTGVBwiirOymfMp5Iqni4JZQ11sU8GplsQo2wIUXM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=r7Zm9IDNSqtBa3vtAJPPmNzEwcbU0oacKXL6FI7xiev3GbJQg3tmseQ7zjR0v4MclX9uL+28fF/KjsJrAmpBP9cd72RePDFLBdxBzl8BYdsGIUHS231U2idvL48ouUbyAmw5FScMygMARFX/Biy37tBDp5SkL5OqkUYLyi9iVUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OyT+DI/j; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712803828; x=1744339828;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4LcTGVBwiirOymfMp5Iqni4JZQ11sU8GplsQo2wIUXM=;
  b=OyT+DI/jF54hOkaRPSAa79VOEWkwUF+EPKbQSZuylB2SYW++wAYxoT86
   Z9efBlul3MWttbzl3bosSreutA2XbzcK2v65gs8/syfHkg7utN3OWFVlI
   UAAEkC05aFKIxbABANz9sRVS/U3yeYh81YN9GQcBPU3N1DcXqyU7zjz7D
   wrdrejb1OlNvGCUou69WlvQ3KwyRg+sBF4nLLQWADaOqQ6xPwa2IMYmpE
   nuHmLGkwQdB4NsxfDfz6ZTTMdpnemHev8uX3V91SZqOf6jIKG3NG+hGAb
   QcLLr2NbPYjwJP5+EJVZnyNt4j3w0cmq90MOXxt7uow+zMFypSP+Hdr6q
   g==;
X-CSE-ConnectionGUID: y6xrPapPSA2dSoKq1EebyA==
X-CSE-MsgGUID: OMY4jPKUSFOH9nEJBNq1qQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8061038"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="8061038"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 19:50:27 -0700
X-CSE-ConnectionGUID: twQ/FGSmSpCLeKQAfGOzmA==
X-CSE-MsgGUID: Do6X+22SRzKolwJR4BXnHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="21351368"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 10 Apr 2024 19:50:25 -0700
Message-ID: <3a2f00cd-bf31-4d75-a42e-d782cfb64ad6@linux.intel.com>
Date: Thu, 11 Apr 2024 10:49:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH] iommu/vt-d: Allocate local memory for page request queue
To: "Tian, Kevin" <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Joerg Roedel <joro@8bytes.org>
References: <20240403214007.985600-1-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB52760B3710E7DDFFC458A35B8C002@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52760B3710E7DDFFC458A35B8C002@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/24 3:36 PM, Tian, Kevin wrote:
>> From: Jacob Pan<jacob.jun.pan@linux.intel.com>
>> Sent: Thursday, April 4, 2024 5:40 AM
>>
>> The page request queue is per IOMMU, its allocation should be made
>> NUMA-aware for performance reasons.
>>
>> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>

Add below fix tag and queue it for v6.9-rc.

Fixes: a222a7f0bb6c ("iommu/vt-d: Implement page request handling")

Best regards,
baolu

