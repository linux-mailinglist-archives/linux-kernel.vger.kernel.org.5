Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7D27DA6A1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 13:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjJ1LGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 07:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjJ1LG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 07:06:27 -0400
Received: from mx1.heh.ee (heh.ee [213.35.143.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435E1D3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 04:06:22 -0700 (PDT)
Received: from [10.0.0.254] (unknown [10.0.0.254])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mx1.heh.ee (Hehee) with ESMTPSA id 88C9117539A;
        Sat, 28 Oct 2023 14:06:18 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ristioja.ee; s=mail;
        t=1698491179; bh=4gvW78IHy8ev5r7e3lZyiKImvCAnrOq76Ek/0UVWPto=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=rmcydujisQ3TPT8fXPSKQpP8L63jNM4lW/bpYb0KZ7tJxM4YjGMi+rtD0A2WSQmrb
         KM0X6ibt1/EzxQfWZxozyijoUegesYIs7m4wJTMSkdo67H+QJOedl/1TnTCPxAhk0J
         vvwL7eH8gbLauWooHwuBAi4GSK18pf2jhXx3nu9A=
Message-ID: <c3bb7983-86e4-424e-aadd-e82a0cb6ef37@ristioja.ee>
Date:   Sat, 28 Oct 2023 14:06:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Blank screen on boot of Linux 6.5 and later on Lenovo ThinkPad
 L570
Content-Language: et-EE
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Evan Preston <x.arch@epreston.net>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
 <c9b79a69-bdc1-4457-900d-709a15d99568@leemhuis.info>
 <CAAhV-H4qQW_fOdkTxmT1xbvo4LOapzw_tOw7Kma47xmh0PvpPA@mail.gmail.com>
 <ZTWoDSPxGO-ApR4r@P70.localdomain>
 <82f1b533-3bd8-4418-843a-718d9a6b5786@leemhuis.info>
 <CAAhV-H5DH3Oj3ttSpa_k6jUdZ+0_pMwgoaqUTGGFr46j7DMXRw@mail.gmail.com>
 <ba16ad66-4b35-4fb4-b4e6-1d785f260eea@ristioja.ee>
 <CAAhV-H64AKdGoHnVLLOYXznpr_aq1jC_TUYXFQRdOjoBxanxkw@mail.gmail.com>
From:   Jaak Ristioja <jaak@ristioja.ee>
Autocrypt: addr=jaak@ristioja.ee; keydata=
 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
In-Reply-To: <CAAhV-H64AKdGoHnVLLOYXznpr_aq1jC_TUYXFQRdOjoBxanxkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.10.23 03:58, Huacai Chen wrote:
> Hi, Jaak,
> 
> On Thu, Oct 26, 2023 at 2:49 AM Jaak Ristioja <jaak@ristioja.ee> wrote:
>>
>> On 25.10.23 16:23, Huacai Chen wrote:
>>> On Wed, Oct 25, 2023 at 6:08 PM Thorsten Leemhuis
>>> <regressions@leemhuis.info> wrote:
>>>>
>>>> Javier, Dave, Sima,
>>>>
>>>> On 23.10.23 00:54, Evan Preston wrote:
>>>>> On 2023-10-20 Fri 05:48pm, Huacai Chen wrote:
>>>>>> On Fri, Oct 20, 2023 at 5:35 PM Linux regression tracking (Thorsten
>>>>>> Leemhuis) <regressions@leemhuis.info> wrote:
>>>>>>> On 09.10.23 10:54, Huacai Chen wrote:
>>>>>>>> On Mon, Oct 9, 2023 at 4:45 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>>>>>>>> On Mon, Oct 09, 2023 at 09:27:02AM +0800, Huacai Chen wrote:
>>>>>>>>>> On Tue, Sep 26, 2023 at 10:31 PM Huacai Chen <chenhuacai@kernel.org> wrote:
>>>>>>>>>>> On Tue, Sep 26, 2023 at 7:15 PM Linux regression tracking (Thorsten
>>>>>>>>>>> Leemhuis) <regressions@leemhuis.info> wrote:
>>>>>>>>>>>> On 13.09.23 14:02, Jaak Ristioja wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> Upgrading to Linux 6.5 on a Lenovo ThinkPad L570 (Integrated Intel HD
>>>>>>>>>>>>> Graphics 620 (rev 02), Intel(R) Core(TM) i7-7500U) results in a blank
>>>>>>>>>>>>> screen after boot until the display manager starts... if it does start
>>>>>>>>>>>>> at all. Using the nomodeset kernel parameter seems to be a workaround.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I've bisected this to commit 60aebc9559492cea6a9625f514a8041717e3a2e4
>>>>>>>>>>>>> ("drivers/firmware: Move sysfb_init() from device_initcall to
>>>>>>>>>>>>> subsys_initcall_sync").
>>>>>>>>>>>>
>>>>>>>>>> As confirmed by Jaak, disabling DRM_SIMPLEDRM makes things work fine
>>>>>>>>>> again. So I guess the reason:
>>>>>>>
>>>>>>> Well, this to me still looks a lot (please correct me if I'm wrong) like
>>>>>>> regression that should be fixed, as DRM_SIMPLEDRM was enabled beforehand
>>>>>>> if I understood things correctly. Or is there a proper fix for this
>>>>>>> already in the works and I just missed this? Or is there some good
>>>>>>> reason why this won't/can't be fixed?
>>>>>>
>>>>>> DRM_SIMPLEDRM was enabled but it didn't work at all because there was
>>>>>> no corresponding platform device. Now DRM_SIMPLEDRM works but it has a
>>>>>> blank screen. Of course it is valuable to investigate further about
>>>>>> DRM_SIMPLEDRM on Jaak's machine, but that needs Jaak's effort because
>>>>>> I don't have a same machine.
>>>>
>>>> Side note: Huacai, have you tried working with Jaak to get down to the
>>>> real problem? Evan, might you be able to help out here?
>>> No, Jaak has no response after he 'fixed' his problem by disabling SIMPLEDRM.
>>>
>>
>> I'm sorry, what was it exactly you want me to do? Please be mindful that
>> I'm not familiar with the internals of the Linux kernel and DRI, and it
>> might sometimes take weeks before I have time to work and respond on this.
> It doesn't matter. I hope you can do some experiments to investigate
> deeper. The first experiment you can do is enabling SIMPLEFB (i.e.
> CONFIG_FB_SIMPLE) instead of SIMPLEDRM (CONFIG_DRM_SIMPLEDRM) to see
> whether there is also a blank screen. If no blank screen, that
> probably means SIMPLEDRM has a bug, if still blank screen, that means
> the firmware may pass wrong screen information.

Testing with 6.5.9 I get a blank screen with CONFIG_DRM_SIMPLEDRM=y and 
get no blank screen with CONFIG_FB_SIMPLE=y and CONFIG_DRM_SIMPLEDRM unset.

Jaak

> 
> Huacai
> 
>>
>> Jaak
>>
>>>>
>>>> But I write this mail for a different reason:
>>>>
>>>>> I am having the same issue on a Lenovo Thinkpad P70 (Intel
>>>>> Corporation HD Graphics 530 (rev 06), Intel(R) Core(TM) i7-6700HQ).
>>>>> Upgrading from Linux 6.4.12 to 6.5 and later results in only a blank
>>>>> screen after boot and a rapidly flashing device-access-status
>>>>> indicator.
>>>>
>>>> This additional report makes me wonder if we should revert the culprit
>>>> (60aebc9559492c ("drivers/firmware: Move sysfb_init() from
>>>> device_initcall to subsys_initcall_sync") [v6.5-rc1]). But I guess that
>>>> might lead to regressions for some users? But the patch description says
>>>> that this is not a common configuration, so can we maybe get away with that?
>>>   From my point of view, this is not a regression, 60aebc9559492c
>>> doesn't cause a problem, but exposes a problem. So we need to fix the
>>> real problem (SIMPLEDRM has a blank screen on some conditions). This
>>> needs Jaak or Evan's help.
>>>
>>> Huacai
>>>>
>>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>>> --
>>>> Everything you wanna know about Linux kernel regression tracking:
>>>> https://linux-regtracking.leemhuis.info/about/#tldr
>>>> If I did something stupid, please tell me, as explained on that page.
>>>>
>>>>>>>>>> When SIMPLEDRM takes over the framebuffer, the screen is blank (don't
>>>>>>>>>> know why). And before 60aebc9559492cea6a9625f ("drivers/firmware: Move
>>>>>>>>>> sysfb_init() from device_initcall to subsys_initcall_sync") there is
>>>>>>>>>> no platform device created for SIMPLEDRM at early stage, so it seems
>>>>>>>>>> also "no problem".
>>>>>>>>> I don't understand above. You mean that after that commit the platform
>>>>>>>>> device is also none, right?
>>>>>>>> No. The SIMPLEDRM driver needs a platform device to work, and that
>>>>>>>> commit makes the platform device created earlier. So, before that
>>>>>>>> commit, SIMPLEDRM doesn't work, but the screen isn't blank; after that
>>>>>>>> commit, SIMPLEDRM works, but the screen is blank.
>>>>>>>>
>>>>>>>> Huacai
>>>>>>>>>
>>>>>>>>> Confused...
>>>>>>>>>
>>>>>>>>> --
>>>>>>>>> An old man doll... just what I always wanted! - Clara
>>>>>>>>
>>>>>>>>
>>>>>
>>>>>
>>

