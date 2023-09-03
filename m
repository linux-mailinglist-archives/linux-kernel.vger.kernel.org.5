Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C1E790C59
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 16:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbjICOJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 10:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjICOJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 10:09:27 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F647F2
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 07:09:23 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4ff9b389677so986560e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 07:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693750161; x=1694354961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AALeIaiiugA/l8EFRK5HkASlp0QQvRxkOCyJ73bcZ4M=;
        b=XdSTZcuVe3/CaxIbSEK3VGgUYUg+oP71QlGKBkNvhx0fFbK2U1fB1OXljjS3ICszRx
         BXVKo0+k9pJZB746XIKyY62ZSrzGmB5aZ8wHes8dE/fW86U+9FxteimcZXldT/WCRXp9
         RXsTVjm5gMSreuW9xBKja0oDPC5SHt2LRzSfgX1IE/A24EcgCcqX5JjCHDPB3j8s4HJe
         9xUtUuoePTIFgkZGZi51W/wwliEyM98+e20c3IOyx6QtI6E0Dr9DvpxeHo9+NIlNa59N
         9NQRmtGVvQyLFK8fmXHCdt1cXt14yea/idPYY7PWQJuSYZe1qNakXUNLkl6p/d2eRtDF
         X6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693750161; x=1694354961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AALeIaiiugA/l8EFRK5HkASlp0QQvRxkOCyJ73bcZ4M=;
        b=RoLXVPzDJZfnRvAqyC3m4iovF1uRAn2h6lmF4t1v5MTO33wx+Jiww3pXvJusZaS2Gq
         a5xAayVov1deNHrKGiTJBkK399jRBaYrbFgelOpwHT+vCpZUa/pPFZ9SSsDiVVOA4YF9
         bUXMoYM/jMsOAPe75DFDFvi9Twkwec9UfyJtvqqxUyomqzu9VGBNKBDri1hKYuUvLagJ
         GUv043pCFD/BQfproTQxi+CEtMHs3mA6JNM03Y0i1scAEVDMcMJULIb3AlJkDNhSRUNs
         HDDH+/dRJ93csWl/FlCoZM6whZi5Xyz8sd8kI5+lBNzkxDzC21VDqRxUtdX4f6VY5jtE
         sI2Q==
X-Gm-Message-State: AOJu0Yzls/d1RMvzQv301UHfrNcliAxL0EowFMyqzr+IlFiN2mJfXw7W
        y5AaCxu0MG8ICVyNfIiQac0=
X-Google-Smtp-Source: AGHT+IG3iDVr+bwDU+PL99hfbuiHt0zCiHIQWUcrjXsJ5KxrLrcR+/Y2Ex+c4EakkXcwlh8smdZPcA==
X-Received: by 2002:a19:504e:0:b0:500:b7ed:105a with SMTP id z14-20020a19504e000000b00500b7ed105amr4902785lfj.29.1693750161061;
        Sun, 03 Sep 2023 07:09:21 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id b25-20020a056512025900b004fbb69d8791sm1275305lfo.79.2023.09.03.07.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 07:09:20 -0700 (PDT)
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH] staging: vme_user: Add missing '*' in multiline comments
Date:   Sun,  3 Sep 2023 16:06:17 +0200
Message-Id: <20230903140617.567850-1-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch resolves a warning reported by checkpatch where multiline
block comments should use '*' on intermediate lines in order to adhere
to the Linux kernel coding-style guidelines.

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/vme_user/vme_fake.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index 7c53a8a7b79b..90aaf650524d 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -1010,8 +1010,8 @@ static void fake_free_consistent(struct device *parent, size_t size,
 {
 	kfree(vaddr);
 /*
-	dma_free_coherent(parent, size, vaddr, dma);
-*/
+ *	dma_free_coherent(parent, size, vaddr, dma);
+ */
 }
 
 /*
-- 
2.34.1

