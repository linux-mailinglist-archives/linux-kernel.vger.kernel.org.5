Return-Path: <linux-kernel+bounces-157060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E93008B0C55
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17DC21C22C16
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEEB13DBB2;
	Wed, 24 Apr 2024 14:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g1WR+rL7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309EB15E213
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713968287; cv=none; b=e0mq1bgy3FcH6x39bvdP5hJ1s/y/smvRF99SNjSE5vYVTTIF+uDA9RQTdER7aW9fu9juHISokqZmmKfuFtxJIQfYuvNAJtKmhbg6utfvIeDwA+qy45xeinmKyzKc6xuDlAGRe9CKgdXjwye2Pd4kQNH0T7ZSqpLqcAk2CTb2nvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713968287; c=relaxed/simple;
	bh=At4UvGSHtC3eAHxqHmHEbLvTz/bxsDbV95dLJBgf9C0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Syn3ymuFyodsuMZHGJikq+oq5TQFXDgpajqafYiZE9Wit0bmTgzM3cDzRxXUEWWViWANG1zXaH58GsGG9GGRKqOvBGZZ0f7IYNDtl0v3tS16wpmI7/mhNHWzE3DlfsJeTBczpPl072M8Ntky9Dh3AVQeWooS1VAdAAa/vJl9B50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g1WR+rL7; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713968286; x=1745504286;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=At4UvGSHtC3eAHxqHmHEbLvTz/bxsDbV95dLJBgf9C0=;
  b=g1WR+rL7JJ6jSvH8lZdDakr1Kk+yINakQGeAjTZYFa1zd2cJS+S22P7P
   Kga0ghrCqkPxtLd1Hm1dF7Dc8YagkWBlmx0S+04Rz9Pusj29ZTbNi/qUk
   rSl5pWEWOq7WOtXfentVxpQk3uEmDl8BddlF0KgyBm04Q1bTuTDAWoGo7
   tgbAAnz8SR7C78egU+IGLha/03AifZP4j6iVUsWHcG7zd79PRIdegL+xW
   z0tJUhZ+cBrKNC+eIs5Plf4Pq50/reJLyoPIzHIP9dxVZ3HzvX41eHvU3
   MTZWrbt7f/6QBRPOkCQ0WV/YnEMR8O0Nk7zZZb9dISpVZJ5WGDr3RRiUl
   Q==;
X-CSE-ConnectionGUID: y1xPYns+Q96mTBk/+0NW6Q==
X-CSE-MsgGUID: Xo++LmcfSuy72hbBcK6y7Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="20217330"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="20217330"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 07:18:05 -0700
X-CSE-ConnectionGUID: k2Y9vOx2Rd+ybaax5y0ZUA==
X-CSE-MsgGUID: 42iMqnkSToGMlw5ObURQlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="25241509"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.237.86]) ([10.124.237.86])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 07:18:02 -0700
Message-ID: <77fd2bba-fc59-4997-a91a-2d9235ce5cd6@linux.intel.com>
Date: Wed, 24 Apr 2024 22:18:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org,
 ewagner12@gmail.com, suravee.suthikulpanit@amd.com, vashegde@amd.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
Subject: Re: [PATCH] iommu: Fix def_domain_type interaction with untrusted
 devices
To: Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>
References: <fa14583e94cbf540b60a6be94b41bb24d0037e75.1713272443.git.robin.murphy@arm.com>
 <20240416152943.GU223006@ziepe.ca>
 <3cf97e3c-c8d9-4282-a8ca-e4c1ea383dbd@arm.com>
 <20240424130457.GF231144@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240424130457.GF231144@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/4/24 21:04, Jason Gunthorpe wrote:
>> OK, so after all that you do in fact agree? In that case, why are we still
>> mucking about proposing hacks on top of hacks in the AMD driver rather than
>> just fixing the regression sensibly?
> It is because your proposal is regressing the meaning of
> def_domain_type back to a policy knob when I've spent a bunch of work
> emptying out def_domain type implementations to get it into a
> capability report.
> 
> def_domain_type is now about*capability*. Does the
> HW/SW/Driver/system support PAGING/IDENTITY or not.
> 
> Meaning if def_domain_type says it is not supported then the core code
> should not use it. This is how everything was working until AMD
> changed their driver to lie about what their attach_domain would
> accept.
> 
> I do not want to see def_domain_type regress back to being confused
> where some drivers are policy advice and some drivers are capability!
> 
> AMD should hack their driver for the rc fix and then go and fix it
> properly to remove the PASID logic entirely from def_domain_type. I
> will also point again out that in v6.9-rc AMD doesn't even support
> PASID yet so this abuse of def_domain_type isn't even needed. 🙁
> 
> The core code should contiue to treat def_domain_type as capability.

I agree with this. Ideally there should be some mechanism to disallow
any device driver to bind to the device if there's a conflict between
the core policy and iommu hw capability because iommu-dma functionality
is already compromised.

If we all agree with the statement that "the core should treat
def_domain_type as capability", the intel iommu driver needs some
enhancement as well.

For example, the intel iommu driver allows users to opt-in graphic in
passthrough mode, in that case def_domain_type will return
IOMMU_DOMAIN_IDENTITY no matter the device is trusted or not.

     if ((iommu_identity_mapping & IDENTMAP_GFX) && IS_GFX_DEVICE(pdev))
          return IOMMU_DOMAIN_IDENTITY;

this potentially creates same conflict as the amd driver.

Best regards,
baolu

