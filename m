Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A32800F9C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 17:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379484AbjLAPfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379464AbjLAPf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:35:29 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4682F194
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:35:35 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B1Cx66t003628;
        Fri, 1 Dec 2023 09:35:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=YzcY4AtfeWuF2AzFjeIMHMQXTXNXxXbJu0r2/vmZFBY=; b=
        ewbjU3WUPuDK9jeTX0Q524hIueB6kINYPS7I0gAG06IBPjqrWb049/rAmjye4CH7
        SKH1SMor6UoqLinoFewSPwkK761Nlp9xuN2g7grBOpI5R4Fmooi9T7B0QgLo/+Fs
        FXQm0bSrzH+8L1qij2cfh4VKya9qqcPhnEuNyDQDZSE/V4J2T1s32RZgXrNLjKam
        CR71ZHqX5sT6r7vlT/qrtnA5oLR7dO8XJL4oQT/zih0Z9qa8wnlUWXbrAIOAekar
        gSUhiCm61BzAUwTBtEo5q28Kqbrg4qdiVLD8eJeLGS+YBG+VypBiN9zCTmTsejJk
        o9Ez20xLSjiuyD4bRGz4Jg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3unvhpbke6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Dec 2023 09:35:29 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 1 Dec
 2023 15:35:27 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.39 via Frontend Transport; Fri, 1 Dec 2023 15:35:27 +0000
Received: from [198.61.65.94] (EDIN4L06LR3.ad.cirrus.com [198.61.65.94])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BEE2B468;
        Fri,  1 Dec 2023 15:35:26 +0000 (UTC)
Message-ID: <328d1d32-26a0-4e70-8694-237e8ac9f9f6@opensource.cirrus.com>
Date:   Fri, 1 Dec 2023 15:35:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: platform-device-test on 6.6 causes "(null)' : is not initialized,
 yet kobject_get() is being called"
Content-Language: en-US
To:     Maxime Ripard <mripard@kernel.org>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Marco Pagani <marpagan@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, - <patches@opensource.cirrus.com>
References: <e239b94b-462a-41e5-9a4c-cd1ffd530d75@opensource.cirrus.com>
 <oho6bypbvr7rhveiqmosp3wmb7ptygcuuuq6v2jrsqugfuyfas@5czwntre4pc5>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <oho6bypbvr7rhveiqmosp3wmb7ptygcuuuq6v2jrsqugfuyfas@5czwntre4pc5>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: f1QvGvTvocHm-ccCSy00UEqpVNJMmQpf
