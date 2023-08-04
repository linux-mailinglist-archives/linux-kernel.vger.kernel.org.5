Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A507708FB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjHDTXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjHDTXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:23:46 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB201BF;
        Fri,  4 Aug 2023 12:23:44 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-523225dd110so723963a12.0;
        Fri, 04 Aug 2023 12:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691177023; x=1691781823;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L/eKFZXAfS2pj/NNd9TcCFGABoDtopIimhHliyYbBCo=;
        b=NcieSZmEdP9PD4FoZu8tqvv2ddVE/jo3uieVVYtcf5i01n6KeNJ6kWSDF6BRehq7W6
         D3A1I5jc6yRamW5+8Eyyu9lD56EvaoBHHmYhgv1CkQleFdu0+G76bTRWjV3LG48DTZdz
         kEtwXm3xjSPpmBAnFDJBegeBx8FrDOa8k1c8pMFeVZn2U/GLHw2NWgz+oSJT+Ym0g6lL
         FWTUY7ttjQHfdDN3SadyqXsrrKJAr65QaUjSsXEzQzXCPHvPBXuR5rfA4G8Ima4I/S03
         ruZbBnoij34A8Tkmct1oP8njC6dpXnZImPp7pzuHyVkzSvxVGmlFa6AOWfXla6jcmpKg
         MB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691177023; x=1691781823;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L/eKFZXAfS2pj/NNd9TcCFGABoDtopIimhHliyYbBCo=;
        b=b7fOjdh7zsW28NbyCd/c+SvUnfRHbdtw12HmR1H4LDLiwZXZiNYA5ECjjqFeVJ9Emi
         RLQlnFUGLSpSqg85OM7q7mjyOpnCuTdXw30DCWSjnoXy7YOcyZOrTN/6EWUuZ+z8V0Pg
         TQKx4qk0/pJUWCy/i43HcsF1+murgOkARcMABpYZdezC6r3XEjk9GTJckHPtgbZ9dTyF
         x/3c+/H5th07CATwzBm3Xn/KZsZCAGRrsV/3xBBtrETQ0aPQ4V54NA4DFYJF/4ZtTnfR
         fqJFRj9mpb4wYZeNTRV+wr7GjvovyiXDx/4BdWnsi5X70j9EnjLJByQTpciNfcsgVfDB
         In3A==
X-Gm-Message-State: AOJu0YxeGs0hIgtfOw21//TvJ4kwJo7bRwDEeWUexOZyJXzMWpvBXQiS
        nv2v2dDh7E0E3kIqbHHCG/U=
X-Google-Smtp-Source: AGHT+IHtm8j7PYtfDvXVBNx4+jd7NDUvMHDcQFkWqI0SOazA+W2ka/MF7rHLZht0tluKlhpWJPEwSg==
X-Received: by 2002:aa7:da17:0:b0:522:7ab4:31fe with SMTP id r23-20020aa7da17000000b005227ab431femr2447946eds.23.1691177023036;
        Fri, 04 Aug 2023 12:23:43 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id e14-20020a50fb8e000000b0051df67eaf62sm1664680edq.42.2023.08.04.12.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 12:23:42 -0700 (PDT)
Message-ID: <fdd2742e-1306-b55f-30f9-6a573d2cfea5@gmail.com>
Date:   Fri, 4 Aug 2023 21:23:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] lib/ucs2_string: Add UCS-2 strscpy function
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Johan Hovold <johan@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230730161906.606163-1-luzmaximilian@gmail.com>
 <20230730161906.606163-2-luzmaximilian@gmail.com>
 <202308040115.A4643B8@keescook>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <202308040115.A4643B8@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/23 10:18, Kees Cook wrote:
