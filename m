Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684C47F06CB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 15:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjKSOQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 09:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjKSOQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 09:16:47 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47472D8;
        Sun, 19 Nov 2023 06:16:43 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6cb66fbc63dso437344b3a.0;
        Sun, 19 Nov 2023 06:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700403402; x=1701008202; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5YMdSJ+DNHbcNIRlOywcDm3j9WNKn1Pp1oJN74vpQo=;
        b=Vw7FD2tgK4Z8xiw4KOuYbCOvEL+l3CTXca7XYjAn3rdPaydbH9qsEYo+gIOPAFNXkY
         3ivvljBnngXo9NtypR61CYlBZDOY5oMxdD+OwR6Xd2qFIUWg0JvOPehraCx5qcMTOsUT
         T0RlVMvJ/Y15gES9CbdW41wOApnRGsWE/Io7p8EMwGiSZEwKxvIHwbToAcBdvIalJN1Z
         S6eYxkRaVEZib/2X07gsKPup14TWWIwYO8zE52Y2JK6IbiOgfJk7XhtNt3tsdMfngrKi
         W2mQPMJeUWnsC08ZnkKD+HLPKHKihI+jeQ456LuT6SD09rw9inTpbb0cl05duDeukkhf
         tFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700403402; x=1701008202;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D5YMdSJ+DNHbcNIRlOywcDm3j9WNKn1Pp1oJN74vpQo=;
        b=L6mhLUSbDmMT9fcX2SiHA4ASEP4MiJ4T69t6HmIi/zYnr2vv7zvJCeyphBwP/LksYr
         Ez28T3Kfu/YHzCpnixHPvpU34zgDjqzNZ7CuRq2ig7Mw84oVuiKzBWPlDd/sPid1KA7C
         uWZWZ2pyypmOult+vmrpJ8Y6ihZIVUMQy4k5jcejlLBCQarZ9Fr98ayJnSm/c8xRghDd
         tOd4CuaLiGamnT0IbukS84m5aj+oZTnaLDJ6KhMhl3dB5TrRO7n52/2PvKJj9RTvBQZk
         sM5Kp8jU+/A8GpHAGs7E27r0Ckgguhx2IQ4qbUqm4mBoD6GUMiS+IfI/XcyokvIfite0
         4vgQ==
X-Gm-Message-State: AOJu0YwG8ZCBBlrNSiA5anJ1bLASTyQ442Gu6Fy6jc5Gtm63lMrur4zq
        BN5nllhG7GFTtqzBk/PwBcpg7IytYRc80g==
X-Google-Smtp-Source: AGHT+IF6byi9ymN4DR72v6SwaZ7fg1ETCkw4C37szrVsW7+y/f5lsYg20gWNhM9MeNk2sZLcRmN0kw==
X-Received: by 2002:a05:6a20:6a10:b0:187:b2cb:2b0f with SMTP id p16-20020a056a206a1000b00187b2cb2b0fmr6631658pzk.8.1700403402435;
        Sun, 19 Nov 2023 06:16:42 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id p18-20020a63fe12000000b0058988954686sm4360457pgh.90.2023.11.19.06.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Nov 2023 06:16:41 -0800 (PST)
Message-ID: <0fd91726-942d-40dd-adef-5b43e25ec49c@gmail.com>
Date:   Sun, 19 Nov 2023 21:16:35 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Common Internet File System & SMB3 
        <linux-cifs@vger.kernel.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Steve French <sfrench@samba.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Tom Talpey <tom@talpey.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        walter59 <walter.moeller@moeller-it.net>,
        Fabio Rossi <rossi.f@inwind.it>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: kernel 6.6.x and higher , apci reboot problems
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

I notice a regression report on Bugzilla [1] (albeit terse). Quoting
from it:

> since kernel 6.6 problems , reboot fails or me muss use double enter key .
> under xfce4 it jumps on console and hangs.
> 
> restart under xfce4 fails shutdown also --- 6.5.11 it works all fine 
> 
> regards 
> 
> ps: all pcs . notebooks , nucs, workstation

Then another reporter can reproduce the regression with bisection:

