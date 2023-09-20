Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42737A868D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbjITOae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbjITOac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:30:32 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2740D3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 07:30:25 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c44c0f9138so35889725ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 07:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695220225; x=1695825025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=RLl4qoUlhpaHYAbyJIpQaEfJYSLzVtx1nfy54m+QJkY=;
        b=GHMIy0XyCQHBNzFbQEgwsBToArnILX0AbNjIz2XRE1ET1FcsAmXdMHiE4Ycx71lvjC
         1QZy9kmoal7zWZnALXFU4FZzFmHT+/sMlz0rhRL823mwiK5yJtx+WJ+EmvJBd98w8bbs
         63GlFaDOpyMaDJrDQymjLniQFxgK5eUpnYM0bPuzQ6pamDvw3UT2w+AxJ3eNWKLzHs0J
         dgA8JRXiVAJmEH6ip7oJGo+UwT0YZxhsBYEP/GGGRZ0iIbBkA/0zF7h7BQrIgvIuicNt
         9TelqVS2UftYjNnGCgmYWYFBo5swqjBd9Qm6PE3rSdY427LZZK80heypSX2oWsMfpDCn
         Zgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695220225; x=1695825025;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLl4qoUlhpaHYAbyJIpQaEfJYSLzVtx1nfy54m+QJkY=;
        b=Zqh6/wz8LYvE3YiMCMu7uFZXH5cuueu4VPJRsT5eSt5FZ3083xaAWN5mI5V3SfT7Cs
         rtZgsfWZ0Hc/4qlXKFZr96Ca21Z1Chob63D2VPXaqJHU1igRnml2T7QGj+DGlAmC0dIt
         q06ED4YnmP7tJobGRv+rNmtuIxErl8Ja64pzWWoyHfAZHTCUjqt6PNyjzzgGO98vgjOu
         zGVx1ESorl1r75XClAD7208lh4B4G6fXT0unyWI1R3zKPybHUb53ALwThVZWCU0Aj3rw
         bxh3RcazU0t0457E/RaqIKF9YXqAyc5kv9XBFmp/gZICNcC7s+I8RSIRYWCitJN47CNO
         RUKw==
X-Gm-Message-State: AOJu0YyHgKwjpfjFG5QnHaCCQKk/A8jNVTnZFYo3rVFdKYrDRz3MzKhZ
        qq5niVKb6lO9OHZr9H6F31BGmTgU2bM=
X-Google-Smtp-Source: AGHT+IHwSSHAlcdVPUgiAFGYQZnQphxjRZ9SGDjWVXQGkQYFN0QJP75e+rD69BasK7iSoJ6N0PDYrw==
X-Received: by 2002:a17:902:b58d:b0:1c3:ebfc:5198 with SMTP id a13-20020a170902b58d00b001c3ebfc5198mr2326654pls.11.1695220225195;
        Wed, 20 Sep 2023 07:30:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902cec700b001b89891bfc4sm7950634plg.199.2023.09.20.07.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 07:30:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <194e2d22-9eff-ec6c-9bc9-13b62bda870a@roeck-us.net>
