Return-Path: <linux-kernel+bounces-90919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4828706C7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC45F28D7B5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B294CB58;
	Mon,  4 Mar 2024 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="e/aP+Tv1"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCBF482DF
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569013; cv=none; b=Hv8qPs0dgui7OmYBkkG7gzlcTUszIlyf1cyn2QMRpr6OkEQgXIBOpn0PmJeWXoHkNT7x9MkswkTzcv3CZtcn4mW9/ZV63y3s9P91HSsiqvIdK88H9M92svdvHApfwaO7Rz7kaUTuVBl+I/1CzkmIZkiTsHJ0DVi3jW58bYc0B4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569013; c=relaxed/simple;
	bh=B0WTZO0wX7ifnrfjJRPFUY0SwyrbQWNW/0wtLsL3FLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rRz3RyEcRg8wO1tSTlD7ujOm4smx7RboXG630QyHSs/4gIEZXlsPd9CxLVnRtjj3Dg0C5FuSvj9df0pxNkX0ArSmQ5/hDfsHvMSiVRb60mscXnffiJMa6cmxLUiMvcu3QNfkWu2UZoIbnKgqopIjyxcNY2d3ndfVsrCEFOAr4RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=e/aP+Tv1; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id h23yrYN8xHXmAhAzdr5anj; Mon, 04 Mar 2024 16:16:45 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id hAzcruPUc2Ka4hAzcrR35D; Mon, 04 Mar 2024 16:16:44 +0000
X-Authority-Analysis: v=2.4 cv=JvP3rt4C c=1 sm=1 tr=0 ts=65e5f3ec
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=VhncohosazJxI00KdYJ/5A==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10 a=cm27Pg_UAAAA:8
 a=IpJZQVW2AAAA:8 a=VwQbUJbxAAAA:8 a=OotqXb1hOlGMc3tnO1gA:9 a=QEXdDO2ut3YA:10
 a=xmb-EsYY8bH0VWELuYED:22 a=IawgGOuG5U0WyFbmm1f5:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oElvryJN6dwtKfgYQ9eTH9ycs8jYw64ERiMsk+Y+q8U=; b=e/aP+Tv10C/1WvHAXfLCtoHNvR
	b4oJGkH1OMplKsdciempOdCOboh1UuOSNmKiy8+Q9HIoj7a+OiJhqrsyFIJ/QI2Q6XaTFbEghAAqW
	pN3ZR6H2mFwHwjVi57Sl0nUDqd+3CbAQ1OBeg14C2/RgHmOpyQpmn7kvSaiPlCvI2uc9iQVWqvEB3
	cjEzilz+g6RzM2eunJO1wSnC3tNiXnUgmn+ehy+X24vGZvGFNbJu4mai4brEV4bRguWi29JTsvhfF
	ZSWzVtQF4BbX2Vn1OYUFd5RmE3h4v5gw1UgxCBbUXxOz2zBmMP1GwxGQxG8Tg+fDYEHrJOxxFy5qJ
	aUNjJXIA==;
Received: from [201.172.172.225] (port=49252 helo=[192.168.15.14])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rhAzb-003iEz-1a;
	Mon, 04 Mar 2024 10:16:43 -0600
Message-ID: <60f43759-ea04-41af-9667-006018e5c750@embeddedor.com>
Date: Mon, 4 Mar 2024 10:16:42 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] spi: axi-spi-engine: use struct_size() macro
Content-Language: en-US
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <20240304-mainline-axi-spi-engine-small-cleanups-v2-0-5b14ed729a31@baylibre.com>
 <20240304-mainline-axi-spi-engine-small-cleanups-v2-3-5b14ed729a31@baylibre.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240304-mainline-axi-spi-engine-small-cleanups-v2-3-5b14ed729a31@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.172.225
X-Source-L: No
X-Exim-ID: 1rhAzb-003iEz-1a
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.14]) [201.172.172.225]:49252
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 21
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfN1/+YrNdWNIsz7RrxclpNrcts0iNBRgEz5cOK+oOmK5Nu5LT2Fo4ZBVj1Y1t9HRGvPV6VgsarivasCNMHC+asogzlsYggAMwWjqr7KabbE0ZhwVCWzP
 fkbpTlxADjEWzyyKGim+dUwKeDK+rK+B+SNeQo8UmjTlNaEkerRMHUnpjxp7dgpVxlZ2xcd7pZuxNuvtBkXEjEJRwD7ooicaW0deaUYNWEHnzfNXjyJHDv6d



On 04/03/24 10:04, David Lechner wrote:
> This makes use of the struct_size() macro to calculate the size of the
> struct axi_spi_engine when allocating it.
> 
> Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   drivers/spi/spi-axi-spi-engine.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
> index a8f626165f44..7cc219d78551 100644
> --- a/drivers/spi/spi-axi-spi-engine.c
> +++ b/drivers/spi/spi-axi-spi-engine.c
> @@ -12,6 +12,7 @@
>   #include <linux/io.h>
>   #include <linux/of.h>
>   #include <linux/module.h>
> +#include <linux/overflow.h>
>   #include <linux/platform_device.h>
>   #include <linux/spi/spi.h>
>   
> @@ -502,15 +503,13 @@ static irqreturn_t spi_engine_irq(int irq, void *devid)
>   static int spi_engine_optimize_message(struct spi_message *msg)
>   {
>   	struct spi_engine_program p_dry, *p;
> -	size_t size;
>   
>   	spi_engine_precompile_message(msg);
>   
>   	p_dry.length = 0;
>   	spi_engine_compile_message(msg, true, &p_dry);
>   
> -	size = sizeof(*p->instructions) * (p_dry.length + 1);
> -	p = kzalloc(sizeof(*p) + size, GFP_KERNEL);
> +	p = kzalloc(struct_size(p, instructions, p_dry.length + 1), GFP_KERNEL);
>   	if (!p)
>   		return -ENOMEM;
>   
> 

