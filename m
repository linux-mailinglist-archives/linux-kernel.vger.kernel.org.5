Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9346680C7AC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 12:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbjLKLIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 06:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbjLKLI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 06:08:26 -0500
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4464DC7;
        Mon, 11 Dec 2023 03:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702292516;
        bh=rtUQjIROmhcvKCPUzvaAzQ2+fePhDS70mvZIoWhWHcY=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=asK4bqJldmXIac4/3TTmMi7GWdaUqB7VuBu/KfBQ+t5fHPQI/KGd0sLOjYucopP3r
         coupqyEqgBh346fXNiHsryTYs7oJpatHdpcERcWrkbebUjdObt9Qouf45HWKKmhNLT
         qjL3HmJqJZowqHjrTYRvdcj6TQD7lP3kfTL6y1zeqppoQKt1qtUxzrDEWAi/8rtajU
         mg4EJ4JH3kPULJeZwJyGwMKliA5cuf3llRAveZEoC0p/r9oCISA1fHaVTnWw8/762P
         jsxHnq079Cmb+bX6G3yUfA37OZGUEao7LtjX8vqQ3SjT64QUUFH0HEqEGwWXTZiMy2
         tyxjPX1HrCz3g==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id 46974378141D;
        Mon, 11 Dec 2023 11:01:52 +0000 (UTC)
Message-ID: <2180095f-1dcd-4542-aafe-aa2b4d039e62@collabora.com>
Date:   Mon, 11 Dec 2023 16:01:52 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, Aishwarya TCV <aishwarya.tcv@arm.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: core: include linux/close_range.h for
 CLOSE_RANGE_* macros
Content-Language: en-US
To:     Shuah Khan <shuah@kernel.org>
References: <20231024155137.219700-1-usama.anjum@collabora.com>
 <9dbda2f9-2bb2-4e79-976a-12856ab6936a@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <9dbda2f9-2bb2-4e79-976a-12856ab6936a@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Soft reminder

On 11/29/23 4:34 PM, Muhammad Usama Anjum wrote:
> Soft reminder
> 
> On 10/24/23 8:51 PM, Muhammad Usama Anjum wrote:
>> Correct header file is needed for getting CLOSE_RANGE_* macros.
>> Previously it was tested with newer glibc which didn't show the need to
>> include the header which was a mistake.
>>
>> Fixes: ec54424923cf ("selftests: core: remove duplicate defines")
>> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
>> Link: https://lore.kernel.org/all/7161219e-0223-d699-d6f3-81abd9abf13b@arm.com
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>  tools/testing/selftests/core/close_range_test.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
>> index 534576f06df1c..c59e4adb905df 100644
>> --- a/tools/testing/selftests/core/close_range_test.c
>> +++ b/tools/testing/selftests/core/close_range_test.c
>> @@ -12,6 +12,7 @@
>>  #include <syscall.h>
>>  #include <unistd.h>
>>  #include <sys/resource.h>
>> +#include <linux/close_range.h>
>>  
>>  #include "../kselftest_harness.h"
>>  #include "../clone3/clone3_selftests.h"
> 

-- 
BR,
Muhammad Usama Anjum
