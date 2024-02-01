Return-Path: <linux-kernel+bounces-48731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C1A846061
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A06D91F22C27
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549F962158;
	Thu,  1 Feb 2024 18:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WMbWZ0f5"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E34D5F46B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 18:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706813555; cv=none; b=ZdF5HD493d1mzfWXcJ36cysVo5dYcgKEQVqY8/4x0PQV6rXG2zpmGk0kwLRO5K5AIJRS4Q0PxhOGPuTHhgKQwcdQk6/yAfy8vCj1Jk+PFJUw8Wm/go/qhWOEI85v4QwyjW2xN+EbnHrx5rGdvRIc4I/MPAWXj09X+kylB5bJX4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706813555; c=relaxed/simple;
	bh=BzUIxA+7NJz5Q/lO17UIfooNXHzOooJUwuCdnCRGEZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iqh/IN4cxQQ44BX9LMRJhSc50wyhYwDFbhKaoChDjvifB5C9au+UB1aZqHEFE19Ib1z8mlGgeiznOgGxMCL76iNOtVJiC8f0UiUoJ0iRwSlkwz1TxGh8PRYqepyUMYQabfdBA20oJ51OF6plraDosfBPF180YJt9QA/HY7KZxYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WMbWZ0f5; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42bf8f26673so3665561cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 10:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706813553; x=1707418353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7eTCfSpE8BSX3w2muEo/jhEsigVfUc1eYeRG/TfFs0A=;
        b=WMbWZ0f58Wi06jru1s78cBEgwxv66cu7ylYNnw95B963/qIOrspvYMuA0yxwcawmcW
         vaFpBSLsJi975u2l7ql+GEPT5YHVsKf4V9qO36Qt15gJXZDV90wOk5WIBpNXXBSQfibc
         boBcKgOB2a8mIdQdDk+sg/zaUZCs7uN8dWE4c+m9WMsSKvHl5PTiKDyuka6W2UBVjhFB
         yosbtypcoea8hB/tLiZWsBHBMGX4/XDHH3SEG+GXD3jFPIxuLl2pSk4gvclePeVncULX
         lc+ugSRlnzIWnTb9ulvzUauWxQ/orsEoW+lnVg0/H/YvXTrOA4ZVNuirMEuBxz4iLTDD
         nkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706813553; x=1707418353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7eTCfSpE8BSX3w2muEo/jhEsigVfUc1eYeRG/TfFs0A=;
        b=HcTXfW3pFQDg2Xj86ckzHFCp59gOF2uVhTGrxX9cWlD8nUE6sgD+XdJePvRwPcFQgv
         xjlP63xmTFJsTIr9ns80MWIdk2BILI2cj/wyRh423XXrKu3Rcqoz74cqifrOKC1vAeZW
         dmEE2MheiB0+4G8CgdMiQ+BSfmK7dWA6RsqGJJWl8SrNl62nwoELOJtCcu5KGW1+0Sra
         LX0nUfh8IuZG0wFmgCzE8tsgRnkZP2vplp8404771jLcUxP6npgXd68uoZTibvBC/Ief
         ITMpUP4KXT6oPdq3DafujhDAvw6FDrDwFyZ57RxTDTfx71j28JJxZ9sQCcFyfbKtsAF5
         tskw==
X-Gm-Message-State: AOJu0Ywhk9paKuNIjBVJ8DJhGr02YXMgW+AwOvADgz8gD5/QvopALAsz
	XQfbhNb5Z5XbbbwaMVQO0WwAssACPXa4X1Ws1qXoTZJbXi+3kgjiureUHLvKziY=
