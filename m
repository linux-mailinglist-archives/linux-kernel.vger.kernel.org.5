Return-Path: <linux-kernel+bounces-89827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F12E86F62D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EFEA1C220E9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629656CDD1;
	Sun,  3 Mar 2024 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D8BD8Bjs"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680CF7493;
	Sun,  3 Mar 2024 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709484121; cv=none; b=dRU4RJrrGjSP8+/CXpVKdesR2CwoIURmg9ACAJleD71Np7su5nkCnYxAIEVZ1tkuNg0MuTWps1bw6fSZrw6U0aUMg7I/dB8Rr5DUxHpWDXeU7LEdhuCWX2ouVwKj7NLz1UYwMNm1aUO1TMBmYaoqHNKF38mO1mwqJaIbqpBSwxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709484121; c=relaxed/simple;
	bh=Gwzzy7hNAaV1D/F6nWxqZu6+TdQiyQjvihiT7l0ydOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YwK6Zkaztx52TeHjbLzIxHwCLYpRRNP4TrWOERfzxCU9Mxibc+nB0ZGBPDTz/CD0Ejl1k9zHxvUJaEoSCvp/OGA2f7ewowMUVY0S/vKZfY74A8B26QAGCP3FirzUNiA5G/2PL+QpXIrlg6HNJ5AyHnRPNnXYNnrNrX1xAG0dPGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D8BD8Bjs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=b4d/3tR4nX8imA7O6QUupWdB/X3IAtMGfLXRBaowLV0=; b=D8BD8BjsGOn7hEIlSgGYc8xXPq
	O3Oudq1XubTYyx97XtSsdXlSLQgSF5sM8Tkg9Wq7ZI1TdwxdIVVrfp/aB/34cWJ4jgvbf35we063g
	BkIbRdNklaMdHeiDTH4RsEUEoFlib97fIEGD/YyPpNPD1KQG3ojm0EmMrEPz02goIleClNBawuPT3
	l0Q8Sscio79vgjRCXk2yKhFJfF/XtDmjQwurROGV2IekoLpTkYy23kHG0qQDdn5mKzj7Tjbi+WswM
	yg6KVXYqdmqKpC2mOGJjC6h23vcvSlCaQ0JuFPMO1EtlJsrlHW1fKa+NnMqxwHskFosw8uYTFiTfj
	nG82Eo5Q==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rgouT-00000006J2t-0uGx;
	Sun, 03 Mar 2024 16:41:57 +0000
Message-ID: <120c265e-dde5-454e-8e0b-72a1361912b6@infradead.org>
Date: Sun, 3 Mar 2024 08:41:56 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Removed inputq,namedq field description to prevent kernel
 doc warnings.
Content-Language: en-US
To: R SUNDAR <prosunofficial@gmail.com>, jmaloy@redhat.com,
 ying.xue@windriver.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
References: <20240303143919.6903-1-prosunofficial@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240303143919.6903-1-prosunofficial@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/3/24 06:39, R SUNDAR wrote:
> /net/tipc/node.c:150: warning: Excess struct member 'inputq' description in 'tipc_node'
> /net/tipc/node.c:150: warning: Excess struct member 'namedq' description in 'tipc_node'
> 
> Signed-off-by: R SUNDAR <prosunofficial@gmail.com>

This is already fixed in linux-next and net-next, as was another one of your
patches.
I suggest that you focus more on the -next trees for such patch targets.

Thanks.

> ---
>  net/tipc/node.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/net/tipc/node.c b/net/tipc/node.c
> index 3105abe97bb9..c1e890a82434 100644
> --- a/net/tipc/node.c
> +++ b/net/tipc/node.c
> @@ -86,8 +86,6 @@ struct tipc_bclink_entry {
>   * @lock: rwlock governing access to structure
>   * @net: the applicable net namespace
>   * @hash: links to adjacent nodes in unsorted hash chain
> - * @inputq: pointer to input queue containing messages for msg event
> - * @namedq: pointer to name table input queue with name table messages
>   * @active_links: bearer ids of active links, used as index into links[] array
>   * @links: array containing references to all links to node
>   * @bc_entry: broadcast link entry

-- 
#Randy

