Return-Path: <linux-kernel+bounces-66384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EE4855BF6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FA1B1F2C0F6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5318F11702;
	Thu, 15 Feb 2024 08:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="LyzZCx36";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZCW9e38H"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AEB33CF;
	Thu, 15 Feb 2024 08:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707984362; cv=none; b=qLn/Cu4vPm4qS5g9xxygzqJypzT5J/LqO+uMspRAGIG3HSkBhX7QkWrdH6l2LM78YMUkqtc1e459FIZOBDbUCE45kIVngPyy8a4T4hhoWqRSnOLRwbG15nQhBdWt+EBOVjgG9FVnVxWjaSTSv7IHiFO3eddqdfcs70/9c32DHIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707984362; c=relaxed/simple;
	bh=xIvB3bnCjrfDnU+qMJacA7Osthh4NMLZgOfe1hsBhxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfCJSngdjLErCLwMI9MPERw0uDnaG0/m3HPoN9H217PUqxrYWZEvpBVY8aIHvNXXVVmeqdOM+dKh8lJNLqL/SSv8AfPsHOyzC6oWN8JhH33d3mcD1FO8Xu1u4g3vLsVZt2D14RwzTZ9C/DGiJ5dEpxbId0pz+unDZ7zjHjeg2+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=LyzZCx36; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZCW9e38H; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8828711400B0;
	Thu, 15 Feb 2024 03:05:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 15 Feb 2024 03:05:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707984358; x=1708070758; bh=QJCVJr8PVd
	9r5fQnZJFD/Wp4xyPQGkYi6AhuDBJjlCE=; b=LyzZCx36G5H0CHSscypAaZ0lGk
	Ny8Lvs3cb8e75fjzYd5NcIl7jknxP9P1rZ9jdWZMkZ6HC6JLrbhEiXlA+kUjcpb2
	aIBAvvtanOprCCZmuyJbjsAWVyc9oYDE/rzSDMmYjzNqVM9YTX9/iSM5y8RR7Q5y
	zXuPifo+cJkuQRstRyAvyO8LM2prsBtvXb7L8d95PkjU28rPURSTfIhhQrnhsFJ0
	0LNhZYX/rM/1fXfLKTHTtTtEcjVz84ezX2eLCIpTBRSh2fv6/x9mznGKI9loRvs+
	/i5a11oRgV9BM3ulMh7TauqN3PBbR1XNQzwrSbkzdNyiQBxTDme/P/gPsibQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1707984358; x=1708070758; bh=QJCVJr8PVd9r5fQnZJFD/Wp4xyPQ
	GkYi6AhuDBJjlCE=; b=ZCW9e38HS9gA42CWuduHKq9nELlVi+JpVEEeC28v1OH1
	fDs2YrotxAJ4GsxjUByRM2QbHFimGrrWowjbsy+Lznqw8eshgyI6TmR7N4ixY2Af
	TtNA+31DQXI7ZKuTh1a1iE3mIGjrleVzl1VpH7euFbbK5NFLpM4Vz2wt9fKxPnKD
	idAqjqcE+WAvgzuD27Vubge9fl8WxNrhvQjxfi/cyWAftW9qQXNQF6OOB7tCdFGc
	bvBBYFRvC5d88VFsN2EJGSV1XliTJL+SusgS3KnfrEmsR4ojCbJ1QwpnukKTz2sl
	p1IIaW5PVrAWvBpi7iD+qGKx7VCcOUXgioMEvcv7nQ==
X-ME-Sender: <xms:5cXNZfljpS4U2HxG9qQT4661MxdnJojn7vfjL2UncpPECQ_ho9w7Kw>
    <xme:5cXNZS1jv9PoDIDElWHqHV7r-3ox3zRjw8VWJiNbcEI0nIxaOr9KjlTE_XNzsJz29
    K6X39RyXAqzWw>
X-ME-Received: <xmr:5cXNZVoAdIZv32qexd4x3jZYjEAEc36khscc4QgRZyWrCrxYjOwJ08zKeli06dNOjX6krXKD9m3nnUKUQyRywxqut_rnVSughw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelgdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:5sXNZXlukBtiddt3jo9i-pGCQ0B9uEepywzKXiJgJh6praZe7bHh4Q>
    <xmx:5sXNZd2Dj4GjyiQs7qVS47WB1SVXA5-9MataQUF7ewOh9zEvNtOxNA>
    <xmx:5sXNZWtPNtFmiye6HrkPABjKrcd0-x1L_N3cebC7oEmMSEw1EtXDuw>
    <xmx:5sXNZbOz1NgWgU1OgVuIVS7RukZulQ8Go6_tNs9gXqHZN-oZqhv3Pw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 03:05:57 -0500 (EST)
Date: Thu, 15 Feb 2024 09:05:56 +0100
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Christoph Winklhofer <cj.winklhofer@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the w1 tree
Message-ID: <2024021506-probiotic-wasp-9439@gregkh>
References: <20240215132952.6c83ab23@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215132952.6c83ab23@canb.auug.org.au>

On Thu, Feb 15, 2024 at 01:29:52PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the w1 tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> drivers/w1/masters/w1-uart.c:314:24: error: initialization of 'size_t (*)(struct serdev_device *, const u8 *, size_t)' {aka 'long unsigned int (*)(struct serdev_device *, const unsigned char *, long unsigned int)'} from incompatible pointer type 'ssize_t (*)(struct serdev_device *, const u8 *, size_t)' {aka 'long int (*)(struct serdev_device *, const unsigned char *, long unsigned int)'} [-Werror=incompatible-pointer-types]
>   314 |         .receive_buf = w1_uart_serdev_receive_buf,
>       |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/w1/masters/w1-uart.c:314:24: note: (near initialization for 'w1_uart_serdev_ops.receive_buf')
> 
> Caused by commit
> 
>   178cf9db9e6d ("w1: add UART w1 bus driver")
> 
> interacting with commit
> 
>   fed99212acae ("treewide, serdev: change receive_buf() return type to size_t")
> 
> from the tty tree.
> 
> I have applied the following merge resolution patch:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 15 Feb 2024 13:23:35 +1100
> Subject: [PATCH] fixup for "w1: add UART w1 bus driver"
> 
> interacting with "treewide, serdev: change receive_buf() return type to size_t"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/w1/masters/w1-uart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/w1/masters/w1-uart.c b/drivers/w1/masters/w1-uart.c
> index 6950d29d7dac..a31782e56ba7 100644
> --- a/drivers/w1/masters/w1-uart.c
> +++ b/drivers/w1/masters/w1-uart.c
> @@ -289,7 +289,7 @@ static int w1_uart_serdev_tx_rx(struct w1_uart_device *w1dev,
>  	return ret;
>  }
>  
> -static ssize_t w1_uart_serdev_receive_buf(struct serdev_device *serdev,
> +static size_t w1_uart_serdev_receive_buf(struct serdev_device *serdev,
>  					  const u8 *buf, size_t count)
>  {
>  	struct w1_uart_device *w1dev = serdev_device_get_drvdata(serdev);

Looks good to me.

Krzysztof, want to pull in the w1 changes to my tty tree and make this
change on top of it so that everything works properly going forward?

Or do you want to handle this when stuff is merged by Linus during -rc1?

thanks,

greg k-h

