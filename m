Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084C07FAF61
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 02:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjK1BCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 20:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjK1BCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 20:02:51 -0500
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561C1C2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 17:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1701133366;
        bh=gYIr0fLGl0A0yMUGkiXP9kYqWmnfeW6NULr2PpdUPrs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=CZjEcZjUxqGAzw+vIpTgyfIQIAX3MaTpmswwcHJF/zHbI+noMygCDBDMJA4VftPZN
         yPaq//cNLQ1HB3nnrcSdxK3yPYEuYxfD7C01CCn374jaK2CsRds9y75lfSXzN3A6pM
         d68cjoPmtnk4eoXUa+J+U+z81bSk/QVGKk/e8ZgE=
Received: from [10.56.52.5] ([39.156.73.12])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id A9882EF; Tue, 28 Nov 2023 09:02:41 +0800
X-QQ-mid: xmsmtpt1701133361t39mf7s0h
Message-ID: <tencent_44E22E4955685EFF479910090D5C84E8B209@qq.com>
X-QQ-XMAILINFO: OaoBA5NOFC/jOVj7yUQgbw3gi+1HeI4r6RzUUXcFdsuuF0M9wglOSEJSLO6sAw
         wuVnc7r9ylrhXP5QDntpHtKoSIeqiZ5P/u/eMwNCf42EezroieDc4+ZJ0aCI3LPsTygcc0vcz90u
         2Uh/buCN5I1biC3suEs3+fjyxVew9eDOAXVpwbD3AApc8mN3oaRFhZz8Kp0n/7DftREPnYKsfO2G
         XMMVMryq7mRpOJWLo7NHxGt0ycYjxjExE8pCysiqMKaekewlyxebbQvjo6P+7NpaNDQlxmhpIfMB
         W2WnUoy4/8Knc9WmIaeniT1WsHJjbt2OlYkNMRuCxpk89f1c327ZPJ/CZpayaoN1xAHas8buAw01
         NzHCii/yU+DKGrEwGW+mp99t6W3KUXRcR1ST9tCfWtZ4VIj5waDGhPmCy9QQiQqBgGQ+Z3WXsyDR
         GaO2RU2q/JdCpWFjZXrZHnPAMvvUi1nYOA9rxsU92WoqRSpimqj1GrpRALRqT8Z0f9yWvfMpbc4w
         u1jcAGTsPQ9eNMWuaH/5lnY1T2FUa/fTvfT4AmbHpuG6Qa1lkqBJ1Z3tpIC6JJeMQFzNtUIsNy/e
         H0WNjrqIyBaMBdk7bP0dKpJNj9KSq/SdgmfBy6NaxzukSrFeIGkOyYdkXU7echOiF3q6QEGbc0EU
         X2eynoOJzC9lp2cqEQS7qI38slQXXj4AD71CMYwAMExOx7uJRQG6glf9tGLKVPSUUjQHLuX+Czmp
         yMOxfRh555Qqq7fRkaZn7xpUITrBFRwjI8iqPq+8b6VkuZC/YWrPmOtVtkBHMuywwboEwPGc/bBY
         jwsW83iZCNchHC3FxaMSAAO1w+Kf25tAz4A9TLS18ouWGEjdwUlptABC/McXc36gal1ZsA2qeS8W
         JVZ2meVBTrjQNYKCNTnFX7l058D5JZE5QbR2HAqOH2Xj1XKmjjEh+B9EFJr/enIP6xspQUeHdnjT
         bzgRyAyVF2cggCpxiUC8HdnFcRmz0r6gu1FLIf7cez3/LTDdP3GQ==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-OQ-MSGID: <d9a8441e-c0af-4b60-a9d6-f54592e76cce@foxmail.com>
Date:   Tue, 28 Nov 2023 09:02:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] prctl: Get private anonymous memory region name
To:     David Hildenbrand <david@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Chiu <andy.chiu@sifive.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Stefan Roesch <shr@devkernel.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>, rongtao@cestc.cn
References: <tencent_77E0BC1E8E9A21CA1B9009DD66555C72A90A@qq.com>
 <20231126135644.GA7199@redhat.com>
 <b2f4c084-47dc-4e92-a9e3-daec3f48425d@redhat.com>
