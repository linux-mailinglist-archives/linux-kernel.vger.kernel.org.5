Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81ECE79D187
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbjILNBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbjILNBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:01:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091BEE50;
        Tue, 12 Sep 2023 06:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694523662; x=1695128462; i=deller@gmx.de;
 bh=uAcTAkaxw16gEbXOQpvMGRfaSDLQeqSUqQooBnzKPAo=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=P2DbIqh5Hxqo0rHRX3Lb87Aj0UPrc017RqMeItr4/5VKsJ+pTYEAFEcA78S6e8X8I7pghoB
 DOE6RlP9M32Hu0UGXFKpjJ//D0hrQqvj2aPPlRT4ItiZQzgQeKNt/wy3ZdDAV4UPpec+mZyVE
 9WDMGE4upGbgAviJl10kQGAKlPdp6PygSxZUPcSUolMwbLhxP9xvUk9g7PYF35ZJUZ7IkTiLc
 ZTqf+zg3oVImtugEY4oNNJpfPJh4HpsoIhIEYeVZDNmBagkKhUNDJ4YkrKm/UeUZSTbekHO3G
 F0bXuDAHE2S0dBKVlSZQ5FpsesCg2Zb5VU24UBSexf5dYIB4lLuA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.148.165]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MG9kC-1qwXgo1cdw-00GaEw; Tue, 12
 Sep 2023 15:01:02 +0200
Message-ID: <2eb1f861-d66f-edb3-17cd-84c90d92083d@gmx.de>
Date:   Tue, 12 Sep 2023 15:01:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] linux/export: fix reference to exported functions for
 parisc64
Content-Language: en-US
To:     John David Anglin <dave.anglin@bell.net>,
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
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <040a0941-936b-87ab-aedd-5a933383b500@bell.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x9M/YOSvSOnNJH1Wl+woESr+/DOyERPizbpblRrfMEVtp1EwzaT
 F+Ia+p1ly1Mps8Y9SGiRRAaNiCa3bH3rwkEvKuhl9ySRDgyLMmxULm0D9XOKewCPD4VBSua
 IC5XgCiIdyqTht5TumaYTzUko3AJLYNCZeV7jB/aVHtjPzo+C94tBlxmpi8uqaMsY7+PTRI
 x+x+50TEDL63i5lASUCzg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YAMU+YoawSA=;StD5PGssR0BGFkreCDxruZsZhus
 4Jb2q8W+hdSAGHMhxTniK/D8nr39844zf9Ii0d/lPdywkl2E/v7ml9NNpKeXf8jgaTHDCqko9
 WVxLTlXhExGY90Jr6fJ8cu9HrWd3J4iOUw9F26K4JPsyI1NRV35IYRNuV0pvlvxYfgc/QIPUb
 pE3kduLwjdIJWbTuuZUSZsP6s/SkANum1FaXe6i7bLIrOKr4zwY+t3WXpG5OaIULn9e33JoL8
 S7FEX61Ss7mlmYCFrVNHtUXZ8O7LXpzQG2vj2WWbQAWyTLSLX3+XI1dc7MdkUgq+SSYatfzQS
 qX0zwFOaZNvioN5Q3z6JOioiOvHPl2ZoiFz7sJCXb7ZaW6+Ljyz+KkC47cS/bQuxnSmzZTamq
 +elGhBs7tawm3uYZpgKrDwEWAcJ9zOgjONd7BqTm/2stbXUKkmd2NbotJbBywwYR7Lz01yOvd
 cdxGdUFbTpWZNFH8qauwWKuaKglpPJFNMp+HpSEz2IIn5QhIZG0JGMJSHq2AHYBVGU9A2X8Jl
 3UpFJvuJ+fi7dQ3J2c0rBMQunEBOiyaVS0+ljWVXbUmgfWysepeWLIFDbFyun95bWwFfG9bA1
 9VSYFy1Q0DcuEmMRYTeohon1BaTpQvzBHQLMu340HufYgGJdi/OIhfxaxdAaTEHJme8W9fYDI
 TCJlxzb6WQ2rYgKOE6pZMaHS+qX7xomr9KVbPlDXYR34hKjtXI65PCSqHw76YegF0m/Wq2Brh
 GBvVmC0DvugiQuvcfTLOM+BQ9hxVy479Sp7Ziq4qfK9gcK1aAesy+3b1GPiveof6mL3h3AQaw
 LXMd6ijrzSlRIDStUg+I/Kg8EQ4wfMtk/SNhSELyKP+heliE6u/7GDA92H4S4xcg1OVMsx1eQ
 g9K+jVN0+RwUUuV9W5GwZ+ehlFKjC7hKFBvsYyGFH0f3MgTl6u7+Leg6UeCoPFq6tSdmrBKrt
 +fbB7mesn3v7lKGWQuFBUdX8EYE=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

