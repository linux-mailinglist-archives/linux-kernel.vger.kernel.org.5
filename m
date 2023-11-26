Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84677F9325
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 15:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjKZOkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 09:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZOkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 09:40:19 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FCF9B
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 06:40:25 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1r7GJ4-0001v2-7I; Sun, 26 Nov 2023 15:40:22 +0100
Message-ID: <a1d74498-9c71-4e46-9db3-58baac89dc36@leemhuis.info>
Date:   Sun, 26 Nov 2023 15:40:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: regression/bisected/6.7rc1: Instead of desktop I see a horizontal
 flashing bar with a picture of the desktop background on white screen
Content-Language: en-US, de-DE
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Lee, Alvin" <Alvin.Lee2@amd.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        "Wheeler, Daniel" <Daniel.Wheeler@amd.com>,
        "Wu, Hersen" <hersenxs.wu@amd.com>,
        "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E+8p-4QO6FOWa6zp22_A@mail.gmail.com>
 <CABXGCsOqbLRHSkiz79NkVQ-wUtR7y-ZFHvhMw0+JJ_cY2AZmSw@mail.gmail.com>
 <CABXGCsPE9=Qp3Jg5hkRsTQoNgODnS_cXFU1d+hg3Baob40AaAA@mail.gmail.com>
 <edc5b75b-c08d-4c62-ae5e-089ffac27772@amd.com>
 <CABXGCsO=pdxorK9pO7qBPJM-xvgPPtpZqxLvQO4t2AK5qW3vcA@mail.gmail.com>
 <DM8PR12MB5400EAB81E5FA10F4309A732D1B1A@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CABXGCsNpEh7GjFPvx=rz6ZeB7Kx4iqV-e8HyFKyhNau2S5gENw@mail.gmail.com>
 <99ef9596-d4f8-49e2-acbe-ed7486310f84@amd.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <99ef9596-d4f8-49e2-acbe-ed7486310f84@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1701009626;8b9eb646;
X-HE-SMSGID: 1r7GJ4-0001v2-7I
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.11.23 11:46, Christian König wrote:
> Am 15.11.23 um 21:08 schrieb Mikhail Gavrilov:
>> On Wed, Nov 15, 2023 at 11:39 PM Lee, Alvin <Alvin.Lee2@amd.com> wrote:
>>> This change has a DMCUB dependency - are you able to update your
>>> DMCUB version as well?
>>>
>> I can confirm this issue was gone after updating firmware.
>>
>> ❯ dmesg | grep DMUB
>> [   11.496679] [drm] Loading DMUB firmware via PSP: version=0x07002300
>> [   12.000314] [drm] DMUB hardware initialized: version=0x07002300
> 
> Mhm, that's a quite ugly problem.
> 
> The driver is supposed to work with older firmware as well or at least
> issue a warning and provide a reasonable fallback.
> 
> How are we going to handle this?

What happened to this regression? This thread looks stalled and from a
quick search on lore and the amdgpu issue tracker it seems the issue
wasn't discussed anywhere else during the last 10 days, but I might have
missed something.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke
