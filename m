Return-Path: <linux-kernel+bounces-126923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9D289447B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00FE41F21DCE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76EE4D9FC;
	Mon,  1 Apr 2024 17:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="4Jw4mWhe"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A951DFE3;
	Mon,  1 Apr 2024 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711993799; cv=none; b=QrU2GVk2Ch02oBMkBp4ZVogLEPVxDer5qVSyQS2HgWTCUaB8Cs3pL90M2NW+UfM6M/AOLvp5Lp0cPNWbQg63fWZq0l9Z/66ctVHVtMQ5zTqOL74Q2+qYEqdIuJ0zFonN2P4YNEYxKFGjGGAy5m8g1ikuaTcPV1yfvIFpz7GQoTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711993799; c=relaxed/simple;
	bh=0Lsq5qG7Op258QzJlgfWQaCKAZFa4k8JLBKF+U4I5Ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rBuJaDzz5QyGhRmGLWo28//mJ/xKOQloTEAKotCjeXW/q/GFs/9ccWzW5m+HguHQP79AOdwpKI5+sEUNpMhxGIYLCntfD7q3IyybovUEP6tNe3cQqqZVxqY4Ln8ZpxfVmlHEBEOkn5jTR2YIRwe6hQJblIi+q03BkAPIWbckM1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=4Jw4mWhe; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V7dnd0QS6zlgTGW;
	Mon,  1 Apr 2024 17:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711993793; x=1714585794; bh=3aS9fjkX6tN76YzPo3xB7NYr
	A2s4BoUyM+VqTM+665Y=; b=4Jw4mWheS2jIaEYmZlHV7q4pkFt5/nu/FCfCYr/4
	xAFiF2sZbaMauAZFuRhoVOevPuP0sZDLvCp4Z8PCKLGso+w/mdEncIphcEVAlDcD
	3jWLa4GPvIOCdnEiDbAnJ2vx0BO3olseDecRViw95TcQnWH004HWLTEU3IKpqLBi
	hcvPZhjonqIpZIhh3UX/gJl14yBoJsfwSAdXWFfMHo+y1TT91whaAHagKwiqK9Ki
	DWQN8iQcyE7rcXMHLgWfl7NzrQKLYiWjPx8oY9ftFBfPd4My+FcNAN6ZL47m7hR8
	3rDum5ON9pO1cNPzfjMZh/Cmz1CHvsH7yjskFjWWIAPG8A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id NCgN9-qSKE04; Mon,  1 Apr 2024 17:49:53 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V7dnW5nQ6zlgTHp;
	Mon,  1 Apr 2024 17:49:51 +0000 (UTC)
Message-ID: <1c65d12e-3821-4cae-a268-4f2755ad53af@acm.org>
Date: Mon, 1 Apr 2024 10:49:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: sd: unregister device if device_add_disk() failed
 in sd_probe()
Content-Language: en-US
To: linan666@huaweicloud.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
 mcgrof@kernel.org
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
 houtao1@huawei.com, yangerkun@huawei.com
References: <20231208082335.1754205-1-linan666@huaweicloud.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231208082335.1754205-1-linan666@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/8/23 00:23, linan666@huaweicloud.com wrote:
> From: Li Nan <linan122@huawei.com>
> 
> "if device_add() succeeds, you should call device_del() when you want to
> get rid of it."
> 
> In sd_probe(), device_add_disk() fails when device_add() has already
> succeeded, so change put_device() to device_unregister() to ensure device
> resources are released.
> 
> Fixes: 2a7a891f4c40 ("scsi: sd: Add error handling support for add_disk()")
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/scsi/sd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 542a4bbb21bc..d81cbeee06eb 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -3736,7 +3736,7 @@ static int sd_probe(struct device *dev)
>   
>   	error = device_add_disk(dev, gd, NULL);
>   	if (error) {
> -		put_device(&sdkp->disk_dev);
> +		device_unregister(&sdkp->disk_dev);
>   		put_disk(gd);
>   		goto out;
>   	}

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

