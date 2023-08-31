Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D5678EA27
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 12:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbjHaK1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 06:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjHaK1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:27:35 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C455DCED;
        Thu, 31 Aug 2023 03:27:31 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bdcade7fbso69430966b.1;
        Thu, 31 Aug 2023 03:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693477650; x=1694082450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9rMQT9yusBBUN/RCuYBZaJicPTDoesLvwEVu8RRpkfw=;
        b=VdxD/oi9didiSjcfSaYAeC2JKfF6GaqZ8lcSptm4mXejwWfzAbq2wEPMltPp0HyZHI
         wVyHhTkH7kT+b0HSZW852COU3dtqWZL5m+vnso6rA24TFoCNAeBJbw5x7iXyG29psY61
         B3spkoha2oMnwHKzDIAvLe7PF1diiSxKKWK64pX6JG2jBrDNLwMXzngc2XNOvgrLVx0Z
         7woOS0qkFmFsk3TUfKPs0RWPbWEHtcTYjTozaQ+PPqwvVKLVRW2V8pOMuGJJr0COTG/x
         jpNKQrGs3wXr4GQBGI7Ud2LWuRJIkeKBYPW7ArvvRjiKM4/tCs2ECf2hcolt14QB6a0e
         BJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693477650; x=1694082450;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9rMQT9yusBBUN/RCuYBZaJicPTDoesLvwEVu8RRpkfw=;
        b=WeNk2wJivW6Deaeptlsxg7TnFZPzTgiwa40U9zs/vGLR3qSC3yWrvp18hcazhu++uG
         PWHxhgH6nZ13fJMu5eQ1Lq9J7TYCMxRl8nVJM5ZIV9Z1hHKl/Vho3/6AqAE32laAaaH3
         6MJz/D2TxfzBqzRlmyI1K5UviQEzSzZeU4PRu8ngCwh15m4R9upnE2sfbYa+MDB0iF3e
         Zy+JkpxEixXCKrd0KOpn719wJU4jNvMZP0w4/5tljKxWWI9mtYakhizMTAhRafUWQ0kW
         P0ydyBnjX/zkVvpProOcbnyks1/OqtCFjceoBz8E4bXkNOuBYNXtzdbULO9mnTdQJUB9
         Q1Kg==
X-Gm-Message-State: AOJu0Yw99VDmFxPOsxF+GHuMM0JkBkI6kzxvJL5ZqnkkW0mLQ8T7TpUB
        N79Y0DWVhgvOCZvC4Gf/tDA=
X-Google-Smtp-Source: AGHT+IF2/sYK+ET0W+3LRvFd8r455J9HqaoHLtAHHWxRx/3UIXdlPKvy9UyLiaphpNwziAbmSFXVGQ==
X-Received: by 2002:a17:907:ea7:b0:9a5:b8c1:2ce1 with SMTP id ho39-20020a1709070ea700b009a5b8c12ce1mr4552358ejc.31.1693477650018;
        Thu, 31 Aug 2023 03:27:30 -0700 (PDT)
Received: from [192.168.178.25] ([134.19.50.95])
        by smtp.gmail.com with ESMTPSA id x24-20020a170906805800b009894b476310sm596003ejw.163.2023.08.31.03.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 03:27:29 -0700 (PDT)
Message-ID: <55fc4a28-1e17-44df-2069-a688828080e6@gmail.com>
Date:   Thu, 31 Aug 2023 12:27:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH AUTOSEL 5.10 13/22] drm/amdgpu: install stub fence into
 potential unused fence pointers
Content-Language: en-US
To:     Chia-I Wu <olvaffe@gmail.com>, Sasha Levin <sashal@kernel.org>
Cc:     airlied@linux.ie, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        stable@vger.kernel.org, Lang Yu <Lang.Yu@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20230724012419.2317649-1-sashal@kernel.org>
 <20230724012419.2317649-13-sashal@kernel.org>
 <CAPaKu7RTgAMBLHbwtp4zgiBSDrTFtAj07k5qMzkuLQy2Zr+sZA@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAPaKu7RTgAMBLHbwtp4zgiBSDrTFtAj07k5qMzkuLQy2Zr+sZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 30.08.23 um 20:53 schrieb Chia-I Wu:
> On Sun, Jul 23, 2023 at 6:24 PM Sasha Levin <sashal@kernel.org> wrote:
>> From: Lang Yu <Lang.Yu@amd.com>
>>
>> [ Upstream commit 187916e6ed9d0c3b3abc27429f7a5f8c936bd1f0 ]
>>
>> When using cpu to update page tables, vm update fences are unused.
>> Install stub fence into these fence pointers instead of NULL
>> to avoid NULL dereference when calling dma_fence_wait() on them.
>>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
> We start getting this warning spew on chromeos

Yeah because the older kernels still kept track of the last VM fence in 
the syncobj.

This patch here should probably not have been back ported.

Why was that done anyway? The upstream commit doesn't have a CC stable 
and this is only a bug fix for a new feature not present on older kernels.

Regards,
Christian.