> I have found a similar problem but in my case I don't think it's related to ACPI. In fact the problem is still there after adding the kernel option acpi=off. @walter59, can you test on your system by disabling ACPI too?
> 
> During system shutdown, started by "shutdown -h now", the process hangs (but the system is still working) during stopping of samba service. Instead the reboot still works.
> 
> My problem appeared with the upgrade 6.5.11 -> 6.6-rc1 so I have bisected until I have found the first bad commit:
> 
> $ git bisect log
> 
> git bisect start
> # status: waiting for both good and bad commits
> # good: [799441832db16b99e400ccbec55db801e6992819] Linux 6.5.11
> git bisect good 799441832db16b99e400ccbec55db801e6992819
> # status: waiting for bad commit, 1 good commit known
> # bad: [0bb80ecc33a8fb5a682236443c1e740d5c917d1d] Linux 6.6-rc1
> git bisect bad 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
> # good: [2dde18cd1d8fac735875f2e4987f11817cc0bc2c] Linux 6.5
> git bisect good 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> # bad: [461f35f014466c4e26dca6be0f431f57297df3f2] Merge tag 'drm-next-2023-08-30' of git://anongit.freedesktop.org/drm/drm
> git bisect bad 461f35f014466c4e26dca6be0f431f57297df3f2
> # bad: [bd6c11bc43c496cddfc6cf603b5d45365606dbd5] Merge tag 'net-next-6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
> git bisect bad bd6c11bc43c496cddfc6cf603b5d45365606dbd5
> # good: [6c9cfb853063f317b2953c5e852b6bac1eb0cade] net: ethernet: mtk_wed: minor change in wed_{tx,rx}info_show
> git bisect good 6c9cfb853063f317b2953c5e852b6bac1eb0cade
> # bad: [ccc5e9817719f59b3dea7b7a168861b4bf0b4ff4] Merge tag 'pm-6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> git bisect bad ccc5e9817719f59b3dea7b7a168861b4bf0b4ff4
> # bad: [68cadad11fe2ddd126b37a8fba3726be7fa0f5c6] Merge tag 'rcu.2023.08.21a' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu
> git bisect bad 68cadad11fe2ddd126b37a8fba3726be7fa0f5c6
> # bad: [dd2c0198a8365dcc3bb6aed22313d56088e3af55] Merge tag 'erofs-for-6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs
> git bisect bad dd2c0198a8365dcc3bb6aed22313d56088e3af55
> # bad: [ecd7db20474c3859d4d01f34aaabf41bd28c7d84] Merge tag 'v6.6-vfs.tmpfs' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs
> git bisect bad ecd7db20474c3859d4d01f34aaabf41bd28c7d84
> # good: [e9d7d3cb9fb3f142df574664507ac0ee4a26365a] procfs: convert to ctime accessor functions
> git bisect good e9d7d3cb9fb3f142df574664507ac0ee4a26365a
> # good: [6f4aaee3faa84f00d38bfaba88a9f75d8c78e7e0] fat: make fat_update_time get its own timestamp
> git bisect good 6f4aaee3faa84f00d38bfaba88a9f75d8c78e7e0
> # bad: [2daf18a7884dc03d5164ab9c7dc3f2ea70638469] tmpfs,xattr: enable limited user extended attributes
> git bisect bad 2daf18a7884dc03d5164ab9c7dc3f2ea70638469
> # good: [6faddda69f623d38bb097640689901a4b5ff881a] libfs: Add directory operations for stable offsets
> git bisect good 6faddda69f623d38bb097640689901a4b5ff881a
> # bad: [2be4f05af71bb2a9958c5680c19e5a489636ff42] libfs: Remove parent dentry locking in offset_iterate_dir()
> git bisect bad 2be4f05af71bb2a9958c5680c19e5a489636ff42
> # bad: [a2e459555c5f9da3e619b7e47a63f98574dc75f1] shmem: stable directory offsets
> git bisect bad a2e459555c5f9da3e619b7e47a63f98574dc75f1
> # good: [23a31d87645c652734f89f477f69ddac9aa402cb] shmem: Refactor shmem_symlink()
> git bisect good 23a31d87645c652734f89f477f69ddac9aa402cb
> # first bad commit: [a2e459555c5f9da3e619b7e47a63f98574dc75f1] shmem: stable directory offsets

See Bugzilla for the full thread.

Anyway, I'm adding this regression to regzbot:

#regzbot introduced: a2e459555c5f9d https://bugzilla.kernel.org/show_bug.cgi?id=218147
#regzbot title: shmem's stable directory offsets hangs samba shutdown

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218147

-- 
An old man doll... just what I always wanted! - Clara
