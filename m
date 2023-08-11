Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9249779B4D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbjHKXXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 19:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbjHKXXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:23:38 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588301736;
        Fri, 11 Aug 2023 16:23:33 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686f19b6dd2so1900759b3a.2;
        Fri, 11 Aug 2023 16:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691796212; x=1692401012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xCGub4yUdKZFD9WM9TtKFKsNg2bW2F2AATXkBlBNwKw=;
        b=X767ZYlcbS3EoQOJvTBekfZYqrHzEKhMOQ7+NkI7u1wNqgq6mYWZr0rLqZ9lMQ5glH
         5xoaWtVApDyAPVO990O5TjGb/4WRTWRXFyuOBJPZNvzxLJQKsLUQ3EGvNfTG8alaIcue
         aVesSk00V6etTnLOjX6n1u7sdFd0P2imr2rpaPrO6662BiEL6oa/zYLCd7eAeUYROX1Q
         jHn43hs/cGyThOHj4PiKxvJBOXKUnhJZocInIhLycRTV/Xtn1ypFPIhjJRvRlVZ73WOS
         pflo4XlFULs/Q21kP8HWs5IAKHQG1rzu3060IBay7NoMF/CKMC/fynvVwCdbeAr2Eccp
         OgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691796212; x=1692401012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xCGub4yUdKZFD9WM9TtKFKsNg2bW2F2AATXkBlBNwKw=;
        b=jDm9dvubJ0tdIPDKuCadMEBjH59/KuMBPrY2YBuz4LYqKFdQxXRZqSvb4+UXQWvMY6
         SAYYf7TJ8kSsyk/E28YpdPf6R3UBkZ2nfOKriCwfZ7TK5SaoUoydLLtFnzSXXzxqIozv
         6Aco80rB1j5Jl8m6xnPX5dLzIKpU65IY/t4qMJHewpBHLYvHRq5aGog/iheap1Lzw2rB
         U6e+7yXgEdF9E6B/+gh1ijPNPDpDWbcjvwN2V3Y1m3GJUyJvtW+1br4i1C/l/enZfNkK
         IYykjX5W16u2ZZQX+NusDJlGZgrlyDooukESIfZ7hFSvTGnUQtpJHNB6G3ysQmI12+cL
         GbuA==
X-Gm-Message-State: AOJu0YzZqhADRBOvSfugkJVQzmLk/490GDlVw7fxIiiaSq3rA0/4Hv1q
        6HBnyuZEGzBzXZnCn8OMS2NqUBgU+AUzGQ==
X-Google-Smtp-Source: AGHT+IHc/gqCKWrqmIHCkkoYU/RsCEbJfRsLYdn8n0M4apAwOxW1PMYtpzlQpYaeLdKQKiSNSpAz2A==
X-Received: by 2002:a05:6a20:12c7:b0:13b:a2c9:922e with SMTP id v7-20020a056a2012c700b0013ba2c9922emr3873337pzg.27.1691796212580;
        Fri, 11 Aug 2023 16:23:32 -0700 (PDT)
Received: from alfred-laptop.ims.dom ([69.178.150.39])
        by smtp.gmail.com with ESMTPSA id c10-20020aa781ca000000b006828e49c04csm3855525pfn.75.2023.08.11.16.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 16:23:32 -0700 (PDT)
From:   Alfred Lee <l00g33k@gmail.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        sgarzare@redhat.com, AVKrasnov@sberdevices.ru,
        Alfred Lee <l00g33k@gmail.com>
Subject: [PATCH net] net: dsa: mv88e6xxx: Wait for EEPROM done before HW reset
Date:   Fri, 11 Aug 2023 16:23:10 -0700
Message-ID: <20230811232310.21124-1-l00g33k@gmail.com>
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

Signed-off-by: Alfred Lee <l00g33k@gmail.com>
Fixes: 8abbffd27ced ("net: dsa: mv88e6xxx: Wait for EEPROM done after HW reset")
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
