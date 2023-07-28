Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A845C7676C2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 22:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjG1UJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 16:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjG1UI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 16:08:59 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5670A423B;
        Fri, 28 Jul 2023 13:08:58 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1bb701d39ddso530958fac.0;
        Fri, 28 Jul 2023 13:08:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690574937; x=1691179737;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q79hPJkv80W3ZTMPPOfOJxtE042u5i+b6lDa964aWnM=;
        b=l9PnizOmaKBxw6d6OF7jlGVeXglBvX9lvkzcTDZXBLdCl2ggGzn7AdqMwzoviVcK8/
         PRIa2WEm0FAOrWbU2yTmjJvUmsmxCOlYAOEXukle3EjQCK6bsbkx6eRb+vvlFFSgkcEh
         qbEXL44kOE7zx95myVJBrIfHFbj3UlxQzl1AIHnzqtXVEQguWEmbFhzTz7kBoh9WB9Ek
         8xBxtTmts0xjVdzq6pANT9REa2Fo8W7nxVWJkzHX/J7FzwIp6zFMqXPPsgzV/oORar3K
         9/t+FvW3gCyjmen4FxaOoWknANnj09aJXWb+WCOklBZQZDhNCBFmlhzvOI0YVfQS1cjR
         P2ew==
X-Gm-Message-State: ABy/qLYbIzOM36OxUC/hKCxlAE+woMjKS4fgWnT+I4FNYx8ADehJagAX
        0en3hyX+JsI8ppuARBCqee1vAE2niiq+/uWgdc00kxVgFCY=
X-Google-Smtp-Source: APBJJlEyH7ILYuWiHXTdPGl1bHR5jOok8xyS3RSSIp9s3XORXnuo+ISsTmLTb4uVYfqWHvSEawAeMPuQr6xiu6nEhnM=
X-Received: by 2002:a4a:a585:0:b0:56c:484a:923d with SMTP id
 d5-20020a4aa585000000b0056c484a923dmr366974oom.1.1690574937495; Fri, 28 Jul
 2023 13:08:57 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Jul 2023 22:08:46 +0200
Message-ID: <CAJZ5v0jRDjoe1Rd4XOQyKvv73AKtKT4wb7mrLe1+q9w1hO9Fyg@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.5-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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
 pm-6.5-rc4

with top-most commit 4dd8752a14ca0303fbdf0a6c68ff65f0a50bd2fa

 serial: qcom-geni: drop bogus runtime pm state update

on top of commit 6eaae198076080886b9e7d57f4ae06fa782f90ef

 Linux 6.5-rc3

to receive power management fixes for 6.5-rc4.

These fix the arming of wakeup IRQs in the generic wakeup IRQ code (wakeirq),
drop unused functions from it and fix up a driver using it and trying to
work around the IRQ arming issue in a questionable way (Johan Hovold).

Thanks!


---------------

Johan Hovold (3):
      PM: sleep: wakeirq: fix wake irq arming
      PM: sleep: wakeirq: drop unused enable helpers
      serial: qcom-geni: drop bogus runtime pm state update

---------------

 drivers/base/power/power.h            |  1 +
 drivers/base/power/wakeirq.c          | 61 +++++------------------------------
 drivers/tty/serial/qcom_geni_serial.c |  7 ----
 include/linux/pm_wakeirq.h            | 10 ------
 4 files changed, 9 insertions(+), 70 deletions(-)
