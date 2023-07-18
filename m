Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E056A7570DE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 02:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjGRA2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 20:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjGRA2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 20:28:05 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6576B1A8;
        Mon, 17 Jul 2023 17:28:04 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b8ad8383faso40786425ad.0;
        Mon, 17 Jul 2023 17:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689640084; x=1692232084;
        h=content-disposition:mime-version:subject:to:date:from:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gsybScX3TAasEPJeiUR0GnmS4s7meRN3K9Y2WCrLayY=;
        b=GYPcZnb4RnvOvNBuxEiXWOH2d4Wdug96h8EVX+GOEAgH8Z2WuqXUnvTdvjg8INdLVK
         DBM6NmczPdhvkoEVgE66kquSab4fELL0UgX9eLK3jBDLcso9kc0kfbYSI3rTcAEJ3QUy
         SmCoO6rPHbwElTJ7wYlf3BAZrK3VhWaiMlcQYwMtHivHPgIZXc/XTyoNeDOsyH5GOnxQ
         sjCP1eAzutGHf8lN59Yz1O/JG9GRHP9SnMMYsSu1sdnwHcK+XZl2DsZ31qXrtxnuXZxz
         /t2hKkm+PnqrDgAoZ+yd+9HBftSE5GVA5rMczzXFjjGU8WsoQTDmwLcGW8AvRgsfSYfg
         j/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689640084; x=1692232084;
        h=content-disposition:mime-version:subject:to:date:from:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gsybScX3TAasEPJeiUR0GnmS4s7meRN3K9Y2WCrLayY=;
        b=TlVmmulMeiC4Bu58g4Qe7LztetOXfrxa4KBcZl/sVswl/2heBZ6GPpmPXpa86P3bJx
         Dx0ChPXetBxi7scbm+ITbnkIzTUKPhnMXoUdPC/HTv12lMuTT6V0iwaOOsZd/3S8P/UM
         Y86sjbYysxzC/lBzgAlQ7m0m7IvSqGri2ehmytls8u96xZODJyZtOnnNaiyeEzj1F1X1
         AptkeOuJ+SVMvRFaGImztgIhHguursze6jd88xxPr/qxl4kh8CSqgGUgqbVcsBIPLC/W
         wqtJJUct/9gOxPzFrElSqDjfiv8WKxZ8Ioa2iIzK6JBQ+RHA5VqAMa9+paKrYB+gBCv0
         rw1A==
X-Gm-Message-State: ABy/qLb1RzHJZpXU3Sj++jbS1o8gp3sUgA6v05UMvggSL3moVZBgY7d1
        hYzThdr2CPbkSruO0rFvIJU=
X-Google-Smtp-Source: APBJJlGcs3hJOrf1f/Cd0vMFz6Oee0pgYh+6JNHCOG9asryiPrdQHqTUaqPDEil1JR7+YBoerQtMgg==
X-Received: by 2002:a17:902:e805:b0:1ab:11c8:777a with SMTP id u5-20020a170902e80500b001ab11c8777amr16225639plg.13.1689640083776;
        Mon, 17 Jul 2023 17:28:03 -0700 (PDT)
Received: from sie-luc. ([1.85.36.133])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902e54a00b001b86e17ecacsm452089plf.131.2023.07.17.17.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 17:28:03 -0700 (PDT)
Message-ID: <64b5dc93.170a0220.243d5.1d63@mx.google.com>
X-Google-Original-Message-ID: <20230718002756.GA2558@sie-luc.>
From:   Luc Ma <onion0709@gmail.com>
X-Google-Original-From: Luc Ma <luc@sietium.com>
Date:   Tue, 18 Jul 2023 08:27:56 +0800
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        onion0709@gmail.com
Subject: [PATCH] dma-buf: remove unintended hyphen in the sysfs path
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luc Ma <luc@sietium.com>

Signed-off-by: Luc Ma <luc@sietium.com>
---
 drivers/dma-buf/dma-buf-sysfs-stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-buf-sysfs-stats.c b/drivers/dma-buf/dma-buf-sysfs-stats.c
index 6cfbbf0720bd..b5b62e40ccc1 100644
--- a/drivers/dma-buf/dma-buf-sysfs-stats.c
+++ b/drivers/dma-buf/dma-buf-sysfs-stats.c
@@ -33,7 +33,7 @@
  * into their address space. This necessitated the creation of the DMA-BUF sysfs
  * statistics interface to provide per-buffer information on production systems.
  *
- * The interface at ``/sys/kernel/dma-buf/buffers`` exposes information about
+ * The interface at ``/sys/kernel/dmabuf/buffers`` exposes information about
  * every DMA-BUF when ``CONFIG_DMABUF_SYSFS_STATS`` is enabled.
  *
  * The following stats are exposed by the interface:
-- 
2.25.1

