Return-Path: <linux-kernel+bounces-95197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 257C1874A89
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ECB1B238B8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB03839F6;
	Thu,  7 Mar 2024 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="caMJd2fk"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A819982D9E;
	Thu,  7 Mar 2024 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803073; cv=none; b=CsHwn+F/7al1DvS6eKuOId2y9/HXcJI/Hf7EAjr/PcRUEdfBr6y0MsXhhxlm3IdSp7+c1uOVnlsKL0eu/67QEKDkmlwrxDWDKOXYoCKVrxD0jp/D8ESVfdx/gCYP2ds5cjnRspE+BHc2zgvJEdZs9sFlDrrWig37/vXsxnITueI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803073; c=relaxed/simple;
	bh=jG/0A5E7yZNIx8YChFSsFMpuzuYRmZ4qSrq/e/WzHzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uC6S2Ajm96ZsXA8tGKYulOxBwXKnRmpe1dv/nI3sOCU3jXltAaRfeWST0V97QnQ4E7U5X+dgN/tksUFs3cCuIAh20Q0qIfqk9Lnu6DLDxu6/QT0Adr2Mx4kCSsBZmtEaLijisMoJpjOQ+pEqtAtHgzBggBqphmx0ZlJXuF2/Yqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=caMJd2fk; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709803065; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MbeGp30QsMgZv+/prTJwcPU23L7dzRIwAJL5oWEug8w=;
	b=caMJd2fk6Y19MYsRJb8SAGCogt3g2T3cBt+lIvMGGKRpELLG7ExwunZ5R80NQWCDjcGbq7YZ3Pj9g9WCbwg8gfk5yTZZltj9E4dMAvpuwQiZnM9q0YSkYIiwkd+dluNvPvNMp4e5HdZu+x7yZ7xPW1eQvXLPsjbVTSDoVHsEKjs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W2-5s9E_1709803064;
Received: from 30.97.48.224(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W2-5s9E_1709803064)
          by smtp.aliyun-inc.com;
          Thu, 07 Mar 2024 17:17:45 +0800
Message-ID: <a7d470b9-091e-4642-badd-a2b19eb3d02d@linux.alibaba.com>
Date: Thu, 7 Mar 2024 17:17:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Fixes tag needs some work in the erofs-fixes tree
To: Stephen Rothwell <sfr@canb.auug.org.au>, Gao Xiang <xiang@kernel.org>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240307081628.6a9e9b65@canb.auug.org.au>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240307081628.6a9e9b65@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2024/3/7 05:16, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>    f531a3c17e7a ("erofs: apply proper VMA alignment for memory mapped files on THP")
> 
> Fixes tag
> 
>    Fixes: be62c5198861 ("erofs: enable large folios for fscache mode")
> 
> has these problem(s):
> 
>    - Subject does not match target commit subject
>      Just use
>          git log -1 --format='Fixes: %h ("%s")'
> 
> So:
> 
> Fixes: be62c5198861 ("erofs: support large folios for fscache mode")

Thanks for the reminder!
It seems that I quoted the wrong commit id and it should be

Fixes: e6687b89225e ("erofs: enable large folios for fscache mode")

I've fixed in the erofs-fixes tree.

Thanks,
Gao Xiang

