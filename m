Return-Path: <linux-kernel+bounces-135269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4368E89BE2E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F357E2843B4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2CC69DEE;
	Mon,  8 Apr 2024 11:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KkprdfwS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD321657C4;
	Mon,  8 Apr 2024 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712575953; cv=none; b=qOgRC9JX60SXgW5qYE0kSShiBzRg/uBhauvveoduuriy61F8OC7KBtX5Kavk/+KUnr1gdgCFASi0txWHbtWNi/qf2H+4JUvsFeh/HjT6XNyRjlJBrpN5slLxzxWkZ1A/kDNivak/4Z586OHYLt1BCJUATECReMPUkJSVo2r3/Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712575953; c=relaxed/simple;
	bh=r4cliyGIwQDyX7Z9XcP+g//foiYQAn/zmPh0DKaJH7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uG9b9YzxnIRQ+qsvOJ0BalPH96ZiUE8Ur1i8NmuQNNEQI9mSZlyBB81YIOap8DTVP4De6cXz1cxii/JsBEJqNABbtkLD/F5nOA3IqiDuukyndte/AgtVTaqg9qdMtJgSx/qB1h5YxQig41fYy6LJo+5hkmgXyqClYOgyI4yuPvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KkprdfwS; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712575952; x=1744111952;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r4cliyGIwQDyX7Z9XcP+g//foiYQAn/zmPh0DKaJH7s=;
  b=KkprdfwSOFCBIjO5U180C2GaxW8SrAfzCwEdbltIzRkKSJX1L1boEuMc
   Iud+W7yp7a/EmgNj4OiJKknB/fr9Rw9AFiFCRdvz/bIWQfomk2NiMlcTC
   z1+HNK0rQ6CzVQnUezhT4Q+qF3rvEaco3LPtegqNndttAh5p3og+MAvX1
   bEaqcWa9I4uI4fqRZT8eAnREeJp+8JEAiewJL3qGGHOUnB8tjCghV7FvP
   DPHTOBzTaQeAm+GdckQDk/bNnOK7K56bPVuYtEdL/dcqv6AVgT4QGrMf3
   cCCpjZ0VVZclVBQdbQc777nyaXaA38gZWz3C71HkbGOCMnRV3uMXIsZHM
   Q==;
X-CSE-ConnectionGUID: kPmrr3xJSLm33cLb+tr1RA==
X-CSE-MsgGUID: Ri9pynbqQNuwLLeVo3ayzw==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="7719787"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="7719787"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 04:32:31 -0700
X-CSE-ConnectionGUID: YFNNf0xYSsqa5EBoqvlKtQ==
X-CSE-MsgGUID: faB8glgyQ5WMfqxdzjvOfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="20294427"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.12.48.215]) ([10.12.48.215])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 04:32:27 -0700
Message-ID: <8ac80d7b-340b-4b3f-b854-98a6a3c1fe41@linux.intel.com>
Date: Mon, 8 Apr 2024 14:32:24 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH 3/3] igc: Remove redundant runtime
 resume for ethtool ops
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
 <20240325222951.1460656-4-helgaas@kernel.org>
Content-Language: en-US
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20240325222951.1460656-4-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/2024 00:29, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> 8c5ad0dae93c ("igc: Add ethtool support") added ethtool_ops.begin() and
> .complete(), which used pm_runtime_get_sync() to resume suspended devices
> before any ethtool_ops callback and allow suspend after it completed.
> 
> Subsequently, f32a21376573 ("ethtool: runtime-resume netdev parent before
> ethtool ioctl ops") added pm_runtime_get_sync() in the dev_ethtool() path,
> so the device is resumed before any ethtool_ops callback even if the driver
> didn't supply a .begin() callback.
> 
> Remove the .begin() and .complete() callbacks, which are now redundant
> because dev_ethtool() already resumes the device.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_ethtool.c | 17 -----------------
>   1 file changed, 17 deletions(-)


Tested-by: Naama Meir <naamax.meir@linux.intel.com>