Content-Language: en-US
From:   Rong Tao <rtoax@foxmail.com>
In-Reply-To: <b2f4c084-47dc-4e92-a9e3-daec3f48425d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/27/23 22:52, David Hildenbrand wrote:
> On 26.11.23 14:56, Oleg Nesterov wrote:
>> On 11/26, Rong Tao wrote:
>>>
>>> then the PR_GET_VMA interface should be provided accordingly,
>>> which is necessary, as the userspace program usually wants to know what
>>> VMA name it has configured for the anonymous page.
>>
>> I don't really understand the use-case for PR_GET_VMA ...
>>
>
> Can't we simply read "/proc/PID/maps" and just have that information 
> from there?


Thank you, David.

The relationship between PR_GET_VMA and /proc/PID/maps is like the 
relationship between

PR_GET_NAME and /proc/PID/comm. Obviously, both methods can obtain the 
corresponding

name. However, prctl(2) can be obtained directly from the code level, 
while reading proc is not

so convenient and efficient. Moreover, reading proc is more like bash 
command line, rather

than C code.


>
> Also, I don't understand the exact use case, that should be clarified 
> -- especially, why the existing way is insufficient.
>

For use-case, in fact, I now want to develop a user-mode patch tool and 
need to map the patch file to the target

process(Use ptrace(2) and pread/pwrite("/proc/self/mem")). I initially 
used shared files

     00400000-00401000 r--p 00000000 08:00 241933181 
/home/sda/git-repos/upatch/tests/hello/hello
     00401000-00402000 r-xp 00001000 08:00 241933181 
/home/sda/git-repos/upatch/tests/hello/hello
     00402000-00403000 r--p 00002000 08:00 241933181 
/home/sda/git-repos/upatch/tests/hello/hello
     00403000-00404000 r--p 00002000 08:00 241933181 
/home/sda/git-repos/upatch/tests/hello/hello
     00404000-00405000 rw-p 00003000 08:00 241933181 
/home/sda/git-repos/upatch/tests/hello/hello
     01136000-01157000 rw-p 00000000 00:00 0 [heap]
     7f21472c0000-7f21472c2000 rw-p 00000000 00:00 0
     7f21472c2000-7f21472e8000 r--p 00000000 103:03 3705 
/usr/lib64/libc.so.6
     7f21472e8000-7f2147448000 r-xp 00026000 103:03 3705 
/usr/lib64/libc.so.6
     7f2147448000-7f2147496000 r--p 00186000 103:03 3705 
/usr/lib64/libc.so.6
     7f2147496000-7f214749a000 r--p 001d3000 103:03 3705 
/usr/lib64/libc.so.6
     7f214749a000-7f214749c000 rw-p 001d7000 103:03 3705 
/usr/lib64/libc.so.6
     7f214749c000-7f21474a6000 rw-p 00000000 00:00 0
     7f21474be000-7f21474bf000 rwxs 00000000 00:27 7794 
/tmp/upatch/62984/map_files/patch-FKSYTp   <<
     7f21474bf000-7f21474c0000 rwxs 00000000 00:27 7793 
/tmp/upatch/62984/map_files/patch-KFaQNU <<
     7f21474c0000-7f21474c1000 r--p 00000000 103:03 3702 
/usr/lib64/ld-linux-x86-64.so.2
     7f21474c1000-7f21474e8000 r-xp 00001000 103:03 3702 
/usr/lib64/ld-linux-x86-64.so.2
     7f21474e8000-7f21474f2000 r--p 00028000 103:03 3702 
/usr/lib64/ld-linux-x86-64.so.2
     7f21474f2000-7f21474f4000 r--p 00031000 103:03 3702 
/usr/lib64/ld-linux-x86-64.so.2
     7f21474f4000-7f21474f6000 rw-p 00033000 103:03 3702 
/usr/lib64/ld-linux-x86-64.so.2
     7ffec158b000-7ffec15ad000 rw-p 00000000 00:00 0 [stack]
     7ffec15cf000-7ffec15d3000 r--p 00000000 00:00 0 [vvar]
     7ffec15d3000-7ffec15d5000 r-xp 00000000 00:00 0 [vdso]
     ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0 [vsyscall]

However, this is obviously not the best approach, I want to use 
anonymous pages instead,

     7f21474be000-7f21474bf000 rwxp 00000000 00:27 7794 [anon:patch1]
     7f21474bf000-7f21474c0000 rwxp 00000000 00:27 7793 [anon:patch2]

I hope to use the address to directly obtain the vma name, which is 
"patch1". This is very convenient

in the program without parsing /proc/PID/maps in the source code.

Thanks again.

Rong Tao



