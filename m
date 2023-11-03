Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3087E04E8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 15:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjKCOqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 10:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKCOpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 10:45:54 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F17D4B;
        Fri,  3 Nov 2023 07:45:51 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-582a82e6d10so373249eaf.0;
        Fri, 03 Nov 2023 07:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699022750; x=1699627550;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z0eMQlkd/1nzWSYbIbqTWFK51BT6StbP9Y4LE768zlc=;
        b=JtYP7IO66GFPShMl6NwSxLy2VpZprXshzxhztTkjHtasQjCMaiVY/W3DhGYw1Nzh43
         JVfgzxhqRs201iUUDENdL8ywrrGrQnGiyps7VrljLQ3kjZvjxUl45503NoE3irHDRp1/
         sL14x9gYBh9OwKCCVglAYlp5epVYE5VerTpXtENtZUYSHM4vMrhvaHkLopBt29hrpgLk
         sRNAOb/2mRNZefoHBjsE1fML4lvz1tXTuy8cpfrTEV9Z5c1oDt5zKiXmf7wpqjqJYKX/
         MkpmjIibIFWAHDQfCFGxLa4mQ1oa/3mDl4ic30bid8Tx3eMXhOJldcAojcQUSt/bd4Di
         JJOQ==
X-Gm-Message-State: AOJu0Yxa7Yjt3u0pNEN9NVgfxuFTAkJ21BdgnIKx0cUmpe2M5qparrqU
        EIXy9JwO9vCS3YdbS8p3g+/uOhY6I2cYWWL8t+I=
X-Google-Smtp-Source: AGHT+IE7bGRJkmZA7il7MQQ4NSOQ/8eGKxxmG+zjeCMZGR5+OPI+8oZauf1DrijC0SN1T3sxclkKpdR29HyGRWAtnkc=
X-Received: by 2002:a4a:b985:0:b0:583:fc94:c3fd with SMTP id
 e5-20020a4ab985000000b00583fc94c3fdmr21662945oop.0.1699022750689; Fri, 03 Nov
 2023 07:45:50 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 3 Nov 2023 15:45:37 +0100
Message-ID: <CAJZ5v0gazz3JxSHwgDFFhXjHVEzwjpteXzAc6uPwz=FFdWs_cg@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v6.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.7-rc1-2

with top-most commit 4b27d5c420335dad7aea1aa6e799fe1d05c63b7e

 ACPI: thermal: Fix acpi_thermal_unregister_thermal_zone() cleanup

on top of commit f4cb34a75e4a4aee09ff832ea2147cf8322a6a7f

 Merge branches 'acpi-ac', 'acpi-pad' and 'pnp'

to receive an ACPI fix for 6.7-rc1.

This fixes the acpi_thermal_add() error path that may do a double-free
in some cases after recent changes (Dan Carpenter).

Thanks!


---------------

Dan Carpenter (1):
      ACPI: thermal: Fix acpi_thermal_unregister_thermal_zone() cleanup

---------------

 drivers/acpi/thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
