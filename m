Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DB77A9139
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 05:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjIUDVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 23:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjIUDVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 23:21:31 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D69F4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 20:21:25 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68fcb4dc8a9so413961b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 20:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1695266485; x=1695871285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qhhsMMDhQSZIy566QGTwti8rilWTQdvE2G3gWQD5Qks=;
        b=JcBUeO+dqpflWIbA1aVoCMCKtRtWO4vJWaGol4UN2eXo21gsTAcsUKfi1mvaDnQ+O/
         OrnqqpUbwiwGBphIJ0KNwKwUfCus6DS2NITvULPr83y69weUoYiOGsfkgJvVgxSq5eUJ
         VIMxVyZbhrdBH42SyU4WFj1nnMIAIBX9NAMJNNsVgrvlh5OiAB1kapBM43vRf6GGulbT
         rUMMCFVXhxkKTLF4l22lV1fFAyViIbD9E9bMcGyqs2teBL0xeyL0YNFwioXAYNc69AiH
         +175ImA9HqagpQzf6mQXHTNtwXAlhjHgdJDXs8iubfxZ3fuPZnJMxcRcTcTbrr7e+9yV
         8dUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695266485; x=1695871285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhhsMMDhQSZIy566QGTwti8rilWTQdvE2G3gWQD5Qks=;
        b=I6+FSev2S59uzWKC/EXF7+RgU8ASw2v8Wjwbfx85YUJ6H7fZkDdNzGy/+KxvSd4Xuq
         UWNjKVXxnaMIKEyRXGlrik8KoAm7e1lvojhTtC31ykXm0JV71o/85mksAoTeFnSSTtRk
         QyjJytRix8od1ntMN3JY44CyDroPYd1B/ixwBcvTyBf1u7nCtl/dNvlcuBa+DeNpPLvz
         XoCU5FchZ14w7X5/QGfiQwBlwwIbqj7olTB0nluVtwrlUwQN1gqYZzcmJLcjXafh4vUS
         BRjhPW5IFAJCy1q9CIp8nuBXlz5M1vp15YA8ncT+fxW4m/YNNBWqH42v6FnK+7tTQ+wk
         3KHQ==
X-Gm-Message-State: AOJu0Yya/NN2PaYZSX9oOquIbm1a3we7bx5hyAkszopayYBmPXJEZTsH
        KwSTI2Ra6kwR1asE47vk2hj9ig==
X-Google-Smtp-Source: AGHT+IGGT/F8gUARgyincCxZ2iNYBJvBvEjQ22OUCDRfBrm/wh9EI+6L84NqgYuwEmURClbgfJC01w==
X-Received: by 2002:a05:6a00:9a0:b0:690:d413:ee0f with SMTP id u32-20020a056a0009a000b00690d413ee0fmr5388825pfg.2.1695266485075;
        Wed, 20 Sep 2023 20:21:25 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id p14-20020a62ab0e000000b0068e49cb1692sm237324pff.1.2023.09.20.20.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 20:21:24 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 00/11] Staging: rtl8192e: Function and Variable rename series
Date:   Wed, 20 Sep 2023 20:25:04 -0700
Message-ID: <20230921032515.96152-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes 11 checkpatch Avoid Camelcase issues throughout the 
driver.

Thank you in advance to reviewers
Tree

Tree Davies (11):
  Staging: rtl8192e: Rename variable Time
  Staging: rtl8192e: Rename variable pAdmittedBa
  Staging: rtl8192e: Rename variable pPendingBa
  Staging: rtl8192e: Rename variable Dst
  Staging: rtl8192e: Rename variable pPendingBA
  Staging: rtl8192e: Rename variable Addr
  Staging: rtl8192e: Rename variable pStatusCode
  Staging: rtl8192e: Rename variable Policy
  Staging: rtl8192e: Rename function GetTs()
  Staging: rtl8192e: Rename function TSInitialize
  Staging: rtl8192e: Rename variable StatusCode

 drivers/staging/rtl8192e/rtl819x_BAProc.c | 74 +++++++++++------------
 drivers/staging/rtl8192e/rtl819x_TS.h     |  2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 36 +++++------
 drivers/staging/rtl8192e/rtllib.h         |  8 +--
 drivers/staging/rtl8192e/rtllib_module.c  |  2 +-
 drivers/staging/rtl8192e/rtllib_rx.c      |  4 +-
 drivers/staging/rtl8192e/rtllib_tx.c      |  4 +-
 7 files changed, 65 insertions(+), 65 deletions(-)

-- 
2.39.2

