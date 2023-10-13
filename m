Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73A07C9185
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 01:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjJMXr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 19:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbjJMXrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 19:47:25 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE22B7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 16:47:24 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-27cfb8bc7eeso2070362a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 16:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697240843; x=1697845643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VsmJKoEfZzH5dGYcow1pJhun4pr6MeJ+V/BA29opGNE=;
        b=Opx/OBWvAWPfh+l+UYe3LDKo2X6Q6T63yMI8Qju/iynzAssM8WA0YOFhGlIOZ1fCif
         2lRZGc4P7TflC5Ojdsma0HaD64wkYYlFAMsD7fXA/epxJOiWosg0UuyT7leUlphzj5pw
         Wkn9p5/fvmHRZNMBx5GA0ltEy6HgplVsPRzQ7W9CPdLQHny59ha0Hge5LanSJH6Tvifu
         4/EDnizCfFySkQlsFsPoIeSb6Epu0prqGYhXa7jyqn0WtqGUmOTPJRrgj2NAoj6wHI8+
         BjUyivF1E3Jdulx4QKOfaC6QEWElNRWQ1vYEVcoDBhpA+jbjwOtYbqx8P4jQlkS+JyVH
         Q/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697240843; x=1697845643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VsmJKoEfZzH5dGYcow1pJhun4pr6MeJ+V/BA29opGNE=;
        b=BueNRyzfTXf3NqD8nqzEieh6T3RDB4NSUOp0s4nF7p6ePV558xsxEXidwMITwNvz7C
         KLB8F55yRk357Iyd6m0CrTUlMU05Pp0hflBMEIkXaWX8PEWc3/ihgpSAuZ9iHbDNv3Et
         zjXZSUMgih4mPg0SOqHUP4L3v3XTq+GEYie1EPl+KZON+WI6C94fQ7Bkz/McLr+FMM6T
         2gg+wtOUFh1b5hc5DF4Xz4Q7mfZR6zpaPm2Cfgy8hTZYEkmpGnf1kad3oONRilzssNs7
         Y7pgzaiKfY9/kd9xUhzJZ+n3MPEdm9upj/3vZY3UIDuO/1HiLC5Ppohyy+i8qraKg9Hy
         cNZA==
X-Gm-Message-State: AOJu0YyV8e+FTx71511FfqYkN6vORvXmUrfpEcZeG8y9RElTzyEQr266
        J9IHt+UkFYpYKqb0ddInvYHFmU8hvM7JsA==
X-Google-Smtp-Source: AGHT+IGiZmINZuvHcm5NXBP1zW2GwN+KlqVDpBtLEE4e25BQLM8VJn2APtskH4zjuBFz7ve0BvcqqA==
X-Received: by 2002:a17:90b:888:b0:27d:6dd:fb7d with SMTP id bj8-20020a17090b088800b0027d06ddfb7dmr8827933pjb.17.1697240843536;
        Fri, 13 Oct 2023 16:47:23 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id ne10-20020a17090b374a00b0027732eb24bbsm657618pjb.4.2023.10.13.16.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 16:47:22 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Soumya Negi <soumya.negi97@gmail.com>
Subject: [PATCH 0/4] staging: vme_user: Coding style cleanup patches
Date:   Fri, 13 Oct 2023 16:47:12 -0700
Message-ID: <cover.1697240381.git.soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset performs trivial code cleanups on the driver 
staging/vme_user to improve code readability. All patches address 
issues reported by checkpatch.pl, and may be applied in any sequence.

Soumya Negi (4):
  staging: vme_user: Correct spelling mistakes in comments
  staging: vme_user: Fix unbalanced {} in if-else blocks
  staging: vme_user: Add spaces around '*'
  staging: vme_user: Add spaces around '<<' operator

 drivers/staging/vme_user/vme.c        |   7 +-
 drivers/staging/vme_user/vme.h        |   2 +-
 drivers/staging/vme_user/vme_tsi148.c |   7 +-
 drivers/staging/vme_user/vme_tsi148.h | 548 +++++++++++++-------------
 4 files changed, 283 insertions(+), 281 deletions(-)

-- 
2.42.0

