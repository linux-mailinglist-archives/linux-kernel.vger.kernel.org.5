Return-Path: <linux-kernel+bounces-18902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8441D8264E2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 17:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225F21F215B1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 16:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601E913FE4;
	Sun,  7 Jan 2024 16:02:44 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E43313AC0;
	Sun,  7 Jan 2024 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5ced19f15c3so780481a12.0;
        Sun, 07 Jan 2024 08:02:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704643362; x=1705248162;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ubF9iYuqrA4cDqdTdDOmYrnWqJz+YZED4CQ5ndLEUD8=;
        b=MOQUE2lNdLM8mDu8hpTSWNyggozI5KirHnszqP3Md8Y+dIQdnNSL26Qw159AvgT9t3
         nOf8bhKQZsXhOJ645y/YLtt1hofrOvwMnUTxMVCZZD/Cn9nQEzIfoNGGAfOlajKxS2db
         tugyAkHQ/jzt1XX8hCTSB0whO+kbqwMfuXmAAiE+pHmJEd7i2vQGTnyMb9sDFKzOKdKb
         UiOhCKC/qaPIbOAp1XF4Wv1Pc8+zWkvZ47IOoxVgrskS4/Kheup8pzrd/kXnfR2QVsv7
         XcaOKqdgqlplwr1qvxvl+VS6/31NqlJFkSjZxzk3EHUol3+7sw6Ig5R6O22vUtpdLlJP
         HZ6A==
X-Gm-Message-State: AOJu0YwH5d82VALnN+N06NDoMKUrWv/q935zNQgYmdqAn4UzPZx2dL/J
	8QOlB1e1ho6OMAUmlhsgaHc=
X-Google-Smtp-Source: AGHT+IFnTcEJvXpZlDMsTDLddJNVooMEU9hBSNrdF520U5mapJb2euinHG76hUXlfsM6X7ynbITh9Q==
X-Received: by 2002:a17:902:9a02:b0:1d3:f43a:a2e2 with SMTP id v2-20020a1709029a0200b001d3f43aa2e2mr2599032plp.117.1704643361510;
        Sun, 07 Jan 2024 08:02:41 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709029a9600b001d35223d0besm4527054plp.251.2024.01.07.08.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jan 2024 08:02:40 -0800 (PST)
Message-ID: <65dead0b-34a5-4e29-83ec-c26e556f262a@acm.org>
Date: Sun, 7 Jan 2024 08:02:37 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ufs: get target SQ entry within critical section
Content-Language: en-US
To: Kiwoong Kim <kwmad.kim@samsung.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
 jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
 adrian.hunter@intel.com, h10.kim@samsung.com, hy50.seo@samsung.com,
 sh425.lee@samsung.com, kwangwon.min@samsung.com, junwoo80.lee@samsung.com,
 wkon.kim@samsung.com
References: <CGME20240104012454epcas2p36b58220b4c89ee72f1e095b34d329be2@epcas2p3.samsung.com>
 <1704331491-115325-1-git-send-email-kwmad.kim@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1704331491-115325-1-git-send-email-kwmad.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/3/24 17:24, Kiwoong Kim wrote:
> In IO centric scenarios, especially during a period that
> many IO requests are submitted to a same HW queue at the same
> time, it's found that one reqeust overwrote a SQ entry
> that had been already occupied by another request submitted
> in the past. And it eventually led to command timed-out
> because one of two requests were overwritten, which could not
> be completed.
> 
> [   74.995185][  T176] exynos-ufs 17100000.ufs: ufshcd_abort: Device abort task at tag 30
> 
> Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
> ---
>   drivers/ufs/core/ufshcd.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 7bc3fc4..da1a9c0 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -2199,9 +2199,10 @@ void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag,
>   	if (is_mcq_enabled(hba)) {
>   		int utrd_size = sizeof(struct utp_transfer_req_desc);
>   		struct utp_transfer_req_desc *src = lrbp->utr_descriptor_ptr;
> -		struct utp_transfer_req_desc *dest = hwq->sqe_base_addr + hwq->sq_tail_slot;
> +		struct utp_transfer_req_desc *dest;
>   
>   		spin_lock(&hwq->sq_lock);
> +		dest = hwq->sqe_base_addr + hwq->sq_tail_slot;
>   		memcpy(dest, src, utrd_size);
>   		ufshcd_inc_sq_tail(hwq);
>   		spin_unlock(&hwq->sq_lock);

Is this perhaps a duplicate of patch "scsi: ufs: core: Let the sq_lock 
protect sq_tail_slot access"? See also
https://lore.kernel.org/linux-scsi/1702913550-20631-1-git-send-email-quic_cang@quicinc.com/#t

Thanks,

Bart.

