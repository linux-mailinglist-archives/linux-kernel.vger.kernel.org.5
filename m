Return-Path: <linux-kernel+bounces-81905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F99867BE8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8D3282AFD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032BC12FB32;
	Mon, 26 Feb 2024 16:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lnIFdyt2"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979EB12DD9B
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964790; cv=none; b=U8FRYhZQ4btULJSdXdmrFNmRBLwonjX6Wpw+ywC2tZdgjJsEvPc062QXLijXvl85/M47Vu+SWvncOAHi8SpCEjvTDX8sdCxrV5+PO+dMvinBSqvlNdh43NuUMFjl6h6ZmGbGxIAs+en2I/bBPR79mDPRywXYEUtJi5ojvf0VXGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964790; c=relaxed/simple;
	bh=UyDTA1WYBajIVPyd/VJZSJsqfWS9ZXKdKDE4cgIUh50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZO61M3dPfg5QBcMOUc6trjU4Zpy0ehXeKqJziIY6ozrg7W905YO52f5kiJprRSAGLcf6icPZScj4nS/B/w59MmUXd4ElSmzYmc8FQjs+T6mR43eeSBDi4wtFg2VYMTbn4sO9L03WjHwn/LcRNLictnkJ4SInLoneUFqnCX+WlYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lnIFdyt2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=6jLZPgKH+kwSRAE27ee7zJCavupjuLo1cENYVhBnN4E=; b=lnIFdyt28YngGM/zpfihB0SlGG
	ln2c7aPeBAWS6O8BGlsiiwGqtcZGCTKzRz+ohEExhS0gdsp96spZxb1WHXkK59NW7XpBHuC/ynFKa
	CirurvQAYBMewmcBUWqRU4GbMFTMNCIiRfI0sTirfb3ANbQKBpZ6bjf2MmDrA5FkIgfe8b4PhXzsl
	Qo00mJVfPY0B9bUduiclnDOROQNN1+e9C6DiWhrM+O0AikC3bTo3IZHRx9iI591mu72TqGHXBtCqK
	X6sn7ffPUGJTOWCRSyLJHqov2odYpForPf5eWrQt4kaAKMCP3Gi2b87/snUB/ltMqxDAsseACB8oq
	PNdcgyNA==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1redo5-00000001epD-1ov9;
	Mon, 26 Feb 2024 16:26:21 +0000
Message-ID: <af6c2001-1e5b-4674-951a-aa72a45c1719@infradead.org>
Date: Mon, 26 Feb 2024 08:26:20 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mm/pat: fix kernel-doc warning
Content-Language: en-US
To: Kunwu Chan <chentao@kylinos.cn>, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, x86@kernel.org, hpa@zytor.com
Cc: linux-kernel@vger.kernel.org
References: <20240226090411.1925770-1-chentao@kylinos.cn>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240226090411.1925770-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/26/24 01:04, Kunwu Chan wrote:
> Fix kernel-doc warning in memtype.c:
> arch/x86/mm/pat/memtype.c:710: warning: Function parameter or struct member 'pfn' not described in 'pat_pfn_immune_to_uc_mtrr'
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.


> ---
>  arch/x86/mm/pat/memtype.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
> index 0904d7e8e126..77c86a575268 100644
> --- a/arch/x86/mm/pat/memtype.c
> +++ b/arch/x86/mm/pat/memtype.c
> @@ -700,6 +700,7 @@ static enum page_cache_mode lookup_memtype(u64 paddr)
>  /**
>   * pat_pfn_immune_to_uc_mtrr - Check whether the PAT memory type
>   * of @pfn cannot be overridden by UC MTRR memory type.
> + * @pfn:  the page frame number to check
>   *
>   * Only to be called when PAT is enabled.
>   *

-- 
#Randy

