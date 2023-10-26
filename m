Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4E87D7E6F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344543AbjJZI0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjJZI0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:26:04 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E589B8;
        Thu, 26 Oct 2023 01:25:59 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ca052ec63bso5189465ad.1;
        Thu, 26 Oct 2023 01:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698308759; x=1698913559; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+iKzrge+XeS+TJzT21RlmekRCrALeBarM6V8wS4DJs=;
        b=Lf+RiZNg3bh7yccY5A6bZWh50BLBTrX7OTm7GPnAHMX6Aovokgl1wVZnCkkl3sv8nV
         MwTVqCyNdPdBgERlPPVDl27uAx5fnvLRcYYy20mT6KQsU63BYOCm3TSnCiH9O+MgZxg+
         p7TqyMOrVGjbJx0X1Fwcm0e+LnIPogQJdpFYvfEMUZuJcz9ffMcaQuqhEH4ZZWMrNPKr
         NicIMWeiUaTUuZwOB67BLc8QA5TWIhXrApUtWRLe2udixbwUAFtxcfbndct6dCJzTl8z
         nqnNLbDoB7PryKgvFWmeQGY7RaLFWvAyRVOQOocTOTuwLAjaeYAK6E9aY2PKKpPu21rx
         SgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698308759; x=1698913559;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k+iKzrge+XeS+TJzT21RlmekRCrALeBarM6V8wS4DJs=;
        b=lDD1Gs6xMoe8qQGGDFh8zZcB7J5nPKLJrV/nnuqHOJjnSUrwaVn9ZbOoE4AD4KXSqW
         8/uwJcH4XpcfybixYjKNVlGxRO0/adplLbshYv37K8eaaUwo0hQN+RxKGIn2L72h+qI7
         ufJUUwqx5mwkpCFB8d8w3AU+apbfXBHikFmGoUe2rSPEUvIQdKRHF043Wb8QCc3B6Ecb
         KtgUZ7sYuOIADkG/9352rm7e7aqNWi388OSAJds2mijdvp01sc/F0bBcfk8jfj+I3/Kv
         GS088agVivSJt8mKRP/sTyOZmNPTwbRy0rdRMRi6HFVe7yYVhNpvM61bUrZkOKcG4GR5
         io2A==
X-Gm-Message-State: AOJu0Ywb+wTj/pYASHsZvWm1qsvxMhYCMfmcqOSyEpoyde3zfzA2bdHN
        UFdG5voR5uVZaOyls440XSmeuo6lDT4=
X-Google-Smtp-Source: AGHT+IHGJ7ZUE5cfNZOzfH0TLQRXrbqxtKyswYC6QS4a3MD7GiG74T0Jya2wFMHiBdH8PpY8zlvN7g==
X-Received: by 2002:a17:902:c782:b0:1c9:d111:9b27 with SMTP id w2-20020a170902c78200b001c9d1119b27mr15478591pla.32.1698308758613;
        Thu, 26 Oct 2023 01:25:58 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902da8600b001bf6ea340a9sm10481627plx.159.2023.10.26.01.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 01:25:58 -0700 (PDT)
Message-ID: <7e8fab39-8cdd-4527-8c4f-b18dd79cee14@gmail.com>
Date:   Thu, 26 Oct 2023 15:25:51 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux SCSI <linux-scsi@vger.kernel.org>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Jason Yan <yanaijie@huawei.com>,
        Nikolaos Barkas <nickosbarkas@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Marvell 88SE6320 SAS controller (mvsas) cannot survive ACPI S3
 or ACPI S4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a bug report on Bugzilla [1]. Quoting from it:

> Hello guys,
>=20
> marvell sas driver fails to resume from suspend/hibernate properly and =
the disks disappear. The issue most likely affects all the chips supporte=
d by this driver.
>=20
> For the first test, I booted the system with 2 ATA disks attached to th=
e onboard SAS controller and did a suspend/resume cycle followed by a get=
 health info cmd.
