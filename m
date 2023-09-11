Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA9979B1D0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377601AbjIKW1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237877AbjIKNRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:17:32 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E7BEB;
        Mon, 11 Sep 2023 06:17:28 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-401bbfc05fcso49214365e9.3;
        Mon, 11 Sep 2023 06:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694438247; x=1695043047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VlerAEPk5ZbRg5PAlIL60EpQx7Cq2EyqtsP8OX4iUb0=;
        b=luLfubuqD9dno+nlaYd5BmXcLyl4KlzfBQHqFIb1DkzAAUuZAeEj8b7Q+GlGt48LB/
         X8L9xqWoaRdvGYuzqs+yMy+UtfOkVjV2vUohOteiMc7KXSIbSDxOwZqhg9eQJhl5O/vM
         w8hSVdlIm/47Qr3ZrhGqox/fHkSFdbuCXcg++yd0jLm7ZCtikGDlCWuU4c6Tiux3ETiE
         rz458p+ld32wjf3hriUjil5GnebNmzzVVlky8gjlqJI+uuShf5k/zwE9vsXZxP/C9FAn
         bRaeWhq8e33AHEumkZRrnX8YCY7IyrK2kVzdFN82QUNNt9JqxfCXRc7qc4lAUgZzRzgT
         94Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694438247; x=1695043047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VlerAEPk5ZbRg5PAlIL60EpQx7Cq2EyqtsP8OX4iUb0=;
        b=gNSD59TosZgqxJcrJtyDLLKbgsSn4JMEJ/Mmlv197LcGWrLgWqL8xxJHV71tqjYaBh
         ZCMLgVxrHJYMUotMV7ups33SZZB+yHhSJWDm4tnHgqZNI51eC28noS1vy/jQf8IMU9rg
         yxaEdkcn7lRYqetv7qPUE8sZMFtvJXzZxlKCrJ9Ekpc6hjOas3ruJVae9fh4tMzqvrLV
         23EvRO/6cMZ9L5cbr/aSeJm/R67rmdK9gb93Q/HhSDEXVuMBM7bAgTiNS3pQllEam5W2
         JzBWVnpePeDwPbYNRH/wdLD/8cOXVXBwp8SY4ZY4ijJZqWAMd9qstlEev2zTyz06NKs3
         lzCQ==
X-Gm-Message-State: AOJu0YxKLKlvgXkGh7VE+uURVdWnVBr68t/8xGLEsnR4jm7J68W2rPqP
        DWVHZnJIC0+1QqDSfMiDL5scyk8+z41tWA==
X-Google-Smtp-Source: AGHT+IEPI6QFXgxg449sbeQSA4HtBFOyu5itUrch2mlFiWIh68Lx1OCYtTJqQqRdsjLm00GVmiQudQ==
X-Received: by 2002:a1c:7912:0:b0:401:bf56:8baf with SMTP id l18-20020a1c7912000000b00401bf568bafmr7934172wme.8.1694438246711;
        Mon, 11 Sep 2023 06:17:26 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:6716:11bf:1bf:eca1])
        by smtp.gmail.com with ESMTPSA id l10-20020a1c790a000000b003fed70fb09dsm10057913wme.26.2023.09.11.06.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 06:17:26 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-renesas-soc@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2] pinctrl: renesas: pinctrl-rzg2l: Add validation of GPIO pin in rzg2l_gpio_request()
Date:   Mon, 11 Sep 2023 14:16:38 +0100
Message-Id: <20230911131638.443055-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Validate the GPIO pin request in rzg2l_gpio_request() callback using
rzg2l_validate_gpio_pin() function. This stops any accidental usage
of GPIO pins which are not supported by the SoCs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
v1->v2
* Maintained reverse christmas tree order.
* Included RB/TB tags from Claudiu.
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 37cdfe4b04f9..cc52a154d201 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -795,12 +795,18 @@ static const struct pinconf_ops rzg2l_pinctrl_confops = {
 static int rzg2l_gpio_request(struct gpio_chip *chip, unsigned int offset)
 {
 	struct rzg2l_pinctrl *pctrl = gpiochip_get_data(chip);
+	const struct pinctrl_pin_desc *pin = &pctrl->desc.pins[offset];
 	u32 port = RZG2L_PIN_ID_TO_PORT(offset);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
+	u64 *pin_data = pin->drv_data;
 	unsigned long flags;
 	u8 reg8;
 	int ret;
 
+	ret = rzg2l_validate_gpio_pin(pctrl, *pin_data, port, bit);
+	if (ret)
+		return ret;
+
 	ret = pinctrl_gpio_request(chip->base + offset);
 	if (ret)
 		return ret;
-- 
2.34.1

