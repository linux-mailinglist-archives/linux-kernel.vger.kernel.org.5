Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601C079C273
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbjILCNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbjILCNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:13:08 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BCDAC21B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 15:51:19 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-579de633419so49407017b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 15:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1694472620; x=1695077420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vyG3UChShGVJO9DWooQ063oFbpwzovAkingO0YTtxfI=;
        b=dOS14yvCh9Ft3H6rgXzID8mP/iSqN5GEajvRL52alW4KkRO4sJczp0GbHB0xSQ71uq
         n05LR66KxM7HlKTnZ4FZ4MmE3kzPrfGPweqFZ+5pcJ62sEPCwIPMFd494NmhPjFejgS/
         IEwtFHnEGWOt6hAaidDuafGaR//EHZfCmDxCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694472620; x=1695077420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyG3UChShGVJO9DWooQ063oFbpwzovAkingO0YTtxfI=;
        b=ccvSrlJd4GCJErBxHG3FdOjvV9TCUl4uYpXpDCn9QCWsd0uTJXu59tmvj+cW9s8tpp
         LyOt+/LheSY2k6YiQdDinYOw0/ci/TNUyc28sw5sWPsaJFSDlfuTYGsJgaV9cH0U5bFe
         UQBvJgib1dOpFcgsbUbwqAtQwlQfoEmcAeIReEb2AuGbFcLsdDvhXIwa5fz5/V6J64AV
         XGM6aZedl+fHtpRX2mHLDCnwAys1Qhu2HX6rSt2SmCeme+zPe/Sq9TM3ofLMXz3bm6FR
         GS8OuHXs1RC7C0Nt0JBWQNyuNXt4VkUSIVh9K52sHwtmNrp2fb0IjTXdVRAFtwtU+0Ku
         O4EQ==
X-Gm-Message-State: AOJu0YwwmKQ6qZCEPE8U+fjwT4SLrgA85DsQrD+iKNcHxCFjuN2bBHD2
        qNkA+ZxtTXraOHi1rVCuAf2VFRCmEncQW0IErK2SkC6LsrVHuw==
X-Google-Smtp-Source: AGHT+IGNNzNZoTkPqBRBvBWifr5nO33Ye5UrwbovWJsNmOlq8W6uLmJ6fD/Xbsecw0HjypP7x1zI6g==
X-Received: by 2002:aca:1a0d:0:b0:3a8:68a9:29d3 with SMTP id a13-20020aca1a0d000000b003a868a929d3mr10800812oia.19.1694471565811;
        Mon, 11 Sep 2023 15:32:45 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id l10-20020aca190a000000b003a8715d7f9esm3658017oii.19.2023.09.11.15.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 15:32:45 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
From:   "Justin M. Forbes" <jforbes@fedoraproject.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Justin M. Forbes" <jforbes@fedoraproject.org>
Subject: [PATCH] tpm: Fix typo in tpmrm class definition
Date:   Mon, 11 Sep 2023 17:32:37 -0500
Message-ID: <20230911223238.3495955-1-jforbes@fedoraproject.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d2e8071bed0be ("tpm: make all 'class' structures const")
unfortunately had a typo for the name on tpmrm.

Fixes: d2e8071bed0b ("tpm: make all 'class' structures const")
Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>
---
 drivers/char/tpm/tpm-chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 23f6f2eda84c..42b1062e33cd 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -33,7 +33,7 @@ const struct class tpm_class = {
 	.shutdown_pre = tpm_class_shutdown,
 };
 const struct class tpmrm_class = {
-	.name = "tmprm",
+	.name = "tpmrm",
 };
 dev_t tpm_devt;

-- 
2.41.0

