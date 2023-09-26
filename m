Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8676D7AF69E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 01:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjIZXOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 19:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjIZXL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 19:11:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45198688
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 15:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=W9+0mXQngBmMf1pqe7YjNpjWOiwbacF2w74/QFywDXI=; b=gy710OajdKs4saq4mJiIDZf7rl
        qow3H270dpmNhxdmoheU4OLNygl2NqYiy52pqawhcoMfN99wfYhOmgcIGHKHsXWHZj/s8llr77K+v
        f54wSqrTE4frThfYnvosAHIxGR45gUM/gZPjDXXBXytPtLjSnBBidtap0qkuPpLJkO7mVcOWioWta
        ES2ZURP8/YiRkhud6RbvUkK16R1n81kFW7mrsqqhVIAmHYDYobbJKB8n3J29f2hyXLvhfAnSSQs+v
        a6Uuj9BmJ/GqLHjLk2wxoobjf3oUnmMa9ece7FEkbH/Dv2kAS99IyhIN6PYiTiP6zft5TbsgdGk5y
        Gk/9om/A==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qlGJO-00H65b-1i;
        Tue, 26 Sep 2023 22:13:46 +0000
Message-ID: <40672e60-3913-4794-b84a-742b7c16d361@infradead.org>
Date:   Tue, 26 Sep 2023 15:13:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ryzen 9 7950x sound module does not not build
Content-Language: en-US
To:     sboyce@blueyonder.co.uk, Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ALSA <alsa-devel@alsa-project.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <213f93b5-bffe-479f-a111-f8a7e44cd293@blueyonder.co.uk>
 <61821f15-78e2-4594-8f39-545ecaa97000@infradead.org>
 <5903832d-7d27-4847-b161-48b9f7e92ee6@blueyonder.co.uk>
 <ZRLWIkyngsasQbQ7@debian.me>
 <6a6d7683-78f2-4511-976d-eb42d3b59c89@blueyonder.co.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <6a6d7683-78f2-4511-976d-eb42d3b59c89@blueyonder.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/23 12:17, Sid Boyce wrote:
> On 26/09/2023 14:01, Bagas Sanjaya wrote:
>> [also Cc'ing alsa ML and related maintainers]
>>
>> On Tue, Sep 26, 2023 at 01:23:13PM +0100, Sid Boyce wrote:
>>> I've since rebooted and did a modprobe. No idea why it isn't automatically
>>> loaded.
>>>
>>> #modinfo snd-rpl-pci-acp6x
>>> filename:       /usr/lib/modules/6.6.0-rc3-vanilla/kernel/sound/soc/amd/rpl/snd-rpl-pci-acp6x.ko.gz
>>> license:        GPL v2
>>> description:    AMD ACP RPL PCI driver
>>> srcversion:     0F909BC61165681426ECEEB
>>> alias:          pci:v00001022d000015E2sv*sd*bc04sc80i00*
>>> depends:
>>> retpoline:      Y
>>> intree:         Y
>>> name:           snd_rpl_pci_acp6x
>>> vermagic:       6.6.0-rc3-vanilla SMP preempt mod_unload modversions
>>>
>>> # modprobe snd-rpl-pci-acp6x
>>>
>>> #lsmod|grep snd
>>> snd_rpl_pci_acp6x      16384  0
>>> snd_seq_dummy          12288  0
>>> snd_hrtimer            12288  1
>>> snd_seq               131072  7 snd_seq_dummy
>>> snd_hda_codec_realtek   192512  1
>>> snd_hda_codec_hdmi     94208  1
>>> snd_hda_codec_generic   110592  1 snd_hda_codec_realtek
>>> snd_hda_intel          65536  2
>>> snd_usb_audio         458752  2
>>> snd_intel_dspcfg       40960  1 snd_hda_intel
>>> snd_intel_sdw_acpi     16384  1 snd_intel_dspcfg
>>> snd_hda_codec         233472  4
>>> snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec_realtek
>>>
>>> snd_usbmidi_lib        49152  1 snd_usb_audio
>>> snd_hda_core          147456  5 snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hda_codec_realtek
>>>
>>> snd_ump                36864  1 snd_usb_audio
>>> snd_rawmidi            57344  2 snd_usbmidi_lib,snd_ump
>>> snd_seq_device         16384  3 snd_seq,snd_ump,snd_rawmidi
>>> mc                     94208  1 snd_usb_audio
>>> snd_hwdep              20480  2 snd_usb_audio,snd_hda_codec
>>> snd_pcm               225280  6
>>> snd_hda_codec_hdmi,snd_hda_intel,snd_usb_audio,snd_hda_codec,snd_hda_core
>>> snd_timer              53248  3 snd_seq,snd_hrtimer,snd_pcm
>>> ledtrig_audio          12288  2 snd_hda_codec_generic,asus_wmi
>>> snd                  163840  23 snd_hda_codec_generic,snd_seq,snd_seq_device,snd_hda_codec_hdmi,snd_hwdep,snd_hda_intel,snd_usb_audio,snd_usbmidi_lib,snd_hda_codec,snd_hda_codec_realtek,snd_timer,snd_ump,snd_pcm,snd_rawmidi
>>>
>>> soundcore              16384  1 snd
>>> usbcore               446464  6
>>> xhci_hcd,snd_usb_audio,usbhid,snd_usbmidi_lib,btusb,xhci_pci
>>>
>> Any errors on dmesg when loading snd-rpl-pci-acp6x module?
>>
> The full .config.

Your .config file also builds with no problems, so I guess that the issue
is not about building but about auto-loading and finding the device.

I think that what we are missing (first) is the output of 'lspci -vv',
at least for the PCI sound device in question.
The snd-rpl-pci-acp6x driver only supports
vendor=0x1022, device=0x15e2, and PCI revision=0x62.


-- 
~Randy
