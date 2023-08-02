Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B366C76D8C1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 22:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjHBUmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 16:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjHBUmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 16:42:39 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404D7171B;
        Wed,  2 Aug 2023 13:42:38 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bb775625e2so1930145ad.1;
        Wed, 02 Aug 2023 13:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691008957; x=1691613757;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JMI56llryw1ayYDFFRqPyr403Rv4ukTocjocPut0FtA=;
        b=Kqz5IRzniMkPbqKM/kIetHLw5wyRm7HrIho7OBFf96HCIGyK+gM6BxvMP94xu+zplI
         p55Ab/pMy9rEROHZ9Xi/yr0k9fcuZEASSwupPrCSAo5GslX6VxK2d1KAm17l+RGKkdxn
         hi37ot8xoq3f9Wx9BVNLD7TRwJrNbV/enFGnio6up2u2rOcoEY5b3ufh2jqnOAX8PS+k
         UQ34f+HrWSElGI9727ttWV4SjBSvsvG7f4DpOBkeRXiOYOaNg9KUug0wtzcLxxWZWUsi
         1Sg1sGyiQglqfAnmi4giEqjeRgkr3oU9ySi87o8gdb4265SooIqz3Rri9wlEkLDQa7jY
         Oyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691008957; x=1691613757;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JMI56llryw1ayYDFFRqPyr403Rv4ukTocjocPut0FtA=;
        b=IiAE1WSCYmDMGq7nElHx9bR05WEmvorBgYsj+OLda1kh0Z+vjznDLur2bfKp7Fo5xm
         NsPtdbNXMRzShQtSqWnaVwO52V7Ut3zCV2IHYE/Dxmk94Sgn0TGE836yMqi+hawbLtd+
         xd/d0CgdvNweuvftCl2c0oS0xGfzJVNvf/M+xlMUK3XmQ5LxxtzG7ZczDLPRLQENS2+T
         lfXgzzEClGo7TFYz9OjUpUrRxgtVaXN9RdtXIK0lko2Bi2nX3UwuVtecKjuhlCEko31f
         +fgSEKmmQZ3N2XzC2id2Hvtpn1128ZqMTtfW7NaoK3iMd+uH97E8DbDxmArsI7xO5iE7
         13vQ==
X-Gm-Message-State: ABy/qLYvwh2aXECOyTBKZgIvOeQAdLV5V+8F4w6Wks35dWLb7H9Zv+DQ
        UmiwPCzeOyl927TOREruJe4=
X-Google-Smtp-Source: APBJJlHigFGdbdiM4tGsWctDPdhtT65Gh0V6/6kIBJ2kNaKfR+MkUDPaJfnWNqjyq9VKRGExPhKMtA==
X-Received: by 2002:a17:902:f54e:b0:1ba:fe6a:3845 with SMTP id h14-20020a170902f54e00b001bafe6a3845mr23984179plf.11.1691008957496;
        Wed, 02 Aug 2023 13:42:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x3-20020a170902fe8300b001bbb7d8fff2sm7984165plm.116.2023.08.02.13.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 13:42:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <20ca1c6c-842f-499f-5119-2cbde6ed9ab4@roeck-us.net>
Date:   Wed, 2 Aug 2023 13:42:35 -0700
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
References: <20230802065510.869511253@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 6.1 000/225] 6.1.43-rc2 review
In-Reply-To: <20230802065510.869511253@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/23 00:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.43 release.
> There are 225 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 04 Aug 2023 06:54:28 +0000.
> Anything received after that time might be too late.
> 

I see crashes when booting with a f2fs root file system on arm-aspeed systems.

For whatever reason are the only f2fs tests I am running, so it is very likely
that f2fs is completely broken in this release candidate.

Guenter

