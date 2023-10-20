Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271357D0BFE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376736AbjJTJfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376803AbjJTJfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:35:46 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19318D55
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:35:41 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qtlut-0003Mz-MB; Fri, 20 Oct 2023 11:35:39 +0200
Message-ID: <c9b79a69-bdc1-4457-900d-709a15d99568@leemhuis.info>
Date:   Fri, 20 Oct 2023 11:35:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Blank screen on boot of Linux 6.5 and later on Lenovo ThinkPad
 L570
Content-Language: en-US, de-DE
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Linux Regressions <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jaak Ristioja <jaak@ristioja.ee>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <7c50e051-eba2-09fc-da9f-023d592de457@ristioja.ee>
 <31bdf7b1-0ed9-4217-b459-1d857e53120b@leemhuis.info>
 <CAAhV-H7fRpykesVUEyaTpVnFiGwpP+fPbtdrp6JwfgD=bDp06Q@mail.gmail.com>
 <CAAhV-H7XCmbgS=N4-SE8FnASAws8hnDRZsQJgXE+dwyARaqzNw@mail.gmail.com>
 <ZSO9uArAtsPMPeTP@debian.me>
 <CAAhV-H5GbidUx8YanUc7S9oGqBkDd53xeT=2O4aCuX7KpM-+8A@mail.gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAAhV-H5GbidUx8YanUc7S9oGqBkDd53xeT=2O4aCuX7KpM-+8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1697794542;f9661a6a;
X-HE-SMSGID: 1qtlut-0003Mz-MB
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.10.23 10:54, Huacai Chen wrote:
> On Mon, Oct 9, 2023 at 4:45 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>> On Mon, Oct 09, 2023 at 09:27:02AM +0800, Huacai Chen wrote:
>>> On Tue, Sep 26, 2023 at 10:31 PM Huacai Chen <chenhuacai@kernel.org> wrote:
>>>> On Tue, Sep 26, 2023 at 7:15 PM Linux regression tracking (Thorsten
>>>> Leemhuis) <regressions@leemhuis.info> wrote:
>>>>> On 13.09.23 14:02, Jaak Ristioja wrote:
>>>>>>
>>>>>> Upgrading to Linux 6.5 on a Lenovo ThinkPad L570 (Integrated Intel HD
>>>>>> Graphics 620 (rev 02), Intel(R) Core(TM) i7-7500U) results in a blank
>>>>>> screen after boot until the display manager starts... if it does start
>>>>>> at all. Using the nomodeset kernel parameter seems to be a workaround.
>>>>>>
>>>>>> I've bisected this to commit 60aebc9559492cea6a9625f514a8041717e3a2e4
>>>>>> ("drivers/firmware: Move sysfb_init() from device_initcall to
>>>>>> subsys_initcall_sync").
>>>>>
>>>>> Hmmm, no reaction since it was posted a while ago, unless I'm missing
>>>>> something.
>>>>>
>>>>> Huacai Chen, did you maybe miss this report? The problem is apparently
>>>>> caused by a commit of yours (that Javier applied), you hence should look
>>>>> into this.
>>>> I'm sorry but it looks very strange, could you please share your config file?
>>> As confirmed by Jaak, disabling DRM_SIMPLEDRM makes things work fine
>>> again. So I guess the reason:
>>
>> Did Jaak reply privately? It should have been disclosed in public
>> ML here instead.
> Yes, he replied privately, and disabling DRM_SIMPLEDRM was suggested by me.

Well, this to me still looks a lot (please correct me if I'm wrong) like
regression that should be fixed, as DRM_SIMPLEDRM was enabled beforehand
if I understood things correctly. Or is there a proper fix for this
already in the works and I just missed this? Or is there some good
reason why this won't/can't be fixed?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

>>> When SIMPLEDRM takes over the framebuffer, the screen is blank (don't
>>> know why). And before 60aebc9559492cea6a9625f ("drivers/firmware: Move
>>> sysfb_init() from device_initcall to subsys_initcall_sync") there is
>>> no platform device created for SIMPLEDRM at early stage, so it seems
>>> also "no problem".
>>
>> I don't understand above. You mean that after that commit the platform
>> device is also none, right?
> No. The SIMPLEDRM driver needs a platform device to work, and that
> commit makes the platform device created earlier. So, before that
> commit, SIMPLEDRM doesn't work, but the screen isn't blank; after that
> commit, SIMPLEDRM works, but the screen is blank.
> 
> Huacai
>>
>> Confused...
>>
>> --
>> An old man doll... just what I always wanted! - Clara
> 
> 
