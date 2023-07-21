Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701A075D7E4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 01:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjGUX3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 19:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjGUX32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 19:29:28 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F551FDF;
        Fri, 21 Jul 2023 16:29:27 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-3460815fde5so11995965ab.2;
        Fri, 21 Jul 2023 16:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689982166; x=1690586966;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2HWGARuGkqEQdwec4wVxh4cga8KRSu+tscD+lku9ZUc=;
        b=VLZ5o+l0fG8iK3OzCCTmVzkfQunTMneXN2K0omC8jPnvlkv5fcpAo0StcIQ1PHGsMS
         gT1rcKNt4z1ruZNcaO9aEhAgk9xK+bLwmswUbr8+uKAqRRDR8kcBViKSG94d0/SyypFC
         saVBYJ5HgZxNjBDfswsY0cJWkIl1YLrVlK4KXKQqzOIwjtZbmoYsKx1TSCEO2mR4sYqg
         KgFg6q6UHOnOJJMTLzsv/a+iig/rjZ+qG+b4tub0nyx3eVtpPyZfPB3hqsDyPWnKxQXK
         HUHI/OpWJTfuYgnaVxp820BwJX6P62JIbwt/wo8+BjDkueO7NJc87+isN9nxn3x6gMPT
         rcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689982166; x=1690586966;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2HWGARuGkqEQdwec4wVxh4cga8KRSu+tscD+lku9ZUc=;
        b=kHOPHrZTy612Bi81BsvsqSmkAPJTUsybxYeZjkMSoIBJroY8tsse6j02PP86rhEUQo
         vhXKbr5yYFQOkMwYrL90eQLfSdD4nYugQuReTa8cxt/IrQNCgJL4e2iYtoun4q8cVWrt
         SQp888XekWLTcZBX+e7PjI2rfv+AOC3cuTXgx0Y05sSMFHD1G4IJPB9xlLAD7saZgWS4
         lQJVC0+uxhTG6NGIjMiMWltGIinFXSGHPT2S+oum9e8trptV2rg9gr+zF1RERYjfytCP
         9mYT3/IfxwS5bRp7x7jBywCaEJDnySso2Bnq9T37sTlZwCXed+b5gyRnEkWHNYcV/tNB
         oOwA==
X-Gm-Message-State: ABy/qLaVxHWdhONDgHzV3OO6xtIkar7xVHaYIC8XWIYpLG8dhLjcq1AB
        dq8FalK+h9WpyDlSlNo/rYI=
X-Google-Smtp-Source: APBJJlGbUUfSCFEYZlRSb36o73TmUpSRq6UROhCUu0k4DBZOU/U5Pgop/szMukqykTsBvSEYFB6BtA==
X-Received: by 2002:a05:6e02:5c3:b0:346:169a:bb4b with SMTP id l3-20020a056e0205c300b00346169abb4bmr1341246ils.4.1689982166564;
        Fri, 21 Jul 2023 16:29:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id kb14-20020a170903338e00b001b9be79729csm4046487plb.165.2023.07.21.16.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 16:29:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f268ae1d-f23b-8c3b-8e94-a7ef76fc4990@roeck-us.net>
Date:   Fri, 21 Jul 2023 16:29:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230626180746.943455203@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 5.15 00/96] 5.15.119-rc1 review
In-Reply-To: <20230626180746.943455203@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/26/23 11:11, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.119 release.
> There are 96 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
> 
[ ... ]
> Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>      drm/amd/display: Add wrapper to call planes and stream update
> 
> Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>      drm/amd/display: Use dc_update_planes_and_stream
> 
> Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>      drm/amd/display: Add minimal pipe split transition state
> 

Just as a heads-up, the above patches result in UI failures when booting
chromeos-5.15 on a Stoney GPU. I don't know if that is because of other
ChromeOS specific backports into chromeos-5.15, so there may be no problem
with linux-5.15.y. I just wanted to report it in case others observe a
similar problem. For reference, the warning traceback observed with
chromeos-5.15 is attached below.

Reverting the above patches fixes the problem for us.

Guenter

