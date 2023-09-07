Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF31B797D91
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 22:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjIGUtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 16:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjIGUtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 16:49:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EB11BCB;
        Thu,  7 Sep 2023 13:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694119744; x=1694724544; i=s.l-h@gmx.de;
 bh=MtXqy4RdyS/achTFtmU3C7IbOQZC319wHC/pSZl6Tm4=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=i5arviMqP9xrR7+ew22ivgKSt7jl6Iag7B9/4Z2CgE3vNwfKaZK9YiEEG3/KSBqJu/rs4OU
 SU9A7s3VmJDX1XnChiKxH8rvEGMRV4vui8uBkmNJ0YyAY0WK+WYUVUL5VeFy0+m7VPFLdx3+N
 UJ4Ndw+kYjzAAGC4dUF/FQmHmfoorrxMwCC9n5ALUQCCuhK6GWYTs/bc02Dq3rvTgtQyhcpFr
 U0c9J1GDcOz+RtTrswnJhZt7EQYi5FciODcwcn8/oRFT8DNNun+J3viC5shK16XRdgAQvi9Ew
 JUc949J2KNNjz3/tPZbXmEeESbc2U8Mf/4ga+wMVl10wAEWPgdlg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mir ([94.31.85.155]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mf07E-1pz1T10vNa-00gbdB; Thu, 07
 Sep 2023 08:41:45 +0200
Date:   Thu, 7 Sep 2023 08:41:35 +0200
From:   Stefan Lippers-Hollmann <s.l-h@gmx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.5 11/34] modules: only allow symbol_get of
 EXPORT_SYMBOL_GPL modules
Message-ID: <20230907084135.02d97441@mir>
In-Reply-To: <20230904182949.104100132@linuxfoundation.org>
References: <20230904182948.594404081@linuxfoundation.org>
        <20230904182949.104100132@linuxfoundation.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2Fy5toPkMEYQqq4loPz4mBFk8T1GnH3q6lOrZmBJOUnNmotKBqr
 acOEkqAmMW1Mn3C0a8Db8s7O6jJuE/1jgx9XjMCoe8whZNm0ym/C6KBcUfzJdyN4CNYN5lF
 KYDkSNy0guWcTxJPz8Aq5vWgJ8+YYaUUBed3BrM5dkz3YFqsQjA1k3G0LHPwjCswN8zpLlz
 bL+PLJK9BoDJjCbj7fnmQ==
UI-OutboundReport: notjunk:1;M01:P0:REDGyp8qDmU=;o4ltwlfC0cDDJ1VTGaSGZRAYex/
 16tDVbKlAzpk9iGf3HEQ+Qd4w/H5+6mnrvPZ9G+X4fM77Bc1MDzaYEh6pKyYOgWNcZ09mupx2
 AludiAw4y9ZzOi2v3neoSx+q8pcAJB5BwuHPITop2P2+PnZ0Lc9PKaW9yx/UozBLL5NfZPYO1
 LY4oVcApboV0MAacWiSyJrrZX5+KpW9SdR5eytUadQ0jQQSnTmGURdhn5HvfUPbJazx8pIWJ1
 uY3FXFUGhGLzUsOO2RPOSpYFWBSU7kPVjPFPxOqkjfjzrHb2qobk92jbPdSqvpnw6Zg0KjlgM
 cOzDlW3Al8eL5yqWg/mB4QF/MgE/w9cladNRVYl6nbUnDCQRH8BsBF4a231RlFlWxaVA/QOmf
 FtdxMmpPfxKXBzGpxsOMK4BbsYJJJl3w/t/kajn6c1+JPCMlEDUHAHk5Uu2IY9yTVJXyqBZY6
 u5komuMf6Y3WXdpFwgpqKhRld65IvC2CaE/uuTI31RC6q4ZvpWqsjxd+l2X8O+H7zUzf/JUIs
 7OXiadFLemrivnGezSGAviCJPsaq4f3C6K1I0B6DsyyTYXLtCYWkJIQr96v8DlBGduTgFPeRg
 hKJrrC1gGEqmqEipi9rUDPvjrNLl/ZWR2HNrGGCZRi6qMTu7CJiJZ4+/6luEZvvYAVRUnE13K
 K6dw7J4urgfEJCKkhtD+w+1Qzgh7N5sJ9YCF89w2AjVRTblsWBXu2W/65XEMcKxcnsgzlt5xq
 VwORDsBUieHuI+/8OGhUPpFRxC2KA4Z1X8fiFOUH6CPAvkjsT4kQvmm+UXSqyl5md2xFykeXx
 4bLP94/U16wrwWtxzQEKL1pR9hjvUbI/1/iVRqa2FYxveAgglp1TMpRtFq5RMUC6TschU3N7+
 KwEjj6gcDJGz8tC2/IkhFJ/Y8vEAOqciSy1w7NgXGiRpR8MDRPDy+ftT5nTYckkVcTLryfPgA
 GKF4WZN+vMH4ltGzdKhW6to8bMw=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 2023-09-04, Greg Kroah-Hartman wrote:
