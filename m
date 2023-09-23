Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8E07ABE84
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 09:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjIWHlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 03:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjIWHkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 03:40:55 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3BF1B3;
        Sat, 23 Sep 2023 00:40:48 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50317080342so5595594e87.2;
        Sat, 23 Sep 2023 00:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695454847; x=1696059647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIRa+aj4f6v9xT4/WGZX0P0iihhQsW2AVKNBUDiG5uU=;
        b=MYYpMPRZiVoeBElScU4kKrpREl/FqOginl6g4pK6qKf7bfJuatcSp8MPBhGwFoP2V7
         AgB0PQhMD5kxqq+z/eT/wIW2JrOFlOBsTXgolyKIdmixI2GaOjJo/6uBcb6K5fweT/ph
         61H+zvszAZE2/u5gBDjC2jFVTKYLVPCeaCclMaPmpfEhgZcY5IDozNkDH4ZOKHn7+G8R
         HvIOtFWCltyBTHUBaoiYU2d+J+IDrG/pihzHF+oxVyXQlKWFnFiq8EasdIalsQHEOOat
         wAwF9MLxB7rmfKdDzihqRVyEP1nnQgSTIoYGy9spx1LaZu5jWKLsCstS254iUMjdemFN
         7stQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695454847; x=1696059647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fIRa+aj4f6v9xT4/WGZX0P0iihhQsW2AVKNBUDiG5uU=;
        b=F4kqxuW1Xqkd4nsfl7MuHzQcmVBlCVa0mRMEUrRBaooiqLIIf2G2Chfd7XV1+KVPVU
         EPOokPxnRz+YFOoCRYTfB41DYVANKgKxqZTL82uF13BpmwKmfaf3uiooeIF1nmbuWnTT
         3Q4hBuQGy/5LO6G2riOXQkaoX1mdeeYuEcjd+e5mqfXBv/mepUHFKgF9kse66T72SJlQ
         Z3foPGT3a7G6Kf8K1Syi6mhD8xXhWw7E4rw0+LRkiJezHG7ldboGmsNMBbWVHQ/O7yzb
         A6Mo3WU8rUYV+LHwTKcg9I3P8l2XJGBpCAzNreQIFwAaTWuPrPO21UbrNsW6R1R2rXuJ
         BmMg==
X-Gm-Message-State: AOJu0YzYxeHcAjGJF13nBIsZGZFoPSbNFbXVAKWxd7Wpi1/MaGHl0BFs
        eiRvU8y70dSdkmHJAKwX+Jo=
X-Google-Smtp-Source: AGHT+IFZEMv+OrEW83oTB7YFL30QbrLTi43vUxTPzpEsnZKPaMFURgPZ97v4FnOEvg4leQDkNyOCNg==
X-Received: by 2002:a19:6506:0:b0:503:1bb0:a658 with SMTP id z6-20020a196506000000b005031bb0a658mr1092532lfb.32.1695454846430;
        Sat, 23 Sep 2023 00:40:46 -0700 (PDT)
Received: from primary.. ([213.139.62.222])
        by smtp.gmail.com with ESMTPSA id k6-20020adfe3c6000000b003196e992567sm6236955wrm.115.2023.09.23.00.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 00:40:46 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, conor+dt@kernel.org,
        ryan.eleceng@gmail.com, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v6 07/14] USB: typec: Apply patch again after power resume
Date:   Sat, 23 Sep 2023 03:39:52 -0400
Message-Id: <20230923073959.86660-8-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230923073959.86660-1-alkuor@gmail.com>
References: <20230923073959.86660-1-alkuor@gmail.com>
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

From: Abdel Alkuor <abdelalkuor@geotab.com>

TPS25750 PD controller might be powered off externally at power suspend,
after resuming PD controller power back, apply the patch again.

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
Changes in v6:
  - Check tps25750 using is_compatiable device node
Changes in v5:
  - Incorporating tps25750 into tps6598x driver

 drivers/usb/typec/tipd/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 148b237d0df5..d77481f78100 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -1192,6 +1192,18 @@ static int __maybe_unused tps6598x_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct tps6598x *tps = i2c_get_clientdata(client);
+	struct device_node *np = client->dev.of_node;
+	int ret;
+
+	ret = tps6598x_check_mode(tps);
+	if (ret < 0)
+		return ret;
+
+	if (of_device_is_compatible(np, "ti,tps25750") && ret == TPS_MODE_PTCH) {
+		ret = tps25750_apply_patch(tps);
+		if (ret)
+			return ret;
+	}
 
 	if (tps->wakeup) {
 		disable_irq_wake(client->irq);
-- 
2.34.1