> For the second test, I booted the system with a SAS disk attached to th=
e onboard SAS controller and did a hibernate/resume cycle followed by a g=
nome disks read cmd.
> The boot drive is not attached to the marvell sas controller.
>=20
> When I try to access the disks after resuming from suspend/hibernate th=
e system becomes dead slow and the disks show no sign of life.
> The system cannot power off by itself at this stage, it needs a hard re=
set or a power off by the psu switch.=20
>=20
> The most important parts of the kernel log can be found below.
> I have provided mainly the mvsas messages and those that have to do wit=
h the suspend/resume.
>=20
> Suspend/resume with ata disks and then trying to get health info:
>=20
> [    0.000000] Linux version 6.1.57-vanilla (turbo@dbn-003) (gcc (Debia=
n 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #14 SMP PREEM=
PT_DYNAMIC Sat Oct 14 11:48:05 EEST 2023
> [    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-6.1.57-vanilla root=3D=
/dev/mapper/test-root ro quiet
>=20
> [    0.345919] pci 0000:06:00.0: [11ab:6440] type 00 class 0x010400
> [    0.345956] pci 0000:06:00.0: reg 0x18: [io  0xbc00-0xbc7f]
> [    0.345980] pci 0000:06:00.0: reg 0x20: [mem 0xfbaff000-0xfbafffff 6=
4bit]
> [    0.345991] pci 0000:06:00.0: reg 0x30: [mem 0xfba80000-0xfbabffff p=
ref]
> [    0.346048] pci 0000:06:00.0: supports D1
> [    0.346049] pci 0000:06:00.0: PME# supported from D0 D1 D3hot
> [    0.346078] pci 0000:06:00.0: 2.000 Gb/s available PCIe bandwidth, l=
imited by 2.5 GT/s PCIe x1 link at 0000:00:1c.4 (capable of 8.000 Gb/s wi=
th 2.5 GT/s PCIe x4 link)
> [    0.346130] pci 0000:06:00.0: disabling ASPM on pre-1.1 PCIe device.=
  You can enable it with 'pcie_aspm=3Dforce'
>=20
> [    1.455071] mvsas 0000:06:00.0: mvsas: driver version 0.8.16
> [    1.455288] mvsas 0000:06:00.0: mvsas: PCI-E x1, Bandwidth Usage: 2.=
5 Gbps
>=20
> [    4.295662] scsi host0: mvsas
> [    4.297425] sas: phy-0:0 added to port-0:0, phy_mask:0x1 (0000000000=
000000)
> [    4.297575] sas: DOING DISCOVERY on port 0, pid:76
> [    4.297638] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
> [    4.297683] sas: ata9: end_device-0:0: dev error handler
>=20
> [    4.458061] ata9.00: ATA-7: WDC WD740ADFD-00NLR4, 21.07QR4, max UDMA=
/133
> [    4.458068] ata9.00: 145226112 sectors, multi 0: LBA48 NCQ (depth 32=
)
> [    4.461181] ata9.00: configured for UDMA/133
> [    4.461304] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 t=
ries: 1
> [    4.471938] scsi 0:0:0:0: Direct-Access     ATA      WDC WD740ADFD-0=
0 7QR4 PQ: 0 ANSI: 5
> [    4.472713] sas: DONE DISCOVERY on port 0, pid:76, result:0
> [    4.472809] sas: phy-0:1 added to port-0:1, phy_mask:0x2 (0100000000=
000000)
> [    4.472901] sas: DOING DISCOVERY on port 1, pid:76
> [    4.472959] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
> [    4.472980] sas: ata9: end_device-0:0: dev error handler
> [    4.472996] sas: ata10: end_device-0:1: dev error handler
> [    4.601099] scsi 9:0:0:0: Direct-Access     Corsair  Flash Voyager  =
  1100 PQ: 0 ANSI: 0 CCS
> [    4.640508] ata10.00: ATA-8: WDC WD5002ABYS-01B1B0, 02.03B03, max UD=
MA/133
> [    4.640515] ata10.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 3=
2)
> [    4.641755] ata10.00: configured for UDMA/133
> [    4.641848] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 t=
ries: 1
> [    4.652603] scsi 0:0:1:0: Direct-Access     ATA      WDC WD5002ABYS-=
0 3B03 PQ: 0 ANSI: 5
> [    4.653764] sas: DONE DISCOVERY on port 1, pid:76, result:0
> [    4.654348] sd 0:0:0:0: [sdb] 145226112 512-byte logical blocks: (74=
=2E4 GB/69.2 GiB)
> [    4.654398] sd 0:0:0:0: [sdb] Write Protect is off
> [    4.654403] sd 0:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> [    4.654420] sd 0:0:1:0: [sdc] 976773168 512-byte logical blocks: (50=
0 GB/466 GiB)
> [    4.654445] sd 0:0:1:0: [sdc] Write Protect is off
> [    4.654448] sd 0:0:1:0: [sdc] Mode Sense: 00 3a 00 00
> [    4.654454] sd 0:0:0:0: [sdb] Write cache: enabled, read cache: enab=
led, doesn't support DPO or FUA
> [    4.654484] sd 0:0:1:0: [sdc] Write cache: enabled, read cache: enab=
led, doesn't support DPO or FUA
> [    4.654506] sd 0:0:0:0: [sdb] Preferred minimum I/O size 512 bytes
> [    4.654582] sd 0:0:1:0: [sdc] Preferred minimum I/O size 512 bytes
> [    4.669569] sd 0:0:0:0: [sdb] Attached SCSI disk
> [    4.689648]  sdc: sdc1 sdc2 sdc3 sdc4 sdc5 sdc6 sdc7
> [    4.690245] sd 0:0:1:0: [sdc] Attached SCSI disk
>=20
> [   13.638335] sd 0:0:0:0: Attached scsi generic sg1 type 0
> [   13.638855] sd 0:0:1:0: Attached scsi generic sg2 type 0
>=20
> [   13.845300] sas: Enter sas_scsi_recover_host busy: 1 failed: 1
> [   13.845305] sas: ata9: end_device-0:0: cmd error handler
> [   13.853646] sas: ata9: end_device-0:0: dev error handler
> [   13.853649] sas: ata10: end_device-0:1: dev error handler
> [   13.853737] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 1 t=
ries: 1
> [   14.031723] sas: Enter sas_scsi_recover_host busy: 1 failed: 1
> [   14.031732] sas: ata10: end_device-0:1: cmd error handler
> [   14.031795] sas: ata9: end_device-0:0: dev error handler
> [   14.031813] sas: ata10: end_device-0:1: dev error handler
> [   14.031906] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 1 t=
ries: 1
>=20
> [   15.007725] sas: Enter sas_scsi_recover_host busy: 1 failed: 1
> [   15.007731] sas: ata10: end_device-0:1: cmd error handler
> [   15.007752] sas: ata9: end_device-0:0: dev error handler
> [   15.007762] sas: ata10: end_device-0:1: dev error handler
> [   15.007777] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 1 t=
ries: 1
>=20
> [  252.047782] sas: Enter sas_scsi_recover_host busy: 1 failed: 1
> [  252.047790] sas: ata9: end_device-0:0: cmd error handler
> [  252.047868] sas: ata9: end_device-0:0: dev error handler
> [  252.047892] sas: ata10: end_device-0:1: dev error handler
> [  252.047938] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 1 t=
ries: 1
> [  252.287724] sas: Enter sas_scsi_recover_host busy: 1 failed: 1
> [  252.287731] sas: ata9: end_device-0:0: cmd error handler
> [  252.287791] sas: ata9: end_device-0:0: dev error handler
> [  252.287812] sas: ata10: end_device-0:1: dev error handler
> [  252.287846] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 1 t=
ries: 1
>=20
> [  437.249448] PM: suspend entry (deep)
> [  437.255308] Filesystems sync: 0.005 seconds
> [  437.255570] Freezing user space processes
> [  437.257093] Freezing user space processes completed (elapsed 0.001 s=
econds)
> [  437.257097] OOM killer disabled.
> [  437.257098] Freezing remaining freezable tasks
> [  437.258226] Freezing remaining freezable tasks completed (elapsed 0.=
001 seconds)
> [  437.258281] printk: Suspending console(s) (use no_console_suspend to=
 debug)
> [  437.291778] sd 0:0:0:0: [sdb] Synchronizing SCSI cache
> [  437.291825] sd 0:0:1:0: [sdc] Synchronizing SCSI cache
> [  437.292083] sd 0:0:0:0: [sdb] Stopping disk
> [  437.292083] sd 0:0:1:0: [sdc] Stopping disk
> [  438.363660] sd 1:0:0:0: [sda] Synchronizing SCSI cache
> [  438.363760] sd 1:0:0:0: [sda] Stopping disk
> [  440.904334] ACPI: PM: Preparing to enter system sleep state S3
> [  440.904747] ACPI: PM: Saving platform NVS memory
> [  440.905096] Disabling non-boot CPUs ...
> [  440.907196] smpboot: CPU 1 is now offline
> [  440.909798] smpboot: CPU 2 is now offline
> [  440.912577] smpboot: CPU 3 is now offline
> [  440.914657] smpboot: CPU 4 is now offline
> [  440.916752] smpboot: CPU 5 is now offline
> [  440.918814] smpboot: CPU 6 is now offline
> [  440.921256] smpboot: CPU 7 is now offline
> [  440.923173] smpboot: CPU 8 is now offline
> [  440.925090] smpboot: CPU 9 is now offline
> [  440.926963] smpboot: CPU 10 is now offline
> [  440.928796] smpboot: CPU 11 is now offline
> [  440.930412] ACPI: PM: Low-level resume complete
> [  440.930434] ACPI: PM: Restoring platform NVS memory
> [  440.930850] Enabling non-boot CPUs ...
> [  440.930895] x86: Booting SMP configuration:
> [  440.930896] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [  440.934817] CPU1 is up
> [  440.934853] smpboot: Booting Node 0 Processor 2 APIC 0x4
> [  440.937922] CPU2 is up
> [  440.937956] smpboot: Booting Node 0 Processor 3 APIC 0x10
> [  440.941085] CPU3 is up
> [  440.941119] smpboot: Booting Node 0 Processor 4 APIC 0x12
> [  440.944217] CPU4 is up
> [  440.944249] smpboot: Booting Node 0 Processor 5 APIC 0x14
> [  440.947416] CPU5 is up
> [  440.947450] smpboot: Booting Node 0 Processor 6 APIC 0x1
> [  440.950671] CPU6 is up
> [  440.950702] smpboot: Booting Node 0 Processor 7 APIC 0x3
> [  440.953929] CPU7 is up
> [  440.953959] smpboot: Booting Node 0 Processor 8 APIC 0x5
> [  440.957246] CPU8 is up
> [  440.957289] smpboot: Booting Node 0 Processor 9 APIC 0x11
> [  440.960652] CPU9 is up
> [  440.960680] smpboot: Booting Node 0 Processor 10 APIC 0x13
> [  440.964037] CPU10 is up
> [  440.964065] smpboot: Booting Node 0 Processor 11 APIC 0x15
> [  440.967511] CPU11 is up
> [  440.980236] ACPI: PM: Waking up from system sleep state S3
> [  440.982206] usb usb1: root hub lost power or was reset
> [  440.982228] usb usb2: root hub lost power or was reset
> [  440.982256] usb usb3: root hub lost power or was reset
> [  440.982289] usb usb5: root hub lost power or was reset
> [  440.982356] usb usb7: root hub lost power or was reset
> [  440.982397] usb usb8: root hub lost power or was reset
> [  441.361544] OOM killer enabled.
> [  441.361546] Restarting tasks ...=20
> [  441.362985] done.
> [  441.362992] random: crng reseeded on system resumption
> [  441.362996] PM: suspend exit
> [  441.521348] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  441.535235] ata1.00: configured for UDMA/133
> [  441.535456] ata1.00: Enabling discard_zeroes_data
> [  441.561306] firewire_core 0000:0b:04.0: rediscovered device fw0
> [  441.650468] RTL8211B Gigabit Ethernet r8169-0-800:00: attached PHY d=
river (mii_bus:phy_addr=3Dr8169-0-800:00, irq=3DMAC)
> [  441.715440] r8169 0000:08:00.0 enp8s0: Link is Down
> [  441.716682] RTL8211B Gigabit Ethernet r8169-0-900:00: attached PHY d=
river (mii_bus:phy_addr=3Dr8169-0-900:00, irq=3DMAC)
> [  441.780180] r8169 0000:09:00.0 enp9s0: Link is Down
> [  472.289330] usb 6-1: reset high-speed USB device number 2 using ehci=
-pci
>=20
> [  586.861381] sas: Enter sas_scsi_recover_host busy: 1 failed: 1
> [  586.861389] sas: trying to find task 0x00000000efe4484d
> [  586.861393] sas: sas_scsi_find_task: aborting task 0x00000000efe4484=
d
> [  586.861397] sas: sas_scsi_find_task: task 0x00000000efe4484d is abor=
ted
> [  586.861399] sas: sas_eh_handle_sas_errors: task 0x00000000efe4484d i=
s aborted
> [  586.861403] sas: ata10: end_device-0:1: cmd error handler
> [  586.861470] sas: ata9: end_device-0:0: dev error handler
> [  586.861486] sas: ata10: end_device-0:1: dev error handler
> [  589.081341] drivers/scsi/mvsas/mv_sas.c 1304:mvs_I_T_nexus_reset for=
 device[1]:rc=3D 0
> [  610.481270] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [  610.481280] rcu: 	11-...0: (0 ticks this GP) idle=3D4f84/1/0x4000000=
000000000 softirq=3D19873/19873 fqs=3D1159
> [  610.481292] 	(detected by 5, t=3D5252 jiffies, g=3D53581, q=3D31630 =
ncpus=3D12)
> [  610.481299] Sending NMI from CPU 5 to CPUs 11:
> [  610.481309] NMI backtrace for cpu 11
> [  610.481312] CPU: 11 PID: 3152 Comm: kworker/u32:59 Tainted: G       =
   I        6.1.57-vanilla #14
> [  610.481318] Hardware name: System manufacturer System Product Name/P=
6T WS PRO, BIOS 1205    09/24/2010
> [  610.481321] Workqueue: events_unbound async_run_entry_fn
> [  610.481329] RIP: 0010:mvs_int_rx+0x81/0x150 [mvsas]
> [  610.481346] Code: 00 00 44 39 75 70 74 47 48 8b 45 60 45 89 e6 41 81=
 e6 ff 03 00 00 41 8d 56 01 8b 1c 90 49 89 d4 41 89 df 41 81 e7 00 00 08 =
00 <f7> c3 00 00 01 00 74 58 31 d2 89 de 48 89 ef e8 0b f9 ff ff 45 85
> [  610.481350] RSP: 0018:ffffb61f06acbb60 EFLAGS: 00000046
> [  610.481354] RAX: ffff9a7cc2658000 RBX: 0000000000010000 RCX: 0000000=
000000000
> [  610.481358] RDX: 000000000000026e RSI: 0000000000010000 RDI: ffff9a7=
ce2660000
> [  610.481361] RBP: ffff9a7ce2660000 R08: ffff9a7ce2660f00 R09: ffff9a7=
ce2660000
> [  610.481364] R10: ffff9a7ce26600c8 R11: ffffffff884d4300 R12: 0000000=
00000026e
> [  610.481367] R13: 0000000000000000 R14: 000000000000026d R15: 0000000=
000000000
> [  610.481371] FS:  0000000000000000(0000) GS:ffff9a7df7cc0000(0000) kn=
lGS:0000000000000000
> [  610.481375] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  610.481378] CR2: 0000563633425300 CR3: 0000000077210006 CR4: 0000000=
0000206e0
> [  610.481382] Call Trace:
> [  610.481385]  <NMI>
> [  610.481389]  ? nmi_cpu_backtrace.cold+0x1b/0x76
> [  610.481398]  ? nmi_cpu_backtrace_handler+0xd/0x20
> [  610.481403]  ? nmi_handle+0x5d/0x120
> [  610.481410]  ? mvs_int_rx+0x81/0x150 [mvsas]
> [  610.481423]  ? default_do_nmi+0x69/0x170
> [  610.481428]  ? exc_nmi+0x13c/0x170
> [  610.481432]  ? end_repeat_nmi+0x16/0x67
> [  610.481443]  ? mvs_int_rx+0x81/0x150 [mvsas]
> [  610.481457]  ? mvs_int_rx+0x81/0x150 [mvsas]
> [  610.481470]  ? mvs_int_rx+0x81/0x150 [mvsas]
> [  610.481483]  </NMI>
> [  610.481484]  <TASK>
> [  610.481487]  mvs_do_release_task+0x3f/0x90 [mvsas]
> [  610.481501]  mvs_release_task+0x13e/0x1a0 [mvsas]
> [  610.481516]  mvs_I_T_nexus_reset+0xb2/0xd0 [mvsas]
> [  610.481530]  ? sas_ata_wait_after_reset+0x80/0x80 [libsas]
> [  610.481552]  sas_ata_hard_reset+0x48/0x80 [libsas]
> [  610.481575]  ata_eh_reset+0x2e5/0x1090 [libata]
> [  610.481631]  ? sas_ata_wait_after_reset+0x80/0x80 [libsas]
> [  610.481652]  ? sas_ata_wait_after_reset+0x80/0x80 [libsas]
> [  610.481676]  ata_eh_recover+0x2e6/0xe00 [libata]
> [  610.481728]  ? __wake_up_klogd.part.0+0x56/0x80
> [  610.481735]  ? vprintk_emit+0x207/0x290
> [  610.481739]  ? smp_ata_check_ready_type+0xb0/0xb0 [libsas]
> [  610.481760]  ? sas_ata_wait_after_reset+0x80/0x80 [libsas]
> [  610.481783]  ? smp_ata_check_ready_type+0xb0/0xb0 [libsas]
> [  610.481804]  ? sas_ata_wait_after_reset+0x80/0x80 [libsas]
> [  610.481824]  ata_do_eh+0x75/0xf0 [libata]
> [  610.481876]  ? del_timer_sync+0x6f/0xb0
> [  610.481884]  ata_scsi_port_error_handler+0x3a8/0x800 [libata]
> [  610.481938]  async_sas_ata_eh+0x44/0x7f [libsas]
> [  610.481960]  async_run_entry_fn+0x30/0x130
> [  610.481966]  process_one_work+0x1c7/0x380
> [  610.481974]  worker_thread+0x4d/0x380
> [  610.481981]  ? rescuer_thread+0x3a0/0x3a0
> [  610.481987]  kthread+0xe9/0x110
> [  610.481992]  ? kthread_complete_and_exit+0x20/0x20
> [  610.481999]  ret_from_fork+0x22/0x30
> [  610.482009]  </TASK>
> [  665.286198] NMI watchdog: Watchdog detected hard LOCKUP on cpu 11
> [  665.286200] Modules linked in: nls_ascii nls_cp437 vfat fat nvme_fab=
rics nvme_core snd_seq_dummy snd_hrtimer snd_seq snd_seq_device rfkill qr=
tr cpufreq_powersave cpufreq_ondemand cpufreq_conservative cpufreq_usersp=
ace binfmt_misc snd_hda_codec_analog snd_hda_codec_generic ledtrig_audio =
intel_powerclamp snd_hda_intel kvm_intel snd_intel_dspcfg snd_intel_sdw_a=
cpi kvm snd_hda_codec snd_hda_core irqbypass snd_hwdep intel_cstate iTCO_=
wdt snd_pcm intel_pmc_bxt iTCO_vendor_support snd_timer intel_uncore seri=
o_raw pcspkr watchdog snd soundcore i7core_edac i5500_temp sg asus_atk011=
0 evdev coretemp acpi_cpufreq hwmon_vid msr parport_pc ppdev lp parport f=
use efi_pstore loop configfs ip_tables x_tables autofs4 ext4 crc32c_gener=
ic crc16 mbcache jbd2 dm_crypt dm_mod hid_logitech_hidpp hid_logitech_dj =
sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft hid_generic crc_t10di=
f uas ata_generic crct10dif_generic usbhid hid usb_storage crc64 pata_mar=
vell nouveau crct10dif_pclmul crct10dif_common
> [  665.286238]  crc32_pclmul crc32c_intel ghash_clmulni_intel video sha=
512_ssse3 i2c_algo_bit sha512_generic drm_display_helper cec rc_core drm_=
ttm_helper mvsas ttm libsas ahci scsi_transport_sas drm_kms_helper r8169 =
libahci ehci_pci uhci_hcd realtek firewire_ohci ehci_hcd mxm_wmi aesni_in=
tel libata crypto_simd lpc_ich cryptd psmouse drm i2c_i801 mdio_devres sc=
si_mod usbcore i2c_smbus firewire_core libphy crc_itu_t scsi_common usb_c=
ommon wmi button
> [  665.286257] CPU: 11 PID: 3152 Comm: kworker/u32:59 Tainted: G       =
   I        6.1.57-vanilla #14
