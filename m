Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0EA770A06
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjHDUsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjHDUsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:48:43 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8452C4C2F;
        Fri,  4 Aug 2023 13:48:42 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1a2dd615ddcso368078fac.0;
        Fri, 04 Aug 2023 13:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691182121; x=1691786921;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dbQ+WITNP3Wm+BUgw20KhrHawBzvFk2I60KIA8i0d6Q=;
        b=JAoVJnq9V1PnRMvHx7M/GcEW2qPObzK5xwBh+mR3DQ9kqtMABdYPRFvpgefJj8b4rT
         3XlDdHFmyU4Jt8SqIXOB3IaEKGexZo7dX2G871mpsISi2hBIFiu3bL3WdcdR0wToUVmF
         IEyDliahmzH9v/qUDD8XVBs7l44jREeRg9GihkABYPQi+jFkLYimDGd/8OTV9QRnum2Z
         N89r3kQxCL38IwKfPOaUGfsBIBZMPuLcaVPZJ7XtQSRnjvE0Fl+Toyg5BUVhGStWowMU
         Z7WOduQCn6h5c+9fiaxwgKtypbbAL2zKe0rGKfXmeNf630QR99xaaHASl+uPed0YIazi
         4dNQ==
X-Gm-Message-State: ABy/qLZ8zjJHaxzmf1Wp08QjQITFXwkVlL1JLKmLVC9uGUXMtdHY5scN
        cjzSJewe61UGF0emmvc10ae14h85bd+yBpXT6MCDgunGkpM=
X-Google-Smtp-Source: APBJJlGaqee6qfyhmG6Kq15SpnAEy7PdOGVHTYIV5X9OMUutQBpVH1idaYJSAYsFjfVHlrmMEfgxYrpIuFCcoA/MR/c=
X-Received: by 2002:a05:6870:658a:b0:1bb:b9d1:37fe with SMTP id
 fp10-20020a056870658a00b001bbb9d137femr19671059oab.2.1691182121664; Fri, 04
 Aug 2023 13:48:41 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 4 Aug 2023 22:48:30 +0200
Message-ID: <CAJZ5v0jz05KdjX51tAbLMUCnLVF_CUhadUt1VVrk7KD-ngrPDg@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v6.5-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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
 pm-6.5-rc5

with top-most commit 16e95a62eed18864aecac404f1e4eed764c363f2

 powercap: intel_rapl: Fix a sparse warning in TPMI interface

on top of commit 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4

 Linux 6.5-rc4

to receive a power management fix for 6.5-rc5.

This fixes a sparse warning triggered by the TPMI interface recently
added to the Intel RAPL power capping driver (Zhang Rui).

Thanks!


---------------

Zhang Rui (1):
      powercap: intel_rapl: Fix a sparse warning in TPMI interface

---------------

 drivers/powercap/intel_rapl_common.c               | 14 +++----
 drivers/powercap/intel_rapl_msr.c                  | 49 +++++++++++-----------
 drivers/powercap/intel_rapl_tpmi.c                 | 17 ++++----
 .../intel/int340x_thermal/processor_thermal_rapl.c | 16 +++----
 include/linux/intel_rapl.h                         | 14 +++++--
 5 files changed, 58 insertions(+), 52 deletions(-)
