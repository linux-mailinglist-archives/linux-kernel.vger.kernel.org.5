Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0387F3536
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbjKURsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjKURs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:48:28 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F65E8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:48:24 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5be30d543c4so3916435a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700588904; x=1701193704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BQpzfrYGsE+0PTDTiL34gs/OkqhZ2Wyj6iaH/gbK9pA=;
        b=x2A3Cbh47sHuNGHBg/J7MDKyUfI9sMsj7PdzqyW2ayIIV3Ozs0iybHayy15D5OyDpm
         mL3ChPDjdkXqPCUDo2Ck4L2gCqXk1GGkK6lO54isvvW2//0iVW8wJfROrTN0AVTH/5FF
         sp5K6dmV1+HQwrpfOwavtUhswCvYvR11Ab8f+WcpIUrKQ2rfr+NlzUjHXqzQVrYyEKzn
         7fU9IZkKigzFZynGqYWOU4L8zngOIEFWnV84Z9ibm9FPB9MdcBapmm9M5dKvGW6vCDph
         /ZtMsS+hX9SvyLtYIPr8Po082uDCvf316AzfhxXBOqQuzVmXUXvbWiTWMSfkPb9+i7oz
         I+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700588904; x=1701193704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQpzfrYGsE+0PTDTiL34gs/OkqhZ2Wyj6iaH/gbK9pA=;
        b=oaP7nzdxcynls9mo8BdfiGISvaox/TH/Iw5Wvm87gwggOYQJPd4rxCMYqa+tbqHw6l
         23mV/VPph4c2kPHKwK2zUThQ0uxEFggKc1LbvXmbsapseYuzJj13F+6WVtuaPqKV4ASP
         7sVxBsMoQ/5BiEagT7loW278zzEQq0VLOt1HDYiIODXDn2neykyiMfrwNOHyTXdsbHKN
         /OVKFY9VICtNGXHlCaU363RF2noFZQ3YPm9vVxcT1i5FaWoZER2ZqhMeR7FlT5eICH2v
         NUeKQMUfjvz9GUrkdFvj9aUsj5eXa0JUWMjMWeSXPeg1nW1KUvmbSE5QY4bAT34ugZL4
         tvWA==
X-Gm-Message-State: AOJu0YxXRK2rGUbJyOdO79FgG5TrM7jTcnhE0QUniyybeH6I76odPYlQ
        OgP+oW9Z64/HU4wDTalqrRMrTQ==
X-Google-Smtp-Source: AGHT+IH5+zyRERABCW680nOLtro7a4MXSzHErXwyD79vgIKV1PgOl18oHlnP03UVvOvNUqMpg8KYLQ==
X-Received: by 2002:a05:6a20:1604:b0:138:2fb8:6c48 with SMTP id l4-20020a056a20160400b001382fb86c48mr9735361pzj.8.1700588903961;
        Tue, 21 Nov 2023 09:48:23 -0800 (PST)
Received: from [172.20.7.39] ([187.217.227.247])
        by smtp.gmail.com with ESMTPSA id b11-20020a056a000ccb00b006cb69ff0444sm5547127pfv.151.2023.11.21.09.48.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 09:48:23 -0800 (PST)
Message-ID: <2773db23-b897-48f4-8529-5cb70480e40e@linaro.org>
Date:   Tue, 21 Nov 2023 11:48:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/17] tty: srmcons: make srmcons_do_write() return void
Content-Language: en-US
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
References: <20231121092258.9334-1-jirislaby@kernel.org>
 <20231121092258.9334-16-jirislaby@kernel.org>
From:   Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231121092258.9334-16-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/23 03:22, Jiri Slaby (SUSE) wrote:
> The return value of srmcons_do_write() is ignored as all characters are
> pushed. So make srmcons_do_write() to return void.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: linux-alpha@vger.kernel.org
> ---
>   arch/alpha/kernel/srmcons.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
> index 8025e2a882ed..32bc098de7da 100644
> --- a/arch/alpha/kernel/srmcons.c
> +++ b/arch/alpha/kernel/srmcons.c
> @@ -88,7 +88,7 @@ srmcons_receive_chars(struct timer_list *t)
>   }
>   
>   /* called with callback_lock held */
> -static int
> +static void
>   srmcons_do_write(struct tty_port *port, const char *buf, int count)
>   {
>   	static char str_cr[1] = "\r";
> @@ -125,7 +125,6 @@ srmcons_do_write(struct tty_port *port, const char *buf, int count)
>   				need_cr = 0;
>   		}
>   	}
> -	return count;
>   }
>   
>   static ssize_t

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
