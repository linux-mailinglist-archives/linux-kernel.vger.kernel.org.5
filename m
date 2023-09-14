Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0087A08EB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240797AbjINPUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239524AbjINPUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:20:03 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C591FC9;
        Thu, 14 Sep 2023 08:19:59 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7a512434bc9so1423558241.0;
        Thu, 14 Sep 2023 08:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694704798; x=1695309598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgA7PcwmgwXejCiJKRlHdUH5uK+0JkyppZjxMRcSh+s=;
        b=MORUfFws6H5jSyFsJZWnF/WilprBqaM7RUhcSoqrROLLodgt4c6JY+7xa4jxPA3wzg
         CYytMTlsgOxw34PlAVFryt52EKtTzA3L2GQG0kZSu8QywhQvN6scrzuy6+y9qYFm/3G5
         p5obuJ9TS33ukoq2WeA8ESu9l0snaLSIlEESr0P9GWm/7eZLPhTkqAkJxfyOpHeNOfR5
         UKJFf/RHMezDHFTt12vKtseo7aTzk71+SQ+Qq6GPj1DX3qobUEJyZyX4dKE2hUbjQ4W0
         qgExNl+lMVjBsnjXX6gfzB35U+FWOElmrMtY7Y5kyi5GhK9b6g4LAIiwRX/rDbyisW2y
         dX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694704798; x=1695309598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgA7PcwmgwXejCiJKRlHdUH5uK+0JkyppZjxMRcSh+s=;
        b=XvT6qNEILMJko4iEPtW3ocUGLrg8zd48kDwLLNEXEN2qUx2vkJyaOnR5oeVObDiti3
         C9dBwkl42W/5SeftSXtKIynNcBsTgsMlvY7o0I67yv68z91SZrx8TezZtFfawwbAVJji
         xk6VoaX98ysppzlJvi/X7KFDeAcOT82ca+VcFkU/Johny7XemtmUv/Hn4knqbeggPnsz
         Y/UDkckp5TLbUiZmjmqy5dvtvmukniPDOHQyc442ltkuaHbEIgeb0S8Ba6RVukFkvOPc
         MPv18bZI0BaXxrUuDIPjEGsbhet+F3VQcaBq6FCghA6s1AtFfLfK2SbdSB28iw4yDynN
         V0vw==
X-Gm-Message-State: AOJu0YzKRcHswQXGxuG6VNL5+KxBHM0Fetuajp956wzUtpSwosvDG2LA
        h8St8LXl1ODtTlIzsdlwLJxtxmU4oRUPin17
X-Google-Smtp-Source: AGHT+IGSlm6UqcoGzTxdPnKwkOkMH2W7gTDRm/2Fmh7Lspov7kgxMbOYMHyDV8LJCq8qMOfoh9EVsw==
X-Received: by 2002:a67:ee50:0:b0:44e:837a:25e with SMTP id g16-20020a67ee50000000b0044e837a025emr1010521vsp.11.1694704798503;
        Thu, 14 Sep 2023 08:19:58 -0700 (PDT)
Received: from localhost.localdomain (vps-035beda1.vps.ovh.us. [51.81.85.161])
        by smtp.gmail.com with ESMTPSA id g2-20020ab016c2000000b0079b44af2af8sm193838uaf.30.2023.09.14.08.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 08:19:57 -0700 (PDT)
From:   Yong Wang <yongw.pur@gmail.com>
X-Google-Original-From: Yong Wang <wang.yong12@zte.com.cn>
To:     chrubis@suse.cz, naresh.kamboju@linaro.org
Cc:     alex.bennee@linaro.org, anders.roxell@linaro.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        ltp@lists.linux.it, mdoucha@suse.cz, peterz@infradead.org,
        vincent.guittot@linaro.org, wegao@suse.com, wang.yong12@zte.com.cn,
        yang.yang29@zte.com.cn, ran.xiaokai@zte.com.cn
Subject: LTP: cfs_bandwidth01: Unable to handle kernel NULL pointer dereference
Date:   Thu, 14 Sep 2023 23:18:39 +0800
Message-Id: <20230914151839.3635-1-wang.yong12@zte.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CA+G9fYvHhiiGKhNd=L9+xYFVwv0Q8k6gUBeFQGWCWw1cWhb50Q@mail.gmail.com>
References: <CA+G9fYvHhiiGKhNd=L9+xYFVwv0Q8k6gUBeFQGWCWw1cWhb50Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
>Following kernel crash noticed on Linux stable-rc 6.5.3-rc1 on qemu-arm64 while
>running LTP sched tests cases.
>
>This is not always reproducible.
I also encountered this problem on linux 5.10 on arm64 environment.
The prompt information is as follows:
[ 2893.003795] ================================================================== 
[ 2893.003822] BUG: KASAN: null-ptr-deref in pick_next_task_fair+0x130/0x4e0 
[ 2893.003880] Read of size 8 at addr 0000000000000080 by task ksoftirqd/0/12 
[ 2893.003901]  
[ 2893.003914] CPU: 0 PID: 12 Comm: ksoftirqd/0 Tainted: P           O      5.10.59-rt52#1 
[ 2893.003959] Call trace: 
[ 2893.003968]  dump_backtrace+0x0/0x2e8 
[ 2893.004009]  show_stack+0x18/0x28 
[ 2893.004032]  dump_stack+0x104/0x174 
[ 2893.004067]  kasan_report+0x1d0/0x258 
[ 2893.004098]  __asan_load8+0x94/0xd0 
[ 2893.004126]  pick_next_task_fair+0x130/0x4e0 
[ 2893.004164]  __schedule+0x220/0xbd0 
[ 2893.004192]  schedule+0xec/0x1a0 
[ 2893.004216]  smpboot_thread_fn+0x124/0x548 
[ 2893.004246]  kthread+0x24c/0x278 
[ 2893.004277]  ret_from_fork+0x10/0x34 
[ 2893.004306] ================================================================== 
[ 2893.004325] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000080 
[ 2893.152267] Mem abort info: 
[ 2893.152639]   ESR = 0x96000004 
[ 2893.153045]   EC = 0x25: DABT (current EL), IL = 32 bits 
[ 2893.153739]   SET = 0, FnV = 0 
[ 2893.154143]   EA = 0, S1PTW = 0 
[ 2893.154560] Data abort info: 
[ 2893.154940]   ISV = 0, ISS = 0x00000004 
[ 2893.155443]   CM = 0, WnR = 0 
[ 2893.155838] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000188edb000 

The source code where the problem occurs corresponds to:
  se = pick_next_entity(cfs_rq, curr);		
  cfs_rq = group_cfs_rq(se); //se is NULL!

It is found that pick_next_entity returns null, so null-ptr-dere appears when accessing the members of se later.
But it is not clear under what circumstances pick_next_entity returns null.

In addition, in my environment, the following operations often recur:
  stress-ng -c 8 --cpu-load 100 --sched fifo --sched-prio 1 --cpu-method pi -t 900 &
  runltp -s cfs_bandwidth01

Hope it helps to solve the problem.
Thanks.