Date:   Wed, 20 Sep 2023 07:30:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: arch/m68k/include/asm/raw_io.h:91:13: warning: array subscript 0
 is outside array bounds of 'volatile u16[0]' {aka 'volatile short unsigned
 int[]'}
To:     Rob Herring <robh@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>
References: <202309192013.vI4DKHmw-lkp@intel.com>
 <CAL_JsqJ0BoR7Dan3=oyWPa6HU3YV=eOFTO5fx7u5zz2i=eB-jQ@mail.gmail.com>
 <a57afd40-71a2-aa68-84cb-44d2a88a1e2b@roeck-us.net>
 <CAL_JsqJYPJVTxH=d5nYK78+ZWhZAfh4VhEyBLqzyg4MzMhrX0g@mail.gmail.com>
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAL_JsqJYPJVTxH=d5nYK78+ZWhZAfh4VhEyBLqzyg4MzMhrX0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 05:44, Rob Herring wrote:
> On Tue, Sep 19, 2023 at 6:14 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 9/19/23 11:37, Rob Herring wrote:
>>> On Tue, Sep 19, 2023 at 7:09 AM kernel test robot <lkp@intel.com> wrote:
>>>>
>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>>> head:   2cf0f715623872823a72e451243bbf555d10d032
>>>> commit: f1a43aadb5a690e141a3b6700e2a40c1d4dbe088 watchdog: Enable COMPILE_TEST for more drivers
>>>> date:   5 weeks ago
>>>> config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230919/202309192013.vI4DKHmw-lkp@intel.com/config)
>>>> compiler: m68k-linux-gcc (GCC) 13.2.0
>>>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230919/202309192013.vI4DKHmw-lkp@intel.com/reproduce)
>>>>
>>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>>> the same patch/commit), kindly add following tags
>>>> | Reported-by: kernel test robot <lkp@intel.com>
>>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202309192013.vI4DKHmw-lkp@intel.com/
>>>>
>>>> All warnings (new ones prefixed by >>):
>>>>
>>>>      In file included from arch/m68k/include/asm/io_mm.h:25,
>>>>                       from arch/m68k/include/asm/io.h:8,
>>>>                       from include/linux/io.h:13,
>>>>                       from drivers/watchdog/machzwd.c:39:
>>>>      In function 'zf_set_timer',
>>>>          inlined from 'zf_timer_on' at drivers/watchdog/machzwd.c:218:2:
>>>>>> arch/m68k/include/asm/raw_io.h:91:13: warning: array subscript 0 is outside array bounds of 'volatile u16[0]' {aka 'volatile short unsigned int[]'} [-Warray-bounds=]
>>>>         91 |         __w = ((*(__force volatile u16 *) ((_addr & 0xFFFF0000UL) + ((__v >> 8)<<1)))); \
>>>>            |         ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>      arch/m68k/include/asm/io_mm.h:228:20: note: in expansion of macro 'rom_out_le16'
>>>>        228 |                  : rom_out_le16(isa_itw(port), (val)))
>>>>            |                    ^~~~~~~~~~~~
>>>>      arch/m68k/include/asm/io_mm.h:356:42: note: in expansion of macro 'isa_rom_outw'
>>>>        356 | #define outw(val, port) ((port) < 1024 ? isa_rom_outw((val), (port)) : out_le16((port), (val)))
>>>>            |                                          ^~~~~~~~~~~~
>>>>      drivers/watchdog/machzwd.c:74:53: note: in expansion of macro 'outw'
>>>>         74 | #define zf_writew(port, data)  { outb(port, INDEX); outw(data, DATA_W); }
>>>>            |                                                     ^~~~
>>>>      drivers/watchdog/machzwd.c:173:17: note: in expansion of macro 'zf_writew'
>>>>        173 |                 zf_writew(COUNTER_1, new);
>>>>            |                 ^~~~~~~~~
>>>>      In function 'zf_timer_on':
>>>>      cc1: note: source object is likely at address zero
>>>
>>> This seems to be some newish check in gcc which looks for fixed
>>> pointers below 4KB[1]. The linked issue says more was planned for
>>> gcc-13, but I haven't found what that is. AFAICT, that shouldn't
>>> happen with this config because isa_itw() should be variable and the
>>> compiler shouldn't be able to determine the value of _addr. However, a
>>> config with CONFIG_Q40=n, CONFIG_AMIGA_PCMCIA=n, and
>>> CONFIG_ATARI_ROM_ISA=n would have a fixed NULL value and could trigger
>>> the warning. This should also have warnings everywhere outw() (and
>>> others) are used with a constant port value.
>>>
>>> Rob
>>>
>>> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99578
>>
>> A long time ago, when someone submitted a "cleanup: patch for the machzwd
>> watchdog driver, I approved it but added this comment.
>>
>>   > If anyone is still using the HW supported by this driver, it would
>>   > be a prime target for conversion to use the watchdog subsystem.
>>   > This would reduce code size and improve driver stability.
>>   > _That_ would be useful.
>>
>>   > The only reason for replacing 0 with NULL is to make a static checker
>>   > happy. This kind of change adds zero value to the code. Instead, it
>>   > takes time from those who have to review the patches and apply them.
>>
>>   > If we ignore such patches, we'll get them again and again, taking
>>   > away even more time. If we don't ignore them, we encourage submitters
>>   > and get even more useless patches. If we try to discourage them, we
>>   > risk being accused of being unfriendly. This is a perfect lose-lose
>>   > situation for maintainers.
> 
> Agreed. I keep getting one to fix "of of" in a comment. The fix is
> always to drop an "of", but that's actually wrong because it's
> supposed to be "OF". I keep pointing this out and *never* get the
> right fix. I don't fix it myself because at this point, I find
> continuing to get "fixes" entertaining.
> 
>> I do wonder if enabling BUILD_TEST on such drivers is any better.
> 
> I think that and trivial fixes on a specific driver are completely
> different. If you want to test build one driver, that's not too hard.
> Find its kconfig value, turn it on and build the right arch. For tree
> wide stuff, it's a real pain to ensure you built everything. For
> example, the only way to build many Cavium Octeon drivers is with the
> Octeon defconfig which is just one of dozens configs for MIPS (which
> is still a bigger mess than arm32 ever was).
> 

Sure, but I still argue that this isn't worth it for drivers like this one.
Are you going to submit a fix ? Because otherwise I'll submit a patch
to drop COMPILE_TEST from MACHZ_WDT.

Thanks,
Guenter

