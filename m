Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439C77A33C5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 07:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjIQFDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 01:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjIQFDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 01:03:35 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AED4196;
        Sat, 16 Sep 2023 22:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1694926976; x=1695531776; i=deller@gmx.de;
 bh=cb3+ZF/rV4lwk1B1qRxD0kTjy/De7HPOSvC2jWQ0MzQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=bkGTLOwJ6+u3KncVFviIhQH1gSOQa23v2bH93POlk+8kQa1fdLpMyefhwCe9EhXsFgJDZJS20EY
 bycUR7epK5mwp91vbOzFPbx2GBQYyEYGDEBXT8HHwL35f0pNc0Vbwcft5KEAid+XhdxpEkrcqZGpq
 eKXxk0qwbFR4t2/51NbrRMPu2Y9Qn8HmiRgMUFp72Lck3JVysMAGR2gOwhifsWhUPNlrud2MJ4/Z0
 EW/mWrsW9EM+sH8d9mCmFRHkYaJOIR1cbe7fbkxmCWzn9cMVI8DPoX3nsqNcerrD9Zsb6MG1BfAuj
 RSexj0VnMMQxu6YU6havyNL6mpt/RgkZ2nvQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.149.71]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mw9QC-1rXN7E0k4K-00s7eF; Sun, 17
 Sep 2023 07:02:56 +0200
Message-ID: <3ee4b922-7686-ec20-f280-48c06bff09cf@gmx.de>
Date:   Sun, 17 Sep 2023 07:02:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Possible 6.5 regression: Huge values for "commited memory"
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux PARISC <linux-parisc@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Michael Labiuk <michael.labiuk@virtuozzo.com>,
        Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
References: <1694366957@msgid.manchmal.in-ulm.de> <ZQWUzwiKWLk79qbp@debian.me>
 <CAHk-=wh29JJSVGyJM7ubxOs51-Nxp6YnmU9Bw1gdOk3rrQ_0mg@mail.gmail.com>
 <CAHk-=wjrEjaUw3oFVEYpF=AWAwrSM3sQTQHuPfFjFdQsvQxHeg@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <CAHk-=wjrEjaUw3oFVEYpF=AWAwrSM3sQTQHuPfFjFdQsvQxHeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uIHbs1szNnWp90sKUPbPA52puQA4EtPReKI1kZ/IIhX2E8llQlo
 Pcb0RDVxaJG9khkqX/rLPIha0TWkVY68z/dIH0M+Cx85kD3BUwTna+dn6z8tFlm6pNdqDFc
 oUpvgo+nW37eTA4GiZkVv1utzXhTaugpQfdyS5ndfle07vN1cQ4OrVPnjb7+BviTDDpIE6v
 M2w2TS9YEfU4byH3IIajg==
UI-OutboundReport: notjunk:1;M01:P0:TVFLNApSMFc=;Q9CDIMEE65QafXNmvrGsy35E7g/
 v5/2DAwP3hrQCCZnrjprA8UieqDCv3G6u9w44f9K8QXiBy4K16Ce0oXY24weGjattJXOIc8XY
 tsC45Hc9nxd52OVEY0bCtbA4B7n+Wu9vRBa9TjPSc41b25I/RcKeKY3uoNMyO0HNdBtO8kz3q
 D0dUAl8PSpMs9kcywU5nwUg36e9Ch3QrbLa5BYvhnxXJOdGsg5P18bxpzyQmLZIJ051w0f1Si
 MhQMeTHR0wt8QrZFgA8s35m1HflYPGBjFsZF5Pzbf9lrGQ1hsaxoK1aUYXZwoc/Jl40QXKscX
 NoqVVsHBrNVg0AJIBaBURGXZttuQk+FLiZqeVnLsk+gWlsGG0X5kx9HcFn6vSmZSim4H95qtq
 qBJ+yK8Dq1d2yqMjbogyVw7XymXMdaZbdgULho6w6NqpDhlXfgSBgvWW1Rezdj3+WLtAqclJ3
 eROwhwGLM+GRdR+yqNmUq7Uo0iiRQBVxzuHNvckG4lF4qBTu2VMVt9+7N0vBuzhZVyiUCcpOJ
 wAOnUcTUfd5M9PZS4V3G1IW13+qQ9ecpKOm5OOYfuFL8S10HUW+T1Gcxji/8xRKDKWMsZsEUV
 QL16HEasISzHmf5J+KT23JUKje8qUrYffYalHdq5wX3xzBn5GtGyoXDnlP5CJFInhIFKhIW1t
 OAxgiotBcw4DuYVDo5aRgOOM/CIjxv8Y5xNSJcBBZyU1ijmomc8bTeEIF+g+C4L6/4Qi3VS1M
 8hTquv988qqIpwLvtp1jMO/yTGyq2yakH2QFTWmGgNfksaWzr36S5TeZHEwB7TGpBY/PCMTO4
 RpKwoekPAvosQuFoFYi7lLA9Ex3FPHXilAhxQhyoZUyRs39MV85Vk3UfVU19aC8frBRNZIIQf
 SsGi9xBoEUfMSLmdHBhc8uxzfOac8JC3zZXz+hLDG7vk4yDjkbBo1D0S0ClYyf+FBUJ9FAuK5
 WsS74RnkzFLtEUcCTFa+ofkGIWY=
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg & Sasha,

can you please queue-up this upstream patch for kernel v6.5-stable ?

commit 3cec50490969afd4a76ccee441f747d869ccff77
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat Sep 16 12:31:42 2023 -0700

     vm: fix move_vma() memory accounting being off

Thanks,
Helge


On 9/16/23 23:17, Linus Torvalds wrote:
> On Sat, 16 Sept 2023 at 12:31, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Does the attached patch fix the problem?
>
> So while I didn't confirm the fix myself, I'm pretty sure that was it.
> Getting the return value wrong would cause an incorrect extra
> vm_acct_memory() call in the non-error case when VM_ACCOUNT is set
> (and mean the loss of one in the error case, but the error case never
> happens in practice).
>
> Which then causes 'vm_committed_as' to grow when it shouldn't, and
> causes exactly that "Committed_AS" in /proc/meminfo to be off.
>
> So here's the same patch, but now with a proper commit message etc.
>
> I haven't pushed it out (because it would be lovely to get a
> "Tested-by" for it, and that will make the commit ID change), but I'll
> probably do so later today, with or without confirmation, because it
> does seem to be the problem.
>
>                Linus

