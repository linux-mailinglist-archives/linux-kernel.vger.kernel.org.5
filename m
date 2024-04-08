Return-Path: <linux-kernel+bounces-134891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F26989B850
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5035283218
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE95328DD1;
	Mon,  8 Apr 2024 07:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b+6ofYEj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B833928DC1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712560925; cv=none; b=laTEE5q3E6vzHbNa5WTAO5zd+n2uHcqczSqnhTlGl5/IXwoa1d8qmqKs5m6DSoJgQrK+mn2d1oKG/lkcpqtIUQPAA/SGGeDycBDFB0x5Wf/Ao4DhFhQ6kBF0fRoExOw9FX0K9D/5/mWd56f8UUd09DgYlo/KflkW3AiB0UlvXnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712560925; c=relaxed/simple;
	bh=5Hk5nRRS+GV+l3S2tfQORQs5jaxuleNOHdTtJDOLK/M=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lcbYXKziliH89tH9stzLnishAlnfxlUYaqbdwkracWTnE6dn5Zv/OBe/YoF0jQ2doJJVzlAlE3Ej6JFygJFZX1J9koC5mCkEi+NUTt2xSG+qErL3rTobBNdOlEnZpVulbzANl2gjMYNAFgcqIuWW4FGAuK0icTqQpDX0ZmeMMYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b+6ofYEj; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712560923; x=1744096923;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5Hk5nRRS+GV+l3S2tfQORQs5jaxuleNOHdTtJDOLK/M=;
  b=b+6ofYEjTgpJV7zO687gxXnPqUZ40uyz05r4DKBnASHvBDpyTcTZt1u0
   NbtDglnbD6JU79zdMBnZ7y5AQoJK3SmyTHoXKAbXO/zDvjqW6fshSlatb
   Dv6CufS+WcS4FI2/YHiYadF0rgVZ2bJeerKUnEIIkZ/8hfT9IwAsGnmK/
   A4XkJ2Hm597hMbVVBqH84KzyFrzJ6Kluo/JgKgSQcIrN3GoyZkTLnqI1L
   0v9EDOotvwz/ySqwo5bO2/SYHHm9uGKym8EbMNMKBjCAlXZZj1phfs71v
   JUgAY9HFJN0nIdxSTzr7p6smCWp+q6CSAC1yS02rNN4MlKst/iRUCurJH
   A==;
X-CSE-ConnectionGUID: FAy6LnlKRP23VH0necI9cQ==
X-CSE-MsgGUID: xBvQElpLRgiclOj1yVWPNQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="7681829"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="7681829"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 00:22:03 -0700
X-CSE-ConnectionGUID: 5rahD3LjQMGxmrSACFgZjg==
X-CSE-MsgGUID: shVHiPvXQ26Vz5R8c8qJyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="57256966"
Received: from penghuan-mobl.ccr.corp.intel.com (HELO [10.254.211.109]) ([10.254.211.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 00:21:59 -0700
Message-ID: <ec0ff625-855c-4dba-b19f-db050671fbfb@linux.intel.com>
Date: Mon, 8 Apr 2024 15:21:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Steve Wahl <steve.wahl@hpe.com>, "Anderson, Russ" <russ.anderson@hpe.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2] iommu/vt-d: Allocate DMAR fault interrupts locally
To: "Tian, Kevin" <kevin.tian@intel.com>, Dimitri Sivanich
 <sivanich@hpe.com>, Thomas Gleixner <tglx@linutronix.de>,
 Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 David Woodhouse <dwmw2@infradead.org>, Mark Rutland <mark.rutland@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 YueHaibing <yuehaibing@huawei.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <Zfydpp2Hm+as16TY@hpe.com>
 <BN9PR11MB52765241E3261B58BE93E8A88C002@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52765241E3261B58BE93E8A88C002@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/8 14:54, Tian, Kevin wrote:
>> From: Dimitri Sivanich <sivanich@hpe.com>
>> Sent: Friday, March 22, 2024 4:51 AM
>>
>> The Intel IOMMU code currently tries to allocate all DMAR fault interrupt
>> vectors on the boot cpu.  On large systems with high DMAR counts this
>> results in vector exhaustion, and most of the vectors are not initially
>> allocated socket local.
>>
>> Instead, have a cpu on each node do the vector allocation for the DMARs on
>> that node.  The boot cpu still does the allocation for its node during its
>> boot sequence.
>>
>> Signed-off-by: Dimitri Sivanich <sivanich@hpe.com>
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> 

Kevin,

Jacob has another proposal which shares the irq among all IOMMUs.

https://lore.kernel.org/linux-iommu/20240403234548.989061-1-jacob.jun.pan@linux.intel.com/

How do you like this?

Best regards,
baolu

