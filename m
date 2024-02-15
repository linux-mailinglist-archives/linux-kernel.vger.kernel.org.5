Return-Path: <linux-kernel+bounces-67488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 880CB856C5F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13E42B25228
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4471386BA;
	Thu, 15 Feb 2024 18:22:52 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6B612FB27;
	Thu, 15 Feb 2024 18:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021372; cv=none; b=jMLyH5xNMSTQpWV2nxqyVOC7r/hPO17tDWzyx6eyBklla/9hg8so/rY0ITCfHdWAh78PZEC8h9jSsnKahzkTfwdQDQ+5EpdAKCPom8SdvhEUcG/GClUWE9dsijjWEJaC8z2Tw9j4jzughvANg/cfNIksWtGzCwKgdi5WXXJiPec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021372; c=relaxed/simple;
	bh=sVLqjHMpdorak55XCRBQy/M4CiqC68hiCEFUZxYrYao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dm1T0rcA7BQd3QdicPU9FbYbvKSORajGPhUaKaOcjjFqZmeI2oiZqVc8YAXTwyvZV320X4TCQd8o0LxNF5210mRh7pq7VZH2KyBAhqZs7iXZkVfedH3r9l1B880wUpnqitouqKM8spOwkCEVUbrbCVV/4HHzukMXrjKMiZESfGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-298ae92a7bbso1639778a91.1;
        Thu, 15 Feb 2024 10:22:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708021370; x=1708626170;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kK7QrrhmrKioAg7I1hm8NPjmxj5IhQb3603fza0D3V0=;
        b=a7Gqq4b9mkSNKzWwFAmrWwKPdAx9R0JyVbJxMN6evmZZ1/4P91FPGYWdlr68wA+zh7
         wBbgT9r5ee6ZROcIkvfg2DQtgWFxWjzmandNajasWRHTEaLY1SpDYaNO/Huz/7P6RMzc
         VCvoTf1pWXglNqX3kEQ2GR7Uw0FBIDa8DWUNgrT6fDAG6dEb51Sqdx+srG2McFS6Y0an
         IohvQbTCALlEjmJklRIOShhzO9Tt3uFm02OongshKcSiCUJcybpgeSsKa10Kp/dfPrie
         eNPSEj5AYVdlgfjXCdrWcmmFYK+eiUVRPRkMY66iPR8wgFao3enb7nQ2ye45pPEOySra
         gkAw==
X-Forwarded-Encrypted: i=1; AJvYcCWJ8Wn1NItS8ZpQ+M6nlGiPYV0IqYlUFDBHvYEij/aw6bLZ7jxQqgG6r/4otcrYVK2xbMF8v/yuyJ4upN9TFKSCaLpSx1bGCyg2Hw3ptWJPtAHtHzolIYwE2MGzeYWHDJHVz7PCW6ZVtSumEo+3wBnOyCk9gjQ9R81NoaiiWmkfbjvlc/r3+qrtHA==
X-Gm-Message-State: AOJu0YzgRrNwqKSPodLgZublPQPIsB8vK7Ti+ob+u0CbNRkdPPp6BgLY
	VABqMVX1El2MJEv4d6oL7BLM8X8AOjr/zmhMS6oc/QSRjU0E2w5B
X-Google-Smtp-Source: AGHT+IErKIyalnW4G+1xN6btEuyGDt0u6FDL2UzgHjTy2VfneU6TkTRyTJer4zwNcWM9X8zRGMY6DA==
X-Received: by 2002:a17:90b:400a:b0:299:275d:b677 with SMTP id ie10-20020a17090b400a00b00299275db677mr1331363pjb.5.1708021369961;
        Thu, 15 Feb 2024 10:22:49 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:cc45:481:45f0:7434? ([2620:0:1000:8411:cc45:481:45f0:7434])
        by smtp.gmail.com with ESMTPSA id y4-20020a17090a1f4400b00298f86ab9b3sm1916900pjy.2.2024.02.15.10.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 10:22:49 -0800 (PST)
Message-ID: <2a27e9a0-04fb-40b6-b725-c53fca21062a@acm.org>
Date: Thu, 15 Feb 2024 10:22:46 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ufs: uninitialized variable in
 ufshcd_devfreq_target()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Peter Wang <peter.wang@mediatek.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Stanley Chu <stanley.chu@mediatek.com>, Can Guo <quic_cang@quicinc.com>,
 "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bean Huo <beanhuo@micron.com>, Ziqi Chen <quic_ziqichen@quicinc.com>,
 Adrien Thierry <athierry@redhat.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <c787d37f-1107-4512-8991-bccf80e74a35@moroto.mountain>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c787d37f-1107-4512-8991-bccf80e74a35@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/24 10:08, Dan Carpenter wrote:
> There is one goto where "sched_clk_scaling_suspend_work" is true but
> "scale_up" is uninitialized.  It leads to a Smatch uninitialized variable
> warning:
> 
> drivers/ufs/core/ufshcd.c:1589 ufshcd_devfreq_target() error: uninitialized symbol 'scale_up'.
> 
> Fixes: 1d969731b87f ("scsi: ufs: core: Only suspend clock scaling if scaling down")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/ufs/core/ufshcd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index d10a77d05d2f..a8a9edb7ba24 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -1514,7 +1514,7 @@ static int ufshcd_devfreq_target(struct device *dev,
>   	int ret = 0;
>   	struct ufs_hba *hba = dev_get_drvdata(dev);
>   	ktime_t start;
> -	bool scale_up, sched_clk_scaling_suspend_work = false;
> +	bool scale_up = false, sched_clk_scaling_suspend_work = false;
>   	struct list_head *clk_list = &hba->clk_list_head;
>   	struct ufs_clk_info *clki;
>   	unsigned long irq_flags;

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

