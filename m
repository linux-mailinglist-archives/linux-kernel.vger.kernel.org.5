Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478137B16D8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjI1JI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjI1JI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:08:27 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A062CAC;
        Thu, 28 Sep 2023 02:08:24 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qln0P-0003Gj-JJ; Thu, 28 Sep 2023 11:08:21 +0200
Message-ID: <1b3f8dd2-6364-4f00-a33e-8b15b8911dbf@leemhuis.info>
Date:   Thu, 28 Sep 2023 11:08:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression] Resume broken on T14s Gen1 (AMD) due to "Input:
 psmouse - add delay when deactivating for SMBus mode"
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jeffery Miller <jefferymiller@google.com>
Cc:     Andrew Duggan <aduggan@synaptics.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <ca0109fa-c64b-43c1-a651-75b294d750a1@leemhuis.info>
 <CAAzPG9NkoaUz_JRtZt_JomsYj-8ZPn4QH0w0eeR-oxd55-18Qg@mail.gmail.com>
 <CAAzPG9NWp8yPU52o7d2-jLjxjLodFOiE_AjoxmCAZ=MXtV__Aw@mail.gmail.com>
 <cf87d6a5-7ff3-4add-8c48-fd3447b32697@leemhuis.info>
Content-Language: en-US, de-DE
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <cf87d6a5-7ff3-4add-8c48-fd3447b32697@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1695892104;762059f1;
X-HE-SMSGID: 1qln0P-0003Gj-JJ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.09.23 19:23, Thorsten Leemhuis wrote:
> On 27.09.23 17:55, Jeffery Miller wrote:
>> On Wed, Sep 27, 2023 at 10:43 AM Jeffery Miller
>> <jefferymiller@google.com> wrote:
>>> On Wed, Sep 27, 2023 at 3:54 AM Thorsten Leemhuis <linux@leemhuis.info> wrote:
>>>>
>>>> My dmesg from a kernel with the revert:
>>>> https://www.leemhuis.info/files/misc/dmesg
> 
> Thx for looking into this!
> 
>>> In this dmesg output it shows that this is an elantech smbus device:
>>> ```
>>> [    4.260415] psmouse serio1: elantech: assuming hardware version 4 (with firmware version 0x7f3001)
>>> [    4.279297] psmouse serio1: elantech: Synaptics capabilities query result 0x90, 0x18, 0x0f.
>>> [    4.292788] psmouse serio1: elantech: Elan sample query result 00, 80, c9
>>> [    4.319184] psmouse serio1: elantech: Elan ic body: 0x10, current fw version: 0x3
>>> ...
>>> [    4.346951] psmouse serio1: elantech: Trying to set up SMBus access
>>> [    4.346986] psmouse serio1: elantech: SMbus companion is not ready yet
>>> [    4.369993] input: ETPS/2 Elantech TrackPoint as /devices/platform/i8042/serio1/input/input7
>>> [    4.376200] systemd[1]: bpf-lsm: LSM BPF program attached
>>> [    4.385192] input: ETPS/2 Elantech Touchpad as /devices/platform/i8042/serio1/input/input5
>>> ```
>>> The change in 92e24e0e57f72e shouldn't affect the elantouch device as  elantech_setup_smbus
>>> initializes `psmouse_smbus_init` with need_deactivate = false.
> 
> Hmmm. Wondering if I should warm up the compiler again to recheck my
> result one more time[1].

Just did that. Ran "make clean" and compiled mainline as of now
(633b47cb009d) and the machine does never resume from s2idle; then I
reverted 92e24e0e57f7 and compiled again (for completeness: without
running "make clean" beforehand) and with that kernel s2idle resume
works perfectly fine.

Wondering if I or the compiler is doing something stupid here -- or if
we missed some small but important detail somewhere.

Ciao, Thorsten

