Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2EB7E7FEF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbjKJSBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235262AbjKJSAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:00:23 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC1633677
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 04:26:42 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507c1936fd5so3413234e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 04:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699619200; x=1700224000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vbt3drzH6qk5bCWArsPemY04IIl/cwsmy/leESa8QcA=;
        b=SuHXJkIcrLQjvNsTMmhw/YnHSw9Lp0TiM9rYq0lLffTZATc/Rore3icDkMYLfgx/Rn
         YYeO72nbh/XgarKv3jHX4Yt3CTaM6tL3yQnKUv4RlE57PF2TijhuiLqTyroS53r2R5xc
         5yuDoEgoaAHIDwPFio5/wpAgkDeS0EWyyGSHhmvS25PtUYXm7qL4zSmn4Fx7qbKOSq3b
         4T0Kt5shjvyDVxLSZxZI5CQgK1HTp4XebzmytEy21PGlmgwCwA4TX6u4n+2IDrgHKu0X
         ZrI1HXfRKjf8iwtC42ghVOLJSga1o9OpeClItAid97iOI0RapSN8xWd/rxg0GCsRaJZO
         7GPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699619200; x=1700224000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vbt3drzH6qk5bCWArsPemY04IIl/cwsmy/leESa8QcA=;
        b=LOwDYn1h5neS0f8IP0PGcLZOPYkMyIvaEWgQ5d7F0UycZpTW7YUcaKGErVNbsK8TS0
         /sybjGppvmTQH1ocUHSRiKKy0jf3LCiL3J0hCmRgO+IFcrKEzvJHooDOIn4BdYvsJVF+
         PDsQxjd3LGr86/wMjoue5q26VufPc+t13TqqfI0oWdZcJZoKC1gplwqKiPdoA0totFah
         lMoa+b2fG0klz/j/fZFNuuB/2pLR3X9L7umEmQfQwSFl3id8O4no3zIMzWcaFBvLFtZk
         lotIZUv+A+9o7po4WR66jS8sBkY97FpUDGbL7gJhlhQ8D3c3arEsOC1gu1zezPENrZjq
         43fg==
X-Gm-Message-State: AOJu0Yw7nTARIMct7lLmxvES69y1EX7jspNNZOmJjd+tXp61lKDAJMc8
        kF1xm33vKmDqO9MlaadnSky3IA==
X-Google-Smtp-Source: AGHT+IFo23qlHctwNYuSs93xlQPGA1oCz5oMynSoQzr47pICWmuEFh+5o92Fz7jLKHrPH/3TRo/4eg==
X-Received: by 2002:ac2:44ac:0:b0:504:b84f:7b19 with SMTP id c12-20020ac244ac000000b00504b84f7b19mr770535lfm.20.1699619200440;
        Fri, 10 Nov 2023 04:26:40 -0800 (PST)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id f19-20020a2e9193000000b002c0055834b3sm257685ljg.4.2023.11.10.04.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 04:26:40 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.7-rc1
Date:   Fri, 10 Nov 2023 13:26:38 +0100
Message-Id: <20231110122638.21897-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.7-rc1. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 8f6f76a6a29f36d2f3e4510d0bde5046672f6924:

  Merge tag 'mm-nonmm-stable-2023-11-02-14-08' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm (2023-11-02 20:53:31 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.7-2

for you to fetch changes up to 015c9cbcf0ad709079117d27c2094a46e0eadcdb:

  mmc: sdhci-pci-gli: GL9750: Mask the replay timer timeout of AER (2023-11-07 13:08:12 +0100)

----------------------------------------------------------------
MMC core:
 - Fix broken cache-flush support for Micron eMMCs
 - Revert "mmc: core: Capture correct oemid-bits for eMMC cards"

MMC host:
 - sdhci_am654: Fix TAP value parsing for legacy speed mode
 - sdhci-pci-gli: Fix support for ASPM mode for GL9755/GL9750
 - vub300: Fix an error path in probe

----------------------------------------------------------------
Bean Huo (1):
      mmc: Add quirk MMC_QUIRK_BROKEN_CACHE_FLUSH for Micron eMMC Q2J54A

Dan Carpenter (1):
      mmc: vub300: fix an error code

Dominique Martinet (1):
      Revert "mmc: core: Capture correct oemid-bits for eMMC cards"

Nitin Yadav (1):
      mmc: sdhci_am654: fix start loop index for TAP value parsing

Victor Shih (2):
      mmc: sdhci-pci-gli: GL9755: Mask the replay timer timeout of AER
      mmc: sdhci-pci-gli: GL9750: Mask the replay timer timeout of AER

 drivers/mmc/core/block.c         |  4 +++-
 drivers/mmc/core/card.h          |  4 ++++
 drivers/mmc/core/mmc.c           | 10 +++++++---
 drivers/mmc/core/quirks.h        |  7 ++++---
 drivers/mmc/host/sdhci-pci-gli.c | 16 ++++++++++++++++
 drivers/mmc/host/sdhci_am654.c   |  2 +-
 drivers/mmc/host/vub300.c        |  1 +
 include/linux/mmc/card.h         |  2 ++
 8 files changed, 38 insertions(+), 8 deletions(-)
