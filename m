Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEEC7584EE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 20:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjGRSj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 14:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjGRSjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:39:24 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C9AF0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 11:39:23 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so10907a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 11:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689705562; x=1692297562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jkb55HhAbN5nQxp124JO5CgyYp5FwsBzn/8eguMNO/I=;
        b=vo5NZKlbXQn4Jl6b8UAEOHnqb04wgASw6MkQZM+pF3hTs01Y0VzlGrVz8NYsDNXcPB
         smn7BGtYuxNMkXvFUouYasWjGuNLoRZjcMnan244Wbya7Mzsfc8ItrplIUBL9Mhkspac
         9Oo1r54niZZC+ITU302GiMZGUvwaQbse/RPw4WsdMWIqh0Ke2HBBkygdlSZ33ijXXcBk
         OBiDSbdTvbmiQJpm56qq778Q6ijwlCTqPeTqJo8SkVFZzP+x3UdrAOL3UkAHgsKyYmVx
         CKo9yr9BEhDiUQVXbOmQrphU1dat7sTEJ5uf+Uqe4hldnVEj+0c+moHnjXglHo7uUeSF
         oYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689705562; x=1692297562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jkb55HhAbN5nQxp124JO5CgyYp5FwsBzn/8eguMNO/I=;
        b=G9HOeENiYDUH8UPcJcmWG2w+/avjnk24Y9se+tRH0JK1WQfg7VJaODb69J8WPz4syG
         tH2kWIBSQkg+ttwdOMrObVAxDdZ4ASokZhJmEWHFIU/0oxO51zmwTywzIbycr4ngl9bK
         P5bbgh4aO0UDGI5uPu3HqB3dZ1CkxXVBEYX0kRnZMlP4gVvZaoPk+grZWdFPZJQ7RiTC
         t91sCzQ/cqhJZsvodfzyB8HcRbhSkznERnQYMZ/pu9xdIOQmQx8ST9CqTXTl7PVxRGGv
         oR0bV01/OC0siXvpiazVB+2hUN32ITyT/VnARfnG69W/3Qij1q2KB+gcvwMLTX7K1Eqz
         Hv2g==
X-Gm-Message-State: ABy/qLbf1Gm1rQtFv+eO/SlDBs0ihxZ4Xs1q8CaXGKQlDsxAqMHzYoJQ
        jtNrzXfbBwBNqz1dcQg87KtPig==
X-Google-Smtp-Source: APBJJlELhwGyjrv7JKi503vZ44u3uhfj4GPWlLn4zkwX+p1EKl4j1+y/9UEV5+hm++H5sG8LkZHJ7w==
X-Received: by 2002:a05:6402:40c5:b0:51e:588b:20ca with SMTP id z5-20020a05640240c500b0051e588b20camr1010538edb.8.1689705561993;
        Tue, 18 Jul 2023 11:39:21 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id c19-20020aa7c993000000b0051e1a4454b2sm1564460edt.67.2023.07.18.11.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 11:39:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH] firmware: arm_scmi: drop OF node reference in smc_chan_setup
Date:   Tue, 18 Jul 2023 20:39:16 +0200
Message-Id: <20230718183916.44439-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OF node reference obtained from of_parse_phandle() should be dropped
if node is not compatible with arm,scmi-shmem.

Fixes: 507cd4d2c5eb ("firmware: arm_scmi: Add compatibility checks for shmem node")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/firmware/arm_scmi/smc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index 621c37efe3ec..2d8c510fbf52 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -137,8 +137,10 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 		return -ENOMEM;
 
 	np = of_parse_phandle(cdev->of_node, "shmem", 0);
-	if (!of_device_is_compatible(np, "arm,scmi-shmem"))
+	if (!of_device_is_compatible(np, "arm,scmi-shmem")) {
+		of_node_put(np);
 		return -ENXIO;
+	}
 
 	ret = of_address_to_resource(np, 0, &res);
 	of_node_put(np);
-- 
2.34.1

