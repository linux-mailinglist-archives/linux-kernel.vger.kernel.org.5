Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A383E78A642
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 09:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjH1HI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 03:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjH1HI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 03:08:28 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8194D8;
        Mon, 28 Aug 2023 00:08:24 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b703a0453fso41735481fa.3;
        Mon, 28 Aug 2023 00:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693206503; x=1693811303;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vf2Ih/LJ4UC8r1LAx8GgwcTGc19SInnmmDpTI9eqFeM=;
        b=eHyc1VajUYW8D89VhvEX7HtoHkiPiImQq8mBi5WjW5UNd+iLh4ehOSmkeMotH7nCQ1
         G9vZd5p6femrvoSademnupXtHAiMEdxPak8UBLoP71Vj5gqSKQdLEEVD3YXsspFgbXmQ
         /OO5tR7ouSNFeuLkmaM/dU/1X92OHMBQkALlolatj2ECOuNGLyGwyFRIyKIJj9XgTTVI
         BTd4Wf2Jc0y8+bGbuz3QamSRq/9iH4w9y6eTgBU55Nzfl4qts7vI68uX6ohsLIBZWTdT
         P49sTR8hMmPomi1mXbkxxalFa+rZvqw7OfjGEVYRy3gCUAaTU11Tc20C8/LQiqUWm/zc
         EtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693206503; x=1693811303;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vf2Ih/LJ4UC8r1LAx8GgwcTGc19SInnmmDpTI9eqFeM=;
        b=TKle3TLFiWyrWaZur9iYWf9VC4zBX0DeSq8TadoC8y03lj1RiUQcRqZO9JQ8+ORF3S
         eZxsU2lmgPtVWgXEWLF52mJVacwGtl5GVoGkez0iONXGRJdcuS80T1VK8oqoWiBjnYYG
         l4zWCA+xYoVJFahDIpIZwPLYRu5PeQci7yhJJxb2uJFr/WrWUcBOYIYmgNfKx9/nZtRd
         FtWxUcmzxMNeWuziKDQcmhBdk8LJoQl/o3Nm675xs35ETyb5JtSOCGrhklmOqIqG78CT
         nqWRa+FvWdyF2RewVbVGX1aNIjq6lA31plCz1Qni2cZMOHGlwxjBFHYIw8hscUYm/GbH
         WqoQ==
X-Gm-Message-State: AOJu0YwlWRo1T6o1X9FRoWVrHEJKT9l9DrmFPk7z1MAjt4OXYAKkBLiw
        VNvjWkHWc2hiK3u6yzQySz5whfEeV1heMw==
X-Google-Smtp-Source: AGHT+IEsbA/15NDQWP+2uicb+KIuMYb5FHg6EGP2TECewmFe9DHFkQhonhGh2OKYmOTQyi5AxbXp/Q==
X-Received: by 2002:a05:6512:2029:b0:4fb:fe97:5e35 with SMTP id s9-20020a056512202900b004fbfe975e35mr15187491lfs.47.1693206502738;
        Mon, 28 Aug 2023 00:08:22 -0700 (PDT)
Received: from ?IPV6:2001:861:3283:cc70:67b:cbff:feb2:30bc? ([2001:861:3283:cc70:67b:cbff:feb2:30bc])
        by smtp.gmail.com with ESMTPSA id f23-20020a7bc8d7000000b003fbc9d178a8sm12934025wml.4.2023.08.28.00.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 00:08:21 -0700 (PDT)
Message-ID: <267f7083-6435-4fab-827f-f7309bcd913d@gmail.com>
Date:   Mon, 28 Aug 2023 09:08:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Qualcomm NFA725A on T14s AMD Gen3: Bluetooth: hci0: Failed
 to send headers (or body or access otp area)
To:     Bagas Sanjaya <bagasdotme@gmail.com>, Kalle Valo <kvalo@kernel.org>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ath11k <ath11k@lists.infradead.org>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <a669d2d5-fee8-5841-eb5f-b7d047d3cdb2@gmail.com>
 <87il99j8dh.fsf@kernel.org> <89c53213-cb9b-7a8c-bc9c-92cabfdbba4d@gmail.com>
