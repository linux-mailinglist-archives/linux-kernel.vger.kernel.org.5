Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3117C7A66
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 01:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443104AbjJLX3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 19:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443090AbjJLX3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 19:29:20 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C10BE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 16:29:18 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b26a3163acso77502b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 16:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697153358; x=1697758158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ox7ZzV5ESrBmEIpsae5SvW22xhGmgMakXbrbQy8MZic=;
        b=k5TfqDmdkDIQ5mAKW0nVX4UOmmCAniJRGbSdfSP09zoZ7k39a3gJLqAWSUCTRwez1M
         bkzzOcKY9/GfPLrqTt1qWe6FIuKx/54YQeO2k1SbbILD5OFcEoJkYVMRxItlY6d06umc
         KH6asZJRsraRKaFQfSKbKfOs6dFzlwkRQOoRA6kkaMY48ZfseVO5BZvEq31vHwfQdqDV
         hbfsuVErHwmhV71XU7vzGo98FPw1tcj+8cRo7pcyDIU+WT/jSTOvGcaR4CEfVEm7YA5t
         LYi8PsfNF5pSygAL9kVObkc0pfoRxUOI/L1HrZmk1rDJ9VU7lgGerO4kqzNnabgNh6O8
         1cIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697153358; x=1697758158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ox7ZzV5ESrBmEIpsae5SvW22xhGmgMakXbrbQy8MZic=;
        b=wg2+pyNN9oTZC+m3mnCvAvKb+CE0Yg4nhHI/Nd4S0YjNoga5K5JH5ZjruEAX4ISXrd
         +KKFxRiY9iZ6mRFj+iXTkZT+gwjeTAIwea8IcFcshclpaD6Xwr5xylm/qwwar54uvytc
         40kNjRvJJ+/Qyo/dcv4wbUt8k9/PmtWizddbtPReyvkb5WYX0Xf4mCStByoPVqNhSUYB
         XAOWz0waOtDEaEVlNY76tGj6FE3zB8+bmMNqQOLv9gWL9/BtS+ADZ58h6enYx3uBdsUn
         /tzdR1lMUWbPmXFpZIXGeqlESud4klnV16L7N3WDLqjLwauMOb0bA8kGok+7hwFp5kpy
         e1Ww==
X-Gm-Message-State: AOJu0YwLkj7N5jVXpJwiwvUFLgMwEM7DWnNTN8tdN9RUIQ8DO718+kJO
        gZIEbUY6Y0alXL+yQmwgJCTfBgPII9bdrw==
X-Google-Smtp-Source: AGHT+IH6Fe/H6t0yDaS87yU66xTqEIVg1VfGPCa+mpPs4pHNgVILOzirnJiNqIaMO68eXqsoYWZQrA==
X-Received: by 2002:a05:6a21:6d9b:b0:158:1387:6a95 with SMTP id wl27-20020a056a216d9b00b0015813876a95mr28303215pzb.19.1697153358401;
        Thu, 12 Oct 2023 16:29:18 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id cm24-20020a17090afa1800b0026f919ff9a1sm2377359pjb.10.2023.10.12.16.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 16:29:18 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Micky Ching <micky_ching@realsil.com.cn>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Soumya Negi <soumya.negi97@gmail.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH v2 1/2] staging: rts5208: Refactor macros to static inline functions
Date:   Thu, 12 Oct 2023 16:29:05 -0700
Message-ID: <c7431fe4d7f72138d8dc86269794f87c30d21a38.1697152251.git.soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697152251.git.soumya.negi97@gmail.com>
References: <cover.1697152251.git.soumya.negi97@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver rts5208 uses macros to read/write data & to perform generic PCI
functions. Rewrite these macros as static inline functions in the header
file.

Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
---
Note: The macros wait_timeout_x() & wait_timeout() have not been redfined as
functions because they pass defined hex constants as arguments(hence can't be 
type-checked).

 drivers/staging/rts5208/rtsx.h | 59 +++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx.h b/drivers/staging/rts5208/rtsx.h
index 2e101da83220..ea29646b8c38 100644
--- a/drivers/staging/rts5208/rtsx.h
+++ b/drivers/staging/rts5208/rtsx.h
@@ -39,25 +39,6 @@
 /*
  * macros for easy use
  */
-#define rtsx_writel(chip, reg, value) \
-	iowrite32(value, (chip)->rtsx->remap_addr + reg)
-#define rtsx_readl(chip, reg) \
-	ioread32((chip)->rtsx->remap_addr + reg)
-#define rtsx_writew(chip, reg, value) \
-	iowrite16(value, (chip)->rtsx->remap_addr + reg)
-#define rtsx_readw(chip, reg) \
-	ioread16((chip)->rtsx->remap_addr + reg)
-#define rtsx_writeb(chip, reg, value) \
-	iowrite8(value, (chip)->rtsx->remap_addr + reg)
-#define rtsx_readb(chip, reg) \
-	ioread8((chip)->rtsx->remap_addr + reg)
-
-#define rtsx_read_config_byte(chip, where, val) \
-	pci_read_config_byte((chip)->rtsx->pci, where, val)
-
-#define rtsx_write_config_byte(chip, where, val) \
-	pci_write_config_byte((chip)->rtsx->pci, where, val)
-
 #define wait_timeout_x(task_state, msecs)	\
 do {						\
 	set_current_state((task_state));	\
@@ -147,4 +128,44 @@ enum xfer_buf_dir	{TO_XFER_BUF, FROM_XFER_BUF};
 #include "rtsx_sys.h"
 #include "general.h"
 
+static inline void rtsx_writel(struct rtsx_chip *chip, u32 reg, u32 value)
+{
+	iowrite32(value, chip->rtsx->remap_addr + reg);
+}
+
+static inline u32 rtsx_readl(struct rtsx_chip *chip, u32 reg)
+{
+	return ioread32(chip->rtsx->remap_addr + reg);
+}
+
+static inline void rtsx_writew(struct rtsx_chip *chip, u32 reg, u16 value)
+{
+	iowrite16(value, chip->rtsx->remap_addr + reg);
+}
+
+static inline u16 rtsx_readw(struct rtsx_chip *chip, u32 reg)
+{
+	return ioread16(chip->rtsx->remap_addr + reg);
+}
+
+static inline void rtsx_writeb(struct rtsx_chip *chip, u32 reg, u8 value)
+{
+	iowrite8(value, chip->rtsx->remap_addr + reg);
+}
+
+static inline u8 rtsx_readb(struct rtsx_chip *chip, u32 reg)
+{
+	return ioread8((chip)->rtsx->remap_addr + reg);
+}
+
+static inline int rtsx_read_config_byte(struct rtsx_chip *chip, int where, u8 *val)
+{
+	return pci_read_config_byte(chip->rtsx->pci, where, val);
+}
+
+static inline int rtsx_write_config_byte(struct rtsx_chip *chip, int where, u8 val)
+{
+	return pci_write_config_byte(chip->rtsx->pci, where, val);
+}
+
 #endif  /* __REALTEK_RTSX_H */
-- 
2.42.0

