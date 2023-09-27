Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF4F7AFF12
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjI0Iz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjI0Izv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:55:51 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CB0E4;
        Wed, 27 Sep 2023 01:55:49 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qlQKi-0001vm-Al; Wed, 27 Sep 2023 10:55:48 +0200
Message-ID: <3efa338a-6d0c-46a9-ae59-d96fbe6aa5af@leemhuis.info>
Date:   Wed, 27 Sep 2023 10:55:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: s2idle stopped working with 6.6-rc on Thinkpad T14 G1 (AMD)
Content-Language: en-US, de-DE
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <0d84fb59-4628-4c7f-ab1a-f58889ef2c9b@leemhuis.info>
 <e556ae63-0539-4b34-b33f-5f5beb4183d1@amd.com>
 <e049aa41-b136-4071-850f-d06b47fe67a1@leemhuis.info>
 <5f753ef4-caec-479a-bff4-43c16fb3317b@amd.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <5f753ef4-caec-479a-bff4-43c16fb3317b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695804949;b555128c;
X-HE-SMSGID: 1qlQKi-0001vm-Al
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.09.23 19:44, Mario Limonciello wrote:
> On 9/25/2023 08:45, Thorsten Leemhuis wrote:
>> On 25.09.23 15:25, Mario Limonciello wrote:
>>> On 9/25/2023 05:55, Thorsten Leemhuis wrote:
>>>> Hi Mario! Did you by chance hear anything about lock-ups on resume with
>>>> mainline affecting AMD systems? I'm asking, as s2idle stopped working
>>>> for me with 6.6-rc on my Thinkpad T14 G1 (AMD).
>>> You're the first report I've heard of this.
>> Thx for taking the time and replying.
> [...]
> FWIW your email prompted me to double check the two other Lenovo systems
> I have on hand at my desk:
> * P14s Gen 1
> * L14 Gen2a
> 
> One of them had a Ubuntu userspace (20.04 IIRC) and the other a Fedora
> 38.  I built 6.6-rc3 and couldn't reproduce any issues with s2idle.
> 
> So yes; bisect is the next step, thanks.

Thx again for your work. Turns out it was


