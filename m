Return-Path: <linux-kernel+bounces-131649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F54898A69
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47C711F26728
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BBC129A6D;
	Thu,  4 Apr 2024 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gyRaBgO6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBF51BF37;
	Thu,  4 Apr 2024 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712242230; cv=none; b=VcSWB9oZAMIFIplX1VZ4ERAhOwqgsRD4i/KFMFzw2BzIAPsBvzTOlBxKjW0qiBmQqA7XHXJFTUpeKTJQhgWTsSkxt3iXWY9NN/25xpzBxrxs8onJXului0+rRGZS0HEtJqEZY7oeuiX1dTpTFEcHh7d06mbGzaSuv9vYiOJOwGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712242230; c=relaxed/simple;
	bh=SCMIZ1IGMHRrGNpDE/LUqaEShJmCNL+gjhIz3VUxPNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h9dIa+Ioy84v9uBY6vAjjuAYYqGwWgc26tELAfpULWkDkZYyAAYUjnnjhr4i/XWOFNHHpNRU1cyitR/DegunX+xaxCnmHNUQ0YguyKU4BAvlY9rO6FOskjDpwiKRVlSX7HQ0p9e35zObKCqX7Yn8uJ6QXMSxYilnSrpp05bQ5Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gyRaBgO6; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712242229; x=1743778229;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SCMIZ1IGMHRrGNpDE/LUqaEShJmCNL+gjhIz3VUxPNw=;
  b=gyRaBgO6iHU7G+M3z7CAuDPNh8s9ZqsGIL4Lco23SXCenJ4IaCHsOFj2
   KzVU3PJMDVcZcbl9LWwoECo28JcItO+LbqV4vgr0vAVhyQBDX16gLsmsv
   UvxVThRjAgJGvP15ucQW+1QFbEJXDqQgOZYcbkjIAJAXlJXTkxhGUOE5U
   Jh/0V5yny640vDFGFyWrcNCwt7O313bEL8ly5RbdHFcE3WD/7lURsrhBH
   RQTjosXEnENPvAeJ+9nZnlHbjGrLzwGMYRjKYVbNO7sxrIhYSauho+34u
   MQsLAfkqdQD3tHP9pRp3oHAUnJmpIfLAre3CeciALo0xvvnAq7flgBJoT
   Q==;
X-CSE-ConnectionGUID: 6oSGR9rKSJmIImoaTSPmIA==
X-CSE-MsgGUID: xnmJQGB0T4O2cKhBLBiowg==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="18885071"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18885071"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 07:50:28 -0700
X-CSE-ConnectionGUID: GaTUqSPCScudo0L9LiAGBg==
X-CSE-MsgGUID: G5bDDajiRvKG+tlUsjc4PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="19264395"
Received: from aghiriba-mobl.ger.corp.intel.com (HELO [10.251.213.116]) ([10.251.213.116])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 07:50:25 -0700
Message-ID: <853f31f7-3616-4412-b153-ee24a7901757@linux.intel.com>
Date: Thu, 4 Apr 2024 17:50:55 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: SOF: Disable pointless writes to debugfs file
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, sound-open-firmware@alsa-project.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <9d2477cf-25aa-4d12-818f-fdafc9aaa28a@moroto.mountain>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <9d2477cf-25aa-4d12-818f-fdafc9aaa28a@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 04/04/2024 10:38, Dan Carpenter wrote:
> The permissions on this debugfs file are 0444 so it can't be written to.
> And writing to the file hasn't done anything since commit 6e9548cdb30e
> ("ASoC: SOF: Convert the generic IPC flood test into SOF client").
> Delete the write function.

I agree, it is not used anymore and ...

> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Acked-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

> ---
> I haven't tested this patch and there is a risk that it breaks some of
> the test scripts.  Another option would be to just make it a dummy
> function that does { return count; }.  But I thought I would try the
> better option first.
> 
> Please review this extra carefully.
> 
>  sound/soc/sof/debug.c | 19 -------------------
>  1 file changed, 19 deletions(-)
> 
> diff --git a/sound/soc/sof/debug.c b/sound/soc/sof/debug.c
> index 7c8aafca8fde..937e51b02a24 100644
> --- a/sound/soc/sof/debug.c
> +++ b/sound/soc/sof/debug.c
> @@ -19,24 +19,6 @@
>  #include "sof-priv.h"
>  #include "ops.h"
>  
> -static ssize_t sof_dfsentry_write(struct file *file, const char __user *buffer,
> -				  size_t count, loff_t *ppos)
> -{
> -	size_t size;
> -	char *string;
> -	int ret;
> -
> -	string = kzalloc(count+1, GFP_KERNEL);
> -	if (!string)
> -		return -ENOMEM;
> -
> -	size = simple_write_to_buffer(string, count, ppos, buffer, count);
> -	ret = size;
> -
> -	kfree(string);

This was not too constructive ;)

> -	return ret;
> -}
> -
>  static ssize_t sof_dfsentry_read(struct file *file, char __user *buffer,
>  				 size_t count, loff_t *ppos)
>  {
> @@ -126,7 +108,6 @@ static const struct file_operations sof_dfs_fops = {
>  	.open = simple_open,
>  	.read = sof_dfsentry_read,
>  	.llseek = default_llseek,
> -	.write = sof_dfsentry_write,
>  };
>  
>  /* create FS entry for debug files that can expose DSP memories, registers */

-- 
Péter

