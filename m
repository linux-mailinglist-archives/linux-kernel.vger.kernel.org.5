Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4562A807CDA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 01:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441913AbjLGAAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 19:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441882AbjLGAAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 19:00:14 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D7DD5A;
        Wed,  6 Dec 2023 16:00:18 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c256ffdbcso3955175e9.2;
        Wed, 06 Dec 2023 16:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701907216; x=1702512016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfZOawQYQNHqU9ZIBqp6/PMD5jOFrh8dAxaGlSct1Og=;
        b=hQC3tj/p0CV0CP+18+KrPYRR3wt0ZXfAirIY+Ry04RtClYu0gNx1nANlfpcWJ2UCYE
         mydpDvITtcsIsFIl3DTOJkZz3rYrLpGVGib+e5+sHhKNkx3s3UG++o6fDAuVnzJGC1IS
         qwE7XOnz6bO4RT1FGTYAgMJJmhPSSwEFAz0EYeQqis9AJSbVO77F4u6GOwfoktG0LI3E
         CTE6EAkFMss/djr6+BPCnZecHCvD+UjUlvmhgbJfzsWzn1huf0G+vYw69zfWDq35dqdu
         vWjvzPUVgJ0idNAJgZYRcm2quzTvRwI6O24aDYRIGSy5aTY4z+l+0nEzX1dtB/QX7KKe
         F35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701907216; x=1702512016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfZOawQYQNHqU9ZIBqp6/PMD5jOFrh8dAxaGlSct1Og=;
        b=Q5K/RAeZHQNme55DQRCpvLrDwgbQ1hOtkQ85OaBwGnF3vKSBSJ+azgMPg5BaTrB8AB
         I4JqtQxd8H6yrRzalhhbL7we4s04Ns39lWpSK8ezQPqZqDoqdDpleKUo8S7fKAdkJQk4
         fBeHW028rNDPflAB46FI5Ja1J2w7y7O/Q4NZMTr3Tw3ZzaH8tjA3ScLFyrv5OTU6yB2/
         QEaeSn02UHE2TJYR6chSU0rM22NjaqNKwTyeUzIR3WpOBNyTjOoww1T1NGcr9KBUvZAU
         ytQL68/7p5CZv+XxoCzLr/xzsKZCoIfrZQp14JP66o+/vahT/TpEfMxSEYmU/LgyTArB
         zG4g==
X-Gm-Message-State: AOJu0Yy34IdSk6KG0i90kk8HWcNcSPI+ZjREa37MzxrOhTUlilZbXaLr
        hKsQW0slQw+f63ze9RVZ4eY=
X-Google-Smtp-Source: AGHT+IEOynzLilO6iZ2qjgY8vw58zmZ29fqvyp7pN7y9fejQLNnGnyQxATUqRVqEvXv0QL0XthPTWA==
X-Received: by 2002:a05:600c:4c94:b0:40b:5e59:c55a with SMTP id g20-20020a05600c4c9400b0040b5e59c55amr1063335wmp.132.1701907216123;
        Wed, 06 Dec 2023 16:00:16 -0800 (PST)
Received: from localhost.localdomain (host-79-26-252-6.retail.telecomitalia.it. [79.26.252.6])
        by smtp.googlemail.com with ESMTPSA id je16-20020a05600c1f9000b00405442edc69sm50280wmb.14.2023.12.06.16.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 16:00:15 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v3 01/13] net: phy: at803x: fix passing the wrong reference for config_intr
Date:   Thu,  7 Dec 2023 00:57:16 +0100
Message-Id: <20231206235728.6985-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231206235728.6985-1-ansuelsmth@gmail.com>
References: <20231206235728.6985-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix passing the wrong reference for config_initr on passing the function
pointer, drop the wrong & from at803x_config_intr in the PHY struct.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/at803x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 37fb033e1c29..ef203b0807e5 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -2104,7 +2104,7 @@ static struct phy_driver at803x_driver[] = {
 	.write_page		= at803x_write_page,
 	.get_features		= at803x_get_features,
 	.read_status		= at803x_read_status,
-	.config_intr		= &at803x_config_intr,
+	.config_intr		= at803x_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.get_tunable		= at803x_get_tunable,
 	.set_tunable		= at803x_set_tunable,
@@ -2134,7 +2134,7 @@ static struct phy_driver at803x_driver[] = {
 	.resume			= at803x_resume,
 	.flags			= PHY_POLL_CABLE_TEST,
 	/* PHY_BASIC_FEATURES */
-	.config_intr		= &at803x_config_intr,
+	.config_intr		= at803x_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.cable_test_start	= at803x_cable_test_start,
 	.cable_test_get_status	= at803x_cable_test_get_status,
@@ -2150,7 +2150,7 @@ static struct phy_driver at803x_driver[] = {
 	.resume			= at803x_resume,
 	.flags			= PHY_POLL_CABLE_TEST,
 	/* PHY_BASIC_FEATURES */
-	.config_intr		= &at803x_config_intr,
+	.config_intr		= at803x_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.cable_test_start	= at803x_cable_test_start,
 	.cable_test_get_status	= at803x_cable_test_get_status,
-- 
2.40.1

