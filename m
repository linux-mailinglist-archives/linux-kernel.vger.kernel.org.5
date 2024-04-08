Return-Path: <linux-kernel+bounces-135590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BF289C80E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60C11C21BAB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F3F140373;
	Mon,  8 Apr 2024 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="utxb9p50"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F5F13F45E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712589638; cv=none; b=dFBBAY6f7i8uGRQy3mgTslLhzbxq7187KVmwaGePO/+RtwwKKb9kRAZTCEGOUx0odfb20JYgbyN1gi8ZgJLRhUolr9txFOoKpDGvuXmwheENM4KUVi/Rm9f0RpEZxGP24T8JvJYu6L8M+wToFa1OOUrsxmogYBer0t77HqtWcHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712589638; c=relaxed/simple;
	bh=j4V3EMN07DeeQwbqi5NCXFxRcsRrdv87YZEpzqDRcA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pFHbfej9FQXeB3hXbeA9z5pyAw8IxtVM0QJu93cldoWH+62GzEYpAho9Xu8tpGvuUU+xTNeryZ8AhF1a3jS5jRHsRa5hXZa/g0d4zKVe2u/dVuiTtuCglMzXerQJ+lO4G3ndOkC5aU8eQGzYDEDWSY9vOaRiq9Ph8cSXDmCEd/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=utxb9p50; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=8edgMOXFgl2zH45wje+hWBsQnHUDbsEh0smyAXxWaBs=; b=utxb9p50qnnv2YLRt4F7EHh/75
	i0wDKd20u8FMRg1/ZL9YT39FkkmRPbggwBg4KZodzFD26daLeV1ZUH0QAN9oethDxmfOWMaSd+y+t
	Bpmr70ko1HKwIMknMwkPFOhA/LAuvYUZvuRnjIlfUJNbnu2ZBgQBLnJH3muDUKjYflaqRQmio/9mE
	DJjAUPbfmC8gxsgxrnhGjXxojOJIbLdeMv1CV8qbyf8vS3pUJG5Ldl5zQCnraLIIRqvR8OQxZod6g
	VB5va1t0bEq7FYTuKPxTel/xN1e9MGYZxdpBt0doHAvZR64ulDovKP7IH/8kl3wZdx4dG5ya/g8Jy
	uSLvLZmQ==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtqnP-0000000G0cL-2QJk;
	Mon, 08 Apr 2024 15:20:32 +0000
Message-ID: <16530926-d19a-4607-a69c-b12455b818a3@infradead.org>
Date: Mon, 8 Apr 2024 08:20:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 1/3 v2] powerpc: boot: Fix kernel-doc param for
 partial_decompress
To: Yang Li <yang.lee@linux.alibaba.com>, arnd@arndb.de, mpe@ellerman.id.au,
 npiggin@gmail.com, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
 naveen.n.rao@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20240408083916.123369-1-yang.lee@linux.alibaba.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240408083916.123369-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/8/24 1:39 AM, Yang Li wrote:
> Fix the kernel-doc annotation for the 'skip' parameter in the
> partial_decompress() function by adding a missing underscore and colon.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  arch/powerpc/boot/decompress.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/boot/decompress.c b/arch/powerpc/boot/decompress.c
> index 977eb15a6d17..6835cb53f034 100644
> --- a/arch/powerpc/boot/decompress.c
> +++ b/arch/powerpc/boot/decompress.c
> @@ -101,7 +101,7 @@ static void print_err(char *s)
>   * @input_size:  length of the input buffer
>   * @outbuf:      output buffer
>   * @output_size: length of the output buffer
> - * @skip         number of output bytes to ignore
> + * @_skip:       number of output bytes to ignore
>   *
>   * This function takes compressed data from inbuf, decompresses and write it to
>   * outbuf. Once output_size bytes are written to the output buffer, or the

-- 
#Randy

