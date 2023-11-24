Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461737F8580
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 22:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjKXVbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 16:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjKXVa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 16:30:58 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981D519A6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:31:04 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9fdf7baabd9so72457266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700861463; x=1701466263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xf+BvI0HCoud7UZk/jd1+lnn/zb5QtR4nqSkftIg4Lc=;
        b=PXvrEAj3Qz8EmASthMqKBA/YnPfHbLZYh+HGfKdmJCROJUcAhCLZnKhDBwT2DDVI0Z
         A5N7Np5adrGYFLtSe8q3Ah8q+otz7YmAEM5Kmt7GnnZ8YxKb7gC4uxQpC4vjRJV1ovOW
         gVXii4mWNxcgUPTE+lmZTcKNrYnxRTselB3Lg7Lp8jXwu3Y7M5f5qGIlPTyomF7oOS/i
         QERI7tbVg5+C9B21gicw+eVgdsy4FgysXau/8KOmdeqnmdLu9WGxM+dr5MCPxuKwL1XS
         OjXkLf6+KpvFIBHIZNrQ/jKXv0LQ2iLHcFjXJKiKRvBU0X7dtsNkxAQi54wAisG9enwB
         sYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700861463; x=1701466263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xf+BvI0HCoud7UZk/jd1+lnn/zb5QtR4nqSkftIg4Lc=;
        b=N/WEALV4Gp3MKIiRO1mnWxux6LcQf71N5edn0lKDyfFf2Apb1xIBXChDAjOV/rqA2i
         T0DPPTPBEdpVfyPrJcT539BxXNmI33jXZj+DVw4ihbK84JJ3stwolB6QF+1+bcW2CwcS
         /+Sqs4PdLgLQIOTY6Jv4aufGMmzvozGhdwCNZA47bce8ElUU17J2h03TgSkjStXXHR2G
         FJJSf04O5CVmVQL6XrM3K5jbPxtGFZq8GOJjqX05PZ/YptOQoYQny2fRvIozrGXuG3lM
         RUb+l4YYK7U8nF+1kKDc8pMRTd1i9OhuYSTsUW0PTyFDRpwAa8sHk4jUTAETxJuQpzXc
         yMog==
X-Gm-Message-State: AOJu0Yy54eOi04XGtb72uOs9iNkhDtxPAoIxwGAg+F8a/IqyzSyzvcRp
        7w9Rj3s/ayDZcwlyZmKPdSk=
X-Google-Smtp-Source: AGHT+IHK17C1vO9U+6o18kae1SZLjDwGP/MMYNJWQnBOz67HwUmYH5p5n4LeoSWvCS+SdGOSsC5/KA==
X-Received: by 2002:a17:906:5812:b0:a01:97e6:6771 with SMTP id m18-20020a170906581200b00a0197e66771mr3351041ejq.0.1700861463124;
        Fri, 24 Nov 2023 13:31:03 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id lv20-20020a170906bc9400b0098884f86e41sm2499299ejb.123.2023.11.24.13.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 13:31:02 -0800 (PST)
Date:   Fri, 24 Nov 2023 22:31:01 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] staging: rtl8192e: Remove unused function
 rtllib_send_beacon()
Message-ID: <fca983a276ae67dc9cd124e236fe9d210fd997d3.1700860759.git.philipp.g.hortmann@gmail.com>
References: <cover.1700860758.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700860758.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused function rtllib_send_beacon().

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 430951c88123..4e33a453f86e 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -351,22 +351,6 @@ static inline struct sk_buff *rtllib_probe_req(struct rtllib_device *ieee)
 	return skb;
 }
 
-static struct sk_buff *rtllib_get_beacon_(struct rtllib_device *ieee);
-
-static void rtllib_send_beacon(struct rtllib_device *ieee)
-{
-	struct sk_buff *skb;
-
-	if (!ieee->ieee_up)
-		return;
-	skb = rtllib_get_beacon_(ieee);
-
-	if (skb) {
-		softmac_mgmt_xmit(skb, ieee);
-		ieee->softmac_stats.tx_beacons++;
-	}
-}
-
 /* Enables network monitor mode, all rx packets will be received. */
 void rtllib_EnableNetMonitorMode(struct net_device *dev,
 		bool bInitState)
-- 
2.42.0

