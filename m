Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725E375EAC2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjGXFOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 01:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjGXFN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:13:58 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193BDE54;
        Sun, 23 Jul 2023 22:13:52 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2632336f75fso2496906a91.3;
        Sun, 23 Jul 2023 22:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690175631; x=1690780431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqW8DfZ6fP+85CmTsJVzjeFdh5CJjlffb6mkzwyRRAA=;
        b=Tlc1MlavR+Wldxpwq4X5o+8CWM7f7kxeQC4dmahGNQQetc8PON7FoURC6vPsEYZvJB
         7+OOHFLM6NASIqpsBr8SBXN/6zacIwRGDzy2k5A4/D6oJYBUPgheH39SaP0fFEeY2xrG
         gDQWXHzjhlC0pK7dQOUh1ghuZzHL1k5JkBKx9J+5vrRjZNrA9rnIz8qXBazD6NyerZLK
         UpcK9GXTEqLCXQHQ9SQCUqbNfopRqoKYcuU5lDIOmW/mldOqYuLb4zr7v6wfXO6tJAbC
         AvAJRdYPPz0ehJFhxnskvKKIdLyAR718xeKz/TSCz78vN67ZFV421Hh/ZjK6as5gXdSc
         cV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690175631; x=1690780431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqW8DfZ6fP+85CmTsJVzjeFdh5CJjlffb6mkzwyRRAA=;
        b=AGRVCNcW9hNeOVXCqq6PPe2azXZ8BbFxB4d8mwy2u6xseFEnZzK3wbdSCzBtbv4QEA
         BgX1ObXEC8ie5w4PnRPDEJOtZfk4F1xFf/SV35Lx6bM65ke44FEDmC8rZ8YyvZGaumDj
         TzxLtsIElJAv1QVnPaUJAndANONvx7L3Asn+hFiEOrq0i37qR4Hw88+VHza/hC89PxBc
         DlCDt5YXx+yPk/LbxL8eo7WbRB/kBZDLdCZBTs14W9GtXdOl31iW2KNnf2DkGNgwTJw6
         GyCfL5fE8ylURIRtfSPu/A+sfqI8SITFCfjkOC1l0kyF3Aex3XtUO8qk2HJt3QZ1gIPk
         hGaw==
X-Gm-Message-State: ABy/qLbGBg4OwUpRL0kTy1oWGYTi98k1HNXeCkiBwKztsDVtIE0+B9Su
        btceiAZBF+n9sPLxcCDipIFGc7Dw7FA=
X-Google-Smtp-Source: APBJJlH0Im8QdnVDV93025+Hbwmqv/NIDLqn4PdqoTzvlK5Q+axm2BFQ63P3SnqiCMS6ZM9l0jtNPw==
X-Received: by 2002:a17:90b:3711:b0:268:13c4:b800 with SMTP id mg17-20020a17090b371100b0026813c4b800mr2499791pjb.21.1690175631102;
        Sun, 23 Jul 2023 22:13:51 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:b8db:3c3:1ff4:2ae3])
        by smtp.gmail.com with ESMTPSA id gv17-20020a17090b11d100b00265dc26d8dfsm7501106pjb.27.2023.07.23.22.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 22:13:50 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] Input: qt2160 - do not hard code interrupt trigger
Date:   Sun, 23 Jul 2023 22:13:41 -0700
Message-ID: <20230724051345.335219-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230724051345.335219-1-dmitry.torokhov@gmail.com>
References: <20230724051345.335219-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rely on the platform and ACPI/DT to set up the interrupt trigger.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/qt2160.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard/qt2160.c
index b8c0f0ebf604..6cfaabd10482 100644
--- a/drivers/input/keyboard/qt2160.c
+++ b/drivers/input/keyboard/qt2160.c
@@ -371,8 +371,7 @@ static int qt2160_probe(struct i2c_client *client)
 
 	if (client->irq) {
 		error = request_threaded_irq(client->irq, NULL, qt2160_irq,
-					     IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-					     "qt2160", input);
+					     IRQF_ONESHOT, "qt2160", input);
 		if (error) {
 			dev_err(&client->dev,
 				"failed to allocate irq %d\n", client->irq);
-- 
2.41.0.487.g6d72f3e995-goog

