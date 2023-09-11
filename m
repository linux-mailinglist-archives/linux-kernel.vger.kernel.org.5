Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4546F79AF9F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbjIKUsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236273AbjIKKFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:05:46 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19C2E68
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 03:05:41 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qfdnT-0005NQ-Cf; Mon, 11 Sep 2023 12:05:35 +0200
Message-ID: <859c6dde-37ad-492e-baa0-4ea100d8381f@leemhuis.info>
Date:   Mon, 11 Sep 2023 12:05:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Makefile.compiler: replace cc-ifversion with
 compiler-specific macros
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Shreeya Patel <shreeya.patel@collabora.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Maksim Panchenko <maks@meta.com>,
        =?UTF-8?Q?Ricardo_Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Bill Wendling <morbo@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "gustavo.padovan@collabora.com" <gustavo.padovan@collabora.com>,
        Guillaume Charles Tucker <guillaume.tucker@collabora.com>,
        denys.f@collabora.com, Nick Desaulniers <ndesaulniers@google.com>,
        kernelci@lists.linux.dev,
        Collabora Kernel ML <kernel@collabora.com>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
References: <CAKwvOd=4hBcU4fAkddU0b-GOZc9FzTZoj3PFW6ZZrX0jS8x+bg@mail.gmail.com>
 <878rdlk9bi.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
 <CAKwvOd=8LVU+iANkFx18Wm1jg7gYiAXovAmo9t5ZZaVdMULn-Q@mail.gmail.com>
 <875y8ok9b5.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
 <CAKwvOdmJJibt6sHSp91v2s7BxUWBC6xG7F7+3C6gUxNMzZ2xRA@mail.gmail.com>
 <87353ok78h.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
 <2023052247-bobtail-factsheet-d104@gregkh>
 <CAKwvOd=2zAV_mizvzLFdyHE_4OzBY5OVu6KLWuQPOMZK37vsmQ@mail.gmail.com>
 <cff33e12-3d80-7e62-1993-55411ccabc01@collabora.com>
 <CAKwvOd=F29-UkNO7FtUWpVV=POOZLb6QgD=mhLMWtRfkRSSi2A@mail.gmail.com>
 <a037a08c-44c4-24e8-1cba-7e4e8b21ffaa@collabora.com>
 <CAK7LNAS8Y9syCiHMO2r75D6hgCSsDDvJ_=VMKpYqjondnbSZjw@mail.gmail.com>
 <267b73d6-8c4b-40d9-542d-1910dffc3238@leemhuis.info>
 <2833d0db-f122-eccd-7393-1f0169dc0741@collabora.com>
 <26aa6f92-2376-51a4-bbdc-abbbd62c23d2@leemhuis.info>
In-Reply-To: <26aa6f92-2376-51a4-bbdc-abbbd62c23d2@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1694426741;a3f6a17f;
X-HE-SMSGID: 1qfdnT-0005NQ-Cf
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.08.23 13:28, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 11.07.23 13:16, Shreeya Patel wrote:
>> On 10/07/23 17:39, Linux regression tracking (Thorsten Leemhuis) wrote:
>>> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
>>> for once, to make this easily accessible to everyone.
>>>
>>> Shreeya Patel, Masahiro Yamada: what's the status of this? Was any
>>> progress made to address this? Or is this maybe (accidentally?) fixed
>>> with 6.5-rc1?
>>
>> I still see the regression happening so it doesn't seem to be fixed.
>> https://linux.kernelci.org/test/case/id/64ac675a8aebf63753bb2a8c/
>>
>> Masahiro had submitted a fix for this issue here.
>>
>> https://lore.kernel.org/lkml/ZJEni98knMMkU%2Fcl@buildd.core.avm.de/T/#t
>>
>> But I don't see any movement there. Masahiro, are you planning to send a
>> v2 for it?
> 
> That was weeks ago and we didn't get a answer. :-/ Was this fixed in
> between? Doesn't look like it from here, but I might be missing something.

Still no reply. :-/

Shreeya Patel, does the problem still happen with 6.6-rc1 and do you
still want to see it fixed? In that case our only option to get things
rolling again might be to involve Linus, unless someone in the CC list
has a idea to resolve this. Might also be good to know if reverting the
culprit fixes the problem.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

