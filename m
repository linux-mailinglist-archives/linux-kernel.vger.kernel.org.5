Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF8D788AD4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245727AbjHYOHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343505AbjHYOG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:06:57 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DFF2D50
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:30 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68c3b9f8333so17784b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1692972376; x=1693577176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/vUdqwdRYBAdAyAf4qgMbXsZ4Ix9El+5T23vOVq68bQ=;
        b=B7WhlnWTRQaL35hB6/MjGpm34XkPQ5kdSXFSqwv1QHYZtvJoDbOGHyZRXdJA3E1xBy
         GSZ+7YPPSH655WdcMcsOY5AKAZgOSnRewe2n9McgeewOR83CrVFX4/jCkK2EJ4TIBGjy
         qRcRLzAakHt9eoKAxs+PZiT+7NGTp4WQzYfWrzVG0cDCTZFVu/9NtkStymTNeOMKzXZ5
         MNqRDppgU5+ZtJBrxabY9Lqk/jdamkHvhl4m5+/VgnaLce/AxK5fRne0WYSZCTRu8zpS
         j6XTIsUN9ItKEKirB9c+wCTn/hM0fc9lAsgblNeA6LY416JuCIbElDPAAcc8wWUFgKh3
         JmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692972376; x=1693577176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/vUdqwdRYBAdAyAf4qgMbXsZ4Ix9El+5T23vOVq68bQ=;
        b=EnYWe3pUC5JubO7Ndc4zCOTX0ufXC2TLrn5Iw/hAvlwegdHcQupIJU7tN83WlD8PRJ
         ArMZai+X+R+COpmjWVEt0eiOZaZ38MmqySrNJrri5u7/ZhfRXue9ri/x2flh+ZMH3Uri
         gmEeJr1wrhCYqV9fToZqfI1lUvfmjhOYNLDr1c8IncSeYkLLGU7ksFgc/Im433Bgwz7r
         ZWgB/9xxz2AaDT3OVrc0BqjtVy/7L3Qjg9RxpbDP42KdMU4WWVhcQ+s6HdjuFBEdGUJi
         SKNvpT2YgchKbVjgpCe3Y2ph/xFD4z+3tgnGTnlH4QVWuLP57FPkoN1m+iv19MicOOFJ
         gltQ==
X-Gm-Message-State: AOJu0YxMJ1I5LT1vWh4FI3Q7VvghRqezdTHke+gtm+QCa3c1XpjBoV/G
        RMpqBv71CuBQdtNv5b6Jgp06vKeln3d07VdqfOe/Ioz6
X-Google-Smtp-Source: AGHT+IFKJQf2nnVuRdrG02X9VWtIhK0vBTk9y+4MLMWwcn5k15IpNoQYCkL5TzyWiHENlsk0PMxRPw==
X-Received: by 2002:a05:6a20:938a:b0:140:d536:d434 with SMTP id x10-20020a056a20938a00b00140d536d434mr28945743pzh.10.1692972376004;
        Fri, 25 Aug 2023 07:06:16 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id v23-20020a62a517000000b006870721fcc5sm1628232pfm.175.2023.08.25.07.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 07:06:15 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v4 00/16] Staging: rtl8192e: Rename struct rx_ts_record references
Date:   Fri, 25 Aug 2023 07:08:31 -0700
Message-ID: <20230825140847.501113-1-tdavies@darkphysics.net>
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

