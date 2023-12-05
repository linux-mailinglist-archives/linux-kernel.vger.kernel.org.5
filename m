Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CB88055C1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376952AbjLENXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345407AbjLENXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:23:02 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3188898
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:23:08 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1rAVOE-0003ki-M3; Tue, 05 Dec 2023 14:23:06 +0100
Message-ID: <d6849d4b-5b47-46e6-8cb3-a4a01f99f95c@leemhuis.info>
Date:   Tue, 5 Dec 2023 14:23:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: regression/bisected/6.7rc1: Instead of desktop I see a horizontal
 flashing bar with a picture of the desktop background on white screen
Content-Language: en-US, de-DE
To:     Alex Deucher <alexdeucher@gmail.com>,
        "Lee, Alvin" <Alvin.Lee2@amd.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Wheeler, Daniel" <Daniel.Wheeler@amd.com>,
        "Wu, Hersen" <hersenxs.wu@amd.com>,
        "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
References: <CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E+8p-4QO6FOWa6zp22_A@mail.gmail.com>
 <CABXGCsOqbLRHSkiz79NkVQ-wUtR7y-ZFHvhMw0+JJ_cY2AZmSw@mail.gmail.com>
 <CABXGCsPE9=Qp3Jg5hkRsTQoNgODnS_cXFU1d+hg3Baob40AaAA@mail.gmail.com>
 <edc5b75b-c08d-4c62-ae5e-089ffac27772@amd.com>
 <CABXGCsO=pdxorK9pO7qBPJM-xvgPPtpZqxLvQO4t2AK5qW3vcA@mail.gmail.com>
 <DM8PR12MB5400EAB81E5FA10F4309A732D1B1A@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CADnq5_P8aRkj340FtBJKsZDnV8iOCmdmCHDWKHGca+4UtfNy1A@mail.gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <CADnq5_P8aRkj340FtBJKsZDnV8iOCmdmCHDWKHGca+4UtfNy1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1701782588;1c2f113c;
X-HE-SMSGID: 1rAVOE-0003ki-M3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.11.23 19:11, Alex Deucher wrote:
> On Wed, Nov 15, 2023 at 1:52 PM Lee, Alvin <Alvin.Lee2@amd.com> wrote:
>>
>> [AMD Official Use Only - General]
>>
>> This change has a DMCUB dependency - are you able to update your DMCUB version as well?
>>
>> This version mismatch issue is something I'll need to fix in driver for Linux.
> 
> @Mahfooz, Hamza @Alvin Lee any update on a fix for this?

Still no news afaics. Or was there any progress I missed?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

>> -----Original Message-----
>> From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
>> Sent: Wednesday, November 15, 2023 1:22 PM
>> To: Mahfooz, Hamza <Hamza.Mahfooz@amd.com>
>> Cc: Lee, Alvin <Alvin.Lee2@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Linux List Kernel Mailing <linux-kernel@vger.kernel.org>; amd-gfx list <amd-gfx@lists.freedesktop.org>
>> Subject: Re: regression/bisected/6.7rc1: Instead of desktop I see a horizontal flashing bar with a picture of the desktop background on white screen
>>
>> On Wed, Nov 15, 2023 at 11:14 PM Hamza Mahfooz <hamza.mahfooz@amd.com> wrote:
>>>
>>> What version of DMUB firmware are you on?
>>> The easiest way to find out would be using the following:
>>>
>>> # dmesg | grep DMUB
>>>
>>
>> Sapphire AMD Radeon RX 7900 XTX PULSE OC:
>> ❯ dmesg | grep DMUB
>> [   14.341362] [drm] Loading DMUB firmware via PSP: version=0x07002100
>> [   14.725547] [drm] DMUB hardware initialized: version=0x07002100
>>
>> Reference GIGABYTE Radeon RX 7900 XTX 24G:
>> ❯ dmesg | grep DMUB
>> [   11.405115] [drm] Loading DMUB firmware via PSP: version=0x07002100
>> [   11.773395] [drm] DMUB hardware initialized: version=0x07002100
>>
>>
>> --
>> Best Regards,
>> Mike Gavrilov.
