Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229B37C8066
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjJMIfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjJMIfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:35:15 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D805BE;
        Fri, 13 Oct 2023 01:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=5MOpr
        jAOmKuRQcUEFPjJnljw9+pk28pP88631pmQ2V4=; b=TtTV8rMsFGMzsof06r6ey
        TN+KdGZoxGw9EVowzSLK0PkAJx7I9uJQX9IzEix6yc4iMR0F0YSGs4+qnupVYjyo
        faEOJJ3LoatohGINbcjyGxhsKlI8ES/Nl3X/e4B68K2Wv121bz22Rkhs1ERf29Dk
        bjTAmGMGHvoed8xjaPZCaw=
Received: from test-Z390-GAMING-X.bayhubtech.com (unknown [58.48.115.170])
        by zwqz-smtp-mta-g3-4 (Coremail) with SMTP id _____wD3n6SsACllYx2+AQ--.7595S2;
        Fri, 13 Oct 2023 16:32:45 +0800 (CST)
From:   liuchang_125125@163.com
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mark.tao@bayhubtech.com, shaper.liu@bayhubtech.com,
        thomas.hu@bayhubtech.com, chevron.li@bayhubtech.com,
        charl.liu@bayhubtech.com, Charl Liu <liuchang_125125@163.com>
Subject: [PATCH 0/9] Add support for Bayhub SD/MMC controller
Date:   Fri, 13 Oct 2023 16:32:42 +0800
Message-Id: <20231013083242.10227-1-liuchang_125125@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3n6SsACllYx2+AQ--.7595S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JF4rJr43GrW5JryUXF1kZrb_yoW3tF1fpF
        WrZ34rAw4UKrWIkrn7Kry2yFy3JayxGryDK3y2q3s8ua4IkFyrtrnrJFy5AF93Xr18trnF
        qFs0qFyDK3WDKFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_8n5dUUUUU=
X-Originating-IP: [58.48.115.170]
X-CM-SenderInfo: polxux5dqjsiqsvrjki6rwjhhfrp/xtbBnwQHWVetlIO+lQABsC
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charl Liu <liuchang_125125@163.com>

The Bayhub's SD/MMC Card interface driver implements card detection,
card initialization, and other application level functions. The whole
project is divided into 9 patches to commit. Patch [1/9] and patch
[2/9] commit the Kconfig and Makefile, and the other code is divided
into 7 patches (patch [3/9] to patch [9/9]) by function.

