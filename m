Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B38977D5C6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 00:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239244AbjHOWFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 18:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238927AbjHOWFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 18:05:11 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01101FEE;
        Tue, 15 Aug 2023 15:05:10 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68876bbecb6so541648b3a.1;
        Tue, 15 Aug 2023 15:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692137110; x=1692741910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BXDgZz/jD99DkFlDIZATLGB9OwsRpjApl9oFam7+RBM=;
        b=NABu+fOXGolFOl05xJvxflbrGDf4BfnAalAnL/Zj3Tja1rGyhViSJWl3Ua+H6sMnjI
         l3ROf0gtB8wv8LYxucMJ80Qkzda9S6yAvvm9xq9xgUu6GYyuLJ7U1WY7vVA+Qc6oJyOb
         i9K6CW0h0QG/pKXAwLFkLSCru48dTLyWy+iVW3HJDvpTYdDb26GfGPXiqBHKhUNKCEav
         TmDHp0/mDiLIRwvF2rbaWRHpsxL4brs9Vk4RWXOA2YpmhB1T7YraYceYKx6PeO5fwGnu
         a5vGP2L7iBQWY0Jv/quK4bJ5aVTJMIANro8/Xd7m0OIODYTLQRmtdGgoBD7k9r+O7YV7
         mbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692137110; x=1692741910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BXDgZz/jD99DkFlDIZATLGB9OwsRpjApl9oFam7+RBM=;
        b=UQeCWHGqpfC8Dla0hc92zobAtG3R+Bq9qNA6bHxDLnUerj3TVTbQgdq3rWUh9YexcW
         jxcv9Ei0igwnLPgu6EyJx0KToArie8wWqmxbulz1lyvoGpmNSfOOB5enXJjb1kMdSfsY
         Y3fT4v8xCE1Ubu89ee5vbmX7o19YNyke9LeWxGIJwXGJHVVoB5+79ofqDwhjNccD1oE3
         AEcTtICRjyFLCBXrkNGgx10s3fqzOZvJR8VJWjhT+BeKqNYKNDymMK/acTETnRXY3QpR
         4d2GCP1BDsHq7egA16xcnNArAIks8RykxqCN7I9bbm9fNntFKZmRcObuNTgO+ATiz4SM
         eX0w==
X-Gm-Message-State: AOJu0YwMc9IGrQhVUXk96KY5PLwN9O0z23+fDWHRdHz5vK0s4t4wRMHw
        ZRMedAKZ+9IItrCSb1Xw5uId1ucXKMLXOg==
X-Google-Smtp-Source: AGHT+IFAUPzAIN1iwipUTillakAMnN4+pit5sww25RmKstJJXGb/BJjZL0LNPIqmhS2qS7743vjR6A==
X-Received: by 2002:a17:903:2595:b0:1b8:9f6a:39de with SMTP id jb21-20020a170903259500b001b89f6a39demr116374plb.65.1692137110009;
        Tue, 15 Aug 2023 15:05:10 -0700 (PDT)
Received: from alfred-laptop.ims.dom ([69.178.150.39])
        by smtp.gmail.com with ESMTPSA id n12-20020a170903110c00b001bb97e51ad5sm11520355plh.99.2023.08.15.15.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 15:05:09 -0700 (PDT)
From:   Alfred Lee <l00g33k@gmail.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        sgarzare@redhat.com, AVKrasnov@sberdevices.ru,
        Alfred Lee <l00g33k@gmail.com>
Subject: [PATCH net v4] net: dsa: mv88e6xxx: Wait for EEPROM done before HW reset
Date:   Tue, 15 Aug 2023 15:04:52 -0700
Message-ID: <20230815220453.32035-1-l00g33k@gmail.com>
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
memory location causing the switch to enter unexpected mode
rendering it inoperational.

Fixes: a3dcb3e7e70c ("net: dsa: mv88e6xxx: Wait for EEPROM done after HW reset")
Signed-off-by: Alfred Lee <l00g33k@gmail.com>
---
v2: moved Signed-off-by to the last line
v3: used correct sha1sum for the Fixes: commit; changed to 'unexpected mode'
v4: added submission history
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

