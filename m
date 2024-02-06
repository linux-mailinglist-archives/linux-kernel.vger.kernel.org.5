Return-Path: <linux-kernel+bounces-55353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E4884BB9B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66EF8B24ACC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF03A947E;
	Tue,  6 Feb 2024 17:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="anFh+Oyn"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A52C13B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707239198; cv=none; b=Axo9DTfLzOGBfT7h7KGb79RIe5kgsPj3x0hz2hnTyvPQsZ/qTV8AhALJ439E1/e9oAY2d8FmZuYlP9paetaogkc4zrAbxxiyawoSy8hwXVP3MtVGzxFBOYo74Pyc2yo90IIwCuZRjVb1GEnPTyJNcRUKKhVJYhMbZ1NS4vC5f7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707239198; c=relaxed/simple;
	bh=zGTV2hlCdCKunygAgyuVhRFoPdv+pC4en+zILtMmYW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fVIiZsxR2c6IbwDjbdk2+s+lWKGpYe96uF47m8eXcJvqrtAxO6PFGeHWk9/WpLg57TQg7s3ldxzHGk1M9ZfMw4sqn9LRr1BNElMe0/eEyLH8ZAve14jTVmyQqGyoAh+iD5ULPrw4A/18jIxI/bJJ5CL83du+11R3W2ghqNY3fqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=anFh+Oyn; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTPS
	id XFdjrclnHpUFLXOu3r7AXT; Tue, 06 Feb 2024 17:06:36 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id XOu2rXdrnMlHEXOu3rZdZf; Tue, 06 Feb 2024 17:06:35 +0000
X-Authority-Analysis: v=2.4 cv=Yeoe5BRf c=1 sm=1 tr=0 ts=65c2671b
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8 a=DBfv99YmAAAA:8 a=cWRNjhkoAAAA:8
 a=cm27Pg_UAAAA:8 a=IUHhT28BEWNEk4qSCmMA:9 a=QEXdDO2ut3YA:10
 a=WzC6qhA0u3u7Ye7llzcV:22 a=AjGcO6oz07-iQ99wixmX:22 a=c73wXdw0ADZYY2z2LwuN:22
 a=sVa6W5Aao32NNC1mekxh:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Xom8zApxC86I/dIUvjWT77cxYWKLUOyYSTZXqNSiH60=; b=anFh+OynbpLIpeaK4DkLUiuKxJ
	YP0kUfSLPy0oZqhN8WGkhXzTW8gTKmyudSMVqvPb6hb8+ryTPcLq9GDTzBPQ5DZ01/nvt2aySxi0s
	FRkatydQWF9N2CqV/xky/GkmFDvEjMT821hPBQQCtNqaF6iKGq4EVUXiMnb9aeqbCrPRmnQHnes7a
	QlRIomTosqjQwLShSekZdWLQnvJkWvKtHffRg8V4AMuuh2SSfRSD066TtvkdmY8teGJopfegd3pWI
	nZ4szOJYIQ/+mUHUhY7YPRT7E8d0qw0iQKaYXrwV3W1AOtMnk9Y5hNjU8Kb9Y9vSnU2jxdXHi466d
	ggnsl+Zg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:34842 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rXOu2-003dF2-1M;
	Tue, 06 Feb 2024 11:06:34 -0600
Message-ID: <33b313d4-ee53-4cd5-842e-147d60f462d6@embeddedor.com>
Date: Tue, 6 Feb 2024 11:06:29 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen/gntalloc: Replace UAPI 1-element array
To: Kees Cook <keescook@chromium.org>, Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240206170320.work.437-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240206170320.work.437-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1rXOu2-003dF2-1M
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:34842
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIOO96uWA7dq+doZgFHIVK1380q0kX11cFvsMB86bmsKPpOnnIe38dTDnzkMpJmgaaDiIQIAvJN8ZmrPM206pXU0yAH0p3XcRVXq3H50jlXeBUK6xC5z
 VaGI6P7ORaDtNvTRk2qx5tw2EXEyRjIqOpmvV8jPN6UHNOInBvn7FdGO7VcF5DtID3mQGayLrhT2nC9kERiYGoYKqF8VGCf2k4XmIYdoqhJvGjrYR4gxeeHU



On 2/6/24 11:03, Kees Cook wrote:
> Without changing the structure size (since it is UAPI), add a proper
> flexible array member, and reference it in the kernel so that it will
> not be trip the array-bounds sanitizer[1].
> 
> Link: https://github.com/KSPP/linux/issues/113 [1]
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Cc: xen-devel@lists.xenproject.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>   drivers/xen/gntalloc.c      | 2 +-
>   include/uapi/xen/gntalloc.h | 5 ++++-
>   2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/xen/gntalloc.c b/drivers/xen/gntalloc.c
> index 26ffb8755ffb..f93f73ecefee 100644
> --- a/drivers/xen/gntalloc.c
> +++ b/drivers/xen/gntalloc.c
> @@ -317,7 +317,7 @@ static long gntalloc_ioctl_alloc(struct gntalloc_file_private_data *priv,
>   		rc = -EFAULT;
>   		goto out_free;
>   	}
> -	if (copy_to_user(arg->gref_ids, gref_ids,
> +	if (copy_to_user(arg->gref_ids_flex, gref_ids,
>   			sizeof(gref_ids[0]) * op.count)) {
>   		rc = -EFAULT;
>   		goto out_free;
> diff --git a/include/uapi/xen/gntalloc.h b/include/uapi/xen/gntalloc.h
> index 48d2790ef928..3109282672f3 100644
> --- a/include/uapi/xen/gntalloc.h
> +++ b/include/uapi/xen/gntalloc.h
> @@ -31,7 +31,10 @@ struct ioctl_gntalloc_alloc_gref {
>   	__u64 index;
>   	/* The grant references of the newly created grant, one per page */
>   	/* Variable size, depending on count */
> -	__u32 gref_ids[1];
> +	union {
> +		__u32 gref_ids[1];
> +		__DECLARE_FLEX_ARRAY(__u32, gref_ids_flex);
> +	};
>   };
>   
>   #define GNTALLOC_FLAG_WRITABLE 1

