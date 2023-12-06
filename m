Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BB28071B0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378788AbjLFODq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378713AbjLFODp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:03:45 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E313181;
        Wed,  6 Dec 2023 06:03:50 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1rAsVA-0006aQ-6t; Wed, 06 Dec 2023 15:03:48 +0100
Message-ID: <8ca2c199-b1cf-468e-8182-f590ac0afb3c@leemhuis.info>
Date:   Wed, 6 Dec 2023 15:03:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Revert "fuse: Apply flags2 only when userspace set the
 FUSE_INIT_EXT"
Content-Language: en-US, de-DE
To:     =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Daniel Rosenberg <drosen@google.com>,
        Alessio Balsini <balsini@android.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <717fd97a-6d14-4dc9-808c-d752d718fb80@ddn.com>
 <fa3510f3-d3cc-45d2-b38e-e8717e2a9f83@ddn.com>
 <1b03f355170333f20ee20e47c5f355dc73d3a91c.camel@linaro.org>
 <9afc3152-5448-42eb-a7f4-4167fc8bc589@ddn.com>
 <5cd87a64-c506-46f2-9fed-ac8a74658631@ddn.com>
 <8ae8ce4d-6323-4160-848a-5e94895ae60e@leemhuis.info>
 <CAOssrKdvy9qTGSwwPVqYLAYYEk0jbqhGg4Lz=jEff7U58O4Yqw@mail.gmail.com>
 <2023102731-wobbly-glimpse-97f5@gregkh>
 <CAOssrKfNkMmHB2oHHO8gWbzDX27vS--e9dZoh_Mjv-17mSUTBw@mail.gmail.com>
 <2023102740-think-hatless-ab87@gregkh>
 <CAOssrKd-O1JKEPzvnM1VkQ0-oTpDv0RfY6B5oF5p63AtQ4HoqA@mail.gmail.com>
 <689f677b84b484636b673b362b17a6501a056968.camel@linaro.org>
 <CAOssrKfP+t-cy322ujizQofgZkPZsBu1H4+zfbWNEFCmTsXwug@mail.gmail.com>
 <afe378bf254f6c4ac73bb55be3fa7422f2da3f5f.camel@linaro.org>
 <CAOssrKeJB7BZ7fA6Uqo6rHohybmgovc6rVwDeHbegvweSyZeeA@mail.gmail.com>
 <7df24b0e-ea98-4dc7-9e1b-dfc29d0fa1b1@leemhuis.info>
 <61be0ebb17ae0f01ea0e88a225cbfa07ff661060.camel@linaro.org>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <61be0ebb17ae0f01ea0e88a225cbfa07ff661060.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1701871430;7228451f;
X-HE-SMSGID: 1rAsVA-0006aQ-6t
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.11.23 11:31, André Draszik wrote:
> [...]
> But I agree, it seems we're stuck and I'm not sure how to resolve this
> either, Miklos has his points, Android has a different position.

FWIW, this thread died down without any agreement if this is an
regression or not. Continuing to track it as one likely is not worth the
effort, hence I'll remove it from the list of tracked issues. If anyone
still thinks this is something that should be fixed I'd say that person
should revive this thread and bring Linus in (but FWIW, I pointed him at
this thread once already).

#regzbot inconclusive: people can't agree if this is a regression or not
and it seems people stopped caring
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
