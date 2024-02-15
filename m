Return-Path: <linux-kernel+bounces-67546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD79856D43
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0B601F2368E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42E9139560;
	Thu, 15 Feb 2024 19:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wJF/rbQj"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAEB12DD9A;
	Thu, 15 Feb 2024 19:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708023780; cv=none; b=FKnfE7t5S/e08gUa0zmZjH0tnCtUtFjqtUZJmbRqZMZiCMGTY8VarEfj1PisjR3otjPv6/gnY9F2xFMAE7DlOOLNTfHHJq4bOGVypQkyhsri34Xz0X9POwebIVowPr+p5uWAx+iSBJRm4jLVwCGXVyqoh685U+jvg0wOeFe969w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708023780; c=relaxed/simple;
	bh=HsBrw5k92azhVa2kk89DFI6B38rW/uSwNntF9cCgQJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=It0dDsO8K2/D89FUE+YrRV6xVTEsl4yFK6p1MAbbl6N8qKUg8doak8k8nHEHWtC1oz3VgyLiBNtxDNGtbxaVJfK1e7xCSCZ0URkZbW2woyGv2FWjrH/jNE4afmRraZUpJl3BCKhHbcYuwyRpF/OWsrcQIUDAjAdzoAJh2JzvEXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wJF/rbQj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=gdINLcaBB47zjBU/4s1ytJ3Urnla7jYI4l5DT0ooHEU=; b=wJF/rbQjW7bIgzw2xmupq4Djik
	Hxythy3wICwxBo/jIiqaL9vXGSNyajTSki6afi+xio+8sOE0gUR/wCz3I4w7Ig9uN13cH85ypDAAn
	DN0sh4IfiUwv/AjvwoBJfLe1f1HN+/pydOClSwFB9uNjbwtYrXCpOtbFzDPnRrybQKCnFfifE8iBT
	JAwNo886q/c3HXwypW+kjpuDx8lowAAUqftgf80th9cvXJGtBKeLVcLIIcPMcgrreDon7O6zRKb3T
	Xn4j1/N5M+AVUBSI6xtjLfAnzFCjI84tkr153GprarnvIA4PTGWpZdYyLtjhDT2rcaV00Kd2AUNVQ
	7N8l98CQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rah0W-0000000HRTc-0sMR;
	Thu, 15 Feb 2024 19:02:52 +0000
Message-ID: <8030a0b6-0816-4313-bf70-aa602fc1a871@infradead.org>
Date: Thu, 15 Feb 2024 11:02:51 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kasan: Add documentation for CONFIG_KASAN_EXTRA_INFO
Content-Language: en-US
To: Juntong Deng <juntong.deng@outlook.com>, ryabinin.a.a@gmail.com,
 glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
 vincenzo.frascino@arm.com, corbet@lwn.net
Cc: kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <AM6PR03MB58480786BBA03365CE454CDB994D2@AM6PR03MB5848.eurprd03.prod.outlook.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <AM6PR03MB58480786BBA03365CE454CDB994D2@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 2/15/24 10:43, Juntong Deng wrote:
> This patch adds CONFIG_KASAN_EXTRA_INFO introduction information to
> KASAN documentation.
> 
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
>  Documentation/dev-tools/kasan.rst | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index a5a6dbe9029f..3dc48b08cf71 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -277,6 +277,27 @@ traces point to places in code that interacted with the object but that are not
>  directly present in the bad access stack trace. Currently, this includes
>  call_rcu() and workqueue queuing.
>  
> +CONFIG_KASAN_EXTRA_INFO
> +~~~~~~~~~~~~~~~~~~~~~~~
> +

Fix punctuation (run-on sentence):

> +Enabling CONFIG_KASAN_EXTRA_INFO allows KASAN to record and report more
> +information, the extra information currently supported is the CPU number and

   information. The

> +timestamp at allocation and free. More information can help find the cause of
> +the bug and correlate the error with other system events, at the cost of using
> +extra memory to record more information (more cost details in the help text of
> +CONFIG_KASAN_EXTRA_INFO).
> +
> +Here is the report with CONFIG_KASAN_EXTRA_INFO enabled (only the
> +different parts are shown)::
> +
> +    ==================================================================
> +    ...
> +    Allocated by task 134 on cpu 5 at 229.133855s:
> +    ...
> +    Freed by task 136 on cpu 3 at 230.199335s:
> +    ...
> +    ==================================================================
> +
>  Implementation details
>  ----------------------
>  

thanks.
-- 
#Randy

