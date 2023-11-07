Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DB67E4979
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 20:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbjKGT4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 14:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKGT4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 14:56:35 -0500
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44715184;
        Tue,  7 Nov 2023 11:56:33 -0800 (PST)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5841a3ffd50so1273597eaf.1;
        Tue, 07 Nov 2023 11:56:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699386992; x=1699991792;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L+67Fow4SDoQzTb3iQORdk0PeLGfng3C8Clxn36Up9o=;
        b=PG9z78NyRpp1mjPvogIp1npJwj5XP7QWC3WVAeYq84StHmqpffwImj5DVo34D7b+Ci
         8kV/7S5FgEplZcUkmtPEZktUKN2UyjvPrUoXB3dKKW4l6Ag5WB4t+R82p+ETzMztmTm1
         dMQ+mXOAo067jto0JGTLpcuxcgHGdwuTDzrAmFLH60wrBVVF4Un3/R6HmfiUXXb5AKKz
         Kb8xdkifbyc8A4tUsVOmiCNX+ZuBu4VEGMLC8rJqg6+OtcCUmLMBPCwH5Ol0HwfnJy6O
         p2rn+RphzCJbYCHs1LwYZFuTuaVNl0NG1IupNn9mNDc9pPyQb2Nq/8xBZIZu0YHGmg+j
         ZUpQ==
X-Gm-Message-State: AOJu0YytX1tg6t8FMiOjouybOK9N8BupGpupWWWAVL0tnL768II23m6L
        6yqY/PFze0ChYG6PcxAOPx52oRZCBIfXccpbcVAj4RqbqNY=
X-Google-Smtp-Source: AGHT+IFDHEbdEEGZPP3XT78f8ZjPsc9hJlOtuXXAeyPrcJoYDnp3iBYWM3w3bcg/LScm10toBmXkTour9Cx2afeM3vQ=
X-Received: by 2002:a05:6808:30a:b0:3b2:9c2f:50e0 with SMTP id
 i10-20020a056808030a00b003b29c2f50e0mr29973171oie.5.1699386991944; Tue, 07
 Nov 2023 11:56:31 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Nov 2023 20:56:20 +0100
Message-ID: <CAJZ5v0gggsvrHYyOJn3g3Wd3M8vpG0sPdcWO8k7hDx4_wsq5cQ@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v6.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.7-rc1-2

with top-most commit 36cbb924d60bf2f1f684b3739edc61cba8350160

 Merge branch 'pm-tools'

on top of commit 3062a9879afbca810d9f1613698963ecfcb35701

 Merge tag 'acpi-6.7-rc1-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more power management updates for 6.7-rc1.

These add new hardware support to a cpufreq driver and fix cpupower
utility documentation:

 - Add support for several Qualcomm SoC versions to the Qualcomm cpufreq
   driver (Robert Marko, Varadarajan Narayanan).

 - Fix a reference to a removed document in the cpupower utility
   documentation (Vegard Nossum).

Thanks!


---------------

Robert Marko (1):
      cpufreq: qcom-nvmem: add support for IPQ8074

Varadarajan Narayanan (2):
      cpufreq: qcom-nvmem: Enable cpufreq for ipq53xx
      cpufreq: qcom-nvmem: Introduce cpufreq for ipq95xx

Vegard Nossum (1):
      cpupower: fix reference to nonexistent document

---------------

 drivers/cpufreq/cpufreq-dt-platdev.c              |  3 ++
 drivers/cpufreq/qcom-cpufreq-nvmem.c              | 60 +++++++++++++++++++++++
 tools/power/cpupower/man/cpupower-powercap-info.1 |  2 +-
 3 files changed, 64 insertions(+), 1 deletion(-)
