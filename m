Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6556E754E6A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 13:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjGPLKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 07:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGPLKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 07:10:53 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A88E10D1;
        Sun, 16 Jul 2023 04:10:52 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-666edfc50deso2089531b3a.0;
        Sun, 16 Jul 2023 04:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689505851; x=1692097851;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFFypmJqYDlXT8DHon/Exdv4NWww0xZmQQjLVgcz49Y=;
        b=QFl6oFb15jbkHZ57TZO+bqkiy5Bo9Cgp8H8oFcmuLIty60Cjj+2ZcdFYK4gfqnJHto
         PUZpDRZBrVFDVfR/54aOgaCsr3lMZIfFBGSi5UIm5Co+ynssR0yDvrgJpxKBCFgwmogm
         /QlJYbvkFmvt6YSNqEWPYX8vlzmwLnfbBzW7Y0e6BhGr7rNAg+YiB2s2Ri6js2qIEDEU
         MKNnRFLRsMDGGc7f9l8J1hnK4fYCyqR3NaX3aZ1S+pAt5Nyd9xQ9KEU2XvTANCjiKcbb
         05gnJX20PU0kFbjOXS5cGpgxalgkGxMwr5fgTrIVSx+D6mq5AhVGXTZc7MriQwt+cTMr
         /VtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689505851; x=1692097851;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YFFypmJqYDlXT8DHon/Exdv4NWww0xZmQQjLVgcz49Y=;
        b=D+rjKXaEK0up/zcbkxzV4nv0xhItPFownKOfN67y+p1azbyOkic/QFunATdHizh3+F
         j0Cs1qJtZJtOPLSpLcyQlHK/jp76LzS6B6QRTZWcMzKCC4UlzIG+3KMch99cfXoOrdFD
         akaydgmO5/9hHbXb12KaCtOWyXSlf4lFJKc8LvM57bKS37F8KnL9xBMJYmBE4XRaphka
         UZnB4z/jHZU7/aFf02cXQJalX5FMrharq59WJst8Cd7RrXWRIjZL2omkYEefSSXyUvy3
         HjSNnQniVdmqy7SNPtwckZw8Axei+P+zEentskIfB4vb0gLdpGfRixwWPI4cdARTkO2k
         80qw==
X-Gm-Message-State: ABy/qLY3edW8PxwO+Kv5xdDLqkriOu1qLGndHzStCDb3hj+PqMCoOpXP
        jNTzdoc0F91lA6wrOd5cuhU=
X-Google-Smtp-Source: APBJJlHnHmyzKIUhy1NjL61Ihqjq4SxH+BnDn6KGxOMsuvj2zzx0TBvs2xKNjJTnh1KlaHxCQNEE7A==
X-Received: by 2002:a05:6a20:4405:b0:10b:bf2d:71bb with SMTP id ce5-20020a056a20440500b0010bbf2d71bbmr9949349pzb.27.1689505851474;
        Sun, 16 Jul 2023 04:10:51 -0700 (PDT)