> , likely from
> dma_fence_is_later because the stub fence is on a different timeline:
>
> [  273.334767] WARNING: CPU: 1 PID: 13383 at
> include/linux/dma-fence.h:478 amdgpu_sync_keep_later+0x95/0xbd
> [  273.334769] Modules linked in: snd_seq_dummy snd_seq snd_seq_device
> bridge stp llc tun vhost_vsock vhost vhost_iotlb
> vmw_vsock_virtio_transport_common vsock 8021q veth lzo_rle
> lzo_compress zram uinput snd_acp_sof_mach snd_acp_mach snd_soc_dmic
> xt_cgroup rfcomm xt_MASQUERADE cmac algif_hash algif_skcipher af_alg
> btusb btrtl btintel btbcm rtw89_8852ae rtw89_pci rtw89_8852a
> rtw89_core snd_sof_amd_renoir snd_sof_xtensa_dsp snd_sof_amd_acp
> snd_acp_pci snd_acp_config snd_soc_acpi snd_pci_acp3x snd_sof_pci
> snd_sof snd_hda_codec_hdmi snd_sof_utils snd_hda_intel mac80211
> snd_intel_dspcfg snd_hda_codec cros_ec_typec snd_hwdep roles
> snd_hda_core typec snd_soc_rt5682s snd_soc_rt1019 snd_soc_rl6231
> ip6table_nat i2c_piix4 fuse bluetooth ecdh_generic ecc cfg80211
> iio_trig_sysfs cros_ec_lid_angle cros_ec_sensors cros_ec_sensors_core
> industrialio_triggered_buffer kfifo_buf industrialio cros_ec_sensorhub
> r8153_ecm cdc_ether usbnet r8152 mii uvcvideo videobuf2_vmalloc
> videobuf2_memops videobuf2_v4l2
> [  273.334795]  videobuf2_common joydev
> [  273.334799] CPU: 1 PID: 13383 Comm: chrome:cs0 Tainted: G        W
>         5.10.192-23384-g3d3f0f0c5e4f #1
> fe1e7e3b7510aa7b8e01701478119255f825a36f
> [  273.334800] Hardware name: Google Dewatt/Dewatt, BIOS
> Google_Dewatt.14500.347.0 03/30/2023
> [  273.334802] RIP: 0010:amdgpu_sync_keep_later+0x95/0xbd
> [  273.334804] Code: 00 00 b8 01 00 00 00 f0 0f c1 43 38 85 c0 74 26
> 8d 48 01 09 c1 78 24 49 89 1e 5b 41 5e 5d c3 cc cc cc cc e8 4a 94 ac
> ff eb ce <0f> 0b 49 8b 06 48 85 c0 75 af eb c2 be 02 00 00 00 48 8d 7b
> 38 e8
> [  273.334805] RSP: 0018:ffffb222c1817b50 EFLAGS: 00010293
> [  273.334807] RAX: ffffffff89bfc838 RBX: ffff8aa425e9ed00 RCX: 0000000000000000
> [  273.334808] RDX: ffff8aa426156a98 RSI: ffff8aa425e9ed00 RDI: ffff8aa432518918
> [  273.334810] RBP: ffffb222c1817b60 R08: ffff8aa43ca6c0a0 R09: ffff8aa33af3c9a0
> [  273.334811] R10: fffffcf8c5986600 R11: ffffffff87a00fce R12: 0000000000000098
> [  273.334812] R13: 00000000005e2a00 R14: ffff8aa432518918 R15: 0000000000000000
> [  273.334814] FS:  00007e70f8694640(0000) GS:ffff8aa4e6080000(0000)
> knlGS:0000000000000000
> [  273.334816] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  273.334817] CR2: 00007e70ea049020 CR3: 0000000178e6e000 CR4: 0000000000750ee0
> [  273.334818] PKRU: 55555554
> [  273.334819] Call Trace:
> [  273.334822]  ? __warn+0xa3/0x131
> [  273.334824]  ? amdgpu_sync_keep_later+0x95/0xbd
> [  273.334826]  ? report_bug+0x97/0xfa
> [  273.334829]  ? handle_bug+0x41/0x66
> [  273.334832]  ? exc_invalid_op+0x1b/0x72
> [  273.334835]  ? asm_exc_invalid_op+0x12/0x20
> [  273.334837]  ? native_sched_clock+0x9a/0x9a
> [  273.334840]  ? amdgpu_sync_keep_later+0x95/0xbd
> [  273.334843]  amdgpu_sync_vm_fence+0x23/0x39
> [  273.334846]  amdgpu_cs_ioctl+0x1782/0x1e56
> [  273.334851]  ? amdgpu_cs_report_moved_bytes+0x5f/0x5f
> [  273.334854]  drm_ioctl_kernel+0xdf/0x150
> [  273.334858]  drm_ioctl+0x1f5/0x3d2
> [  273.334928]  ? amdgpu_cs_report_moved_bytes+0x5f/0x5f
> [  273.334932]  amdgpu_drm_ioctl+0x49/0x81
> [  273.334935]  __x64_sys_ioctl+0x7d/0xc8
> [  273.334937]  do_syscall_64+0x42/0x54
> [  273.334939]  entry_SYSCALL_64_after_hwframe+0x4a/0xaf
> [  273.334941] RIP: 0033:0x7e70ff797649
> [  273.334943] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10
> c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00
> 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 77 1d 48 8b 45 c8 64 48 2b 04 25 28
> 00 00
> [  273.334945] RSP: 002b:00007e70f8693170 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010
> [  273.334947] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007e70ff797649
> [  273.334948] RDX: 00007e70f8693248 RSI: 00000000c0186444 RDI: 0000000000000013
> [  273.334950] RBP: 00007e70f86931c0 R08: 00007e70f8693350 R09: 00007e70f8693340
> [  273.334951] R10: 000000000000000a R11: 0000000000000246 R12: 00000000c0186444
> [  273.334952] R13: 00007e70f8693380 R14: 00007e70f8693248 R15: 0000000000000013
> [  273.334954] ---[ end trace fc066a0fcea39e8c ]---

