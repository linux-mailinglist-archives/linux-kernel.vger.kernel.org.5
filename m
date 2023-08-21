Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851F078244E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbjHUHUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjHUHUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:20:30 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33738A9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 00:20:29 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31781e15a0cso2705980f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 00:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692602427; x=1693207227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xKVOdMsnZ56jkOvnM2g2MXrdW492ArIZJLGaonGgCxo=;
        b=dRpIoXlkJeWaNTQ3S6kmqIM+U48Rjr/VZQFyXZqr2VfindmEB7ABhEf5s4Pw87c8bK
         bYL6Fdu6eOkJsSRqbNPbl2wknvH/7YXrAKXyb03R2JGpFAoCAYLhZ8wJByitTc2aN0h2
         YYb5hykmGO7Pb+ut/UYWyVOJegiIc3T2DfD1xXerCoW3WJhb5wttSbXVQSIqNhMGWa9X
         kSYUrTAbC8PSjXRH1E0sxiPQqUwct+NibYXj1ZXsl7VX4yAmzbIHGQXbY37jihVxe7Gu
         JBxseOckJZUHLrAa4zPLsHYgZSnbY7zySDNuNhiQEHArjkqybhcU8NVZ+e2uVesLzVe6
         d0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692602427; x=1693207227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xKVOdMsnZ56jkOvnM2g2MXrdW492ArIZJLGaonGgCxo=;
        b=X3Dm7TJ4yQHttoUnMdkFINq10WPfEtvtWYIMC4pQcfbttjuOf2lVGGjJ5OYwjPyuMt
         Upa6QMVNOY8xugeftvxfwzQxKJlmALGyY/L22qprnHdxpT1eV5wXsv8YxwA3UxSFn68r
         5zAqdINSHeojloMDdlvd/wxZVh+UN5MMweGKnsxAruPwHYeoYZc5Q2mNoFhdFgls0sf0
         xY/ZGy1Oc6KH4UAAADDe9TieWgoHOH4p6uYVCpX4HS4QrY55gVCZoZqHb4SwsJB4kJ9J
         QeAjCeRdvJDhEqSXEgA3aD7OqVOVEblK28ArUoiRMYFL2FzpGvl30lMwusDPVMXNGQP1
         KgmQ==
X-Gm-Message-State: AOJu0YzNIia+z1YB2zTzj3YlOUsVrUpxo3rPpNfnBKQhOXwNzvGXb2At
        +bkgtJC8spvcjY07qq6riD89yoaJ0AQ=
X-Google-Smtp-Source: AGHT+IFaWRxX1/UVscCok0gg6uEFMROrNxYnLU6pco7esfmauKtxLx3vc85vLr80wFyCs00eknmiRg==
X-Received: by 2002:a5d:68ca:0:b0:31a:d7ce:927a with SMTP id p10-20020a5d68ca000000b0031ad7ce927amr4019783wrw.3.1692602426985;
        Mon, 21 Aug 2023 00:20:26 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id w7-20020adfcd07000000b00313de682eb3sm11554763wrm.65.2023.08.21.00.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 00:20:26 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>
Subject: [PATCH 0/8] OpenRISC compiler warning fixes
Date:   Mon, 21 Aug 2023 08:19:59 +0100
Message-Id: <20230821072007.2698186-1-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes a few compiler warnings under the OpenRISC architcture
subtree when compiling with W=1.  I have split each warning by the type of fixes
that were needed for each.

Most of these were reported by Arnd in:

  https://lore.kernel.org/all/20230810141947.1236730-17-arnd@kernel.org/

After these fixes I don't have any warnings in architecture specific code.

Stafford Horne (8):
  openrisc: Add missing prototypes for assembly called fnctions
  openrisc: Declare do_signal function as static
  openrisc: Add prototype for show_registers to processor.h
  openrisc: Add prototype for die to bug.h
  openrisc: Include cpu.h and switch_to.h for prototypes
  openriac: Remove unused nommu_dump_state function
  openrisc: Remove unused tlb_init function
  openrisc: Remove kernel-doc marker from ioremap comment

 arch/openrisc/include/asm/bug.h       | 11 ++++
 arch/openrisc/include/asm/processor.h |  1 +
 arch/openrisc/kernel/process.c        |  4 +-
 arch/openrisc/kernel/ptrace.c         |  4 ++
 arch/openrisc/kernel/signal.c         |  7 ++-
 arch/openrisc/kernel/smp.c            |  2 +
 arch/openrisc/kernel/time.c           |  2 +
 arch/openrisc/kernel/traps.c          | 85 ++++-----------------------
 arch/openrisc/mm/fault.c              |  4 +-
 arch/openrisc/mm/init.c               |  2 -
 arch/openrisc/mm/ioremap.c            |  2 +-
 arch/openrisc/mm/tlb.c                |  9 ---
 12 files changed, 42 insertions(+), 91 deletions(-)
 create mode 100644 arch/openrisc/include/asm/bug.h

-- 
2.39.1

