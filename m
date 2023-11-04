Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476587E0F83
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 14:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjKDM7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 08:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKDM7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 08:59:40 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9DD194;
        Sat,  4 Nov 2023 05:59:37 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50943ccbbaeso4211018e87.2;
        Sat, 04 Nov 2023 05:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699102776; x=1699707576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ObsqG9+10NLUeAHOgwfeMmWgkHs3rhcD4ztf3mot19o=;
        b=PZ8Om298AfkI3IiDU1vDX57PE9d+pz4nVDZGp2kDYEamHTPbI3WiIGkHkQbr+htb97
         H+F4wvZL5EnxV1wBbBRjvS+cWZeRTWGmFEhBgTic97Xury4x//waV9qddedyCsXOtK2Y
         +MJezsYQYmGaDoZzh9dxq/1k2+eVsfUE17wBUbQKasAsye3H9HLX7UU1kluU6/po4vdi
         JZYfup3Ofo1ezX7GZ30J6WE5o8O+F0cV9t9YnmrpO/uNGJICvcPA+iFUyllO+PxMVupM
         9nQi5W968d/oXSCORbIlGhrPu0nrEW8IVeLa/Nsn22FRCBRpUc+d6J8gK35NOY4AQdNv
         iQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699102776; x=1699707576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ObsqG9+10NLUeAHOgwfeMmWgkHs3rhcD4ztf3mot19o=;
        b=B0+4vF6LzkRBbmlISe6UkzHSP6Fka0og2+eNbSYMD8EGqeoPspW3jnQeqxZDvXXQv7
         Lk/YLUq6ssYj9NfGuwNdsXzP2b1r5mbFUJc/tZ2EsIpRUL6ghcVP7KPSritbmnRa2zws
         D1eBwVkAEFYd35rpWO9FyL505q3ULHIjxCozD4o4Ss5HacOGGz6uOxl4vZEDuKTQIeQw
         uK/9rNIPDVNVzI6Kiy4xyL+LaObb7kKnoyUvnTyIZcwgMV48axmQEyZXKAmxIjyB26p1
         3ks9YR73m/pVwYPrWCwH6wqV8y2qJm2F6o9jVDywQZE9CDS8gXF15U6nfkh9F1CRiUHa
         EGsw==
X-Gm-Message-State: AOJu0YybOTBt9+g49KTN4sUyxD3ju8sh0+TBrpzBzwHVF19DAUmhUvNE
        whhRBsn7Q/Sj5D65Dy2SkNo=
X-Google-Smtp-Source: AGHT+IEINvmjUC0yxKeihtigOl7Q+sI8Uo7L+xFjgOv/kbuT95k+JW09e4wnXO/ZBYThDOpyLnAHLw==
X-Received: by 2002:a05:6512:202a:b0:509:4980:7bf0 with SMTP id s10-20020a056512202a00b0050949807bf0mr6170428lfs.38.1699102775647;
        Sat, 04 Nov 2023 05:59:35 -0700 (PDT)
Received: from mars.. ([2a02:168:6806:0:e018:7b08:28f0:78c5])
        by smtp.gmail.com with ESMTPSA id r13-20020a05600c458d00b00406443c8b4fsm5707383wmo.19.2023.11.04.05.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 05:59:35 -0700 (PDT)
From:   Klaus Kudielka <klaus.kudielka@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Christian Marangi <ansuelsmth@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Li Zetao <lizetao1@huawei.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Klaus Kudielka <klaus.kudielka@gmail.com>
Subject: [PATCH] leds: triggers: netdev: add a check, whether device is up
Date:   Sat,  4 Nov 2023 13:58:40 +0100
Message-ID: <20231104125840.27914-1-klaus.kudielka@gmail.com>
X-Mailer: git-send-email 2.42.0
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

Some net devices do not report NO-CARRIER, if they haven't been brought
up. In that case, the netdev trigger results in a wrong link state being
displayed. Fix this, by adding a check, whether the device is up.

Signed-off-by: Klaus Kudielka <klaus.kudielka@gmail.com>
---
 drivers/leds/trigger/ledtrig-netdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index e358e77e4b..bd5e21d0f0 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -195,7 +195,8 @@ static void get_device_state(struct led_netdev_data *trigger_data)
 {
 	struct ethtool_link_ksettings cmd;
 
-	trigger_data->carrier_link_up = netif_carrier_ok(trigger_data->net_dev);
+	trigger_data->carrier_link_up = netif_running(trigger_data->net_dev) &&
+		netif_carrier_ok(trigger_data->net_dev);
 	if (!trigger_data->carrier_link_up)
 		return;
 
-- 
2.42.0

