Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFDB7F356C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbjKUR6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjKUR6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:58:35 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680F218C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:58:31 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6cd09663b1cso3847082a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700589510; x=1701194310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=77qERLs0OaQrBVtVqKqY8REeDJgJr05nxeZrsBFakuY=;
        b=C/ZEMiJFlpYDHxuW1leUupyS6vNzdkfSumXePhGeFDhDCLK1cdurDgDjkbAhPXNUdR
         qkMPqpti0sv8HqkMMkuHCSYzgNvFI0Ov90tBF4Nv6cg5+5OqPKZXvlTRuq9K+WbzYN5k
         WMvrVAd5hyRH07yloQ5Oy095mdEMhN2JY5mXdGF9lG4G9LABX5tSNMEsaz38TfU7Sh9J
         5cbpvt0c92/hkvgReLQ9ijmal1MfBpcJEVdZP89dgqYwOHpNzxNhrva/oCM8Zk9zYnoO
         zBoqtlosoI7ovoSMcVOjXLZNV6ag4AhMV/oE/HzcRuLUAhMhWr7Th3SZ2Dqq+Mst6+wy
         +q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700589510; x=1701194310;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=77qERLs0OaQrBVtVqKqY8REeDJgJr05nxeZrsBFakuY=;
        b=QL1gOd853WRWZnzgRDcTCcAuiDzSj2mAHpTnxIJyESFsYSC2CTz+QFWF4WeVACHZ/O
         eFvzq6d4fTzrv1bSaZacYadXw0SwhgK+beeTvZOQBOU6En7WEpyiUyPyFuAdJLeE3FKN
         PR0C9jL2mcVASRzotg0Fa98G5JPbYTP1h188TzVyQ09rtTZtbKCS2mU+PD6MNB1zjnIq
         CI7GZVxCzQ1iR/r7cW+EjifJPWk73exrTX9ggxFqxgMZRk925DGyxuLpxBbd22wijVTb
         hGJr8FkoYO48LNo5fcTzOzBbHXAdhDjDyUgZK9yVmBkXHzey8FAJGnvEWaqmVo415gIL
         z+kQ==
X-Gm-Message-State: AOJu0YymljmHRiMqHDIFJeKqZ7qktivfoQZHwt25wy0hk6HGlQ6plJVT
        0suK0ve6XEehZPy1r1piG/CESg==
X-Google-Smtp-Source: AGHT+IH2kHEJhg1L+w3IKpHNOng3FayS3H19pAQ9FtKcBKGQIPjhcoraxZrC/R/qsT/fQHVTmFyF/Q==
X-Received: by 2002:a05:6870:46a9:b0:1e9:b0fa:de48 with SMTP id a41-20020a05687046a900b001e9b0fade48mr7101338oap.47.1700589510707;
        Tue, 21 Nov 2023 09:58:30 -0800 (PST)
Received: from [172.20.7.39] ([187.217.227.247])
        by smtp.gmail.com with ESMTPSA id j25-20020a9d7699000000b006b74bea76c0sm1648610otl.47.2023.11.21.09.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 09:58:30 -0800 (PST)
Message-ID: <885063ee-b0da-42cc-b836-da2117d4d3aa@linaro.org>
Date:   Tue, 21 Nov 2023 11:58:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/17] tty: srmcons: make 'str_cr' const and non-array
Content-Language: en-US
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
References: <20231121092258.9334-1-jirislaby@kernel.org>
 <20231121092258.9334-18-jirislaby@kernel.org>
From:   Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231121092258.9334-18-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/23 03:22, Jiri Slaby (SUSE) wrote:
> 'str_cr' contains a single character: \n. There is no need to declare it
> as array. Declare it as a variable, make it const and pass a pointer to
> it to callback_puts().
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: linux-alpha@vger.kernel.org
> ---
>   arch/alpha/kernel/srmcons.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
> index c6b821afbfd3..a6cff61706b5 100644
> --- a/arch/alpha/kernel/srmcons.c
> +++ b/arch/alpha/kernel/srmcons.c
> @@ -91,7 +91,7 @@ srmcons_receive_chars(struct timer_list *t)
>   static void
>   srmcons_do_write(struct tty_port *port, const char *buf, int count)
>   {
> -	static char str_cr[1] = "\r";
> +	static const char str_cr = '\r';

Best to remove this entirely...

>   	size_t c;
>   	srmcons_result result;
>   
> @@ -119,7 +119,7 @@ srmcons_do_write(struct tty_port *port, const char *buf, int count)
>   		}
>   
>   		while (need_cr) {
> -			result.as_long = callback_puts(0, str_cr, 1);
> +			result.as_long = callback_puts(0, &str_cr, 1);

... and simply use "\r" here.

Logically it adds one '\0' of const data, but it is virtually certain that even more bytes 
of padding are present anyway.  As a string literal it will be placed into .rodata.str1.1 
and packed with other strings.


r~
