Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC487F3541
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbjKURsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbjKURsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:48:51 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8466193
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:48:47 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6c4eaa5202aso5929910b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700588927; x=1701193727; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U7Rbioe+AA0m1Xzil+Qj4X93APjsim1oxKrG1rmg9wU=;
        b=jtj8h/Gj/UcUVARWjUu8hsv2XBagNerBCPsxfyimIMsk02UtbmkkJ6NfwvqK0YA1RF
         YV6rNmVivqMstbTM+l7MFHUVEMV5+SgYMtYHT6QIY0fgiOt/J+q7iKyBZjFqGQH9gTgI
         ed3fj7YM5RC5g6Gn2ZvlAm5aoFHP6T0jfUNw1Ixshob9ozIyWxJubUtbQh2fRYDxrpaQ
         o/UBNLmaW2gxvMfvKFLOUtLlVNJ1Q5oytxNPOfG/i6jzlIqd0E2+ICiyGwYWnsfncMhs
         I4uAwbMlGBP5bmtKqzMaP8QPn6fthkT5W/GR/rjmo7g3JMOl/Ye6eh+I4k4Srx2Xj6eQ
         /dKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700588927; x=1701193727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U7Rbioe+AA0m1Xzil+Qj4X93APjsim1oxKrG1rmg9wU=;
        b=S6RNwbHHbaFLF/piKC4HiqUPW2qrrCw0gN9LsfBxkDGY0NMd/CBm8Tt4Rf1EdglTDF
         raGl9k9y2S/5LRiUPgHXQjajfzqz6c2Uf8oTlxOcG4mIrrmLsWXZVdbQ3JIzj+0s7Uuu
         DqPF4dPpZDOo7UZN01Wm65zTzZibbpL5t0KiydUfmx7nNT4OMX/Idki6O0Wu7Tnrkvee
         PRFaR1OjM5hsW5HhikaAF4spzbprtCHIs+pBV9gTgSiTg+xeMKilfRTo3FKVzCyrDcS3
         7i+O6/wrJzVWLPgzav3tdfGSaTHe5qUu2TY8iasoZwMRe0Sw4QB9nZAFrvYAouSRf+tg
         xeUA==
X-Gm-Message-State: AOJu0YwdGIG5GlcygLl0cx0idfdJVNsqdrVyi8mJpafiWIuwaOcVQBbw
        n8EkxMkUbaoo3FY9eM3sIV6nJw==
X-Google-Smtp-Source: AGHT+IH2VR6y5Gp7PFy+FKIjD6rAI0xCdmN7BDgDaHvXjsz7rNoF2oUSGeO6SUsyI6QYtEVokRmWlA==
X-Received: by 2002:a05:6a00:15d2:b0:6cb:903a:b064 with SMTP id o18-20020a056a0015d200b006cb903ab064mr9034307pfu.22.1700588927322;
        Tue, 21 Nov 2023 09:48:47 -0800 (PST)
Received: from [172.20.7.39] ([187.217.227.247])
        by smtp.gmail.com with ESMTPSA id b11-20020a056a000ccb00b006cb69ff0444sm5547127pfv.151.2023.11.21.09.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 09:48:46 -0800 (PST)
Message-ID: <f4babac1-8366-45a2-94c2-838cacb4a006@linaro.org>
Date:   Tue, 21 Nov 2023 11:48:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/17] tty: srmcons: use 'count' directly in
 srmcons_do_write()
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
References: <20231121092258.9334-1-jirislaby@kernel.org>
 <20231121092258.9334-15-jirislaby@kernel.org>
 <4f0db52-6430-9122-1ecc-86e337644944@linux.intel.com>
From:   Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <4f0db52-6430-9122-1ecc-86e337644944@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 11/21/23 09:21, Ilpo Järvinen wrote:
> On Tue, 21 Nov 2023, Jiri Slaby (SUSE) wrote:
> 
>> Similarly to 'buf' in the previous patch, there is no need to have a
>> separate counter ('remaining') in srmcons_do_write(). 'count' can be
>> used directly which simplifies the code a bit.
>>
>> Note that the type of the current count ('c') is changed from 'long' to
>> 'size_t' so that:
>> 1) it is prepared for the upcoming change of 'count's type, and
>> 2) is unsigned.
>>
>> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
>> Cc: Richard Henderson <richard.henderson@linaro.org>
>> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
>> Cc: Matt Turner <mattst88@gmail.com>
>> Cc: linux-alpha@vger.kernel.org
>> ---
>>   arch/alpha/kernel/srmcons.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
>> index b68c5af083cd..8025e2a882ed 100644
>> --- a/arch/alpha/kernel/srmcons.c
>> +++ b/arch/alpha/kernel/srmcons.c
>> @@ -92,24 +92,24 @@ static int
>>   srmcons_do_write(struct tty_port *port, const char *buf, int count)
>>   {
>>   	static char str_cr[1] = "\r";
>> -	long c, remaining = count;
>> +	size_t c;
>>   	srmcons_result result;
>>   	int need_cr;
>>   
>> -	while (remaining > 0) {
>> +	while (count > 0) {
>>   		need_cr = 0;
>>   		/*
>>   		 * Break it up into reasonable size chunks to allow a chance
>>   		 * for input to get in
>>   		 */
>> -		for (c = 0; c < min_t(long, 128L, remaining) && !need_cr; c++)
>> +		for (c = 0; c < min_t(size_t, 128U, count) && !need_cr; c++)
>>   			if (buf[c] == '\n')
>>   				need_cr = 1;
>>   		
>>   		while (c > 0) {
>>   			result.as_long = callback_puts(0, buf, c);
>>   			c -= result.bits.c;
>> -			remaining -= result.bits.c;
>> +			count -= result.bits.c;
>>   			buf += result.bits.c;
>>   
>>   			/*
>>
> 
> The patches in the series are in pretty odd order and it was not told
> anywhere here that the return value is unused by the callers. I'd just
> reorder the patches.
> 

Agreed, patch 15 needs to be before patch 14.  With that,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
