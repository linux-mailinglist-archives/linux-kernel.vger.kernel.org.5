Return-Path: <linux-kernel+bounces-93876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75459873631
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4063289318
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D12F80618;
	Wed,  6 Mar 2024 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="flKz97UR"
Received: from smtpdh17-1.aruba.it (smtpdh17-1.aruba.it [62.149.155.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E68A7FBC1
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 12:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709727721; cv=none; b=QYHAkJaoC6fgbqRuKEaFfn1Bnr4ln5aY+We+jC672MPLjLUojVILUNsS/2ixaI8OCiGjGUKGEqrKxwkF5qr/wOCd/wVEVIpd+mJKLG72326wdFmNxmams6Mah1Zgr4x657UNYAh+sKGu6d5hBvuseL9DdQNwP3AD6fm7AUAZO0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709727721; c=relaxed/simple;
	bh=wU3G8YFak0o+nuh4lyA5VMTG3gwzwPSpparlbmHgvS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aDtJ8HDsnsBjcO+GXKn0cwAsxk+l7WcpCUoy/u3Bb6N9O8kTShFnkJ1rQjoFfjt8Cq5Nb8T0nNvbYJJh6gCTJfiWmWVGTOtlemgxYjltwY7xaTvDHjYoNoxUMfDh1yPNHnSzDUHCIBfeRXp9qNy/rRvZ4OkI1v9ZR0hnevQ+T14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=flKz97UR; arc=none smtp.client-ip=62.149.155.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.59] ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id hqEQrVf32URZ5hqERrGgl2; Wed, 06 Mar 2024 13:18:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1709727527; bh=wU3G8YFak0o+nuh4lyA5VMTG3gwzwPSpparlbmHgvS8=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=flKz97URq48twY0yFh0zwWlL+ErKCOt2hGsBd/Bmm+y6iDNpMOG7FBaKkM01eXsGS
	 0GXH8TohjL6KjoV2RWhnA0aONAIica+GIkgnvWFr/xrsIaFSPJYhMlSxiPjI6Pr4k8
	 AJNenef8m1h0f8314SlgpoMI+vyAX3YaQSxMAefcobzDqMFJjYcJhzzrMQt9TGcUfh
	 aC5oQaXD138RgLEOxIsU5p3mZXZTki7Cec7A7a3Xq46plUhnhR3TEICYsMG8fnfFL+
	 d0CuZKIFi2dVS/xw7XFrv0LnZcRP8ab6VyM2xw1P9UVLFg4yBGZOLfHLJAFSE09I/v
	 tofxpWXUTPYuA==
Message-ID: <b10e330a-ca9e-47b9-a80f-3dc350e6c502@enneenne.com>
Date: Wed, 6 Mar 2024 13:18:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pps: use cflags-y instead of EXTRA_CFLAGS
Content-Language: en-US
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240306120515.15711-1-lukas.bulwahn@gmail.com>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <20240306120515.15711-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfNpTQvcxk3honCktkOckSd+dwohuJYM+49XLWmnri4QPHL0a471NeOZqM1PwjXcVHK8OUTVwjfqvdln8hJDHfJaPyOmACwVFiLQ9dKVBsKZsfTxZBL6h
 cjOfb5sLl/VJYRKphd5mjSsppQ3T60QzGxCdv6m9Xg0QIA/AmD7wH+1O7oboZGwZMDt2lgd+wJyWzKyPV1vkDxzBiQ0lY5YCpSt0FJj2Avbgw6FUwfJKMVXw
 w3oTF3Dg/rgio+X/nmHBkl0WgtGe6JdoU9hiroFHu2bbkaifvaEECblFCrDTldIqrW4oEhIW32lJta0mttzpsgfeOhtVEi9v9HTUaR3HOm8=

On 06/03/24 13:05, Lukas Bulwahn wrote:
> Commit f77bf01425b1 ("kbuild: introduce ccflags-y, asflags-y and
> ldflags-y") deprecates use of EXTRA_CFLAGS in the kernel build.
> 
> This has been cleaned up in the whole kernel tree long ago, but this one
> single place must have been missed.
> 
> Replace the EXTRA_CFLAGS use by the common pattern for such debug flags.
> No functional change.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

> ---
> Rodolfo, please ack.
> 
> Greg, please pick this minor cleanup patch.
> 
>   drivers/pps/generators/Makefile | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pps/generators/Makefile b/drivers/pps/generators/Makefile
> index 2d56dd0495d5..2589fd0f2481 100644
> --- a/drivers/pps/generators/Makefile
> +++ b/drivers/pps/generators/Makefile
> @@ -5,6 +5,4 @@
>   
>   obj-$(CONFIG_PPS_GENERATOR_PARPORT) += pps_gen_parport.o
>   
> -ifeq ($(CONFIG_PPS_DEBUG),y)
> -EXTRA_CFLAGS += -DDEBUG
> -endif
> +ccflags-$(CONFIG_PPS_DEBUG) := -DDEBUG

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


