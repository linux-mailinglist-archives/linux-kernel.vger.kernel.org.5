Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347AC773029
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 22:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjHGULg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 16:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjHGULe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 16:11:34 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FBEE79;
        Mon,  7 Aug 2023 13:11:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3159d5e409dso3608514f8f.0;
        Mon, 07 Aug 2023 13:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691439092; x=1692043892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NIgW417nJ8bvxbhi642SzRPDY1ezzoM514sPszH49a4=;
        b=CuPKy1nJHxILhIX3BO+881Vpy4e85JkXhpbjPqnCKMsbU0INPblIFXRLvyfsda/BRP
         HrWs2ZhbTWu9xBJ3BiKLu1tx7v9d7B9p8+HAzZ9HOpMYOb5t1Y7Uo+3aeP499EnTUBHz
         cPKCRLIzbUSBM9zwh/BVJ1Go1yQUdisPyMVIYKQNV0edqmeuLB/kv56c0jmCMZrU9aWn
         s4Lnj66DMnzfu/bHfHlbfzL52nThIgx11BJH1OtEb2gic8lbi7OOO8CNvEWkLK5Yb+D2
         kkxr07uYzom0ikfG0wIQk1f+I0sV102u8ahMrXlAatsJKd+s6GXGfrjc1Os0a9lavJ6n
         x9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691439092; x=1692043892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NIgW417nJ8bvxbhi642SzRPDY1ezzoM514sPszH49a4=;
        b=aH+29uFUquqfoXbRDbFnRs/jMajbtLWaDdkro0hY7ag7RRIL4219WMCapgCGSz2sfz
         Dh3fvAPM//cYD9n+uU0/K0ESuv9W8T6zh7147+SxaTZs0AO6pCr8hlgz1L9tYT1DgNhw
         4dTok56QjcNJdTJkQsGeSXphDQBRRILkRUYcE5H4GzetLb6ghY55KBKhcznt1Y3EjiBK
         SgQhV+ImlwqPBwElrEObe1RHuO4NMaRHJ3wFGEOwCFwU1xB1vy5LEDiTsG+4qQX2UrmH
         ZGfDSnMVDKk4SZ9sdNbDeQbhWS8a8v42ZnPSApWkYHnLZ2KBmKZGSbk5MikgYwW4OlBw
         amnA==
X-Gm-Message-State: AOJu0Yw2TD2FNYHP8Qr2JfH2tWXSLes5G4FEW0816D4cSqVYmKNQEXM6
        uSQaFZ1q4nxvzbxXUy8poBYox27n593YFHpU
X-Google-Smtp-Source: AGHT+IEfihewtMi1wwv4EExS6KMmD7EL5dbu05lTOoKn2ydQ+El3PbhdWggCr7EhI/1h8r+u3bpJrA==
X-Received: by 2002:adf:fcc4:0:b0:314:3369:df57 with SMTP id f4-20020adffcc4000000b003143369df57mr6034932wrs.5.1691439091633;
        Mon, 07 Aug 2023 13:11:31 -0700 (PDT)
Received: from mmaatuq-HP-Laptop-15-dy2xxx.. ([2001:8f8:1163:15aa:2e0a:61a:af68:b30])
        by smtp.gmail.com with ESMTPSA id l26-20020a1c791a000000b003fe4548188bsm11572566wme.48.2023.08.07.13.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 13:11:31 -0700 (PDT)
From:   Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
To:     jirislaby@kernel.org, mickflemm@gmail.com, mcgrof@kernel.org,
        kvalo@kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
Subject: [PATCH] ath5k: fix WARNING opportunity for swap.
Date:   Tue,  8 Aug 2023 00:10:57 +0400
Message-Id: <20230807201057.340371-1-mahmoudmatook.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
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

coccinielle reported the following:
./drivers/net/wireless/ath/ath5k/phy.c:1573:25-26: WARNING opportunity for swap()

Signed-off-by: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
---
 drivers/net/wireless/ath/ath5k/phy.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath5k/phy.c b/drivers/net/wireless/ath/ath5k/phy.c
index 5797ef9c73d7..f87eb684f223 100644
--- a/drivers/net/wireless/ath/ath5k/phy.c
+++ b/drivers/net/wireless/ath/ath5k/phy.c
@@ -1562,16 +1562,13 @@ static s16
 ath5k_hw_get_median_noise_floor(struct ath5k_hw *ah)
 {
 	s16 sort[ATH5K_NF_CAL_HIST_MAX];
-	s16 tmp;
 	int i, j;
 
 	memcpy(sort, ah->ah_nfcal_hist.nfval, sizeof(sort));
 	for (i = 0; i < ATH5K_NF_CAL_HIST_MAX - 1; i++) {
 		for (j = 1; j < ATH5K_NF_CAL_HIST_MAX - i; j++) {
 			if (sort[j] > sort[j - 1]) {
-				tmp = sort[j];
-				sort[j] = sort[j - 1];
-				sort[j - 1] = tmp;
+				swap(sort[j], sort[j - 1]);
 			}
 		}
 	}
-- 
2.34.1

