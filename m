Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AEC76BBB1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjHARv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjHARvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:51:21 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3046B213C;
        Tue,  1 Aug 2023 10:51:06 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1bbc64f9a91so50159445ad.0;
        Tue, 01 Aug 2023 10:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690912265; x=1691517065;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JFahkUVAa3Z9C9oggz17jW5h7WEHfUtkbLkvSnyosWQ=;
        b=UDTa+CU5l9qb0vcEXh/qdM+cbVNE3N58W8aiv19cNfx/hM1rhGn1OxPPvb6LH/Xga+
         Re0MJDemytNiE5JhI2KfRLo6i4dsy89lrZ9Cu06o71GQD7Bf7zN/4SAAKxRqAXV1+a5c
         mCKglWMGTjX+YN1HLcwkF85Dpiri6p8v4Q/gdLPDdfRlKxh3fez2pDUULom/GpdLmrI1
         3QX0Ym2t8a/iRz1DZiLfaEU6s11pxFEi340Rw8U2ie1RHkzzBbG8sJvr7TSWTIae0qD5
         RoIbhDUFIikvGjuuKxJPEmV5+m+e3iKp7GRmxz04uVDGT4R8dICOJvfrOMP14iYGSllo
         GWSw==
X-Gm-Message-State: ABy/qLaw/bxT0/P5OwCqTfz7sRAEgLVZ0Qvqvc5WnjxRjIFQB3Rm/QUU
        h4VrmdwtkvlQuzjg1wj1hwo=
X-Google-Smtp-Source: APBJJlGJkiyy679SdLZ+dD5N7/QBXdz+gfTnyyV4bZgjA4yJq4IMUBrHZ6Hb9lSru31wGbdS1kYuLQ==
X-Received: by 2002:a17:902:c103:b0:1bb:809d:ae6a with SMTP id 3-20020a170902c10300b001bb809dae6amr11968955pli.7.1690912265455;
        Tue, 01 Aug 2023 10:51:05 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id f16-20020a170902ce9000b001ac6b926621sm10761570plg.292.2023.08.01.10.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 10:51:04 -0700 (PDT)
Message-ID: <67f2a68f-8462-e1de-c016-b84d7c6e3222@acm.org>
Date:   Tue, 1 Aug 2023 10:51:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: next: arm64: gcc-8-defconfig: ufshcd.c:10629:2:
 /builds/linux/include/linux/compiler_types.h:397:38: error: call to
 '__compiletime_assert_553' declared with attribute error: BUILD_BUG_ON
 failed:
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org,
        linux-next <linux-next@vger.kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Anders Roxell <anders.roxell@linaro.org>
References: <CA+G9fYur8UJoUyTLJFVEJPh-15TJ7kbdD2q8xVz8a3fLjkxxVw@mail.gmail.com>
 <a660adba-b73b-1c02-f642-c287bb4c72fc@acm.org>
 <CA+G9fYsYifn9ywPc8KqYHwDDSTRQGOgf_T58Gpt9CYDBs8u+SQ@mail.gmail.com>
 <227327a3-399a-4a9f-a775-e9627656b5a1@app.fastmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <227327a3-399a-4a9f-a775-e9627656b5a1@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/23 07:56, Arnd Bergmann wrote:
> On Tue, Aug 1, 2023, at 16:23, Naresh Kamboju wrote:
>> On Tue, 1 Aug 2023 at 18:53, Bart Van Assche <bvanassche@acm.org> wrote:
> 
>>>>    - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230801/testrun/18754886/suite/build/test/gcc-8-defconfig/log
>>>>    - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230801/testrun/18754886/suite/build/test/gcc-8-defconfig/details/
>>>>    - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230801/testrun/18754886/suite/build/test/gcc-8-defconfig/history/
>>>
>>> I can't reproduce this build error with a gcc-12 arm64 cross-compiler. How
>>> important is gcc-8 for the ARM community?
>>
>> You are right,
>> gcc-12 build pass.
>> gcc-8 build failed.
> 
> I can also reproduce this with gcc-9.5.0 from
> https://mirrors.edge.kernel.org/pub/tools/crosstool/ but
> not with 10.5.0 or clang.
> 
> I get the same results for x86 with gcc-9.5.0.
> 
> See https://godbolt.org/z/GjGrW9znc for a partially reduced testcase.
Thanks Arnd, this is very helpful. The first error message reported for that
test case is as follows:

<source>:34:286: error: call to '__compiletime_assert_655' declared with attribute error: BUILD_BUG_ON failed: ((u8 *)&(struct request_desc_header){ .enable_crypto = 1})[2] != 0x80
    34 |  do { __attribute__((__noreturn__)) extern void __compiletime_assert_655(void) __attribute__((__error__("BUILD_BUG_ON failed: " "((u8 *)&(struct request_desc_header){ .enable_crypto = 1})[2] != 0x80")));
  if (!(!(((u8 *)&(struct request_desc_header){ .enable_crypto = 1})[2] != 0x80))) __compiletime_assert_655(); } while (0);
       |

If I change the return type of ufshcd_check_header_layout() from void
into unsigned int and insert the following at the start of that function:

return ((u8 *)&(struct request_desc_header){ .enable_crypto = 1})[2] != 0x80;

then the compiler shows the following in the output window:

xorl    %eax, %eax

In other words, the expression next to the return statement evaluates to zero
but the same expression does not evaluate to zero in the BUILD_BUG_ON()
statement. Does this perhaps indicate a compiler bug? And if so, what is the
appropriate way to fix the build error? Insert an #ifdef/#endif pair inside
ufshcd_check_header_layout() such that the compile-time checks do not happen
for gcc version 9 or older?

Thanks,

Bart.
