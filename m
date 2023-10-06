Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FD57BB4EB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjJFKLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjJFKLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:11:03 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EBEBE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 03:11:01 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32483535e51so1889106f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 03:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696587060; x=1697191860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hwWW0sABsjh41YiHpOu0oUsWiTPmoqzV+38FlfE5YNs=;
        b=nq+s4fQj2mcftSGpPJ2EBRBAnnIRD6UutYjjTtbkPeXDutqKQ/rVkaVNP8cZ3/SYA/
         Oh5FQkXLs4Li74fyA403SR5pTAixifsN3eaSB1LWW1l+GMbwdYn7PkmKPr2nC9k8OydE
         8BosMxXQaccUMa2qmsUclp8d0eaH9U0Gp8IXd+iYOOjyPmVhcuGh/5r8TPeu7oHF0Iz/
         9s/F1o6jQieoq2HCr7jKwSLaZQ26jwBPUcV1UpDhxikAZCwm9PaVMSGSPZHHHvmxHutW
         dsZYlFYV9fRcXKg7AT1qrOELsh1V5stRLBtQqCy7+aSccevK062+9TtF8xPTgwDqulnM
         24ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696587060; x=1697191860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hwWW0sABsjh41YiHpOu0oUsWiTPmoqzV+38FlfE5YNs=;
        b=gbXH6rV6K5mNiNvQO8G/9kS++cB8CKFwfq1z8Xr6qQj99HsZw5iSHxq629UREctzt6
         rhPeRi27vjbe8Gpm72qNHjZUPSA3NaJrWmDJgJv1Ru9zkzn0/Vinai4ZggJshtVu+wD3
         Z1ZkojqhlDO700ncL1CIhfLr7tKo9duUUmo5weuwtYb/xA24S6HHj7anlUJRGBrEw/HS
         NM1l5TkIoHo9OwERoaLR8Drez9nGDe21uZ4RuNtDEVSauhWZyFWXDE1yG6SNDwL5wXSM
         HH0YTRa0u1FmRx57IsLkdoMjnNJnkd0/hwCxuGWZh5fSXL6g4QRZ+zHE65DiHz0Uf/Ng
         j3tQ==
X-Gm-Message-State: AOJu0YyFrsOe5XCrO3XTyLo94BOP5zpmZTH2fAT6tN00e6iVINU4YnLL
        LWmHjMTUfDDotp5HvaaEaOu+qQ==
X-Google-Smtp-Source: AGHT+IGYhlwFF07RvZ38Py5lab35w5tbnwiTBeJleQWMQAS8m72BMQD3KLpLHth0tKiNxpaKbjwTLA==
X-Received: by 2002:a5d:574f:0:b0:321:63d0:1f0e with SMTP id q15-20020a5d574f000000b0032163d01f0emr6520490wrw.20.1696587059529;
        Fri, 06 Oct 2023 03:10:59 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:8f44:72b3:5bcb:6c6b])
        by smtp.googlemail.com with ESMTPSA id t6-20020adff046000000b003231a0ca5ebsm1287343wro.49.2023.10.06.03.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 03:10:59 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH] usb: misc: onboard_usb_hub: extend gl3510 reset duration
Date:   Fri,  6 Oct 2023 12:10:28 +0200
Message-Id: <20231006101028.1973730-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial tests with the gl3510 has been done on libretech aml-a311d-cc.
A 50us reset was fine as long as the hub node was under the usb phy node it
DT. DT schema does not allow that. Moving the hub under the dwc3 controller
caused issues, such as:

onboard-usb-hub 1-1: Failed to suspend device, error -32
onboard-usb-hub 1-1: can't set config #1, error -71
onboard-usb-hub 1-1: Failed to suspend device, error -32
onboard-usb-hub 1-1: USB disconnect, device number 2

Extending the reset duration solves the problem.
Since there is no documentation available for this hub, it is difficult to
know the actual required reset duration. 200us seems to work fine so far.

Suggested-by: Neil Armstrong <neil.armstrong@linaro.org>
Fixes: 65009ccf7e8f ("usb: misc: onboard_usb_hub: add Genesys Logic gl3510 hub support")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/usb/misc/onboard_usb_hub.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
index a9e2f6023c1c..38de22452963 100644
--- a/drivers/usb/misc/onboard_usb_hub.h
+++ b/drivers/usb/misc/onboard_usb_hub.h
@@ -31,6 +31,11 @@ static const struct onboard_hub_pdata cypress_hx3_data = {
 	.num_supplies = 2,
 };
 
+static const struct onboard_hub_pdata genesys_gl3510_data = {
+	.reset_us = 200,
+	.num_supplies = 1,
+};
+
 static const struct onboard_hub_pdata genesys_gl850g_data = {
 	.reset_us = 3,
 	.num_supplies = 1,
@@ -56,7 +61,7 @@ static const struct of_device_id onboard_hub_match[] = {
 	{ .compatible = "usb5e3,608", .data = &genesys_gl850g_data, },
 	{ .compatible = "usb5e3,610", .data = &genesys_gl852g_data, },
 	{ .compatible = "usb5e3,620", .data = &genesys_gl852g_data, },
-	{ .compatible = "usb5e3,626", .data = &genesys_gl852g_data, },
+	{ .compatible = "usb5e3,626", .data = &genesys_gl3510_data, },
 	{ .compatible = "usbbda,411", .data = &realtek_rts5411_data, },
 	{ .compatible = "usbbda,5411", .data = &realtek_rts5411_data, },
 	{ .compatible = "usbbda,414", .data = &realtek_rts5411_data, },
-- 
2.40.1

