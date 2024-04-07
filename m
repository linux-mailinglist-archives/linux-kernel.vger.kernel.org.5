Return-Path: <linux-kernel+bounces-134580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C8789B335
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 19:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 714A9B2180C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 17:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC22E3B799;
	Sun,  7 Apr 2024 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SVm6pSkV"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32E239AFA
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712509571; cv=none; b=MaMCvjkvIqEPsMhbDaO7fL6UHPvYL9VAiQ32p74SKyI11jYb18n/OBETuFrvmfl4HOfHAOAlb5oUR/+q8l2lWL4WQH5DPuPZ9iUxrMLeediryHo9FaD6GeR9YyvyxGjCBGKH5X65ZKa6ysRzEKdiI/i60r9DWbarn86aPz7sCwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712509571; c=relaxed/simple;
	bh=GHuwQxDsODWyAsnhwuYEm/YFbIlCe0NcnF/r7zWb4Ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PZAR8LzT2Zrp/uKyNeiVbp3gZBFFSpTPSGsOvGRpERnThttFOLZp0nMdSc2vC1dDxtYpbtiCIUggf85eObdmL7kH3icUWEke5hFfKcqeGcw9yROw6sj71SnyRS09PiTFQq1jMtBYAczcYvxMElh+rw8ySriBvbIHbmPr425sopM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SVm6pSkV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=tkE7wjg7mEGHR9RcR4gH0ugAtFUzXk4D+Was2qIvbLE=; b=SVm6pSkVlTE5UJVoUMgD2nXMo1
	BqgIZu2vUFNEv/SR44z4E5R8PEZCWNSGKX5bXDeaGm4hv1wRgPTgWGVPyBd7joZcfuzNDDweW+R4C
	NlAnHmBI9sFYLc9K9Lim67mjHuBxbF9ZzBNg+Mvca8NM0EcddTnIdlbBKrne5UBOZcimVcAvCbgmh
	klV1kcEyg/4+Lh26NQhpyn4cMSELphoHm5iw6bZSifo4dXrnRmEfBufOV0tjpLWIan9tPOJRxyk2u
	/mroZOPpSzBe9mAk1umxEq7HhrdUuHeke6dgPUjKXaW15SljM/Jj+7r/VvkLQ28mS+qhFryP/mIv2
	cG/s/VRQ==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtVxw-0000000D6gH-0VGA;
	Sun, 07 Apr 2024 17:06:00 +0000
Message-ID: <70b22ecf-7d02-4b90-ada7-ccef659e115f@infradead.org>
Date: Sun, 7 Apr 2024 10:05:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 1/3] powerpc: boot: Fix a typo in
 partial_decompress() comment
To: Yang Li <yang.lee@linux.alibaba.com>, arnd@arndb.de, mpe@ellerman.id.au,
 npiggin@gmail.com, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
 naveen.n.rao@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20240407063952.36270-1-yang.lee@linux.alibaba.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240407063952.36270-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/6/24 11:39 PM, Yang Li wrote:
> This commit adds kernel-doc style comments with complete parameter
> descriptions for the function partial_decompress().
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

