Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CFE754076
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbjGNR3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235303AbjGNR3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:29:03 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86F6113;
        Fri, 14 Jul 2023 10:29:01 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-98dfd15aae1so49927666b.0;
        Fri, 14 Jul 2023 10:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689355740; x=1689960540;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c4R4oPAbYvAZN3uOuXDJAesEZx6JIXyY0l/mzxXQYxI=;
        b=k46q47c5LKkkPfr+tdtMAqMXFDYOPUNsTQDVCAhghJD/Bq31sKJP41GmseYbOXx9bn
         RzCPdfb5ZGhLsKuCw+HOB5LMOMxsaMt5IhteDmmEKAgVyuuTTDVZhn5zAcY9GRsOb+QJ
         GchcDL6GYv5HE81BwmiqEFZ2guapBZEeyP86KRmNTcUjFX1U3Nq5Q1snDrMi1cF1bBO/
         dQvVroqUaHd+AKdmeTGfudbyZ5m7EfSH6nFrwL5T0KzbK+w1VFx3nzUCRbsRMHzxYNVg
         +9EuAGTGyYChT4cRRyZuOtnLcQE8+e5fSlJHE6ay6ivbjeaaf1W8DPn5vxn8COQKnuil
         w6Gw==
X-Gm-Message-State: ABy/qLbTJqRJA6x9/d8xHi9AfTCUIC81zpIIKrXcIi7CZkn4zFR7NlPT
        diSocxCyxjDeF7tkxXBdlI1vjd016tqfPQIfjOwxywfuz4A=
X-Google-Smtp-Source: APBJJlFoXjqme9EidgYL5ypIlskSxqWlYuyooX2kYRP1x+tqgZ8eKZ9ssAdPL48TKahfvJzRGSZZftYxooqhg6zWOog=
X-Received: by 2002:a17:906:73ca:b0:993:d7d2:7f1c with SMTP id
 n10-20020a17090673ca00b00993d7d27f1cmr3729078ejl.5.1689355740137; Fri, 14 Jul
 2023 10:29:00 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Jul 2023 19:28:49 +0200
Message-ID: <CAJZ5v0hSU_kJFMGJOBDELFYycNRjCF1tdjZLH+gXc0wp9JN_AQ@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.5-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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
 pm-6.5-rc2

with top-most commit d121758da6df6829cb505ef0143cf42d28bd865d

 Merge branches 'pm-sleep' and 'pm-qos'

on top of commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5

 Linux 6.5-rc1

to receive power management fixes for 6.5-rc2.

These fix hibernation (after recent changes), frequency QoS and the sparc
cpufreq driver.

Specifics:

 - Unbreak the /sys/power/resume interface after recent changes (Azat
   Khuzhin).

 - Allow PM_QOS_DEFAULT_VALUE to be used with frequency QoS (Chungkai
   Yang).

 - Remove __init from cpufreq callbacks in the sparc driver, because
   they may be called after initialization too (Viresh Kumar).

Thanks!


---------------

Azat Khuzhin (1):
      PM: hibernate: Fix writing maj:min to /sys/power/resume

Chungkai Yang (1):
      PM: QoS: Restore support for default value on frequency QoS

Viresh Kumar (1):
      cpufreq: sparc: Don't mark cpufreq callbacks with __init

---------------

 drivers/cpufreq/sparc-us2e-cpufreq.c | 2 +-
 drivers/cpufreq/sparc-us3-cpufreq.c  | 2 +-
 kernel/power/hibernate.c             | 1 +
 kernel/power/qos.c                   | 9 +++++++--
 4 files changed, 10 insertions(+), 4 deletions(-)
