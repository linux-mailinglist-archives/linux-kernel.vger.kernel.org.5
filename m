Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1907D1437
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377874AbjJTQjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjJTQjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:39:18 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDA5D5A;
        Fri, 20 Oct 2023 09:39:13 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-584081ad442so91154eaf.0;
        Fri, 20 Oct 2023 09:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697819952; x=1698424752;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AFN5sba7fAwfQL7XZYasMppuDyc1SAhMhSfxSGiGZ4o=;
        b=rUaFe/tkxKkWU5403GuOPBGxXfb2EAWIX+DNTyG+rqaTQ2O4IqV91gqOZFBYYhM2Uz
         Wd6IKV+4lVLJpanaWVgF7P3IBWP4qeV0b1lxfeOykWiiRSevIcysGl/kVPgULAHT3CTq
         1LO/T5BI4lHdsT/m7QSiNC8uMHhaYP3D9I6iy5YSOJzMnI3rxDudBVmlHhZ+XLTxnycr
         FV96e5Wwx/QiWVtKuQxE8twkm7ULe0/HJzr2JAyWcCbZXVUfAlQOk9E1IDowS9is4xnh
         bor6/rQdsE9BptoSUbA1vRCFFpLFwofW9f96KZN9Y3KhVj73gt/bGXOpR3WEv/ARey0A
         nSwA==
X-Gm-Message-State: AOJu0YzyR6w00hv9KzqiWVj0U9VHelhjChwEDM9YM/dpfMhiv2yEFXio
        /gSucMss2coyWka6FU6jtyKqdNuY8a8GEQtFf+AW5dK1v8E=
X-Google-Smtp-Source: AGHT+IEVBwVrON3rs+Jwwr0IDBEWiarjr0owpS04V9XFgx2fNIVMOWU53kMyS0XRAJO8N4hCF9Ddf6kQIBw6WHyJlDs=
X-Received: by 2002:a4a:e7d1:0:b0:583:ec88:e0 with SMTP id y17-20020a4ae7d1000000b00583ec8800e0mr2622789oov.0.1697819952128;
 Fri, 20 Oct 2023 09:39:12 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Oct 2023 18:39:01 +0200
Message-ID: <CAJZ5v0gJZdGLmJQvKcOtVuJr1XX8J_3kH2jg2rUM1=_1XPCknw@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.6-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.6-rc7

with top-most commit 9caa3a2de955238df742572812178568fed173f7

 Merge branch 'acpi-irq'

on top of commit 58720809f52779dc0f08e53e54b014209d13eebb

 Linux 6.6-rc6

to receive ACPI fixes for 6.6-rc7.

These fix the ACPI initialization ordering on ARM and ACPI IRQ
management in the cases when irq_create_fwspec_mapping() fails.

Specifics:

 - Fix ACPI initialization ordering on ARM that was changed incorrectly
   during the 6.5 development cycle (Hanjun Guo).

 - Make acpi_register_gsi() return an error code as appropriate when
   irq_create_fwspec_mapping() returns 0 on failure (Sunil V L).

Thanks!


---------------

Hanjun Guo (1):
      ACPI: bus: Move acpi_arm_init() to the place of after acpi_ghes_init()

Sunil V L (1):
      ACPI: irq: Fix incorrect return value in acpi_register_gsi()

---------------

 drivers/acpi/bus.c | 2 +-
 drivers/acpi/irq.c | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)
