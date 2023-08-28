Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDC778B731
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjH1SVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbjH1SV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:21:27 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9993313D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:21:25 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a7781225b4so2502687b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693246885; x=1693851685;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bZXa7XMWyu/hYIBm2X6ctJQB4UDw267+zV3IMjTUdDQ=;
        b=n6wmzo4ZACJ3/chjKv3pQN7YiUU761F5DeaLzrEsavmgdv+ZDGcGP7A+kV0frRBlgA
         np1YSSCm21Yi5tbwi9i2d1Zm6IkPcbFue8984dSTscHFK9wbUve3cSVermHjPFsTePL0
         WWUP/jWDdT5BGfqFOoKrxGv0m0tzEnNqtjoRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693246885; x=1693851685;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bZXa7XMWyu/hYIBm2X6ctJQB4UDw267+zV3IMjTUdDQ=;
        b=iBkYCokQqsumZwBQjVjYrbqRZA930lhA1kyoyBOx5ipvIke6GSZ2YdxlxO59AFDRyn
         ydupoG3Pe0mX0d50uI0/DbYa0lINipczU6GtbdYJg6pKdmovGSVWn+Tc5UGkuE1fziYJ
         UCkf4MhDd09o4lPh2xi5OIMKyRoOTMe+9UUraWkWf4tkSdZxn8RXTNixmq1v2OpFBv4z
         rvNjA9qQ0fxfGA5ooTaytLNK0wA7osINzAnU2AKQgWlVZNa15uae7dmWAXEgP9nCavRq
         TN4r2l1LtEfR5P5d16iRLIiNhJaUSDBIM6Vsfi4/7zlaPZM7S9Afe3kHEbbGQ1pUCibK
         ihcw==
X-Gm-Message-State: AOJu0Yxbb+HLgGNrD9tdvt0mfdszcaLz9e0eNqbgNA/kqQ0jczUQCfG7
        XHU8BuSnpFZbQNfaKYnfa1YUIQ==
X-Google-Smtp-Source: AGHT+IEMFS7QokErnk5nHJpPhzTtrOKlrZB+15dEAiZ63r1TI6xpt56hA3v2YHwHk+ZwveGhMZ2yBA==
X-Received: by 2002:a05:6808:df4:b0:3a7:2f1d:ea4e with SMTP id g52-20020a0568080df400b003a72f1dea4emr10248780oic.41.1693246884957;
        Mon, 28 Aug 2023 11:21:24 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i4-20020a63b304000000b0054fe7736ac1sm6995941pgf.76.2023.08.28.11.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 11:21:24 -0700 (PDT)
Date:   Mon, 28 Aug 2023 11:21:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Enlin Mu <enlin.mu@unisoc.com>,
        Eric Biggers <ebiggers@google.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Kees Cook <keescook@chromium.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yunlong Xing <yunlong.xing@unisoc.com>,
        Yuxiao Zhang <yuxiaozhang@google.com>
Subject: [GIT PULL] pstore updates for v6.6-rc1
Message-ID: <202308281119.10472FC7@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these pstore updates for v6.6-rc1. This contains a fair bit
of code _removal_ which is always nice. Changes have been in -next for
most of the development cycle.

Thanks!

-Kees

The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:

  Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.6-rc1

for you to fetch changes up to af58740d8b06a6a97b7594235a1be11bd6aa37fa:

  pstore: Fix kernel-doc warning (2023-08-18 13:27:28 -0700)

----------------------------------------------------------------
pstore updates for v6.6-rc1

- Greatly simplify compression support (Ard Biesheuvel).

- Avoid crashes for corrupted offsets when prz size is 0 (Enlin Mu).

- Expand range of usable record sizes (Yuxiao Zhang).

- Fix kernel-doc warning (Matthew Wilcox).

----------------------------------------------------------------
Ard Biesheuvel (2):
      pstore: Remove worst-case compression size logic
      pstore: Replace crypto API compression with zlib_deflate library calls

Enlin Mu (1):
      pstore/ram: Check start of empty przs during init

Matthew Wilcox (Oracle) (1):
      pstore: Fix kernel-doc warning

Yuxiao Zhang (1):
      pstore: Support record sizes larger than kmalloc() limit

 fs/pstore/Kconfig    | 100 ++-------------
 fs/pstore/inode.c    |   2 +-
 fs/pstore/platform.c | 353 +++++++++++++++++----------------------------------
 fs/pstore/ram.c      |  11 +-
 fs/pstore/ram_core.c |  17 ++-
 5 files changed, 137 insertions(+), 346 deletions(-)

-- 
Kees Cook
