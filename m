Return-Path: <linux-kernel+bounces-156802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E57EE8B085B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E1A2827A0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97AC15A4AA;
	Wed, 24 Apr 2024 11:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KZ0cVilz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A317A1598E6;
	Wed, 24 Apr 2024 11:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713958358; cv=none; b=ru9f0WDm9zuaD/tGqVcIiJbaPJadqUP96NWWRKMQ8dGwzuobywYL0FoqjnhatjnRIxd7oeFswY9TXJGnpySEGprCVqMEiatLhee3VdnpmlGxdaXQIDx13aJjvglRPaY9x6Rj11a02yvNFLNIdjmNtZA6tnTOUiv7TEApAA9UwHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713958358; c=relaxed/simple;
	bh=Y9kdMVKHiAP1zSpHswbPKKYfi3WHHjOaEgGj1LB2NVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tteuJv2Nr6WwCQRuAyjNbKAzn8DyZj1Q+pVqJtb0v5gnA6xIDDcDJo4GzU7Pq5yeZBSPGdycXLimQM8cJuJN3B3lWq7CX/aP6sibSi0ZAZglUQOGpVuED04w0M8VfB3EVleT/A63iuc2mD/+wEKYYINb9aEt607YOS8VNFHQPj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KZ0cVilz; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713958357; x=1745494357;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y9kdMVKHiAP1zSpHswbPKKYfi3WHHjOaEgGj1LB2NVA=;
  b=KZ0cVilz2mqLRXNxotA8qgjsnGGHtPm2MGOdyCEl1EVcAEo+MGCmvTKI
   6284UiCB4RrpBL9WGI+sGpVP1dTTN/TNFbJAU+MzNZ0c8lkraC6jk3LGR
   TK8bPnKmX6IxBDOiICDiLj5bHVR3TlYQO4GzaVoQg83zHjIINdZv9J+u+
   bI0vGKz3uUwkQNuyVzXTnwLpo3ANViL0g8TbWqNpwUz8EgDTk6cdXYPDS
   wTOHU9ygDNiZPn3Ii64eNBQFT7K0+vRzgYxZnBIzy/1/MTzuoC/HQjuCv
   +uxoYlxzvZ6Qp+oqTfqi5YLt+mG6TwqWKdbOdsrppNO8r/nEjipMkKGgy
   A==;
X-CSE-ConnectionGUID: MSER4OpqTT+Qperd8Frtxw==
X-CSE-MsgGUID: vWpgLBJzT2Wbc2bB65W4hg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20278815"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="20278815"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 04:32:36 -0700
X-CSE-ConnectionGUID: tj9kQ+HMSXeDJxPM2ZuR4Q==
X-CSE-MsgGUID: adCmwtbQSXaCJPrKolHRew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="25288492"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO [10.212.109.188]) ([10.212.109.188])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 04:32:34 -0700
Message-ID: <e565a9c3-9244-4a0b-9ad8-4beebd03d681@linux.intel.com>
Date: Wed, 24 Apr 2024 04:32:32 -0700
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
Content-Language: en-US
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
In-Reply-To: <ZijNj7DzL9e01Vnt@mai.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/24/24 02:14, Daniel Lezcano wrote:
> On Wed, Apr 10, 2024 at 07:03:10PM +0200, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Notifying user space about trip points that have not been crossed is
>> not particuarly useful, so modity the User Space governor to use the
>> .trip_crossed() callback, which is only invoked for trips that have been
>> crossed, instead of .throttle() that is invoked for all trips in a
>> thermal zone every time the zone is updated.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> I would also consider removing this governor which is pointless now that we
> have the netlink notification mechanism

That is a good goal, But, not there yet to deprecate.

Thanks,

Srinivas

>

