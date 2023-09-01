Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641E87901FC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 20:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350571AbjIASVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 14:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350550AbjIASVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 14:21:32 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308CA1702;
        Fri,  1 Sep 2023 11:21:26 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-79266c8617eso80311839f.3;
        Fri, 01 Sep 2023 11:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693592485; x=1694197285; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=AkxZWqWdmQ7F4OBr4vVbCBrNJyUi6XIXCKckh3E053I=;
        b=UFRW04TiecSbnPNUr7wqXSpFxNrqEc51JgS91Ow0fFG5Jy0T2ZTHpLWc3r8ObBdh56
         F1KihHTTpAGF4HM906FFVDWja2pkakbq2J1xI46JGa2ahiHT0oDdBQoi7yYUAVSb26Zl
         sgYMkedEbTr+DkddKVb57FYTnZDMTvnkb4bXCjyxz3J6EptElGsOD9fF4GUG0aw2l9Pf
         SsZav94dCOMgBxRScvTbVIyPhjYQbX+THyHu6zsESZalVMr0g6mKUUAah14HIyVUtgZD
         TQanHveQnxatEcD8r8070U9rNwOOi9TYzNGZdi/dAWk9zaO2i3YToZ8wJHZVpgP1JLVv
         1U7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693592485; x=1694197285;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AkxZWqWdmQ7F4OBr4vVbCBrNJyUi6XIXCKckh3E053I=;
        b=OnlooigOd18Dl5//uVOqdZC1A0LZiQT+Mg8NkDyWDbbceuy+k2h2xVjvJUc98ijKRN
         ise0+9iN/68w90QvwtK3xQRppc0pCuUddxVJOOl7hOQwAGgPsiouSZgPPasj6SSm7LMW
         Gh+2MqxuiZZoQRx/xvSCtRCh0UOAf+BWmWX8oxfwqvtBoootI+6B47vGL6oWKDHVFKfs
         wSIzwtl9+s9iODOZJ5XYtnnny++ciFuXXUNrJtIhkLXkIloatxmPLamlAQCumvOEsKyx
         8j+8z4sUpxFgRcgiCa2FaMYa5cDf7LCCcBGwia1lG4kIsGdiIPI3I1/7nXYYXpW5QgDP
         Vq7g==
X-Gm-Message-State: AOJu0YwilPNi1c75BSNvUwYNL/OtHMvCXIF+D/D7AwRVXUF80zviimUl
        9rYF2RdjfTvzQ1eKJmUEc0A=
X-Google-Smtp-Source: AGHT+IEbBMcZsXGlB1GUVHhi2Pihj+qc2rFLgCVuWcgWXsrzuhONf+cH6SWBxsrTojrGnCA9s4rMBQ==
X-Received: by 2002:a5e:9505:0:b0:791:6aa4:2d89 with SMTP id r5-20020a5e9505000000b007916aa42d89mr3489073ioj.21.1693592485543;
        Fri, 01 Sep 2023 11:21:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e2-20020a056638020200b0041e328a2084sm1168921jaq.79.2023.09.01.11.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 11:21:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <11390a1e-932f-8979-1547-f4555920fb7a@roeck-us.net>
Date:   Fri, 1 Sep 2023 11:21:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [patch 17/17] x86/fpu: Move FPU initialization into
 arch_cpu_finalize_init()
Content-Language: en-US
To:     Nikolay Borisov <nik.borisov@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org,
        Richard Henderson <richard.henderson@linaro.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Tom Lendacky <thomas.lendacky@amd.com>, semenzato@google.com
References: <20230613223827.532680283@linutronix.de>
 <20230613224545.902376621@linutronix.de>
 <ba1b11e5-b3f0-457b-8920-d57d470626c3@roeck-us.net>
 <20f025f9-35d9-1f35-f21e-38e1bb44b74c@suse.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20f025f9-35d9-1f35-f21e-38e1bb44b74c@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/23 11:00, Nikolay Borisov wrote:
> 
> 
> On 1.09.23 г. 20:30 ч., Guenter Roeck wrote:
>> Hi,
>>
>> On Wed, Jun 14, 2023 at 01:39:46AM +0200, Thomas Gleixner wrote:
>>> Initializing the FPU during the early boot process is a pointless
>>> exercise. Early boot is convoluted and fragile enough.
>>>
>>> Nothing requires that the FPU is set up early. It has to be initialized
>>> before fork_init() because the task_struct size depends on the FPU register
>>> buffer size.
>>>
>>> Move the initialization to arch_cpu_finalize_init() which is the perfect
>>> place to do so.
>>>
>>> No functional change.
>>>
>>> This allows to remove quite some of the custom early command line parsing,
>>> but that's subject to the next installment.
>>>
>>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>>
>> The backport of this patch into chromeos-5.10 and chromeos-5.15 via stable
>> relase merges is causing various Chromebooks (not all of them) to crash
>> early during boot. Subsequent fixes have not addressed the problem for us,
>> so we already reverted the patch from chromeos-5.15 and will revert it
>> from chromeos-5.10 as well.
>>
>> I don't know if this is a Chromebook specific problem, or if it affects
>> mainline, so this is just a heads-up in case others experience similar
>> problems.
> 
> 
> Looking at 5.15 the following prerequisites are likely missing:
> 
> af8060279968 ("mm: Move mm_cachep initialization to mm_init()")
> 5b93a83649c7 ("x86/mm: Initialize text poking earlier")
> 
> 
> Can you test with those patches backported to 5.15.y and see if it works?

Both patches are already in v5.10.y and 5.15.y, so unfortunately
that doesn't help.

Guenter

