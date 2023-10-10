Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3097BFEB2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbjJJOEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjJJOEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:04:13 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B44AC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:04:12 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-79fc0068cb5so23479839f.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1696946651; x=1697551451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7IzdtVda5p6uZw0sv3lF6L0PV8Is8yYsfl2erGY9rmY=;
        b=ggDkuI/ZdiTmkTQAU928IZzs/kpc9bkI0nhQjNKtQnwEWNC5IxYF6/CqivS4VFxO8z
         83xtheKI5apvfS6PTIeU61z8h4tiVWPXo3aQqV7jbEgaLwE+6GG305bcpt0GyFnTkMw1
         J1iUDbAQ9ZkwS6di59n3HI5VCHOArFeyjngOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696946651; x=1697551451;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7IzdtVda5p6uZw0sv3lF6L0PV8Is8yYsfl2erGY9rmY=;
        b=r5149o81hk6XsVATrTS4ZU+MyGbhxImgGt29FjIR+17p/XGrqyp9+BCdG68uafkaHC
         RaUXRzMMELytou5DtWjhkp5dsGIsA5COgEUTbxJHD4twF+G8oPrbbnhy6nN2Wt3BbdWq
         8CSmu9//nkqzjMPCYcKUaVsMYkCJfZVGwS5HiVKDnsv13tpwdFLNGr0YCZysztjgzqFY
         6q6MbXF92JhQHz0+dWAYwgAZwW85d1L8SW9gPbjb3qUINUuQBS4QXvav3TOmTRn42wvO
         0Y+BIXfX62tnAzShMRxSCvs6W5EYzBqAUJmajGOzymyyXz7sFIGT6iTJ08vuWBxQkQZr
         5MFA==
X-Gm-Message-State: AOJu0YzOSlgZtNvDp64Is2+QnJjvGGcddBWlmztaG/d6Am/ZU58aw75q
        cGY8B2f7MjpQtyobYU96XRLElg==
X-Google-Smtp-Source: AGHT+IG2AhVE6CgiRlVtHUh6DOO7yr2NmYgAY4+FTDjU41s456pchXmBPPQLSzWoiaw/n7tk+WAc/w==
X-Received: by 2002:a05:6602:2e84:b0:79f:8cd3:fd0e with SMTP id m4-20020a0566022e8400b0079f8cd3fd0emr23041244iow.1.1696946651485;
        Tue, 10 Oct 2023 07:04:11 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id r18-20020a056638101200b0042319c38763sm2779337jab.15.2023.10.10.07.04.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 07:04:10 -0700 (PDT)
Message-ID: <e9f887d3-1fa7-42f1-8d84-bff26150cfad@linuxfoundation.org>
Date:   Tue, 10 Oct 2023 08:04:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: duplicate patches in the nolibc tree
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, Willy Tarreau <w@1wt.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20231010153354.2357ee1c@canb.auug.org.au>
 <0e0f5e19-c962-458a-b52d-0aa540301c34@paulmck-laptop>
 <92d99a63-876e-4d9c-be59-703b7f298c24@t-8ch.de>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <92d99a63-876e-4d9c-be59-703b7f298c24@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/23 07:46, Thomas Weißschuh wrote:
> On 2023-10-10 06:44:00-0700, Paul E. McKenney wrote:
>> On Tue, Oct 10, 2023 at 03:33:54PM +1100, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> The following commits are also in the rcu tree as different commits
>>> (but the same patches):
>>>
>>>    1b831eb43176 ("tools/nolibc: string: Remove the `_nolibc_memcpy_down()` function")
>>>    3a7296c94dfa ("tools/nolibc: x86-64: Use `rep stosb` for `memset()`")
>>>    3f79a57865b3 ("selftests/nolibc: libc-test: avoid -Wstringop-overflow warnings")
>>>    9e9dcee894f8 ("selftests/nolibc: use -nostdinc for nolibc-test")
>>>    a04fd4052251 ("tools/nolibc: add stdarg.h header")
>>>    ab663cc32912 ("tools/nolibc: automatically detect necessity to use pselect6")
>>>    bd216cb8d814 ("tools/nolibc: don't define new syscall number")
>>>    c6a15707d1c3 ("tools/nolibc: string: Remove the `_nolibc_memcpy_up()` function")
>>>    d09e2b033a9f ("tools/nolibc: avoid unused parameter warnings for ENOSYS fallbacks")
>>>    d7f2a69857ce ("MAINTAINERS: nolibc: update tree location")
>>>    dbb6448b4263 ("selftests/nolibc: allow building i386 with multiarch compiler")
>>>    e6401064e32b ("tools/nolibc: x86-64: Use `rep movsb` for `memcpy()` and `memmove()`")
>>
>> Apologies for the hassle, but which is the non-rcu tree?
> 
> Should be this one:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=nolibc
> 
> Sorry for the breakage.

Sorry - I will update the tree.

thanks,
-- Shuah