> 6.5-stable review patch.  If anyone has any objections, please let me kn=
ow.
>
> ------------------
>
> From: Christoph Hellwig <hch@lst.de>
>
> commit 9011e49d54dcc7653ebb8a1e05b5badb5ecfa9f9 upstream.
>
> It has recently come to my attention that nvidia is circumventing the
> protection added in 262e6ae7081d ("modules: inherit
> TAINT_PROPRIETARY_MODULE") by importing exports from their proprietary
> modules into an allegedly GPL licensed module and then rexporting them.
>
> Given that symbol_get was only ever intended for tightly cooperating
> modules using very internal symbols it is logical to restrict it to
> being used on EXPORT_SYMBOL_GPL and prevent nvidia from costly DMCA
> Circumvention of Access Controls law suites.
>
> All symbols except for four used through symbol_get were already exporte=
d
> as EXPORT_SYMBOL_GPL, and the remaining four ones were switched over in
> the preparation patches.

This patch, as part of v6.5.2, breaks the in-kernel ds3000 module
(for a TeVii s480 v2 DVB-S2 card, which is a PCIe card attaching two
onboard TeVii s660 cards via an onboard USB2 controller (MCS9990),
https://www.linuxtv.org/wiki/index.php/TeVii_S480) from loading.

[    2.896589] dvbdev: dvb_create_media_entity: media entity 'dvb-demux' r=
egistered.
[    2.901085] failing symbol_get of non-GPLONLY symbol ds3000_attach.
[    2.901089] DVB: Unable to find symbol ds3000_attach()
[    2.901091] dvb-usb: no frontend was attached by 'TeVii S480.2 USB'

$ dmesg | grep -i -e dvb -e dw21 -e ds3000 -e symbol
[    2.739710] dvb-usb: found a 'TeVii S480.2 USB' in cold state, will try=
 to load a firmware
[    2.740232] dvb-usb: downloading firmware from file 'dvb-usb-s660.fw'
[    2.740233] dw2102: start downloading DW210X firmware
[    2.743090] dvb-usb: found a 'Microsoft Xbox One Digital TV Tuner' in c=
old state, will try to load a firmware
[    2.743217] dvb-usb: downloading firmware from file 'dvb-usb-dib0700-1.=
20.fw'
[    2.896066] dvb-usb: found a 'TeVii S480.2 USB' in warm state.
[    2.896297] dvb-usb: will pass the complete MPEG2 transport stream to t=
he software demuxer.
[    2.896344] dvbdev: DVB: registering new adapter (TeVii S480.2 USB)
[    2.896450] dvb-usb: MAC address: 9f:9f:9f:9f:9f:9f
[    2.896589] dvbdev: dvb_create_media_entity: media entity 'dvb-demux' r=
egistered.
[    2.901085] failing symbol_get of non-GPLONLY symbol ds3000_attach.
[    2.901089] DVB: Unable to find symbol ds3000_attach()
[    2.901091] dvb-usb: no frontend was attached by 'TeVii S480.2 USB'
[    2.925255] rc rc0: lirc_dev: driver dw2102 registered at minor =3D 0, =
scancode receiver, no transmitter
[    2.925398] dvb-usb: schedule remote query interval to 150 msecs.
[    2.925401] dvb-usb: TeVii S480.2 USB successfully initialized and conn=
ected.
[    2.925458] dvb-usb: found a 'TeVii S480.1 USB' in cold state, will try=
 to load a firmware
[    2.925488] dvb-usb: downloading firmware from file 'dvb-usb-s660.fw'
[    2.925489] dw2102: start downloading DW210X firmware
[    2.959695] dvb-usb: TeVii S480.2 USB successfully deinitialized and di=
sconnected.
[    3.079102] dvb-usb: found a 'TeVii S480.1 USB' in warm state.
[    3.079416] dvb-usb: will pass the complete MPEG2 transport stream to t=
he software demuxer.
[    3.079486] dvbdev: DVB: registering new adapter (TeVii S480.1 USB)
[    3.079777] dvb-usb: MAC address: 2f:2f:2f:2f:2f:2f
[    3.080123] dvbdev: dvb_create_media_entity: media entity 'dvb-demux' r=
egistered.
[    3.080622] failing symbol_get of non-GPLONLY symbol ds3000_attach.
[    3.083513] failing symbol_get of non-GPLONLY symbol ds3000_attach.
[    3.083516] DVB: Unable to find symbol ds3000_attach()
[    3.085420] dvb-usb: no frontend was attached by 'TeVii S480.1 USB'
[    3.087260] rc rc1: lirc_dev: driver dw2102 registered at minor =3D 0, =
scancode receiver, no transmitter
[    3.087362] dvb-usb: schedule remote query interval to 150 msecs.
[    3.087365] dvb-usb: TeVii S480.1 USB successfully initialized and conn=
ected.
[    3.087451] usbcore: registered new interface driver dw2102
[    3.115445] dvb-usb: TeVii S480.1 USB successfully deinitialized and di=
sconnected.
[    3.319289] dvb-usb: found a 'Microsoft Xbox One Digital TV Tuner' in w=
arm state.
[    3.319543] dvb-usb: will pass the complete MPEG2 transport stream to t=
he software demuxer.
[    3.320133] dvbdev: DVB: registering new adapter (Microsoft Xbox One Di=
gital TV Tuner)
[    3.320350] dvbdev: dvb_create_media_entity: media entity 'dvb-demux' r=
egistered.
[    3.498941] usb 5-5: DVB: registering adapter 0 frontend 0 (Panasonic M=
N88472)...
[    3.498948] dvbdev: dvb_create_media_entity: media entity 'Panasonic MN=
88472' registered.
[    3.499264] dvb-usb: Microsoft Xbox One Digital TV Tuner successfully i=
nitialized and connected.
[    3.499437] usbcore: registered new interface driver dvb_usb_dib0700
[    4.667281] usb 1-1: Product: DVBS2BOX
[    4.667833] dvb-usb: found a 'TeVii S660 USB' in cold state, will try t=
o load a firmware
[    4.667883] dvb-usb: downloading firmware from file 'dvb-usb-s660.fw'
[    4.667885] dw2102: start downloading DW210X firmware
[    4.823196] dvb-usb: found a 'TeVii S660 USB' in warm state.
[    4.823520] dvb-usb: will pass the complete MPEG2 transport stream to t=
he software demuxer.
[    4.823950] dvbdev: DVB: registering new adapter (TeVii S660 USB)
[    4.851318] usb 4-1: Product: DVBS2BOX
[    4.851853] dvb-usb: found a 'TeVii S660 USB' in cold state, will try t=
o load a firmware
[    4.851898] dvb-usb: downloading firmware from file 'dvb-usb-s660.fw'
[    4.851900] dw2102: start downloading DW210X firmware
[    5.007159] dvb-usb: found a 'TeVii S660 USB' in warm state.
[    5.007469] dvb-usb: will pass the complete MPEG2 transport stream to t=
he software demuxer.
[    5.007837] dvbdev: DVB: registering new adapter (TeVii S660 USB)
[    5.067116] dvb-usb: MAC address: 00:18:XX:XX:XX:XX
[    5.067337] dvbdev: dvb_create_media_entity: media entity 'dvb-demux' r=
egistered.
[    5.067802] failing symbol_get of non-GPLONLY symbol ds3000_attach.
[    5.071091] failing symbol_get of non-GPLONLY symbol ds3000_attach.
[    5.071094] DVB: Unable to find symbol ds3000_attach()
[    5.072124] dvb-usb: no frontend was attached by 'TeVii S660 USB'
[    5.074041] rc rc1: lirc_dev: driver dw2102 registered at minor =3D 0, =
scancode receiver, no transmitter
[    5.074244] dvb-usb: schedule remote query interval to 150 msecs.
[    5.074254] dvb-usb: TeVii S660 USB successfully initialized and connec=
ted.
[    5.250767] dvb-usb: MAC address: 00:18:XX:XX:XX:XX
[    5.250985] dvbdev: dvb_create_media_entity: media entity 'dvb-demux' r=
egistered.
[    5.251599] failing symbol_get of non-GPLONLY symbol ds3000_attach.
[    5.254664] failing symbol_get of non-GPLONLY symbol ds3000_attach.
[    5.254666] DVB: Unable to find symbol ds3000_attach()
[    5.255871] dvb-usb: no frontend was attached by 'TeVii S660 USB'
[    5.257962] rc rc2: lirc_dev: driver dw2102 registered at minor =3D 2, =
scancode receiver, no transmitter
[    5.258132] dvb-usb: schedule remote query interval to 150 msecs.
[    5.258135] dvb-usb: TeVii S660 USB successfully initialized and connec=
ted.
[   13.070175] mn88472 12-0018: downloading firmware from file 'dvb-demod-=
mn88472-02.fw'

This is a self built version of v6.5.2, without any out-of-tree-,
backports- or proprietary modules being loaded.

$ lspci -nn
00:00.0 Host bridge [0600]: Intel Corporation Device [8086:a703] (rev 01)
00:02.0 VGA compatible controller [0300]: Intel Corporation Raptor Lake-S =
GT1 [UHD Graphics 770] [8086:a780] (rev 04)
00:06.0 PCI bridge [0604]: Intel Corporation Raptor Lake PCIe 4.0 Graphics=
 Port [8086:a74d] (rev 01)
00:08.0 System peripheral [0880]: Intel Corporation GNA Scoring Accelerato=
r module [8086:a74f] (rev 01)
00:0a.0 Signal processing controller [1180]: Intel Corporation Raptor Lake=
 Crashlog and Telemetry [8086:a77d] (rev 01)
00:0e.0 RAID bus controller [0104]: Intel Corporation Volume Management De=
vice NVMe RAID Controller Intel Corporation [8086:a77f]
00:14.0 USB controller [0c03]: Intel Corporation Device [8086:7a60] (rev 1=
1)
00:14.2 RAM memory [0500]: Intel Corporation Device [8086:7a27] (rev 11)
00:14.3 Network controller [0280]: Intel Corporation Device [8086:7a70] (r=
ev 11)
00:15.0 Serial bus controller [0c80]: Intel Corporation Device [8086:7a4c]=
 (rev 11)
00:16.0 Communication controller [0780]: Intel Corporation Device [8086:7a=
68] (rev 11)
00:17.0 SATA controller [0106]: Intel Corporation Device [8086:7a62] (rev =
11)
00:1a.0 PCI bridge [0604]: Intel Corporation Device [8086:7a48] (rev 11)
00:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:7a38] (rev 11)
00:1c.2 PCI bridge [0604]: Intel Corporation Device [8086:7a3a] (rev 11)
00:1c.4 PCI bridge [0604]: Intel Corporation Device [8086:7a3c] (rev 11)
00:1d.0 PCI bridge [0604]: Intel Corporation Device [8086:7a36] (rev 11)
00:1f.0 ISA bridge [0601]: Intel Corporation Device [8086:7a06] (rev 11)
00:1f.3 Audio device [0403]: Intel Corporation Device [8086:7a50] (rev 11)
00:1f.4 SMBus [0c05]: Intel Corporation Device [8086:7a23] (rev 11)
00:1f.5 Serial bus controller [0c80]: Intel Corporation Device [8086:7a24]=
 (rev 11)
01:00.0 Non-Volatile memory controller [0108]: Micron/Crucial Technology P=
5 Plus NVMe PCIe SSD [c0a9:5407]
04:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL812=
5 2.5GbE Controller [10ec:8125] (rev 05)
05:00.0 SATA controller [0106]: ASMedia Technology Inc. ASM1062 Serial ATA=
 Controller [1b21:0612] (rev 02)
06:00.0 USB controller [0c03]: MosChip Semiconductor Technology Ltd. MCS99=
90 PCIe to 4-Port USB 2.0 Host Controller [9710:9990]
06:00.1 USB controller [0c03]: MosChip Semiconductor Technology Ltd. MCS99=
90 PCIe to 4-Port USB 2.0 Host Controller [9710:9990]
06:00.2 USB controller [0c03]: MosChip Semiconductor Technology Ltd. MCS99=
90 PCIe to 4-Port USB 2.0 Host Controller [9710:9990]
06:00.3 USB controller [0c03]: MosChip Semiconductor Technology Ltd. MCS99=
90 PCIe to 4-Port USB 2.0 Host Controller [9710:9990]
06:00.4 USB controller [0c03]: MosChip Semiconductor Technology Ltd. MCS99=
90 PCIe to 4-Port USB 2.0 Host Controller [9710:9990]
06:00.5 USB controller [0c03]: MosChip Semiconductor Technology Ltd. MCS99=
90 PCIe to 4-Port USB 2.0 Host Controller [9710:9990]
06:00.6 USB controller [0c03]: MosChip Semiconductor Technology Ltd. MCS99=
90 PCIe to 4-Port USB 2.0 Host Controller [9710:9990]
06:00.7 USB controller [0c03]: MosChip Semiconductor Technology Ltd. MCS99=
90 PCIe to 4-Port USB 2.0 Host Controller [9710:9990]

$ lsusb
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 010 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 009 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 001 Device 003: ID 9022:d660 TeVii Technology Ltd. DVB-S2 S660
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 008 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 004 Device 003: ID 9022:d660 TeVii Technology Ltd. DVB-S2 S660
Bus 004 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 007 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 006 Device 002: ID 174c:3074 ASMedia Technology Inc. ASM1074 SuperSpee=
d hub
Bus 006 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 005 Device 003: ID 174c:2074 ASMedia Technology Inc. ASM1074 High-Spee=
d hub
Bus 005 Device 002: ID 045e:02d5 Microsoft Corp. Xbox One Digital TV Tuner
Bus 005 Device 007: ID 8087:0026 Intel Corp. AX201 Bluetooth
Bus 005 Device 005: ID 0b05:19af ASUSTek Computer, Inc. AURA LED Controlle=
r
Bus 005 Device 010: ID 0609:0334 SMK Manufacturing, Inc. eHome Infrared Re=
ceiver
Bus 005 Device 009: ID 04d9:1603 Holtek Semiconductor, Inc. Keyboard
Bus 005 Device 008: ID 046d:c069 Logitech, Inc. M-U0007 [Corded Mouse M500=
]
Bus 005 Device 006: ID 147e:2016 Upek Biometric Touchchip/Touchstrip Finge=
rprint Sensor
Bus 005 Device 004: ID 05e3:0608 Genesys Logic, Inc. Hub
Bus 005 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

$ ls -1 /sys/module/
8250
842_compress
842_decompress
ac97_bus
acpi
acpi_pad
acpiphp
acpi_tad
aesni_intel
af_alg
af_packet
ahci
algif_hash
algif_skcipher
asus_nb_wmi
asus_wmi
async_memcpy
async_pq
async_raid6_recov
async_tx
async_xor
autofs4
battery
binder
binder_alloc
binfmt_misc
blk_cgroup
blk_crypto
block
bluetooth
bnep
bridge
btbcm
btintel
btmtk
btrtl
btusb
button
ccp
cec
cfg80211
clocksource
cmac
configfs
coretemp
cpufreq
cpufreq_conservative
cpufreq_powersave
cpuid
cpuidle
cpuidle_haltpoll
crc16
crc32c_generic
crc32c_intel
crc32_pclmul
crc64_rocksoft
crc_t10dif
crct10dif_pclmul
cryptd
cryptomgr
crypto_simd
device_hmem
dib0070
dib0090
dib3000mc
dib7000m
dibx000_common
dm_mod
dns_resolver
drm
drm_buddy
drm_display_helper
drm_kms_helper
ds3000
dvb_core
dvb_usb
dvb_usb_dib0700
dvb_usb_dw2102
edac_core
ee1004
eeepc_wmi
efi_pstore
ehci_hcd
ehci_pci
evdev
ext4
fan
fat
fb
firmware_class
fscrypto
fuse
ghash_clmulni_intel
gpiolib_acpi
grant_table
haltpoll
hid
hid_generic
hwmon_vid
i2c_algo_bit
i2c_core
i2c_designware_core
i2c_designware_platform
i2c_dev
i2c_i801
i2c_smbus
i8042
i915
idma64
ima
intel_cstate
intel_gtt
intel_idle
intel_lpss
intel_lpss_pci
intel_pmc_bxt
intel_pmc_core
intel_powerclamp
intel_rapl_common
intel_rapl_msr
intel_tcc_cooling
intel_uncore_frequency
intel_uncore_frequency_common
intel_vsec
ip_tables
ipv6
irqbypass
ir_rc6_decoder
iTCO_vendor_support
iTCO_wdt
iwlmvm
iwlwifi
jbd2
kernel
keyboard
kfence
kvm
kvm_intel
ledtrig_audio
libahci
libarc4
libata
libcrc32c
linear
llc
loop
lp
mac80211
mbcache
mc
mceusb
md_mod
mei
mei_hdcp
mei_me
mei_pxp
memory_hotplug
mfd_core
mn88472
module
mousedev
msr
multipath
nct6775
nct6775_core
netpoll
nls_cp437
nls_utf8
nmi_backtrace
nvme
nvme_core
ohci_hcd
ohci_pci
page_alloc
page_reporting
parport
parport_pc
pcie_aspm
pciehp
pci_hotplug
pcspkr
pinctrl_alderlake
platform_profile
pmt_class
pmt_telemetry
polyval_clmulni
polyval_generic
ppdev
printk
processor
pstore
r8169
raid0
raid1
raid10
raid456
raid6_pq
random
rapl
rc_core
rc_rc6_mce
rc_tevii_nec
rcupdate
rcutree
realtek
regmap_i2c
rfcomm
rfkill
rng_core
rtc_cmos
scsi_common
scsi_mod
sd_mod
secretmem
sg
sha512_ssse3
snd
snd_compress
snd_hda_codec
snd_hda_codec_generic
snd_hda_codec_hdmi
snd_hda_codec_realtek
snd_hda_core
snd_hda_ext_core
snd_hda_intel
snd_hwdep
snd_intel_dspcfg
snd_intel_sdw_acpi
snd_pcm
snd_pcm_dmaengine
snd_soc_acpi
snd_soc_acpi_intel_match
snd_soc_core
snd_soc_hdac_hda
snd_sof
snd_sof_intel_hda
snd_sof_intel_hda_common
snd_sof_intel_hda_mlink
snd_sof_pci
snd_sof_pci_intel_tgl
snd_sof_utils
snd_sof_xtensa_dsp
snd_timer
soundcore
soundwire_cadence
soundwire_generic_allocation
soundwire_intel
sparse_keymap
spurious
srcutree
stp
sysrq
tcp_cubic
tda18250
thermal
tpm
tpm_crb
tpm_tis
tpm_tis_core
ttm
tun
udmabuf
usb_common
usbcore
usbhid
vfat
video
videobuf2_common
videobuf2_memops
videobuf2_vmalloc
vmd
vt
watchdog
wmi
wmi_bmof
workqueue
x86_pkg_temp_thermal
xen
xhci_hcd
xhci_pci
xhci_pci_renesas
xor
x_tables
xz_dec
zswap

Regards
	Stefan Lippers-Hollmann
