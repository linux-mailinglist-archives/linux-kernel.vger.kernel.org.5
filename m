Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9317B45F7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbjJAIPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbjJAIPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:15:25 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80DDD9;
        Sun,  1 Oct 2023 01:15:23 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-533cbbd0153so17263171a12.0;
        Sun, 01 Oct 2023 01:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696148122; x=1696752922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mihHJZYDvrxcQ5UWKrmIwqyKIitG/AHmGkKzI/r7wpg=;
        b=bnYj5FEgAmk1BgeiWFBgWzz/0pCHiLEN7QBq6AqkCzvWNxzGewutXHk+b6mIFZLfTr
         LGZz44xWDnvhwXw+DKacCopDhKyWrZIfGd7IsVvVIF95mAnWJ+87ZS05BCjkNdrewkBp
         mVbXCYUuo8dqtPBEH13X+jGGGeOg1VVleWAQac5MtnzUymJI7KlykcfHRREiUXBcPknv
         QYK/88BtI+SINbRra+IWKdxo4BL4kCPR9aZs7m1IQfbyQq/aqhK3WI0LMlKgF7VDbU47
         X40zHS+q+S6SME07b/bDSSRFVLeNYQcuZ1xubxeMaoswa7jSMHA9RAOBrYbWT70yc3J0
         rD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696148122; x=1696752922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mihHJZYDvrxcQ5UWKrmIwqyKIitG/AHmGkKzI/r7wpg=;
        b=R5UzYvvJhJtA1JUAGn4SraUAB11J+obDwQwJr2ZcBoXCNv8pF/uSd6jQ6oko0lYi22
         Kve0a8W3DHz2H8hDH8uriFXbYmK74/RlfvmbfkESvaA10Y0nairLfCGW9OxDkapGYTzb
         Tq5BO9nKaXQaghMPH0bDz1KX+Qm8tykBl7EJ/JXwAYIUMu870dgWk+AmvociYs9siKeL
         fvo3AKzodVB6MmJvHyUqIwHbOmBe1ohyQy2rLUrX/013xX+iTq+wkFiU1p7y7YGreMHZ
         +m11kqdJm9dAs8IfzWEpeaMzHO+Vk0t1JakWtlcWhO8tlCACtYKDIx8KFf+xtq8frsha
         JqOQ==
X-Gm-Message-State: AOJu0YyOXI4a1PigIAUhminUQbTEA6NASun+AjyyYNBgQr2mT7T9Ibj3
        Y8aCLTb2wPvFL3PUHloh4f4=
X-Google-Smtp-Source: AGHT+IHzDx2piFqqgaYdYhqPPK1NpONfc40MUoVq2Qx52/WVVBSQSKfljnsEWnkofoKKZVZeG4BZEQ==
X-Received: by 2002:a17:906:76d1:b0:9ae:729c:f651 with SMTP id q17-20020a17090676d100b009ae729cf651mr7386783ejn.17.1696148121928;
        Sun, 01 Oct 2023 01:15:21 -0700 (PDT)
Received: from primary.. ([213.139.52.198])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906374800b0099cf840527csm15121841ejc.153.2023.10.01.01.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 01:15:21 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v9 03/14] USB: typec: tps6598x: Add patch mode to tps6598x
Date:   Sun,  1 Oct 2023 04:11:23 -0400
Message-Id: <20231001081134.37101-4-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231001081134.37101-1-alkuor@gmail.com>
References: <20231001081134.37101-1-alkuor@gmail.com>
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

TPS25750 has a patch mode indicating the device requires
a configuration to get the device into operational mode

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
Changes in v9:
  - No changes
Changes in v8:
  - Revert mode check return
Changes in v7:
  - Add driver name to commit subject
Changes in v6:
  - Return current mode and check it directly
Changes in v5:
  - Incorporating tps25750 into tps6598x driver

 drivers/usb/typec/tipd/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 32420c61660d..c5bbf03cb74a 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -68,6 +68,7 @@ enum {
 	TPS_MODE_BOOT,
 	TPS_MODE_BIST,
 	TPS_MODE_DISC,
+	TPS_MODE_PTCH,
 };
 
 static const char *const modes[] = {
@@ -75,6 +76,7 @@ static const char *const modes[] = {
 	[TPS_MODE_BOOT]	= "BOOT",
 	[TPS_MODE_BIST]	= "BIST",
 	[TPS_MODE_DISC]	= "DISC",
+	[TPS_MODE_PTCH] = "PTCH",
 };
 
 /* Unrecognized commands will be replaced with "!CMD" */
@@ -595,6 +597,7 @@ static int tps6598x_check_mode(struct tps6598x *tps)
 
 	switch (match_string(modes, ARRAY_SIZE(modes), mode)) {
 	case TPS_MODE_APP:
+	case TPS_MODE_PTCH:
 		return 0;
 	case TPS_MODE_BOOT:
 		dev_warn(tps->dev, "dead-battery condition\n");
-- 
2.34.1

