Return-Path: <linux-kernel+bounces-139763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 478F78A076D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9521F23250
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6277213C830;
	Thu, 11 Apr 2024 05:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EApQP9eA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E460F13C696;
	Thu, 11 Apr 2024 05:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712811666; cv=none; b=uzVlnnUoL9ttynKcBvYaehqltbhEbBVZxo6+Fa/Rw4kOsDPqR+eTcC42MzjmBtwsvoCCFFqkTz0IpZLWUDiSaSK0CeoMI3FOvM5GHr435wQk/Wysn+oCOwfxA+i765Z/Y3Jjjgom89A8qDQD2CNbo4xAadJHRwnG+Ale9pWYSaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712811666; c=relaxed/simple;
	bh=5VxM0AYd2IXDBMwhwjlHKCDuJH2Zn8zHb0Kxjlub/iY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nlej/Jc7crIWU06Tgwd99E7WU5I3nVpn612gODLlGqcB1HL+kFvjBCfIOSTR69ypFgiz/hz0Aj3bW6ERPsmFRT+47D6od+sMcHRkfXvUltcU60r+cVsnCmrF4bPs99zkYeWjNqSxy/IdL2BOVeW6unG5j9+LY9rERuGW1snoL+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EApQP9eA; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712811664; x=1744347664;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=5VxM0AYd2IXDBMwhwjlHKCDuJH2Zn8zHb0Kxjlub/iY=;
  b=EApQP9eA8GNWHiHaHOAGOEeVkm3TCIoZi1vqyWWMDPDVUvXw6nEtiwhq
   4BwlOFMXqIVVtr375tXfuvepVg2UaS9xz3JHtFuzEcH1yeIxOIyACMUVa
   ZE6b9LrQ5O7RNxo0NfXw0qjaGJXpTBvQVjiqwseimups1003FmrQjmIO9
   TO2Kn7YDh5G8Iu3eLMofNQLhwfIC87AKx2iIJ0k4tiNKLK0KTO4x3H6pV
   29XPIuXA4Aku6dxQ/gdpsHYGyTxO50qugpKiWfmH84zisN/2k0Tz/FEG6
   xiPk/WvHrlI4V3TNGcMhaNw9tURMfV0jFBuO8yD+7z/YCk7JXrrKT3ISP
   A==;
X-CSE-ConnectionGUID: UcdB9u8gT9yfOzIdfHd6Gg==
X-CSE-MsgGUID: xK/XCDY6RRGH+R1lOEKJNQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8331521"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="8331521"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 22:01:04 -0700
X-CSE-ConnectionGUID: gVZsv62LQfqUstYoNLYHPg==
X-CSE-MsgGUID: 4W7Kg3OHReWBPKNpRDM2/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="25554176"
Received: from tashley-mobl.amr.corp.intel.com (HELO [10.255.230.246]) ([10.255.230.246])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 22:01:04 -0700
Message-ID: <cd3a1be5-cca3-4af2-8736-00598b3896d4@linux.intel.com>
Date: Wed, 10 Apr 2024 22:01:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/9] platform/x86/intel/sdsi: Set message size during
 writes
To: "David E. Box" <david.e.box@linux.intel.com>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240411025856.2782476-1-david.e.box@linux.intel.com>
 <20240411025856.2782476-2-david.e.box@linux.intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240411025856.2782476-2-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/10/24 7:58 PM, David E. Box wrote:
> New mailbox commands will support sending multi packet writes and updated
> firmware now requires that the message size be written for all commands
> along with the packet size. Since the driver doesn't perform writes larger
> than the packet size, set the message size to the same value.
>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---


Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


>
> V4 - no changes
> V3 - no changes
> V2 - no changes
>
>  drivers/platform/x86/intel/sdsi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
> index 556e7c6dbb05..a70c071de6e2 100644
> --- a/drivers/platform/x86/intel/sdsi.c
> +++ b/drivers/platform/x86/intel/sdsi.c
> @@ -252,6 +252,7 @@ static int sdsi_mbox_cmd_write(struct sdsi_priv *priv, struct sdsi_mbox_info *in
>  		  FIELD_PREP(CTRL_SOM, 1) |
>  		  FIELD_PREP(CTRL_RUN_BUSY, 1) |
>  		  FIELD_PREP(CTRL_READ_WRITE, 1) |
> +		  FIELD_PREP(CTRL_MSG_SIZE, info->size) |
>  		  FIELD_PREP(CTRL_PACKET_SIZE, info->size);
>  	writeq(control, priv->control_addr);
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