Charl Liu (9):
  scsi: Update Kconfig and Makefile for supporting Bayhub's SD/MMC Card
    interface driver
  scsi: bht: Add Bayhub module's Kconfig and Makefile for compiling
    Bayhub's SD/MMC Card interface driver
  scsi: bht: card: Add the source files related to card initialization
  scsi: bht: host: Add the source files related to host initialization,
    command handler, interrupt handler and transfer handler
  scsi: bht: include: Add the header files related to Bayhub specific
    struct, enum and macro
  scsi: bht: linux_os: Add the source files related to SCSI frame and
    driver entry
  scsi: bht: main: Add the source files related to driver setting
    management
  scsi: bht: tagqueue: Add the source files related to tagqueue transfer
    function
  scsi: bht: util: Add the source files related to utility

 drivers/scsi/Kconfig                         |    1 +
 drivers/scsi/Makefile                        |    2 +
 drivers/scsi/bht/Kconfig                     |   10 +
 drivers/scsi/bht/Makefile                    |   18 +
 drivers/scsi/bht/card/card_ddr200_support.c  |  195 ++
 drivers/scsi/bht/card/card_ddr200_support.h  |   38 +
 drivers/scsi/bht/card/cardcommon.c           |  961 ++++++
 drivers/scsi/bht/card/cardcommon.h           |  123 +
 drivers/scsi/bht/card/cardinterface.c        | 2448 ++++++++++++++
 drivers/scsi/bht/card/mmc.c                  | 1666 ++++++++++
 drivers/scsi/bht/card/output_tuning.c        |  756 +++++
 drivers/scsi/bht/card/sd.c                   | 3029 ++++++++++++++++++
 drivers/scsi/bht/card/thermal.c              |  348 ++
 drivers/scsi/bht/card/uhs2.c                 | 1228 +++++++
 drivers/scsi/bht/host/cmdhandler.c           | 1686 ++++++++++
 drivers/scsi/bht/host/handler.h              |   36 +
 drivers/scsi/bht/host/host.c                 | 2947 +++++++++++++++++
 drivers/scsi/bht/host/hostreg.h              |  478 +++
 drivers/scsi/bht/host/hostven.c              | 2774 ++++++++++++++++
 drivers/scsi/bht/host/hostven.h              |   31 +
 drivers/scsi/bht/host/irqhandler.c           |  742 +++++
 drivers/scsi/bht/host/transhandler.c         | 1730 ++++++++++
 drivers/scsi/bht/include/basic.h             |  395 +++
 drivers/scsi/bht/include/card.h              |  626 ++++
 drivers/scsi/bht/include/cardapi.h           |   85 +
 drivers/scsi/bht/include/cfgmng.h            | 1303 ++++++++
 drivers/scsi/bht/include/cmdhandler.h        |  289 ++
 drivers/scsi/bht/include/debug.h             |  169 +
 drivers/scsi/bht/include/funcapi.h           |   80 +
 drivers/scsi/bht/include/function.h          |   94 +
 drivers/scsi/bht/include/globalcfg.h         |   78 +
 drivers/scsi/bht/include/host.h              |  282 ++
 drivers/scsi/bht/include/hostapi.h           |  170 +
 drivers/scsi/bht/include/hostvenapi.h        |   47 +
 drivers/scsi/bht/include/osapi.h             |  201 ++
 drivers/scsi/bht/include/reqapi.h            |   80 +
 drivers/scsi/bht/include/tq.h                |  159 +
 drivers/scsi/bht/include/tqapi.h             |   36 +
 drivers/scsi/bht/include/transh.h            |  132 +
 drivers/scsi/bht/include/transhapi.h         |   25 +
 drivers/scsi/bht/include/util.h              |   37 +
 drivers/scsi/bht/linux_os/linux_api.c        | 2207 +++++++++++++
 drivers/scsi/bht/linux_os/linux_api.h        |   90 +
 drivers/scsi/bht/linux_os/linux_base.c       |  985 ++++++
 drivers/scsi/bht/linux_os/linux_scsi.c       | 1076 +++++++
 drivers/scsi/bht/linux_os/linux_scsi.h       |  239 ++
 drivers/scsi/bht/main/autotimerfunc.c        |  335 ++
 drivers/scsi/bht/main/cfgmng.c               | 1132 +++++++
 drivers/scsi/bht/main/funcapi.h              |   36 +
 drivers/scsi/bht/main/geniofunc.c            |  618 ++++
 drivers/scsi/bht/main/pmfunc.c               |  357 +++
 drivers/scsi/bht/main/reqmng.c               |  546 ++++
 drivers/scsi/bht/main/testcase.c             |  213 ++
 drivers/scsi/bht/main/thread.c               |  530 +++
 drivers/scsi/bht/tagqueue/tagqueue.c         | 2517 +++++++++++++++
 drivers/scsi/bht/tagqueue/tq_merge.c         |  433 +++
 drivers/scsi/bht/tagqueue/tq_trans_api.h     |   91 +
 drivers/scsi/bht/tagqueue/tq_util.h          |   29 +
 drivers/scsi/bht/tagqueue/tqadma2.c          |  821 +++++
 drivers/scsi/bht/tagqueue/tqadma3.c          |  504 +++
 drivers/scsi/bht/tagqueue/tqadma_sdma_like.c |  373 +++
 drivers/scsi/bht/tagqueue/tqpolicy.c         |  210 ++
 drivers/scsi/bht/tagqueue/tqsdma.c           |  285 ++
 drivers/scsi/bht/util/debug.c                |  413 +++
 drivers/scsi/bht/util/util.c                 |  141 +
 65 files changed, 39716 insertions(+)
 create mode 100644 drivers/scsi/bht/Kconfig
 create mode 100644 drivers/scsi/bht/Makefile
 create mode 100644 drivers/scsi/bht/card/card_ddr200_support.c
 create mode 100644 drivers/scsi/bht/card/card_ddr200_support.h
 create mode 100644 drivers/scsi/bht/card/cardcommon.c
 create mode 100644 drivers/scsi/bht/card/cardcommon.h
 create mode 100644 drivers/scsi/bht/card/cardinterface.c
 create mode 100644 drivers/scsi/bht/card/mmc.c
 create mode 100644 drivers/scsi/bht/card/output_tuning.c
 create mode 100644 drivers/scsi/bht/card/sd.c
 create mode 100644 drivers/scsi/bht/card/thermal.c
 create mode 100644 drivers/scsi/bht/card/uhs2.c
 create mode 100644 drivers/scsi/bht/host/cmdhandler.c
 create mode 100644 drivers/scsi/bht/host/handler.h
 create mode 100644 drivers/scsi/bht/host/host.c
 create mode 100644 drivers/scsi/bht/host/hostreg.h
 create mode 100644 drivers/scsi/bht/host/hostven.c
 create mode 100644 drivers/scsi/bht/host/hostven.h
 create mode 100644 drivers/scsi/bht/host/irqhandler.c
 create mode 100644 drivers/scsi/bht/host/transhandler.c
 create mode 100644 drivers/scsi/bht/include/basic.h
 create mode 100644 drivers/scsi/bht/include/card.h
 create mode 100644 drivers/scsi/bht/include/cardapi.h
 create mode 100644 drivers/scsi/bht/include/cfgmng.h
 create mode 100644 drivers/scsi/bht/include/cmdhandler.h
 create mode 100644 drivers/scsi/bht/include/debug.h
 create mode 100644 drivers/scsi/bht/include/funcapi.h
 create mode 100644 drivers/scsi/bht/include/function.h
 create mode 100644 drivers/scsi/bht/include/globalcfg.h
 create mode 100644 drivers/scsi/bht/include/host.h
 create mode 100644 drivers/scsi/bht/include/hostapi.h
 create mode 100644 drivers/scsi/bht/include/hostvenapi.h
 create mode 100644 drivers/scsi/bht/include/osapi.h
 create mode 100644 drivers/scsi/bht/include/reqapi.h
 create mode 100644 drivers/scsi/bht/include/tq.h
 create mode 100644 drivers/scsi/bht/include/tqapi.h
 create mode 100644 drivers/scsi/bht/include/transh.h
 create mode 100644 drivers/scsi/bht/include/transhapi.h
 create mode 100644 drivers/scsi/bht/include/util.h
 create mode 100644 drivers/scsi/bht/linux_os/linux_api.c
 create mode 100644 drivers/scsi/bht/linux_os/linux_api.h
 create mode 100644 drivers/scsi/bht/linux_os/linux_base.c
 create mode 100644 drivers/scsi/bht/linux_os/linux_scsi.c
 create mode 100644 drivers/scsi/bht/linux_os/linux_scsi.h
 create mode 100644 drivers/scsi/bht/main/autotimerfunc.c
 create mode 100644 drivers/scsi/bht/main/cfgmng.c
 create mode 100644 drivers/scsi/bht/main/funcapi.h
 create mode 100644 drivers/scsi/bht/main/geniofunc.c
 create mode 100644 drivers/scsi/bht/main/pmfunc.c
 create mode 100644 drivers/scsi/bht/main/reqmng.c
 create mode 100644 drivers/scsi/bht/main/testcase.c
 create mode 100644 drivers/scsi/bht/main/thread.c
 create mode 100644 drivers/scsi/bht/tagqueue/tagqueue.c
 create mode 100644 drivers/scsi/bht/tagqueue/tq_merge.c
 create mode 100644 drivers/scsi/bht/tagqueue/tq_trans_api.h
 create mode 100644 drivers/scsi/bht/tagqueue/tq_util.h
 create mode 100644 drivers/scsi/bht/tagqueue/tqadma2.c
 create mode 100644 drivers/scsi/bht/tagqueue/tqadma3.c
 create mode 100644 drivers/scsi/bht/tagqueue/tqadma_sdma_like.c
 create mode 100644 drivers/scsi/bht/tagqueue/tqpolicy.c
 create mode 100644 drivers/scsi/bht/tagqueue/tqsdma.c
 create mode 100644 drivers/scsi/bht/util/debug.c
 create mode 100644 drivers/scsi/bht/util/util.c


base-commit: 401644852d0b2a278811de38081be23f74b5bb04
-- 
2.34.1

