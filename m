Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3257995D7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 03:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237238AbjIIBqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 21:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjIIBqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 21:46:52 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7481716
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 18:46:48 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-6490c2c4702so14688076d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 18:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20230601.gappssmtp.com; s=20230601; t=1694224007; x=1694828807; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=26BI+0n04B5aNtj8zPuXi+pIvROzpuhpiJ4Kp/E4q6A=;
        b=LDk4LP5y1DeSPInwO3PLA6rvqFGTLYL0ZuMjgKIKNjthwkwoaHuZKooh29G/3tnttO
         uh50YhTNuLaFqYggoOW/BFkLGHzAZizz39sL4ibvEHHxznwhrzv8F1n9CUFhudm5L4Le
         /CfryZuanEDXKErYlJe0+UUl5EBGJiLSXCzr1+H4EmmMomFTslG8BIo/ZLBa+MsxbVgx
         4k6oPM+VH2vZ5QUxYuRiCu2cv5X9X6EHw3wpEl0DpTYAcLEA7XLBKRpRhJizt0D8IFTW
         G1jqBJtmvrUE+egrEVeEMtxLpjjfHsvTtWjwCGDddcPfOXc8DFmIvH5weZEwclcm5jt4
         DGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694224007; x=1694828807;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26BI+0n04B5aNtj8zPuXi+pIvROzpuhpiJ4Kp/E4q6A=;
        b=WUT99qc3+PJ5cBGlXJTDGJO4CW212ZvvigucznGZlhIzlhmdGhwDMt0YOi1F12uKW4
         Ne4rySv3DGbUrRFPhFMhOLG00VD33rTWH5UMjzu/nAJyR9z7BneXH6k5u/4psk2hpACs
         NCHoFsDPpcs+VrVm5fFDQP45Y6Y942GVkawgvw22FOx6oPrZZ66u3sTpZcX2kC0NcFaB
         LcmJGFLKXtJpkj/XkChHB7UeoMBSwSEyn1bb5xGUddHOEzw6Bv7xy1bdRj5X+OM1Z2hX
         269jc69UggtDvk0PhVmDkHWurkh/4oy6blO+k6qT37TZ4fvtQEDjGFhHuOMUc+N0kaTO
         HjKA==
X-Gm-Message-State: AOJu0YwzIQt7srsxq13DBc5zwUb0nm92TZax78rmfB1F59f09RP5JDdc
        sDx2cpFT2ICB6ZVdamAA7YU+iXTw79hPsSFDFQg=
X-Google-Smtp-Source: AGHT+IH8jIhg4dy1rQ87RnbLG0KNPA2cA2o7nnNQ3ZjQ/vgD5iXTEY3mC7rWrjAqPU/q1vJGn+Mwow==
X-Received: by 2002:a0c:a892:0:b0:64f:3bee:93a6 with SMTP id x18-20020a0ca892000000b0064f3bee93a6mr3424599qva.42.1694224007216;
        Fri, 08 Sep 2023 18:46:47 -0700 (PDT)
Received: from localhost ([2605:a601:a697:5800:8ac9:b3ff:febf:a2f8])
        by smtp.gmail.com with ESMTPSA id v4-20020a0ce1c4000000b0064dd4b5fdb4sm1176989qvl.6.2023.09.08.18.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 18:46:46 -0700 (PDT)
From:   Jon Mason <jdmason@kudzu.us>
X-Google-Original-From: Jon Mason <jdm@athena.kudzu.us>
Date:   Fri, 8 Sep 2023 21:46:40 -0400
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: [GIT PULL] NTB bug fixes for 6.6
Message-ID: <ZPvOgFe6+hUx9SUC@athena.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,
Here are a few NTB bug fixes for 6.6.  Please consider pulling them.

Thanks,
Jon



The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  https://github.com/jonmason/ntb tags/ntb-6.6

for you to fetch changes up to 643982232860887fed493144957ea5794b6557d1:

  ntb: Check tx descriptors outstanding instead of head/tail for tx queue (2023-08-22 12:38:19 -0400)

----------------------------------------------------------------
Link toggling fixes and debugfs error path fixes

----------------------------------------------------------------
Dave Jiang (4):
      ntb: Clean up tx tail index on link down
      ntb: Drop packets when qp link is down
      ntb: Fix calculation ntb_transport_tx_free_entry()
      ntb: Check tx descriptors outstanding instead of head/tail for tx queue

Minjie Du (1):
      dtivers: ntb: fix parameter check in perf_setup_dbgfs()

Ruan Jinjie (2):
      NTB: ntb_tool: Switch to memdup_user_nul() helper
      ntb: amd: Drop unnecessary error check for debugfs_create_dir

Wang Ming (1):
      ntb: Remove error checking for debugfs_create_dir()

 drivers/ntb/hw/amd/ntb_hw_amd.c | 11 ++++-------
 drivers/ntb/ntb_transport.c     | 21 ++++++++++++++++-----
 drivers/ntb/test/ntb_perf.c     |  2 +-
 drivers/ntb/test/ntb_tool.c     | 15 +++------------
 4 files changed, 24 insertions(+), 25 deletions(-)
