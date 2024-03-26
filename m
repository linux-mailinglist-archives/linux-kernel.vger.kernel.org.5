Return-Path: <linux-kernel+bounces-119045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6543988C328
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E801C394B5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F992745D5;
	Tue, 26 Mar 2024 13:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8UAgcMU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9C967A00;
	Tue, 26 Mar 2024 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458878; cv=none; b=afDqzbauq6FJ/KX8EkTGa6HPFdVgw83FZnYPFZz9nMAAboSVRvcsd50pCXkX4PFE9Io/Kaq3REj3q8Y1anTrNYOGjME0MiDSuYCEQl3DD8VCIQ7cS9+Na1S2vn15rfX20A8zhSoOr/o+QzyC5mqVdZM4IgB6kSNtxmn648fS0KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458878; c=relaxed/simple;
	bh=nmWVxeahIwjiydd8whiklUV8w2UkQUt1yCCfBT1OWnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GxEnYbfzR9UOGmznMNwFufHMtlROpeIKZtL0oLCPR2X7baeNZk1yECECURQx9Mpwh1wFZiet5V9lBjBmcuEmRPkUwdUSM+bZSU9tbb3As29AGNHPMpqAMbi0ATdMe0Ti7DLj2H9xArVvEJtVuTzgmbWXo1I11sYsibpOUM/i/yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8UAgcMU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC19AC433F1;
	Tue, 26 Mar 2024 13:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711458878;
	bh=nmWVxeahIwjiydd8whiklUV8w2UkQUt1yCCfBT1OWnY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U8UAgcMUMoPBe08Joo53MjIM6CWAZ8Yk/tYFvFnt5mnaWxJU0n47rFFu689nzxXN7
	 ICE4ZOhKm3hWsHsn7XEnjlswT9TnAr2cP9u1ThJ4cJOnDEyCmu362CrQUTNBOsQCRe
	 5HPgdvi6jAbIEGgxA4O9Q7NW5jAZsxb8oaojOeyj6IDjqIztGa5huwR3iuOlM8TQ3d
	 /KQ4dkvsBhV8rOCdDecXytiD4kBCOuKFV+ThaPq8QPVbGSRW8NQ1GufLWRxnM6FL3T
	 32yiX5uGFZBrHV7s8HdDwmdEXPFx9/RzGtwnEqQ9Rqe745zA6gqsNRI9XaTMj2I3Bw
	 KwHvfFNy2ZDCg==
Message-ID: <5b5b9392-7fd2-4c87-8e41-5e54adf20003@kernel.org>
Date: Tue, 26 Mar 2024 22:14:11 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scsi: libsas: Allocation SMP request is aligned to
 ARCH_DMA_MINALIGN
Content-Language: en-US
To: Yihang Li <liyihang9@huawei.com>, john.g.garry@oracle.com,
 yanaijie@huawei.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
 chenxiang66@hisilicon.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com, prime.zeng@huawei.com, yangxingui@huawei.com
References: <20240326124358.2466259-1-liyihang9@huawei.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240326124358.2466259-1-liyihang9@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/26/24 21:43, Yihang Li wrote:
> This series [1] reducing the kmalloc() minimum alignment on arm64 to 8
> (from 128). In libsas, this will cause SMP requests to be 8-byte-aligned
> through kmalloc() allocation. However, for the hisi_sas hardware, all
> commands address must be 16-byte-aligned. Otherwise, the commands fail to
> be executed.
> 
> ARCH_DMA_MINALIGN represents the minimum (static) alignment for safe DMA
> operations, so use ARCH_DMA_MINALIGN as the alignment for SMP request.
> 
> Link: https://lkml.kernel.org/r/20230612153201.554742-1-catalin.marinas@arm.com [1]
> Signed-off-by: Yihang Li <liyihang9@huawei.com>
> ---
> Changes since v1:
> - Directly modify alloc_smp_req() instead of using handler callback.
> ---
>  drivers/scsi/libsas/sas_expander.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
> index a2204674b680..941abc7298df 100644
> --- a/drivers/scsi/libsas/sas_expander.c
> +++ b/drivers/scsi/libsas/sas_expander.c
> @@ -135,7 +135,10 @@ static int smp_execute_task(struct domain_device *dev, void *req, int req_size,
>  
>  static inline void *alloc_smp_req(int size)
>  {
> -	u8 *p = kzalloc(size, GFP_KERNEL);
> +	u8 *p;
> +
> +	size = ALIGN(size, ARCH_DMA_MINALIGN);
> +	p = kzalloc(size, GFP_KERNEL);

Nit: why not:

	p = kzalloc(ALIGN(size, ARCH_DMA_MINALIGN), GFP_KERNEL);

>  	if (p)
>  		p[0] = SMP_REQUEST;
>  	return p;

Otherwise looks OK to me.

John,

Unrelated to this patch, but I wonder if the GFP_KERNEL used here shouldn't be
GFP_NOIO... Is this ever called in the IO path or error recovery ?

-- 
Damien Le Moal
Western Digital Research


