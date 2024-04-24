Return-Path: <linux-kernel+bounces-156231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9899C8AFFFB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54432288CA5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA87413C3F8;
	Wed, 24 Apr 2024 03:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="abQsFnej"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D749C13340B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 03:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713930235; cv=none; b=dHh4xj/qLYqAwl+04mxSR7AwMCiEYGq8GrVIXz91584nAkAsGYAicgqDHh+J3eOMx9NFIk1nSGDIUI48A/VxeVAQ4eTCN8CFaL/Xw42arl7KGesSvPl72B7MDkeov6N+pBxzrawoR7qm2Sb82W5/9hnFqvcA12ORQI1zjUo2XD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713930235; c=relaxed/simple;
	bh=E5CvyKwPBQpRyM0AVWWIVzuLRubaZPD0MvbrMFrbwWQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uHGOwVcjgQWZFBN9jIzhdzJ4ggFlDw7E3GplauWhxwWQDaB1qqnyCNS4+1fSBi4Wl5+8Eo1e6cIeOjk6+RBZLafU19sY3HyreFI65GdOP8r0YSJ/DeUrJ6x0dW6Hzby38vGSPQaxvEFOiDegspMtGNfysb/hPemVxh9pfgqgqPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=abQsFnej; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713930234; x=1745466234;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=E5CvyKwPBQpRyM0AVWWIVzuLRubaZPD0MvbrMFrbwWQ=;
  b=abQsFnej66ucMedrArgCclQFjLppDYrS5l7Fl/RPcndSJAnIJZ/xW6Ig
   URSAltv99QUgrfDvTPD8yts9m7j9XmINm/IwKW7hzmP6M77piPKlDNbsO
   mgEGh0OB20X2hQ6vtjZ2HLli7PCqPNgbfDeWKN4Cqu1Ry2NHB6RrenkW2
   1tKKw/9+VI2s0mXHfxiohrAAqcmvoiY3SeRZmhpyMphQ6c0L9FWhkEGLM
   iKQo9nClQyuoRiAB5Lu1d8HAWzsZXECNIssyHHLAnzUgz70/kJsbN5dQs
   6NLFPwtMxRno71wUAxR4FZdcugnZAN+VvifGokB7Ti3TXjD6bFrKG9Ae1
   w==;
X-CSE-ConnectionGUID: wOzFkkYyR6aeFBw46VmO1g==
X-CSE-MsgGUID: bNX+GxgtReGySkIKCv8CsQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9409349"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="9409349"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 20:43:53 -0700
X-CSE-ConnectionGUID: 2B+0aBnWTdOfSTHEwcnedw==
X-CSE-MsgGUID: F6Iu94wbS/i3wRiJjl4p7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24609443"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa006.fm.intel.com with ESMTP; 23 Apr 2024 20:43:51 -0700
Message-ID: <ab89fb17-508a-4041-b4a0-11341d356581@linux.intel.com>
Date: Wed, 24 Apr 2024 11:42:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iommu/vt-d: Remove use of private data field
To: Jingqi Liu <Jingqi.liu@intel.com>, iommu@lists.linux.dev,
 Tian Kevin <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20240308103811.76744-1-Jingqi.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240308103811.76744-1-Jingqi.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/8/24 6:38 PM, Jingqi Liu wrote:
> "Private Data" field has been removed from Page Request/Response in
> Intel VT-d specification revision 4.0.
> 
> Since the private data field has been removed, it's fine to remove the
> entire private data handling from the driver as the specification
> has been deprecated and Intel hasn't shipped any products which
> support private data in the page request message.
> 
> Jingqi Liu (2):
>    iommu/vt-d: Remove debugfs use of private data field
>    iommu/vt-d: Remove private data use in fault message

Patches have been queued for iommu/vt-d.

Best regards,
baolu

