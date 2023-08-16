Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D1C77E5E5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344562AbjHPP7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344552AbjHPP7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:59:32 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E933210F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:59:31 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-760dff4b701so80395739f.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692201571; x=1692806371;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6LWn1wprpupG35+bMZ4L8PNbSMJ+ptPNw9QujPnf6hY=;
        b=Y9009i98a5k/RKDiCvgAVt/GpX9xfdqqSzhcRoZ4o5yRIf4K57F6CXkNhs4fCSxZHE
         gufo+/8vkgMf63/1JpsrRlmv/PgunPkbf9IQQKvFZpljRW4gK3Or+xkqA3dgQ9sRYAPq
         mx8lAzpcktGEMFRg42+fUjWmNnuPb6pfGq4dY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692201571; x=1692806371;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6LWn1wprpupG35+bMZ4L8PNbSMJ+ptPNw9QujPnf6hY=;
        b=Ie3/Lhfydl56LJh7ZBA1OfY5nJIbRhkA88+6ZzHjYG+xbjky63fT4z561ZC+M74TcI
         IzvMKU47rvpajtQFrZaIQw5SPh70ehOfVDS+sKznR7JxiWqTchkiApwQ7paMo8hPVKLm
         eTSN0jK1Jkz6RL3kyD7sdRUR7is/UAHWOlnjI9ImnHR102nmXzja3XnkH/kqZtdE7JHN
         7cIuy/ozsiiU/YmMxPmeOyIIWR36I8BFftwLMbBd4Zjq0z280mgXtCbMo04foyyJ8d0U
         B2yI7CIST7YXqSB+OKyY7I3m/rwlWY5ly4L/3i8Ad2xEHiAh121ZdwvjqwFJY/r/Mzj+
         1cVw==
X-Gm-Message-State: AOJu0YxqM/Ny4bAzBc8tUN3qdnL94yVWl0UOlCmmJzZAkH5LOUy/t1cg
        pKmhEE71jtmsGVOlM+csCUKqjQ==
X-Google-Smtp-Source: AGHT+IGK4cdCETtfYgSH4T9D5jn2WTiDl9/1cLISPwpvLDfE4s5qSf8Ox8MxyoVcoyjql0bwO2/2jQ==
X-Received: by 2002:a05:6602:3983:b0:783:63e8:3bfc with SMTP id bw3-20020a056602398300b0078363e83bfcmr3773980iob.0.1692201571288;
        Wed, 16 Aug 2023 08:59:31 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id b12-20020a5ea70c000000b0078702f4894asm4719286iod.9.2023.08.16.08.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 08:59:30 -0700 (PDT)
Message-ID: <8d0c3075-22a0-bd13-45fe-f8c052e50588@linuxfoundation.org>
Date:   Wed, 16 Aug 2023 09:59:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5] selftests: rtc: Fixes rtctest error handling.
Content-Language: en-US
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Atul Kumar Pant <atulpant.linux@gmail.com>
Cc:     a.zummo@towertech.it, shuah@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230717175251.54390-1-atulpant.linux@gmail.com>
 <202307172115223bd0669f@mail.local>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <202307172115223bd0669f@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/23 15:15, Alexandre Belloni wrote:
> On 17/07/2023 23:22:51+0530, Atul Kumar Pant wrote:
>> Adds a check to verify if the rtc device file is valid or not
>> and prints a useful error message if the file is not accessible.
>>
>> Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> 
> Please collect and keep the tags you got on previous versions
> 
>> ---
>>
>> changes since v4:
>>      Updated the commit message.
>>
>> changes since v3:
>>      Added Linux-kselftest and Linux-kernel mailing lists.
>>
>> changes since v2:
>>      Changed error message when rtc file does not exist.
>>
>> changes since v1:
>>      Removed check for uid=0
>>      If rtc file is invalid, then exit the test.
>>
>>   tools/testing/selftests/rtc/rtctest.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
>> index 63ce02d1d5cc..630fef735c7e 100644
>> --- a/tools/testing/selftests/rtc/rtctest.c
>> +++ b/tools/testing/selftests/rtc/rtctest.c
>> @@ -17,6 +17,7 @@
>>   #include <unistd.h>
>>   
>>   #include "../kselftest_harness.h"
>> +#include "../kselftest.h"
>>   
>>   #define NUM_UIE 3
>>   #define ALARM_DELTA 3
>> @@ -419,6 +420,8 @@ __constructor_order_last(void)
>>   
>>   int main(int argc, char **argv)
>>   {
>> +	int ret = -1;
>> +
>>   	switch (argc) {
>>   	case 2:
>>   		rtc_file = argv[1];
>> @@ -430,5 +433,11 @@ int main(int argc, char **argv)
>>   		return 1;
>>   	}
>>   
>> -	return test_harness_run(argc, argv);
>> +	// Run the test if rtc_file is valid
>> +	if (access(rtc_file, F_OK) == 0)
>> +		ret = test_harness_run(argc, argv);
>> +	else
>> +		ksft_exit_fail_msg("[ERROR]: Cannot access rtc file %s - Exiting\n", rtc_file);

This should be skip not a fail. access() could for a number of reasons.
Since the test isn't run when access() returns error, this would be a
skip. Also the new message could be improved to use strerror() to
print message with details on why access() failed.
  
thanks,
-- Shuah
