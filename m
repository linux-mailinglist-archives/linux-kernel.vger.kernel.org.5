Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9797BCDB3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 11:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344586AbjJHJ7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 05:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343527AbjJHJ7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 05:59:43 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6708B6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 02:59:41 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-694ed847889so2683831b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 02:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=transsion-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1696759181; x=1697363981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XrAvSbwr4PKpLCcR91dzcYyXIYaLONFqumRQMBJ+XXI=;
        b=12zAL3VlYF6KqWVJLHUB7cEtjD9xFenYy6uJgN/FctjC3smnPNksV6TBMU+ajOUuB0
         KqoimStPv8ErDzViijVzSnCWyvJTPsLvF8dyDLUCz5tOuAJezT2QygxNjf0kr3OD+k1D
         3Z/WHtNSyuIJ2kjsXIxkyKLpuQpaqYD/bar8NBbg7EE9oCo95NAYkhqZT84XgT57hGzl
         xJbD9d7znZvnhQWt6m+ECFcpQ0oECBxeonGnCHxsM1geQdMDGwPN87THIYqUe9vBQygB
         MgPFoFiE3PtWGKsVKDYDoDkte8ul8A2Yz6fcOo7lGjG9UUyL4Jl/QxzY9uma+m4w25r4
         Q3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696759181; x=1697363981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XrAvSbwr4PKpLCcR91dzcYyXIYaLONFqumRQMBJ+XXI=;
        b=UpzkGWDkxo76n/cgsnwd+rZrEsNYPIlEuj8kZtdkZpiwI8Yc7voYCEHSWNMfgiu8+X
         oc1Rjt+L6Dt9WJQTt2D+PhPinLSlULcBlBT9xSSckm/j/OOMI9xqZ6ihF2aMNyV6I0NG
         Hz//DiQH5FOYoLdFP6yCr89WqFWOaCNnBrOulkiDdfajlzmPYGYdW4bzMrqovGJH7E4S
         2Zw18jEQzWcW5iiTsL30ln7lvfZ2FZbPT579VoIv1EbVoVI3nNHlc1VjZBwtKQebLVqr
         sth3hZ+tl4H5mJXGXX4vQ7ziOmG/z85gqnKwe8KbUWU8n31V2sRcTLsNbD+Hiy+xo1PH
         gx/Q==
X-Gm-Message-State: AOJu0Yw+qxusa1ZjqadMOzV3wRqyfwplQNBCizutjK580u/eneXbQZL1
        6Bt2gNPp/fRHctcCSDVsqr5HkucV635zIJdKVQVmRA==
X-Google-Smtp-Source: AGHT+IEAjG9z5Y35VZX6FXVsxQD1NfgeRUoa48YfmjKw7ltsyfiSU1+kzTvRDjsQQBdX/+v6eGIMzQ==
X-Received: by 2002:a05:6a21:2716:b0:16b:75a6:4102 with SMTP id rm22-20020a056a21271600b0016b75a64102mr4501636pzb.46.1696759181330;
        Sun, 08 Oct 2023 02:59:41 -0700 (PDT)
Received: from linchengyang-VB.. ([103.40.76.4])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090282c900b001c72c07c9d9sm7126343plz.308.2023.10.08.02.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 02:59:41 -0700 (PDT)
From:   Lincheng Yang <lincheng.yang@transsion.corp-partner.google.com>
X-Google-Original-From: Lincheng Yang <lincheng.yang@transsion.com>
To:     akpm@linux-foundation.org, rostedt@goodmis.org,
        mhiramat@kernel.org, willy@infradead.org, hughd@google.com,
        peterx@redhat.com, mike.kravetz@oracle.com, jgg@ziepe.ca,
        surenb@google.com, steven.price@arm.com, pasha.tatashin@soleen.com,
        kirill.shutemov@linux.intel.com, yuanchu@google.com,
        david@redhat.com, mathieu.desnoyers@efficios.com,
        dhowells@redhat.com, shakeelb@google.com, pcc@google.com,
        tytso@mit.edu, 42.hyeyoo@gmail.com, vbabka@suse.cz,
        catalin.marinas@arm.com, lrh2000@pku.edu.cn, ying.huang@intel.com,
        mhocko@suse.com, vishal.moola@gmail.com, yosryahmed@google.com,
        findns94@gmail.com, neilb@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        wanbin.wang@transsion.com, chunlei.zhuang@transsion.com,
        jinsheng.zhao@transsion.com, jiajun.ling@transsion.com,
        dongyun.liu@transsion.com,
        Lincheng Yang <lincheng.yang@transsion.com>
Subject: [RFC PATCH 0/5] hot page swap to zram, cold page swap to swapfile directly
Date:   Sun,  8 Oct 2023 17:59:19 +0800
Message-Id: <20231008095924.1165106-1-lincheng.yang@transsion.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

We team developed a feature in Android linux v4.19 that can directly swapout
cold pages to the swapfile device and hot pages to the ZRAM device. This can
reduce the lag when writing back cold pages to backing-dev through ZRAM when
there is a lot of memory pressure, saving the ZRAM compression/decompression
process. Especially for low-end Android devices, low CPU frequency and small
memory.

Currently, Android uses the GKI strategy. We cannot directly modify the Linux
kernel to support this feature. We can only support it through the hook vendor.
However, this feature involves too many modifications. Google TAM suggested
that we push this feature to the Linux community.

The main changes are as follows:
[PATCH 2/5]: Set the hot and cold status for each page.
             If it is a cold page, it is swapout to the swapfile directly.
             If it is a hot page, it is swapout to the ZRAM device.
[PATCH 3/5]: When a VMA has many hot pages, predict that the VMA is hot,
             so that all anonymous pages of this VMA are hot and are only
             swapout to the ZRAM device.
[PATCH 4/5]: When user space uses madvise/process_madvise(MADV_PAGEOUT),
             swapout to the swapfile device directly.
[PATCH 5/5]: When the storage life of the external storage device is too
             low or the amount of daily writes to swapfile is too high,
             the user turns off swapout hot/cold page to the swapfile
             device and can only swapout to the ZRAM device.

This series is based on linux v6.5, this is just porting the core function to
linux v6.5.

If similar function already exists in the kernel, please let me know and give
it a shout, also comments and suggestions are welcome.

Thanks,
Lincheng Yang


Lincheng Yang (5):
  mm/swap_slots: cleanup swap slot cache
  mm: introduce hot and cold anon page flags
  mm: add VMA hot flag
  mm: add page implyreclaim flag
  mm/swapfile: add swapfile_write_enable interface

 fs/proc/task_mmu.c             |   3 +
 include/linux/mm.h             |  32 +++++++
 include/linux/mm_types.h       |   2 +
 include/linux/mm_types_task.h  |  10 +++
 include/linux/mmzone.h         |   1 +
 include/linux/page-flags.h     |   9 ++
 include/linux/swap.h           |   8 +-
 include/linux/swap_slots.h     |   2 +-
 include/trace/events/mmflags.h |   6 +-
 mm/filemap.c                   |   2 +
 mm/madvise.c                   |   7 +-
 mm/memory.c                    |  44 ++++++++++
 mm/migrate.c                   |   6 ++
 mm/rmap.c                      |   3 +
 mm/shmem.c                     |   2 +-
 mm/swap.h                      |   4 +-
 mm/swap_slots.c                | 133 +++++++++++++++++-----------
 mm/swap_state.c                |   4 +-
 mm/swapfile.c                  | 153 +++++++++++++++++++++++++++++++--
 mm/vmscan.c                    |  22 ++++-
 20 files changed, 384 insertions(+), 69 deletions(-)

--
2.34.1

