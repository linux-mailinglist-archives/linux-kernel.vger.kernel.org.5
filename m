Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F77767CEE
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 09:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjG2Hwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 03:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjG2Hwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 03:52:49 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46693A84
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 00:52:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99bd67facffso77485266b.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 00:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690617164; x=1691221964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1szKMdZwkmMXHdwn2jyX7UsMVVQqZQ9qEgjK+BqxWBI=;
        b=eS69vhUXOsdSXZwFmG35XILBdgDz0M7uz/0odSm3CtIssI6jH9sFoq8XsReS3Md9UV
         kmHgRTzVXFNjo8Pl6fuPxeQzQzlcIn5/DON8uHqJPdkgSqv2LEt9fonzC5McB8344+le
         M+fHRGkI0NDH25AtvMNlbRUm4t+F7ZHPVjFKIR3lZ5BH5sAUG5KuTQBdj/qySxGP0Zm9
         hENzd7vCcKa7nCol/WYeWfKvKXntzvpCpMc3U5wcz12OE+laCDH/Y/EBWFZw2lhHtNLU
         nTVRK5OtBcPIfbuSbAGHJ7xBz1PKdLy2ZzSYuisGmDhiahHzkFt1q8+MofjAuspcUDVO
         bG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690617164; x=1691221964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1szKMdZwkmMXHdwn2jyX7UsMVVQqZQ9qEgjK+BqxWBI=;
        b=Zuh6T4iKm3B/XnCZUrNthsA3rIBP2sdOgIYh0Sz/+4BUREItcQhwos2mXtrVRJRouj
         0wma8eBH864ktD7SRHWRYnuDUjXBph3+S2UefGWNI0FlwoewHKKmD0m7b4MG/01lgnwy
         VsmPw5f2Tg2nifVv5MCAPGju/PtMKx9oSh1dImwmrkHmukWz7OPXUj3a5JWbjuNzkov+
         ri47uLV2ZErPtBwOLOolD17qkHOPCxdPCRgXXhKTcrUBBoJkR5oRUo9HYrTIpjW/IBrL
         LUXdWoiiylWiBbAzcJeFdL9B8vCCDAwgIj6c4Y4QGTAxD7r0jPhZu3yb+/hujzKnhqrJ
         Qr2Q==
X-Gm-Message-State: ABy/qLbPTt3X5YtHDx+fGXD4nT/qXSEhTi/jIVEgIe/2V9zsfCn9LUdo
        N3qKMue/3z1e0bHyT8yFJKk=
X-Google-Smtp-Source: APBJJlHFgqfYGjEPpuk8F4KBojbefOXxDsu5/wnHBcsSPQsaf8kti6nZ1y7poN8nypQESxruJo0tRw==
X-Received: by 2002:a05:6402:2708:b0:521:f2a7:d57a with SMTP id y8-20020a056402270800b00521f2a7d57amr1369926edd.2.1690617164037;
        Sat, 29 Jul 2023 00:52:44 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id z17-20020a170906815100b0099bcdfff7cbsm2964854ejw.160.2023.07.29.00.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 00:52:43 -0700 (PDT)
Date:   Sat, 29 Jul 2023 09:52:41 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] staging: rtl8192e: Remove unused variable intb in
 _rtl92e_irq()
Message-ID: <df6efb730ba4119f00b5bcc0d760c9b1fd245235.1690615475.git.philipp.g.hortmann@gmail.com>
References: <cover.1690615475.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1690615475.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable intb in _rtl92e_irq().

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index cfad170008c6..50eb8f3494ec 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1973,9 +1973,6 @@ static irqreturn_t _rtl92e_irq(int irq, void *netdev)
 	struct r8192_priv *priv = rtllib_priv(dev);
 	unsigned long flags;
 	u32 inta;
-	u32 intb;
-
-	intb = 0;
 
 	if (priv->irq_enabled == 0)
 		goto done;
-- 
2.41.0

