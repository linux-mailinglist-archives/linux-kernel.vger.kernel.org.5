Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C91779B54
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbjHKX2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 19:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjHKX2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:28:38 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591D4E73;
        Fri, 11 Aug 2023 16:28:38 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-686f94328a4so1778420b3a.0;
        Fri, 11 Aug 2023 16:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691796517; x=1692401317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GIUVmdz9W0Mk0KL3ySNSKHOwbP4OMB5UpbBAsVR/MHc=;
        b=QGu0Y4QYv/KtY+FsXH65da5iFOVTnuOXCTscn4O/V9pKhKd8Zg9v3M0UXPqFo9yf3P
         UPwmeWds5Qm6147gCAxpBgenEaYe6cfLGYtfG0hwN3OVgfdKZsPoHv+vM41rHtNZu2xi
         y0GnVCJtE49F6GkakQ0po0zyH6hIQ8vsnd3pHQU9ppo5j3GIsAiEamgH2OEK6BHQU9sQ
         C1J0PT1R2spSCPMrzNr/rUvF/QZ1amGKLot/uhuXa20h3qk48mpUn76D4u5eQVii28Gw
         7ALBM3T6ABjJptUm/r41sPcuHTFvf/gqm7cpHZRSnETl1m7zTTm8hSuXA9iqb3z3oOh8
         9uUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691796517; x=1692401317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GIUVmdz9W0Mk0KL3ySNSKHOwbP4OMB5UpbBAsVR/MHc=;
        b=ZsYb3hxQHHx/4n7l9YDnLPSTQ4ZiD7hgUdcssiZp0SkDVuAGH4tGlC0xsKWeCgOqJZ
         HKqxxMtahsQE+6ch7gzQPR4wZ4Sn7E7bchlCSyVDQB4xcXR+/f5jIsjsLjfYkabWxEqx
         vsH5BAIKyzqlGs7r1sop4StIGPvjsSOq1Li8gRBXjAV1Sa+eVZZnG6WWUjy38fpBKg29
         6lv6yf4DJiFlc/J9bN7/CvTcMJstz7HM1UmMdkn47W33wsyK7mB62ORJOBpVFphEJQt5
         empQiTLlskD0ZIvDAIu6ikXkniYOgQ/YwZ+dADyDdVA/3XSqn8HXm77YIm78JU++C5Zy
         DQbg==
X-Gm-Message-State: AOJu0Yxc37kexpaBt0ZJlgOJkRB7+iv54f11yG2J6EALKAj4wdfjemko
        ukE0JaxB6wj+WNPoDHafiYYeJHB902YcCA==
X-Google-Smtp-Source: AGHT+IEH/DRyJl4tSzZ8eR8WY2kdjF70nklx0LAjELtz4lubhb+zFNwCm053tNkiksFUG6/yWjyoyA==
X-Received: by 2002:a05:6a20:258e:b0:140:3775:308e with SMTP id k14-20020a056a20258e00b001403775308emr4370843pzd.0.1691796517618;
        Fri, 11 Aug 2023 16:28:37 -0700 (PDT)
Received: from alfred-laptop.ims.dom ([69.178.150.39])
        by smtp.gmail.com with ESMTPSA id 17-20020aa79251000000b0064d47cd116esm3817422pfp.161.2023.08.11.16.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 16:28:37 -0700 (PDT)
From:   Alfred Lee <l00g33k@gmail.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        sgarzare@redhat.com, AVKrasnov@sberdevices.ru,
        Alfred Lee <l00g33k@gmail.com>
Subject: [PATCH v2 net] net: dsa: mv88e6xxx: Wait for EEPROM done before HW reset
Date:   Fri, 11 Aug 2023 16:28:32 -0700
Message-ID: <20230811232832.24321-1-l00g33k@gmail.com>
X-Mailer: git-send-email 2.41.0
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

If the switch is reset during active EEPROM transactions, as in
just after an SoC reset after power up, the I2C bus transaction
may be cut short leaving the EEPROM internal I2C state machine
in the wrong state.  When the switch is reset again, the bad
state machine state may result in data being read from the wrong
memory location causing the switch to enter unexpect mode
rendering it inoperational.

Fixes: 8abbffd27ced ("net: dsa: mv88e6xxx: Wait for EEPROM done after HW reset")
Signed-off-by: Alfred Lee <l00g33k@gmail.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index c7d51a539451..7af2f08a62f1 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3034,6 +3034,14 @@ static void mv88e6xxx_hardware_reset(struct mv88e6xxx_chip *chip)
 
 	/* If there is a GPIO connected to the reset pin, toggle it */
 	if (gpiod) {
+		/* If the switch has just been reset and not yet completed
+		 * loading EEPROM, the reset may interrupt the I2C transaction
+		 * mid-byte, causing the first EEPROM read after the reset
+		 * from the wrong location resulting in the switch booting
+		 * to wrong mode and inoperable.
+		 */
+		mv88e6xxx_g1_wait_eeprom_done(chip);
+
 		gpiod_set_value_cansleep(gpiod, 1);
 		usleep_range(10000, 20000);
 		gpiod_set_value_cansleep(gpiod, 0);
-- 
2.41.0
