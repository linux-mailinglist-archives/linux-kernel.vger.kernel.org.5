Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8578E7C992B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 15:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjJONgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 09:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjJONgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 09:36:05 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D6DA6;
        Sun, 15 Oct 2023 06:36:02 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-27cfb84432aso2281627a91.2;
        Sun, 15 Oct 2023 06:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697376961; x=1697981761; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jWM7j+OZCwLtm2rLuGsJS/VApTDDC6NKoILtMy2P7BE=;
        b=KbDr62pDpYPxDPDu+6SLMcxawMby0UDawnZ3As1UnsNiTpUymrKu27KKG+GBPqps4o
         k96Y3eovgVIwIy+n/AueIXsrWSr9CYsYsASGA/6vfMVJba+LFhIP3dJRiBGKZCrapdLt
         byGNSR1m1xtfWwHMwYrcAGqcPvogW+9lVmfxBvdmZ7SgOjuvd+5WHwKAGLBY5geDZgoY
         PlNRCI4DPLtLeIP7MlSdfNIrlcmg9+1LeDpIhmTtOS8tizi9WjFZMnGgg08URHkAzA0C
         UvFHNL1jqVf+mZYGRPLdEOEwK88BOVmQ/RuyCxyCJWFuWxHOyjMtQ0OTzPRsI50ATgFa
         HgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697376961; x=1697981761;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jWM7j+OZCwLtm2rLuGsJS/VApTDDC6NKoILtMy2P7BE=;
        b=JCBHwRhP7nygtfMgA7IoNWbofFW+i9qoDyGeXFhTs7luiqrI3t3Lj117v00QehxdU0
         jJ0mE87QgnbIdjEfWmxtfX/okyhZ8J9tsCbrLpb9RQyapVFwXBJxlw9PqM/mNWaEP8ru
         HT7HDByMgbD6GOua5tncP7JExI3E9+eEmZ0notyuZfCKAElx7KoCreE7KAgEsHgZ+PgS
         o2GuqB+7CCgHL/o3Yxj1PZI45wC2uHZFljpb0YwsDTpybsBCJZsm1ijKAGrKNhBCPcUy
         5F4HK6xhZDhT3Nnv4VWMzFZSCq+hbZPjUG+ae+knPHKj9ryll47PX5ImZBa/deILT0Nn
         UZbA==
X-Gm-Message-State: AOJu0YyxJBvocEUlrFCTAiS4NCJN7B47S4dT8BY3kEEXZZWwt39OXt3l
        BOrdHUIt78RMo5qWPWeGi04=
X-Google-Smtp-Source: AGHT+IG3EY/GYPlQhjDKMrD7ydfH3jXllsSUiuQpVP2X+ZvbgJar2DW/73YFnlgwQl6OJ3GDzD4a6Q==
X-Received: by 2002:a17:90a:1541:b0:268:1355:b03e with SMTP id y1-20020a17090a154100b002681355b03emr28186055pja.38.1697376961266;
        Sun, 15 Oct 2023 06:36:01 -0700 (PDT)
Received: from ubuntu ([122.171.162.0])
        by smtp.gmail.com with ESMTPSA id e7-20020a17090a804700b00263b9e75aecsm2966806pjw.41.2023.10.15.06.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 06:36:01 -0700 (PDT)
Date:   Sun, 15 Oct 2023 06:35:58 -0700
From:   Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
To:     Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        Coiby Xu <coiby.xu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     kumaran.4353@gmail.com
Subject: [PATCH] staging: qlge: Replace the occurrences of (1<<x) by BIT(x)
Message-ID: <20231015133558.GA5489@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adhere to linux coding style. Reported by checkpatch.pl:
CHECK: Prefer using the BIT macro

Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
---
 drivers/staging/qlge/qlge.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/qlge/qlge.h b/drivers/staging/qlge/qlge.h
index d0dd659834ee..69c5b332fd7c 100644
--- a/drivers/staging/qlge/qlge.h
+++ b/drivers/staging/qlge/qlge.h
@@ -1273,7 +1273,7 @@ struct qlge_net_req_iocb {
  */
 struct wqicb {
 	__le16 len;
-#define Q_LEN_V		(1 << 4)
+#define Q_LEN_V		BIT(4)
 #define Q_LEN_CPP_CONT	0x0000
 #define Q_LEN_CPP_16	0x0001
 #define Q_LEN_CPP_32	0x0002
@@ -1308,7 +1308,7 @@ struct cqicb {
 #define FLAGS_LI	0x40
 #define FLAGS_LC	0x80
 	__le16 len;
-#define LEN_V		(1 << 4)
+#define LEN_V		BIT(4)
 #define LEN_CPP_CONT	0x0000
 #define LEN_CPP_32	0x0001
 #define LEN_CPP_64	0x0002
-- 
2.25.1

