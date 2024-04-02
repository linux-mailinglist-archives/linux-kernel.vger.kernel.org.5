Return-Path: <linux-kernel+bounces-128505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D347F895BC8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DDFE283926
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B8D15B12B;
	Tue,  2 Apr 2024 18:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Blm56ri0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6437615AD86;
	Tue,  2 Apr 2024 18:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712082758; cv=none; b=m/WRFeDh1t1KJ8hG8ReWxHbrttcG7TY7fv9n38UCcbBHx2JYrL3pQlhMQPdGxdS28D0Vfb7o+pf98s4HjHpZJ921vF3iNHLB/UW8vilUH9pyPzbQJJav6tgSucGzo/N6CP2wxN1uoMtcF4V6hKIIOu9ep5Cc6MdS/wQeI9LnhEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712082758; c=relaxed/simple;
	bh=56IvtkOVy7cYW39VJv3cYm8/WXzWR/XaCzSn86nROLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TvRUFp+6pei5yWUc0Ud4RHCbokeaF9SaR0dPKvr9jRX6CzkUqjJpJKXzRF2wjYVv6wRGAGJf0XudI3bt9/oWwxvYpkXI5VLjd94kDtK8A48+76bLHH3Ly6WmOXlJBiuzYLqtthbG+UeKv364KLlUzydf0wM8EC3SIKze2kGQMis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Blm56ri0; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712082757; x=1743618757;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=56IvtkOVy7cYW39VJv3cYm8/WXzWR/XaCzSn86nROLg=;
  b=Blm56ri0biEfZUieSpnnU3+LSQ0EZiEga/Qj8b+zYj3JFojDV9TuWQHT
   8QeHdAO8rZqQCGyZ+fwu4+fTk8PYYkfLhRj7NiV/FQRiYK0SQ6FunK1hg
   5eAGOCf+NO2cOZLZCsGjdHyqb9TjZhNGw3BXH2Fj77VfNPsxZPGZo5PZj
   pTiJvzqYsYaNKaYr1anso4QH2kRcbGQBaXmpGdhgMNdEZ/vOLayO6aCjE
   IZq10QTKZRv55Osk7rtpCxMo8NkoujU8mIlR/hQnAXQW8/9YwO0XFc1Bi
   xJRtt0BCCQoOSS4Za3fGXfH4rNi5x+33yNxCHuiBENeoTaDCa371TuWlV
   Q==;
X-CSE-ConnectionGUID: +jm6HFuLQUSicGNP40kEbg==
X-CSE-MsgGUID: dXaDzmDoQAir5Vxc+lf/Zw==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="10240491"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="10240491"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 11:32:36 -0700
X-CSE-ConnectionGUID: Tk7eASW7TM+bdx0LKden0Q==
X-CSE-MsgGUID: j7pN286VQ0G7h9zhvr5LTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="41306852"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.245.163.187]) ([10.245.163.187])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 11:32:31 -0700
Message-ID: <b3f92716-9532-4bef-94d7-502689fc2b04@linux.intel.com>
Date: Tue, 2 Apr 2024 21:32:28 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH 1/3] e1000e: Remove redundant runtime
 resume for ethtool_ops
To: Bjorn Helgaas <helgaas@kernel.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Sasha Neftin <sasha.neftin@intel.com>, netdev@vger.kernel.org,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 intel-wired-lan@lists.osuosl.org, Zheng Yan <zheng.z.yan@intel.com>,
 Konstantin Khlebnikov <khlebnikov@openvz.org>,
 Heiner Kallweit <hkallweit1@gmail.com>
References: <20240325222951.1460656-1-helgaas@kernel.org>
 <20240325222951.1460656-2-helgaas@kernel.org>
Content-Language: en-US
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20240325222951.1460656-2-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/2024 00:29, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> e60b22c5b7e5 ("e1000e: fix accessing to suspended device") added
> ethtool_ops.begin() and .complete(), which used pm_runtime_get_sync() to
> resume suspended devices before any ethtool_ops callback and allow suspend
> after it completed.
> 
> 3ef672ab1862 ("e1000e: ethtool unnecessarily takes device out of RPM
> suspend") removed ethtool_ops.begin() and .complete() and instead did
> pm_runtime_get_sync() only in the individual ethtool_ops callbacks that
> access device registers.
> 
> Subsequently, f32a21376573 ("ethtool: runtime-resume netdev parent before
> ethtool ioctl ops") added pm_runtime_get_sync() in the dev_ethtool() path,
> so the device is resumed before *any* ethtool_ops callback, as it was
> before 3ef672ab1862.
> 
> Remove most runtime resumes from ethtool_ops, which are now redundant
> because the resume has already been done by dev_ethtool().  This is
> essentially a revert of 3ef672ab1862 ("e1000e: ethtool unnecessarily takes
> device out of RPM suspend").
> 
> There are a couple subtleties:
> 
>    - Prior to 3ef672ab1862, the device was resumed only for the duration of
>      a single ethtool callback.  3ef672ab1862 changed e1000_set_phys_id() so
>      the device was resumed for ETHTOOL_ID_ACTIVE and remained resumed until
>      a subsequent callback for ETHTOOL_ID_INACTIVE.  Preserve that part of
>      3ef672ab1862 so the device will not be runtime suspended while in the
>      ETHTOOL_ID_ACTIVE state.
> 
>    - 3ef672ab1862 added "if (!pm_runtime_suspended())" in before reading the
>      STATUS register in e1000_get_settings().  This was racy and is now
>      unnecessary because dev_ethtool() has resumed the device already, so
>      revert that.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>   drivers/net/ethernet/intel/e1000e/ethtool.c | 62 ++-------------------
>   1 file changed, 6 insertions(+), 56 deletions(-)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>

