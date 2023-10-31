Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7DD7DC3AF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 01:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbjJaArE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 20:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjJaArD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 20:47:03 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC47A98
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 17:47:00 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5b9a7357553so1039449a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 17:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698713220; x=1699318020; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgyWK3qunH0fnxcJpciTVkelrn2jA7AqrJnsJG2pLzs=;
        b=HYVHuEe7gaPCEF3csEW4+oEGnQ8jdUlBt4rD/pcSPMlFX5GqsGQUjuMAg9wypP2JkL
         762bM+sUmUuKDzA6gEG2dy3owrvnxxWtTYJe1aDOyct3RyMPg11Ladl5xGFpRPVgWe3g
         GHbbxC7Gu/qY8E7usrwgA8cVnx7KKxDCQCuF/rB+ZOo6y1VYac/eNRT9z8ql0QNTNJIb
         mElS0HPXXstGDgajL33oFr1/JBdlvGC0kLRA3FP2jCNzIEv6ZG1bmxXF0whphj9gl0d8
         lOWj8cco5RGmmjLug1FMAvM3aIwrjaWM6xW2c9wN85yXdHW5CANtmQND58JALDN1oUAe
         kOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698713220; x=1699318020;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZgyWK3qunH0fnxcJpciTVkelrn2jA7AqrJnsJG2pLzs=;
        b=taMdOmACCok2o7yn8EprvUXOurqsAwYZZIzKQ9X4Px/JZBr9ptEk03frnqFwlnyijK
         I/2Nc4PKuh+TIpOsDbuDaiG8A+PG9jCvau9HIpdvGGLvVOXxCJHqXOp3I7E7ZfsWht1H
         6gIh/P5MpCIH8OajejkqfTKhjAKYVvWCdszLEJE1BDY8gruRDFCaXA+yjH5y+nv5Doah
         Ld4GHIb2+W5aLrA5piEqudSVbj41/GrvI9uvNv8Icn27BqnSpCoaKVOCTXypiopKu1JX
         0vSPU6wdgeBhX9aazgclW1lyt7j2o7T0ouN4o6W6b/c6XTDNMSn0dADEPVDBEv3J7P0j
         FPoA==
X-Gm-Message-State: AOJu0YyCfIPW6zu12EPlpF64VKSgRx6ZWMcNLUiBmu1aPvV0hnVdrRrz
        l88DTDjWDCUBCu0efwdkExE=
X-Google-Smtp-Source: AGHT+IGbwHsADnPOE5QFzbnyW9q2fD7ZkQ103tHYjxTpuza9/6GS/1vssabEXu/Fmm1AdFcajAJNUg==
X-Received: by 2002:a17:903:1211:b0:1c7:245a:7fea with SMTP id l17-20020a170903121100b001c7245a7feamr15015744plh.58.1698713220219;
        Mon, 30 Oct 2023 17:47:00 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:10c7])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b001b392bf9192sm103729ple.145.2023.10.30.17.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 17:46:59 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 30 Oct 2023 14:46:58 -1000
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        aliceryhl@google.com
Subject: [GIT PULL] workqueue rust bindings for v6.7
Message-ID: <ZUBOgm4uS5t0-qV3@slm.duckdns.org>
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

The following changes since commit 6465e260f48790807eef06b583b38ca9789b6072:

  Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.7-rust-bindings

for you to fetch changes up to 15b286d1fd056b0366bc8d211ff2c4ce2449eacb:

  rust: workqueue: add examples (2023-09-25 09:46:42 -1000)

----------------------------------------------------------------
workqueue: Add rust bindings for v6.7

to allow rust code to schedule work items on workqueues. While the current
bindings don't cover all of the workqueue API, it provides enough for basic
usage and can be expanded as needed.

----------------------------------------------------------------
Alice Ryhl (5):
      rust: workqueue: add low-level workqueue bindings
      rust: workqueue: add helper for defining work_struct fields
      rust: workqueue: implement `WorkItemPointer` for pointer types
      rust: workqueue: add `try_spawn` helper method
      rust: workqueue: add examples

Wedson Almeida Filho (2):
      rust: sync: add `Arc::{from_raw, into_raw}`
      rust: workqueue: define built-in queues

 rust/bindings/bindings_helper.h |   1 +
 rust/helpers.c                  |  13 +
 rust/kernel/lib.rs              |   3 +
 rust/kernel/sync/arc.rs         |  46 ++-
 rust/kernel/workqueue.rs        | 679 ++++++++++++++++++++++++++++++++++++++++
 scripts/Makefile.build          |   2 +-
 6 files changed, 741 insertions(+), 3 deletions(-)
 create mode 100644 rust/kernel/workqueue.rs

-- 
tejun
