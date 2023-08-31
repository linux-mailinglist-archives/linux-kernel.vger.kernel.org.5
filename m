Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D5678EB3F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344291AbjHaLAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbjHaLAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:00:48 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF7CE6E;
        Thu, 31 Aug 2023 04:00:30 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qbfPY-0008MK-Ec; Thu, 31 Aug 2023 13:00:28 +0200
Message-ID: <c362089e-8cdb-c735-762f-7a56552b68c2@leemhuis.info>
Date:   Thu, 31 Aug 2023 13:00:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: in linux 6.3.7-200.fc38.x86_64 goes vlc in time to switch tv
 channels to zombie-process
Content-Language: en-US, de-DE
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media <linux-media@vger.kernel.org>,
        Linux Stable <stable@vger.kernel.org>
References: <a7f997fc-e7cc-cf67-3ac0-80ed30346511@gmail.com>
 <cdacb249-9d1d-cad9-44a9-ffa7b4b5b887@leemhuis.info>
 <150a5670-8220-5c2f-351c-181ceeddf307@xs4all.nl>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <150a5670-8220-5c2f-351c-181ceeddf307@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1693479631;0bc01999;
X-HE-SMSGID: 1qbfPY-0008MK-Ec
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.08.23 12:35, Hans Verkuil wrote:
> On 31/08/2023 11:26, Linux regression tracking #update (Thorsten Leemhuis) wrote:
>> [TLDR: This mail in primarily relevant for Linux kernel regression
>> tracking. See link in footer if these mails annoy you.]
>>
>> On 19.06.23 02:24, Bagas Sanjaya wrote:
>>>
>>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>> [...]
>>>
>>> #regzbot introduced: v6.3.5..v6.3.7 https://bugzilla.kernel.org/show_bug.cgi?id=217566
>>> #regzbot title: switching TV channel causes VLC and firmware loading hang
>>
>> #regzbot fix: 7cfab4c9dc09ca3a9d57c187894055a22bdcd
>> #regzbot ignore-activity
>>
>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>> --
>> Everything you wanna know about Linux kernel regression tracking:
>> https://linux-regtracking.leemhuis.info/about/#tldr
>> That page also explains what to do if mails like this annoy you.
> 
>>From what I can gather from the bugzilla report, whatever the issue was appears
> to be resolved or at least improved in later kernels.

I'm pretty (but not 100%) sure the initial report in that ticket were
issues caused by a backport of a patch that was reverted later:
https://lore.kernel.org/all/20230609082238.3671398-1-mchehab@kernel.org/

The versions when the problems started and some feedback in the ticket
when things started working again (like
https://bugzilla.kernel.org/show_bug.cgi?id=217566#c15 – 6.3.9 was when
the revert came to 6.3.y) are strong indicators for that.

But yes, more people showed up in the ticket with problems that might or
might not be related to the initial problem and things got confusing. I
told them to report those problems separately. Ideally somebody would
look into that and check if they did, yes, but I chose to ignore things
at that point, as regression tracking is quite hard already and I have
to draw lines somewhere. I often hate that, but otherwise I don't get
much work done. :-/

Ciao, Thorsten
