Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD0E7F98BA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 06:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjK0FgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 00:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjK0FgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 00:36:09 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431E0B5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:36:16 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cfabcbda7bso13494095ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1701063376; x=1701668176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AFU0GLwo+k9SYd7xhvDwdolRC+g7PfQjKlM2ZWM6J4A=;
        b=K9WuX6tPxW+gtmi4B1hOxN/PVOcLqTMf9CrTEDWM0Mk8wFy5sCPpxko016dgccmddI
         dozLHkjg5cuQkKmzKq9c8PBxowZTVtyqdUY5sHvn2fDcL/9Fm+96VdHQovv+4f5I/uGg
         CLN6LDstAgt5BTNhp/ypUK2uPAfFPhMY9bWpcMRYDh2MOH/g9mofnQSwdEYLA5AWIbRO
         5avwURxXhga6n3EW5EKH3QWITNp4VUv1p+bwGsAUPnHxrDwXbxIrt+6RgpMEukGX34wu
         TVoB5+3ZCoTdlhxXVhzhoSPuS+LVqv+bZnTNOFlYdCKrt2FfQJai735yW4nXivyTQJH5
         8iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701063376; x=1701668176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFU0GLwo+k9SYd7xhvDwdolRC+g7PfQjKlM2ZWM6J4A=;
        b=FbVeYFp+zFdzsMjBctbqQXYvdEedZDADwjq3LVLBAXKgFSi1DPVVHTUCfSvvciAXsu
         SjbZGqvch5jWGWff2CfVEiz4SudU5CjHWZ2kHj9yOlteMMGXoI8P/X7GdQhdT5n9n/rC
         Dth+02l3qHY2LP2mzdMnddA9VphvlucImQwsou5MMx2IoxVA+mtg/c47rabSavBR8A0F
         HVXB07zvTgh0BS95GlMwXDTUGAtlEqsTI3QJqPbR577pXH84rplHYKqd+u9BUQ7uf4nR
         YTB7M+rFdH6Z+cCoS4MFgIL0sV7UJQj/FiW02wubFC3OZkg73z/zyZ3jncfPu0XSUNkZ
         Hnrw==
X-Gm-Message-State: AOJu0YwmX7cr3shGqUB0qAK+Nr/CZihg/mJ9QweO7YbnWaBaGmJhcKUG
        8EoibYuQBI2t8K2EImTShtFIS2het4MThe3qfbM=
X-Google-Smtp-Source: AGHT+IEFOyrbmnp7bIhJ3IP23QwPEQsOt25ZXE9QHgMwmG9UQfY3KA3eqlvwwBcaYv6AIBT9jssIig==
X-Received: by 2002:a17:903:4d4:b0:1cf:636f:1bf8 with SMTP id jm20-20020a17090304d400b001cf636f1bf8mr15914236plb.24.1701063375758;
        Sun, 26 Nov 2023 21:36:15 -0800 (PST)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902ed0600b001cc3875e658sm7300465pld.303.2023.11.26.21.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 21:36:15 -0800 (PST)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 00/15] Staging: rtl8192e: Rename CamelCase vars
Date:   Sun, 26 Nov 2023 21:42:50 -0800
Message-ID: <20231127054305.148276-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Series renames 15 variables to fix checkpatch warnings.

Thank you in advance to reviewers
~Tree

Tree Davies (15):
  Staging: rtl8192e: Rename variable pTxTs
  Staging: rtl8192e: Rename variable BAReq
  Staging: rtl8192e: Rename variable Delba
  Staging: rtl8192e: Rename variable TSpec
  Staging: rtl8192e: Rename variable TxAdmittedBARecord
  Staging: rtl8192e: Rename variable TxPendingBARecord
  Staging: rtl8192e: Rename variable pDialogToken
  Staging: rtl8192e: Rename variable pTsCommonInfo
  Staging: rtl8192e: Rename variable TxCurSeq
  Staging: rtl8192e: Rename variable TsAddBaTimer
  Staging: rtl8192e: Rename variable DelbaParamSet
  Staging: rtl8192e: Rename variable pBaParamSet
  Staging: rtl8192e: Rename variable pBaTimeoutVal
  Staging: rtl8192e: Rename variable pAdmittedBA
  Staging: rtl8192e: Rename variable TsCommonInfo

 drivers/staging/rtl8192e/rtl819x_BAProc.c | 178 +++++++++++-----------
 drivers/staging/rtl8192e/rtl819x_TS.h     |  12 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c |  56 +++----
 drivers/staging/rtl8192e/rtllib.h         |   2 +-
 drivers/staging/rtl8192e/rtllib_tx.c      |  22 +--
 5 files changed, 135 insertions(+), 135 deletions(-)

-- 
2.39.2

