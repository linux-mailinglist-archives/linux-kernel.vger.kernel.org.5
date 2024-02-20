Return-Path: <linux-kernel+bounces-73433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4AF85C282
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4288328294F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B2C77658;
	Tue, 20 Feb 2024 17:21:43 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACDC77626;
	Tue, 20 Feb 2024 17:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708449702; cv=none; b=Ga5CSM2k5xwranlZl+YJmESnqyx48h0o8U+jMal1UnpHt9GMjMstHBRrIq+YK1gv+477RogPX4Juxkq+AOYgMuY58TxTfrWlNv++UBuvpqQuGU8JHfj0MwXSjfW69P5bOzRstya1Ibt4WpZAPGFxn8qTV22S2xeiQtGq8HBzUsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708449702; c=relaxed/simple;
	bh=mPo+l7s6R2Mn5HzTebtRduD2jfu/x8K/datW8X5vC90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q2+OpkUeas4pb8Dt/N4dct68D7PguvkyP2VOMx/sqsztDCcfjNBkfblko2CQ5bVLWJXU4DUQ0Nun/l3hPk/K/SVNoTbS14YzQ7EdCTgfOD+p4rZcZQwruOfa5Kose2kWoISvI4pI/vC2J3MmHinz37U+jxf4uChFLGEU3KRZzd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e0f803d9dfso2903171b3a.0;
        Tue, 20 Feb 2024 09:21:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708449699; x=1709054499;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q2yUIPD7foX8u6Xdbasilcg/3p8ULKCtlmQtBTHBRrU=;
        b=e/kosMAp12J+yiF6DGKXrEZV1tkuDDqC0SOtLxOfO8mgIOy4Dz7r1qSEZf6oupFoF/
         02wKYY1lxGnKrC9NpVd2zzHiStrEUWWy8hAlh97ijzqcm1+YplTxMGAfAeiMgv5xEpHq
         SPawy8MzbgG+TfY79r8xaHzNpjnbmxKeU9LPCK6+yzzrfxc1aUdVKTkdUTn4je2JbUDz
         7c1iiXh4VBkKu6yx7bkYDPGLfSLfW+rJUGkqxONBzpi81tMPQZQ5qddBdoWPX9RpwgwX
         8kwexL3MwdrXzI+VyoT8+RsprOIh7c/naz4/E7Et4lERLjdRSu0ovUY/gPB9IaKXsPGv
         j1wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWByMh4C5ZiEkgqW2yRsoX+fRY/iXFnHgIYxgfo2SKz0/Nkp+gLYk7vJiwE0iCzcFEgciuISwTO4TmAsJC/f4ZuXG13o6IiWnH5ZG5lr9bjkb5ioe7UDcmXbVxsyRXX1m2VwLQPAXx/FA==
X-Gm-Message-State: AOJu0YxU1vWtfGQeD/WGaUwHy3D96lxG0nyLkpPdtCGWRqz11iqGp4N/
	7GaqVIbhnzFbpE4s+5lEVYd41AoccsBVzZ21VAzgOlxeqSB+rLk8
X-Google-Smtp-Source: AGHT+IE779i2QADDo/XfAUyVbShxQgDbClnCbfoX2CDYqxGWSdXQL6WKX7naG+PPOPmDkKWQE36Vow==
X-Received: by 2002:a05:6a00:1897:b0:6e4:864a:9f68 with SMTP id x23-20020a056a00189700b006e4864a9f68mr1190636pfh.5.1708449699227;
        Tue, 20 Feb 2024 09:21:39 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:455a:b76d:46a7:7189? ([2620:0:1000:8411:455a:b76d:46a7:7189])
        by smtp.gmail.com with ESMTPSA id d5-20020aa78685000000b006e2301e702fsm6824989pfo.125.2024.02.20.09.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 09:21:38 -0800 (PST)
Message-ID: <1920a2f6-e398-47af-a5d7-9dad9c70e03d@acm.org>
Date: Tue, 20 Feb 2024 09:21:37 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ufs: core: Fix setup_xfer_req invocation
Content-Language: en-US
To: Rohit Ner <rohitner@google.com>, Can Guo <quic_cang@quicinc.com>,
 Bean Huo <beanhuo@micron.com>, Stanley Chu <stanley.chu@mediatek.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Avri Altman <avri.altman@wdc.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240220090805.2886914-1-rohitner@google.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240220090805.2886914-1-rohitner@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/24 01:08, Rohit Ner wrote:
> Allow variant callback to setup transfers without
> restricting the transfers to use legacy doorbell
> 
> Signed-off-by: Rohit Ner <rohitner@google.com>
> ---
>   drivers/ufs/core/ufshcd.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index d77b25b79ae3..91e483dd3974 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -2280,6 +2280,9 @@ void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag,
>   		ufshcd_clk_scaling_start_busy(hba);
>   	if (unlikely(ufshcd_should_inform_monitor(hba, lrbp)))
>   		ufshcd_start_monitor(hba, lrbp);
> +	if (hba->vops && hba->vops->setup_xfer_req)
> +		hba->vops->setup_xfer_req(hba, lrbp->task_tag,
> +						!!lrbp->cmd);
>   
>   	if (is_mcq_enabled(hba)) {
>   		int utrd_size = sizeof(struct utp_transfer_req_desc);
> @@ -2293,9 +2296,6 @@ void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag,
>   		spin_unlock(&hwq->sq_lock);
>   	} else {
>   		spin_lock_irqsave(&hba->outstanding_lock, flags);
> -		if (hba->vops && hba->vops->setup_xfer_req)
> -			hba->vops->setup_xfer_req(hba, lrbp->task_tag,
> -						  !!lrbp->cmd);
>   		__set_bit(lrbp->task_tag, &hba->outstanding_reqs);
>   		ufshcd_writel(hba, 1 << lrbp->task_tag,
>   			      REG_UTP_TRANSFER_REQ_DOOR_BELL);

UFS controllers that are compliant with the JEDEC UFSHCI specification do
not need the .setup_xfer_req() callback so I think a better motivation is
needed to make this change.

Thanks,

Bart.

