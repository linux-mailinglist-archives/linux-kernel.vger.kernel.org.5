Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8467713FE
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 10:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjHFIhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 04:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjHFIho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 04:37:44 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6D1B6;
        Sun,  6 Aug 2023 01:37:43 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686e0213c0bso2426690b3a.1;
        Sun, 06 Aug 2023 01:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691311062; x=1691915862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrXeSpeuC2gzyt9qidPdox3/pGaSYVOC+06MEHE1kmY=;
        b=Sid+cRv5QSaZv2yiPAGIe4aA5sfxdLEKyJut3NxHgecR9aFIIFK0ScTSoNpm6xHJ2J
         jU8wFmClv/+9QVIg8gGimu6fyiJ3CVCuBtZiJkUqymQf+NC741HMSOREmjjHjNnHqz+7
         JTOUg+HqY4AXScDeuaapY6Gmp8naFY2kVnSlHmicjmTRAm8BlnOcgBGm0aBi8Bt6ZzCY
         8nfRAKO1IvAa3PHpqFOBqO/IQi0klSo8Q4JRdu2s8eG3cuPtnewgRAGMnV8DVqRNJY8K
         soCWgtwEe9Bx0yBefOP25VzZQUUUy9dOy/ZbQEaTlGZQv4nIX5bfYwFBlo8l/A9KBqLL
         +WJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691311062; x=1691915862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrXeSpeuC2gzyt9qidPdox3/pGaSYVOC+06MEHE1kmY=;
        b=jdHYZfxkaQRdV56tky4rmjapqzXfuWmhyP7Wihc3LzZsxWYIouKLgCpPAU4LUIVj85
         UTeNrUHHjYZlS8vYlo/iXIyj5kUfDmpZ/QNBtyyBo4VjJTx8hOcPC/7aXWmZzbitTXPr
         HgZAsIgtbxh0oyQcHAPyjCYZgP3hdZcESnREbY+UTHcHnOaymKjcKZ1sCv8XjgNPdVW2
         U3giZZOnplgUriH5Xe7JEmzAMdlDWN9CojitPKzMPDmJLnsxxDnNZzNQJLuJFqyF0Zn8
         /aP64Ne4G+dLzf+9z4BigqRnBBofzD1OwPUuRgsA+QfeAwQPgBVRsQH/99vlFnm/d7eZ
         C5ew==
X-Gm-Message-State: AOJu0YxPzrcp2LGowUD9YUcPrE0m8lRAdq1i6+1xFUZcy60k5p8CCCCP
        7mTg19jEoq5Hf6b5NwfIeR/3F3WY4Ek=
X-Google-Smtp-Source: AGHT+IGM4oSRmmUW0Z++Auu5+buRXa+u6jRhZiPyievtJTnhUDlx+820nSRqttFP5I8MNcofc3+ZoQ==
X-Received: by 2002:a17:90b:224e:b0:267:f9c4:c0a8 with SMTP id hk14-20020a17090b224e00b00267f9c4c0a8mr5031102pjb.4.1691311062614;
        Sun, 06 Aug 2023 01:37:42 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:1028:5dc5:7c0a:52e1:6b87:38ef])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090a64c400b0026307fa0442sm6580403pjm.49.2023.08.06.01.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 01:37:42 -0700 (PDT)
From:   coolrrsh@gmail.com
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Rajeshwar R Shinde <coolrrsh@gmail.com>
Subject: [PATCH v3] spi: spi-mpc52xx-psc: Fix an unsigned comparison that can never be negative 
Date:   Sun,  6 Aug 2023 14:07:34 +0530
Message-Id: <20230806083734.7685-2-coolrrsh@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230806083734.7685-1-coolrrsh@gmail.com>
References: <20230806083734.7685-1-coolrrsh@gmail.com>
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

From: Rajeshwar R Shinde <coolrrsh@gmail.com>

In struct mpc52xx_psc_spi, the variable 'irq' is declared as an unsigned int.
The comparison of variable 'irq'  with signed int operand is incorrect. Also,
the return value from the call to platform_get_irq(pdev,0) is int and it is 
assigned to an unsigned int variable 'irq', thus redeclaring the type of
variable 'irq' to signed int.

This fixes warning such as:
drivers/spi/spi-mpc52xx-psc.c:332:5-13:
WARNING: Unsigned expression compared with zero: mps -> irq < 0

---
 drivers/spi/spi-mpc52xx-psc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mpc52xx-psc.c b/drivers/spi/spi-mpc52xx-psc.c
index 9a1a080fb..795c08594 100644
--- a/drivers/spi/spi-mpc52xx-psc.c
+++ b/drivers/spi/spi-mpc52xx-psc.c
@@ -29,7 +29,7 @@ struct mpc52xx_psc_spi {
 	/* driver internal data */
 	struct mpc52xx_psc __iomem *psc;
 	struct mpc52xx_psc_fifo __iomem *fifo;
-	unsigned int irq;
+	int irq;
 	u8 bits_per_word;
 
 	struct completion done;
-- 
2.25.1

