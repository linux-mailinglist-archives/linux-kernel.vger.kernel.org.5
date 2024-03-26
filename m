Return-Path: <linux-kernel+bounces-119570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4095588CA8C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ACF1B256F8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B051C6BB;
	Tue, 26 Mar 2024 17:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NglBZgkx"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDEF1C2AF;
	Tue, 26 Mar 2024 17:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473381; cv=none; b=nfczhX4M+n6wRvJpuu3FsEu92MDANMB5uQsh3y1MIkJO6Yqu069XXxxYL5UwxQ7Gc0bCuyZtIhzZZG0pA9OuRR593ewagc6dFAk5alAoS3NmR5e2FA/xWr/7yZBO9G+4GEokOo6ZDoqpVzb124kCNftgSW+yT5b6qQ3n/xGwUFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473381; c=relaxed/simple;
	bh=o2EHSZ1pkNNwsVraQPR7FRdXvD9eeSKp4Seu6Q6Uanc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MxjjHQzvg69XrjYuGFDrCyiioww5/rVXLpDrKp0X304xU7pSAcI4mfBq+mw3J/VShs1JMB2C4mJUUFkFDPhE3gwtQWwOmLn3F/w8cLMqmXsZ37v0gKJDKbW2CBKcxBqFcrHdYO8JUR6n+22IBFklKXoxR5zU4zv5PHbDkKJubbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NglBZgkx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=4Sv85FGjimXN6NzHHLB+VPfFSPQPE+zInd7evQBHyig=; b=NglBZgkxNAVisLL0m2NA8J0CyW
	Hd0aBI3/ilxcg3ICww4bOxZC5uuH88f3nS/b0aSFwqlASNzoRSUMQ0DU2HTVR65e8iGlX5o/gzDV6
	B3Tn327hF4KNtcKfUhrKrVz2gwM7N4+qeLJqv61U8gHK6QlNMkOKwuhJyYcQsQnKS6CokfPELHfbz
	nc/FajqXsed7f8hYQP8vLy0k8mPC+rswoRFluAtgu0fWN5d/jikE6LVsAW7HBEu9YWGa4B9nWWsel
	baUTrg6PrexhN7+n2z8QbB1CWf3hL3bl67R4AYBctUc8vQfiUCZv4pJeFreOixqXewoZt89DtfcF9
	qgqL+QIw==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpAPJ-00000005gbJ-21MC;
	Tue, 26 Mar 2024 17:16:17 +0000
Message-ID: <40fcf36e-3a60-474e-a7ef-1de874743828@infradead.org>
Date: Tue, 26 Mar 2024 10:16:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Documentation: fs/proc: fix allocinfo title
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: sfr@canb.auug.org.au, kent.overstreet@linux.dev,
 linux-doc@vger.kernel.org, linux-next@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240326073813.727090-1-surenb@google.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240326073813.727090-1-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/26/24 00:38, Suren Baghdasaryan wrote:
> Fix "Title underline too short." warning in the documentation.
> 
> Fixes: d08b311b6d49 ("lib: add allocation tagging support for memory allocation profiling")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/filesystems/proc.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 5d2fc58b5b1f..245269dd6e02 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -955,7 +955,7 @@ reclaimed to achieve this.
>  
>  
>  allocinfo
> -~~~~~~~
> +~~~~~~~~~
>  
>  Provides information about memory allocations at all locations in the code
>  base. Each allocation in the code is identified by its source file, line

-- 
#Randy

