Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560B77AB91E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjIVSYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbjIVSYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:24:00 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFFCCA;
        Fri, 22 Sep 2023 11:23:53 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3ae0df6494bso307649b6e.1;
        Fri, 22 Sep 2023 11:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695407033; x=1696011833;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jHAukQqrkJE28GYt3F1ijfvM9aeABkfEb++TlB6e2cY=;
        b=CQbD4ZChPU3/QmT+2e3AEogZEfj3zNrD9zqxDI7j7lwwUSlPk5e/Yz0gPhR1ir7fFn
         QEoqM5sX00kwjUIKb4R5R4OmzakJD4fspojyF6+RFUz+ezSw9cAu1EbPX3sltfMljVjd
         19AgFTtw97i0Ud+2FPcs129DCVXS6G3t1drIcai1ZSh0tWHeyv12NRRpFyeYd49t4reZ
         zYUYB5yVLkJNOLOVrEU0Xn86tN6kChff9s9u7MXszBW9nMPuNJAWuH8qmsMASltTtm2x
         X81/f0n//Qfr7hPKVzt7LRyep+x+1B1EZ0A6oAxjfyTSPA7OdfQ36welBjpw4Nty2NQl
         z8iw==
X-Gm-Message-State: AOJu0YzIG8wk1HAV0rL5GREUzHi4gBfOtaJ6+bqB8erNa8u9dqQwscD6
        Ms3scGCYltZJmQtK6LLGDGnidqeHHqrvOtweNDk=
X-Google-Smtp-Source: AGHT+IE+AqVGPYHSWXqTASuIqrF0RoJU4ySF+R22mQnVc7GUbrnB8Ibnws3GLAfOVIbDo5enOPMz2fnmy3e4Bo64p5c=
X-Received: by 2002:a05:6808:14d4:b0:3ad:f535:7e9a with SMTP id
 f20-20020a05680814d400b003adf5357e9amr528964oiw.5.1695407033053; Fri, 22 Sep
 2023 11:23:53 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Sep 2023 20:23:42 +0200
Message-ID: <CAJZ5v0iYLvO6VbzKo0-1sbpuVGF=Y-y2ajoRMMz+wAO0RTUNLw@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.6-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.6-rc3

with top-most commit a1001c37f83b30a75c17796b453769773b71f9b2

 Merge branch 'acpi-processor'

on top of commit ce9ecca0238b140b88f43859b211c9fdfd8e5b70

 Linux 6.6-rc2

to receive ACPI fixes for 6.6-rc3.

These fix a general ACPI processor driver regression and an ia64 build
issue, both introduced recently.

Specifics:

 - Fix recently introduced uninitialized memory access issue in the ACPI
   processor driver (Michal Wilczynski).

 - Fix ia64 build inadvertently broken by recent ACPI processor driver
   changes, which is prudent to do for 6.6 even though ia64 support is
   slated for removal in 6.7 (Ard Biesheuvel).

Thanks!


---------------

Ard Biesheuvel (1):
      acpi: Provide ia64 dummy implementation of acpi_proc_quirk_mwait_check()

Michal Wilczynski (1):
      ACPI: processor: Fix uninitialized access of buf in acpi_set_pdc_bits()

---------------

 arch/ia64/kernel/acpi.c      | 4 ++++
 drivers/acpi/processor_pdc.c | 1 +
 2 files changed, 5 insertions(+)
