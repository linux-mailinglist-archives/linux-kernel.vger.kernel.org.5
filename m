Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A84B79D32A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbjILOFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235812AbjILOF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:05:28 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8259B10D0;
        Tue, 12 Sep 2023 07:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694527514; x=1695132314; i=deller@gmx.de;
 bh=zkVohFeaHpsZ3RYTMnALchIo6fwb/T0Nbc/5yfNpqxk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=DemEY8ZAjjQLinCdKJe8P9/rqsBeU6n7smYXka2xNmrGh2IND9oazkncdndRR+WAsNfRG0U
 j2w6YqHDXWBWmGmmG4BoeEQYwfR9h8QwcgVG0AhKMEcPMxVTbOExbEvoc5615rVROovjtdqP1
 tDFpF6Mj5DQgq9rtHGvDgz+37xcrzQf9z3+MdrsNogBG6sd2Ga7N6GUdE/CzrC+icHcRMyYvD
 CHYJ0sljvCLr4bjy6FFj4bbg4dr9DDnYf1PYnoP/X1GwRR58zsKRXl3U9TG7pZOG93UFQwQme
 tdWQBOoKSl+T5cbzUCveAclK84MSSxt6MesdCWQyPPq/LPj103OQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.148.165]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2wKq-1qjNOo2IBg-003Qix; Tue, 12
 Sep 2023 16:05:14 +0200
Message-ID: <1870f4dc-fba4-26e9-6ec8-43e23cdeef12@gmx.de>
Date:   Tue, 12 Sep 2023 16:05:13 +0200
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
 <2eb1f861-d66f-edb3-17cd-84c90d92083d@gmx.de>
 <d04d6acf-ad2c-e93d-9927-f1e937c7f1e5@bell.net>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <d04d6acf-ad2c-e93d-9927-f1e937c7f1e5@bell.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T8PKd4enzK24JLCQqFESXuVjV9q6vGhYxLjn7y2wOJI9Rp+YCTS
 D+ZaX3mvTWDUz0GJadYpwiv1/37HglaEFC/JuTmR74mxqdhGZInq6Zd+z+ONPBX8UoCkaug
 ZORfmojF4t99Xs9nhElyNBGYLgIzy4P5tgkeeDlq84HfWeJr/gLK6jxHQok2dCVkBc+beQC
 H69i7cLWPIna8RzNe5vgQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QBahZnZU0Qc=;F3PONEfxVj5G85riXw9mDot44ux
 sXj29cBvqIbhMp7ubjQA8hhLpUzK9cjCcIuYFIDreLHEQf8V/7V2EU+/fgesQM7sXkR7AtSPJ
 bEM5uW+Rl2i6tdwcJIp+MW/udbPqx6c+9dsq1erarF4vbOY8XFf3VRd+cVB+rArntXF7KraWW
 WAv591E57+nycKG3hOJaEOg+pquyPMaRi9VUjL3gg3zn7CIst2MlpB5oxfLruHJBJln24hIcw
 TTdL8bILA7nFcJvNV9WyeNuCgU91B2jDYtj7qnWGFkM/EtZwk3jhgLEgqP572MNOgKPgCGqzV
 KYpFpYYuckJXiOGpsy2oq/F4dQAZTy9OpGXe9w59l/FkMlL75Ixlnzr/Aw2wakqEeu+YlcEsl
 s1P0u2YM2I6C75XhYisBAUmoH4ewbv/35Ra+R+mDLw6IFJs/5pbuyfv7d9Knb4z/EsvAuj1Gh
 gSD45Lq/rNhJb7zm0ECfDg6wQla+dqm2AZb5XM4W6cJpu8QQkDMte9oOLwZzT8La8XFWQ99Ky
 j29qtVl2RvA2CjR/88YpAuA/BL/0csLQAmlXZOfsy7+1ansQt/UgejvpgHyms8fDCVXYqP23S
 jaWGW0+XEpnGdfkoms8WHPcbGPjsGHkCgMt+tjJcrDnn2aDBEqhHu6Fyipp3PkJxddEDQXQVr
 piCQeYWhW9ioaNE8aeN2kFk/Svt0UhVaK7TVSSgDAq+smKvRFGkBe3na83ihbzWye9eHfe811
 bAWbDBzpTsFbg78xhfMuBXzfYkGK9IRI062/w6vzCNbv05rBJAmBej+OX4SHJfXukuiTt9wPT
 Ej692eKOCNhFdBwm7mcZdBSSbtyu6zvgACrUsYccImYu1aWi+vOdgkSeC9J+dYjZ1vIW0kFtv
 1GWuOFoqFySYXFzIAkBjd1xhhmlXmBgINZsgz0fcX/LloZhgl5kiyGQdoJbgLCgs/HxAcvGT3
 MvpYXtinU5BKNG58SX43jP8KmJo=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 9/12/23 15:20, John David Anglin wrote:
