Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6AE780841
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359078AbjHRJ32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359087AbjHRJ3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:29:21 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C752E30C5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 02:29:19 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9cdba1228so10857461fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 02:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692350958; x=1692955758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pe6dUrFf2OfRIze9u6TiWKYUZqpOSPeSgcea4E9pAH8=;
        b=HcV4CGUqJf+tkyUDdlqSRPJ//Tt6+qta265+7O+KsSD4apqVlf/G3swEE3+9K/5lpa
         q33ilqddz9zpfy/7CJyHqPx1xAWaxYoigj+hqynMgLzzb3XW9dP6FFct1EFIOMdjjZgO
         EsP+gUkvbQ5Fs2lDBw7dg8C/dRmatpSs4zf9xBWxHWBZevhgUf4JH7cFX9sfISpYRJao
         NbVTdttNyLfqAWRJzSW7eD1KLGku4f5eM6FtO9mftV7NlsyXuJa23i1jqixOzEI3eHE8
         4f0aPm92MvmZaWZj+FvrQh4g+Aa8KzHYDxHDLeatnDeZSiZjU30ZUuvwp0OmnoEq5C+C
         vorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692350958; x=1692955758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pe6dUrFf2OfRIze9u6TiWKYUZqpOSPeSgcea4E9pAH8=;
        b=B1x3EgCyfyfCLo+ThIFCrEOQNbUyHhQeTtaA+Z8+P0BiEGzfE2pY6AL4wb2FOR2lHW
         eiItI+HVVyUKKgg9tY9uzrEbW96AgHurdVZJ9Bp2z11TiTcn6rNdUjzCU9i5nxHPe3NZ
         Oh7re3ic9fYqY8QkMbGGP03yuMQhMCyj6ZAovjKn5JXMaJuK8NAZuAknRNSY3t/1Gnei
         CBHgorkBC1g8nan8j+JrRCTEsLYQDpEkWIb4Un784P0DNWnGvkeNVKNjg5Tg/zAQLowu
         pDmIHcsNZ2/bGarHU/ATOW71WbntrPqflYrG3kn3b9GUuW6LRIeGzObryjwLnve5gzNr
         8XIA==
X-Gm-Message-State: AOJu0Yx7T0WiJNH98H1ZZs6QYaKwH7+8lxfF6dgQRTK/in5rp7M8TPOt
        rooSwvyg3wMfHQrtLKCjcJ1oKg==
X-Google-Smtp-Source: AGHT+IGovJeuyXXZM0SAAt+XnpR6ZkzwKHmLu3sqae8E8VhNrzYrIWkUAVTMWyFKYbISCtCzDHpAHA==
X-Received: by 2002:a2e:9d55:0:b0:2b6:e96c:5414 with SMTP id y21-20020a2e9d55000000b002b6e96c5414mr1215354ljj.52.1692350958052;
        Fri, 18 Aug 2023 02:29:18 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id p17-20020a2e9ad1000000b002bbacc6c523sm333546ljj.49.2023.08.18.02.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 02:29:17 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.5-rc7
Date:   Fri, 18 Aug 2023 11:29:16 +0200
Message-Id: <20230818092916.38330-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.5-rc7. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 5def5c1c15bf22934ee227af85c1716762f3829f:

  mmc: sdhci-f-sdh30: Replace with sdhci_pltfm (2023-07-14 11:28:55 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.5-rc1-2

for you to fetch changes up to 58abdd80b93b09023ca03007b608685c41e3a289:

  mmc: f-sdh30: fix order of function calls in sdhci_f_sdh30_remove (2023-08-15 13:24:29 +0200)

----------------------------------------------------------------
MMC core:
 - Fix in_flight[issue_type] value error to properly manage requests

MMC host:
 - wbsd: Fix double free in the probe error path
 - sunplus: Fix error path in probe
 - sdhci_f_sdh30: Fix order of function calls in sdhci_f_sdh30_remove

----------------------------------------------------------------
Harshit Mogalapalli (1):
      mmc: sunplus: Fix error handling in spmmc_drv_probe()

Wei Chen (1):
      mmc: sunplus: fix return value check of mmc_add_host()

Yang Yingliang (1):
      mmc: wbsd: fix double mmc_free_host() in wbsd_init()

Yangtao Li (1):
      mmc: f-sdh30: fix order of function calls in sdhci_f_sdh30_remove

Yibin Ding (1):
      mmc: block: Fix in_flight[issue_type] value error

 drivers/mmc/core/block.c         |  7 ++++---
 drivers/mmc/host/sdhci_f_sdh30.c | 11 +++++++----
 drivers/mmc/host/sunplus-mmc.c   | 26 +++++++++++++-------------
 drivers/mmc/host/wbsd.c          |  2 --
 4 files changed, 24 insertions(+), 22 deletions(-)
