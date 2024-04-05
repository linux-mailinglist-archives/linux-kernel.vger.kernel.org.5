Return-Path: <linux-kernel+bounces-133155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDD8899FAD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DC091C22E35
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF00B16EC09;
	Fri,  5 Apr 2024 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UfcP3doI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE8C16D309;
	Fri,  5 Apr 2024 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327371; cv=none; b=HWhHKKKYQtqH4XspZ5o/yyXK9mES814nc+aaMigfkTfGNJ+IkmsNZ7SpbNgLooW0HW5HVaHtw9SxFJZZMU5W4Sg1w/0ZWihHJRhuOSOONRw2EjsUTUSnCNfpuS6uEGK4b7mTX4zPUr7WfCxNyFps1+lnYcBSTZbhzM85t4Lg9Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327371; c=relaxed/simple;
	bh=adxHW9H6aeu4CTh2dg1sxI3yYbg0QDcIPqVAHiPrhtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Sk2ggVAH5vZXJPhseuhiC/htQeNyJsVBKksxvxaGCWsf77gegjS7BagejccWDp9mgifsyUTVjfPzoCt6KCePBz9x21N6j7fTG3GhGgVJ+efXNq72w4TsLEfDZgssEWWWABOkyxLogV2Td5jDtUKk7pDSHDJkU80JdHUjpZnQ78Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UfcP3doI; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712327370; x=1743863370;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=adxHW9H6aeu4CTh2dg1sxI3yYbg0QDcIPqVAHiPrhtY=;
  b=UfcP3doIqM3T2EzRQ1KSGZ/EijoU+55WO7qcE2Ez7rNBkueKW91M6U1i
   XYTxYn7vHeB6ZMFVp6F3WQX82g1ZQFN8mDE+ccF5n6OfbwmLdSrchUX05
   FEG9jKmkg7St9DFmVroOrRhae8fja1hhgZZ+DJw14PUX2NPQGerx2CwUi
   2+k/7sxb8C3UWrls+Uujwe4bw4bdnJcloeAbGqFQfKTrBJ/DiS0iSHIvD
   1ZBZxOi8r8AlOAwO2XSBTJ7Hh/nNd0WCR91UZlcc3KqyF+d9Sn4tTEP0T
   mA6UHJ995LpfSwiAgymovQd2wZPPsyueUn/QnBBv2qMYbjKKV1a8yb6a9
   A==;
X-CSE-ConnectionGUID: h/lXbwtvRCKUgxjzq9M9jA==
X-CSE-MsgGUID: tJEMN/HIR6qplOapsyA9MA==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="11476054"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="11476054"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 07:29:29 -0700
X-CSE-ConnectionGUID: kiabjL1rTYaanOt+F3VO1w==
X-CSE-MsgGUID: /eSRb+p3Tmuap6/P+d5iiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19248796"
Received: from mdawoo-mobl.amr.corp.intel.com (HELO [10.212.152.63]) ([10.212.152.63])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 07:29:29 -0700
Message-ID: <1a78408b-f933-49f9-9c37-2f4dff90c22e@linux.intel.com>
Date: Fri, 5 Apr 2024 07:29:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/9] platform/x86/intel/sdsi: Set message size during
 writes
To: "David E. Box" <david.e.box@linux.intel.com>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240405032507.2637311-1-david.e.box@linux.intel.com>
 <20240405032507.2637311-2-david.e.box@linux.intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240405032507.2637311-2-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/4/24 8:24 PM, David E. Box wrote:
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


