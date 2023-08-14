Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC3877C17C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjHNU35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjHNU3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:29:22 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABF7110;
        Mon, 14 Aug 2023 13:29:21 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe426b8583so48006825e9.2;
        Mon, 14 Aug 2023 13:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692044960; x=1692649760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=skSB4WHU3agMjJpOp9u1pm8XMUrKGCqe8s5rHJ83mN4=;
        b=Or6W+MyYdzgWVg0EXjQdL0ZcBCjMAqFuhX5sDn+BcGD8aboekDkvSvOwOk+luDHptx
         6s7wmrrsNTu004AuQlBu4xn4HYDHjXxOQ6r6fcuqX3t9FxsRJe2M3fET8GBY1zkaTD2c
         R+ZZERmnklkYXD6A5t/hmH48wMelboOh0bhiJ6IbuvnT5LHKE2D05rg4xBAkmLYavlh1
         2Or/np0KX1OwetUabXZLodsVJr5Qupqn0oMRwd3N/x1V46GeeWm0aALa+CFl6hwbH1f5
         qXkDVdEb4+SwMvGbwA2xEO5ULKrSAmee0tNCPbtCXvzmURBXJqcxFb2kzw43JKG62/Cs
         YG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692044960; x=1692649760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=skSB4WHU3agMjJpOp9u1pm8XMUrKGCqe8s5rHJ83mN4=;
        b=MwU7PSLPqo+bBte18c8+7NFL9h/v3W5EWaPLiqUpU3ICexETkzyzPuKaVcTJ48AwOs
         0d/4thJyFX2LQjzyOmOhlSCM7n4QrymFv4B9OOIw7y+V4S2py2v8KDaQi5XXbJy6YDhG
         l3jmq5R8TKqwq6R1ioi0QrwPVv+/Xvn9IsnewoEQfujmSYSUQFy9UjjaH1AKjxuTemcf
         qqRsIVKzj1PCVS6l2BMieprJP8OUmVknojENDWBv27pwkWNS0Ru7UMeasG1XImBOxADC
         WQ8ZtY0jZxMbLD22AOXIf+ysEfW3tAFfNnn+c2MSNVafCZnzRhF3/trWtvAeFfv8kk72
         +eyA==
X-Gm-Message-State: AOJu0YyyMbEKv+gxNq8DG7c9qu+1YzMPHp6aekdRkVIAhRcSTkGi+ikk
        8PAqiofvVnFl1e9+vT97VwY=
X-Google-Smtp-Source: AGHT+IGJy9RL4HpNQk9B8SeZ2pp6kejrgfM+jYh9YwXWRnBdq3gVXv7Z1R3XJ8gvGk1+6UcVr/rYWw==
X-Received: by 2002:a1c:4c0e:0:b0:3fc:3f31:4233 with SMTP id z14-20020a1c4c0e000000b003fc3f314233mr8605181wmf.38.1692044960131;
        Mon, 14 Aug 2023 13:29:20 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:20e9:baea:a4f7:d880])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c024800b003fd2d33ea53sm15181223wmj.14.2023.08.14.13.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 13:29:19 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [(subset) PATCH v2 0/3] riscv: dma-mapping: unify support for cache flushes
Date:   Mon, 14 Aug 2023 21:28:18 +0100
Message-Id: <20230814202821.78120-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

This patch series is a subset from Arnd's original series [0]. Ive just
picked up the bits required for RISC-V unification of cache flushing.
Remaining patches from the series [0] will be taken care by Arnd soon.

Cheers,
Prabhakar

v1->v2
* Dropped others archs
* Included RB and ACKs
* Fixed checkpatch issues

V1:
[0] https://patchwork.kernel.org/project/linux-riscv/cover/20230327121317.4081816-1-arnd@kernel.org/

Arnd Bergmann (3):
  riscv: dma-mapping: only invalidate after DMA, not flush
  riscv: dma-mapping: skip invalidation before bidirectional DMA
  riscv: dma-mapping: replace custom code with generic implementation

 arch/riscv/mm/dma-noncoherent.c |  50 +++++++-------
 include/linux/dma-sync.h        | 113 ++++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+), 27 deletions(-)
 create mode 100644 include/linux/dma-sync.h

-- 
2.34.1

