Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48FF7676C5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 22:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjG1UKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 16:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjG1UKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 16:10:09 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3815B423B;
        Fri, 28 Jul 2023 13:10:09 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-563393b63dbso286757eaf.1;
        Fri, 28 Jul 2023 13:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690575008; x=1691179808;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ryMo8RWZEkiACeQYrmm5XmkGRuVYqp4Jcwq4ivOPstE=;
        b=FIVii1pK9Gk91MsXcErZ6Min77acozdYnVuQV7LyN4eVVNipCxtvN964CWmbxN+/I+
         cHqlLhMWo01BMKT++yHSFtXcZYWuMrNcRqxqcqE+A9V4dlaFUk5jsaEDLxTSy1hPrt12
         I7s48ErbMwEiGG2HuXOD7biuYKVPbMQnyfWy3dsDYM6tJCHddDQBnXkjPQg0Fmz+17OC
         VIaQm2PLftvckArnGlznnfrfvfsMb1FvUkPLUnpwE8g7LUyj30uLYfsm6NDSNP5Wc52z
         xQvsibiJy9Dl3QUnB8Spv3uU9r0w3gAGy+/7BndWb41G9MoL8iJ/azk/gRmoAzDLhixO
         zeLg==
X-Gm-Message-State: ABy/qLZg5nRFuBgSa6UJNU95Bmdr0uIVf5KM4VZLFJjpoYQuObys2ZXI
        S7ald6GVow2ca0/mHa4/720+qS6itSY/bgVmtgQ=
X-Google-Smtp-Source: APBJJlGmwiVcsqEXeGGPHtsVHa+qSgqt9SDudq2YhkMkl9RkgiCA3wFvb/R5kjSdwsVMNXIhkeAgw7KKEbHTeNhZxTk=
X-Received: by 2002:a4a:a585:0:b0:56c:484a:923d with SMTP id
 d5-20020a4aa585000000b0056c484a923dmr370962oom.1.1690575008386; Fri, 28 Jul
 2023 13:10:08 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Jul 2023 22:09:57 +0200
Message-ID: <CAJZ5v0jnGiQLWci3=-PM-8StYL4Dqa19HJhVLRVhDkvmuosjPA@mail.gmail.com>
Subject: [GIT PULL] Thermal control fixes for v6.5-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.5-rc4

with top-most commit ac4436a5b20e0ef1f608a9ef46c08d5d142f8da6

 thermal: of: fix double-free on unregistration

on top of commit 6eaae198076080886b9e7d57f4ae06fa782f90ef

 Linux 6.5-rc3

to receive thermal control fixes for 6.5-rc4.

These constify thermal_zone_device_register() parameters, which was
omitted by mistake, and fix a double free on thermal zone unregistration
in the generic DT thermal driver (Ahmad Fatoum).

Thanks!


---------------

Ahmad Fatoum (2):
      thermal: core: constify params in thermal_zone_device_register
      thermal: of: fix double-free on unregistration

---------------

 drivers/thermal/thermal_core.c |  4 ++--
 drivers/thermal/thermal_of.c   | 27 ++++++---------------------
 include/linux/thermal.h        |  6 +++---
 3 files changed, 11 insertions(+), 26 deletions(-)
