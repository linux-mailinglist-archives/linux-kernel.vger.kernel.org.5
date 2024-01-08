Return-Path: <linux-kernel+bounces-19898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FB0827664
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8879AB21DE3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02F454F82;
	Mon,  8 Jan 2024 17:32:44 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3040954F8F;
	Mon,  8 Jan 2024 17:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6d9e62ff056so1764115b3a.1;
        Mon, 08 Jan 2024 09:32:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704735162; x=1705339962;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kw+wSdthHXaeTv2yem3P/PJZDXSCJyoCnP92JkrK1gU=;
        b=wzP67SDLEKGyDvk6sU6Lm94kx+oM8Dcl9aX3RipFPp5xn6452Myjb/uAeR53hsmcRf
         11JH2vxZgJW5vI6/wzqhXl7rgRiZMwuQFrM0+nwnyQ5tDYTIURjAYRmK0BJTZw+wxb3f
         hrlNmbnbYj83rledjAtagW/ePQQ5gD14nMqap3OK735OwoDH7OHFyqbocJLyOUds/r68
         8ttK3jDxeJ494LIs4jl0aVPPD1r2H6F7gQqCMp7kRFvZQMLY+DHsbN0JyWTtnPTjWkdF
         Mq1F+0gRfEwpLbXSIEZM72hTvHIml0nsYJqu5YPpyGapHJrBwY/bxCT7YGLV8GGAs9sr
         SOkw==
X-Gm-Message-State: AOJu0YyYvB/xl52zSbrW1Wa1h/5j6cED/7/c2ctrP1GOHaUItCZAX7jM
	mhCmkR0jN8U8ZXKEaCt5Fr8=
X-Google-Smtp-Source: AGHT+IHp9BFJgHPG3clEPLIKtzI6ppcoXOfiEZsiKulk1TaBrIZt2HovAlTCALbODeiuxNv3qa14EA==
X-Received: by 2002:aa7:860a:0:b0:6d9:b417:1afe with SMTP id p10-20020aa7860a000000b006d9b4171afemr3984755pfn.32.1704735162220;
        Mon, 08 Jan 2024 09:32:42 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:cee:c48d:78d6:ed9a? ([2620:0:1000:8411:cee:c48d:78d6:ed9a])
        by smtp.gmail.com with ESMTPSA id gx18-20020a056a001e1200b006d93ca7f8f3sm126390pfb.150.2024.01.08.09.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 09:32:41 -0800 (PST)
Message-ID: <175cf5c2-0bf2-48f4-8f48-a9589b6ad916@acm.org>
Date: Mon, 8 Jan 2024 09:32:39 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ufs:mcq:Remove unused parameters
Content-Language: en-US
To: Chanwoo Lee <cw9316.lee@samsung.com>, alim.akhtar@samsung.com,
 avri.altman@wdc.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
 stanley.chu@mediatek.com, quic_cang@quicinc.com, mani@kernel.org,
 quic_asutoshd@quicinc.com, powen.kao@mediatek.com, quic_nguyenb@quicinc.com,
 yang.lee@linux.alibaba.com, peter.wang@mediatek.com, athierry@redhat.com,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: grant.jung@samsung.com, jt77.jang@samsung.com, dh0421.hwang@samsung.com,
 sh043.lee@samsung.com
References: <20240105021041.20400-1-cw9316.lee@samsung.com>
 <CGME20240105021223epcas1p156208a9a445b5e0b527a9eb2d2589ed3@epcas1p1.samsung.com>
 <20240105021041.20400-3-cw9316.lee@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240105021041.20400-3-cw9316.lee@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/4/24 18:10, Chanwoo Lee wrote:
> From: ChanWoo Lee <cw9316.lee@samsung.com>
> 
> The 'hwq' parameter is not used in this function.
> So, remove unused parameters.
> 
> Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>
> ---
>   drivers/ufs/core/ufs-mcq.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index edc752e55878..8db81f1a12d5 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -258,9 +258,7 @@ EXPORT_SYMBOL_GPL(ufshcd_mcq_write_cqis);
>    * Current MCQ specification doesn't provide a Task Tag or its equivalent in
>    * the Completion Queue Entry. Find the Task Tag using an indirect method.
>    */
> -static int ufshcd_mcq_get_tag(struct ufs_hba *hba,
> -				     struct ufs_hw_queue *hwq,
> -				     struct cq_entry *cqe)
> +static int ufshcd_mcq_get_tag(struct ufs_hba *hba, struct cq_entry *cqe)
>   {
>   	u64 addr;
>   
> @@ -278,7 +276,7 @@ static void ufshcd_mcq_process_cqe(struct ufs_hba *hba,
>   				   struct ufs_hw_queue *hwq)
>   {
>   	struct cq_entry *cqe = ufshcd_mcq_cur_cqe(hwq);
> -	int tag = ufshcd_mcq_get_tag(hba, hwq, cqe);
> +	int tag = ufshcd_mcq_get_tag(hba, cqe);
>   
>   	if (cqe->command_desc_base_addr) {
>   		ufshcd_compl_one_cqe(hba, tag, cqe);

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

