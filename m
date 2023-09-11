Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8363E79C190
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 03:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbjILBUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 21:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbjILBUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 21:20:01 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6769059D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 15:39:24 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3ab244e7113so3572689b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 15:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1694471566; x=1695076366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vyG3UChShGVJO9DWooQ063oFbpwzovAkingO0YTtxfI=;
        b=HRMIuoHkXChuW/mCQPKxDRiHUsWsx4hj51j6cqR3yYGUv5PLx6KuJEArpatC6KoQcq
         jAnNat/CHB74YhMyApFrNyMXASu/Up4GjzRS1rLp5FSx0PLAY8jwlnZ9iB1kPk2TwOIj
         FimlhqOMg7Uh7XlvNDPrAyzYqeFhgiym79K1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694471566; x=1695076366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyG3UChShGVJO9DWooQ063oFbpwzovAkingO0YTtxfI=;
        b=OTvgu5Vet1P0LBV5+z5PGFW4WaGs1snRcSDz+7Eh9GZOnz3BYmUvvx79NBk7BV37vA
         Ai50QYSZysa4iZeTT9oH9CzixRHwx0eKKExF4uiuJZkV622jJp5OnH4tVfaqAqYiO1Gf
         skB1u1IWTHeYeFUy/Iek/H5RrJzQOjluDbA+Ucch49F5PY45mcOX0xQHqFqvHvT2kxZf
         I9G9rpjVKLy8VzfCXYwMDP/kiTXKL/Ucv7Lt4ajrgSHCb5tDJ994FvCHxZURV19Kx6ZT
         ri4dLk9iAVBVuvSgy/rQmEr9630hgJv57zrk/YVTAnhAqyTlxc3YqJllJdmf+mwLAa+c
         DbKw==
X-Gm-Message-State: AOJu0YzWI9GfcktLDbqrLoDigzVnr7woGEGQRX9vZ3u+C1n8gxYk0v+1
        lY+yS23PlLlgxli8gCShwXMtUA==
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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

