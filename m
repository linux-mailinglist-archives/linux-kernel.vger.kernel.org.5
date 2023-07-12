Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1939750F2E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjGLRCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjGLRCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:02:45 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54F01BD5;
        Wed, 12 Jul 2023 10:02:43 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qJdEc-0005DU-C3; Wed, 12 Jul 2023 19:02:38 +0200
Message-ID: <d8403c45-3561-4759-f6c2-d18afa5e323a@leemhuis.info>
Date:   Wed, 12 Jul 2023 19:02:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US, de-DE
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <cover.1689008220.git.linux@leemhuis.info>
 <2023071002-phrasing-tranquil-49d6@gregkh>
 <a97a37bf-86b5-cd8e-a8ce-00e38720cee4@leemhuis.info>
 <2023071221-blade-reactive-0707@gregkh>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [RFC PATCH v1 0/3] docs: stable-kernel-rules: add delayed
 backporting option and a few tweaks
In-Reply-To: <2023071221-blade-reactive-0707@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1689181364;0e7d24e0;
X-HE-SMSGID: 1qJdEc-0005DU-C3
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.07.23 17:16, Greg KH wrote:
> On Wed, Jul 12, 2023 at 11:30:30AM +0200, Thorsten Leemhuis wrote:
>> While working on the latter I noticed one more thing:
>>
>> ```
>>     .. warning::
>>        The -stable-rc tree is a snapshot in time of the stable-queue
>> tree and
>>        will change frequently, hence will be rebased often. It should
>> only be
>>        used for testing purposes (e.g. to be consumed by CI systems).
>> ```
> [...]
>> I'll thus likely
>> change the text to something like this,
>> unless I'm missing something or someone has a better idea:
>> ```
>>   .. warning::
>>      The branches in the -stable-rc tree are rebased each time a new -rc
>>      is released, as they are created by taking the latest release and
>>      applying the patches from the stable-queue on top.
> 
> Yes, that is true, but they are also rebased sometimes in intermediate
> places, before a -rc is released, just to give CI systems a chance to
> test easier.
> 
> These are ONLY for CI systems to use, nothing else should be touching
> them.  So I think the current text is correct, what am I missing?

That I misunderstood things and forgot about the "rebased sometimes in
intermediate places" aspect I once knew about. Sorry. I'll leave the
text as it is then.

Nevertheless makes me wonder: is that strategy wise in times when some
ordinary users and some distributions are building kernels straight from
git repos instead of tarballs? I'm one of those, as I distribute
stable-rc packages for Fedora here:
https://copr.fedorainfracloud.org/groups/g/kernel-vanilla/coprs/

And the "rebased sometimes in intermediate places" aspect complicated
things for me (my scripts handle that and apparently I forgot about that
since I wrote them; uhhps :-/ ).

But whatever, not that important, feel free to ignore this remark. And I
can see why you are doing it the way you do, too.

Thx for you helpful feedback!

Ciao, Thorsten
