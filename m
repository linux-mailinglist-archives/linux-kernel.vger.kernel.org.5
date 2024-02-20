Return-Path: <linux-kernel+bounces-73281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C807985C072
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34377B227AA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB06762FB;
	Tue, 20 Feb 2024 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="syRCmvD4"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA2E2C6AA;
	Tue, 20 Feb 2024 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708444686; cv=none; b=LfzGGCSuHOpfKGOTfq5sTJzeWU64Kj7/O3wqoLCOJGf7HX36ke3GpiIoRowi+tdE3r1FeEYfmSx1cRYSJonjobk/4dgot+aTc51lNzgfLbDW4hZZaqt8awMDB6z+DuLQ4CNkkwM2KHjYndbbsjAnHWJRLoSKvlMH37oIx2z5Xmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708444686; c=relaxed/simple;
	bh=yq4KqATKZFE+VTP/iWx4g38Aw5kVGcwploKvDpU/75s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MIFVm5capSoNxYlV+SE4kmGp6Cvt7PhCYi5bj8Qxd98UBkuyKMLZwMZX+MsnwiewkEv9a/O8JaWxYtthId0oeVHk+41FqGtpQhG1Yo9dpJZO7MkBDH5elcOWk3ZN+j7qJTEaXLYLebt5S01AHBzxIKcKC3H8Z8pw4yulT19DOrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=syRCmvD4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=mI1b9Q0kx3oUZdIsTb9IBVZQkaj5tsf2alf0sxnBr9M=; b=syRCmvD47wyu0rUyixcp9yoKyA
	qdONj9K4Rzz2hDuaXqqZn8NT7DBUDIWu/PBf18fWNF901s0X7Yrzqh2gARcmBr+02kDjG83ZsgagS
	Hlh2q808aSzUXDxop873uxYXsNyNVPgjtLC3aweTi3Bo1nozvcTT4gNF2m204sTeV9riKx8cd1Qc1
	YdtSar9x0RLFPvsz7T1zxCSsLj2Xj+OACQ20HcePr0nACNFNTSfGaViYueJb3Ff93bNFuGrorvopX
	ZnoTfe8mgpaaUMic6hYw8YO06sTnZgxYWp6kLhQjm2XqCLN27669YsnI8hpWF6IR9frA0GRov2GYu
	jTwJBBHA==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcSVN-0000000FKkA-0Y5T;
	Tue, 20 Feb 2024 15:58:01 +0000
Message-ID: <325b813a-9afe-4822-bd0a-b661ed863b20@infradead.org>
Date: Tue, 20 Feb 2024 07:57:59 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tipc: fixup kerneldoc comment for struct tipc_node
Content-Language: en-US
To: Peter Griffin <peter.griffin@linaro.org>, jmaloy@redhat.com,
 ying.xue@windriver.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, kernel-team@android.com
References: <20240220122436.485112-1-peter.griffin@linaro.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240220122436.485112-1-peter.griffin@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/20/24 04:24, Peter Griffin wrote:
> Fixes the following warnings
> 
> linux/net/tipc/node.c:150: warning: Excess struct member 'inputq' description in 'tipc_node'
> linux/net/tipc/node.c:150: warning: Excess struct member 'namedq' description in 'tipc_node'
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

i.e., same as
https://lore.kernel.org/lkml/20240112050010.25626-1-rdunlap@infradead.org/

from Jan. 11, 2024....

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