>>> On 20.06.23 06:19, Masahiro Yamada wrote:
>>>> On Mon, Jun 12, 2023 at 7:10 PM Shreeya Patel
>>>> <shreeya.patel@collabora.com> wrote:
>>>>> On 24/05/23 02:57, Nick Desaulniers wrote:
>>>>>> On Tue, May 23, 2023 at 3:27 AM Shreeya Patel
>>>>>> <shreeya.patel@collabora.com> wrote:
>>>>>>> Hi Nick and Masahiro,
>>>>>>>
>>>>>>> On 23/05/23 01:22, Nick Desaulniers wrote:
>>>>>>>> On Mon, May 22, 2023 at 9:52 AM Greg KH
>>>>>>>> <gregkh@linuxfoundation.org> wrote:
>>>>>>>>> On Mon, May 22, 2023 at 12:09:34PM +0200, Ricardo Cañuelo wrote:
>>>>>>>>>> On vie, may 19 2023 at 08:57:24, Nick Desaulniers
>>>>>>>>>> <ndesaulniers@google.com> wrote:
>>>>>>>>>>> It could be; if the link order was changed, it's possible that
>>>>>>>>>>> this
>>>>>>>>>>> target may be hitting something along the lines of:
>>>>>>>>>>> https://isocpp.org/wiki/faq/ctors#static-init-order i.e. the
>>>>>>>>>>> "static
>>>>>>>>>>> initialization order fiasco"
>>>>>>>>>>>
>>>>>>>>>>> I'm struggling to think of how this appears in C codebases, but I
>>>>>>>>>>> swear years ago I had a discussion with GKH (maybe?) about
>>>>>>>>>>> this. I
>>>>>>>>>>> think I was playing with converting Kbuild to use Ninja rather
>>>>>>>>>>> than
>>>>>>>>>>> Make; the resulting kernel image wouldn't boot because I had
>>>>>>>>>>> modified
>>>>>>>>>>> the order the object files were linked in.  If you were to
>>>>>>>>>>> randomly
>>>>>>>>>>> shuffle the object files in the kernel, I recall some hazard
>>>>>>>>>>> that may
>>>>>>>>>>> prevent boot.
>>>>>>>>>> I thought that was specifically a C++ problem? But then again, the
>>>>>>>>>> kernel docs explicitly say that the ordering of obj-y goals in
>>>>>>>>>> kbuild is
>>>>>>>>>> significant in some instances [1]:
>>>>>>>>> Yes, it matters, you can not change it.  If you do, systems will
>>>>>>>>> break.
>>>>>>>>> It is the only way we have of properly ordering our init calls
>>>>>>>>> within
>>>>>>>>> the same "level".
>>>>>>>> Ah, right it was the initcall ordering. Thanks for the reminder.
>>>>>>>>
>>>>>>>> (There's a joke in there similar to the use of regexes to solve a
>>>>>>>> problem resulting in two new problems; initcalls have levels for
>>>>>>>> ordering, but we still have (unexpressed) dependencies between calls
>>>>>>>> of the same level; brittle!).
>>>>>>>>
>>>>>>>> +Maksim, since that might be relevant info for the BOLT+Kernel work.
>>>>>>>>
>>>>>>>> Ricardo,
>>>>>>>> https://elinux.org/images/e/e8/2020_ELCE_initcalls_myjosserand.pdf
>>>>>>>> mentions that there's a kernel command line param `initcall_debug`.
>>>>>>>> Perhaps that can be used to see if
>>>>>>>> 5750121ae7382ebac8d47ce6d68012d6cd1d7926 somehow changed initcall
>>>>>>>> ordering, resulting in a config that cannot boot?
>>>>>>> Here are the links to Lava jobs ran with initcall_debug added to the
>>>>>>> kernel command line.
>>>>>>>
>>>>>>> 1. Where regression happens
>>>>>>> (5750121ae7382ebac8d47ce6d68012d6cd1d7926)
>>>>>>> https://lava.collabora.dev/scheduler/job/10417706
>>>>>>> <https://lava.collabora.dev/scheduler/job/10417706>
>>>>>>>
>>>>>>> 2. With a revert of the commit
>>>>>>> 5750121ae7382ebac8d47ce6d68012d6cd1d7926
>>>>>>> https://lava.collabora.dev/scheduler/job/10418012
>>>>>>> <https://lava.collabora.dev/scheduler/job/10418012>
>>>>>> Thanks!
>>>>>>
>>>>>> Yeah, I can see a diff in the initcall ordering as a result of
>>>>>> commit 5750121ae738 ("kbuild: list sub-directories in ./Kbuild")
>>>>>>
>>>>>> https://gist.github.com/nickdesaulniers/c09db256e42ad06b90842a4bb85cc0f4
>>>>>>
>>>>>> Not just different orderings, but some initcalls seem unique to the
>>>>>> before vs. after, which is troubling. (example init_events and
>>>>>> init_fs_sysctls respectively)
>>>>>>
>>>>>> That isn't conclusive evidence that changes to initcall ordering are
>>>>>> to blame, but I suspect confirming that precisely to be very very time
>>>>>> consuming.
>>>>>>
>>>>>> Masahiro, what are your thoughts on reverting 5750121ae738? There are
>>>>>> conflicts in Kbuild and Makefile when reverting 5750121ae738 on
>>>>>> mainline.
>>>>> I'm not sure if you followed the conversation but we are still seeing
>>>>> this regression with the latest kernel builds and would like to know if
>>>>> you plan to revert 5750121ae738?
>>>>
>>>> Reverting 5750121ae738 does not solve the issue
>>>> because the issue happens even before 5750121ae738.
>>>> multi_v7_defconfig + debug.config + CONFIG_MODULES=n
>>>> fails to boot in the same way.
>>>>
>>>> The revert would hide the issue on a particular build setup.
>>>>
>>>>
>>>> I submitted a patch to more pin-point the issue.
>>>> Let's see how it goes.
>>>> https://lore.kernel.org/lkml/ZJEni98knMMkU%2Fcl@buildd.core.avm.de/T/#t
>>>>
>>>>
>>>> (BTW, the initcall order is unrelated)
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>>
>>>>> Thanks,
>>>>> Shreeya Patel
>>>>>
>>>>>>> Thanks,
>>>>>>> Shreeya Patel
>>>>>>>
>>>> -- 
>>>> Best Regards
>>>> Masahiro Yamada
>>>>
>>>>
>>
>>
