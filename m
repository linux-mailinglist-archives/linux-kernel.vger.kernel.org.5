Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E14F7841E5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbjHVNWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbjHVNWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:22:21 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE25BE;
        Tue, 22 Aug 2023 06:22:19 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe11652b64so6823643e87.0;
        Tue, 22 Aug 2023 06:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692710537; x=1693315337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wGWZmoxclOfYzjyLvlkmT9ZvCsngcDBgs2bkB2Nywss=;
        b=MU+J9C1wcQYK1gVd6TaxkuHqX/vrIL2N+Xf4RY2de74ButEFa7v7SxadrbCpR1MGTS
         Q/hFE7B9FkMWdi1sI/HhrIES+xG6AD8xtd2RG3WCR4167UVWEcTXxvHbWe65BkzTfj0o
         9M+oxOi6klLSM/D2il+R3H0zzRSavyvt3bwCyEaGASZ5h7rRhvmtOl444QrxE4lPyt4T
         HeLSSmIr9Pco68I7488aywjAKKjJN8FRB3T7Y0FjlfoAvPWuZ2+32jfgfwH3HuPQ08iR
         uauXbpiTa+KhwC0wUIBLs569C0/4zzOWI5GKIK7tVYzPw6fmZsgl28jasITLIbMDSIUv
         RYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692710537; x=1693315337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wGWZmoxclOfYzjyLvlkmT9ZvCsngcDBgs2bkB2Nywss=;
        b=AqQswqTXtyJenE7iUC0KA84g6FUfrf1NX7M3DSlraMphRfVQCIGp5eD9EO4eFl/4wr
         rny/MMgzS5JqqgmnXleXkGfMZgAcw2Km2zI8SVv9VenrQcHuGORqNruxvUo0TCcktH20
         oDLUbHoPgGgElJVk+4L4qsAk84d6POqHO8s1r34DA0nogiCnD+h8xLoi53XVRSXAsFXZ
         AGZw/zFzligzh5RFsYtVSjuDQTymvGY1tlKdtJKvY7c40mms/P52pMmU8yMc7g9wFYyO
         sIlQ1VX3t5z+gHxROg6NbvMlOv0CLTjIN9UwngfuwmeRiAusXlT66yNqxLdF4Y+jJV+m
         IHWw==
X-Gm-Message-State: AOJu0Yw4XIQD7YiV/q2em+MRmmWSZDXDkem2lUq67a7Ho9smoNvgQmxw
        kp5GE3nPv05HBZVXC5ZapWH6jvp7/hmIoQ==
X-Google-Smtp-Source: AGHT+IETp5Dr++LaS88bS0SWHxpcPKsyakg7Le7M3QyrWJ3aj7P0kb/fJ9wcgyjvLYdZbuMMot66Ew==
X-Received: by 2002:ac2:4d90:0:b0:4f8:5905:8e0a with SMTP id g16-20020ac24d90000000b004f859058e0amr6176696lfe.6.1692710536887;
        Tue, 22 Aug 2023 06:22:16 -0700 (PDT)
Received: from localhost.localdomain ([102.39.140.247])
        by smtp.gmail.com with ESMTPSA id k11-20020a05640212cb00b005233f2635fbsm7575696edx.21.2023.08.22.06.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 06:22:16 -0700 (PDT)
From:   Grant B Adams <nemith592@gmail.com>
Cc:     linux-omap@vger.kernel.org, tony@atomide.com,
        Grant B Adams <nemith592@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH 2/2] usb: musb: dsps: Fix vbus vs tps65217-charger irq conflict
Date:   Tue, 22 Aug 2023 15:22:02 +0200
Message-Id: <20230822132202.19659-1-nemith592@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling the tps65217-charger driver/module causes an interrupt conflict
with the vbus driver resulting in a probe failure.
The conflict is resolved by changing both driver's threaded interrupt
request function from IRQF_ONESHOT to IRQF_SHARED.

Signed-off-by: Grant B Adams <nemith592@gmail.com>
---
 drivers/usb/musb/musb_dsps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 9119b1d51370..cbb45de5a76f 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -851,7 +851,7 @@ static int dsps_setup_optional_vbus_irq(struct platform_device *pdev,
 
 	error = devm_request_threaded_irq(glue->dev, glue->vbus_irq,
 					  NULL, dsps_vbus_threaded_irq,
-					  IRQF_ONESHOT,
+					  IRQF_SHARED,
 					  "vbus", glue);
 	if (error) {
 		glue->vbus_irq = 0;
-- 
2.34.1

