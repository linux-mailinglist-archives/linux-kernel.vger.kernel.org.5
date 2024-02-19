Return-Path: <linux-kernel+bounces-71630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5041F85A809
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8CD284D4D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C7E3B18D;
	Mon, 19 Feb 2024 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3c6aqIUW"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5AD3A1DE;
	Mon, 19 Feb 2024 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358460; cv=none; b=rT792Vv6ypuskSeaejTFQId81qkUXV9lRUsLQekfjGFI0bXiKB3GZDvKdljLci3huNPJGcqPNss0u0ug4MKXcxDgjDx48ECLRQJlM6JfBPwpj2Qb8OOmrfHaMYL5Ld6muxaxK2uLPPiBgWKOYtxaZAH1jLgvgKCaXAjHYddTlFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358460; c=relaxed/simple;
	bh=mkxQyW1MDhlEE7Juli0Fv11LooCAXtYrnR6kF74B17k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f1UCtrwKufvbNpW/jiO7rrqwigauNlJyTyxqCOcBx5KbAOaOkxYtL9zv9//uXU9hCIAFlxpow0xOpdCfUPIyPsbbaz2rMMUOhY19HMdYgeeXa0sACErUYCesOUIp2fP6sxPd2bSV8dZZXD9l9qhwUHL5LP3/HwdQ7PYzzDqJwq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3c6aqIUW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=b+yTbC3LvSYQUMnGVtqug/Ddhp61GwUTdiFR0Zm9oNM=; b=3c6aqIUWJmSlz+en6n1+VYGdiY
	V45YvYWl/IpeQDmBAtNCqy5dfEoIkK4HfJGmDzIp2/rKi0u9WdhsoxolrNDMmYU57jDx6Xr75zIwQ
	CedDxMfjIZ3siY1v/IJigX5bF/qrzF3ldgz1I7FAVnbZFFJDOTwb6mOqh9wDs+zitVjdVA+3Vts2H
	eUYWX7c4MeLfX73dO017AYxwAT9xVkSpQ5p4/I1idOgQwWW/fhWnONm4Etx+40WW/qcU724twlgyA
	MJPSB+Y4oBpeCW/4OZzdqaQZLI6OvZDibp4UU1vN48JUcwFr2jOM6kiQP3Ls3eXhRcIWDbQ9ir31T
	DOCgi5lg==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rc64a-0000000BFEn-4Bkj;
	Mon, 19 Feb 2024 16:00:53 +0000
Message-ID: <8cae5358-d1f3-4e86-950f-bb72a940ed3f@infradead.org>
Date: Mon, 19 Feb 2024 08:00:52 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] workqueue: Control the frequency of intensive warning
 through cmdline
Content-Language: en-US
To: Xuewen Yan <xuewen.yan@unisoc.com>, tj@kernel.org,
 jiangshanlai@gmail.com, corbet@lwn.net
Cc: paulmck@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
 xuewen.yan94@gmail.com
References: <20240219074634.2039-1-xuewen.yan@unisoc.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240219074634.2039-1-xuewen.yan@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/18/24 23:46, Xuewen Yan wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 31b3a25680d0..599fc59fcf70 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -7225,6 +7225,15 @@
>  			threshold repeatedly. They are likely good
>  			candidates for using WQ_UNBOUND workqueues instead.
>  
> +	workqueue.cpu_intensive_warning_per_count=

	workqueue.cpu_intensive_warning_per_count=<uint>
or
	                                          <integer>

> +			If CONFIG_WQ_CPU_INTENSIVE_REPORT is set, the kernel
> +			will report the work functions which violate the
> +			intensive_threshold_us repeatedly. In order to prevent
> +			the kernel log from being printed too frequently.

			                                      frequently,
			control

> +			Control the frequency.
> +
> +			Default, it will print one warning per 4 times.

			By default,

> +

-- 
#Randy

