Return-Path: <linux-kernel+bounces-131683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77968898AC3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A87C61C2782C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8B2763F4;
	Thu,  4 Apr 2024 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dc3+AVDp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9491D551;
	Thu,  4 Apr 2024 15:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243529; cv=none; b=oZAKbZyACid+P6UIEd1EIPVPDswjf1pZq1L8sc7S0nDi7ItVU5GhAquW9GO3W8vCoU8bL48l/zs3LZGAXJMdMF8L5NYbbYpgsLP7jrniSsju+zZF2FoAhB1IKRKCMMp+NOkeqE5DwpGlC3RitXdb2/aPAM55oQ6boATjiP+WkkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243529; c=relaxed/simple;
	bh=J1aqCHl4RlvByCEFGZ60+2vPpqa4aKe6g5qYLLoW0CI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WUW8zq2njdAi9h3H2wQ9MlTohOjKCCbCngfWjkg5XmuDIOSamhxFW86yUAO8PD7jlfkrMh2nuRyuhrRvLV+CVzQ9oX1IQYpW8gqbpQVAHW3o/o9zOs0UJBrDODZnGwHk6cm8thrWpU0YuSxFgGyn64dSJmT9ZSH6MN54BJJkRBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dc3+AVDp; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712243528; x=1743779528;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J1aqCHl4RlvByCEFGZ60+2vPpqa4aKe6g5qYLLoW0CI=;
  b=Dc3+AVDpodc3alHA0dmsqxF6ClKugBDF7/XTS2MwaT/7Gq+npGwklAL3
   zm+hsm1l3g2glFjQ1YcN6c4UPpK56V5N5Fbypxp0Zujkz/R7+dupuj3Vg
   9VWDSYiqyFCPvLKgwhod0tWfUfzweMjyXATJ3/Tixs6raJNbFURHEOC9t
   IGTPIz8crVFKwSx5uZsCkA7UjKdpUkoqDH856a4LfDzInz38TY2kWo7vy
   i1IjzNAKSBsQRojYxm2f8oeInV9Fo9gx0N5fvHPJvxKh2C6KKRyG/CM1Y
   ezzYs2aHpsp1Wq/t6/shaJAApJ560wQbm1ke0p7fcHKHKwiwznXlQXRXz
   A==;
X-CSE-ConnectionGUID: oHke3O1MQ+iUPrXb3nkyPw==
X-CSE-MsgGUID: x7yeo/CiRUOF+77ysEWvnw==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="11355536"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="11355536"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 08:12:07 -0700
X-CSE-ConnectionGUID: JEZ3/RujSLiVwTylxe6LDw==
X-CSE-MsgGUID: 7XRf0ZZKT4u4MRwLUuR2FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="23282962"
Received: from aghiriba-mobl.ger.corp.intel.com (HELO [10.251.213.116]) ([10.251.213.116])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 08:12:04 -0700
Message-ID: <bab6cb4d-a460-45c9-a889-52a97eb6dd69@linux.intel.com>
Date: Thu, 4 Apr 2024 18:12:35 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: SOF: Clean up sof_ipc_flood_dfs_write()
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
References: <a35dded2-392b-4ccb-9dbb-d782ac9b6547@moroto.mountain>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <a35dded2-392b-4ccb-9dbb-d782ac9b6547@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 04/04/2024 10:34, Dan Carpenter wrote:
> This function doesn't support partial writes so using
> simple_write_to_buffer() doesn't really make sense.  It's better to
> just use copy_from_user().
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks, it makes sense.

Acked-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

> ---
>  sound/soc/sof/sof-client-ipc-flood-test.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/sof/sof-client-ipc-flood-test.c b/sound/soc/sof/sof-client-ipc-flood-test.c
> index c0d6723aed59..1b2e9e25a836 100644
> --- a/sound/soc/sof/sof-client-ipc-flood-test.c
> +++ b/sound/soc/sof/sof-client-ipc-flood-test.c
> @@ -160,15 +160,20 @@ static ssize_t sof_ipc_flood_dfs_write(struct file *file, const char __user *buf
>  	unsigned long ipc_count = 0;
>  	struct dentry *dentry;
>  	int err;
> -	size_t size;
>  	char *string;
>  	int ret;
>  
> +	if (*ppos != 0)
> +		return -EINVAL;
> +
>  	string = kzalloc(count + 1, GFP_KERNEL);
>  	if (!string)
>  		return -ENOMEM;
>  
> -	size = simple_write_to_buffer(string, count, ppos, buffer, count);
> +	if (copy_from_user(string, buffer, count)) {
> +		ret = -EFAULT;
> +		goto out;
> +	}
>  
>  	/*
>  	 * write op is only supported for ipc_flood_count or
> @@ -198,7 +203,7 @@ static ssize_t sof_ipc_flood_dfs_write(struct file *file, const char __user *buf
>  	/* limit max duration/ipc count for flood test */
>  	if (flood_duration_test) {
>  		if (!ipc_duration_ms) {
> -			ret = size;
> +			ret = count;
>  			goto out;
>  		}
>  
> @@ -207,7 +212,7 @@ static ssize_t sof_ipc_flood_dfs_write(struct file *file, const char __user *buf
>  			ipc_duration_ms = MAX_IPC_FLOOD_DURATION_MS;
>  	} else {
>  		if (!ipc_count) {
> -			ret = size;
> +			ret = count;
>  			goto out;
>  		}
>  
> @@ -231,9 +236,9 @@ static ssize_t sof_ipc_flood_dfs_write(struct file *file, const char __user *buf
>  	if (err < 0)
>  		dev_err_ratelimited(dev, "debugfs write failed to idle %d\n", err);
>  
> -	/* return size if test is successful */
> +	/* return count if test is successful */
>  	if (ret >= 0)
> -		ret = size;
> +		ret = count;
>  out:
>  	kfree(string);
>  	return ret;

-- 
Péter

