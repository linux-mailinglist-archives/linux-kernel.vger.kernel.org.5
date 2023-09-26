Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCFF7AEC87
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbjIZMX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbjIZMXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:23:24 -0400
X-Greylist: delayed 39751 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Sep 2023 05:23:17 PDT
Received: from csmtpq4-prd-nl1-vmo.edge.unified.services (csmtpq4-prd-nl1-vmo.edge.unified.services [84.116.50.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C00FC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 05:23:17 -0700 (PDT)
Received: from csmtp5-prd-nl1-vmo.nl1.unified.services ([100.107.82.68] helo=csmtp5-prd-nl1-vmo.edge.unified.services)
        by csmtpq4-prd-nl1-vmo.edge.unified.services with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <sboyce@blueyonder.co.uk>)
        id 1ql75u-0041pE-NG
        for linux-kernel@vger.kernel.org; Tue, 26 Sep 2023 14:23:14 +0200
Received: from [192.168.10.244] ([82.32.17.210])
        by csmtp5-prd-nl1-vmo.edge.unified.services with ESMTPA
        id l75tqis0oay9cl75tqdIfd; Tue, 26 Sep 2023 14:23:14 +0200
X-SourceIP: 82.32.17.210
X-Authenticated-Sender: sboyce@blueyonder.co.uk
X-Spam: 0
X-Authority: v=2.4 cv=TfpQ9zch c=1 sm=1 tr=0 ts=6512cd32 cx=a_exe
 a=xwbGgp66NgX51+oEeDXSrg==:117 a=xwbGgp66NgX51+oEeDXSrg==:17
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=x7bEGLp0ZPQA:10
 a=6i85INYm-GQaCzMb2JYA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=blueyonder.co.uk;
        s=meg.feb2017; t=1695730994;
        bh=HlCkXSUg4xrXtsFxZl5LXGh9CgXu9ptawwkoAJxL2nw=;
        h=Date:Reply-To:Subject:To:References:From:In-Reply-To;
        b=cZtFyFua0Cb9yMVma7rc5LxswcqRmsiourTRgRZOR6F8QiRjpoi0kHcNSdBoHMxET
         K4VCytOTjko9YoJZg8lr5T49QPSBbrm5XGeD29sdocQDi/AUpyXitIXHNvL7/d8jzq
         ZzU8fI8ELwg5ONyy6xYPaDRdOBdZmPkCQRcvoi3GYaw1U+FKR9uIjHBbij6CMYZ5f+
         ES05+8l7B+MpHY2qOyG0FbuwpNjr+h7R6SPxR3WQVGAFvyPA3DSRI3nmDXVj5hNQXu
         zt3UbLsd0DkbFnDJkSSq6Gf16Pzzm8D7bGwbYUtHbd/uB4oVCl+WoNawxdV5M6e+bJ
         z3a10t9qHzKmg==
Message-ID: <5903832d-7d27-4847-b161-48b9f7e92ee6@blueyonder.co.uk>
Date:   Tue, 26 Sep 2023 13:23:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: sboyce@blueyonder.co.uk
Subject: Re: Ryzen 9 7950x sound module does not not build
Content-Language: en-GB
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>
References: <213f93b5-bffe-479f-a111-f8a7e44cd293@blueyonder.co.uk>
 <61821f15-78e2-4594-8f39-545ecaa97000@infradead.org>
From:   Sid Boyce <sboyce@blueyonder.co.uk>
Organization: blueyonder.co.uk
In-Reply-To: <61821f15-78e2-4594-8f39-545ecaa97000@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFOfh/wxrYP0ExxmjUq7u6O7OF4oBBME06Y8kVisE9ibzIkIJcjeHrb4vvU9wFlNTQxXP+WvsXavUSyPi0XxdBovXCWK6kdsFQ5+ts1DWvv9IdqdzOcp
 AaVm6eDxJFP4BtmMQOi3qMqAvSg+NrGcCaIqAOzKCijFPz3AOFixMHeDqiUYLBwlRLRw8zMZPGmRBFEWV8v5PAmsX1idvFAzwL9bqPTiL2SaMthTgfLc1Sak
 tu8jpJ62Np6p7eq8ZvSOeg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2023 02:48, Randy Dunlap wrote:
> Hi,
>
> On 9/25/23 18:20, Sid Boyce wrote:
>> Machine:
>>   Type: Desktop System: ASUS product: N/A v: N/A serial: N/A
>>   Mobo: ASUSTeK model: PRIME B650M-A WIFI II v: Rev 1.xx
>>     serial: 221214156800233 UEFI: American Megatrends v: 1634 date: 07/21/2023
>> CPU:
>>   Info: 16-core model: AMD Ryzen 9 7950X bits: 64 type: MT MCP cache:
>>     L2: 16 MiB
>> slipstream:/usr/src/linux-6.6.0-rc3 # grep CONFIG_SND_SOC_AMD_RPL_ACP6x=m .config
>> CONFIG_SND_SOC_AMD_RPL_ACP6x=m
>>
>>
>> This module never gets built, so only USB audio works.
>> # dmesg -T|grep snd
>> [Sun Sep 24 23:48:08 2023] snd_hda_intel 0000:01:00.1: Disabling MSI
>> [Sun Sep 24 23:48:08 2023] snd_hda_intel 0000:01:00.1: Handle vga_switcheroo audio client
>> [Sun Sep 24 23:48:08 2023] snd_hda_intel 0000:0b:00.6: enabling device (0000 -> 0002)
>> [Sun Sep 24 23:48:08 2023] snd_hda_intel 0000:01:00.1: bound 0000:01:00.0 (ops nv50_audio_component_bind_ops [nouveau])
>> [Sun Sep 24 23:48:08 2023] usbcore: registered new interface driver snd-usb-audio
>> [Sun Sep 24 23:48:08 2023] snd_hda_codec_realtek hdaudioC2D0: autoconfig for ALC897: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
>> [Sun Sep 24 23:48:08 2023] snd_hda_codec_realtek hdaudioC2D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
>> [Sun Sep 24 23:48:08 2023] snd_hda_codec_realtek hdaudioC2D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
>> [Sun Sep 24 23:48:08 2023] snd_hda_codec_realtek hdaudioC2D0:    mono: mono_out=0x0
>> [Sun Sep 24 23:48:08 2023] snd_hda_codec_realtek hdaudioC2D0:    dig-out=0x11/0x0
>> [Sun Sep 24 23:48:08 2023] snd_hda_codec_realtek hdaudioC2D0:    inputs:
>> [Sun Sep 24 23:48:08 2023] snd_hda_codec_realtek hdaudioC2D0:      Front Mic=0x19
>> [Sun Sep 24 23:48:08 2023] snd_hda_codec_realtek hdaudioC2D0:      Rear Mic=0x18
>> [Sun Sep 24 23:48:08 2023] snd_hda_codec_realtek hdaudioC2D0:      Line=0x1a
>>
>>
>> # fuser -v /dev/snd/*
>>                      USER        PID ACCESS COMMAND
>> /dev/snd/controlC0:  lancelot   3738 F.... wireplumber
>> /dev/snd/controlC1:  lancelot   3738 F.... wireplumber
>> /dev/snd/controlC2:  lancelot   3738 F.... wireplumber
>> /dev/snd/pcmC0D0p:   lancelot   3737 F...m pipewire
>> /dev/snd/seq:        lancelot   3737 F.... pipewire
>>
>> Regards
>>
>> Sid.
> It builds for me:
>
>    CC [M]  sound/soc/amd/rpl/rpl-pci-acp6x.o
>    LD [M]  sound/soc/amd/rpl/snd-rpl-pci-acp6x.o
>    CC [M]  sound/soc/amd/rpl/snd-rpl-pci-acp6x.mod.o
>    LD [M]  sound/soc/amd/rpl/snd-rpl-pci-acp6x.ko
>
> and the object file subdirectory contains:
>
> -rw-r--r-- 1 rdunlap rdunlap    34 Sep 25 18:37 snd-rpl-pci-acp6x.mod
> -rw-r--r-- 1 rdunlap rdunlap  9360 Sep 25 18:37 rpl-pci-acp6x.o
> -rw-r--r-- 1 rdunlap rdunlap  9616 Sep 25 18:37 snd-rpl-pci-acp6x.o
> -rw-r--r-- 1 rdunlap rdunlap    38 Sep 25 18:37 modules.order
> -rw-r--r-- 1 rdunlap rdunlap   777 Sep 25 18:38 snd-rpl-pci-acp6x.mod.c
> -rw-r--r-- 1 rdunlap rdunlap  3104 Sep 25 18:38 snd-rpl-pci-acp6x.mod.o
> -rw-r--r-- 1 rdunlap rdunlap 11816 Sep 25 18:38 snd-rpl-pci-acp6x.ko
>
>
> You might need to post your failing .config file.
>
Thanks Randy,

I've since rebooted and did a modprobe. No idea why it isn't 
automatically loaded.

#modinfo snd-rpl-pci-acp6x
filename: 
       /usr/lib/modules/6.6.0-rc3-vanilla/kernel/sound/soc/amd/rpl/snd-rpl-pci-acp6x.ko.gz
license:        GPL v2
description:    AMD ACP RPL PCI driver
srcversion:     0F909BC61165681426ECEEB
alias:          pci:v00001022d000015E2sv*sd*bc04sc80i00*
depends:
retpoline:      Y
intree:         Y
name:           snd_rpl_pci_acp6x
vermagic:       6.6.0-rc3-vanilla SMP preempt mod_unload modversions

# modprobe snd-rpl-pci-acp6x

#lsmod|grep snd
snd_rpl_pci_acp6x      16384  0
snd_seq_dummy          12288  0
snd_hrtimer            12288  1
snd_seq               131072  7 snd_seq_dummy
snd_hda_codec_realtek   192512  1
snd_hda_codec_hdmi     94208  1
snd_hda_codec_generic   110592  1 snd_hda_codec_realtek
snd_hda_intel          65536  2
snd_usb_audio         458752  2
snd_intel_dspcfg       40960  1 snd_hda_intel
snd_intel_sdw_acpi     16384  1 snd_intel_dspcfg
snd_hda_codec         233472  4 
snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec_realtek 

snd_usbmidi_lib        49152  1 snd_usb_audio
snd_hda_core          147456  5 
snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hda_codec_realtek 

snd_ump                36864  1 snd_usb_audio
snd_rawmidi            57344  2 snd_usbmidi_lib,snd_ump
snd_seq_device         16384  3 snd_seq,snd_ump,snd_rawmidi
mc                     94208  1 snd_usb_audio
snd_hwdep              20480  2 snd_usb_audio,snd_hda_codec
snd_pcm               225280  6 
snd_hda_codec_hdmi,snd_hda_intel,snd_usb_audio,snd_hda_codec,snd_hda_core
snd_timer              53248  3 snd_seq,snd_hrtimer,snd_pcm
ledtrig_audio          12288  2 snd_hda_codec_generic,asus_wmi
snd                  163840  23 
snd_hda_codec_generic,snd_seq,snd_seq_device,snd_hda_codec_hdmi,snd_hwdep,snd_hda_intel,snd_usb_audio,snd_usbmidi_lib,snd_hda_codec,snd_hda_codec_realtek,snd_timer,snd_ump,snd_pcm,snd_rawmidi 

soundcore              16384  1 snd
usbcore               446464  6 
xhci_hcd,snd_usb_audio,usbhid,snd_usbmidi_lib,btusb,xhci_pci

Regards

Sid.

-- 
Sid Boyce ... Hamradio License G3VBV, Keen licensed Private Pilot
Retired IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support Specialist
Microsoft Windows Free Zone - Linux used for all Computing Tasks