>>> Did you store dmesg logs from boot without the applied patch?
>> I intended to ask if you have logs from a boot without 92e24e0e57f72e reverted.
> 
> https://www.leemhuis.info/files/misc/dmesg-6.6-rc3-vanilla
> 
>>> If the delay was being applied the timestamps should show the 30ms delay between
>>> `psmouse serio1: elantech: Trying to set up SMBus access`
>>> and
>>> `psmouse serio1: elantech: SMbus companion is not ready yet`
> 
> Unless I missed something there is not difference. :-/
> 
> Ciao, Thorsten
> 
> [1] FWIW, this is my bisect log
> 
> """
>> git bisect start
>> # status: waiting for both good and bad commits
>> # bad: [6465e260f48790807eef06b583b38ca9789b6072] Linux 6.6-rc3
>> git bisect bad 6465e260f48790807eef06b583b38ca9789b6072
>> # status: waiting for good commit(s), bad commit known
>> # good: [2dde18cd1d8fac735875f2e4987f11817cc0bc2c] Linux 6.5
>> git bisect good 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
>> # good: [4fb0dacb78c6a041bbd38ddd998df806af5c2c69] Merge tag 'sound-6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
>> git bisect good 4fb0dacb78c6a041bbd38ddd998df806af5c2c69
>> # good: [307d59039fb26212a84a9aa6a134a7d2bdea34ca] Merge tag 'media/v6.6-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
>> git bisect good 307d59039fb26212a84a9aa6a134a7d2bdea34ca
>> # bad: [4a0fc73da97efd23a383ca839e6fe86410268f6b] Merge tag 's390-6.6-2' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
>> git bisect bad 4a0fc73da97efd23a383ca839e6fe86410268f6b
>> # good: [e4f1b8202fb59c56a3de7642d50326923670513f] Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost
>> git bisect good e4f1b8202fb59c56a3de7642d50326923670513f
>> # good: [5eea5820c7340d39e56e169e1b87199391105f6b] Merge tag 'mm-stable-2023-09-04-14-00' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>> git bisect good 5eea5820c7340d39e56e169e1b87199391105f6b
>> # good: [65d6e954e37872fd9afb5ef3fc0481bb3c2f20f4] Merge tag 'gfs2-v6.5-rc5-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2
>> git bisect good 65d6e954e37872fd9afb5ef3fc0481bb3c2f20f4
>> # bad: [744a759492b5c57ff24a6e8aabe47b17ad8ee964] Merge tag 'input-for-v6.6-rc0' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input
>> git bisect bad 744a759492b5c57ff24a6e8aabe47b17ad8ee964
>> # good: [dbce1a7d5dce7318d8465b1e0d052ef1d2202237] Input: Explicitly include correct DT includes
>> git bisect good dbce1a7d5dce7318d8465b1e0d052ef1d2202237
>> # good: [29057cc5bddc785ea0a11534d7ad2546fa0872d3] Merge tag 'linux-watchdog-6.6-rc1' of git://www.linux-watchdog.org/linux-watchdog
>> git bisect good 29057cc5bddc785ea0a11534d7ad2546fa0872d3
>> # bad: [3e4bb047b23375a34dbf5885709ac3729d9cfb22] Input: qt2160 - convert to use devm_* api
>> git bisect bad 3e4bb047b23375a34dbf5885709ac3729d9cfb22
>> # good: [e175eae16c1bf92062f1f431a95f476a61a77c48] Input: mcs-touchkey - convert to use devm_* api
>> git bisect good e175eae16c1bf92062f1f431a95f476a61a77c48
>> # bad: [92e24e0e57f72e06c2df87116557331fd2d4dda2] Input: psmouse - add delay when deactivating for SMBus mode
>> git bisect bad 92e24e0e57f72e06c2df87116557331fd2d4dda2
>> # good: [8362bf82fb5441613aac7c6c9dbb6b83def6ad3b] Input: mcs-touchkey - fix uninitialized use of error in mcs_touchkey_probe()
>> git bisect good 8362bf82fb5441613aac7c6c9dbb6b83def6ad3b
>> # first bad commit: [92e24e0e57f72e06c2df87116557331fd2d4dda2] Input: psmouse - add delay when deactivating for SMBus mode
> """
> 
> 
