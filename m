Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A11776F0A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 06:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjHJETy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 00:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjHJETw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 00:19:52 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7686A171D;
        Wed,  9 Aug 2023 21:19:50 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qTx9F-0004H5-4C; Thu, 10 Aug 2023 06:19:45 +0200
Message-ID: <94a31824-016a-7fe3-7477-e3ab500844c1@leemhuis.info>
Date:   Thu, 10 Aug 2023 06:19:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Nouveau] Fwd: System (Xeon Nvidia) hangs at boot terminal after
 kernel 6.4.7
Content-Language: en-US, de-DE
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Peter Bottomley <peebee@gmx.com>, peter@peebee.org.uk
Cc:     Linux Nouveau <nouveau@lists.freedesktop.org>,
        Linux Stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Regressions <regressions@lists.linux.dev>
References: <4b0c06ba-b05c-071c-d494-67775bd7250f@gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <4b0c06ba-b05c-071c-d494-67775bd7250f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1691641190;576a0fa0;
X-HE-SMSGID: 1qTx9F-0004H5-4C
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.08.23 05:03, Bagas Sanjaya wrote:
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
>> Kernel 6.4.6 compiled from source worked AOK on my desktop with Intel Xeon cpu and Nvidia graphics - see below for system specs.
>>
>> Kernels 6.4.7 & 6.4.8 also compiled from source with identical configs hang with a frozen boot terminal screen after a significant way through the boot sequence (e.g. whilst running /etc/profile). The system may still be running as a sound is emitted when the power button is pressed (only way to escape from the system hang).
> [...]
>> Computer Profile:
>>  Machine                    Dell Inc. Precision WorkStation T5400   (version: Not Specified)
>>  Mainboard                  Dell Inc. 0RW203 (version: NA)
>>  • BIOS                     Dell Inc. A11 | Date: 04/30/2012 | Type: Legacy
>>  • CPU                      Intel(R) Xeon(R) CPU E5450 @ 3.00GHz (4 cores)
>>  • RAM                      Total: 7955 MB | Used: 1555 MB (19.5%) | Actual Used: 775 MB (9.7%)
>>  Graphics                   Resolution: 1366x768 pixels | Display Server: X.Org 21.1.8
>>  • device-0                 NVIDIA Corporation GT218 [NVS 300] [10de:10d8] (rev a2)
>>  Audio                      ALSA
>>  • device-0                 Intel Corporation 631xESB/632xESB High Definition Audio Controller [8086:269a] (rev 09)
>>  • device-1                 NVIDIA Corporation High Definition Audio Controller [10de:0be3] (rev a1)
>>  Network                    wlan1
>>  • device-0                 Ethernet: Broadcom Inc. and subsidiaries NetXtreme BCM5754 Gigabit Ethernet PCI Express [14e4:167a] (rev 02)
> 
> See Bugzilla for the full thread.
> [...]
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217776

Not my area of expertise, but nevertheless pretty sure this is the same
issue already discussed here, as it's a GT218 there as well at 6.4.7 is
the version that commit was backported to:

https://lore.kernel.org/all/20230806213107.GFZNARG6moWpFuSJ9W@fat_crate.local/

No final solution ready yet, but looks like the culprit will be reverted.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
