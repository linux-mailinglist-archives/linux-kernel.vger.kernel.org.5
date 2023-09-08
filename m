Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593B1798F00
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236743AbjIHTZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjIHTZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:25:42 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B9DA9;
        Fri,  8 Sep 2023 12:25:39 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3a88b1e18f2so236295b6e.0;
        Fri, 08 Sep 2023 12:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694201138; x=1694805938;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MYTek89qDoSynnvkBdLYnIPitaSU8x1bNWIPjFCR1c4=;
        b=fbB9imQBu8BBF3JTFBu5pDB5WoP2SS+TpSBFenBbbmVmXoV29hwzH+rSjd3QPhbSJE
         PA23442H4zlvC3nUr33PJc7x2ZAYa1fPZbYy0rrZM0bnHlJn5KjAyIfAmek657+KdMei
         wD5NN0vzBohDzmaS2p11SRi8+9i8NAv/AnP9ltGruXx/B+KW2mbdVHmOa7zhJ1MmaN05
         fWKyPF1SEBjsKZQuDfucedGf6tV9YRFlZRjhU9xXbf5lCl9Qs/ADsw4TJlYkL4ltizQ3
         qpNsDb31V0+h+H8yqLvCMcDl5xcdGFTA2Ofvs1f/0KAl39lrLVvWOjbg6CZYqBajAJM3
         Y+1w==
X-Gm-Message-State: AOJu0YwhxEmRvRL+4VUKlv6KdIU/PB5ZzdzwZpLwr4Rrx3zRD8QHsIhh
        35+tBq00sotefkmKkjiHxVSoOv0+LuPwce0VTqt8h9UuAdE=
X-Google-Smtp-Source: AGHT+IG3CIxF0fzJMJ80GbrvQiKO2tEn/ytb9Y9LZCz1tFVOU+j6w3wHoLJajkoGPvN8Bk7S0Sp6/ghZ8SlggI1CEVw=
X-Received: by 2002:a05:6808:2102:b0:3a9:e0db:8d75 with SMTP id
 r2-20020a056808210200b003a9e0db8d75mr4079605oiw.2.1694201138475; Fri, 08 Sep
 2023 12:25:38 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Sep 2023 21:25:27 +0200
Message-ID: <CAJZ5v0gjTAXsgob=tYenV_ifSWNVwBPmo6CfoQFp9=bRXcj3QA@mail.gmail.com>
Subject: [GIT PULL] Additional thermal control updates for v6.6-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.6-rc1-3

with top-most commit edd220b33f479cf9dcda0bfefb2cb8c5902e9885

 thermal: core: Drop thermal_zone_device_register()

on top of commit 0ca4080a884329759a08c76f0aeabe3d24350c62

 Merge tag 'thermal-6.6-rc1-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional thermal control updates for 6.6-rc1.

These eliminate an obsolete thermal zone registration function.

Thanks!


---------------

Rafael J. Wysocki (4):
      thermal: core: Clean up headers of thermal zone registration functions
      thermal: core: Add function for registering tripless thermal zones
      thermal: Use thermal_tripless_zone_device_register()
      thermal: core: Drop thermal_zone_device_register()

---------------

 drivers/power/supply/power_supply_core.c           |  4 +-
 drivers/thermal/armada_thermal.c                   |  5 ++-
 drivers/thermal/dove_thermal.c                     |  4 +-
 .../intel/int340x_thermal/int3400_thermal.c        |  6 +--
 drivers/thermal/kirkwood_thermal.c                 |  4 +-
 drivers/thermal/spear_thermal.c                    |  4 +-
 drivers/thermal/thermal_core.c                     | 16 +++----
 include/linux/thermal.h                            | 51 ++++++++++++++--------
 8 files changed, 56 insertions(+), 38 deletions(-)