X-Proofpoint-ORIG-GUID: f1QvGvTvocHm-ccCSy00UEqpVNJMmQpf
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/23 14:42, Maxime Ripard wrote:
> Hi,
> 
> On Wed, Nov 15, 2023 at 01:28:13PM +0000, Richard Fitzgerald wrote:
>> Target platform: Aaeon Whiskeylake UpXtreme (Celeron CPU)
>> Target OS: Debian 11 (non-graphical install)
>>
>> Kernel: v6.6.1 from
>> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
>> branch: linux-6.6.y
>> at commit 8afabe2118a9 ("Linux 6.6.1")
>>
>> defconfig attached.
>>
>> CONFIG_DM_KUNIT_TEST=m
>>
>> gcc (Debian 10.2.1-6) 10.2.1 20210110
>>
>> loading the module to run the test causes kobject_get() to WARN:
>>
>> sudo modprobe platform-device-test
>>
>> [   82.595238] KTAP version 1
>> [   82.595252] 1..1
>> [   82.595487]     KTAP version 1
>> [   82.595489]     # Subtest: platform-device-devm
>> [   82.595490]     # module: platform_device_test
>> [   82.595493]     1..4
>> [   82.596130]     ok 1 platform_device_devm_register_unregister_test
>> [   82.596314]     ok 2
>> platform_device_devm_register_get_unregister_with_devm_test
>> [   82.596387] ------------[ cut here ]------------
>> [   82.596395] kobject: '(null)' (0000000067030afc): is not initialized, yet
>> kobject_get() is being called.
>> [   82.596410] WARNING: CPU: 1 PID: 654 at lib/kobject.c:637
>> kobject_get+0x4c/0x70
>> [   82.596415] Modules linked in: platform_device_test(E+)
>> x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) crc32_pclmul(E)
>> ghash_clmulni_intel(E) sha512_ssse3(E) sha512_generic(E) nls_ascii(E)
>> nls_cp437(E) vfat(E) fat(E) aesni_intel(E) libaes(E) crypto_simd(E)
>> cryptd(E) mei_wdt(E) mei_hdcp(E) snd_hda_codec_hdmi(E) watchdog(E) rapl(E)
>> intel_rapl_msr(E) snd_hda_codec_cs8409(E) snd_hda_codec_generic(E)
>> intel_cstate(E) ledtrig_audio(E) snd_hda_intel(E) snd_intel_dspcfg(E)
>> intel_uncore(E) snd_hda_codec(E) processor_thermal_device_pci_legacy(E)
>> processor_thermal_device(E) snd_hda_core(E) processor_thermal_rfim(E)
>> efi_pstore(E) pcspkr(E) mei_me(E) wmi_bmof(E) snd_pcm(E)
>> processor_thermal_mbox(E) processor_thermal_rapl(E) snd_timer(E)
>> intel_rapl_common(E) int340x_thermal_zone(E) snd(E) intel_soc_dts_iosf(E)
>> mei(E) intel_pch_thermal(E) soundcore(E) tpm_crb(E) evdev(E) tpm_tis(E)
>> tpm_tis_core(E) tpm(E) intel_pmc_core(E) acpi_pad(E) rng_core(E) acpi_tad(E)
>> button(E) msr(E) fuse(E) configfs(E) efivarfs(E) ip_tables(E)
>> [   82.596473]  x_tables(E) autofs4(E) ext4(E) crc32c_generic(E) crc16(E)
>> mbcache(E) jbd2(E) spi_pxa2xx_platform(E) dw_dmac(E) dw_dmac_core(E)
>> mmc_block(E) i915(E) drm_buddy(E) ttm(E) intel_gtt(E) drm_display_helper(E)
>> drm_kms_helper(E) sdhci_pci(E) xhci_pci(E) drm(E) crct10dif_pclmul(E)
>> cqhci(E) crct10dif_common(E) intel_lpss_pci(E) crc32c_intel(E) sdhci(E)
>> intel_lpss(E) xhci_hcd(E) i2c_i801(E) cec(E) i2c_smbus(E) idma64(E)
>> mmc_core(E) usbcore(E) usb_common(E) fan(E) video(E) wmi(E)
>> [   82.596508] CPU: 1 PID: 654 Comm: kunit_try_catch Tainted: G   E    N
>> 6.6.1-test #1
>> [   82.596510] Hardware name: AAEON UP-WHL01/UP-WHL01, BIOS UPW1AM19
>> 11/10/2020
>> [   82.596512] RIP: 0010:kobject_get+0x4c/0x70
>> [   82.596515] Code: 44 24 38 85 c0 74 3b 78 25 83 c0 01 78 20 4c 89 e0 41
>> 5c c3 cc cc cc cc 48 8b 37 48 89 fa 48 c7 c7 80 a6 a1 92 e8 64 2a 68 ff <0f>
>> 0b eb c4 be 01 00 00 00 e8 26 08 af ff 4c 89 e0 41 5c c3 cc cc
>> [   82.596517] RSP: 0018:ffffa2cf814e7d40 EFLAGS: 00010286
>> [   82.596519] RAX: 0000000000000000 RBX: ffffffffc111c510 RCX:
>> ffff8e28e3c9c888
>> [   82.596521] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI:
>> ffff8e28e3c9c880
>> [   82.596522] RBP: ffff8e27843e48c0 R08: 0000000000000000 R09:
>> 00000000ffffefff
>> [   82.596524] R10: ffffa2cf814e7be0 R11: ffffffff92cd2788 R12:
>> ffffffffc111c510
>> [   82.596525] R13: 0000000000000000 R14: 0000000000000000 R15:
>> ffff8e2784968da0
>> [   82.596526] FS:  0000000000000000(0000) GS:ffff8e28e3c80000(0000)
>> knlGS:0000000000000000
>> [   82.596528] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   82.596530] CR2: 0000558fd9288c70 CR3: 000000002b020003 CR4:
>> 00000000003706e0
>> [   82.596531] Call Trace:
>> [   82.596532]  <TASK>
>> [   82.596534]  ? __warn+0x84/0x170
>> [   82.596538]  ? kobject_get+0x4c/0x70
>> [   82.596541]  ? report_bug+0x198/0x1b0
>> [   82.596545]  ? handle_bug+0x3c/0x70
>> [   82.596547]  ? exc_invalid_op+0x18/0x70
>> [   82.596549]  ? asm_exc_invalid_op+0x1a/0x20
>> [   82.596554]  ? kobject_get+0x4c/0x70
>> [   82.596557]  kobject_add_internal+0x30/0x2b0
>> [   82.596560]  kobject_add+0x7e/0xf0
>> [   82.596565]  kobject_create_and_add+0x51/0x90
>> [   82.596567]  module_add_driver+0xfe/0x110
>> [   82.596571]  bus_add_driver+0x130/0x220
>> [   82.596575]  ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
>> [   82.596578]  driver_register+0x60/0x120
>> [   82.596581]
>> probed_platform_device_devm_register_unregister_test+0x40/0x3e0
>> [platform_device_test]
>> [   82.596587]  ? platform_device_devm_init+0x74/0xd0 [platform_device_test]
>> [   82.596593]  ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
>> [   82.596595]  kunit_generic_run_threadfn_adapter+0x17/0x30
>> [   82.596597]  kthread+0xf4/0x130
>> [   82.596600]  ? __pfx_kthread+0x10/0x10
>> [   82.596604]  ret_from_fork+0x31/0x50
>> [   82.596606]  ? __pfx_kthread+0x10/0x10
>> [   82.596609]  ret_from_fork_asm+0x1b/0x30
>> [   82.596615]  </TASK>
>> [   82.596616] irq event stamp: 975
>> [   82.596618] hardirqs last  enabled at (981): [<ffffffff9193aa6d>]
>> console_unlock+0x10d/0x130
>> [   82.596621] hardirqs last disabled at (986): [<ffffffff9193aa52>]
>> console_unlock+0xf2/0x130
>> [   82.596624] softirqs last  enabled at (0): [<ffffffff9188890f>]
>> copy_process+0xa8f/0x2080
>> [   82.596626] softirqs last disabled at (0): [<0000000000000000>] 0x0
>> [   82.596628] ---[ end trace 0000000000000000 ]---
> 
> It's not entirely clear to me what could be happening here, but it looks
> similar to the issue that Marco was fixing here:
> https://lore.kernel.org/linux-kselftest/20231128101627.65399-1-marpagan@redhat.com/
> 
> Could you test with that fix and see if it still happens?
> 
> Thanks!
> Maxime

Yes, Marco's patch fixes it.