---
[   40.701227] ------------[ cut here ]------------
[   40.701235] WARNING: CPU: 0 PID: 2026 at drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.c:393 dce_aux_transfer_raw+0x54f/0x738 [amdgpu]
[   40.701417] Modules linked in: xt_cgroup btusb joydev btrtl btintel btbcm xt_MASQUERADE uvcvideo videobuf2_vmalloc ax88179_178a usbnet videobuf2_memops mii videobuf2_v4l2 videobuf2_common rtw88_8821ce rtw88_8821c rtw88_pci rtw88_core psmouse fam15h_power k10temp mac80211 i2c_piix4 r8169 realtek snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi ledtrig_audio snd_hda_intel snd_hda_codec snd_hwdep snd_hda_core ip6table_nat fuse cfg80211 bluetooth ecdh_generic ecc lzo_rle lzo_compress zram nls_iso8859_1 nls_cp437 vfat fat amdgpu drm_buddy gpu_sched drm_ttm_helper ttm hp_wmi drm_display_helper sparse_keymap platform_profile wmi_bmof cec video wmi backlight
[   40.701477] CPU: 0 PID: 2026 Comm: fwupd Not tainted 5.15.120-20012-g13671c9741ee #1 498f2dc5e165de69fea5f8cdcc6c5b2a52bfbe44
[   40.701484] Hardware name: HP HP Laptop 15-db0xxx/84AC, BIOS F.21 08/30/2019
[   40.701487] RIP: 0010:dce_aux_transfer_raw+0x54f/0x738 [amdgpu]
[   40.701622] Code: 70 18 48 c7 c2 73 d0 67 c0 e8 81 50 f1 ff 41 89 c4 0f ba e0 09 48 8b 4d b8 48 8b 55 88 b8 04 00 00 00 72 28 41 f6 c4 01 75 09 <0f> 0b b8 03 00 00 00 eb 19 b8 03 00 00 00 41 f6 c4 f0 75 0e b8 02
[   40.701626] RSP: 0018:ffffb36901a5bbf8 EFLAGS: 00010246
[   40.701630] RAX: 0000000000000004 RBX: ffff8f75c7e23a00 RCX: ffffb36901a5bc84
[   40.701633] RDX: ffffb36901a5bc88 RSI: ffff8f75c2616580 RDI: ffff8f75c7a40000
[   40.701636] RBP: ffffb36901a5bc70 R08: 0000000000000001 R09: 000000000000000a
[   40.701639] R10: 000000000000ff00 R11: ffffffffc02bae29 R12: 0000000000000000
[   40.701641] R13: 0000000000000000 R14: ffffb36901a5bd3f R15: 0000000000000000
[   40.701644] FS:  00007afcd2d76780(0000) GS:ffff8f75cdc00000(0000) knlGS:0000000000000000
[   40.701647] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   40.701650] CR2: 000025cd033e2000 CR3: 000000003dec2000 CR4: 00000000001506f0
[   40.701653] Call Trace:
[   40.701657]  <TASK>
[   40.701661]  ? __warn+0xa3/0x131
[   40.701670]  ? dce_aux_transfer_raw+0x54f/0x738 [amdgpu a9c22b8374912b6290fb299545c9bc23d10c4dee]
[   40.701775]  ? report_bug+0x97/0xfa
[   40.701783]  ? handle_bug+0x41/0x66
[   40.701787]  ? exc_invalid_op+0x1b/0x4b
[   40.701791]  ? asm_exc_invalid_op+0x16/0x20
[   40.701795]  ? amdgpu_cgs_destroy_device+0xf/0xf [amdgpu a9c22b8374912b6290fb299545c9bc23d10c4dee]
[   40.701895]  ? dce_aux_transfer_raw+0x54f/0x738 [amdgpu a9c22b8374912b6290fb299545c9bc23d10c4dee]
[   40.701990]  ? dce_aux_transfer_raw+0x533/0x738 [amdgpu a9c22b8374912b6290fb299545c9bc23d10c4dee]
[   40.702119]  dm_dp_aux_transfer+0xa1/0x127 [amdgpu a9c22b8374912b6290fb299545c9bc23d10c4dee]
[   40.702255]  drm_dp_dpcd_access+0x8e/0x120 [drm_display_helper bafd2440f737065f4481ed31c70f27c5ee4cb409]
[   40.702266]  drm_dp_dpcd_probe+0x46/0xfa [drm_display_helper bafd2440f737065f4481ed31c70f27c5ee4cb409]
[   40.702273]  drm_dp_dpcd_read+0x5b/0x106 [drm_display_helper bafd2440f737065f4481ed31c70f27c5ee4cb409]
[   40.702280]  auxdev_read_iter+0xe4/0x1a9 [drm_display_helper bafd2440f737065f4481ed31c70f27c5ee4cb409]
[   40.702287]  vfs_read+0x1d2/0x32d
[   40.702295]  __x64_sys_read+0x7c/0xe2
[   40.702299]  do_syscall_64+0x53/0xa1
[   40.702305]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[   40.702310] RIP: 0033:0x7afcd2c8180a
[   40.702315] Code: 55 48 89 e5 48 83 ec 20 48 89 55 e8 48 89 75 f0 89 7d f8 e8 28 96 f8 ff 48 8b 55 e8 48 8b 75 f0 41 89 c0 8b 7d f8 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 2e 44 89 c7 48 89 45 f8 e8 82 96 f8 ff 48 8b
[   40.702318] RSP: 002b:00007ffc037fb090 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[   40.702322] RAX: ffffffffffffffda RBX: 00007ffc037fb15c RCX: 00007afcd2c8180a
[   40.702325] RDX: 0000000000000001 RSI: 00007ffc037fb15c RDI: 000000000000000e
[   40.702328] RBP: 00007ffc037fb0b0 R08: 0000000000000000 R09: 00007ffc037fb1e8
[   40.702330] R10: 97913fda310400e9 R11: 0000000000000246 R12: 00000000000004b0
[   40.702333] R13: 0000000000000001 R14: 0000000000000001 R15: 000058833f394ba0
[   40.702337]  </TASK>
[   40.702339] ---[ end trace 45d9123147b37667 ]---
[   40.707210] [drm] REG_WAIT timeout 10us * 240 tries - submit_channel_request line:222
[   40.728925] [drm] REG_WAIT timeout 10us * 240 tries - submit_channel_request line:222
[   40.737218] [drm] REG_WAIT timeout 10us * 240 tries - submit_channel_request line:222
[   40.756655] [drm] REG_WAIT timeout 10us * 240 tries - submit_channel_request line:222
[   40.760616] [drm] REG_WAIT timeout 10us * 240 tries - submit_channel_request line:222
[   40.766107] ------------[ cut here ]------------

