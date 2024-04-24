Return-Path: <linux-kernel+bounces-156813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DAD8B0888
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CCDB1F24242
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B957115A4BC;
	Wed, 24 Apr 2024 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nRG83O82"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9C015A4A4;
	Wed, 24 Apr 2024 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713959086; cv=none; b=kGxK5xGH2Vgmf8i9IAC4MqKdnksWF/jLGcJBbXERkqvYuPAf1EpByvyMAcKeSWIMB9dXBMCTTnhFxlGDKd8BgJPJ0GgOMCsqxwID7ouWBTfiTH5V+zW8AZr/FwFg05AVu5T+Mh+c/QL5/RP4+o0HKugISlK/jq5FGaHb5v+ipAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713959086; c=relaxed/simple;
	bh=xpUTnXpiZhsPhmL4RJ3EPHSMkblKDHr8KkYzdAZ0yCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ib8iq4TY0XB/3SE1lsRD115gSTtEnoPTsnBBZJkJw6knEEmof+gXbWCjVx43yT81ak9fYZYf/ZgPO228Mvw6H9GfB/a4PB718h7iDNYj9SlomQAoakgiiY8DIfXI1+jdXm2QrMJdFuvzJ8Zna6DNAW9aLwAH945C9NvZZ8577V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nRG83O82; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713959084; x=1745495084;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xpUTnXpiZhsPhmL4RJ3EPHSMkblKDHr8KkYzdAZ0yCk=;
  b=nRG83O82fqFh5ToFKb8WWksDMHNFIoOT0vIw3a97MLnz7KuTgy6424+2
   vidFjkQaSabVFo6tKvTMYW/9KEXBfVuBoxorKKE/jIY3SDBXcOW8xwagg
   ojYdMNTXbteJx2yxgaUsMfSVTHYurMw7CSjJNQvXTReHJ0oz2tAvxvQrV
   gVoAVBI0cWTOOJAVjoQTFQXX9U8z2ETw8osUWYv4IBYorbkmnZ9jTCNNo
   L4S736J3J34vEXveX+zsXOgz/3q1EwgznmJhMTMBDdsqMI5koeUJfGUpk
   5jQf4yfBvIZQuRqQ2jEzZ6zYlNRn3r+THZSKohaXFTe77vDJacANzcI5w
   w==;
X-CSE-ConnectionGUID: +Yz0J4wjQxWqgwIEaeQ4mQ==
X-CSE-MsgGUID: ZFekwH78SkiNYD0kuz4ATg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="10123653"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="10123653"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 04:44:43 -0700
X-CSE-ConnectionGUID: aOxPJhh6Rz+3u9n3Cu24IA==
X-CSE-MsgGUID: SOx7EidETuuhviBZaSh38A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="47949188"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO [10.212.109.188]) ([10.212.109.188])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 04:44:43 -0700
Message-ID: <d96da934-a996-418e-a175-4ba463d3916b@linux.intel.com>
Date: Wed, 24 Apr 2024 04:44:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 14/16] thermal: gov_user_space: Use .trip_crossed()
 instead of .throttle()
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>
References: <13515747.uLZWGnKmhe@kreacher> <15186663.tv2OnDr8pf@kreacher>
 <ZijNj7DzL9e01Vnt@mai.linaro.org>
 <e565a9c3-9244-4a0b-9ad8-4beebd03d681@linux.intel.com>
 <917f9bec-80f3-4d10-9781-7b27f361101d@linaro.org>
Content-Language: en-US
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
In-Reply-To: <917f9bec-80f3-4d10-9781-7b27f361101d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/24/24 04:34, Daniel Lezcano wrote:
> On 24/04/2024 13:32, Srinivas Pandruvada wrote:
>>
>> On 4/24/24 02:14, Daniel Lezcano wrote:
>>> On Wed, Apr 10, 2024 at 07:03:10PM +0200, Rafael J. Wysocki wrote:
>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>
>>>> Notifying user space about trip points that have not been crossed is
>>>> not particuarly useful, so modity the User Space governor to use the
>>>> .trip_crossed() callback, which is only invoked for trips that have 
>>>> been
>>>> crossed, instead of .throttle() that is invoked for all trips in a
>>>> thermal zone every time the zone is updated.
>>>>
>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>> ---
>>> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>
>>> I would also consider removing this governor which is pointless now 
>>> that we
>>> have the netlink notification mechanism
>>
>> That is a good goal, But, not there yet to deprecate.
>
> What can be done to deprecate it ?
>
>

First we need to migrate all the existing usage to netlink. We need to 
add some more netlink notifications. That is relatively easy.

The problem is user space changes are much slower to push than kernel. 
Kernels changes gets deployed at faster pace in some distributions.

Thanks,

Srinivas



