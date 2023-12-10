Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363CF80BCBC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 20:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjLJThR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 14:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjLJThH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 14:37:07 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B8CE7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 11:37:14 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-58d06bfadf8so2333838eaf.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 11:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1702237033; x=1702841833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocIsk1Z1AgB/fk/jpeDl/jTBcRisWZEz2PlTlirKV9U=;
        b=XRY/MJS/oWG5ELPhJkB+8Ws83CXGOTEFRSVOjYwg9ryukkTiCguleBkliANlakMZzu
         J7rmZb9uhaPZhBPRfFwHiFaPUpFIO2QwhSVHzWU3JpzLh1Vy3n/bc3cl0dR+cOCYEk56
         jCRdds/of1OPZZS2hF31gf6D/3EXV5ZjSryD3gfc8D9nsh3/h0aTTnHc6r90UjdKigpq
         MymYuooN7rEXu/iTMM9oFE5MrQQg9NL77dOt1F6A2W7t9z0TpGmYTnwU5Y/dYuCPoC1y
         n7hwCu+TYAWoDN2k5zLTeGmYgGTRoNfDMqqIkxEe15TVbr//obhhDEHbDMqtVfvYN5cG
         1Y0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702237033; x=1702841833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocIsk1Z1AgB/fk/jpeDl/jTBcRisWZEz2PlTlirKV9U=;
        b=gKgTaxZGY0mbKMz0jmztMZ6uu8EbcLoXUyfTQDeU7yr4A/vdkzH9E4YXi5gn3HmXwA
         HWe9sr/mUyNZPmc5I+h8xN9l6cJmri7WHsyQ8BxBR4Mi15dpi8NhQ9srNL13PTRUNIzs
         6QApCWewVd1mPB1/GkS52lfKd766sR4eIPyLbeimytUgm6s2Wl2VmTs9H9cbKvV7VA/3
         VdGLOKHOHgbUHdvF0DFVUBjhm4umt1OJcVfM7lF1mYABic8IjcMaJzGSxzECrjWrtPeu
         6QNjyrVRkY/UXkzGiXK0kd1nhOdRmjABQPSgXo6SnCZi9++Ic+Ch3uP9N02HItGKVhVe
         Kq/A==
X-Gm-Message-State: AOJu0Yy6YTMfcGFd7vfMF18Dgz4xOG11ZioRVOYiHQes6otqFTH6JNyQ
        LXBAopOwRZ8WDla08yp3lMUCQw==
X-Google-Smtp-Source: AGHT+IH4+QxPwg2ArrCJJTa5iUAYLO7QQ72lGdZ7KViMmjh75qoVK3In1i+Rw1NnXHD538NSMOfPSA==
X-Received: by 2002:a05:6358:c11a:b0:170:6675:a509 with SMTP id fh26-20020a056358c11a00b001706675a509mr4173666rwb.60.1702237033400;
        Sun, 10 Dec 2023 11:37:13 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902c40900b001b9e9edbf43sm5117419plk.171.2023.12.10.11.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 11:37:12 -0800 (PST)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 4/4] Staging: rtl8192e: Remove variable macId
Date:   Sun, 10 Dec 2023 11:37:05 -0800
Message-Id: <20231210193705.2131807-5-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231210193705.2131807-1-tdavies@darkphysics.net>
References: <20231210193705.2131807-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove variable macId as it is defined but never used.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 224774b1ba31..0b4a6ded257a 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -136,7 +136,6 @@ struct cb_desc {
 	u8 bAMSDU:1;
 	u8 bFromAggrQ:1;
 	u8 reserved6:6;
-	u8 macId;
 	u8 priority;
 
 	/* Tx firmware related element(20-27) */
-- 
2.39.2

