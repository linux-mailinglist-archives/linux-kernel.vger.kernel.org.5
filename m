Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791E17AB906
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjIVSUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjIVSUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:20:37 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD446A9;
        Fri, 22 Sep 2023 11:20:31 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-57328758a72so354477eaf.1;
        Fri, 22 Sep 2023 11:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695406831; x=1696011631;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ESTyMCdxl96YaByff//NqB4sUD2Ac/hLlF5LXgRg9z0=;
        b=HDoN5wlT/tfqcrXYuF5VBsgNAk57HxmuJhfINXSXzGY69ceS10VGccbnDeuwFBZUUM
         Qjde+ozV4BASNGgZ3NI67DyJSd97r3fws10dhotuVKfJ/EX4RtOIWNJ5IHlFHHelTByC
         pgfj/l0oGGpNk+qNQDdnZs3lu4jMbCMZKaIipDA+svz0qbmhJ9oPAF9/uneDyuDxGLUF
         Ka0TKfUxA0hZ5IcAx8q+7klyapfK0idaqyXGtYztpb/uev1lAhxVjmqkN/ZM2U4MTGy7
         dn/WRXCF4a1S4VkQeYD1RHaDfsYu4kQE94IJEG52Gj1sGpRwWRsscQHe3B2nl5yL9+oG
         d0yQ==
X-Gm-Message-State: AOJu0YxngGaGBYSNU+5UPPF2h9bzUTvfzXpeUkEZWJTr/GFEGpO4jZ3C
        O9KhtQkBOZFUsZW1Rx34nRSLFaZ9SDuPXnfUMIsuceH03A4=
X-Google-Smtp-Source: AGHT+IGJYvVd6+1YFIkAwVUl4OkAY1N66saxHriAUQMMxfHVUgR0RD7tBxC4/TgnDa3PB/u9NBxX65aJ43BDQvt/Mr0=
X-Received: by 2002:a4a:e8c4:0:b0:57b:73f6:6f80 with SMTP id
 h4-20020a4ae8c4000000b0057b73f66f80mr433869ooe.0.1695406831134; Fri, 22 Sep
 2023 11:20:31 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Sep 2023 20:20:20 +0200
Message-ID: <CAJZ5v0iV2vMCF9xJ+ZyCBoMcREsrw+1EuFdV-1Byr-96L4Ws=g@mail.gmail.com>
Subject: [GIT PULL] Thermal control fix for v6.6-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
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
 thermal-6.6-rc3

with top-most commit ea3105672c68a5b6d7368504067220682ee6c65c

 thermal: sysfs: Fix trip_point_hyst_store()

on top of commit ce9ecca0238b140b88f43859b211c9fdfd8e5b70

 Linux 6.6-rc2

to receive a thermal control fix for 6.6-rc3.

This unbreaks the trip point update sysfs interface that has been broken since
the 6.3 cycle (Rafael Wysocki).

Thanks!


---------------

Rafael J. Wysocki (1):
      thermal: sysfs: Fix trip_point_hyst_store()

---------------

 drivers/thermal/thermal_sysfs.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)
