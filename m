Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAAB7EF7E1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 20:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346090AbjKQTbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 14:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjKQTbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 14:31:34 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4306CB6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 11:31:31 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-5842ea6f4d5so1306219eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 11:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700249490; x=1700854290; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rLQpx2Ea8WniN3ET3XXwxquF9xYnIWv3JtKcYcjl7e8=;
        b=PjfeYJe5kgNX4PA/bnqnxVeEuo1UZ2GGbzVXbfgw2OdaqjiNWxpacTm89JqHpUsW2C
         AEzpw2Is7IZn5dn/g9Ji87/OvjrAeZXDAYLYKKd20JPbcPUb8+rxKCts7pcOfl+K+Ca8
         NTvXNaCj948lab0RRg1LQ7Y3a/yCcniqcNBsfx1f5KdcRVLGRG1eEjdbDA7OoQiwo2Fy
         L54d6DUDRSYb3uS8vkpwgBV6DfoizwA8CZDpEisBIwmY+2dBPR2g3iWE6gv3aUS5NPQE
         hDz9QcWY+GdO1DqvoqMu0nJwcAROU3+RTrUKGPX+FbMVOwM8EzB4hwY0Xn1cbNaoe9sx
         JacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700249490; x=1700854290;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLQpx2Ea8WniN3ET3XXwxquF9xYnIWv3JtKcYcjl7e8=;
        b=hyyLplkh7N4DtBxEjX8zpVYOT09WmxpmuMRTRqh1tIBPxb+dnwi7grGm6mEhRQlZ2p
         18XSJ00x2TOqsaBKiLLoB/Hjw8SFj3GZa0v81tH/JKwW+sWCU5uufOQ55e98ubShSjIp
         m0CFGBDImmdrWU/HNkSfipgU2pIr45rROvaLoh2epuisas7ZNM3HCVBfGTTi6xwX98HQ
         O4qf5IM2zOETQNieLD9gYTjfDqn7BaXFSniigW5EVCwfR1uzEC9prtXpulTp8qWlc0H5
         pRUpCOjAthDPg12JQUYsR/O77rQmVv3nXTkxuyRTXwc8rIQrblhS4tVj5rtU5eNR4CmX
         QyDQ==
X-Gm-Message-State: AOJu0YwFaJu+n2zw6ubZoFlN/g/yY4qqrkF2vQaGp7WviTA05hXnf3zP
        Iira/Iu05LRlqeyhHBZF9V/s5bDMWzOAXF2cOPA=
X-Google-Smtp-Source: AGHT+IEgz6Xb9oM5BedDBa+fpRovp6TSHg6uYyTwVvOfIV1flDhzcTqY8lt9oMbhwM4EPFeUu8RYZF3yJBler3spFVY=
X-Received: by 2002:a05:6358:281e:b0:16b:c810:667b with SMTP id
 k30-20020a056358281e00b0016bc810667bmr369166rwb.2.1700249490433; Fri, 17 Nov
 2023 11:31:30 -0800 (PST)
MIME-Version: 1.0
References: <20231116173849.210205-1-kdipendra88@gmail.com>
 <3ff3e05a-8377-4b38-84ae-be24b6cae6a4@intel.com> <CAEKBCKNsw60QM=Ay6CH2Kuh-L8YdjVB5yScjG9pTZUXcBrsf5w@mail.gmail.com>
In-Reply-To: <CAEKBCKNsw60QM=Ay6CH2Kuh-L8YdjVB5yScjG9pTZUXcBrsf5w@mail.gmail.com>
From:   Dipendra Khadka <kdipendra88@gmail.com>
Date:   Sat, 18 Nov 2023 01:16:19 +0545
Message-ID: <CAEKBCKP9WqurMp4M0Xfm3Jn_5roMGce+G6D3X2bNFuOPe5u07A@mail.gmail.com>
Subject: Re: [PATCH] x86: Fixes warning: cast removes address space '__user'
 of expression in uaccess_64.h
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        mjguzik@gmail.com, ira.weiny@intel.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am not sure why spare did not find the difference between 'long' and
'unsigned long'
in this particular case. I saw that in else case,there is use of
unsigned long and sparse
does not report a warning .Hence I thought casting to unsigned long
will solve the problem.
Also, there are not any other warnings thrown by spare in the uaccess_64.h file.

I think casting x  to  'void __user *'before checking whether it is
greater than or equal to zero
in valid_user_address() will be more sensible and fix the warning either.

Is this ok for you? Or have to cast to 'unsigned long' or other
changes or no need to do anything?



On Sat, 18 Nov 2023 at 00:00, Dipendra Khadka <kdipendra88@gmail.com> wrote:
>
> Hi,
>
> I am not sure why spare did not find the difference between 'long' and 'unsigned long'
> in this particular case. I saw that in else case,there is use of unsigned long and sparse
> does not report a warning .Hence I thought casting to unsigned long will solve the problem.
> Also, there are not any other warnings thrown by spare in the uaccess_64.h file.
>
> I think casting x  to  'void __user *'before checking whether it is greater than or equal to zero
> in valid_user_address() will be more sensible and fix the warning either.
>
> Is this ok for you? Or have to cast to 'unsigned long' or no need to do anything?
>
>
> On Fri, 17 Nov 2023 at 21:04, Dave Hansen <dave.hansen@intel.com> wrote:
>>
>> On 11/16/23 09:38, Dipendra Khadka wrote:
>> > Sparse has identified a warning as follows:
>> >
>> > ./arch/x86/include/asm/uaccess_64.h:88:24: warning: cast removes address space '__user' of expression.
>> >
>> > Since the valid_user_address(x) macro implicitly casts the argument
>> > to long and compares the converted value of x to zero, casting ptr
>> > to unsigned long has no functional impact and does not trigger a
>> > Sparse warning either.
>>
>> Why does sparse complain about a cast to 'long' but not 'unsigned long'?
>>  Both remove the '__user' address space from the expression.  Were there
>> just so many __user pointers being cast to 'unsigned long' that there's
>> an exception in sparse for 'void __user *' => 'unsigned long'?
>>
>> Either way, if we're going to fix it it seems like it would be better to
>> valid_user_address() actually handle, well, __user addresses rather than
>> expecting callers to do it.
