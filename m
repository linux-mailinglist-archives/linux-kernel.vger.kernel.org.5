Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC4E79D1F6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbjILNU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbjILNUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:20:25 -0400
Received: from cmx-mtlrgo001.bell.net (mta-mtl-002.bell.net [209.71.208.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E59E210D1;
        Tue, 12 Sep 2023 06:20:20 -0700 (PDT)
X-RG-CM-BuS: 0
X-RG-CM-SC: 0
X-RG-CM: Clean
X-Originating-IP: [174.88.80.174]
X-RG-Env-Sender: dave.anglin@bell.net
X-RG-Rigid: 64C35282044AEC07
X-CM-Envelope: MS4xfBCjMfPPTAhq8a8p3MF3MVj5INVD+kdDGmbbJuA7IZlRM5J+RLBDVJecnNFh/LmosAjACrHU6vrEbLNoQiOk0ritwU+j4oshzQGfvRUZLTxswADmoIzL
 cm7M59rjldtmNI9FTccIgNtWeQJXkbsAAi4NeZRgl0K1XJJdGhtZ16NEjQw49ytr90IrMMIwKT/LmFQ48pEVDWVRxQuB1ITsnaqwnJVXwgNFL1IwckfHQDNa
 /rdi3KBS8sRCdwFd1qzgTm18gKmd/xRCCVV0NvEXmpwPLGn21YZL7idKL+acQ84YDOdIVkwZ6vdkSDvUOnYua0nSJwqSFUGxO3TBG8MrXHQtK2Nmnkk9V/SQ
 xqk+bf64VITOU8K6ueisqriTe1dm+dx2Hgey6EDrm1edelnrq/K7GrQakWDSMotMSytN2mXdGZUC/J/GRQML1p43Xr0H6w==
X-CM-Analysis: v=2.4 cv=W7Nb6Tak c=1 sm=1 tr=0 ts=65006585
 a=NkkRUIc9Fga6GQ4JCcDOLQ==:117 a=NkkRUIc9Fga6GQ4JCcDOLQ==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=FBHGMhGWAAAA:8 a=bYoKuhMniw73sPSH_gUA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=9gvnlMMaQFpL9xblJ6ne:22
Received: from [192.168.2.49] (174.88.80.174) by cmx-mtlrgo001.bell.net (5.8.814) (authenticated as dave.anglin@bell.net)
        id 64C35282044AEC07; Tue, 12 Sep 2023 09:20:05 -0400
Message-ID: <d04d6acf-ad2c-e93d-9927-f1e937c7f1e5@bell.net>
Date:   Tue, 12 Sep 2023 09:20:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] linux/export: fix reference to exported functions for
 parisc64
To:     Helge Deller <deller@gmx.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20230905190828.790400-1-masahiroy@kernel.org>
 <c8a92dc8-de78-7484-bcc8-d4a91bec77de@bell.net>
 <c6568683-86b4-c48d-ed37-f1f87677eb44@bell.net>
 <97859bf1-c8c3-7294-8322-b0c9c408ba5e@bell.net>
 <CAK7LNAR_4rVgAQToSoYmbgYnWoSpowcrKi2ciiH9HyhJUGdmWg@mail.gmail.com>
 <CAK7LNAQQ1Vp4YtvU8Bq9aE+NWxnnOTX2dcZ5Gc9fC+vjRmCe4w@mail.gmail.com>
 <CAK7LNATktSBFe=7cE8kHEGx2R90iVV6AJsCfgg5ZD2+ssMmzow@mail.gmail.com>
 <040a0941-936b-87ab-aedd-5a933383b500@bell.net>
 <2eb1f861-d66f-edb3-17cd-84c90d92083d@gmx.de>
Content-Language: en-US
From:   John David Anglin <dave.anglin@bell.net>
In-Reply-To: <2eb1f861-d66f-edb3-17cd-84c90d92083d@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helge,

It occurs consistently on my c8000 but I'm having difficulty bisecting it.  Trying a bisect
with --first-parent.

Note I had to pull ATI graphics card from the machine as it started to malfunction causing crashes.
However, v6.1.52 boots fine.

Dave

On 2023-09-12 9:01 a.m., Helge Deller wrote:
> Hi Masahiro,
>
> I can confirm as well, that your patch
>  linux/export: fix reference to exported functions for parisc64
> does indeed fix the boot issue on parisc64.
>
> I did tested it on a C3000 workstation on top of Linus' v6.6-rc1 git tree.
> You may add:
> Tested-by: Helge Deller <deller@gmx.de>
>
> Dave, I don't see the issue you mention below...
>
> Helge
>
> On 9/10/23 23:30, John David Anglin wrote:
>> Hi Masahiro,
>>
>> The attached change fixed boot at ddb5cdbafaaa 😁
>>
>> However, v6.5.x boot is still broken:
>>
>> Run /init as init process
>> process '/usr/bin/sh' started with executable stack
>> Loading, please wait...
>> Starting systemd-udevd version 254.1-3
>> e1000 alternatives: applied 0 out of 569 patches
>> e1000: Intel(R) PRO/1000 Network Driver
>> e1000: Copyright (c) 1999-2006 Intel Corporation.
>> scsi_mod alternatives: applied 0 out of 7 patches
>> SCSI subsystem initialized
>> usbcore alternatives: applied 0 out of 18 patches
>> usbcore: registered new interface driver usbfs
>> libata alternatives: applied 0 out of 3 patches
>> usbcore: registered new interface driver hub
>> usbcore: registered new device driver usb
>> mptbase alternatives: applied 0 out of 73 patches
>> ehci_hcd alternatives: applied 0 out of 114 patches
>> sata_sil24 alternatives: applied 0 out of 56 patches
>> Fusion MPT base driver 3.04.20
>> Copyright (c) 1999-2008 LSI Corporation
>> sata_sil24 0000:00:01.0: Applying completion IRQ loss on PCI-X errata fix
>> scsi host0: sata_sil24
>> scsi host1: sata_sil24
>> pata_sil680 0000:60:02.0: sil680: 133MHz clock.
>> scsi host2: sata_sil24
>> ehci_pci alternatives: applied 0 out of 2 patches
>> ohci_hcd alternatives: applied 0 out of 144 patches
>> ehci-pci 0000:60:01.2: EHCI Host Controller
>> scsi host3: pata_sil680
>> ehci-pci 0000:60:01.2: new USB bus registered, assigned bus number 1
>> scsi host4: sata_sil24
>> ata1: SATA max UDMA/100 host m128@0xffffffff80088000 port 0xffffffff80080000 ir6
>> ata2: SATA max UDMA/100 host m128@0xffffffff80088000 port 0xffffffff80082000 ir6
>> ata3: SATA max UDMA/100 host m128@0xffffffff80088000 port 0xffffffff80084000 ir6
>> ata4: SATA max UDMA/100 host m128@0xffffffff80088000 port 0xffffffff80086000 ir6
>> e1000 0000:60:03.0 eth0: (PCI:33MHz:32-bit) 00:11:0a:31:8a:77
>> ehci-pci 0000:60:01.2: irq 71, io mem 0xffffffffb00a1000
>> scsi host5: pata_sil680
>> ata5: PATA max UDMA/133 cmd 0x26058 ctl 0x26064 bmdma 0x26040 irq 72
>> ata6: PATA max UDMA/133 cmd 0x26050 ctl 0x26060 bmdma 0x26048 irq 72
>> e1000 0000:60:03.0 eth0: Intel(R) PRO/1000 Network Connection
>> ehci-pci 0000:60:01.2: USB 2.0 started, EHCI 0.95
>> usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.05
>> usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> usb usb1: Product: EHCI Host Controller
>> usb usb1: Manufacturer: Linux 6.5.2-dirty ehci_hcd
>> usb usb1: SerialNumber: 0000:60:01.2
>> hub 1-0:1.0: USB hub found
>> hub 1-0:1.0: 5 ports detected
>> ata1: SATA link down (SStatus 0 SControl 0)
>> ata2: SATA link down (SStatus 0 SControl 0)
>> ata3: SATA link down (SStatus 0 SControl 0)
>> ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
>> ata4.00: ATA-10: ST4000VN008-2DR166, SC60, max UDMA/133
>> ata4.00: 7814037168 sectors, multi 0: LBA48 NCQ (depth 31/32)
>> ata4.00: configured for UDMA/100
>> scsi 4:0:0:0: Direct-Access     ATA      ST4000VN008-2DR1 SC60 PQ: 0 ANSI: 5
>> ata6.00: ATAPI: HL-DT-STDVD+-RW GSA-H21L, 1.04, max UDMA/44
>> scsi 5:0:0:0: CD-ROM            HL-DT-ST DVD+-RW GSA-H21L 1.04 PQ: 0 ANSI: 5
>> random: crng init done
>> Timed out for waiting the udev queue being empty.
>> Begin: Loading essential drivers ... done.
>> Begin: Running /scripts/init-premount ... done.
>> Begin: Mounting root file system ... Begin: Running /scripts/local-top ... done.
>> Begin: Running /scripts/local-premount ... done.
>> Timed out for waiting the udev queue being empty.
>> Begin: Waiting for root file system ... Begin: Running /scripts/local-block ....
>> Begin: Running /scripts/local-block ... done.
>> Begin: Running /scripts/local-block ... done.
>> Begin: Running /scripts/local-block ... done.
>> Begin: Running /scripts/local-block ... done.
>> Begin: Running /scripts/local-block ... done.
>> Begin: Running /scripts/local-block ... done.
>> Begin: Running /scripts/local-block ... done.
>> Begin: Running /scripts/local-block ... done.
>> Begin: Running /scripts/local-block ... done.
>> Begin: Running /scripts/local-block ... done.
>> Begin: Running /scripts/local-block ... done.
>> Begin: Running /scripts/local-block ... done.
>> Begin: Running /scripts/local-block ... done.
>> Begin: Running /scripts/local-block ... done.
>> Begin: Running /scripts/local-block ... done.
>> Begin: Running /scripts/local-block ... done.
>> Begin: Running /scripts/local-block ... done.
>> Begin: Running /scripts/local-block ... done.
>> done.
>> Gave up waiting for root file system device.  Common problems:
>>   - Boot args (cat /proc/cmdline)
>>     - Check rootdelay= (did the system wait long enough?)
>>   - Missing modules (cat /proc/modules; ls /dev)
>> ALERT!  LABEL=ROOT does not exist.  Dropping to a shell!
>> Rebooting automatically due to panic= boot argument
>>
>> I'll see if I can find the commit that breaks 6.5.
>>
>> Thanks,
>> Dave
>>
>> On 2023-09-10 3:47 a.m., Masahiro Yamada wrote:
>>> Hi John, Helge,
>>>
>>> Could you test the attached patch please?
>>>
>>>
>>> Again, I only tested compilation for this.
>>> I do not have parisc64 hardware.
>>> In my understanding, QEMU does not support hppa64.
>>> I do not find a way to test parisc64.
>>>
>>>
>>> Masahiro Yamada
>>>
>>>
>>>
>>>
>>>
>>> On Sun, Sep 10, 2023 at 4:20 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>>>> With a little more investigation,
>>>> I found arch/parisc/kernel/parisc_ksyms.c
>>>> is causing the issue.
>>>>
>>>> That file is a collection of EXPORT_SYMBOL
>>>> of assembly code.
>>>>
>>>> I will take a closer look tomorrow.
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> On Sun, Sep 10, 2023 at 2:20 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>>>>> On Fri, Sep 8, 2023 at 7:02 AM John David Anglin <dave.anglin@bell.net> wrote:
>>>>>> On 2023-09-05 7:59 p.m., John David Anglin wrote:
>>>>>>> On 2023-09-05 5:57 p.m., John David Anglin wrote:
>>>>>>>> I'll check ddb5cdbafaaa.
>>>>>>> Similar fault with ddb5cdbafaaa:
>>>>>> The alignment of the __kstrtab_ symbols in vmlinux seems wrong.
>>>>> __kstrtab_ symbols do not need alignment.
>>>>>
>>>>> They were not aligned at all
>>>>> before ddb5cdbafaaa^.
>>>>>
>>>>>
>>>>>
>>>>>>   I'm fairly certain that function
>>>>>> references prefixed with P% on hppa64 need 8 byte alignment.
>>>>> Yeah.
>>>>> In the following dump, all of __ksymtab_* are correctly 8-byte aligned.
>>>>>
>>>>>
>>>>>> 81662: 0000000040ea4358     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab_system[...]
>>>>>>    81663: 0000000040ea4748     0 NOTYPE  LOCAL DEFAULT   16 __kstrtabns_syst[...]
>>>>>>    81664: 0000000040e8e830     0 NOTYPE  LOCAL DEFAULT   14 __ksymtab_system[...]
>>>>>>    81665: 0000000040ea4365     0 NOTYPE  LOCAL DEFAULT   16 __kstrtab_static[...]
>>>>>>    81666: 0000000040ea4748     0 NOTYPE  LOCAL DEFAULT   16 __kstrtabns_stat[...]
>>>>>>    81667: 0000000040ea1640     0 NOTYPE  LOCAL DEFAULT   15 __ksymtab_static[...]
>>>>>>    81668: 0000000040ea437c     0 NOTYPE  LOCAL DEFAULT   16 __kstrtab_reset_[...]
>>>>>>    81669: 0000000040ea4748     0 NOTYPE  LOCAL DEFAULT   16 __kstrtabns_rese[...]
>>>>>>    81670: 0000000040e8bbc0     0 NOTYPE  LOCAL DEFAULT   14 __ksymtab_reset_[...]
>>>>>>    81671: 0000000040ea438a     0 NOTYPE  LOCAL DEFAULT   16 __kstrtab_loops_[...]
>>>>>>    81672: 0000000040ea4748     0 NOTYPE  LOCAL DEFAULT   16 __kstrtabns_loop[...]
>>>>>>    81673: 0000000040e86610     0 NOTYPE  LOCAL DEFAULT   14 __ksymtab_loops_[...]
>>>>>>    81674: 0000000040ea439a     0 NOTYPE  LOCAL DEFAULT   16 __kstrtab_init_uts_ns
>>>>>>    81675: 0000000040ea4748     0 NOTYPE  LOCAL DEFAULT   16 __kstrtabns_init[...]
>>>>>>    81676: 0000000040e99180     0 NOTYPE  LOCAL DEFAULT   15 __ksymtab_init_uts_ns
>>>>>>    81677: 0000000040ea43a6     0 NOTYPE  LOCAL DEFAULT   16 __kstrtab_name_t[...]
>>>>>>    81678: 0000000040ea4748     0 NOTYPE  LOCAL DEFAULT   16 __kstrtabns_name[...]
>>>>>>    81679: 0000000040e9b340     0 NOTYPE  LOCAL DEFAULT   15 __ksymtab_name_t[...]
>>>>>>    81680: 0000000040ea43b4     0 NOTYPE  LOCAL DEFAULT   16 __kstrtab_wait_f[...]
>>>>>>    81681: 0000000040ea4748     0 NOTYPE  LOCAL DEFAULT   16 __kstrtabns_wait[...]
>>>>>>    81682: 0000000040ea3638     0 NOTYPE  LOCAL DEFAULT   15 __ksymtab_wait_f[...]
>>>>>>    81683: 0000000040ea43c7     0 NOTYPE  LOCAL DEFAULT   16 __kstrtab_init_task
>>>>>> [...]
>>>>>>
>>>>>> I'm not sure how we get symbols that aren't 8 byte aligned.  The ".balign 4" directive
>>>>>> in __KSYMTAB doesn't seem correct but it's not the whole problem.
>>>>>>
>>>>>> Dave
>


-- 
John David Anglin  dave.anglin@bell.net