> [  665.286259] Hardware name: System manufacturer System Product Name/P=
6T WS PRO, BIOS 1205    09/24/2010
> [  665.286260] Workqueue: events_unbound async_run_entry_fn
> [  665.286265] RIP: 0010:mvs_slot_complete+0x0/0x540 [mvsas]
> [  665.286273] Code: 3c 05 00 00 48 c7 c6 28 36 8f c0 48 c7 c7 ac 36 8f=
 c0 e8 31 e4 af c6 89 d8 5b c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 =
00 <0f> 1f 44 00 00 41 57 41 56 41 55 41 89 f5 41 81 e5 ff 0f 00 00 41
> [  665.286275] RSP: 0018:ffffb61f06acbb58 EFLAGS: 00000046
> [  665.286276] RAX: ffff9a7cc2658000 RBX: 0000000000010006 RCX: 0000000=
000000000
> [  665.286277] RDX: 0000000000000000 RSI: 0000000000010006 RDI: ffff9a7=
ce2660000
> [  665.286278] RBP: ffff9a7ce2660000 R08: ffff9a7ce2660f00 R09: ffff9a7=
ce2660160
> [  665.286279] R10: ffff9a7ce26600c8 R11: ffffffff884d4300 R12: 0000000=
0000001a4
> [  665.286280] R13: 0000000000000000 R14: 00000000000001a3 R15: 0000000=
000000000
> [  665.286282] FS:  0000000000000000(0000) GS:ffff9a7df7cc0000(0000) kn=
lGS:0000000000000000
> [  665.286283] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  665.286284] CR2: 0000563633425300 CR3: 0000000077210006 CR4: 0000000=
0000206e0
> [  665.286286] Call Trace:
> [  665.286288]  <NMI>
> [  665.286290]  ? watchdog_overflow_callback.cold+0x20/0x7e
> [  665.286295]  ? __perf_event_overflow+0xe5/0x2a0
> [  665.286299]  ? handle_pmi_common+0x185/0x3a0
> [  665.286306]  ? intel_pmu_handle_irq+0x124/0x480
> [  665.286309]  ? perf_event_nmi_handler+0x26/0x50
> [  665.286312]  ? mvs_query_task+0x60/0x60 [mvsas]
> [  665.286317]  ? nmi_handle+0x5d/0x120
> [  665.286320]  ? mvs_query_task+0x60/0x60 [mvsas]
> [  665.286324]  ? default_do_nmi+0x69/0x170
> [  665.286326]  ? exc_nmi+0x13c/0x170
> [  665.286328]  ? end_repeat_nmi+0x16/0x67
> [  665.286332]  ? mvs_query_task+0x60/0x60 [mvsas]
> [  665.286336]  ? mvs_query_task+0x60/0x60 [mvsas]
> [  665.286341]  ? mvs_query_task+0x60/0x60 [mvsas]
> [  665.286346]  </NMI>
> [  665.286346]  <TASK>
> [  665.286347]  mvs_int_rx+0x95/0x150 [mvsas]
> [  665.286352]  mvs_do_release_task+0x3f/0x90 [mvsas]
> [  665.286357]  mvs_release_task+0x13e/0x1a0 [mvsas]
> [  665.286362]  mvs_I_T_nexus_reset+0xb2/0xd0 [mvsas]
> [  665.286368]  ? sas_ata_wait_after_reset+0x80/0x80 [libsas]
> [  665.286377]  sas_ata_hard_reset+0x48/0x80 [libsas]
> [  665.286386]  ata_eh_reset+0x2e5/0x1090 [libata]
> [  665.286413]  ? sas_ata_wait_after_reset+0x80/0x80 [libsas]
> [  665.286421]  ? sas_ata_wait_after_reset+0x80/0x80 [libsas]
> [  665.286429]  ata_eh_recover+0x2e6/0xe00 [libata]
> [  665.286448]  ? __wake_up_klogd.part.0+0x56/0x80
> [  665.286452]  ? vprintk_emit+0x207/0x290
> [  665.286454]  ? smp_ata_check_ready_type+0xb0/0xb0 [libsas]
> [  665.286464]  ? sas_ata_wait_after_reset+0x80/0x80 [libsas]
> [  665.286474]  ? smp_ata_check_ready_type+0xb0/0xb0 [libsas]
> [  665.286484]  ? sas_ata_wait_after_reset+0x80/0x80 [libsas]
> [  665.286495]  ata_do_eh+0x75/0xf0 [libata]
> [  665.286516]  ? del_timer_sync+0x6f/0xb0
> [  665.286519]  ata_scsi_port_error_handler+0x3a8/0x800 [libata]
> [  665.286538]  async_sas_ata_eh+0x44/0x7f [libsas]
> [  665.286546]  async_run_entry_fn+0x30/0x130
> [  665.286549]  process_one_work+0x1c7/0x380
> [  665.286553]  worker_thread+0x4d/0x380
> [  665.286555]  ? rescuer_thread+0x3a0/0x3a0
> [  665.286557]  kthread+0xe9/0x110
> [  665.286559]  ? kthread_complete_and_exit+0x20/0x20
> [  665.286562]  ret_from_fork+0x22/0x30
> [  665.286565]  </TASK>
> [  673.501273] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [  673.501280] rcu: 	11-...0: (0 ticks this GP) idle=3D4f84/1/0x4000000=
000000000 softirq=3D19873/19873 fqs=3D4311
> [  673.501286] 	(detected by 0, t=3D21007 jiffies, g=3D53581, q=3D12069=
6 ncpus=3D12)
> [  673.501289] Sending NMI from CPU 0 to CPUs 11:
> [  673.501296] NMI backtrace for cpu 11
> [  673.501298] CPU: 11 PID: 3152 Comm: kworker/u32:59 Tainted: G       =
   I        6.1.57-vanilla #14
