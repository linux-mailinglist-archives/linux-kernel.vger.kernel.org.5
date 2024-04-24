Return-Path: <linux-kernel+bounces-156235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFDD8B0005
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2D31C22844
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678AE13C9B5;
	Wed, 24 Apr 2024 03:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GzChvpK0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713EB139CEB;
	Wed, 24 Apr 2024 03:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713930438; cv=none; b=npgrKruCZSLNpoiMTlaIx4iROOYruME6j7R0jGfp+bNQZZl5WGAu/pVGI6Ic2FOVjm+lUBOW8j1pb6ggpFa+Aao3//yNGfwJhigR2V7kDBIsq9+QjnzeEUU7rb0KkdLqiV56qsjlKAl3jn2JRiBLEa1sCgydTCrRjOrd8h0vGgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713930438; c=relaxed/simple;
	bh=kSwT2UXH4kCmR450oMEHo7WWZc1PeFTIYoxSot7nJLw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gTRUxvOwmf0xUKbXrwIk857uqsoF0J/TEqFPnLDcWTEBGXrGhiGBeGKPhwNAm/QRCAe2GW4ihzgUmIsia7+CKqt6X9sM48tFa+KflDDqlibzTXkNAFVyFMfrlhoo5UwWInjVycUGSNv0n3AukpdwnqxVPdXO2GtEl/FTM5mDRjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GzChvpK0; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713930437; x=1745466437;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kSwT2UXH4kCmR450oMEHo7WWZc1PeFTIYoxSot7nJLw=;
  b=GzChvpK0QK5GSsUeyRYCLBfZ7QBqovvFS9HdF4xGtJl+rBLp+Mj7ur/3
   yCZWT+9FXHQbnwPm9AbUl1qM/Q081T4+/lrJ6w1OdFXdk8VFZ8RwxH9TC
   VkS8iy9S4Z4iOreI6IYVBuSdwYBfeUrWG6DjYPfJUVmbO6oIz/BfJFi8R
   K9q0OLrDZNzZqqfRiApjuGEIVZUtU8Oup6vzsLKZx9Y6vVq1E78n2Wkre
   SMHD5RJNb1Rr3ErzGml7ntTnIZzhcpSIhdKl/TwZQiASjr3RmtXwd4dwQ
   +rMquoeH6FLFCBMXCmp1nO1lHgoOOWCi2OEdTmUB74N0XwFurvl6UjUlA
   g==;
X-CSE-ConnectionGUID: 2PXKQt8vSGyHTMt7UZBvxg==
X-CSE-MsgGUID: X1KcXKwBQ5CJ35okYtzwbA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20963613"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="20963613"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 20:47:16 -0700
X-CSE-ConnectionGUID: Da9Wx48VRwCX/60hF2hTQw==
X-CSE-MsgGUID: K9uhtQWSSButsq5T4hLV+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="25185814"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 23 Apr 2024 20:47:15 -0700
Message-ID: <6a08e3ea-572d-442b-9b58-7da0b0ad212e@linux.intel.com>
Date: Wed, 24 Apr 2024 11:45:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iommu/vt-d: remove redundant assignment to variable
 err
To: Colin Ian King <colin.i.king@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev
References: <20240411090535.306326-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240411090535.306326-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/24 5:05 PM, Colin Ian King wrote:
> Variable err is being assigned a value that is never read. It is
> either being re-assigned later on error exit paths, or never referenced
> on the non-error path.
> 
> Cleans up clang scan build warning:
> drivers/iommu/intel/dmar.c:1070:2: warning: Value stored to 'err' is
> never read [deadcode.DeadStores]`
> 
> Signed-off-by: Colin Ian King<colin.i.king@gmail.com>
> ---
>   drivers/iommu/intel/dmar.c | 1 -
>   1 file changed, 1 deletion(-)

Patch has been queued for iommu/vt-d.

Best regards,
baolu