> On Sun, Jul 30, 2023 at 06:19:02PM +0200, Maximilian Luz wrote:
>> Add a ucs2_strscpy() function for UCS-2 strings. The behavior is
>> equivalent to the standard strscpy() function, just for 16-bit character
>> UCS-2 strings.
>>
>> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
>> ---
>>
>> Changes in v5:
>>   - Add ucs2_strscpy() instead of ucs2_strlcpy()
>>
>> Patch introduced in v4.
>>
>> ---
>>   include/linux/ucs2_string.h |  1 +
>>   lib/ucs2_string.c           | 35 +++++++++++++++++++++++++++++++++++
>>   2 files changed, 36 insertions(+)
>>
>> diff --git a/include/linux/ucs2_string.h b/include/linux/ucs2_string.h
>> index cf3ada3e820e..c499ae809c7d 100644
>> --- a/include/linux/ucs2_string.h
>> +++ b/include/linux/ucs2_string.h
>> @@ -10,6 +10,7 @@ typedef u16 ucs2_char_t;
>>   unsigned long ucs2_strnlen(const ucs2_char_t *s, size_t maxlength);
>>   unsigned long ucs2_strlen(const ucs2_char_t *s);
>>   unsigned long ucs2_strsize(const ucs2_char_t *data, unsigned long maxlength);
>> +ssize_t ucs2_strscpy(ucs2_char_t *dst, const ucs2_char_t *src, size_t count);
>>   int ucs2_strncmp(const ucs2_char_t *a, const ucs2_char_t *b, size_t len);
>>   
>>   unsigned long ucs2_utf8size(const ucs2_char_t *src);
>> diff --git a/lib/ucs2_string.c b/lib/ucs2_string.c
>> index 0a559a42359b..b608129fcbdc 100644
>> --- a/lib/ucs2_string.c
>> +++ b/lib/ucs2_string.c
>> @@ -32,6 +32,41 @@ ucs2_strsize(const ucs2_char_t *data, unsigned long maxlength)
>>   }
>>   EXPORT_SYMBOL(ucs2_strsize);
>>   
>> +ssize_t ucs2_strscpy(ucs2_char_t *dst, const ucs2_char_t *src, size_t count)
>> +{
>> +	long res;
>> +
>> +	/*
>> +	 * Ensure that we have a valid amount of space. We need to store at
>> +	 * least one NUL-character.
>> +	 */
>> +	if (count == 0 || WARN_ON_ONCE(count > INT_MAX))
> 
> Is "count" a measure of bytes or characters? It seems to be characters.
> can you please add some kern-doc for this function to clarify this.
> Also, I wonder if the above check should be "count > INT_MAX / 2" since
> the INT_MAX is, generally, done in byte counts.

Count is a measure of characters. I'll add a doc-comment.

Regarding INT_MAX / 2: I'm fine with either. I'd change it to
INT_MAX / sizeof(*dst) if you say it's generally enforced in bytes.

>> +		return -E2BIG;
>> +
>> +	/*
>> +	 * Copy at most 'count' bytes, return early if we find a
> 
> If "count" is characters, this comment should not say "bytes". :)

Correct. Will fix this.
  
>> +	 * NUL-terminator.
>> +	 */
>> +	for (res = 0; res < count; res++) {
>> +		ucs2_char_t c;
>> +
>> +		c = src[res];
>> +		dst[res] = c;
>> +
>> +		if (!c)
>> +			return res;
>> +	}
>> +
>> +	/*
>> +	 * The loop above terminated without finding a NUL-terminator,
>> +	 * exceeding the 'count': Enforce proper NUL-termination and return
>> +	 * error.
>> +	 */
>> +	dst[count - 1] = 0;
>> +	return -E2BIG;
>> +}
>> +EXPORT_SYMBOL(ucs2_strscpy);
>> +
>>   int
>>   ucs2_strncmp(const ucs2_char_t *a, const ucs2_char_t *b, size_t len)
>>   {
>> -- 
>> 2.41.0
>>
> 
> Otherwise looks good to me!

Thanks!

Regards
Max