Received: from [192.168.0.104] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id d11-20020aa78e4b000000b00678159eacecsm10085573pfr.121.2023.07.16.04.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 04:10:50 -0700 (PDT)
Message-ID: <51e53417-cfad-542c-54ee-0fb9e26c4a38@gmail.com>
Date:   Sun, 16 Jul 2023 18:10:44 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Rudi Heitbaum <rudi@heitbaum.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: mm/page_alloc.c:4453 with cfg80211_wiphy_work [cfg80211]
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> Linux version 6.5.0-rc1+ - up to 831fe284d8275987596b7d640518dddba5735f61
> 
> [    7.312665] ------------[ cut here ]------------
> [    7.312671] WARNING: CPU: 8 PID: 659 at mm/page_alloc.c:4453 __alloc_pages+0x329/0x340
> [    7.312683] Modules linked in: exfat ntfs3 bnep btusb btrtl btbcm btintel btmtk bluetooth ecdh_generic ecc iwlmvm mac80211 libarc4 snd_hda_codec_hdmi iwlwifi snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio cfg80211 snd_hda_intel snd_hda_codec snd_hwdep intel_rapl_msr x86_pkg_temp_thermal intel_powerclamp snd_hda_core tpm_tis intel_rapl_common snd_intel_dspcfg tpm_tis_core idma64 rfkill tpm_crb tpm rng_core pkcs8_key_parser fuse dmi_sysfs
> [    7.312725] CPU: 8 PID: 659 Comm: kworker/8:2 Not tainted 6.5.0-rc1 #1
> [    7.312729] Hardware name: Intel(R) Client Systems NUC12WSKi7/NUC12WSBi7, BIOS WSADL357.0087.2023.0306.1931 03/06/2023
> [    7.312731] Workqueue: events cfg80211_wiphy_work [cfg80211]
> [    7.312785] RIP: 0010:__alloc_pages+0x329/0x340
> [    7.312791] Code: a8 44 89 e6 89 df c6 45 c8 00 4c 89 6d b0 41 89 de e8 0b ef ff ff 49 89 c7 e9 90 fe ff ff 80 e3 3f eb c0 c6 05 69 49 f7 09 01 <0f> 0b eb 98 e8 1e ec 6d 01 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
> [    7.312794] RSP: 0018:ffffad8e80defbf8 EFLAGS: 00010246
> [    7.312798] RAX: 0000000000000000 RBX: 0000000000040dc0 RCX: 0000000000000000
> [    7.312800] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000040dc0
> [    7.312802] RBP: ffffad8e80defc50 R08: 0000000000000005 R09: 0000000000000018
> [    7.312804] R10: ffff938899d4a800 R11: ffff938891a9c800 R12: 0000000000000034
> [    7.312806] R13: 0000000000000000 R14: ffffffffc02b150d R15: fffffffffffffc90
> [    7.312808] FS:  0000000000000000(0000) GS:ffff938fb6600000(0000) knlGS:0000000000000000
> [    7.312811] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    7.312813] CR2: 00007f540c94b710 CR3: 000000059502c000 CR4: 0000000000f50ea0
> [    7.312815] PKRU: 55555554
> [    7.312817] Call Trace:
> [    7.312819]  <TASK>
> [    7.312822]  ? show_regs+0x69/0x80
> [    7.312827]  ? __warn+0x89/0x140
> [    7.312833]  ? __alloc_pages+0x329/0x340
> [    7.312837]  ? report_bug+0x15d/0x180
> [    7.312843]  ? handle_bug+0x42/0x80
> [    7.312848]  ? exc_invalid_op+0x1c/0x70
> [    7.312852]  ? asm_exc_invalid_op+0x1f/0x30
> [    7.312857]  ? cfg80211_scan_6ghz+0x12d/0xcb0 [cfg80211]
> [    7.312911]  ? __alloc_pages+0x329/0x340
> [    7.312916]  ? cfg80211_scan_6ghz+0x12d/0xcb0 [cfg80211]
> [    7.312968]  __kmalloc_large_node+0x7e/0x170
> [    7.312973]  __kmalloc+0xb9/0x120
> [    7.312976]  cfg80211_scan_6ghz+0x12d/0xcb0 [cfg80211]
> [    7.313028]  ? sched_clock_noinstr+0xd/0x20
> [    7.313034]  ? sched_clock_cpu+0x14/0x190
> [    7.313040]  ? raw_spin_rq_lock_nested+0x12/0x20
> [    7.313046]  ___cfg80211_scan_done+0x1e0/0x250 [cfg80211]
> [    7.313099]  __cfg80211_scan_done+0x23/0x30 [cfg80211]
> [    7.313153]  cfg80211_wiphy_work+0xae/0xd0 [cfg80211]
> [    7.313201]  process_one_work+0x1f1/0x3e0
> [    7.313204]  worker_thread+0x51/0x3f0
> [    7.313207]  ? _raw_spin_unlock_irqrestore+0x26/0x30
> [    7.313212]  ? __pfx_worker_thread+0x10/0x10
> [    7.313217]  kthread+0xdb/0x110
> [    7.313222]  ? __pfx_kthread+0x10/0x10
> [    7.313226]  ret_from_fork+0x3e/0x60
> [    7.313229]  ? __pfx_kthread+0x10/0x10
> [    7.313233]  ret_from_fork_asm+0x1b/0x30
> [    7.313237]  </TASK>
> [    7.313239] ---[ end trace 0000000000000000 ]---

See Bugzilla for the full thread.

Anyway, I'm adding it to regzbot to make sure it doesn't fall through
cracks unnoticed:

#regzbot introduced: v6.5-rc1..831fe284d82759 https://bugzilla.kernel.org/show_bug.cgi?id=217675

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217675

-- 
An old man doll... just what I always wanted! - Clara
