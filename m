Return-Path: <linux-kernel+bounces-80565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B258669AE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 840F228199E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBF61B947;
	Mon, 26 Feb 2024 05:32:45 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220FA1B7E5
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 05:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708925564; cv=none; b=q7Tgbbj7z+Q/pq/zOfgSoXApt3LHHCqt+3JHWIodx+SzLBAHR4lvGSU2j3h185ZQ2j4ln/rCz06WnbT1BY0jT75Z+kmPhvWhpc1+CU5rIynAKzQdPreQssz6vWo78nCXy4VaU3TVTMqz0g2PYRakVQDwF50jGx+Rg9WH9ChcPKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708925564; c=relaxed/simple;
	bh=tyv6MhYLlCuLhoKBDoh+njPhpHwvf+VCHcqxdskDw/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fE/NsDmSzW7PWPha+glUPEeXhEap16JKuXUi6TG9vQajfgVEpMfMwVFs8Iq8UbjkXQB2v/nbmQQJX2MGr3dZMy4KmFhZNnGIGq4mvLmCLfpJywURYlg+tClF0AyeaJkq+NcNKh76iPYaiV9bynZsmq2gNCG/MBBZd0lNyEH9GUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-564fd9eea75so3125063a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 21:32:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708925561; x=1709530361;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zk4X73m+k+2u6r6PF+hHboJCB8LZGZ7egry2rIkG3xc=;
        b=sP4D3rxJgxI1CLC8YV9lNqxVTq0XVX0fp2jFwnFiX0BFuy6sPLDB4J3AIEl5ZEibhs
         hUHnGEQfwzNv1EXR61cyTYqLWPFc3MmR3doi0/09B5yZg52Cs4tAowIcYCFYDW3P6ESP
         dapKYqYuhNPl5idWuFNewlMCdZJ466t8V9YkvhoCy8kKMjCAZKcObRy8EXd3QKDBF2AS
         wEc54lGUOQH88Pm7g8aR4nLmSyohdSysU9mu2It9ZwUNzGF16RvEdNnqqQhd7h/rGm1W
         +BbvJ/VBtsbDW1vfZ0Pzc0bl9rJ8qMZCa4K7hIMwO7kXW6sZM42RMjv38NNBWvkG5hFv
         /tFA==
X-Forwarded-Encrypted: i=1; AJvYcCV+Av1Ksftid/bV2ojGzndZ2CqBTCkW6KV51uTd3itx7UJX7Mf8Z9HjzOKMAWFH9obaTJcWDnS9Rek2VHrdyYSoceBt9gzDIj8FkZJA
X-Gm-Message-State: AOJu0Yz9OacZ0xuq+mY0zZtcBz4YrKR9A65fnD8pXuZD2m58TJwnBRXE
	I9SgzOwaCSvgRmPaKLemH5scV8bIrJfUDzQiSA8eoLLePElF53Ud
X-Google-Smtp-Source: AGHT+IGLtmndL3lxpKzvueuB5eNvoG9VSHOVFO2W5k07Kobt/UT4V5+bnjmxizqcYAh6lGb1wwOnVA==
X-Received: by 2002:a17:906:f8d3:b0:a43:4530:c722 with SMTP id lh19-20020a170906f8d300b00a434530c722mr1404509ejb.2.1708925561240;
        Sun, 25 Feb 2024 21:32:41 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id vk3-20020a170907cbc300b00a42fe08081fsm1753817ejc.47.2024.02.25.21.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Feb 2024 21:32:40 -0800 (PST)
Message-ID: <4f7681ce-9e91-456f-bcc8-3b756f5c04bd@kernel.org>
Date: Mon, 26 Feb 2024 06:32:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] kfifo: add kfifo_out_linear{,_ptr}()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: stefani@seibold.net, linux-kernel@vger.kernel.org
References: <20240223115155.8806-1-jirislaby@kernel.org>
 <20240223115155.8806-4-jirislaby@kernel.org>
 <20240223183123.59efd1d637cf33b9f24d6b2e@linux-foundation.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240223183123.59efd1d637cf33b9f24d6b2e@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24. 02. 24, 3:31, Andrew Morton wrote:
> On Fri, 23 Feb 2024 12:51:54 +0100 "Jiri Slaby (SUSE)" <jirislaby@kernel.org> wrote:
> 
>> +	return min(n, __kfifo_peek_n(fifo, recsize);
> 
> When things like this happen I wonder "was I sent the correct version"
> and "was this tested" and "wtf".
> 
> Please confirm that with this patch:
> 
> --- a/lib/kfifo.c~a
> +++ a/lib/kfifo.c
> @@ -497,7 +497,7 @@ unsigned int __kfifo_out_linear_r(struct
>   	if (tail)
>   		*tail = fifo->out + recsize;
>   
> -	return min(n, __kfifo_peek_n(fifo, recsize);
> +	return min(n, __kfifo_peek_n(fifo, recsize));
>   }
>   EXPORT_SYMBOL(__kfifo_out_linear_r);
>   
> @@ -609,4 +609,3 @@ unsigned int __kfifo_dma_out_prepare_r(s
>   	return setup_sgl(fifo, sgl, nents, len, fifo->out + recsize);
>   }
>   EXPORT_SYMBOL(__kfifo_dma_out_prepare_r);
> 
> we have a fully tested, production quality kernel change?

After Friday's last minute changes, there are apparently more issues (as 
reported by the test robot). Please drop this series, I will send a 
better one.

And I understand that you are OK for this to go through serial, so I 
will post with the serial "users" too. Of course with you in Cc, so that 
you can (N)Ack.

thanks and sorry for the bogus submission,
-- 
js
suse labs


