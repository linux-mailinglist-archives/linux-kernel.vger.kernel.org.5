Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC61773000
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjHGT5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjHGT5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:57:30 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDB1B1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 12:57:29 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bbf8cb61aeso31586495ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 12:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691438248; x=1692043048;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=eVrc5sCnUF8HvIOQWwl3/gSCKNbBnn3nEyaDQIaBcfA=;
        b=XUMdFCFVv+oGwxgyDS1JjhwAbkFm6AmajUyYSOvRnP8x0gtVlF5yFn2RzaVZQRZAEZ
         LrAr4i3b3QMDbC06g9ng+3XAFoODLn8pPPEMfaIYQ4YpPPcPwFmpLtKiHEAGxI4Klfvj
         cnBbj1cuUbxcbM4jDJdNFQJo8vCKO+MME9jAvJ9TpDDuy/vkNZTR5PZRUz9XBkAJQ7C5
         ZxPX0qpwkE3fvFUeWglOTb4veyQk6+VdrQYU4V9zlVVpEvU5FBe1qUJrsksg4aXwVOXp
         bXbrz6bIcAXnYE5zlrZYiffTHLvPiWVRWs+8nMhE91aoRHR+ZGWpaqeoKkOf9zelshaS
         HEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691438248; x=1692043048;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eVrc5sCnUF8HvIOQWwl3/gSCKNbBnn3nEyaDQIaBcfA=;
        b=G+5yplL0IWcYgbuGuFMG/vv112ICQDAeuJAr8uRtJbVVzGYSt6hGtmUn1+rppjbwXk
         LLXtEF2Is6JQ9NwC12Ps6sTFfInr83StAZydhvYVPIiMPRC7k61Ts0E/tx7U6J1dIQzP
         T9C+K6htE4Qezmm6QFTd9+qj2/Oddg9KENJV4T7EE9Yh87wt0WYRk/BY9/qX+L0X2/K0
         Y2T+oN+/ZURb8ZQJDnBEAeptI+//YQ3rhxg5PD339c0p6me6BPSeQmi2p9x31fOjzvkq
         MIyk4ayimRXvAVPc9NDw/wzRcYQeWFo1iGR/H0aGrr3KH9FBYmh7PSLxKwoIj1b2bm/N
         HJig==
X-Gm-Message-State: AOJu0YzPIv+xAp/H3A3susZFcmb732UInP1H17CPEtYB3PokX5v98/ib
        F7Qx/CcCmUTnjJVOaIJqIbY=
X-Google-Smtp-Source: AGHT+IEGwF70L8HJZkxmh8kc4tWjL39o+3VrwJvbwikoZRUmlzhiOYc58UHfWW37PN2UHdUXRa0G6g==
X-Received: by 2002:a17:902:b482:b0:1bb:c0a6:2ee3 with SMTP id y2-20020a170902b48200b001bbc0a62ee3mr8433896plr.26.1691438248462;
        Mon, 07 Aug 2023 12:57:28 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9d5d])
        by smtp.gmail.com with ESMTPSA id b10-20020a170902a9ca00b001bbdf33b878sm7300197plr.272.2023.08.07.12.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 12:57:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 7 Aug 2023 09:57:26 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue fixes for v6.5-rc5
Message-ID: <ZNFMpjyxtKhnLrdK@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3f01e9fed8454dcd89727016c3e5b2fbb8f8e50c:

  Merge tag 'linux-watchdog-6.5-rc2' of git://www.linux-watchdog.org/linux-watchdog (2023-07-10 10:04:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.5-rc5-fixes

for you to fetch changes up to aa6fde93f3a49e42c0fe0490d7f3711bac0d162e:

  workqueue: Scale up wq_cpu_intensive_thresh_us if BogoMIPS is below 4000 (2023-07-25 11:49:57 -1000)

----------------------------------------------------------------
workqueue: Fixes for v6.5-rc5

Two commits:

* The recently added cpu_intensive auto detection and warning mechanism was
  spuriously triggered on slow CPUs. While not causing serious issues, it's
  still a nuisance and can cause unintended concurrency management
  behaviors. Relax the threshold on machines with lower BogoMIPS. While
  BogoMIPS is not an accurate measure of performance by most measures, we
  don't have to be accurate and it has rough but strong enough correlation.

* A correction in Kconfig help text.

----------------------------------------------------------------
Geert Uytterhoeven (1):
      workqueue: Fix cpu_intensive_thresh_us name in help text

Tejun Heo (1):
      workqueue: Scale up wq_cpu_intensive_thresh_us if BogoMIPS is below 4000

 kernel/workqueue.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 lib/Kconfig.debug  |  2 +-
 2 files changed, 43 insertions(+), 2 deletions(-)