Content-Language: en-CA
From:   =?UTF-8?B?RnJhbsOnb2lz?= <fanf42@gmail.com>
In-Reply-To: <89c53213-cb9b-7a8c-bc9c-92cabfdbba4d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2023 10:21, Bagas Sanjaya wrote:
> On 21/08/2023 12:02, Kalle Valo wrote:
>> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>>
>>> Hi,
>>>
>>> I notice a bug report on Bugzilla [1]. Quoting from it:
>>>
>>>> Hello,
>>>>
>>>> (Sorry by advance if it's not the correct place to discuss that, but
>>>> I tried other place like my distro kernel forum
>>>> (https://bbs.archlinux.org/viewtopic.php?id=286929), interactive
>>>> chat, etc and nobody was able to help).
>>>>
>>>> [1] == Short summary ==
>>>>
>>>> I have a lenovo T14S AMD Gen 3 with a *Qualcomm NFA725A* Wi-Fi card
>>>> (which is actually reported by lspci as QCNFA765) and bluetooth
>>>> never worked on it, failing to load the rampatch with "failed to
>>>> send header" or "failed to send body" or "Failed to access otp area
>>>> (-71)".
>>>>
>>>> Other people reports bluetooth as working
>>>> (https://wiki.archlinux.org/title/Lenovo_ThinkPad_T14s_(AMD)_Gen_3)
>>>> and a work friend has a T16 AMD gen1 which seems to have exactly the
>>>> same chipset and work flowlessly. So perhaps it's an hardware issue,
>>>> but I don't know how to qualify it if so.
>>>>
>>>> => How can this be further qualified/debuged/workarounded?
>>>>
>>>> Any help, even RTFM pointing to corresponding manuals would be very
>>>> much appreciated.
>> This looks like a bluetooth bug so not related to ath11k (which is a
>> Wi-Fi driver).
>>
> Oops, I really can't guess which driver is the culprit in this case unless
> the reporter also attaches lsmod output. To François: Can you show
> lsmod list as requested?
>
> Also Cc: bluetooth people.

Very sorry, I was AFK for a couple of days and totaly missed the request.

# lsmod, just the ath11k part:
❯ lsmod | grep -i ath
ath11k_pci             24576  0
ath11k                749568  1 ath11k_pci
qmi_helpers            36864  1 ath11k
mac80211             1527808  1 ath11k
cfg80211             1286144  2 ath11k,mac80211
mhi                   110592  2 ath11k_pci,qrtr_mhi

# lsmod, just btusb
❯ lsmod | grep -i btusb
btusb                  81920  0
btrtl                  28672  1 btusb
btbcm                  24576  1 btusb
btintel                53248  1 btusb
btmtk                  12288  1 btusb
bluetooth            1093632  14 btrtl,btmtk,btintel,btbcm,bnep,btusb

# lsmod everything
❯ lsmod
Module                  Size  Used by
bnep                   36864  2
btusb                  81920  0
btrtl                  28672  1 btusb
btbcm                  24576  1 btusb
btintel                53248  1 btusb
btmtk                  12288  1 btusb
bluetooth            1093632  14 btrtl,btmtk,btintel,btbcm,bnep,btusb
ecdh_generic           16384  1 bluetooth
hid_logitech_hidpp     77824  0
hid_logitech_dj        40960  0
hid_jabra              16384  0
snd_usb_audio         438272  0
snd_usbmidi_lib        49152  1 snd_usb_audio
snd_rawmidi            53248  1 snd_usbmidi_lib
usbhid                 77824  2 hid_logitech_dj,hid_logitech_hidpp
tun                    69632  2
snd_seq_dummy          12288  0
snd_hrtimer            12288  1
snd_seq               106496  7 snd_seq_dummy
snd_seq_device         16384  2 snd_seq,snd_rawmidi
ccm                    20480  6
michael_mic            12288  1
qrtr_mhi               16384  0
iptable_nat            12288  0
nf_nat                 61440  1 iptable_nat
nf_conntrack          200704  1 nf_nat
nf_defrag_ipv6         24576  1 nf_conntrack
nf_defrag_ipv4         12288  1 nf_conntrack
iptable_mangle         12288  0
iptable_filter         12288  0
uvcvideo              176128  0
videobuf2_vmalloc      20480  1 uvcvideo
uvc                    12288  1 uvcvideo
videobuf2_memops       16384  1 videobuf2_vmalloc
videobuf2_v4l2         40960  1 uvcvideo
videodev              372736  2 videobuf2_v4l2,uvcvideo
videobuf2_common       86016  4 
videobuf2_vmalloc,videobuf2_v4l2,uvcvideo,videobuf2_memops
mc                     86016  5 
videodev,snd_usb_audio,videobuf2_v4l2,uvcvideo,videobuf2_common
snd_acp6x_pdm_dma      16384  1
snd_soc_acp6x_mach     24576  4
snd_soc_dmic           12288  1
snd_sof_amd_rembrandt    16384  0
snd_sof_amd_renoir     16384  0
ext4                 1150976  1
snd_sof_amd_acp        57344  2 snd_sof_amd_rembrandt,snd_sof_amd_renoir
snd_sof_pci            24576  2 snd_sof_amd_rembrandt,snd_sof_amd_renoir
snd_sof_xtensa_dsp     16384  1 snd_sof_amd_acp
qrtr                   57344  5 qrtr_mhi
crc16                  12288  2 bluetooth,ext4
snd_sof               409600  2 snd_sof_amd_acp,snd_sof_pci
mbcache                16384  1 ext4
joydev                 24576  0
ath11k_pci             24576  0
snd_sof_utils          16384  1 snd_sof
mousedev               24576  0
jbd2                  208896  1 ext4
ath11k                749568  1 ath11k_pci
snd_soc_core          438272  4 
snd_soc_acp6x_mach,snd_sof,snd_acp6x_pdm_dma,snd_soc_dmic
snd_ctl_led            24576  0
snd_compress           28672  1 snd_soc_core
intel_rapl_msr         20480  0
qmi_helpers            36864  1 ath11k
ac97_bus               12288  1 snd_soc_core
snd_hda_codec_realtek   192512  1
snd_pcm_dmaengine      16384  1 snd_soc_core
intel_rapl_common      36864  1 intel_rapl_msr
snd_hda_codec_generic   110592  1 snd_hda_codec_realtek
snd_hda_codec_hdmi     94208  1
snd_pci_ps             20480  0
mac80211             1527808  1 ath11k
edac_mce_amd           53248  0
snd_rpl_pci_acp6x      16384  0
snd_acp_pci            12288  0
snd_hda_intel          61440  10
snd_pci_acp6x          20480  0
snd_intel_dspcfg       32768  2 snd_hda_intel,snd_sof
kvm_amd               204800  0
snd_pci_acp5x          16384  0
snd_intel_sdw_acpi     16384  1 snd_intel_dspcfg
libarc4                12288  1 mac80211
snd_hda_codec         212992  4 
snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec_realtek
kvm                  1318912  1 kvm_amd
ucsi_acpi              12288  0
hid_multitouch         32768  0
snd_rn_pci_acp3x       24576  0
cfg80211             1286144  2 ath11k,mac80211
snd_hda_core          139264  5 
snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hda_codec_realtek
snd_acp_config         16384  6 
snd_rn_pci_acp3x,snd_pci_acp6x,snd_sof_amd_rembrandt,snd_acp_pci,snd_pci_ps,snd_sof_amd_renoir
think_lmi              36864  0
typec_ucsi             61440  1 ucsi_acpi
irqbypass              12288  1 kvm
snd_soc_acpi           12288  2 snd_sof_amd_acp,snd_acp_config
sp5100_tco             20480  0
snd_hwdep              20480  2 snd_usb_audio,snd_hda_codec
rapl                   20480  0
psmouse               233472  0
typec                 106496  1 typec_ucsi
acpi_cpufreq           32768  0
firmware_attributes_class    12288  1 think_lmi
wmi_bmof               12288  0
k10temp                16384  0
thunderbolt           495616  0
snd_pcm               196608  14 
snd_sof_amd_acp,snd_hda_codec_hdmi,snd_pci_acp6x,snd_hda_intel,snd_usb_audio,snd_hda_codec,snd_sof,snd_acp6x_pdm_dma,snd_compress,snd_soc_core,snd_sof_utils,snd_hda_core,snd_pci_ps,snd_pcm_dmaengine
snd_pci_acp3x          16384  0
i2c_piix4              32768  0
snd_timer              53248  3 snd_seq,snd_hrtimer,snd_pcm
mhi                   110592  2 ath11k_pci,qrtr_mhi
roles                  16384  1 typec_ucsi
i2c_hid_acpi           12288  0
i2c_hid                40960  1 i2c_hid_acpi
amd_pmc                36864  0
acpi_tad               20480  0
mac_hid                12288  0
vboxnetflt             40960  1
vboxnetadp             28672  0
vboxdrv               651264  4 vboxnetadp,vboxnetflt
vfat                   20480  1
fat                   102400  1 vfat
pkcs8_key_parser       12288  0
crypto_user            20480  0
fuse                  204800  5
loop                   40960  0
bpf_preload            20480  0
ip_tables              36864  3 iptable_filter,iptable_nat,iptable_mangle
x_tables               61440  4 
iptable_filter,ip_tables,iptable_nat,iptable_mangle
btrfs                2035712  1
blake2b_generic        24576  0
libcrc32c              12288  3 nf_conntrack,nf_nat,btrfs
crc32c_generic         12288  0
xor                    20480  1 btrfs
raid6_pq              122880  1 btrfs
dm_crypt               65536  1
cbc                    12288  0
encrypted_keys         28672  1 dm_crypt
trusted                53248  2 encrypted_keys,dm_crypt
asn1_encoder           12288  1 trusted
tee                    45056  1 trusted
dm_mod                217088  3 dm_crypt
serio_raw              16384  0
atkbd                  40960  0
crct10dif_pclmul       12288  1
libps2                 20480  2 atkbd,psmouse
crc32_pclmul           12288  0
vivaldi_fmap           12288  1 atkbd
crc32c_intel           16384  4
polyval_clmulni        12288  0
polyval_generic        12288  1 polyval_clmulni
gf128mul               16384  1 polyval_generic
nvme                   65536  4
ghash_clmulni_intel    16384  0
sha512_ssse3           45056  0
thinkpad_acpi         200704  0
aesni_intel           360448  6
snd                   147456  48 
snd_ctl_led,snd_hda_codec_generic,snd_seq,snd_seq_device,snd_hda_codec_hdmi,snd_hwdep,snd_hda_intel,snd_usb_audio,snd_usbmidi_lib,snd_hda_codec,snd_hda_codec_realtek,snd_sof,snd_timer,snd_compress,thinkpad_acpi,snd_soc_core,snd_pcm,snd_rawmidi
crypto_simd            16384  1 aesni_intel
cryptd                 28672  3 crypto_simd,ghash_clmulni_intel
soundcore              16384  2 snd_ctl_led,snd
xhci_pci               28672  0
nvme_core             237568  6 nvme
ledtrig_audio          12288  3 
snd_ctl_led,snd_hda_codec_generic,thinkpad_acpi
ccp                   155648  1 kvm_amd
xhci_pci_renesas       24576  1 xhci_pci
platform_profile       12288  1 thinkpad_acpi
nvme_common            20480  1 nvme_core
i8042                  53248  0
rfkill                 40960  6 bluetooth,thinkpad_acpi,cfg80211
serio                  28672  7 amd_pmc,serio_raw,atkbd,psmouse,i8042
amdgpu              11882496  67
i2c_algo_bit           20480  1 amdgpu
drm_ttm_helper         12288  1 amdgpu
ttm                    98304  2 amdgpu,drm_ttm_helper
video                  77824  2 thinkpad_acpi,amdgpu
wmi                    45056  3 video,wmi_bmof,think_lmi
drm_suballoc_helper    12288  1 amdgpu
drm_buddy              20480  1 amdgpu
gpu_sched              53248  1 amdgpu
drm_display_helper    204800  1 amdgpu
cec                    86016  1 drm_display_helper



-- 
François ARMAND

