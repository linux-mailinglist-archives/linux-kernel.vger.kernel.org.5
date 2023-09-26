Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A117AEF24
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 16:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbjIZO6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 10:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjIZO6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 10:58:35 -0400
Received: from csmtpq1-prd-nl1-vmo.edge.unified.services (csmtpq1-prd-nl1-vmo.edge.unified.services [84.116.50.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100258E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 07:58:29 -0700 (PDT)
Received: from csmtp1-prd-nl1-vmo.nl1.unified.services ([100.107.82.135] helo=csmtp1-prd-nl1-vmo.edge.unified.services)
        by csmtpq1-prd-nl1-vmo.edge.unified.services with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <sboyce@blueyonder.co.uk>)
        id 1ql9W5-007rgX-It
        for linux-kernel@vger.kernel.org; Tue, 26 Sep 2023 16:58:25 +0200
Received: from [192.168.10.244] ([82.32.17.210])
        by csmtp1-prd-nl1-vmo.edge.unified.services with ESMTPA
        id l9W3qmxRTscPpl9W3qbm5k; Tue, 26 Sep 2023 16:58:25 +0200
X-SourceIP: 82.32.17.210
X-Authenticated-Sender: sboyce@blueyonder.co.uk
X-Spam: 0
X-Authority: v=2.4 cv=MOqm2uVl c=1 sm=1 tr=0 ts=6512f191 cx=a_exe
 a=xwbGgp66NgX51+oEeDXSrg==:117 a=xwbGgp66NgX51+oEeDXSrg==:17
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=x7bEGLp0ZPQA:10
 a=w4l64K11s27c6s6ukoEA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=blueyonder.co.uk;
        s=meg.feb2017; t=1695740305;
        bh=GL3aBN4ouPY4nXvtUsGbqmTKhOltfnejMfIl3UCtebg=;
        h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To;
        b=GevVt9Ji23GP/ylwwHi423X6szkXV34fLibqIsAFe9Sp7i7fAUjRFWg971Nh/NCnP
         MobNLqY2J8XLBZLTY++x6qfGOWhMe2KxMsELFFbdK9qFhLuf8MdFRCEih29tKKdtFA
         G/MNUoW/Qsdn1UUWVwtKvXgInMzTOQSKl5xLVfkQawv2oeqeZ84Y+iOzmPFMLANHHM
         IQhbp57cJIEblQZ3dOJcLbkPypLwoTWWGkDDBkJmerz9piG+ulfZOZk0Dd15a3x/9D
         CSAD/VXpJP7ykDrv/K+o7t5c51iE8OClyzTKPKwozReUDleHtBZUw4Q0VET+UcULuT
         GJpHf/gOtdcbw==
Message-ID: <1d0c5a6b-e82a-4b37-8f98-eaac0b8db8e7@blueyonder.co.uk>
Date:   Tue, 26 Sep 2023 15:58:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: sboyce@blueyonder.co.uk
Subject: Re: Ryzen 9 7950x sound module does not not build
Content-Language: en-GB
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ALSA <alsa-devel@alsa-project.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <213f93b5-bffe-479f-a111-f8a7e44cd293@blueyonder.co.uk>
 <61821f15-78e2-4594-8f39-545ecaa97000@infradead.org>
 <5903832d-7d27-4847-b161-48b9f7e92ee6@blueyonder.co.uk>
 <ZRLWIkyngsasQbQ7@debian.me>
From:   Sid Boyce <sboyce@blueyonder.co.uk>
Organization: blueyonder.co.uk
In-Reply-To: <ZRLWIkyngsasQbQ7@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfAliM8TZSBWqTjavl6P9To3jRxiD6s9P/p1K1gJfwEdLdxUbaYpPTicvP8En6AUkBPIfsbLZc3eIDaupfM98Lg988R80KC/9xEfdNEJopm5ONiSa41gd
 X22nxR5hyeQgfJhUr9l38VWzo55rGXLYpMO7hVQMCqrheYcOuXQkKWabbFdGqXXPfhrKUUFQyksj7yhyI5b9y3Twpn1IbLpK3wp4DFdaGpMEqc3FYdbtqOND
 Ww8QBnQxRvogwEQ11IIxCT0skFIlq4c8ll5ZY9zbgaAy2oo3BD3phgO8KzMLIP3T3PJoezL20IhTfu6XvXuHl1rpGT4a6kP3YbqlYFkj/Vw8cCwV/OabgfqB
 LpQRxX192tuo9f5xR+u8Kun/uhMjOpMDzT3in3e57EYveq3sH20P1+E+H+f+8rRZYp/MJh8M
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2023 14:01, Bagas Sanjaya wrote:
> [also Cc'ing alsa ML and related maintainers]
>
> On Tue, Sep 26, 2023 at 01:23:13PM +0100, Sid Boyce wrote:
>> I've since rebooted and did a modprobe. No idea why it isn't automatically
>> loaded.
>>
>> #modinfo snd-rpl-pci-acp6x
>> filename:       /usr/lib/modules/6.6.0-rc3-vanilla/kernel/sound/soc/amd/rpl/snd-rpl-pci-acp6x.ko.gz
>> license:        GPL v2
>> description:    AMD ACP RPL PCI driver
>> srcversion:     0F909BC61165681426ECEEB
>> alias:          pci:v00001022d000015E2sv*sd*bc04sc80i00*
>> depends:
>> retpoline:      Y
>> intree:         Y
>> name:           snd_rpl_pci_acp6x
>> vermagic:       6.6.0-rc3-vanilla SMP preempt mod_unload modversions
>>
>> # modprobe snd-rpl-pci-acp6x
>>
>> #lsmod|grep snd
>> snd_rpl_pci_acp6x      16384  0
>> snd_seq_dummy          12288  0
>> snd_hrtimer            12288  1
>> snd_seq               131072  7 snd_seq_dummy
>> snd_hda_codec_realtek   192512  1
>> snd_hda_codec_hdmi     94208  1
>> snd_hda_codec_generic   110592  1 snd_hda_codec_realtek
>> snd_hda_intel          65536  2
>> snd_usb_audio         458752  2
>> snd_intel_dspcfg       40960  1 snd_hda_intel
>> snd_intel_sdw_acpi     16384  1 snd_intel_dspcfg
>> snd_hda_codec         233472  4
>> snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec_realtek
>>
>> snd_usbmidi_lib        49152  1 snd_usb_audio
>> snd_hda_core          147456  5 snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hda_codec_realtek
>>
>> snd_ump                36864  1 snd_usb_audio
>> snd_rawmidi            57344  2 snd_usbmidi_lib,snd_ump
>> snd_seq_device         16384  3 snd_seq,snd_ump,snd_rawmidi
>> mc                     94208  1 snd_usb_audio
>> snd_hwdep              20480  2 snd_usb_audio,snd_hda_codec
>> snd_pcm               225280  6
>> snd_hda_codec_hdmi,snd_hda_intel,snd_usb_audio,snd_hda_codec,snd_hda_core
>> snd_timer              53248  3 snd_seq,snd_hrtimer,snd_pcm
>> ledtrig_audio          12288  2 snd_hda_codec_generic,asus_wmi
>> snd                  163840  23 snd_hda_codec_generic,snd_seq,snd_seq_device,snd_hda_codec_hdmi,snd_hwdep,snd_hda_intel,snd_usb_audio,snd_usbmidi_lib,snd_hda_codec,snd_hda_codec_realtek,snd_timer,snd_ump,snd_pcm,snd_rawmidi
>>
>> soundcore              16384  1 snd
>> usbcore               446464  6
>> xhci_hcd,snd_usb_audio,usbhid,snd_usbmidi_lib,btusb,xhci_pci
>>
> Any errors on dmesg when loading snd-rpl-pci-acp6x module?
>
No errors, no mention of the module. Booted with the USB dongle removed.

kmix only lists Playback Devices: Family 17h/19h HD Audio Controller 
Digital Stereo (IEC958).

Capture Devices: Family 17h/19h HD Audio Controller Analog Stereo.

With USB dongle plugged it uses it as the default.

#fuser -v /dev/snd/*

                     USER        PID ACCESS COMMAND
/dev/snd/controlC0:  lancelot   2618 F.... wireplumber
/dev/snd/controlC1:  lancelot   2618 F.... wireplumber
/dev/snd/controlC2:  lancelot   2618 F.... wireplumber
/dev/snd/pcmC0D0p:   lancelot   2617 F...m pipewire
/dev/snd/seq:        lancelot   2617 F.... pipewire


#dmesg -T |grep snd
[Tue Sep 26 15:30:12 2023] snd_hda_intel 0000:01:00.1: Disabling MSI
[Tue Sep 26 15:30:12 2023] snd_hda_intel 0000:01:00.1: Handle 
vga_switcheroo audio client
[Tue Sep 26 15:30:12 2023] snd_hda_intel 0000:0b:00.6: enabling device 
(0000 -> 0002)
[Tue Sep 26 15:30:12 2023] snd_hda_codec_realtek hdaudioC2D0: autoconfig 
for ALC897: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
[Tue Sep 26 15:30:12 2023] snd_hda_codec_realtek hdaudioC2D0: 
    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[Tue Sep 26 15:30:12 2023] snd_hda_codec_realtek hdaudioC2D0: 
    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[Tue Sep 26 15:30:12 2023] snd_hda_codec_realtek hdaudioC2D0:    mono: 
mono_out=0x0
[Tue Sep 26 15:30:12 2023] snd_hda_codec_realtek hdaudioC2D0: 
    dig-out=0x11/0x0
[Tue Sep 26 15:30:12 2023] snd_hda_codec_realtek hdaudioC2D0:    inputs:
[Tue Sep 26 15:30:12 2023] snd_hda_codec_realtek hdaudioC2D0:      Front 
Mic=0x19
[Tue Sep 26 15:30:12 2023] snd_hda_codec_realtek hdaudioC2D0:      Rear 
Mic=0x18
[Tue Sep 26 15:30:12 2023] snd_hda_codec_realtek hdaudioC2D0: 
      Line=0x1a
[Tue Sep 26 15:30:12 2023] snd_hda_intel 0000:01:00.1: bound 
0000:01:00.0 (ops nv50_audio_component_bind_ops [nouveau])

I had to use modprobe:

#lsmod|grep snd_rpl_pci_acp6x
snd_rpl_pci_acp6x     16384  0

dmesg does not report it.

Regards

Sid.

-- 
Sid Boyce ... Hamradio License G3VBV, Keen licensed Private Pilot
Retired IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support Specialist
Microsoft Windows Free Zone - Linux used for all Computing Tasks

