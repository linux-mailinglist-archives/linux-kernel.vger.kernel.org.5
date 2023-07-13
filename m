Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0372D752842
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbjGMQ1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjGMQ1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:27:48 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A592735;
        Thu, 13 Jul 2023 09:27:41 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qJzAD-0007ty-0z; Thu, 13 Jul 2023 18:27:33 +0200
Message-ID: <b09c8265-c788-dede-aa34-0eb32f4eb107@leemhuis.info>
Date:   Thu, 13 Jul 2023 18:27:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US, de-DE
To:     Conor Dooley <conor@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <cover.1689008220.git.linux@leemhuis.info>
 <2023071002-phrasing-tranquil-49d6@gregkh>
 <a97a37bf-86b5-cd8e-a8ce-00e38720cee4@leemhuis.info>
 <2023071221-blade-reactive-0707@gregkh>
 <d8403c45-3561-4759-f6c2-d18afa5e323a@leemhuis.info>
 <2023071215-able-mushy-c889@gregkh>
 <18238769-39c3-2b40-7725-367aa0e5c50b@leemhuis.info>
 <2023071341-twitter-apron-e023@gregkh>
 <20230713-irritant-rarity-5f7b424fe43e@spud>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [RFC PATCH v1 0/3] docs: stable-kernel-rules: add delayed
 backporting option and a few tweaks
In-Reply-To: <20230713-irritant-rarity-5f7b424fe43e@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1689265661;26817c57;
X-HE-SMSGID: 1qJzAD-0007ty-0z
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.07.23 17:39, Conor Dooley wrote:
> On Thu, Jul 13, 2023 at 05:06:22PM +0200, Greg KH wrote:
>> On Thu, Jul 13, 2023 at 10:48:14AM +0200, Thorsten Leemhuis wrote:
>>> On 12.07.23 21:00, Greg KH wrote:
>>>> On Wed, Jul 12, 2023 at 07:02:34PM +0200, Thorsten Leemhuis wrote:
>>>>> On 12.07.23 17:16, Greg KH wrote:
>>>> [...]
>>>>>>>   .. warning::
>>>>>>>      The branches in the -stable-rc tree are rebased each time a new -rc
>>>>>>>      is released, as they are created by taking the latest release and
>>>>>>>      applying the patches from the stable-queue on top.
>>>>>>
>>>>>> Yes, that is true, but they are also rebased sometimes in intermediate
>>>>>> places, before a -rc is released, just to give CI systems a chance to
>>>>>> test easier.
>>>> [...]
>>>>> Nevertheless makes me wonder: is that strategy wise in times when some
>>>>> ordinary users and some distributions are building kernels straight from
>>>>> git repos instead of tarballs? I'm one of those, as I distribute
>>>>> stable-rc packages for Fedora here:
>>>>> https://copr.fedorainfracloud.org/groups/g/kernel-vanilla/coprs/
>>>>
>>>> As we keep the patches in quilt, not git, it's the best we can do.  The
>>>> -rc releases are never a straight-line if we have to do multiple ones,
>>>> we remove patches in the middle, add them at the end or beginning, and
>>>> sometimes even change existing ones.
>>>>
>>>> All of this is stuff that a linear history tool like git can't really
>>>> model well, so we keep a quilt series of the patches in git for anyone
>>>> that want to generate the tree themselves, and we provide the -rc git
>>>> tree for those that don't want to generate it and can live with the
>>>> constant rebasing.
>>>
>>> /me first didn't want to reply, as this is not really important, but
>>> then reconsidered; again, feel free to just ignore this
>>>
>>> FWIW, I do not consider that rebasing to be problem at all; it are those
>>> rebases "sometimes in intermediate places, before a -rc is released,
>>> just to give CI systems a chance to test easier" make things this
>>> slightly annoying bit harder when you want to distribute stable-rc
>>> releases to users.
>>>
>>> But as I said, I can fully understand why you do those as well. I just
>>> with there was a way to reliably get a -rc release from git as well.
>>> Simply tagging them when you do a -rc release would solve all that. Is
>>> that maybe something that could be easily added to your -rc release scripts?
>>
>> I can add a tag, but it would have to be a tag that can be rebased, and
>> git doesn't like that very well :)
> 
> I figure the desired tagging behaviour is that you do it when the email
> is sent out for a corresponding version & so the tag "should" not need to
> be rebased?

Yup, exactly, that's what I meant, as that makes it possible to get the
same state as the tarball by simply doing a "git checkout v6.4.4-rc1",
even if the linux-6.4.y branch in the stable-rc repo changed.

And CI systems should not care.

>>> /me looks at https://github.com/gregkh/gregkh-linux/tree/master/stable
>>> but failed to find the -rc release script :-/
>>
>> Hah, no github, it's at:
>> 	https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/scripts/quilt-mail
>>
>> But I don't think tags will help much.  I'll let anyone who actually
>> runs a CI that uses this to speak up to see if it would before adding
>> them.
> 
> I'm not sure that it is particularly valuable to the usual flow of
> testing what is about to come down the tracks, at least in my simple
> case where I trigger it based on the -rc emails

My scripts instead wait for the tarballs to show up on kernel.org. :-D

> or whenever something
> else interesting happens, like a patch being dropped that breaks the
> build.
> 
> I suppose it may be useful if an issue presents itself but disappears
> when a backport is dropped from the queue & some developers are
> interested in figuring out why the backport went awry?
> 
> Other than that, I'm not sure what the value is in "I just with [sic]
> there was a way to reliably get a -rc release from git as well", in
> _my_ CI use case I don't care about the superseded stable -rc versions,
> just whatever is about to be released.
> 
> Others with more complex CI infrastructure, like Linaro etc, might feel
> differently :)

Yeah, CI systems likely don't care much, but I distribute the proper
stable-rc releases to ordinary users for simple testing in the wild; and
it afaics would be good if they'd match the tarball in case a users runs
into problems and reports them, as I fear people otherwise might quickly
talk past each other...

Ciao, Thorsten
