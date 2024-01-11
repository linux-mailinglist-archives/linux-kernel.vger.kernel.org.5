Return-Path: <linux-kernel+bounces-23937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A2182B42C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E885A1F2433D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AD053806;
	Thu, 11 Jan 2024 17:33:30 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A495537E3;
	Thu, 11 Jan 2024 17:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d3eae5c1d7so30734465ad.2;
        Thu, 11 Jan 2024 09:33:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704994407; x=1705599207;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xhz/lG4EsXKgcCYrcQVY+shefZ4zMHBbZ8MsW9wIwb8=;
        b=hrEyMDRKhgcr6cBaDzzLgW9HwHE+YDsYvpYztQ1h/NvwSJKoOPni7J8N/r4+WbU+/l
         kAj8Myh6um6ZNt85EUbKLbWikDYWI2NJzLwGkKHrEa1EHH6eB9R3z5Alk9Xqmd7XG9EB
         uNxsT/GHb4AmxwDpADOk21euOMJRemDwt2Gmq6Uq7ziKjiSK1yeFk5Ee6EC0+xTTnn7C
         kVLCYX6Yf9R3XCH6/cSWCi61Nh9c7opsPWne/ZtxS+yQCGeUXpdjVddNap1YP5w14cpE
         LMxmxKO4F0oQs7QMwUeelLshFzVnoYBWV0kCE7uNNy8cUQWSGLiuRhoXntOcQ8nYbT3q
         hLgA==
X-Gm-Message-State: AOJu0YyQ0kF40SkMUM/jGQk4LN0zXe55AI4lQvKisnorMCc/coIEo8NP
	v7VZfGN2Ndp6DzPHCtyNyxU=
X-Google-Smtp-Source: AGHT+IH3IJgqi1b65LHZnGEZrDZRn9LfhP44UO2FDqI1kW7N4WDRko0M3lDABkq+lnDRjDcI1Fi3qA==
X-Received: by 2002:a17:902:c286:b0:1d4:e1f1:eea3 with SMTP id i6-20020a170902c28600b001d4e1f1eea3mr10640pld.131.1704994407454;
        Thu, 11 Jan 2024 09:33:27 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:2b84:6ee3:e813:3d8d? ([2620:0:1000:8411:2b84:6ee3:e813:3d8d])
        by smtp.gmail.com with ESMTPSA id jx2-20020a170903138200b001d46d9953a3sm1429343plb.241.2024.01.11.09.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 09:33:26 -0800 (PST)
Message-ID: <89041392-c747-4aa8-875d-38d3dc892ffa@acm.org>
Date: Thu, 11 Jan 2024 09:33:24 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: aacraid: Clean up errors in commsup.c
Content-Language: en-US
To: XueBing Chen <chenxb_99091@126.com>, jejb@linux.ibm.com,
 aacraid@microsemi.com, martin.petersen@oracle.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20240111113240.15985-1-chenxb_99091@126.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240111113240.15985-1-chenxb_99091@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/11/24 03:32, XueBing Chen wrote:
> Fix the following errors reported by checkpatch:
> 
> ERROR: spaces required around that '<' (ctx:VxV)
> ERROR: "foo * bar" should be "foo *bar"
> 
> Signed-off-by: XueBing Chen <chenxb_99091@126.com>
> ---
>   drivers/scsi/aacraid/commsup.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/aacraid/commsup.c b/drivers/scsi/aacraid/commsup.c
> index 25cee03d7f97..865316ba3c19 100644
> --- a/drivers/scsi/aacraid/commsup.c
> +++ b/drivers/scsi/aacraid/commsup.c
> @@ -129,7 +129,7 @@ void aac_fib_vector_assign(struct aac_dev *dev)
>    *	fib area, the unmapped fib data and also the free list
>    */
>   
> -int aac_fib_setup(struct aac_dev * dev)
> +int aac_fib_setup(struct aac_dev *dev)
>   {
>   	struct fib *fibptr;
>   	struct hw_fib *hw_fib;
> @@ -144,7 +144,7 @@ int aac_fib_setup(struct aac_dev * dev)
>   		if (dev->comm_interface != AAC_COMM_MESSAGE_TYPE3)
>   			dev->init->r7.max_io_commands = cpu_to_le32(max_cmds);
>   	}
> -	if (i<0)
> +	if (i < 0)
>   		return -ENOMEM;
>   
>   	memset(dev->hw_fib_va, 0,

checkpatch is for checking patches before these are submitted and should not
be run on code that has already been merged into the kernel tree.

Bart.

