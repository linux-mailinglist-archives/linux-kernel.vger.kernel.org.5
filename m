Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054C178AB7B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjH1KbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjH1KbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:31:06 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2637319A;
        Mon, 28 Aug 2023 03:30:51 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-98377c5d53eso386036466b.0;
        Mon, 28 Aug 2023 03:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693218649; x=1693823449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MiKi/TKlvIbc3sNkJh8jRuCHA25ICsx20PEexiy1mcA=;
        b=JeECIXoDP+alNRW0eSh7bgGm2v6c43o90r6svTuf+En4ezPQbJMkmNAGtJ50YMW5Eo
         7sryg29Ie+23VAN+DUYMAE4oIgPUxK4wfZZDji8rN7XkKrOJt0ANppR3Sz1epP+Spvyj
         Sq5ahqAd5vLnKT5M6cZjsi2Uq81Kq/9bZX4nT46AmHKb1k4tbUugJsn5SLgrOojnzAl4
         iNqMHPPVcq9KgZICPWgWGj9cAdHQB0FJxM/uH3J3iYR1TCLfI79/kj25DAgQzQB9u+4F
         jDsQkxRHeyWMMkVd3V+GzE8LXQAQBmRNQHrLaOn9NVpS6wirIaA0QoBYJnoUYDQSuk/d
         Pywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693218649; x=1693823449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MiKi/TKlvIbc3sNkJh8jRuCHA25ICsx20PEexiy1mcA=;
        b=jDhA4YbxWKNb+pEYMfAx0AczAZVpHWah4xIdIMQQrckyDGaB6DCzkmTcmZtWNfWrv8
         MHM9ZjG/BUmJ45yyaM4CUgGYLQaMx/+uPPntfluFe/ZDLbzqLXoXR55OqJnkqfHaIDp1
         6QETKsip9RMYvLsvktMVXs32IQOwWJcKFhEWx4bgbVDeinETsCDxs4J7lgOVeQosgMNl
         Xd9pTavIOQFLfVk+sp6+1JbhundH0/Ri66/bBZYY+Cgl3oy1tSBwqX2Xb2uRttuvwPzI
         gVfF2+gO2Hinem9bKknFozErFkm9xfYyTnftLrYS39r38fPnN9M7Cif5xkKnmksTd7W/
         NUIw==
X-Gm-Message-State: AOJu0YxNFK8cpFe5Iqf1QRP1XTii+cSVqh0t5RW4BUvKOIfdsW/frspN
        nC0uDG3jYEZunNW6vXulkK8D+/n8MDLvbw==
X-Google-Smtp-Source: AGHT+IFMIaCCcDZoYpunAsRhOgK+O4zynTdJpthd60JRcNlmWJicgI5wy+fP0w6n37NqjiFNaWT6SA==
X-Received: by 2002:a17:906:5dd9:b0:993:d617:bdc2 with SMTP id p25-20020a1709065dd900b00993d617bdc2mr16824143ejv.75.1693218649168;
        Mon, 28 Aug 2023 03:30:49 -0700 (PDT)
Received: from fedora.. (87-97-90-214.pool.digikabel.hu. [87.97.90.214])
        by smtp.gmail.com with ESMTPSA id w24-20020a17090649d800b009930308425csm4473505ejv.31.2023.08.28.03.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 03:30:48 -0700 (PDT)
From:   Andras Sebok <sebokandris2009@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     andriseseboke@gmail.com, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org, gregkh@linuxfoundation.org,
        Andras Sebok <sebokandris2009@gmail.com>
Subject: [PATCH 2/2] Add disabled text to indicate inactive commands in sysrq help menu
Date:   Mon, 28 Aug 2023 12:27:56 +0200
Message-ID: <20230828102753.4811-5-sebokandris2009@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828102753.4811-2-sebokandris2009@gmail.com>
References: <20230828102753.4811-2-sebokandris2009@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds disabled text after disabled commands in sysrq help.

before:
sak : k

after:
sak : k (disabled)

Signed-off-by: Andras Sebok <sebokandris2009@gmail.com>
---
 drivers/tty/sysrq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 831cdadf366f..1af78f76232e 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -617,6 +617,9 @@ void __handle_sysrq(int key, bool check_mask)
 				if (j != i)
 					continue;
 				pr_cont("%s ", sysrq_key_table[i]->help_msg);
+				if (!check_mask || (check_mask &&
+					!sysrq_on_mask(sysrq_key_table[i]->enable_mask)))
+					pr_cont("(disabled)");
 				pr_cont("\n");
 			}
 		}
-- 
2.41.0

