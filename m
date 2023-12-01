Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426B0801537
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 22:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjLAVTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 16:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAVTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 16:19:20 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CFC10D0;
        Fri,  1 Dec 2023 13:19:27 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3b85d97a529so387742b6e.0;
        Fri, 01 Dec 2023 13:19:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701465567; x=1702070367;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Na5SuSnuGSKFtr3bwJTXAsXLv0Bpp+jJLrkc0svhQs=;
        b=VlPLDeQI4xfHpelXtmbZ9bma3FXq7BWeo3ctW3tavKWCgDi9GAUsgmDaBKCOkz+DTE
         q4snhugFtsrSNC3RUGElcRv0oWOCnUowVnmSY21tc72+0jCw4I7c7R2ejVx/pQbmmZj3
         jmo5MQcdngf9pVisAAvB2d8wpFLlgtn14nRFS2Zf5GMOZf8HzAV6LB5roY3pbi6tn20b
         fYVCyba/EeX+biDBU8aAe07UC3vcqamKbugm5StEn8sLSqUhB6kfFt6UeIPaOW5Izeee
         lWY7SA/ijBxW/hJjcoJADnKweWcAOLOSV1FzA1thA1tD1Qock4iHNwoZ2SPM6dLzJfh+
         0spA==
X-Gm-Message-State: AOJu0YxPXACLpK00i0bhiKLff8Qd7/DHDuRQZXkI8HNcSqAL8mwqjYnX
        SZe83msth3vB7mwnJK1JmL2fYRClpmmyNnBL+h9WfO/DocA=
X-Google-Smtp-Source: AGHT+IFEc4P+oh95LTEsSLeRVbfU6mBGECB8PMHw30gUbESltyScgK6F/oxN4q8ypDgHTa5g37jjAkAgU5l7sc24BmA=
X-Received: by 2002:a05:6870:971f:b0:1fa:f195:e3b4 with SMTP id
 n31-20020a056870971f00b001faf195e3b4mr2755801oaq.2.1701465566780; Fri, 01 Dec
 2023 13:19:26 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 1 Dec 2023 22:19:15 +0100
Message-ID: <CAJZ5v0gCXED78oLB7wPJ+bn0keQvYzZhyk-XsQVUJrP2i+c-xQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.7-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.7-rc4

with top-most commit 7d4c44a53dade7103c3a9a928705db2326efba6f

 Merge branch 'acpi-tables'

on top of commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab

 Linux 6.7-rc3

to receive ACPI fixes for 6.7-rc4.

This fix a recently introduced build issue on ARM32 and a NULL pointer
dereference in the ACPI backlight driver due to a design issue exposed
by a recent change in the ACPI bus type code.

Specifics:

 - Fix a recently introduced build issue on ARM32 platforms caused by an
   inadvertent header file breakage (Dave Jiang).

 - Eliminate questionable usage of acpi_driver_data() in the ACPI
   backlight cooling device code that leads to NULL pointer dereferences
   after recent ACPI core changes (Hans de Goede).

Thanks!


---------------

Dave Jiang (1):
      ACPI: Fix ARM32 platforms compile issue introduced by fw_table changes

Hans de Goede (1):
      ACPI: video: Use acpi_video_device for cooling-dev driver data

---------------

 drivers/acpi/acpi_video.c | 14 +++++---------
 include/linux/acpi.h      | 22 +++++++++++-----------
 include/linux/fw_table.h  |  3 ---
 lib/fw_table.c            |  2 +-
 4 files changed, 17 insertions(+), 24 deletions(-)
