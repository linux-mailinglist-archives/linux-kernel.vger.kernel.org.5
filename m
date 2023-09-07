Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC9F796F55
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 05:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237190AbjIGDkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 23:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjIGDkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 23:40:41 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A3811B;
        Wed,  6 Sep 2023 20:40:37 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qe5sg-0001c0-SR; Thu, 07 Sep 2023 05:40:34 +0200
Message-ID: <f8588a24-85aa-405e-bd4d-7a570f69fe4c@leemhuis.info>
Date:   Thu, 7 Sep 2023 05:40:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible bug report: kernel 6.5.0/6.5.1 high load when CIFS share
 is mounted (cifsd-cfid-laundromat in"D" state)
Content-Language: en-US, de-DE
To:     Linux CIFS <linux-cifs@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <CAO+kfxTwOvaxYV0ZRESxZB-4LHsF9b_VBjAKahhwUm5a1_c4ug@mail.gmail.com>
 <ZPfPfyIoVxw5L6El@debian.me>
 <CAO+kfxQgXOsx6u+xLKGJe0KDiFsRAGstSpnrwxjQF6udgz5HFQ@mail.gmail.com>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAO+kfxQgXOsx6u+xLKGJe0KDiFsRAGstSpnrwxjQF6udgz5HFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1694058037;6fb4caec;
X-HE-SMSGID: 1qe5sg-0001c0-SR
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 06.09.23 23:03, Brian Pardy wrote:
> Added committer Ronnie Sahlberg to CC.
> 
> On Tue, Sep 5, 2023 at 9:01 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>> On Tue, Sep 05, 2023 at 01:09:05PM -0400, Brian Pardy wrote:
>>> I've noticed an issue with the CIFS client in kernel 6.5.0/6.5.1 that
>>> does not exist in 6.4.12 or other previous kernels (I have not tested
>>> 6.4.13). Almost immediately after mounting a CIFS share, the reported
>>> load average on my system goes up by 2. At the time this occurs I see
>>> two [cifsd-cfid-laundromat] kernel threads running the "D" state,
>>> where they remain for the entire time the CIFS share is mounted. The
>>> load will remain stable at 2 (otherwise idle) until the share is
>>> unmounted, at which point the [cifsd-cfid-laundromat] threads
>>> disappear and load drops back down to 0. This is easily reproducible
>>> on my system, but I am not sure what to do to retrieve more useful
>>> debugging information. If I mount two shares from this server, I get
>>> four laundromat threads in "D" state and a sustained load average of
>>> 4.
> [...]
> 
> Thank you for directing me to the bug-bisect documentation. Results below:
> 
> # git bisect bad
> d14de8067e3f9653cdef5a094176d00f3260ab20 is the first bad commit
>

#regzbot ^introduced: d14de8067e3f9653cdef5a094176d00f3260a
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