I can confirm as well, that your patch
  linux/export: fix reference to exported functions for parisc64
does indeed fix the boot issue on parisc64.

I did tested it on a C3000 workstation on top of Linus' v6.6-rc1 git tree.
You may add:
Tested-by: Helge Deller <deller@gmx.de>

Dave, I don't see the issue you mention below...

Helge

On 9/10/23 23:30, John David Anglin wrote:
> Hi Masahiro,
>
> The attached change fixed boot at ddb5cdbafaaa =F0=9F=98=81
>
> However, v6.5.x boot is still broken:
>
> Run /init as init process
> process '/usr/bin/sh' started with executable stack
> Loading, please wait...
> Starting systemd-udevd version 254.1-3
> e1000 alternatives: applied 0 out of 569 patches
> e1000: Intel(R) PRO/1000 Network Driver
> e1000: Copyright (c) 1999-2006 Intel Corporation.
> scsi_mod alternatives: applied 0 out of 7 patches
> SCSI subsystem initialized
> usbcore alternatives: applied 0 out of 18 patches
> usbcore: registered new interface driver usbfs
> libata alternatives: applied 0 out of 3 patches
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> mptbase alternatives: applied 0 out of 73 patches
> ehci_hcd alternatives: applied 0 out of 114 patches
> sata_sil24 alternatives: applied 0 out of 56 patches
> Fusion MPT base driver 3.04.20
> Copyright (c) 1999-2008 LSI Corporation
> sata_sil24 0000:00:01.0: Applying completion IRQ loss on PCI-X errata fi=
x
> scsi host0: sata_sil24
> scsi host1: sata_sil24
> pata_sil680 0000:60:02.0: sil680: 133MHz clock.
> scsi host2: sata_sil24
> ehci_pci alternatives: applied 0 out of 2 patches
> ohci_hcd alternatives: applied 0 out of 144 patches
> ehci-pci 0000:60:01.2: EHCI Host Controller
> scsi host3: pata_sil680
> ehci-pci 0000:60:01.2: new USB bus registered, assigned bus number 1
> scsi host4: sata_sil24
> ata1: SATA max UDMA/100 host m128@0xffffffff80088000 port 0xffffffff8008=
0000 ir6
> ata2: SATA max UDMA/100 host m128@0xffffffff80088000 port 0xffffffff8008=
2000 ir6
> ata3: SATA max UDMA/100 host m128@0xffffffff80088000 port 0xffffffff8008=
4000 ir6
> ata4: SATA max UDMA/100 host m128@0xffffffff80088000 port 0xffffffff8008=
6000 ir6
> e1000 0000:60:03.0 eth0: (PCI:33MHz:32-bit) 00:11:0a:31:8a:77
> ehci-pci 0000:60:01.2: irq 71, io mem 0xffffffffb00a1000
> scsi host5: pata_sil680
> ata5: PATA max UDMA/133 cmd 0x26058 ctl 0x26064 bmdma 0x26040 irq 72
> ata6: PATA max UDMA/133 cmd 0x26050 ctl 0x26060 bmdma 0x26048 irq 72
> e1000 0000:60:03.0 eth0: Intel(R) PRO/1000 Network Connection
> ehci-pci 0000:60:01.2: USB 2.0 started, EHCI 0.95
> usb usb1: New USB device found, idVendor=3D1d6b, idProduct=3D0002, bcdDe=
vice=3D 6.05
> usb usb1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
> usb usb1: Product: EHCI Host Controller
> usb usb1: Manufacturer: Linux 6.5.2-dirty ehci_hcd
> usb usb1: SerialNumber: 0000:60:01.2
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 5 ports detected
> ata1: SATA link down (SStatus 0 SControl 0)
> ata2: SATA link down (SStatus 0 SControl 0)
> ata3: SATA link down (SStatus 0 SControl 0)
> ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata4.00: ATA-10: ST4000VN008-2DR166, SC60, max UDMA/133
> ata4.00: 7814037168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> ata4.00: configured for UDMA/100
> scsi 4:0:0:0: Direct-Access=C2=A0=C2=A0=C2=A0=C2=A0 ATA=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ST4000VN008-2DR1 SC60 PQ: 0 ANSI: 5
> ata6.00: ATAPI: HL-DT-STDVD+-RW GSA-H21L, 1.04, max UDMA/44
> scsi 5:0:0:0: CD-ROM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 HL-DT-ST DVD+-RW GSA-H21L 1.04 PQ: 0 ANSI: 5
> random: crng init done
> Timed out for waiting the udev queue being empty.
> Begin: Loading essential drivers ... done.
> Begin: Running /scripts/init-premount ... done.
> Begin: Mounting root file system ... Begin: Running /scripts/local-top .=
.. done.
> Begin: Running /scripts/local-premount ... done.
> Timed out for waiting the udev queue being empty.
> Begin: Waiting for root file system ... Begin: Running /scripts/local-bl=
ock ....
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> done.
> Gave up waiting for root file system device.=C2=A0 Common problems:
>  =C2=A0- Boot args (cat /proc/cmdline)
>  =C2=A0=C2=A0 - Check rootdelay=3D (did the system wait long enough?)
>  =C2=A0- Missing modules (cat /proc/modules; ls /dev)
> ALERT!=C2=A0 LABEL=3DROOT does not exist.=C2=A0 Dropping to a shell!
> Rebooting automatically due to panic=3D boot argument
>
> I'll see if I can find the commit that breaks 6.5.
>
> Thanks,
> Dave
>
> On 2023-09-10 3:47 a.m., Masahiro Yamada wrote:
>> Hi John, Helge,
>>
>> Could you test the attached patch please?
>>
>>
>> Again, I only tested compilation for this.
>> I do not have parisc64 hardware.
>> In my understanding, QEMU does not support hppa64.
>> I do not find a way to test parisc64.
>>
>>
>> Masahiro Yamada
>>
>>
>>
>>
>>
>> On Sun, Sep 10, 2023 at 4:20=E2=80=AFAM Masahiro Yamada <masahiroy@kern=
el.org> wrote:
>>> With a little more investigation,
>>> I found arch/parisc/kernel/parisc_ksyms.c
>>> is causing the issue.
>>>
>>> That file is a collection of EXPORT_SYMBOL
>>> of assembly code.
>>>
>>> I will take a closer look tomorrow.
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>> On Sun, Sep 10, 2023 at 2:20=E2=80=AFAM Masahiro Yamada <masahiroy@ker=
nel.org> wrote:
>>>> On Fri, Sep 8, 2023 at 7:02=E2=80=AFAM John David Anglin <dave.anglin=
@bell.net> wrote:
>>>>> On 2023-09-05 7:59 p.m., John David Anglin wrote:
>>>>>> On 2023-09-05 5:57 p.m., John David Anglin wrote:
>>>>>>> I'll check ddb5cdbafaaa.
>>>>>> Similar fault with ddb5cdbafaaa:
>>>>> The alignment of the __kstrtab_ symbols in vmlinux seems wrong.
>>>> __kstrtab_ symbols do not need alignment.
>>>>
>>>> They were not aligned at all
>>>> before ddb5cdbafaaa^.
>>>>
>>>>
>>>>
>>>>> =C2=A0 I'm fairly certain that function
>>>>> references prefixed with P% on hppa64 need 8 byte alignment.
>>>> Yeah.
>>>> In the following dump, all of __ksymtab_* are correctly 8-byte aligne=
d.
>>>>
>>>>
>>>>> 81662: 0000000040ea4358=C2=A0=C2=A0=C2=A0=C2=A0 0 NOTYPE=C2=A0 LOCAL=
=C2=A0 DEFAULT=C2=A0=C2=A0 16 __kstrtab_system[...]
>>>>> =C2=A0=C2=A0 81663: 0000000040ea4748=C2=A0=C2=A0=C2=A0=C2=A0 0 NOTYP=
E=C2=A0 LOCAL=C2=A0 DEFAULT=C2=A0=C2=A0 16 __kstrtabns_syst[...]
>>>>> =C2=A0=C2=A0 81664: 0000000040e8e830=C2=A0=C2=A0=C2=A0=C2=A0 0 NOTYP=
E=C2=A0 LOCAL=C2=A0 DEFAULT=C2=A0=C2=A0 14 __ksymtab_system[...]
>>>>> =C2=A0=C2=A0 81665: 0000000040ea4365=C2=A0=C2=A0=C2=A0=C2=A0 0 NOTYP=
E=C2=A0 LOCAL=C2=A0 DEFAULT=C2=A0=C2=A0 16 __kstrtab_static[...]
>>>>> =C2=A0=C2=A0 81666: 0000000040ea4748=C2=A0=C2=A0=C2=A0=C2=A0 0 NOTYP=
E=C2=A0 LOCAL=C2=A0 DEFAULT=C2=A0=C2=A0 16 __kstrtabns_stat[...]
>>>>> =C2=A0=C2=A0 81667: 0000000040ea1640=C2=A0=C2=A0=C2=A0=C2=A0 0 NOTYP=
E=C2=A0 LOCAL=C2=A0 DEFAULT=C2=A0=C2=A0 15 __ksymtab_static[...]
>>>>> =C2=A0=C2=A0 81668: 0000000040ea437c=C2=A0=C2=A0=C2=A0=C2=A0 0 NOTYP=
E=C2=A0 LOCAL=C2=A0 DEFAULT=C2=A0=C2=A0 16 __kstrtab_reset_[...]
>>>>> =C2=A0=C2=A0 81669: 0000000040ea4748=C2=A0=C2=A0=C2=A0=C2=A0 0 NOTYP=
E=C2=A0 LOCAL=C2=A0 DEFAULT=C2=A0=C2=A0 16 __kstrtabns_rese[...]
>>>>> =C2=A0=C2=A0 81670: 0000000040e8bbc0=C2=A0=C2=A0=C2=A0=C2=A0 0 NOTYP=
E=C2=A0 LOCAL=C2=A0 DEFAULT=C2=A0=C2=A0 14 __ksymtab_reset_[...]
>>>>> =C2=A0=C2=A0 81671: 0000000040ea438a=C2=A0=C2=A0=C2=A0=C2=A0 0 NOTYP=
E=C2=A0 LOCAL=C2=A0 DEFAULT=C2=A0=C2=A0 16 __kstrtab_loops_[...]
>>>>> =C2=A0=C2=A0 81672: 0000000040ea4748=C2=A0=C2=A0=C2=A0=C2=A0 0 NOTYP=
E=C2=A0 LOCAL=C2=A0 DEFAULT=C2=A0=C2=A0 16 __kstrtabns_loop[...]
>>>>> =C2=A0=C2=A0 81673: 0000000040e86610=C2=A0=C2=A0=C2=A0=C2=A0 0 NOTYP=
E=C2=A0 LOCAL=C2=A0 DEFAULT=C2=A0=C2=A0 14 __ksymtab_loops_[...]
>>>>> =C2=A0=C2=A0 81674: 0000000040ea439a=C2=A0=C2=A0=C2=A0=C2=A0 0 NOTYP=
E=C2=A0 LOCAL=C2=A0 DEFAULT=C2=A0=C2=A0 16 __kstrtab_init_uts_ns
>>>>> =C2=A0=C2=A0 81675: 0000000040ea4748=C2=A0=C2=A0=C2=A0=C2=A0 0 NOTYP=
E=C2=A0 LOCAL=C2=A0 DEFAULT=C2=A0=C2=A0 16 __kstrtabns_init[...]
>>>>> =C2=A0=C2=A0 81676: 0000000040e99180=C2=A0=C2=A0=C2=A0=C2=A0 0 NOTYP=
E=C2=A0 LOCAL=C2=A0 DEFAULT=C2=A0=C2=A0 15 __ksymtab_init_uts_ns
>>>>> =C2=A0=C2=A0 81677: 0000000040ea43a6=C2=A0=C2=A0=C2=A0=C2=A0 0 NOTYP=
E=C2=A0 LOCAL=C2=A0 DEFAULT=C2=A0=C2=A0 16 __kstrtab_name_t[...]
>>>>> =C2=A0=C2=A0 81678: 0000000040ea4748=C2=A0=C2=A0=C2=A0=C2=A0 0 NOTYP=
E=C2=A0 LOCAL=C2=A0 DEFAULT=C2=A0=C2=A0 16 __kstrtabns_name[...]
>>>>> =C2=A0=C2=A0 81679: 0000000040e9b340=C2=A0=C2=A0=C2=A0=C2=A0 0 NOTYP=
E=C2=A0 LOCAL=C2=A0 DEFAULT=C2=A0=C2=A0 15 __ksymtab_name_t[...]
>>>>> =C2=A0=C2=A0 81680: 0000000040ea43b4=C2=A0=C2=A0=C2=A0=C2=A0 0 NOTYP=
E=C2=A0 LOCAL=C2=A0 DEFAULT=C2=A0=C2=A0 16 __kstrtab_wait_f[...]
>>>>> =C2=A0=C2=A0 81681: 0000000040ea4748=C2=A0=C2=A0=C2=A0=C2=A0 0 NOTYP=
E=C2=A0 LOCAL=C2=A0 DEFAULT=C2=A0=C2=A0 16 __kstrtabns_wait[...]
>>>>> =C2=A0=C2=A0 81682: 0000000040ea3638=C2=A0=C2=A0=C2=A0=C2=A0 0 NOTYP=
E=C2=A0 LOCAL=C2=A0 DEFAULT=C2=A0=C2=A0 15 __ksymtab_wait_f[...]
>>>>> =C2=A0=C2=A0 81683: 0000000040ea43c7=C2=A0=C2=A0=C2=A0=C2=A0 0 NOTYP=
E=C2=A0 LOCAL=C2=A0 DEFAULT=C2=A0=C2=A0 16 __kstrtab_init_task
>>>>> [...]
>>>>>
>>>>> I'm not sure how we get symbols that aren't 8 byte aligned.=C2=A0 Th=
e ".balign 4" directive
>>>>> in __KSYMTAB doesn't seem correct but it's not the whole problem.
>>>>>
>>>>> Dave

