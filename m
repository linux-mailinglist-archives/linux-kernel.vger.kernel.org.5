Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6841F79DB2D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 23:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237052AbjILVxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 17:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbjILVxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:53:21 -0400
Received: from cmx-mtlrgo002.bell.net (mta-mtl-005.bell.net [209.71.208.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0854B10D2;
        Tue, 12 Sep 2023 14:53:17 -0700 (PDT)
X-RG-CM-BuS: 0
X-RG-CM-SC: 0
X-RG-CM: Clean
X-Originating-IP: [174.88.80.174]
X-RG-Env-Sender: dave.anglin@bell.net
X-RG-Rigid: 64FAC33300919743
X-CM-Envelope: MS4xfIcrCkMt7E3wY2IWRwPGuTmLnt2Z14XblFwiWfJFW6rOFLvmQofyLJNARNg4lmIMtvtPRWn8PBJsNc8Dz8knbAcALJ1BRPZx9O9RaaEdrLPPqdSNh9Q+
 OBDTO/XRunn87he1UxFZlXK3+UO58Z+j5ewWFDE/m3najQGv0GvYRwExYzI1BssePSdcDeBgNv3h6i07v5KT5LnkihHSiKOR2Zk08ojjqPvyiSVu6juurSHh
 9xsJrH7AE0+BCIz1/b6MZ355fGeaNj7ypbmR/WWvHhfaE5biXjr+1hZwUAxrRF9SSqjW378RfoG8KGew4ZaTC3yicxswCQTKv1B0i5+SnjjaJYYdxpocNfub
 NJ8UcgRYs9fQfg+ko3os0aAokl8FBI4GlPUWEE5S6bBk4dAtnMhywMY3yzmIpeUnnPGUXPAwG1YVS9k2VcJ897p/DrcgdYfYTLz0AGrK38yAyptvn86WlINk
 Aa70ArispwkY5LTh
X-CM-Analysis: v=2.4 cv=QbcFAuXv c=1 sm=1 tr=0 ts=6500ddc2
 a=NkkRUIc9Fga6GQ4JCcDOLQ==:117 a=NkkRUIc9Fga6GQ4JCcDOLQ==:17
 a=IkcTkHD0fZMA:10 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=FBHGMhGWAAAA:8
 a=xzjvN3707cN-AbLt1MIA:9 a=QEXdDO2ut3YA:10 a=HkZW87K1Qel5hWWM3VKY:22
 a=AjGcO6oz07-iQ99wixmX:22 a=9gvnlMMaQFpL9xblJ6ne:22
Received: from [192.168.2.49] (174.88.80.174) by cmx-mtlrgo002.bell.net (5.8.814) (authenticated as dave.anglin@bell.net)
        id 64FAC33300919743; Tue, 12 Sep 2023 17:53:06 -0400
Message-ID: <b919c7fd-babb-5557-dd8d-c2b8bb428d54@bell.net>
Date:   Tue, 12 Sep 2023 17:53:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] linux/export: fix reference to exported functions for
 parisc64
Content-Language: en-US
From:   John David Anglin <dave.anglin@bell.net>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Helge Deller <deller@gmx.de>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
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
In-Reply-To: <040a0941-936b-87ab-aedd-5a933383b500@bell.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-10 5:30 p.m., John David Anglin wrote:
> Hi Masahiro,
>
> The attached change fixed boot at ddb5cdbafaaa 😁
>
> However, v6.5.x boot is still broken:
>
> Run /init as init process
> process '/usr/bin/sh' started with executable stack
> Loading, please wait...
> Starting systemd-udevd version 254.1-3
> e1000 alternatives: applied 0 out of 569 patches
> e1000: Intel(R) PRO/1000 Network Driver
> e1000: Copyright (c) 1999-2006 Intel Corporation.
> scsi_mod alternatives: applied 0 out of 7 patches
> SCSI subsystem initialized
> usbcore alternatives: applied 0 out of 18 patches
> usbcore: registered new interface driver usbfs
> libata alternatives: applied 0 out of 3 patches
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> mptbase alternatives: applied 0 out of 73 patches
> ehci_hcd alternatives: applied 0 out of 114 patches
> sata_sil24 alternatives: applied 0 out of 56 patches
> Fusion MPT base driver 3.04.20
> Copyright (c) 1999-2008 LSI Corporation
> sata_sil24 0000:00:01.0: Applying completion IRQ loss on PCI-X errata fix
> scsi host0: sata_sil24
> scsi host1: sata_sil24
> pata_sil680 0000:60:02.0: sil680: 133MHz clock.
> scsi host2: sata_sil24
> ehci_pci alternatives: applied 0 out of 2 patches
> ohci_hcd alternatives: applied 0 out of 144 patches
> ehci-pci 0000:60:01.2: EHCI Host Controller
> scsi host3: pata_sil680
> ehci-pci 0000:60:01.2: new USB bus registered, assigned bus number 1
> scsi host4: sata_sil24
> ata1: SATA max UDMA/100 host m128@0xffffffff80088000 port 0xffffffff80080000 ir6
> ata2: SATA max UDMA/100 host m128@0xffffffff80088000 port 0xffffffff80082000 ir6
> ata3: SATA max UDMA/100 host m128@0xffffffff80088000 port 0xffffffff80084000 ir6
> ata4: SATA max UDMA/100 host m128@0xffffffff80088000 port 0xffffffff80086000 ir6
> e1000 0000:60:03.0 eth0: (PCI:33MHz:32-bit) 00:11:0a:31:8a:77
> ehci-pci 0000:60:01.2: irq 71, io mem 0xffffffffb00a1000
> scsi host5: pata_sil680
> ata5: PATA max UDMA/133 cmd 0x26058 ctl 0x26064 bmdma 0x26040 irq 72
> ata6: PATA max UDMA/133 cmd 0x26050 ctl 0x26060 bmdma 0x26048 irq 72
> e1000 0000:60:03.0 eth0: Intel(R) PRO/1000 Network Connection
> ehci-pci 0000:60:01.2: USB 2.0 started, EHCI 0.95
> usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.05
> usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb1: Product: EHCI Host Controller
> usb usb1: Manufacturer: Linux 6.5.2-dirty ehci_hcd
> usb usb1: SerialNumber: 0000:60:01.2
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 5 ports detected
> ata1: SATA link down (SStatus 0 SControl 0)
> ata2: SATA link down (SStatus 0 SControl 0)
> ata3: SATA link down (SStatus 0 SControl 0)
> ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata4.00: ATA-10: ST4000VN008-2DR166, SC60, max UDMA/133
> ata4.00: 7814037168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> ata4.00: configured for UDMA/100
> scsi 4:0:0:0: Direct-Access     ATA      ST4000VN008-2DR1 SC60 PQ: 0 ANSI: 5
> ata6.00: ATAPI: HL-DT-STDVD+-RW GSA-H21L, 1.04, max UDMA/44
> scsi 5:0:0:0: CD-ROM            HL-DT-ST DVD+-RW GSA-H21L 1.04 PQ: 0 ANSI: 5
> random: crng init done
> Timed out for waiting the udev queue being empty.
> Begin: Loading essential drivers ... done.
> Begin: Running /scripts/init-premount ... done.
> Begin: Mounting root file system ... Begin: Running /scripts/local-top ... done.
> Begin: Running /scripts/local-premount ... done.
> Timed out for waiting the udev queue being empty.
> Begin: Waiting for root file system ... Begin: Running /scripts/local-block ....
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> done.
> Gave up waiting for root file system device.  Common problems:
>  - Boot args (cat /proc/cmdline)
>    - Check rootdelay= (did the system wait long enough?)
>  - Missing modules (cat /proc/modules; ls /dev)
> ALERT!  LABEL=ROOT does not exist.  Dropping to a shell!
> Rebooting automatically due to panic= boot argument
>
> I'll see if I can find the commit that breaks 6.5.
I've traced this to the following merge commit:

dave@atlas:~/linux/linux$ git bisect good
ca7ce08d6a063e0ccb91dc57f9bc213120d0d1a7 is the first bad commit
commit ca7ce08d6a063e0ccb91dc57f9bc213120d0d1a7
Merge: 1546cd4bfda4 af92c02fb209
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri Jun 30 11:57:07 2023 -0700

     Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi

     Pull SCSI updates from James Bottomley:
      "Updates to the usual drivers (ufs, pm80xx, libata-scsi, smartpqi,
       lpfc, qla2xxx).

       We have a couple of major core changes impacting other systems:

        - Command Duration Limits, which spills into block and ATA

        - block level Persistent Reservation Operations, which touches block,
          nvme, target and dm

       Both of these are added with merge commits containing a cover letter
       explaining what's going on"

     * tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi: (187 commits)
       scsi: core: Improve warning message in scsi_device_block()
       scsi: core: Replace scsi_target_block() with scsi_block_targets()
       scsi: core: Don't wait for quiesce in scsi_device_block()
       scsi: core: Don't wait for quiesce in scsi_stop_queue()
       scsi: core: Merge scsi_internal_device_block() and device_block()
       scsi: sg: Increase number of devices
       scsi: bsg: Increase number of devices
       scsi: qla2xxx: Remove unused nvme_ls_waitq wait queue
       scsi: ufs: ufs-pci: Add support for Intel Arrow Lake
       scsi: sd: sd_zbc: Use PAGE_SECTORS_SHIFT
       scsi: ufs: wb: Add explicit flush_threshold sysfs attribute
       scsi: ufs: ufs-qcom: Switch to the new ICE API
       scsi: ufs: dt-bindings: qcom: Add ICE phandle
       scsi: ufs: ufs-mediatek: Set UFSHCD_QUIRK_MCQ_BROKEN_RTC quirk
       scsi: ufs: ufs-mediatek: Set UFSHCD_QUIRK_MCQ_BROKEN_INTR quirk
       scsi: ufs: core: Add host quirk UFSHCD_QUIRK_MCQ_BROKEN_RTC
       scsi: ufs: core: Add host quirk UFSHCD_QUIRK_MCQ_BROKEN_INTR
       scsi: ufs: core: Remove dedicated hwq for dev command
       scsi: ufs: core: mcq: Fix the incorrect OCS value for the device command
       scsi: ufs: dt-bindings: samsung,exynos: Drop unneeded quotes
       ...

dave@atlas:~/linux/linux$ lspci
00:01.0 RAID bus controller: Silicon Image, Inc. SiI 3124 PCI-X Serial ATA Controller (rev 02)
40:01.0 SCSI storage controller: Broadcom / LSI 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 07)
40:01.1 SCSI storage controller: Broadcom / LSI 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 07)
60:01.0 USB controller: NEC Corporation OHCI USB Controller (rev 41)
60:01.1 USB controller: NEC Corporation OHCI USB Controller (rev 41)
60:01.2 USB controller: NEC Corporation uPD72010x USB 2.0 Controller (rev 02)
60:02.0 IDE interface: Silicon Image, Inc. PCI0680 Ultra ATA-133 Host Controller (rev 02)
60:03.0 Ethernet controller: Intel Corporation 82540EM Gigabit Ethernet Controller (rev 02)

Dave

-- 
John David Anglin  dave.anglin@bell.net

