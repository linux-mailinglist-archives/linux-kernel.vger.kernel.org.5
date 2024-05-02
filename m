Return-Path: <linux-kernel+bounces-166080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E021A8B95AD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ED041F2139E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E671324B4A;
	Thu,  2 May 2024 07:56:06 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EE022F00;
	Thu,  2 May 2024 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636566; cv=none; b=PNXCQNlSgp9Vmk2PvejcaDIqwiBrAdgSXxdhisTECYocXE25t+WkEjWiOC1tvUD4l+fiEK2b9CXKDr+bxyiJhTc3WLs9o9A9BWjZrrkmq+Mj07Nw8gIuOPIUdu1D1KxzOzWdhKUNx9j67UJmlosHJwPtoRYwKUI244QWHU/BuTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636566; c=relaxed/simple;
	bh=Vc+UiWe/PFfiLW9+QHsBDK/nqefj6balOiVXYNuF3i0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IT0Tvdm0tQ517aRMic8XKB88AqjVVPVmfuWT7lFhqLVV+kNJWbUsfgd5qJbzRZVBjp+mCcV9/MjIBeI/F9bo3klOopRaAmKlc0GsyEVdGdOS9B164S4NUSGd3gzS+b7iMKsepVdNh/5XzWFIJfbJ8KAtyljQtguOYdCA4Z7zLOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a58e787130fso265321966b.0;
        Thu, 02 May 2024 00:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714636563; x=1715241363;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCHs5AyIZZ846owNPHrscIolxUHAkH2dX6I4QmI8RyU=;
        b=XPkIocWuy4hwM7UhR0NcfEzSxSsMW104AseASWvLZDx5Fmox9+lc3Mw9kzXf3AA/DT
         j54EQuBspHA6jzGRiKiZdpWZAoPeaRJ0Uq0jCxrxFhPvmMBZUlfjN6qbShHzQe3Lm1Tf
         nn6U7X2ZVMk/M4l8UOhFoChwEAtzDe5UlJv9l2g47Gi7mIRVdUzLtKbNNcB5vWxtU2uj
         /qcQYA3akFC1md2l8pZljyQKQq/sVW3ltwa5g84Rl/u/gmSFknFH+rDeC3+tUl8PA/uz
         EmMa/O4kZ7gMZbYkidGRX78GmqYdwrfajxQznCHCYgUb6O4hCdfl/OROYryL3cgf4p16
         5xHw==
X-Forwarded-Encrypted: i=1; AJvYcCU1JJb/A6BlJU3bP7Bg3jnt6vhBiXGygiYx9N0hsCp1TaQom1HfdFlFPOG+fZWnKnGlo69GHfnwSdA+fmlR4pLjXTyXo4kscAsPJI2UI8IlV5uTfqUX9no7BOIiqeA5+eA7dihZURNMXkQx
X-Gm-Message-State: AOJu0Yw4rbkGyS1ndTzVFkkROF5rGJyuVofAzuaGAacPeAOeCRa3w979
	Z29XppxPPAQQ3qvEuwDz0Midcwrpn09q+mE5D7Hj/qh5KMjc2t7c
X-Google-Smtp-Source: AGHT+IGFME45YUcGSIYJpvtT0MBUCcOSCBGxBO1lqQJPYJ00YYSsDdQL+TsG9vmbcHd1ZjwEt6x6mw==
X-Received: by 2002:a17:906:1ccc:b0:a58:85ab:354c with SMTP id i12-20020a1709061ccc00b00a5885ab354cmr1587893ejh.1.1714636562454;
        Thu, 02 May 2024 00:56:02 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id jw20-20020a17090776b400b00a4660b63502sm253754ejc.12.2024.05.02.00.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 00:56:02 -0700 (PDT)
Message-ID: <01cbcdf5-8a7a-4b47-a2aa-05c041e3cab2@kernel.org>
Date: Thu, 2 May 2024 09:56:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] tty: sunsu: Simplify device_node cleanup by
 using __free
To: Shresth Prasad <shresthprasad7@gmail.com>, davem@davemloft.net,
 gregkh@linuxfoundation.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, javier.carrasco.cruz@gmail.com,
 skhan@linuxfoundation.org, Julia Lawall <julia.lawall@inria.fr>
References: <20240501084110.4165-2-shresthprasad7@gmail.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240501084110.4165-2-shresthprasad7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01. 05. 24, 10:41, Shresth Prasad wrote:
> Add `__free` function attribute to `ap` and `match` pointer
> initialisations which ensure that the pointers are freed as soon as they
> go out of scope, thus removing the need to manually free them using
> `of_node_put`.
> 
> This also removes the need for the `goto` statement and the `rc`
> variable.
> 
> Tested using a qemu x86_64 virtual machine.
> 
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
> ---
> Changes in v2:
>      - Specify how the patch was tested
> 
>   drivers/tty/serial/sunsu.c | 37 +++++++++++--------------------------
>   1 file changed, 11 insertions(+), 26 deletions(-)

Nice cleanup.

> --- a/drivers/tty/serial/sunsu.c
> +++ b/drivers/tty/serial/sunsu.c
> @@ -1382,44 +1382,29 @@ static inline struct console *SUNSU_CONSOLE(void)
>   
>   static enum su_type su_get_type(struct device_node *dp)
>   {
> -	struct device_node *ap = of_find_node_by_path("/aliases");
> -	enum su_type rc = SU_PORT_PORT;
> +	struct device_node *ap __free(device_node) =
> +			    of_find_node_by_path("/aliases");

If we used c++, that would be even nicer; like:
Destroyer ap(of_find_node_by_path("/aliases"));

But we don't :P. OTOH. can't we achieve that with macro-fu and typeof() 
magic? Perhaps not really exactly the above, but something like
   Destroyer(ap, of_find_node_by_path("/aliases"));
maybe?

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

thanks,
-- 
js
suse labs


