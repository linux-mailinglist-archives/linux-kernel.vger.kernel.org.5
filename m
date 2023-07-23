Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F61F75E2C2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 17:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjGWPB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 11:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjGWPBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 11:01:55 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07F1D1;
        Sun, 23 Jul 2023 08:01:54 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666e916b880so1970424b3a.2;
        Sun, 23 Jul 2023 08:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690124514; x=1690729314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bhw7aS6Ttjq7iKZtaXUkeoqYKQnM4Kk9jkRz0JOQFyU=;
        b=oBQ6EFoLo43YeFslZ93d+KzKQaPDIYxvUgtovPitsGtHDSjDw56vKDMo4hlh9obkvk
         x/vHfXMu+HFUtODWkGmX/do1OT3suz720aqbGczxyCiEO6AVPXCg89FqBg5vEG/vNd+7
         qywV3ABWwmDQduJshw71HluWwvlmP84gKQHeb6vVZq+SPubhpLRE3TUZNCftXRwAqLzy
         Xgg03sLKGkxsmjUI9O8wK9bLH+Fa297ZvEzdDp9sKi523Gg7eZITXRxQD2fAA2b0rqdq
         7p04DFmRU0+izkO4UzRvnUlAtBjryTwNwZ7Fz6ttNw2VQjbEo6BoFaOs89kDN/sjt03o
         bbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690124514; x=1690729314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bhw7aS6Ttjq7iKZtaXUkeoqYKQnM4Kk9jkRz0JOQFyU=;
        b=lW31F3dxGPyp9GBskophPmlgMfGDEOLlVhJOJ6XCxGtmfG/Rdpu4rTLKM5Ou9wPsVh
         q31/JDU8ExUUM2dEtJQBlyQmyvHnI+4gGDotiFLlapoQ41NdR368NXOxvYRXr70SPZoC
         a6mk0aIlUmvqk76ypr6vMlusl77lXr5TtCOPUJGZ8LroqNCLd6Kf7YcTIrApClBs+SyA
         hAtbjy0m4gW+0DVIbEhBBpakHO1gEEmz/qTpjqbntHuf3hje5nEAFx7SamYAgMFuVtb+
         +nDnN9hPr3Is+N8vVb2BM0wcGzfnThuMyG+JoPU8GkOB6nUaWVrbuTpUkfDhfq6joZUU
         N2Jg==
X-Gm-Message-State: ABy/qLYXhE8tOaqQX0Jn3P94ExOnhTOer4brhPps9MDOPQTebby2DwDN
        uB1BAp8lTWh5xh4iZAtoIwA=
X-Google-Smtp-Source: APBJJlGrkZbZAI+0i5agNXdNgChDuEbW7rB1bs1hj8u6UREjJr2lAAv6r87GAWsZ6e0Co0w02/ODyA==
X-Received: by 2002:a05:6a00:114c:b0:680:ddd6:7d8b with SMTP id b12-20020a056a00114c00b00680ddd67d8bmr5134675pfm.15.1690124514220;
        Sun, 23 Jul 2023 08:01:54 -0700 (PDT)
Received: from [192.168.1.9] ([222.252.65.171])
        by smtp.gmail.com with ESMTPSA id bn9-20020a056a00324900b00678afd48250sm6019234pfb.218.2023.07.23.08.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jul 2023 08:01:53 -0700 (PDT)
Message-ID: <8f5a91f4-2b4e-9007-99d3-bf69b776b708@gmail.com>
Date:   Sun, 23 Jul 2023 22:01:50 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] tools/counter: Makefile: Replace rmdir by rm to avoid
 make,clean failure
To:     William Breathitt Gray <wbg@kernel.org>
Cc:     william.gray@linaro.org, rongtao@cestc.cn, ricardo@pardini.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <d4080db5-1825-2848-079a-8bb674d8ee44@gmail.com>
 <ZLqDwg44UFNrrQfZ@ishi>
Content-Language: en-US
From:   Anh Tuan Phan <tuananhlfc@gmail.com>
In-Reply-To: <ZLqDwg44UFNrrQfZ@ishi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/23 20:10, William Breathitt Gray wrote:
> On Sun, Jul 16, 2023 at 10:44:56PM +0700, Anh Tuan Phan wrote:
>> Use rm -df instead of rmdir -p since rmdir requires the directory exist
>> so it causes "make -C tools clean" failed if someone only builds other
>> tools but not counter.
>>
>> Fixes: 228354ed692f ("tools/counter: Makefile: Remove lingering
>> 'include' directories on make clean")
> 
> Hi Anh,
> 
> Tags should span a single line even if they are long. This is minor
> enough that I will clean it as I pick up the patch so no need to worry
> about it this time. In the future, run script/checkpatch.pl on your
> patches to catch these type of mistakes that are easy to miss.
> 
> I'll queue this patch for the counter-fixes branch.
> 
> Thanks,
> 
> William Breathitt Gray
> 

Thanks for helping me correct the patch, will run the script in the future.

Best,
Anh

>> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
>> ---
>> Changes from v1:
>> - Use rm -df instead of checking the directory exists
>> - Add Fixes tag
>> - Update the patch title
>> Reference:
>> - v1:
>> https://lore.kernel.org/all/362e127d-6018-5fc6-247b-3c729b99d946@gmail.com/
>> ---
>>  tools/counter/Makefile | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/counter/Makefile b/tools/counter/Makefile
>> index a0f4cab71fe5..b2c2946f44c9 100644
>> --- a/tools/counter/Makefile
>> +++ b/tools/counter/Makefile
>> @@ -40,7 +40,8 @@ $(OUTPUT)counter_example: $(COUNTER_EXAMPLE)
>>  clean:
>>  	rm -f $(ALL_PROGRAMS)
>>  	rm -rf $(OUTPUT)include/linux/counter.h
>> -	rmdir -p $(OUTPUT)include/linux
>> +	rm -df $(OUTPUT)include/linux
>> +	rm -df $(OUTPUT)include
>>  	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
>>
>>  install: $(ALL_PROGRAMS)
>> -- 
>> 2.34.1