> It occurs consistently on my c8000 but I'm having difficulty bisecting i=
t.=C2=A0 Trying a bisect
> with --first-parent.

I just tried to boot the v6.6-rc1 with Masahiro's patch on c8000, and it s=
ucceeds as well.
I've copied my pre-built kernel here:
http://backup.parisc-linux.org/kernel/linux-image-6.6.0-rc1-dirty_6.6.0-rc=
1-250_hppa.deb

So, I think Masahiro's patch is basically ok and probably isn't the root c=
ause
for your udev issues below.
Did you checked if initramfs included all necessary filesystem modules?
Maybe updating your machine to latest ramfstools and re-installing your ke=
rnel?

Helge


> Note I had to pull ATI graphics card from the machine as it started to m=
alfunction causing crashes.
> However, v6.1.52 boots fine.

>
> On 2023-09-12 9:01 a.m., Helge Deller wrote:
>> Hi Masahiro,
>>
>> I can confirm as well, that your patch
>> =C2=A0linux/export: fix reference to exported functions for parisc64
>> does indeed fix the boot issue on parisc64.
>>
>> I did tested it on a C3000 workstation on top of Linus' v6.6-rc1 git tr=
ee.
>> You may add:
>> Tested-by: Helge Deller <deller@gmx.de>
>>
>> Dave, I don't see the issue you mention below...
>>
>> Helge
>>
>> On 9/10/23 23:30, John David Anglin wrote:
>>> Hi Masahiro,
>>>
>>> The attached change fixed boot at ddb5cdbafaaa =F0=9F=98=81
>>>
>>> However, v6.5.x boot is still broken:
>>>
>>> Run /init as init process
>>> process '/usr/bin/sh' started with executable stack
>>> Loading, please wait...
>>> Starting systemd-udevd version 254.1-3
>>> e1000 alternatives: applied 0 out of 569 patches
>>> e1000: Intel(R) PRO/1000 Network Driver
>>> e1000: Copyright (c) 1999-2006 Intel Corporation.
>>> scsi_mod alternatives: applied 0 out of 7 patches
>>> SCSI subsystem initialized
>>> usbcore alternatives: applied 0 out of 18 patches
>>> usbcore: registered new interface driver usbfs
>>> libata alternatives: applied 0 out of 3 patches
>>> usbcore: registered new interface driver hub
>>> usbcore: registered new device driver usb
>>> mptbase alternatives: applied 0 out of 73 patches
>>> ehci_hcd alternatives: applied 0 out of 114 patches
>>> sata_sil24 alternatives: applied 0 out of 56 patches
>>> Fusion MPT base driver 3.04.20
>>> Copyright (c) 1999-2008 LSI Corporation
>>> sata_sil24 0000:00:01.0: Applying completion IRQ loss on PCI-X errata =
fix
>>> scsi host0: sata_sil24
>>> scsi host1: sata_sil24
>>> pata_sil680 0000:60:02.0: sil680: 133MHz clock.
>>> scsi host2: sata_sil24
>>> ehci_pci alternatives: applied 0 out of 2 patches
>>> ohci_hcd alternatives: applied 0 out of 144 patches
>>> ehci-pci 0000:60:01.2: EHCI Host Controller
>>> scsi host3: pata_sil680
>>> ehci-pci 0000:60:01.2: new USB bus registered, assigned bus number 1
>>> scsi host4: sata_sil24
>>> ata1: SATA max UDMA/100 host m128@0xffffffff80088000 port 0xffffffff80=
080000 ir6
>>> ata2: SATA max UDMA/100 host m128@0xffffffff80088000 port 0xffffffff80=
082000 ir6
>>> ata3: SATA max UDMA/100 host m128@0xffffffff80088000 port 0xffffffff80=
084000 ir6
>>> ata4: SATA max UDMA/100 host m128@0xffffffff80088000 port 0xffffffff80=
086000 ir6
>>> e1000 0000:60:03.0 eth0: (PCI:33MHz:32-bit) 00:11:0a:31:8a:77
>>> ehci-pci 0000:60:01.2: irq 71, io mem 0xffffffffb00a1000
>>> scsi host5: pata_sil680
>>> ata5: PATA max UDMA/133 cmd 0x26058 ctl 0x26064 bmdma 0x26040 irq 72
>>> ata6: PATA max UDMA/133 cmd 0x26050 ctl 0x26060 bmdma 0x26048 irq 72
>>> e1000 0000:60:03.0 eth0: Intel(R) PRO/1000 Network Connection
>>> ehci-pci 0000:60:01.2: USB 2.0 started, EHCI 0.95
>>> usb usb1: New USB device found, idVendor=3D1d6b, idProduct=3D0002, bcd=
Device=3D 6.05
>>> usb usb1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=
=3D1
>>> usb usb1: Product: EHCI Host Controller
>>> usb usb1: Manufacturer: Linux 6.5.2-dirty ehci_hcd
>>> usb usb1: SerialNumber: 0000:60:01.2
>>> hub 1-0:1.0: USB hub found
>>> hub 1-0:1.0: 5 ports detected
>>> ata1: SATA link down (SStatus 0 SControl 0)
>>> ata2: SATA link down (SStatus 0 SControl 0)
>>> ata3: SATA link down (SStatus 0 SControl 0)
>>> ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
>>> ata4.00: ATA-10: ST4000VN008-2DR166, SC60, max UDMA/133
>>> ata4.00: 7814037168 sectors, multi 0: LBA48 NCQ (depth 31/32)
>>> ata4.00: configured for UDMA/100
>>> scsi 4:0:0:0: Direct-Access=C2=A0=C2=A0=C2=A0=C2=A0 ATA=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ST4000VN008-2DR1 SC60 PQ: 0 ANSI: 5
>>> ata6.00: ATAPI: HL-DT-STDVD+-RW GSA-H21L, 1.04, max UDMA/44
>>> scsi 5:0:0:0: CD-ROM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 HL-DT-ST DVD+-RW GSA-H21L 1.04 PQ: 0 ANSI: 5
>>> random: crng init done
>>> Timed out for waiting the udev queue being empty.
>>> Begin: Loading essential drivers ... done.
>>> Begin: Running /scripts/init-premount ... done.
>>> Begin: Mounting root file system ... Begin: Running /scripts/local-top=
 ... done.
