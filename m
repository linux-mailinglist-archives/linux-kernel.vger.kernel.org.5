Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560187EB16D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjKNOBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjKNOBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:01:20 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F308130
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:01:17 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cc330e8f58so41351785ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699970477; x=1700575277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LPaXAqYY/yDcBKqyxlX4UqgDs4pXQVFVUpt4WE1cEdQ=;
        b=K11E/GwMXoc24xNBsB4XGIMr3g69OLdSq2HuBtEuWLi8v8/8s46cG2nRoq3sYkjrVJ
         1blRpMsgnRqx222SHNbxj0HG2gyJ7IC1qMrvCa2U8ZPMge7YSbKnZbnekk/vFqz38FlI
         mWT0PKJ3z3IZdGs0IYLl5vvTWoyXvJnD3g4+s3ACRMJraksMSvBdgHba22kVPgT535jT
         b8bn3y9syu+keRnjbis7SmVI5PDoBkXB5gZgqmo6rzVcymaURgVfMrM/hZow30o4ZgwG
         6dTU7u6OZMCt/l+Ik4bytB3Z9UD7TyfPgYWA8Ygj4lz3retGvLX5vmAxt5q/wLIevjJe
         Rqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699970477; x=1700575277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPaXAqYY/yDcBKqyxlX4UqgDs4pXQVFVUpt4WE1cEdQ=;
        b=LCu4Gm7Ed62CZASGtLerLMgxugMmVkNbEimE6YMNH/YWOQr0u5Jwxlh4L/5JrebS5G
         x++24G9YO7wMWWzu7wbQ3Cn+iVDt4eytQyJ537W6Fhokt5UZauZmuYDIXeHA7W896YJ+
         08skLpfzxW+d5x74jwUBWAw6qR6aWJVAMITRawE5NhZjkC9K9EpOQ7UEuI1vTzr6GcQH
         GPbSSvMDeTMDRjx0rrXgVI08unhmGB+h/vAthcWgx0FytBku7VYGWmUzvGW8CQx9tfnU
         aGbUY/2Rr4AfDdO39mHd+c4muu8psbySv6AUsqS8vwojkA4sc4pJnUvBzuTocc10CF/3
         Mzeg==
X-Gm-Message-State: AOJu0YwB1jgAntC5TXCBpy+EP7tkgwmPPVyMN9LyiwKJAdaUjImia/F3
        l/om90otlPD9X2I5k8+M7I8=
X-Google-Smtp-Source: AGHT+IEoHhyrD/xuzw14KbeXzPEVZjc1R4xA1mhgyGBfGzYY6Y9jBHpZuSq+LvdRsFrMDvr7dsHpjg==
X-Received: by 2002:a17:902:ce0f:b0:1cc:7a8e:606b with SMTP id k15-20020a170902ce0f00b001cc7a8e606bmr3017314plg.43.1699970476774;
        Tue, 14 Nov 2023 06:01:16 -0800 (PST)
Received: from toolbox.iitism.net ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902c1c500b001cc31dcec49sm5654521plc.146.2023.11.14.06.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 06:01:15 -0800 (PST)
From:   Ayush Singh <ayushdevel1325@gmail.com>
To:     greybus-dev@lists.linaro.org
Cc:     Ayush Singh <ayushdevel1325@gmail.com>, johan@kernel.org,
        elder@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        kernel test robot <yujie.liu@intel.com>
Subject: [PATCH] greybus: gb-beagleplay: fix restricted __le16 degrades to integer warning
Date:   Tue, 14 Nov 2023 19:31:02 +0530
Message-ID: <20231114140103.784484-1-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

greybus message header->size are of type __le16, so to fix this warnings
we are using le16_to_cpu() macros.

Reported-by: kernel test robot <yujie.liu@intel.com>
Closes: https://lore.kernel.org/r/202311072329.Xogj7hGW-lkp@intel.com/
Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
---
 drivers/greybus/gb-beagleplay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/greybus/gb-beagleplay.c b/drivers/greybus/gb-beagleplay.c
index 43318c1993ba..b3f47b5cbbfa 100644
--- a/drivers/greybus/gb-beagleplay.c
+++ b/drivers/greybus/gb-beagleplay.c
@@ -344,7 +344,7 @@ static int gb_message_send(struct gb_host_device *hd, u16 cport, struct gb_messa
 	dev_dbg(&hd->dev, "Sending greybus message with Operation %u, Type: %X on Cport %u",
 		msg->header->operation_id, msg->header->type, cport);
 
-	if (msg->header->size > RX_HDLC_PAYLOAD)
+	if (le16_to_cpu(msg->header->size) > RX_HDLC_PAYLOAD)
 		return dev_err_probe(&hd->dev, -E2BIG, "Greybus message too big");
 
 	memcpy(msg->header->pad, &cport, sizeof(cport));
-- 
2.41.0

