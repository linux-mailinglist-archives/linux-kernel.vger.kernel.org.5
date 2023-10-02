Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F4F7B599E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238656AbjJBRxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238620AbjJBRxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:53:39 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164C4C9
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:53:36 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9ae65c0e46fso488204766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 10:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696269214; x=1696874014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v8XgAodUCp0kY+1km3TbFUFkWPyDPdSc7jRGFUGZ6tY=;
        b=Td9DXcCrx0CpY0PtA3NkWlnOh79juT4XgF5jJDBpw25kC8c4grt/1HNnMrBVrt2aYY
         LptVU2NIdiAE2ZG3rnO23Q0TVqw9rQNza04xUu/8UE192QvyKysdOe6eYDIRORAnMhKx
         IfiDPF8tNSBT6BQAKLiaM58y/N2HU+2dFcz6ZAyfiIdFyN7Qn0g9e3JLPFgMQ1Ba4GNx
         kiP/0uLWSarSJoOwYPq57wLq03InZW5ryWZXnie2qzclKR4jRljhE2PzOapyhaeaGE19
         zADuJ9tZySuIXZTUF6HbwyYjHKxVxlsZQ1GNq4NLC0li6fRRCjVzswbpQZHPCXdwlGw1
         z9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696269214; x=1696874014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8XgAodUCp0kY+1km3TbFUFkWPyDPdSc7jRGFUGZ6tY=;
        b=mpiTRLfqgqU8xdnz2X7Ac+BxZ2pYjQ495UrTj+tQPHfZdrtdV0ThYjSrbjI2G2RhNR
         3USRQv7EZUFqSGeMiFYB65jfgQQHS8X4e4SNS4rWpc1YxZuIuXjU2PiT2vzPAfzuj0w8
         Q8zcNAa8V291+qzN9e9tHV60yHYYmyqitQAY7qHNkb2YC65R2nqPBm4qKyirc/jpfsGG
         owwAU5ZPh0GNUlCL3Q3QDOoUllJhVCalI32pz/YoLoyD6BJ67VpPyVOe4f6SIJSb7+Mc
         XxOXnuKKc0fSsd8cfdK2sdS30mfuGLi83IRE0K6vx3a2BC6m1jWng5fbAnhGdHoejahJ
         QBIw==
X-Gm-Message-State: AOJu0YzkyCuP7Z89Mw4r9Q0DgHVtOfRC7kwKr3Ntj8DAjnukF+5oFz00
        Q8rbMnaQIItLOpgB89M9BQw=
X-Google-Smtp-Source: AGHT+IHxoVyWegDAD4XwJ303ZcTwEtX/l/Xbey9YjC2IN7R8/Q0amJdtjx2O+QvFQl7248scBmVivg==
X-Received: by 2002:a17:906:7389:b0:9b2:71f2:bd11 with SMTP id f9-20020a170906738900b009b271f2bd11mr9471541ejl.4.1696269214420;
        Mon, 02 Oct 2023 10:53:34 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id k20-20020a170906681400b009adca8ada31sm17651321ejr.12.2023.10.02.10.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 10:53:34 -0700 (PDT)
Date:   Mon, 2 Oct 2023 19:53:32 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] staging: rtl8192e: Remove unused variable
 rate_adaptive_disabled
Message-ID: <31ba05bce9966dfac15cac15aa0e79cf36fad27f.1696266964.git.philipp.g.hortmann@gmail.com>
References: <cover.1696266964.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696266964.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rate_adaptive_disabled is initialized to 0 and unchanged. The equation
results accordingly. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 3 ---
 drivers/staging/rtl8192e/rtllib.h          | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 52b9393b55e7..01abe1e48468 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -284,9 +284,6 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
 	if (!priv->up)
 		return;
 
-	if (pra->rate_adaptive_disabled)
-		return;
-
 	if (priv->rtllib->mode != WIRELESS_MODE_N_24G)
 		return;
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 1e474691aa88..bf4ec38efa35 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1146,7 +1146,6 @@ struct sw_cam_table {
 
 #define   TOTAL_CAM_ENTRY				32
 struct rate_adaptive {
-	u8				rate_adaptive_disabled;
 	u8				ratr_state;
 	u16				reserve;
 
-- 
2.42.0

