Return-Path: <linux-kernel+bounces-142075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577C18A2720
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AA3E1C2084B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F8546449;
	Fri, 12 Apr 2024 06:51:49 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC1022069
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 06:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712904708; cv=none; b=dbsTtC5rQr+bL34BvFZIG1HzvtW6VasFrGIUrWioqOTt+/gpt2rtB2stPzU5i0HEBQ/U0dNaiC8SPCHYPmhkUVujqXq8WS2HSBQ1Fjup367UTf67TOwE6xSlPvsfwrtcMO7FvyE93yhTn0NX0eX3+pmdbrqNbuBuh71lZigHwAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712904708; c=relaxed/simple;
	bh=87gO3AzfeKrq0lhrVAHx88285IhQnw9jz36DLx4hzgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DXdVgHCf3lOgHaLNV34SPyvz+0gX8ZQfg37mkSvyAhl1sURmj+FrAaj8Ra/AtqPWrfiW1J97omSQqPxKIW/LKche2yI6jtX9FW/uM1bvLO3eBp0nh0wWUhe6reCczxOBqdrsREalIEZrK3YTZrVdiTPlf3fJdi4Ne0/4zKQgX8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a51beae2f13so58233666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 23:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712904705; x=1713509505;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VeUrNwZsrYtcAZMUcIsqFOpwyRbs+KybpBvKnVi/u2U=;
        b=DVA1VwLNoocoXGHT2x2t7cfCpXTzmtDlZGP18hYWpoqcr07wznkglr4PlAtGmaCx4W
         EBIyGCUC4ug7ec7esu3Q7v4Lf6Hhy77kzfpQfTzlNb3dfTSOh4JJ+L2UNkllN4oi4UJm
         1Z1HrDfLxVXsKVqXK72fhIMWJOFnVGXhWi7yHWjIEAQy8Rpp1q3JqDyDFoLejCh00MsO
         P/FiRu9a39kPbPTClmSJQuEAIJFXd+sjhxIxkRVeXGYWPW4k5UImrRIdRQeq5koiTJpT
         vszYh8jnSdQyvbkOQlmgr5O3p0JK6A9KjkSMvcwVWOV+h6Z7A2UaXlb79qpu6FxDPyf2
         8zNA==
X-Forwarded-Encrypted: i=1; AJvYcCUDNe21HnaF3hiERsADRs/OZuv6nxeGkqlIq0NMXiwOfv9zWtZQt67RzMkwawx2Ei2uPOxQSNshGj9LMblyEwJbcv7LSDqKJT3TgRID
X-Gm-Message-State: AOJu0YzoQjWEKkEUYzuwS171gqSN7y0wJ2I1XzcG/sksh7b7QKZKh9Vk
	boRM8U0iPwR71isT47sBIhucGownGXPS7P/ECUu0xW7l3FcHPFG5
X-Google-Smtp-Source: AGHT+IF+IGlqAXo5sBwOwY37R8KnLUFmLqOlSFhOiLiTsPJfXYkm7i5sEoAAk6Z94Wj5wGzTbmeWaA==
X-Received: by 2002:a17:906:f84f:b0:a51:c6e9:159f with SMTP id ks15-20020a170906f84f00b00a51c6e9159fmr873668ejb.74.1712904705177;
        Thu, 11 Apr 2024 23:51:45 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id bl22-20020a170906c25600b00a522bf06d8fsm923273ejb.14.2024.04.11.23.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 23:51:44 -0700 (PDT)
Message-ID: <75dff5cd-7b0e-4039-9157-8bf10cf7ba29@kernel.org>
Date: Fri, 12 Apr 2024 08:51:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: hvc: wakeup hvc console immediately when needed
To: li.hao40@zte.com.cn
Cc: gregkh@linuxfoundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20240412113848167egmP7kBg1Qm5sxfwGALG-@zte.com.cn>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240412113848167egmP7kBg1Qm5sxfwGALG-@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12. 04. 24, 5:38, li.hao40@zte.com.cn wrote:
> From: Li Hao <li.hao40@zte.com.cn>
> 
> Cancel the do_wakeup flag in hvc_struct, and change it to immediately
> wake up tty when hp->n_outbuf is 0 in hvc_push().
> 
> When we receive a key input character, the interrupt handling function
> hvc_handle_interrupt() will be executed, and the echo thread
> flush_to_ldisc() will be added to the queue.
> 
> If the user is currently using tcsetattr(), a hang may occur. tcsetattr()
> enters kernel and waits for hp->n_outbuf to become 0 via
> tty_wait_until_sent(). If the echo thread finishes executing before
> reaching tty_wait_until_sent (for example, put_chars() takes too long),
> it will cause while meeting the wakeup condition (hp->do_wakeup = 1),
> tty_wait_until_sent() cannot be woken up (missed the tty_wakeup() of
> this round's tty_poll). Unless the next key input character comes,
> hvc_poll will be executed, and tty_wakeup() will be performed through
> the do_wakeup flag.
> 
> Signed-off-by: Li Hao <li.hao40@zte.com.cn>
> ---
>   drivers/tty/hvc/hvc_console.c | 12 +++++-------
>   drivers/tty/hvc/hvc_console.h |  1 -
>   2 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
> index cd1f657f7..2fa90d938 100644
> --- a/drivers/tty/hvc/hvc_console.c
> +++ b/drivers/tty/hvc/hvc_console.c
> @@ -476,11 +476,13 @@ static void hvc_hangup(struct tty_struct *tty)
>   static int hvc_push(struct hvc_struct *hp)
>   {
>   	int n;
> +	struct tty_struct *tty;
> 
>   	n = hp->ops->put_chars(hp->vtermno, hp->outbuf, hp->n_outbuf);
> +	tty = tty_port_tty_get(&hp->port);
>   	if (n <= 0) {
>   		if (n == 0 || n == -EAGAIN) {
> -			hp->do_wakeup = 1;
> +			tty_wakeup(tty);

What if tty is NULL? Did you intent to use tty_port_tty_wakeup() instead?

thanks,
-- 
js
suse labs


