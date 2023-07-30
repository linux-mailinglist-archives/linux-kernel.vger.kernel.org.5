Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676F9768470
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 10:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjG3I1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 04:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjG3I1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 04:27:21 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CE710FF
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 01:27:20 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99b9421aaebso498700566b.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 01:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690705638; x=1691310438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AgkTGVmy1yK5uMTDHx23HyiSp5u5RN5VGXGJ2S44BGA=;
        b=D7A36QooQwlrSjyHBvTrdd1IRlPRuW3OyVBUIm+XLZwGMWi7IvLuNyCHB9ZfyyEJnq
         EOSIdhckzo9JB4SSYNoFITfpdPsqTMknm5pc5rNjyMJ/xsanss25Y5Ik+YvZ34dgLpp3
         ETrHXvlUFCtYnkTIC5HJ6nUpI06WLhQydOy8IcJYbck5yfou/dt8xwXlbEkoIdte3pM2
         t+3yMdNn3XGpRVc+3gAFVX0xTDe+jPDmHjzZMQq92tsb1DFJfXSoznV5HPNNejxgj5+V
         8FE20oVS/C/VbQvamu5396ak17TnoHmpvib2htQcOpdu8OV+4re7K9e/1ii/K7Sj9/Y8
         4BAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690705638; x=1691310438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AgkTGVmy1yK5uMTDHx23HyiSp5u5RN5VGXGJ2S44BGA=;
        b=DdJwGSN8D1V/8ilEjPLM3u3Yq0HLNhaSvLJWJxbl359uNPJT+lO0pTnVDPIsUcNRe8
         pm9lPXcY/kJ+z+ZNw3WH519P/NHixA80u1/+55p1obeW1YZVVN2orP/rMdziy4N5ujgh
         iuxpIMvyu1GH9u3WUVqqgyjG22/UmcPHF0+DCnAJVEJhWkIjq/FfkdkU5RelFs6gSQbB
         ph3tFenQshyy8SG0XSSr5KrxQopEzPXRag0jzRxgtaxML5LMBFtaqI5jJhCHROTiMCZo
         +uvD1OFQYUUHsTYnZJr7fxec7eLboCQTck7zO/ldsU05IKoQyxPrE41MgHTL1eGJjPRn
         wCGA==
X-Gm-Message-State: ABy/qLZI2XwY8rs6/3pHlaLGcYK/4Q17etjuTmrdGuWYVDr751sNdliI
        wCqKui3hFww1Ul7+hYwZad0W6nYB3Yrjlw==
X-Google-Smtp-Source: APBJJlEIVYcMyCNO2KnNQSXGP+fSbMHARvp0rLNvnGCrM8tnuh2RyaZk/CI6oGCvi/bq551+X3PfdA==
X-Received: by 2002:a17:907:2c5b:b0:99b:ce19:b69a with SMTP id hf27-20020a1709072c5b00b0099bce19b69amr3502474ejc.53.1690705638346;
        Sun, 30 Jul 2023 01:27:18 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id l25-20020a170906415900b0099297782aa9sm4322851ejk.49.2023.07.30.01.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 01:27:17 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Nam Cao <namcaov@gmail.com>
Subject: [PATCH 0/3] riscv: kprobes: simulate some instructions
Date:   Sun, 30 Jul 2023 10:27:06 +0200
Message-Id: <cover.1690704360.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simulate some currently rejected instructions. Still to be simulated are:
    - c.jal
    - c.ebreak

Nam Cao (3):
  riscv: kprobes: simulate c.j instruction
  riscv: kprobes: simulate c.jr and c.jalr instructions
  riscv: kprobes: simulate c.beqz and c.bnez

 arch/riscv/kernel/probes/decode-insn.c   |  11 +-
 arch/riscv/kernel/probes/simulate-insn.c | 105 +++++++++
 arch/riscv/kernel/probes/simulate-insn.h |   5 +
 drivers/test_kprobe/Makefile             |   3 +
 drivers/test_kprobe/test_kprobe.c        | 265 +++++++++++++++++++++++
 5 files changed, 384 insertions(+), 5 deletions(-)
 create mode 100644 drivers/test_kprobe/Makefile
 create mode 100644 drivers/test_kprobe/test_kprobe.c

-- 
2.34.1

