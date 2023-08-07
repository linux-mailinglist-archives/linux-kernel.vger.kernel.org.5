Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A90477224B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjHGLb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbjHGLbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:31:39 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667DA3ABE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 04:28:52 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe457ec6e7so7213779e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 04:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691407684; x=1692012484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FCN3ASjgm6paKRrXP7UgHgJnVBIgMohTjb+0gbMZTcY=;
        b=WT/RnJPABirNR+dI8bW9M2e2Bt2+as9xxjdPaLiRTIJxM35FNyJxTwskuYVKDEzuIb
         weu3OEtH7C+gtDG+x5M5XZTf2a0z1O/2/D40wwbRPvpvamm7kxyUAcN+n2Vddh4NGiVZ
         MYhvu2KmBXoV3yH857L9aj9yx76Hm+WTttDAvaOotIgXLLyU5aPvbrKAqYLOCbCgbbLc
         LceuyD9Tvr4UnNAkPqiPWVRryWNRU/qMsypIlXcluy+9F4XccsG8iaiAlrKopZO9gCie
         cZew6vTueds6bShrTx5UQiV2FSY03RDrRxJt8zQPLT0+hZS0o1FRC5fWj9Qq9Sij2obP
         2Qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691407684; x=1692012484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FCN3ASjgm6paKRrXP7UgHgJnVBIgMohTjb+0gbMZTcY=;
        b=Pty1zVbqT37t/CTKrAoCmu6iwafAEIaV9vw4/OQE9TaDgcpaIO4qwXFhZkUE5hTYNx
         STXhgYjruLlbFEW1lHylTFawUCjDhZesP2MFjDqM9PZ0Nu+/V5MMXn/ODEBREdOQuxvi
         ecpkXergaExMzM2lHP0SY5Rw2TJikg4F5fvkYt9W5xQPl79zzTT92LExjicC3ToNJtxO
         n9hYYLfZS8dIRGiGFeFMhBaM+K7ZvyuUbR/CxBhWWGOQ2431iahhBVdlrNgWOWH6K63m
         An+KcbkTL0gXdFSDM0Y8iMPA/vBykhrDdRkF9A1uS3JGYhLpwTEFyulFJv1sjY+VYxoC
         QT/g==
X-Gm-Message-State: AOJu0Yy8fLypNALuR/mYup7k6wWV62LTXgnhl0JlRnaCFsRRYGAsmP0v
        obPdD3z3ErX2YGilYfK4vkdFzw==
X-Google-Smtp-Source: AGHT+IG1+2Xh0c89iavLMPnQAJeWQ0PIKd44rb33qy+ZPVMIOZsK5rUSHRY+qr1o1UGzRLFbxBd3KQ==
X-Received: by 2002:a19:5f54:0:b0:4f8:7325:bcd4 with SMTP id a20-20020a195f54000000b004f87325bcd4mr5210157lfj.0.1691407683760;
        Mon, 07 Aug 2023 04:28:03 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id z23-20020ac25df7000000b004fbddb14020sm1448083lfq.56.2023.08.07.04.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:28:03 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.5-rc6
Date:   Mon,  7 Aug 2023 13:28:02 +0200
Message-Id: <20230807112802.7032-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.5-rc6. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.5-rc1

for you to fetch changes up to 5def5c1c15bf22934ee227af85c1716762f3829f:

  mmc: sdhci-f-sdh30: Replace with sdhci_pltfm (2023-07-14 11:28:55 +0200)

----------------------------------------------------------------
MMC host:
 - moxart: Fix big-endian conversion for SCR structure
 - sdhci-f-sdh30: Replace with sdhci_pltfm to fix PM support

----------------------------------------------------------------
Kunihiko Hayashi (1):
      mmc: sdhci-f-sdh30: Replace with sdhci_pltfm

Sergei Antonov (1):
      mmc: moxart: read scr register without changing byte order

 drivers/mmc/host/moxart-mmc.c    |  8 +-----
 drivers/mmc/host/sdhci_f_sdh30.c | 60 ++++++++++++++++++----------------------
 2 files changed, 28 insertions(+), 40 deletions(-)
