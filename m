Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6733F753C4E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbjGNN52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235689AbjGNN50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:57:26 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F5A3580;
        Fri, 14 Jul 2023 06:57:25 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1b05d63080cso1566000fac.2;
        Fri, 14 Jul 2023 06:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689343044; x=1691935044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TfUrNaYcqNZhEYinnWCBKO+r1h4U75pLbDj1kOxOsMw=;
        b=Itkrll0RJysYvFtjk0RjuY+b+Tl/aRm/kMQ7BnrsAZtVU2lUMk+N5/p+7FE4bZjIUx
         STLdGxGFCBlosnc6HK7N8S2DuqnWux51ojiaeqJZrC2dS1KX+kCKcLwoGiYKLlV+2bL2
         hqfCaKRjugNvG5ObEVGadgZ7pS24BiNaxWm3b71sPBLGeWyLX4KRKG4xceF1+Yz+Zmrd
         iDNicZQA64Pvwn5EZHXFW+wlRLVgQbgfo3pY9NHyugq6vfnzbDxpdk1v28U+Jx7eWUX1
         KDfHYr0osT+s9ozuz4ycZIF9LB+83vFT2ZQEkVLQphmPlfrg/cTG7LEk0AB0n3VQwlwE
         095g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689343044; x=1691935044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TfUrNaYcqNZhEYinnWCBKO+r1h4U75pLbDj1kOxOsMw=;
        b=asgrILyT9Ogi95rgUbSQnjFQwqEUZfKikHGRpFbFliVfatx+N7o5EzCD4AVp3+tsy5
         jXwXoIYev7+rUhKd1Rtyqn79LA6uMHTO9RjEOMYxXsVL8d5REg58uq+VKB7nKjhsE8hy
         Y+A9Vr+NcgkGsmJHKxlID/ML1rbjFZ0qqlxg8XzKpjSGQZM3Fz6WWDi5AH8zKsFaiZ1r
         zquq42ZxwmmxcWzFexCuz/6PALP0mB5J1sBYfZCG4NVVABe/IR13eWSkogPkCU12ygXS
         UkuT7sylzndej6bg6v2NdndUzWnsNGVESuS7DezSrnvK0d81LhXqIGPnBFNbDlG7gu0+
         Wulw==
X-Gm-Message-State: ABy/qLZIn2QVJ4exUJMYRn+wXcdHmV3K6k64cTYAz5QwB5SFr2+Ux7sH
        1MlXzFV8n9TDKCf5mr4iUDI=
X-Google-Smtp-Source: APBJJlGy0BKKwjBMdzDGfbeswYUnFStzyfDbsModAk0FFK0ECQhxoQaJ27hqqw/IoC+lApzhYIuPpA==
X-Received: by 2002:a05:6870:b694:b0:19e:b8e0:1434 with SMTP id cy20-20020a056870b69400b0019eb8e01434mr6639612oab.8.1689343044511;
        Fri, 14 Jul 2023 06:57:24 -0700 (PDT)
Received: from [192.168.1.9] ([222.252.65.171])
        by smtp.gmail.com with ESMTPSA id k10-20020a636f0a000000b004ff6b744248sm7550904pgc.48.2023.07.14.06.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 06:57:24 -0700 (PDT)
Message-ID: <e62f481d-f939-a12b-7f8a-ec1db95c7b8e@gmail.com>
Date:   Fri, 14 Jul 2023 20:57:21 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tools/counter: Add checking directory exists for make
 clean
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org, rongtao@cestc.cn,
        ricardo@pardini.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <362e127d-6018-5fc6-247b-3c729b99d946@gmail.com>
 <ZKtZ1WB9LdszbxU+@fedora>
Content-Language: en-US
From:   Anh Tuan Phan <tuananhlfc@gmail.com>
In-Reply-To: <ZKtZ1WB9LdszbxU+@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William, the race condition possibility is a good point. Thanks for
suggesting me. Will send a new version with using `rm -df` instead and
add the appropriate CC lists. Thank you!

On 7/10/23 08:07, William Breathitt Gray wrote:
> On Fri, Jul 07, 2023 at 09:08:35PM +0700, Anh Tuan Phan wrote:
>> rmdir requires the directory exist so it causes "make -C tools clean"
>> failed if someone only builds other tools but not counter. This commit
>> adds checking the directory exist before doing rmdir.
>>
>> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
>> ---
>>  tools/counter/Makefile | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/counter/Makefile b/tools/counter/Makefile
>> index a0f4cab71fe5..2907f3b3094b 100644
>> --- a/tools/counter/Makefile
>> +++ b/tools/counter/Makefile
>> @@ -40,7 +40,9 @@ $(OUTPUT)counter_example: $(COUNTER_EXAMPLE)
>>  clean:
>>  	rm -f $(ALL_PROGRAMS)
>>  	rm -rf $(OUTPUT)include/linux/counter.h
>> -	rmdir -p $(OUTPUT)include/linux
>> +	@if [ -d $(OUTPUT)include/linux ]; then \
>> +		rmdir -p $(OUTPUT)include/linux; \
>> +	fi
>>  	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
>>
>>  install: $(ALL_PROGRAMS)
>> -- 
>> 2.34.1
> 
> Hi Anh,
> 
> Please CC <linux-iio@vger.kernel.org> and <linux-kernel@vger.kernel.org>
> as well in the future so Counter users and developers can become aware
> of relevant patches.
> 
> One worry I have with this approach is the possible race condition where
> the check for existence succeeds but the directory is deleted by another
> agent before our rmdir executes. However, I'm not sure how we could
> achieve such behavior atomically to prevent the issue.
> 
> One alternative I've considered is perhaps a single find command to
> search for and delete empty directories:
> 
>     find $(or $(OUTPUT),.) -type d -empty -delete
> 
> But this will delete directories not created by the makefile which I
> consider an unexpected behavior for the user (or at least very rude of
> the script to do).
> 
> Perhaps we should delete the directory tree explicitly:
> 
>     rm -df $(OUTPUT)include/linux
>     rm -df $(OUTPUT)include
> 
> Although we lose the symmetry of rmdir to our previous mkdir, this
> should prevent the race condition issue and succeed whether the
> directories still exist or not.
> 
> William Breathitt Gray