>>> Begin: Running /scripts/local-premount ... done.
>>> Timed out for waiting the udev queue being empty.
>>> Begin: Waiting for root file system ... Begin: Running /scripts/local-=
block ....
>>> Begin: Running /scripts/local-block ... done.
>>> Begin: Running /scripts/local-block ... done.
>>> Begin: Running /scripts/local-block ... done.
>>> Begin: Running /scripts/local-block ... done.
>>> Begin: Running /scripts/local-block ... done.
>>> Begin: Running /scripts/local-block ... done.
>>> Begin: Running /scripts/local-block ... done.
>>> Begin: Running /scripts/local-block ... done.
>>> Begin: Running /scripts/local-block ... done.
>>> Begin: Running /scripts/local-block ... done.
>>> Begin: Running /scripts/local-block ... done.
>>> Begin: Running /scripts/local-block ... done.
>>> Begin: Running /scripts/local-block ... done.
>>> Begin: Running /scripts/local-block ... done.
>>> Begin: Running /scripts/local-block ... done.
>>> Begin: Running /scripts/local-block ... done.
>>> Begin: Running /scripts/local-block ... done.
>>> Begin: Running /scripts/local-block ... done.
>>> done.
>>> Gave up waiting for root file system device.=C2=A0 Common problems:
>>> =C2=A0=C2=A0- Boot args (cat /proc/cmdline)
>>> =C2=A0=C2=A0=C2=A0 - Check rootdelay=3D (did the system wait long enou=
gh?)
>>> =C2=A0=C2=A0- Missing modules (cat /proc/modules; ls /dev)
>>> ALERT!=C2=A0 LABEL=3DROOT does not exist.=C2=A0 Dropping to a shell!
>>> Rebooting automatically due to panic=3D boot argument
>>>
>>> I'll see if I can find the commit that breaks 6.5.
>>>
>>> Thanks,
>>> Dave
>>>
>>> On 2023-09-10 3:47 a.m., Masahiro Yamada wrote:
>>>> Hi John, Helge,
>>>>
>>>> Could you test the attached patch please?
>>>>
>>>>
>>>> Again, I only tested compilation for this.
>>>> I do not have parisc64 hardware.
>>>> In my understanding, QEMU does not support hppa64.
>>>> I do not find a way to test parisc64.
>>>>
>>>>
>>>> Masahiro Yamada
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> On Sun, Sep 10, 2023 at 4:20=E2=80=AFAM Masahiro Yamada <masahiroy@ke=
rnel.org> wrote:
>>>>> With a little more investigation,
>>>>> I found arch/parisc/kernel/parisc_ksyms.c
>>>>> is causing the issue.
>>>>>
>>>>> That file is a collection of EXPORT_SYMBOL
>>>>> of assembly code.
>>>>>
>>>>> I will take a closer look tomorrow.
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> On Sun, Sep 10, 2023 at 2:20=E2=80=AFAM Masahiro Yamada <masahiroy@k=
ernel.org> wrote:
>>>>>> On Fri, Sep 8, 2023 at 7:02=E2=80=AFAM John David Anglin <dave.angl=
in@bell.net> wrote:
>>>>>>> On 2023-09-05 7:59 p.m., John David Anglin wrote:
>>>>>>>> On 2023-09-05 5:57 p.m., John David Anglin wrote:
>>>>>>>>> I'll check ddb5cdbafaaa.
>>>>>>>> Similar fault with ddb5cdbafaaa:
>>>>>>> The alignment of the __kstrtab_ symbols in vmlinux seems wrong.
>>>>>> __kstrtab_ symbols do not need alignment.
>>>>>>
>>>>>> They were not aligned at all
>>>>>> before ddb5cdbafaaa^.
>>>>>>
>>>>>>
>>>>>>
>>>>>>> =C2=A0 I'm fairly certain that function
>>>>>>> references prefixed with P% on hppa64 need 8 byte alignment.
>>>>>> Yeah.
>>>>>> In the following dump, all of __ksymtab_* are correctly 8-byte alig=
ned.
>>>>>>
>>>>>>
>>>>>>> 81662: 0000000040ea4358=C2=A0=C2=A0=C2=A0=C2=A0 0 NOTYPE=C2=A0 LOC=
AL=C2=A0 DEFAULT=C2=A0=C2=A0 16 __kstrtab_system[...]
>>>>>>> =C2=A0=C2=A0 81663: 0000000040ea4748=C2=A0=C2=A0=C2=A0=C2=A0 0 NOT=
YPE=C2=A0 LOCAL DEFAULT=C2=A0=C2=A0 16 __kstrtabns_syst[...]
>>>>>>> =C2=A0=C2=A0 81664: 0000000040e8e830=C2=A0=C2=A0=C2=A0=C2=A0 0 NOT=
YPE=C2=A0 LOCAL DEFAULT=C2=A0=C2=A0 14 __ksymtab_system[...]
>>>>>>> =C2=A0=C2=A0 81665: 0000000040ea4365=C2=A0=C2=A0=C2=A0=C2=A0 0 NOT=
YPE=C2=A0 LOCAL DEFAULT=C2=A0=C2=A0 16 __kstrtab_static[...]
>>>>>>> =C2=A0=C2=A0 81666: 0000000040ea4748=C2=A0=C2=A0=C2=A0=C2=A0 0 NOT=
YPE=C2=A0 LOCAL DEFAULT=C2=A0=C2=A0 16 __kstrtabns_stat[...]
>>>>>>> =C2=A0=C2=A0 81667: 0000000040ea1640=C2=A0=C2=A0=C2=A0=C2=A0 0 NOT=
YPE=C2=A0 LOCAL DEFAULT=C2=A0=C2=A0 15 __ksymtab_static[...]
>>>>>>> =C2=A0=C2=A0 81668: 0000000040ea437c=C2=A0=C2=A0=C2=A0=C2=A0 0 NOT=
YPE=C2=A0 LOCAL DEFAULT=C2=A0=C2=A0 16 __kstrtab_reset_[...]
>>>>>>> =C2=A0=C2=A0 81669: 0000000040ea4748=C2=A0=C2=A0=C2=A0=C2=A0 0 NOT=
YPE=C2=A0 LOCAL DEFAULT=C2=A0=C2=A0 16 __kstrtabns_rese[...]
>>>>>>> =C2=A0=C2=A0 81670: 0000000040e8bbc0=C2=A0=C2=A0=C2=A0=C2=A0 0 NOT=
YPE=C2=A0 LOCAL DEFAULT=C2=A0=C2=A0 14 __ksymtab_reset_[...]
>>>>>>> =C2=A0=C2=A0 81671: 0000000040ea438a=C2=A0=C2=A0=C2=A0=C2=A0 0 NOT=
YPE=C2=A0 LOCAL DEFAULT=C2=A0=C2=A0 16 __kstrtab_loops_[...]
>>>>>>> =C2=A0=C2=A0 81672: 0000000040ea4748=C2=A0=C2=A0=C2=A0=C2=A0 0 NOT=
YPE=C2=A0 LOCAL DEFAULT=C2=A0=C2=A0 16 __kstrtabns_loop[...]
>>>>>>> =C2=A0=C2=A0 81673: 0000000040e86610=C2=A0=C2=A0=C2=A0=C2=A0 0 NOT=
YPE=C2=A0 LOCAL DEFAULT=C2=A0=C2=A0 14 __ksymtab_loops_[...]
>>>>>>> =C2=A0=C2=A0 81674: 0000000040ea439a=C2=A0=C2=A0=C2=A0=C2=A0 0 NOT=
YPE=C2=A0 LOCAL DEFAULT=C2=A0=C2=A0 16 __kstrtab_init_uts_ns
>>>>>>> =C2=A0=C2=A0 81675: 0000000040ea4748=C2=A0=C2=A0=C2=A0=C2=A0 0 NOT=
YPE=C2=A0 LOCAL DEFAULT=C2=A0=C2=A0 16 __kstrtabns_init[...]
>>>>>>> =C2=A0=C2=A0 81676: 0000000040e99180=C2=A0=C2=A0=C2=A0=C2=A0 0 NOT=
YPE=C2=A0 LOCAL DEFAULT=C2=A0=C2=A0 15 __ksymtab_init_uts_ns
>>>>>>> =C2=A0=C2=A0 81677: 0000000040ea43a6=C2=A0=C2=A0=C2=A0=C2=A0 0 NOT=
YPE=C2=A0 LOCAL DEFAULT=C2=A0=C2=A0 16 __kstrtab_name_t[...]
>>>>>>> =C2=A0=C2=A0 81678: 0000000040ea4748=C2=A0=C2=A0=C2=A0=C2=A0 0 NOT=
YPE=C2=A0 LOCAL DEFAULT=C2=A0=C2=A0 16 __kstrtabns_name[...]
>>>>>>> =C2=A0=C2=A0 81679: 0000000040e9b340=C2=A0=C2=A0=C2=A0=C2=A0 0 NOT=
YPE=C2=A0 LOCAL DEFAULT=C2=A0=C2=A0 15 __ksymtab_name_t[...]
>>>>>>> =C2=A0=C2=A0 81680: 0000000040ea43b4=C2=A0=C2=A0=C2=A0=C2=A0 0 NOT=
YPE=C2=A0 LOCAL DEFAULT=C2=A0=C2=A0 16 __kstrtab_wait_f[...]
>>>>>>> =C2=A0=C2=A0 81681: 0000000040ea4748=C2=A0=C2=A0=C2=A0=C2=A0 0 NOT=
YPE=C2=A0 LOCAL DEFAULT=C2=A0=C2=A0 16 __kstrtabns_wait[...]
>>>>>>> =C2=A0=C2=A0 81682: 0000000040ea3638=C2=A0=C2=A0=C2=A0=C2=A0 0 NOT=
YPE=C2=A0 LOCAL DEFAULT=C2=A0=C2=A0 15 __ksymtab_wait_f[...]
>>>>>>> =C2=A0=C2=A0 81683: 0000000040ea43c7=C2=A0=C2=A0=C2=A0=C2=A0 0 NOT=
YPE=C2=A0 LOCAL DEFAULT=C2=A0=C2=A0 16 __kstrtab_init_task
>>>>>>> [...]
>>>>>>>
>>>>>>> I'm not sure how we get symbols that aren't 8 byte aligned.=C2=A0 =
The ".balign 4" directive
>>>>>>> in __KSYMTAB doesn't seem correct but it's not the whole problem.
>>>>>>>
>>>>>>> Dave
>>
>
>

