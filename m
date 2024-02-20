Return-Path: <linux-kernel+bounces-73276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C9E85C05C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CCD01C21F02
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBCE762EB;
	Tue, 20 Feb 2024 15:52:42 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEA5762C5
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708444362; cv=none; b=jApxhnhlUEoAMcyeQJvena2cP0GUaVWKbrL0am9RQxCqI/+S3Sy86MW19I7B3ZkcgRUxnTtpjEQ99M58C/AddA12pV6OQ+ARI1OS/Y747oMSh0yY9eXW4PGMCCwoq0FFXcDzossHPhsyKa3ygoZNFaeIKkI95t2/jTsdupnwvQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708444362; c=relaxed/simple;
	bh=hU9zdqsUtvxFQ4fhOcU5tos+YZBJH9VYO1Up5vmlUFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dXLhZNxuV3+fX2i50gqTj/ZW9GZZqgNANej6NSoc+Ir5oqlc9f+SIBt2CTJemqy3NozGZv1awPKeBt0B3BdmeBXnSgv0Tmo1OcoksnbImlFeI+P/H1PlpZirSJbaeJMB6QFbDfd2Mjshll6KW9TBUO29cm/S7gvPaQEOeCkIoOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 35D0E61E5FE01;
	Tue, 20 Feb 2024 16:51:23 +0100 (CET)
Message-ID: <a9169894-6972-49c0-a1d4-d80863f5b511@molgen.mpg.de>
Date: Tue, 20 Feb 2024 16:51:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ipmi: kcs: Update OBF poll timeout to reduce latency
Content-Language: en-US
To: Andrew Geissler <geissonator@gmail.com>
Cc: minyard@acm.org, joel@jms.id.au, andrew@codeconstruct.com.au,
 openipmi-developer@lists.sourceforge.net,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
 Andrew Geissler <geissonator@yahoo.com>
References: <20240220123615.963916-1-geissonator@gmail.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240220123615.963916-1-geissonator@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Andrew,


Thank you for your patch. Some style suggestions.

Am 20.02.24 um 13:36 schrieb Andrew Geissler:
> From: Andrew Geissler <geissonator@yahoo.com>

(Oh no, Yahoo. (ignore))

You could be more specific in the git commit message by using *Double*:

 > ipmi: kcs: Double OBF poll timeout to reduce latency

 > ipmi: kcs: Double OBF poll timeout to 200 us to reduce latency

> Commit f90bc0f97f2b ("ipmi: kcs: Poll OBF briefly to reduce OBE
> latency") introduced an optimization to poll when the host has
> read the output data register (ODR). Testing has shown that the 100us
> timeout was not always enough. When we miss that 100us window, it
> results in 10x the time to get the next message from the BMC to the
> host. When you're sending 100's of messages between the BMC and Host,

I do not understand, how this poll timeout can result in such an 
increase, and why a quite big timeout hurts, but I do not know the 
implementation.

> this results in a server boot taking 50% longer for IBM P10 machines.
> 
> Started with 1000 and worked it down until the issue started to reoccur.
> 200 was the sweet spot in my testing. 150 showed the issue
> intermittently.

I’d add a blank line here.

> Signed-off-by: Andrew Geissler <geissonator@yahoo.com>
> ---
>   drivers/char/ipmi/kcs_bmc_aspeed.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
> index 72640da55380..af1eae6153f6 100644
> --- a/drivers/char/ipmi/kcs_bmc_aspeed.c
> +++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
> @@ -422,7 +422,7 @@ static void aspeed_kcs_irq_mask_update(struct kcs_bmc_device *kcs_bmc, u8 mask,
>   			 * missed the event.
>   			 */
>   			rc = read_poll_timeout_atomic(aspeed_kcs_inb, str,
> -						      !(str & KCS_BMC_STR_OBF), 1, 100, false,
> +						      !(str & KCS_BMC_STR_OBF), 1, 200, false,
>   						      &priv->kcs_bmc, priv->kcs_bmc.ioreg.str);
>   			/* Time for the slow path? */
>   			if (rc == -ETIMEDOUT)


Kind regards,

Paul

