Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456D27A63C3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjISMv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjISMvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:51:23 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02079E3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:51:16 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-770ef334b4fso249965785a.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695127875; x=1695732675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EzfxQdXla0PknaJGcF18mFftRNpFMZC6735h+HuTWrQ=;
        b=DGnFIhpRnZVYCF5MnBEyMz1pgbHC+qiPae2JMDSnrNl9+8i76Jzaqrjb9xMx5yyTEc
         j+lVblKP5MjA2ZlbmUpk+OS1y3gPfOUjaQe9Up7cd51w2m6q2Iqx0CVp/2/IqmyLnQqw
         2s5Jf4wo+A/cDzYiMb0654qZrUXr1Eb/qxid63qU4I1lNYtIukMpwP2dDAGsYi4nnCRI
         51iBfwAtfi8r2SOQAuHsan8ItZphU6Uiu7y7WSFjNSg6oP1DeZPmYVaGeJuowLXALVNk
         C7sDzgWLy9J2HXxjuDVpr/M9WMQXpoChv3yjNnrymfwdUe+iChqKIOam8fQLesN9atek
         XYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695127875; x=1695732675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EzfxQdXla0PknaJGcF18mFftRNpFMZC6735h+HuTWrQ=;
        b=BXVvslBi7oMLCeZn8quYFKxzfAEzdfwh2Gy7lGPe9nEYbpW9A8M6S96G5UyXuE1NAB
         QL8pgmHE/cWn+sUw5DdEhqskyAN3PD2GPJ36dQvUaAL8vwvQZ8dhYHSa24E3ujWMbvk4
         44YsRwohnF0dj0h6zdUC1KnNQ6p3qjXPtl27R4xTKjPpZnLy9YciiCLms1hCVDtJU83P
         C9K9F4yo7Zb6tRE555L+1UFWL8H7KwnSIbWn2IgINdJ8Uzp74inipAZ412nTGpqgP/1w
         kWjliENBGNzRlaDTmnDSD9JeGXVbS7nr3kEDP6qqulB9L5Rz5eDINY9pnaSXHcRKJLch
         JKgg==
X-Gm-Message-State: AOJu0Yz2UGa1o5tV7SLtQGNS3nS0F/HIxlttVCuKfCY6Cay82KyHyGyW
        9/RLwTtFupM7ou8ZVKQDrBucSskY9XmWJw==
X-Google-Smtp-Source: AGHT+IFyJyG0RDrT5otqhjeWZBTvAR7xF8M/r8Qpg65I95NA2PM08v0gr7EZLAAA0r6G7ybyMhT20w==
X-Received: by 2002:a05:620a:46a9:b0:76e:e66c:92f8 with SMTP id bq41-20020a05620a46a900b0076ee66c92f8mr3259115qkb.8.1695127875288;
        Tue, 19 Sep 2023 05:51:15 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id y7-20020a37e307000000b007676f3859fasm3936508qki.30.2023.09.19.05.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 05:51:14 -0700 (PDT)
From:   Trevor Woerner <twoerner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/1] ARM: defconfig: cleanup orphaned CONFIGs
Date:   Tue, 19 Sep 2023 08:51:10 -0400
Message-ID: <20230919125112.15515-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.41.0.327.gaa9166bcc0ba
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop CONFIG_ options from defconfigs whose code has been removed.

v4:
Re-submit the ARM patch (alone) with a better subject line and CC'ing the
correct people to help ensure it gets picked up. v4 drops the patches for
mips, powerpc, and loongarch which have already been applied.

v3:
While reorganizing the patches, I put the wrong commit message with the
CONFIG_IP_NF_TARGET_CLUSTERIP option.

v2:
Generate arch-specific patches. In v1 I organized the patches by
CONFIG_ option which caused some of the patches to cross architectural
lines. This requires cross-arch consensus before they can be applied.
Therefore organize the changes by architecture so each one can apply them
independently (or not).

Trevor Woerner (1):
  ARM: defconfig: cleanup orphaned CONFIGs

 arch/arm/configs/keystone_defconfig  | 1 -
 arch/arm/configs/multi_v7_defconfig  | 1 -
 arch/arm/configs/omap2plus_defconfig | 8 --------
 3 files changed, 10 deletions(-)

-- 
2.41.0.327.gaa9166bcc0ba

