Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC957DADF9
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 20:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjJ2TqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 15:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjJ2TqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 15:46:13 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B3979B
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 12:46:09 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Cx77t_tj5lrps1AA--.45646S3;
        Mon, 30 Oct 2023 03:46:07 +0800 (CST)
Received: from openarena.loongson.cn (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxXNx+tj5lKq02AA--.51878S2;
        Mon, 30 Oct 2023 03:46:06 +0800 (CST)
From:   Sui Jingfeng <suijingfeng@loongson.cn>
To:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] drm/loongson: Submit a mini VBIOS support and a display bridge driver
Date:   Mon, 30 Oct 2023 03:45:59 +0800
Message-Id: <20231029194607.379459-1-suijingfeng@loongson.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxXNx+tj5lKq02AA--.51878S2
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7WF1DCr4UJFW3Jw1kuryrKrX_yoW8tw45pF
        sxA34FkrWUJF12yrZxJFy8JFy5Aa4rWFZa9anrJ3sIg3srAa4UZr15AFW5JrZrZFy7Jry2
        qr97GF4UG3WI9wcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07URa0PUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loongson boards using various external display bridges to extend output
display interface. To complete the support, we have to introduce VBIOS(
or DT/ACPI support) and display bridge drivers.

Sui Jingfeng (8):
  drm/loongson: Introduce a minimal support for Loongson VBIOS
  drm/loongson: Introduce a drm bridge driver for it66121 HDMI
    transmitter
  drm/loongson: Allow attach drm bridge driver by calling
    lsdc_output_init()
  drm/loongson: Started to attach display bridge driver for LS7A1000
  drm/loongson: Using vbios for the LS7A2000 output initialization
  drm/loongson: Clean up the output part of LS7A2000
  drm/loongson: Support to infer DC reversion from CPU's PRID value
  drm/loongson: Add support for the display subsystem in LS2K2000

 drivers/gpu/drm/loongson/Kconfig              |   1 +
 drivers/gpu/drm/loongson/Makefile             |   7 +-
 drivers/gpu/drm/loongson/ite_it66121.c        | 749 ++++++++++++++++++
 drivers/gpu/drm/loongson/ite_it66121.h        |  19 +
 drivers/gpu/drm/loongson/ite_it66121_regs.h   | 268 +++++++
 drivers/gpu/drm/loongson/loongson_device.c    |  50 ++
 drivers/gpu/drm/loongson/loongson_vbios.c     | 420 ++++++++++
 drivers/gpu/drm/loongson/loongson_vbios.h     |  59 ++
 drivers/gpu/drm/loongson/lsdc_drv.c           |   4 +
 drivers/gpu/drm/loongson/lsdc_drv.h           |  27 +-
 drivers/gpu/drm/loongson/lsdc_output.c        | 643 +++++++++++++++
 drivers/gpu/drm/loongson/lsdc_output.h        |  57 +-
 drivers/gpu/drm/loongson/lsdc_output_2k2000.c |  84 ++
 drivers/gpu/drm/loongson/lsdc_output_7a1000.c | 144 ++--
 drivers/gpu/drm/loongson/lsdc_output_7a2000.c | 575 +++-----------
 drivers/gpu/drm/loongson/lsdc_probe.c         |  35 +
 drivers/gpu/drm/loongson/lsdc_probe.h         |   2 +
 17 files changed, 2560 insertions(+), 584 deletions(-)
 create mode 100644 drivers/gpu/drm/loongson/ite_it66121.c
 create mode 100644 drivers/gpu/drm/loongson/ite_it66121.h
 create mode 100644 drivers/gpu/drm/loongson/ite_it66121_regs.h
 create mode 100644 drivers/gpu/drm/loongson/loongson_vbios.c
 create mode 100644 drivers/gpu/drm/loongson/loongson_vbios.h
 create mode 100644 drivers/gpu/drm/loongson/lsdc_output.c
 create mode 100644 drivers/gpu/drm/loongson/lsdc_output_2k2000.c

-- 
2.34.1

