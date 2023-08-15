Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FC077C455
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbjHOAOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbjHOAOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:14:12 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB54172E;
        Mon, 14 Aug 2023 17:14:11 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68843478de1so677398b3a.2;
        Mon, 14 Aug 2023 17:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692058451; x=1692663251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yl5BFlBDcW+MGrE8+Ois62MVPDM6ryT0SugwmhUr5hA=;
        b=HHN6LiExmLsPJXVPpAJmtI23OxwBJ8JHHD9Zq4K7VNYd2TkKIn+4y7J6Sd/ioCDNOl
         XAK3Qy2rVYpIfHx+GQxYtgFbxYBnbv3gtYpaMlA1DJ8Whv1MvR6XjMZ7ASGEcbWoQYZU
         ahupBrjhUGPwL1Wxv4oB5XfYPNr8EVjQDNBw3Rn9bk/6XerWWcJH0TkUXPQk5LVstlF6
         /kFtg232qw21vd2zekAQyj5617RI939V4zsXKUqE9kBXTdOmdQNCnF3OK2qFhAQOCl2+
         yymoC6dAKhEG7mvvKDU+61I3B+hmzJld8UdlXuGEOgO+vEu8EV5t5cycTByGR4jqZ06r
         QILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692058451; x=1692663251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yl5BFlBDcW+MGrE8+Ois62MVPDM6ryT0SugwmhUr5hA=;
        b=ZKcEs6Wm0Hj/brhSn7gnuZMG79XyBipOMShW6pmvrNpuHAamR8jHm3qr8foTNOqz4h
         RuJl3bVJsic4zrzXg/L/PJoE3/vQk5kMeqguTJokHseRBXNXraaQDuviF17VHhfS0AQr
         HXlpR/KnRaT7R3hR+92dXTg9BiK6KgwWV1LqBujRNs0xCcB+i6gDa0Ad9RX5uLBrolAK
         DgGaf7tYlEr3ceaaD0F4V1Kp11KP+BiRvOWI7Ej2Ss5BEK+bg4GqGmjKwwMCUzxoBeRZ
         jRNiND6zU949J4E3pqbWdKeWnhD4DZ4ecalD/qPETc4trjOAD0SrVTscNqQPUeip27C7
         knfg==
X-Gm-Message-State: AOJu0Yy+OHEvpWvDI9/s627GxAzR/ZS2rFXV4yF71QntdUH+IwYmnQHL
        z4F0+cRiOqLnSpUT/s3oC9wa2rkLJgbLnA==
X-Google-Smtp-Source: AGHT+IELdZAh4H/VbI+BgvpFRCQhs7xh/6Udx+Y0VcHJpRQgabXjgg2VHc9qGxob3Kp9w45/P+DX8Q==
X-Received: by 2002:a05:6a00:21d4:b0:686:bc23:e20a with SMTP id t20-20020a056a0021d400b00686bc23e20amr12351714pfj.21.1692058450748;
        Mon, 14 Aug 2023 17:14:10 -0700 (PDT)
Received: from alfred-laptop.ims.dom ([69.178.150.39])
        by smtp.gmail.com with ESMTPSA id s11-20020a62e70b000000b0068746ab9aebsm8686403pfh.14.2023.08.14.17.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 17:14:10 -0700 (PDT)
From:   Alfred Lee <l00g33k@gmail.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        sgarzare@redhat.com, AVKrasnov@sberdevices.ru,
        Alfred Lee <l00g33k@gmail.com>
Subject: [PATCH net v3] net: dsa: mv88e6xxx: Wait for EEPROM done before HW reset
Date:   Mon, 14 Aug 2023 17:13:23 -0700
Message-ID: <20230815001323.24739-1-l00g33k@gmail.com>
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