> [  673.501301] Hardware name: System manufacturer System Product Name/P=
6T WS PRO, BIOS 1205    09/24/2010
> [  673.501302] Workqueue: events_unbound async_run_entry_fn
> [  673.501306] RIP: 0010:mvs_slot_complete+0x28/0x540 [mvsas]
> [  673.501315] Code: 00 00 0f 1f 44 00 00 41 57 41 56 41 55 41 89 f5 41=
 81 e5 ff 0f 00 00 41 54 45 89 ec 55 4b 8d 04 a4 53 49 8d 04 44 48 c1 e0 =
03 <4c> 8d 0c 07 48 83 ec 20 49 8b 99 08 fd 00 00 89 54 24 08 4c 89 0c
> [  673.501316] RSP: 0018:ffffb61f06acbb28 EFLAGS: 00000046
> [  673.501318] RAX: 0000000000000000 RBX: 0000000000010000 RCX: 0000000=
000000000
> [  673.501319] RDX: 0000000000000000 RSI: 0000000000010000 RDI: ffff9a7=
ce2660000
> [  673.501320] RBP: ffff9a7ce2660000 R08: ffff9a7ce2660f00 R09: ffff9a7=
ce2660058
> [  673.501321] R10: ffff9a7ce26600c8 R11: ffffffff884d4300 R12: 0000000=
000000000
> [  673.501322] R13: 0000000000000000 R14: 0000000000000149 R15: 0000000=
000000000
> [  673.501323] FS:  0000000000000000(0000) GS:ffff9a7df7cc0000(0000) kn=
lGS:0000000000000000
> [  673.501324] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  673.501325] CR2: 0000563633425300 CR3: 0000000077210006 CR4: 0000000=
0000206e0
> [  673.501327] Call Trace:
> [  673.501329]  <NMI>
> [  673.501331]  ? nmi_cpu_backtrace.cold+0x1b/0x76
> [  673.501335]  ? nmi_cpu_backtrace_handler+0xd/0x20
> [  673.501337]  ? nmi_handle+0x5d/0x120
> [  673.501340]  ? mvs_slot_complete+0x28/0x540 [mvsas]
> [  673.501345]  ? default_do_nmi+0x69/0x170
> [  673.501347]  ? exc_nmi+0x13c/0x170
> [  673.501348]  ? end_repeat_nmi+0x16/0x67
> [  673.501353]  ? mvs_slot_complete+0x28/0x540 [mvsas]
> [  673.501358]  ? mvs_slot_complete+0x28/0x540 [mvsas]
> [  673.501362]  ? mvs_slot_complete+0x28/0x540 [mvsas]
> [  673.501367]  </NMI>
> [  673.501368]  <TASK>
> [  673.501369]  mvs_int_rx+0x95/0x150 [mvsas]
> [  673.501374]  mvs_do_release_task+0x3f/0x90 [mvsas]
> [  673.501379]  mvs_release_task+0x13e/0x1a0 [mvsas]
> [  673.501384]  mvs_I_T_nexus_reset+0xb2/0xd0 [mvsas]
> [  673.501389]  ? sas_ata_wait_after_reset+0x80/0x80 [libsas]
> [  673.501399]  sas_ata_hard_reset+0x48/0x80 [libsas]
> [  673.501407]  ata_eh_reset+0x2e5/0x1090 [libata]
> [  673.501433]  ? sas_ata_wait_after_reset+0x80/0x80 [libsas]
> [  673.501440]  ? sas_ata_wait_after_reset+0x80/0x80 [libsas]
> [  673.501449]  ata_eh_recover+0x2e6/0xe00 [libata]
> [  673.501467]  ? __wake_up_klogd.part.0+0x56/0x80
> [  673.501470]  ? vprintk_emit+0x207/0x290
> [  673.501471]  ? smp_ata_check_ready_type+0xb0/0xb0 [libsas]
> [  673.501479]  ? sas_ata_wait_after_reset+0x80/0x80 [libsas]
> [  673.501487]  ? smp_ata_check_ready_type+0xb0/0xb0 [libsas]
> [  673.501495]  ? sas_ata_wait_after_reset+0x80/0x80 [libsas]
> [  673.501502]  ata_do_eh+0x75/0xf0 [libata]
> [  673.501521]  ? del_timer_sync+0x6f/0xb0
> [  673.501523]  ata_scsi_port_error_handler+0x3a8/0x800 [libata]
> [  673.501542]  async_sas_ata_eh+0x44/0x7f [libsas]
> [  673.501551]  async_run_entry_fn+0x30/0x130
> [  673.501553]  process_one_work+0x1c7/0x380
> [  673.501556]  worker_thread+0x4d/0x380
> [  673.501558]  ? rescuer_thread+0x3a0/0x3a0
> [  673.501561]  kthread+0xe9/0x110
> [  673.501563]  ? kthread_complete_and_exit+0x20/0x20
> [  673.501565]  ret_from_fork+0x22/0x30
> [  673.501569]  </TASK>
>=20
>=20
>=20
> Hibernate/resume with a sas disk and then running gnome disks for a cou=
ple of reads:
>=20
> [    0.000000] Linux version 6.1.57-vanilla (turbo@dbn-003) (gcc (Debia=
n 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #14 SMP PREEM=
PT_DYNAMIC Sat Oct 14 11:48:05 EEST 2023
> [    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-6.1.57-vanilla root=3D=
/dev/mapper/test-root ro quiet
>=20
>     4.191667] scsi host0: mvsas
> [    4.202932] sas: phy-0:1 added to port-0:0, phy_mask:0x2 (2bad2bad2b=
ad2bad)
> [    4.202935] drivers/scsi/mvsas/mv_sas.c 1099:set wide port phy map 2=

> [    4.232802] sas: DOING DISCOVERY on port 0, pid:78
> [    4.234233] scsi 0:0:0:0: Direct-Access     WD       WD3001HKHG-02VU=
C SR07 PQ: 0 ANSI: 6
> [    4.234723] scsi 0:0:0:0: Power-on or device reset occurred
> [    4.243180] sas: DONE DISCOVERY on port 0, pid:78, result:0
> [    4.243958] sd 0:0:0:0: [sdb] 586072368 512-byte logical blocks: (30=
0 GB/279 GiB)
> [    4.251366] sd 0:0:0:0: [sdb] Write Protect is off
> [    4.251372] sd 0:0:0:0: [sdb] Mode Sense: df 00 10 08
> [    4.256088] sd 0:0:0:0: [sdb] Write cache: disabled, read cache: ena=
bled, supports DPO and FUA
>=20
> [  331.841349] PM: hibernation: hibernation entry
> [  331.846068] Filesystems sync: 0.004 seconds
> [  331.846251] Freezing user space processes
> [  331.847662] Freezing user space processes completed (elapsed 0.001 s=
econds)
> [  331.847665] OOM killer disabled.
> [  331.847752] PM: hibernation: Marking nosave pages: [mem 0x00000000-0=
x00000fff]
> [  331.847754] PM: hibernation: Marking nosave pages: [mem 0x0009c000-0=
x000fffff]
> [  331.847757] PM: hibernation: Marking nosave pages: [mem 0xbf780000-0=
xffffffff]
> [  331.848818] PM: hibernation: Basic memory bitmaps created
> [  331.848868] PM: hibernation: Preallocating image memory
> [  332.320952] PM: hibernation: Allocated 468298 pages for snapshot
> [  332.320958] PM: hibernation: Allocated 1873192 kbytes in 0.47 second=
s (3985.51 MB/s)
> [  332.320961] Freezing remaining freezable tasks
> [  332.322205] Freezing remaining freezable tasks completed (elapsed 0.=
001 seconds)
> [  332.322378] printk: Suspending console(s) (use no_console_suspend to=
 debug)
> [  334.826522] ACPI: PM: Preparing to enter system sleep state S4
> [  334.826773] ACPI: PM: Saving platform NVS memory
> [  334.826979] Disabling non-boot CPUs ...
> [  334.829452] smpboot: CPU 1 is now offline
> [  334.831537] smpboot: CPU 2 is now offline
> [  334.833750] smpboot: CPU 3 is now offline
> [  334.835897] smpboot: CPU 4 is now offline
> [  334.838296] smpboot: CPU 5 is now offline
> [  334.840868] smpboot: CPU 6 is now offline
> [  334.842966] smpboot: CPU 7 is now offline
> [  334.845060] smpboot: CPU 8 is now offline
> [  334.847030] smpboot: CPU 9 is now offline
> [  334.848955] smpboot: CPU 10 is now offline
> [  334.850837] smpboot: CPU 11 is now offline
> [  334.851340] PM: hibernation: Creating image:
> [  335.133820] PM: hibernation: Need to copy 480821 pages
> [  335.133826] PM: hibernation: Normal pages needed: 480821 + 1024, ava=
ilable pages: 1613904
> [  334.852388] ACPI: PM: Restoring platform NVS memory
> [  334.852777] Enabling non-boot CPUs ...
> [  334.852817] x86: Booting SMP configuration:
> [  334.852818] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [  334.856338] CPU1 is up
> [  334.856369] smpboot: Booting Node 0 Processor 2 APIC 0x4
> [  334.859345] CPU2 is up
> [  334.859375] smpboot: Booting Node 0 Processor 3 APIC 0x10
> [  334.862383] CPU3 is up
> [  334.862412] smpboot: Booting Node 0 Processor 4 APIC 0x12
> [  334.865376] CPU4 is up
> [  334.865407] smpboot: Booting Node 0 Processor 5 APIC 0x14
> [  334.868395] CPU5 is up
> [  334.868423] smpboot: Booting Node 0 Processor 6 APIC 0x1
> [  334.871618] CPU6 is up
> [  334.871649] smpboot: Booting Node 0 Processor 7 APIC 0x3
> [  334.874844] CPU7 is up
> [  334.874878] smpboot: Booting Node 0 Processor 8 APIC 0x5
> [  334.878160] CPU8 is up
> [  334.878189] smpboot: Booting Node 0 Processor 9 APIC 0x11
> [  334.881557] CPU9 is up
> [  334.881586] smpboot: Booting Node 0 Processor 10 APIC 0x13
> [  334.884946] CPU10 is up
> [  334.884974] smpboot: Booting Node 0 Processor 11 APIC 0x15
> [  334.888415] CPU11 is up
> [  334.901008] ACPI: PM: Waking up from system sleep state S4
> [  335.001313] usb usb4: root hub lost power or was reset
> [  335.001314] usb usb2: root hub lost power or was reset
> [  335.001314] usb usb5: root hub lost power or was reset
> [  335.001365] usb usb1: root hub lost power or was reset
> [  335.001372] usb usb6: root hub lost power or was reset
> [  335.001375] usb usb7: root hub lost power or was reset
> [  335.001428] usb usb8: root hub lost power or was reset
> [  335.001449] usb usb3: root hub lost power or was reset
> [  335.297280] usb 3-4: reset high-speed USB device number 2 using ehci=
-pci
> [  335.537215] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  335.549624] ata1.00: configured for UDMA/133
> [  335.549810] ata1.00: Enabling discard_zeroes_data
> [  335.769243] usb 3-4.3: reset full-speed USB device number 3 using eh=
ci-pci
> [  335.957245] usb 3-4.4: reset full-speed USB device number 4 using eh=
ci-pci
> [  336.385247] usb 3-4.4.1: reset full-speed USB device number 5 using =
ehci-pci
> [  336.539864] PM: hibernation: Basic memory bitmaps freed
> [  336.540367] OOM killer enabled.
> [  336.540368] Restarting tasks ...=20
> [  336.541593] done.
> [  336.541600] PM: hibernation: hibernation exit
> [  336.636953] RTL8211B Gigabit Ethernet r8169-0-800:00: attached PHY d=
river (mii_bus:phy_addr=3Dr8169-0-800:00, irq=3DMAC)
> [  336.703336] r8169 0000:08:00.0 enp8s0: Link is Down
> [  336.704991] RTL8211B Gigabit Ethernet r8169-0-900:00: attached PHY d=
river (mii_bus:phy_addr=3Dr8169-0-900:00, irq=3DMAC)
> [  336.772497] r8169 0000:09:00.0 enp9s0: Link is Down
>=20
> [  463.977280] sas: Enter sas_scsi_recover_host busy: 3 failed: 3
> [  463.977288] sas: trying to find task 0x00000000f13c22cf
> [  463.977292] sas: sas_scsi_find_task: aborting task 0x00000000f13c22c=
f
> [  463.977416] sas: task done but aborted
> [  463.977422] sas: sas_scsi_find_task: task 0x00000000f13c22cf is done=

> [  463.977425] sas: sas_eh_handle_sas_errors: task 0x00000000f13c22cf i=
s done
> [  463.977429] sas: trying to find task 0x0000000089d39e25
> [  463.977431] sas: sas_scsi_find_task: aborting task 0x0000000089d39e2=
5
> [  472.026033] sas: task done but aborted
> [  472.026040] sas: sas_scsi_find_task: task 0x0000000089d39e25 is done=

> [  472.026044] sas: sas_eh_handle_sas_errors: task 0x0000000089d39e25 i=
s done
> [  472.026048] sas: trying to find task 0x000000002d226601
> [  472.026050] sas: sas_scsi_find_task: aborting task 0x000000002d22660=
1
> [  492.601193] sas: TMF task timeout for 2bad2bad2bad2bad and not done
> [  492.601204] drivers/scsi/mvsas/mv_sas.c 1410:mvs_abort_task:rc=3D 5
> [  492.601208] sas: sas_scsi_find_task: querying task 0x000000002d22660=
1
> [  513.081228] sas: TMF task timeout for 2bad2bad2bad2bad and not done
> [  513.081241] drivers/scsi/mvsas/mv_sas.c 1340:mvs_query_task:rc=3D 5
> [  513.081247] sas: sas_scsi_find_task: task 0x000000002d226601 failed =
to abort
> [  513.081252] sas: task 0x000000002d226601 is not at LU: I_T recover
> [  513.081255] sas: I_T nexus reset for dev 2bad2bad2bad2bad
> [  513.577383] drivers/scsi/mvsas/mv_sas.c 1690:Release slot [5] tag[5]=
, task [000000002d226601]:
> [  513.577396] sas: task done but aborted
> [  513.577398] drivers/scsi/mvsas/mv_sas.c 1690:Release slot [1] tag[1]=
, task [00000000d0d28957]:
> [  515.321219] drivers/scsi/mvsas/mv_sas.c 1304:mvs_I_T_nexus_reset for=
 device[0]:rc=3D 0
> [  515.321226] sas: I_T 2bad2bad2bad2bad recovered
> [  515.321243] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 3 t=
ries: 1
> [  515.337273] sd 0:0:0:0: [sdb] tag#8 FAILED Result: hostbyte=3DDID_NO=
_CONNECT driverbyte=3DDRIVER_OK cmd_age=3D81s
> [  515.337281] sd 0:0:0:0: [sdb] tag#8 CDB: Read(10) 28 00 11 77 78 98 =
00 04 00 00
> [  515.337283] I/O error, dev sdb, sector 293042328 op 0x0:(READ) flags=
 0x4000 phys_seg 8 prio class 2
> [  515.337299] sd 0:0:0:0: [sdb] tag#9 FAILED Result: hostbyte=3DDID_NO=
_CONNECT driverbyte=3DDRIVER_OK cmd_age=3D81s
> [  515.337303] sd 0:0:0:0: [sdb] tag#9 CDB: Read(10) 28 00 11 77 7c 98 =
00 04 00 00
> [  515.337305] I/O error, dev sdb, sector 293043352 op 0x0:(READ) flags=
 0x4000 phys_seg 8 prio class 2
> [  515.337315] sd 0:0:0:0: [sdb] tag#10 FAILED Result: hostbyte=3DDID_N=
O_CONNECT driverbyte=3DDRIVER_OK cmd_age=3D81s
> [  515.337318] sd 0:0:0:0: [sdb] tag#10 CDB: Read(10) 28 00 11 77 80 98=
 00 04 00 00
> [  515.337320] I/O error, dev sdb, sector 293044376 op 0x0:(READ) flags=
 0x4000 phys_seg 9 prio class 2
> [  515.710666] drivers/scsi/mvsas/mv_sas.c 1099:set wide port phy map 2=

> [  515.710714] sas: sas_form_port: phy1 belongs to port0 already(1)!
> [  519.721300] drivers/scsi/mvsas/mv_sas.c 1690:Release slot [1] tag[1]=
, task [00000000d0d28957]:
> [  521.822694] drivers/scsi/mvsas/mv_sas.c 1099:set wide port phy map 2=

> [  521.822702] sas: sas_form_port: phy1 belongs to port0 already(1)!

See Bugzilla for the full thread.

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D218030

--=20
An old man doll... just what I always wanted! - Clara
