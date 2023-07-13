Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD2D751C22
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjGMItI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjGMIsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:48:39 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CB9211F;
        Thu, 13 Jul 2023 01:48:19 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qJrzj-00049e-RU; Thu, 13 Jul 2023 10:48:15 +0200
Message-ID: <18238769-39c3-2b40-7725-367aa0e5c50b@leemhuis.info>
Date:   Thu, 13 Jul 2023 10:48:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <cover.1689008220.git.linux@leemhuis.info>
 <2023071002-phrasing-tranquil-49d6@gregkh>
 <a97a37bf-86b5-cd8e-a8ce-00e38720cee4@leemhuis.info>
 <2023071221-blade-reactive-0707@gregkh>
 <d8403c45-3561-4759-f6c2-d18afa5e323a@leemhuis.info>
 <2023071215-able-mushy-c889@gregkh>
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [RFC PATCH v1 0/3] docs: stable-kernel-rules: add delayed
 backporting option and a few tweaks
In-Reply-To: <2023071215-able-mushy-c889@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1689238099;33ba6bd9;
X-HE-SMSGID: 1qJrzj-00049e-RU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.07.23 21:00, Greg KH wrote:
> On Wed, Jul 12, 2023 at 07:02:34PM +0200, Thorsten Leemhuis wrote:
>> On 12.07.23 17:16, Greg KH wrote:
> [...]
>>>>   .. warning::
>>>>      The branches in the -stable-rc tree are rebased each time a new -rc
>>>>      is released, as they are created by taking the latest release and
>>>>      applying the patches from the stable-queue on top.
>>>
>>> Yes, that is true, but they are also rebased sometimes in intermediate
>>> places, before a -rc is released, just to give CI systems a chance to
>>> test easier.
> [...]
>> Nevertheless makes me wonder: is that strategy wise in times when some
>> ordinary users and some distributions are building kernels straight from
>> git repos instead of tarballs? I'm one of those, as I distribute
>> stable-rc packages for Fedora here:
>> https://copr.fedorainfracloud.org/groups/g/kernel-vanilla/coprs/
> 
> As we keep the patches in quilt, not git, it's the best we can do.  The
> -rc releases are never a straight-line if we have to do multiple ones,
> we remove patches in the middle, add them at the end or beginning, and
> sometimes even change existing ones.
> 
> All of this is stuff that a linear history tool like git can't really
> model well, so we keep a quilt series of the patches in git for anyone
> that want to generate the tree themselves, and we provide the -rc git
> tree for those that don't want to generate it and can live with the
> constant rebasing.

/me first didn't want to reply, as this is not really important, but
then reconsidered; again, feel free to just ignore this

FWIW, I do not consider that rebasing to be problem at all; it are those
rebases "sometimes in intermediate places, before a -rc is released,
just to give CI systems a chance to test easier" make things this
slightly annoying bit harder when you want to distribute stable-rc
releases to users.

But as I said, I can fully understand why you do those as well. I just
with there was a way to reliably get a -rc release from git as well.
Simply tagging them when you do a -rc release would solve all that. Is
that maybe something that could be easily added to your -rc release scripts?

/me looks at https://github.com/gregkh/gregkh-linux/tree/master/stable
but failed to find the -rc release script :-/

Whatever, as I said, not really important. :-D Have a nice day everyone!

Ciao, Thorsten
