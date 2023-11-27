Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4329B7F98BC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 06:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjK0FgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 00:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjK0FgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 00:36:12 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC86B5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:36:18 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cf89df1eecso23597935ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1701063378; x=1701668178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mhtCZ2FPHkfJMzES7tFYFByhVEv5qF9kyJcqPMGxvU=;
        b=kHuT7HnFfwKsMB18g0ZE8pdVwAVSKBwB0+cA+hVUh3r0TXJlhfQgYTtmcctL71PuCG
         boHIiSVFfCNU6umEZ4Fwm3QywpU7oXNV9ZgPyZlq73CE+FEnYjcR4QD4s6dJW20e8xt7
         BcpQ0hGKUasyrxKrLbU0vNHXP2Zuw83TosMKX6f/HLVPHFbdxZ0xcIxhT31OVn/1QRgU
         l02gjddsiWylPRp+IkMfeUD7GAHivpCFmQjPkAXZWXu7fuv/JrvJf3Wq7LlyOq6r3fGs
         Pod7zHXZX7p0c6wSiSdpMcOuVBhsoFVLuL66AXDXJJxXeHrucicLMQhVWNUSI3+zsau3
         LVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701063378; x=1701668178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mhtCZ2FPHkfJMzES7tFYFByhVEv5qF9kyJcqPMGxvU=;
        b=jkuteKlQwQFcBMoFU/5OxocTKJD0mDZx5UhwC0eV6UhYQ/BHa+InWglmpBhod1CwQF
         2fBfXwSttI4wFzY/LaTnjrTPb7dDAiNmE4khU74r6Q1OFxB8BJ649VKgDJYj2BML+Vx3
         d86uskiSqcqnqVUIBl2ngzK8369jUtpSvWOI7/VYCX1pGeXj1LC5CnhdBr++/SJ4IwTV
         bvONLwkLgjhoWQ04jRj9dk/l9o/t+1+112COfOsAPR4Dy+X11UtHY2mvNWec+nuAQpJg
         cwoonjVzX4/9/V4qb97OHEIYhf/mHlhJYSHH3IqTKca/5nhYt4qHwD9fG7nDaBWboCWS
         Y8hg==
X-Gm-Message-State: AOJu0YyUOpfxNPwfXlJ5rT2+JryUZQpINj1Wm8CoHrejsXlaVmv2PPUZ
        wSkIixr6rBJdBN+ixuiYus0ipw==
X-Google-Smtp-Source: AGHT+IEud1ssm4kngq3IOpf/LNa3Jt2Gd16D1urJFcRr2xOSzZtw9tCi93NJGF3GOu4LV8QrVN9dWQ==
X-Received: by 2002:a17:902:dac4:b0:1cf:d7e2:5e73 with SMTP id q4-20020a170902dac400b001cfd7e25e73mr470783plx.49.1701063378238;
        Sun, 26 Nov 2023 21:36:18 -0800 (PST)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902ed0600b001cc3875e658sm7300465pld.303.2023.11.26.21.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 21:36:17 -0800 (PST)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 02/15] Staging: rtl8192e: Rename variable BAReq
Date:   Sun, 26 Nov 2023 21:42:52 -0800
Message-ID: <20231127054305.148276-3-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231127054305.148276-1-tdavies@darkphysics.net>
References: <20231127054305.148276-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable BAReq to ba_req to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 497791a980ba..f6ba922dc82e 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -68,7 +68,7 @@ static struct sk_buff *rtllib_ADDBA(struct rtllib_device *ieee, u8 *dst,
 				    u16 status_code, u8 type)
 {
 	struct sk_buff *skb = NULL;
-	struct ieee80211_hdr_3addr *BAReq = NULL;
+	struct ieee80211_hdr_3addr *ba_req = NULL;
 	u8 *tag = NULL;
 	u16 len = ieee->tx_headroom + 9;
 
@@ -87,13 +87,13 @@ static struct sk_buff *rtllib_ADDBA(struct rtllib_device *ieee, u8 *dst,
 
 	skb_reserve(skb, ieee->tx_headroom);
 
-	BAReq = skb_put(skb, sizeof(struct ieee80211_hdr_3addr));
+	ba_req = skb_put(skb, sizeof(struct ieee80211_hdr_3addr));
 
-	ether_addr_copy(BAReq->addr1, dst);
-	ether_addr_copy(BAReq->addr2, ieee->dev->dev_addr);
+	ether_addr_copy(ba_req->addr1, dst);
+	ether_addr_copy(ba_req->addr2, ieee->dev->dev_addr);
 
-	ether_addr_copy(BAReq->addr3, ieee->current_network.bssid);
-	BAReq->frame_control = cpu_to_le16(IEEE80211_STYPE_ACTION);
+	ether_addr_copy(ba_req->addr3, ieee->current_network.bssid);
+	ba_req->frame_control = cpu_to_le16(IEEE80211_STYPE_ACTION);
 
 	tag = skb_put(skb, 9);
 	*tag++ = ACT_CAT_BA;
-- 
2.39.2