---
[    7.018008] 8<--- cut here ---
[    7.018137] Unable to handle kernel NULL pointer dereference at virtual address 00000034
[    7.018261] [00000034] *pgd=00000000
[    7.018555] Internal error: Oops: 5 [#1] SMP ARM
[    7.018754] CPU: 0 PID: 193 Comm: seedrng Not tainted 6.1.43-rc2-00226-gbdcf4e82a088 #1
[    7.018897] Hardware name: Generic DT based system
[    7.019011] PC is at f2fs_issue_flush+0x160/0x210
[    7.019367] LR is at f2fs_do_sync_file+0x7c8/0xaa8
[    7.019438] pc : [<8060fc94>]    lr : [<805c63f0>]    psr: 40000013
[    7.019517] sp : e0c65e78  ip : 00000000  fp : 000001a7
[    7.019586] r10: 00000000  r9 : 00000000  r8 : 000001a7
[    7.019658] r7 : 8330e1c0  r6 : 83509000  r5 : 00000000  r4 : 00000034
[    7.019744] r3 : e555c589  r2 : 82f36e00  r1 : 000001a7  r0 : 83509000
[    7.019856] Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    7.019957] Control: 10c5387d  Table: 840c006a  DAC: 00000051
[    7.020047] Register r0 information: slab kmalloc-4k start 83508000 data offset 4096 pointer offset 0 size 4096 allocated at f2fs_fill_super+0x50/0x22d4
[    7.020619]     kmalloc_trace+0x30/0x144
[    7.020689]     f2fs_fill_super+0x50/0x22d4
[    7.020748]     mount_bdev+0x174/0x1ac
[    7.020802]     f2fs_mount+0x1c/0x28
[    7.020853]     legacy_get_tree+0x2c/0x54
[    7.020909]     vfs_get_tree+0x2c/0xf4
[    7.020961]     path_mount+0x6ec/0xafc
[    7.021013]     init_mount+0x5c/0x88
[    7.021065]     do_mount_root+0x7c/0x10c
[    7.021119]     mount_block_root+0xcc/0x1e0
[    7.021174]     prepare_namespace+0x134/0x18c
[    7.021231]     kernel_init+0x1c/0x138
[    7.021284]     ret_from_fork+0x14/0x2c
[    7.021345]  Free path:
[    7.021410]     vfat_fill_super+0x20/0x2c
[    7.021476]     mount_bdev+0x174/0x1ac
[    7.021530]     vfat_mount+0x1c/0x28
[    7.021581]     legacy_get_tree+0x2c/0x54
[    7.021636]     vfs_get_tree+0x2c/0xf4
[    7.021688]     path_mount+0x6ec/0xafc
[    7.021738]     init_mount+0x5c/0x88
[    7.021788]     do_mount_root+0x7c/0x10c
[    7.021841]     mount_block_root+0xcc/0x1e0
[    7.021896]     prepare_namespace+0x134/0x18c
[    7.021953]     kernel_init+0x1c/0x138
[    7.022004]     ret_from_fork+0x14/0x2c
[    7.022077] Register r1 information: non-paged memory
[    7.022206] Register r2 information: slab kmalloc-192 start 82f36dc0 data offset 64 pointer offset 0 size 192 allocated at f2fs_build_segment_manager+0x40/0x2198
[    7.022399]     kmalloc_trace+0x30/0x144
[    7.022454]     f2fs_build_segment_manager+0x40/0x2198
[    7.022518]     f2fs_fill_super+0x1414/0x22d4
[    7.022576]     mount_bdev+0x174/0x1ac
[    7.022628]     f2fs_mount+0x1c/0x28
[    7.022678]     legacy_get_tree+0x2c/0x54
[    7.022733]     vfs_get_tree+0x2c/0xf4
[    7.022787]     path_mount+0x6ec/0xafc
[    7.022839]     init_mount+0x5c/0x88
[    7.022890]     do_mount_root+0x7c/0x10c
[    7.022943]     mount_block_root+0xcc/0x1e0
[    7.022998]     prepare_namespace+0x134/0x18c
[    7.023055]     kernel_init+0x1c/0x138
[    7.023106]     ret_from_fork+0x14/0x2c
[    7.023158] Register r3 information: non-paged memory
[    7.023247] Register r4 information: non-paged memory
[    7.023316] Register r5 information: NULL pointer
[    7.023380] Register r6 information: slab kmalloc-4k start 83508000 data offset 4096 pointer offset 0 size 4096 allocated at f2fs_fill_super+0x50/0x22d4
[    7.023561]     kmalloc_trace+0x30/0x144
[    7.023615]     f2fs_fill_super+0x50/0x22d4
[    7.023672]     mount_bdev+0x174/0x1ac
[    7.023724]     f2fs_mount+0x1c/0x28
[    7.023774]     legacy_get_tree+0x2c/0x54
[    7.023829]     vfs_get_tree+0x2c/0xf4
[    7.023881]     path_mount+0x6ec/0xafc
[    7.023932]     init_mount+0x5c/0x88
[    7.023982]     do_mount_root+0x7c/0x10c
[    7.024035]     mount_block_root+0xcc/0x1e0
[    7.024090]     prepare_namespace+0x134/0x18c
[    7.024156]     kernel_init+0x1c/0x138
[    7.024208]     ret_from_fork+0x14/0x2c
[    7.024260]  Free path:
[    7.024298]     vfat_fill_super+0x20/0x2c
[    7.024352]     mount_bdev+0x174/0x1ac
[    7.024404]     vfat_mount+0x1c/0x28
[    7.024454]     legacy_get_tree+0x2c/0x54
[    7.024509]     vfs_get_tree+0x2c/0xf4
[    7.024560]     path_mount+0x6ec/0xafc
[    7.024612]     init_mount+0x5c/0x88
[    7.024661]     do_mount_root+0x7c/0x10c
[    7.024714]     mount_block_root+0xcc/0x1e0
[    7.024769]     prepare_namespace+0x134/0x18c
[    7.024826]     kernel_init+0x1c/0x138
[    7.024877]     ret_from_fork+0x14/0x2c
[    7.024929] Register r7 information: slab task_struct start 8330e180 data offset 64 pointer offset 0 allocated at copy_process+0x198/0x1580
[    7.025096]     copy_process+0x198/0x1580
[    7.025151]     kernel_clone+0x90/0x490
[    7.025204]     sys_fork+0x3c/0x58
[    7.025253]     ret_fast_syscall+0x0/0x54
[    7.025319]  Free path:
[    7.025356]     __do_softirq+0x118/0x3e4
[    7.025409] Register r8 information: non-paged memory
[    7.025477] Register r9 information: NULL pointer
[    7.025541] Register r10 information: NULL pointer
[    7.025605] Register r11 information: non-paged memory
[    7.025673] Register r12 information: NULL pointer
[    7.025745] Process seedrng (pid: 193, stack limit = 0xe0c64000)
[    7.025856] Stack: (0xe0c65e78 to 0xe0c66000)
[    7.025957] 5e60:                                                       835093f0 8116b528
[    7.026060] 5e80: 60000013 8330e8f8 805c65d4 00000001 000001a7 8017c2f0 835093b4 00000001
[    7.026155] 5ea0: 83509000 00000001 00000000 e555c589 835093e0 e555c589 83cd7760 83509000
[    7.026249] 5ec0: 8330e1c0 00000000 00000000 00000000 00000000 805c63f0 e0c65f0c 7fffffff
[    7.026342] 5ee0: 836b0280 8116b528 60000013 81211d10 805c6714 83cd7a10 8330e1c0 8017c2f0
[    7.026436] 5f00: 00000001 00000000 01010006 00000000 7fffffff 00000000 00000000 00000000
[    7.026529] 5f20: 00000000 00000000 00000001 00000000 00000000 00000000 00000000 e555c589
[    7.026624] 5f40: 00000000 ffffffff 7fffffff 836b0200 00000076 801002e8 8330e1c0 00000076
[    7.026717] 5f60: 0053c8ca 805c6714 ffffffff 7fffffff 00000000 00000000 00000000 836b0200
[    7.026811] 5f80: 00000000 8034ce00 ffffffff 7fffffff 00000000 76fba390 00000000 00000000
[    7.026904] 5fa0: 7e9bed24 80100080 00000000 00000000 00000005 00000000 00000000 00000000
[    7.026998] 5fc0: 00000000 00000000 7e9bed24 00000076 00000005 00000020 0053860b 0053c8ca
[    7.027091] 5fe0: 7e9beb30 7e9beb20 76f5d110 76f5c4c4 60000010 00000005 00000000 00000000
[    7.027249]  f2fs_issue_flush from f2fs_do_sync_file+0x7c8/0xaa8
[    7.027401]  f2fs_do_sync_file from f2fs_sync_file+0x44/0x58
[    7.027487]  f2fs_sync_file from do_fsync+0x44/0x78
[    7.027558]  do_fsync from ret_fast_syscall+0x0/0x54
[    7.027643] Exception stack(0xe0c65fa8 to 0xe0c65ff0)
[    7.027727] 5fa0:                   00000000 00000000 00000005 00000000 00000000 00000000
[    7.027825] 5fc0: 00000000 00000000 7e9bed24 00000076 00000005 00000020 0053860b 0053c8ca
[    7.027920] 5fe0: 7e9beb30 7e9beb20 76f5d110 76f5c4c4
[    7.028099] Code: 1afffffa e59d0038 eaffffd7 f5d4f000 (e1943f9f)
[    7.028502] ---[ end trace 0000000000000000 ]---
