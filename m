Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46A980F047
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377060AbjLLP0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbjLLPZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:25:53 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C84EF3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:25:59 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54ba86ae133so5528896a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1702394758; x=1702999558; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4YOmXjtg+QYQBxHin0XEuIjM6hmU4vypdWtWff89pKM=;
        b=kTiAXFhk8YYfBF/HFNdhcEdoas4IzBswWaUcnN1HmUym58HjLtkM+GL4Vx0z8JKl0Y
         G0aPsbtZULKzImVwXuUnhKMXjrwhPMtYJPE+78+rUXjvW3r88a+uZnQl7YIzQO9Sdi6L
         pLGWGQDDjTLiIsnUZhNPH31UR1tmelbGLdHJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702394758; x=1702999558;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4YOmXjtg+QYQBxHin0XEuIjM6hmU4vypdWtWff89pKM=;
        b=mEXPThPgGJRlsFERIVXzTPuUpdB/8D4pqz+Zd26wC3K7IkbSCa9tWJ6riW1E6jzNVY
         mZmfLFltIdJzFP8bspIN3k9m/3Uqfl58FeyFNYeINGCQ/JaNSJrCN8x3MZxG9rQyEyI0
         4AunnaSBZDjjZrcHyamJB2F3wXF9R2NTRs+w6CXLA5cSiX14MYoS+IHDpVEn83kCDehd
         dzLh9AJadiCoFxyauTuZblYUU8QMQXkJUHJKhzwr//Kz+9wZNSWIgHMEc/N5/pKPZ2s3
         ZQUU38XP0omLMubvU8R+3Wvg0syGwzqr+8+Lw/so6W9EyhTY6KLbEqFySnUHZ45rBjIN
         +0Ow==
X-Gm-Message-State: AOJu0YyXnaeYwYAgHFRjlI5KjMIi7HO7lxZR5Jbp1HdeJRguqKQWGYDH
        kEBmud3cCzgoj5qVpuYmvbOnZxDpkjqoMtdcjz5I9Q==
X-Google-Smtp-Source: AGHT+IF5sjc1HAoOLU2FF2xH9fnOYW204DNorurP5oUNffj+6I9JQIztVYTl+Vgw2FfqUmhaGwIJVpkjIzo7Uq4KxHc=
X-Received: by 2002:a17:907:a0c6:b0:a17:ab92:3d55 with SMTP id
 hw6-20020a170907a0c600b00a17ab923d55mr4045465ejc.19.1702394757949; Tue, 12
 Dec 2023 07:25:57 -0800 (PST)
MIME-Version: 1.0
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 12 Dec 2023 16:25:46 +0100
Message-ID: <CAJfpeguzG6EGi2FXspV-sQDrFkyf5umF6jHg3G=9XpWN95Bsug@mail.gmail.com>
Subject: [GIT PULL] fuse fixes for 6.7-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
tags/fuse-fixes-6.7-rc6

 - Fix a couple of potential crashes, one introduced in 6.6 and one in 5.10

 - Fix misbehavior of virtiofs submounts on memory pressure

 - Clarify naming in the uAPI for a recent feature

Thanks,
Miklos

----------------------------------------------------------------
Amir Goldstein (1):
      fuse: disable FOPEN_PARALLEL_DIRECT_WRITES with FUSE_DIRECT_IO_ALLOW_MMAP

Hangyu Hua (1):
      fuse: dax: set fc->dax to NULL in fuse_dax_conn_free()

Krister Johansen (1):
      fuse: share lookup state between submount and its parent

Tyler Fanelli (2):
      fuse: Rename DIRECT_IO_RELAX to DIRECT_IO_ALLOW_MMAP
      docs/fuse-io: Document the usage of DIRECT_IO_ALLOW_MMAP

---
 Documentation/filesystems/fuse-io.rst |  3 +-
 fs/fuse/dax.c                         |  1 +
 fs/fuse/file.c                        |  8 ++--
 fs/fuse/fuse_i.h                      | 19 +++++++-
 fs/fuse/inode.c                       | 81 ++++++++++++++++++++++++++++++++---
 include/uapi/linux/fuse.h             | 10 +++--
 6 files changed, 106 insertions(+), 16 deletions(-)
