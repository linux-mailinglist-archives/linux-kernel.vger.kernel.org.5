Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4AD7EB729
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 21:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjKNUAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 15:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjKNUAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 15:00:20 -0500
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC72B7;
        Tue, 14 Nov 2023 12:00:16 -0800 (PST)
Received: from [192.168.0.183] (unknown [95.90.240.101])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 860CA61E5FE05;
        Tue, 14 Nov 2023 20:58:59 +0100 (CET)
Message-ID: <58d017a1-cae6-46d8-9cee-515dbf607051@molgen.mpg.de>
Date:   Tue, 14 Nov 2023 20:58:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath10k_pci logs errors about missing pre-cal and cal firmware on
 a laptop
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        debian-kernel@lists.debian.org
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, ath10k@lists.infradead.org,
        Ben Hutchings <ben@decadent.org.uk>
References: <7158e5e9-8bdc-4660-ac5d-5e3f81cf6158@molgen.mpg.de>
 <b70d8041-901c-48f6-8790-35e354c30865@quicinc.com>
 <2e4be606-68a9-455b-a43d-20b8375efc49@quicinc.com>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <2e4be606-68a9-455b-a43d-20b8375efc49@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[To: +debian-kernel@lists.debian.org]

Dear Jeff, dear Debian Linux kernel team,


Am 14.11.23 um 19:19 schrieb Jeff Johnson:
> On 11/14/2023 9:32 AM, Jeff Johnson wrote:
>> On 11/12/2023 4:13 AM, Paul Menzel wrote:

>>> On the Dell XPS 13 9360 with Debian sid/unstable, Linux 6.5.10 logs the
>>> error below:
>>>
>>>       $ sudo dmesg | grep -e "DMI:" -e "Linux version" -e microcode
>>>       [    0.000000] microcode: updated early: 0xf0 -> 0xf4, date = 2023-02-22
>>>       [    0.000000] Linux version 6.5.0-4-amd64 (debian-kernel@lists.debian.org) (gcc-13 (Debian 13.2.0-6) 13.2.0, GNU ld (GNU Binutils for Debian) 2.41) #1 SMP PREEMPT_DYNAMIC Debian 6.5.10-1 (2023-11-03)
>>>       [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
>>>       [    0.580689] microcode: Microcode Update Driver: v2.2.
>>>
>>>       $ sudo dmesg --level alert,crit,err
>>>       [    0.053566] x86/cpu: SGX disabled by BIOS.
>>>       [    1.942183] psmouse serio1: synaptics: Unable to query device: -5
>>>       [   14.401112] ath10k_pci 0000:3a:00.0: firmware: failed to load ath10k/pre-cal-pci-0000:3a:00.0.bin (-2)
>>>       [   14.401143] firmware_class: See https://wiki.debian.org/Firmware for information about missing firmware
>>>       [   14.401185] ath10k_pci 0000:3a:00.0: firmware: failed to load ath10k/pre-cal-pci-0000:3a:00.0.bin (-2)
>>>       [   14.401233] ath10k_pci 0000:3a:00.0: firmware: failed to load ath10k/cal-pci-0000:3a:00.0.bin (-2)
>>>       [   14.401273] ath10k_pci 0000:3a:00.0: firmware: failed to load ath10k/cal-pci-0000:3a:00.0.bin (-2)
>>>
>>> As it’s logged with error level, I’d like to address the ath10k_pci
>>> errors, but I am unable to find the firmware in the Linux firmware
>>> archive [1].
>>>
>>> What can I do about this?

>>> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/
>>
>> Adding the ath10k list so this isn't lost in the noise
> 
> The calibration files are optional and you should not see any warnings
> if they are not present.
> 
> Note ath10k explicitly calls firmware_request_nowarn() when it loads the
> files since it doesn't want any warnings from the firmware loader if the
> files aren't present.
> <https://elixir.bootlin.com/linux/v6.5.10/source/drivers/net/wireless/ath/ath10k/core.c#L929>
> 
> And ath10k itself explicitly doesn't warn:
> <https://elixir.bootlin.com/linux/v6.5.10/source/drivers/net/wireless/ath/ath10k/core.c#L1259>
> 
> So I'm confused where these warnings originate.
> 
> Based upon the message:
> [   14.401143] firmware_class: See https://wiki.debian.org/Firmware
> for information about missing firmware
> 
> it seems you are not running a stock kernel. So perhaps Debian has
> modified the firmware loading such that it ignores the FW_OPT_NO_WARN
> flag and warns even when told not to do so? This does not appear to be
> an upstream kernel issue.

Thank you very much for the analysis. It seems to be indeed a Debian 
specific patch [1].

Dear Debian Linux kernel team, is my observation about the error log a 
result of the patch and intended?


Kind regards,

Paul


[1]: 
debian/patches/debian/firmware_class-refer-to-debian-wiki-firmware-page.patch
