Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BC47C641C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 06:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343517AbjJLEfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 00:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbjJLEfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 00:35:23 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475E6A9;
        Wed, 11 Oct 2023 21:35:21 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-406618d080eso6171955e9.2;
        Wed, 11 Oct 2023 21:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697085320; x=1697690120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7WosZVTXUOEeXoWrox6z3tSDEIuK6BYXU7VnhYrOQfo=;
        b=Abz2obaKCcFXHZMdHBGtU7VYc2C8izoDou+q0NFBo+gRLWyNzgY2Q6fbdBCKdVpIaS
         paYWP3E3x8sSixMKxXLtY3liVmcSMxHSN1h72xqfcEniv3yq94WRU3PNv9eCiAwLYbST
         u8hY/qSjBp/J8vWKF2xkwGw6wsRpHKDe1V/Xk+fEcY9TcBdIGttO+SmaPnXPdkKdSeRV
         0PGRBPjcRNyyD5dUyDb1HyL/8BUtWdSyjryh61gfBjr4FmeWKqIX3aRqPGrZBbgOVmFn
         YKy9QJLVH8GoqxilmsV2kknfKphDXNMraGgZJUttgRxruQcE4BJs3F1milXgf9zqDTUW
         l63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697085320; x=1697690120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7WosZVTXUOEeXoWrox6z3tSDEIuK6BYXU7VnhYrOQfo=;
        b=ZsNmGVDlG0j+LvF0ZiwJKHji49FrOCJy09Tw1d1zHVcbVG7ATEvC5AYLGQM9SyJ0pj
         956N/wyty24Ei8c6av8n3hbrCPfY0bpzgrPOI6Ar8D5pVTZlzBSkoS0U6WAJFIuUzfc/
         Gw2H8y460nKjvkwO5Zl4EMfFc+TrGc73wEIqHu2xUFkaeNv7wBGImBOAoTzZoMaIEwIf
         pTz9DQLj1uw3QrIDvV3BYQhxLZeybx8wmmiU/m6PPg4qIK/SaBvrp0fpxvJly1xvhj05
         f1My3D/aB7+Ga+E/ybkt3cmHdR1J+YW9bMxRNfh/nuu8jMtTVWaFcE1D2IWOoQKz1OAR
         Oq0Q==
X-Gm-Message-State: AOJu0YxEYLSvLH0iR/qGIBBGSR7m/0tysVDsyg1sKirbJplN2kjwutra
        IG02UntNtsZsJhX30GLMq1g=
X-Google-Smtp-Source: AGHT+IEMdBfINMg5wVoIJUHiN8ohSa4D2agSHU8u5m1PSGZ41FqRWyaFQksruR6jrWfdmas5zgNYbg==
X-Received: by 2002:a05:600c:220b:b0:406:4242:e7df with SMTP id z11-20020a05600c220b00b004064242e7dfmr20647900wml.35.1697085319322;
        Wed, 11 Oct 2023 21:35:19 -0700 (PDT)
Received: from dreambig.dreambig.corp ([58.27.187.115])
        by smtp.gmail.com with ESMTPSA id f12-20020a7bcd0c000000b003fefb94ccc9sm18246890wmj.11.2023.10.11.21.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 21:35:19 -0700 (PDT)
From:   Muhammad Muzammil <m.muzzammilashraf@gmail.com>
To:     horms@kernel.org, loic.poulain@linaro.org, ryazanov.s.a@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Subject: [PATCH v2] drivers: net: wwan: wwan_core.c: resolved spelling mistake
Date:   Thu, 12 Oct 2023 09:35:00 +0500
Message-Id: <20231012043501.9610-1-m.muzzammilashraf@gmail.com>
X-Mailer: git-send-email 2.25.1
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

resolved typing mistake from devce to device

changes since v1:
	- resolved another typing mistake from concurent to
	  concurrent

Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
---
 drivers/net/wwan/wwan_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 87df60916960..72e01e550a16 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -302,7 +302,7 @@ static void wwan_remove_dev(struct wwan_device *wwandev)
 
 static const struct {
 	const char * const name;	/* Port type name */
-	const char * const devsuf;	/* Port devce name suffix */
+	const char * const devsuf;	/* Port device name suffix */
 } wwan_port_types[WWAN_PORT_MAX + 1] = {
 	[WWAN_PORT_AT] = {
 		.name = "AT",
@@ -1184,7 +1184,7 @@ void wwan_unregister_ops(struct device *parent)
 	 */
 	put_device(&wwandev->dev);
 
-	rtnl_lock();	/* Prevent concurent netdev(s) creation/destroying */
+	rtnl_lock();	/* Prevent concurrent netdev(s) creation/destroying */
 
 	/* Remove all child netdev(s), using batch removing */
 	device_for_each_child(&wwandev->dev, &kill_list,
-- 
2.27.0