X-Google-Smtp-Source: AGHT+IFgJjDZxGoU+AfH6P+MRx9vRucn+J7TQs9/JS1FLA6fwYCChoHxRRKWYO6S0i3pCkO2ELKixA==
X-Received: by 2002:a05:622a:1b16:b0:42a:b346:4e10 with SMTP id bb22-20020a05622a1b1600b0042ab3464e10mr6579555qtb.39.1706813552851;
        Thu, 01 Feb 2024 10:52:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWvSVnDQ95l7NoA6swosk450Ra3893m7dUOxMRLKXwIczYcRr98wDcEaSiaXjPZGbqgqjb9aOVo8tKTXjI6QLEbWkFTCNQzlFGOelvNhYrOPQt1rMPtbQj2oAlPY2ChcstNH2lvjXfoR7NnIx236XeajzyDy5QwmCHJ6XIM+6+Y2EMxnjWjAyzLu98dsRXPqjdZh9k18rSZEOrWbGf1NZv/6yGuCdla1KhCfNuMYyoSM7O09WPAb6c/G6w4U7gg8cYF5BX80/cL0ReHSabR2tUund0W2x280+7ECvcV7bj4DSFENmWtAStsICp0G77sdMQqXGK283bQtfHQc5w+pnNiVFXcaTBzdy1ABf8s1PrkKSECFbXkXsO+o7MEScGfGLvsZDq8nkTcyiMLpm+VTb4/XmTfHJHldNvoYDI+Ly2OaMa/pAKVMRit1oM0dw9rDZQDp+Zlu0WhyTxdnFV/d40VsjpgvMYZhY8ws3MpssDL2SbgqxmokUlNVB4ds5lQUYAE+F02PQ==
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id bs26-20020ac86f1a000000b0042a992d8289sm43838qtb.19.2024.02.01.10.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 10:52:32 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rVcAp-00AnuA-Ka;
	Thu, 01 Feb 2024 14:52:31 -0400
Date: Thu, 1 Feb 2024 14:52:31 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: iommu@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com, jroedel@suse.de,
	tpearson@raptorengineering.com, aik@amd.com, bgray@linux.ibm.com,
	gregkh@linuxfoundation.org, gbatra@linux.vnet.ibm.com,
	vaibhav@linux.ibm.com
Subject: Re: [PATCH v2] powerpc: iommu: Bring back table group
 release_ownership() call
Message-ID: <20240201185231.GP50608@ziepe.ca>
References: <170628173462.3742.18330000394415935845.stgit@ltcd48-lp2.aus.stglab.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170628173462.3742.18330000394415935845.stgit@ltcd48-lp2.aus.stglab.ibm.com>

On Fri, Jan 26, 2024 at 09:09:18AM -0600, Shivaprasad G Bhat wrote:
> The commit 2ad56efa80db ("powerpc/iommu: Setup a default domain and
> remove set_platform_dma_ops") refactored the code removing the
> set_platform_dma_ops(). It missed out the table group
> release_ownership() call which would have got called otherwise
> during the guest shutdown via vfio_group_detach_container(). On
> PPC64, this particular call actually sets up the 32-bit TCE table,
> and enables the 64-bit DMA bypass etc. Now after guest shutdown,
> the subsequent host driver (e.g megaraid-sas) probe post unbind
> from vfio-pci fails like,
> 
> megaraid_sas 0031:01:00.0: Warning: IOMMU dma not supported: mask 0x7fffffffffffffff, table unavailable
> megaraid_sas 0031:01:00.0: Warning: IOMMU dma not supported: mask 0xffffffff, table unavailable
> megaraid_sas 0031:01:00.0: Failed to set DMA mask
> megaraid_sas 0031:01:00.0: Failed from megasas_init_fw 6539
> 
> The patch brings back the call to table_group release_ownership()
> call when switching back to PLATFORM domain from BLOCKED, while
> also separates the domain_ops for both.
> 
> Fixes: 2ad56efa80db ("powerpc/iommu: Setup a default domain and remove set_platform_dma_ops")
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> ---
> Changelog:
> v1: https://lore.kernel.org/linux-iommu/170618451433.3805.9015493852395837391.stgit@ltcd48-lp2.aus.stglab.ibm.com/
>  - Split the common attach_dev call to platform and blocked attach_dev
>    calls as suggested.
> 
>  arch/powerpc/kernel/iommu.c |   37 ++++++++++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 9 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> @@ -1312,13 +1312,32 @@ static struct iommu_domain spapr_tce_platform_domain = {
>  	.ops = &spapr_tce_platform_domain_ops,
>  };
> 
> -static struct iommu_domain spapr_tce_blocked_domain = {
> -	.type = IOMMU_DOMAIN_BLOCKED,
> +static int
> +spapr_tce_blocked_iommu_attach_dev(struct iommu_domain *platform_domain,

It was my typo but this should be "struct iommu_domain *blocked_domain"

Jason

