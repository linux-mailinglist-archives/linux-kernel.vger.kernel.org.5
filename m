Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0386781BE3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 03:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjHTA6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjHTA6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:58:18 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCA07C9D7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 17:45:18 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bf092a16c9so17550145ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 17:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1692492317; x=1693097117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cy9tL7xMtgr5rVitcjMBMNisMnaBX+7pR4GgJ1PYIOU=;
        b=Cw0uIKb0MNYLcqso+FPfo2hQhFNylDxC3nsnf/sjaDv0emXWNXHf0jsY3BAoFYg6lR
         IS1+ng2LYUa+9h8gcCR/cm5TEu+DKSkZhw0PenUcwei2EXOzm7f6RuuA2vaNxTlgvDq4
         tmTyaq7iwIMxryZILjMri62sNAJ5XfVNcxm4HoqiRCIAIY62bGTr55M2gza/8+5Zo54t
         1Tu4HCsH4S6ODwpYiy3AYIjAuu+iRxS3J6yB0Ob1v6qm9lK38hMulF1jppfyjFP1Y2jX
         U3XIwUWypoDp85t7nn5rLvw3qXwzcPMHmrVs0r2iuXR43iYsJBTLTb0eKqzg5uxKJSHs
         zxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692492317; x=1693097117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cy9tL7xMtgr5rVitcjMBMNisMnaBX+7pR4GgJ1PYIOU=;
        b=XX6WgcrY5DrSXEXnWkrM3UgEomS2mPB35JtUFt8Vb6H8IKkcxjLAN2y3Wly7AJRJL+
         34w399UHVLAN5OhMkYg5Esq1tfy4n4VEtRTRh3rxTmiD9FnTSee6nwjb8AxBkiYoFGUV
         q7fmGiEk7ktzJG7pxvVzCaF4IkvHvbjffJabT50WhTywXLFAruipdp9bD+ur49igKjC3
         3YSsl4l+kEKV9ldPfaXikmRdNbBZZG/P6v2NXqJ5RC3VvoaqmlSaHlqUQBukQJz2rqN6
         btMjzpwYC4khYr2Z7trW9hmALu68Q7aegahcgEA4I71bThbeFcQimuW1DkQwfw5Y4FDO
         Hlsw==
X-Gm-Message-State: AOJu0YzD29Bmf9rdZps6ioR7MhpXjsKcQ2etLGOUchbAphAvhTGBG8Qo
        WDjSCWGgsiL6wgpMDOFPZoTDdoDhK3GL/Q3IZYNl+Gtp
X-Google-Smtp-Source: AGHT+IEZw2DwUAps9XfkD4SvOzR2dtbsZ9J8FQkJyKuTjIrU3EP6W4uMuQ0djIi9dcREfcW1Hqy7Tw==
X-Received: by 2002:a17:90a:744b:b0:26d:227c:9068 with SMTP id o11-20020a17090a744b00b0026d227c9068mr2765065pjk.16.1692492317571;
        Sat, 19 Aug 2023 17:45:17 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a1a1900b00268b439a0cbsm4004884pjk.23.2023.08.19.17.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 17:45:17 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 00/16] Staging: rtl8192e: Rename struct rx_ts_record references
Date:   Sat, 19 Aug 2023 17:47:28 -0700
Message-ID: <20230820004744.278022-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of this series is to fix checkpatch warning Avoid CamelCase,
for all references of struct rx_ts_record. In most cases renames the
references to, ts, to make the naming consistent.

The first 8 patches have been sent before, and versioned appropriately.

Thank you in advance to the reviewers,
~ Tree

Tree Davies (16):
  Staging: rtl8192e: Rename variable pRxTs in function rx_ts_delete_ba()
  Staging: rtl8192e: Rename variable pTS in function
    rtllib_rx_ADDBAReq()
  Staging: rtl8192e: Rename variable pRxTs in function rtllib_rx_DELBA()
  Staging: rtl8192e: Rename variable pRxTs in function
    rtllib_ts_init_del_ba()
  Staging: rtl8192e: Rename variable pRxTs in function
    rtllib_rx_ba_inact_timeout()
  Staging: rtl8192e: Rename variable pRxTs in function
    RxPktPendingTimeout()
  Staging: rtl8192e: Rename variable pTS in function ResetRxTsEntry()
  Staging: rtl8192e: Rename variable pRxTS in function TSInitialize()
  Staging: rtl8192e: Rename variable tmp in function GetTs()
  Staging: rtl8192e: Rename variable pRxTS in function RemoveTsEntry()
  Staging: rtl8192e: Rename variable pTS in function prototype
    rtllib_FlushRxTsPendingPkts()
  Staging: rtl8192e: Rename variable pTS in function AddReorderEntry()
  Staging: rtl8192e: Rename variable pTS in function
    rtllib_FlushRxTsPendingPkts()
  Staging: rtl8192e: Rename variable pTS in function
    RxReorderIndicatePacket()
  Staging: rtl8192e: Rename variable pRxTS in function
    rtllib_rx_check_duplicate()
  Staging: rtl8192e: Rename variable pTS in function
    rtllib_rx_InfraAdhoc()

 drivers/staging/rtl8192e/rtl819x_BAProc.c | 36 ++++-----
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 73 +++++++++---------
 drivers/staging/rtl8192e/rtllib.h         |  2 +-
 drivers/staging/rtl8192e/rtllib_rx.c      | 94 +++++++++++------------
 4 files changed, 102 insertions(+), 103 deletions(-)

-- 
2.41.0

