Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2407AA902
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 08:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjIVGZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 02:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjIVGYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 02:24:39 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA53192;
        Thu, 21 Sep 2023 23:24:33 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-274972a4cb6so1306364a91.1;
        Thu, 21 Sep 2023 23:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695363873; x=1695968673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czUvoB2YphHxinmpy35aY7rZVy/pXgKwXq7ZvtF0H2o=;
        b=ELnR2XsmHQYG0Z7j8jnTW7CWUZ9x8UGAt///7tstYiXJadYILsQpMrIbZ1d5A5iu4e
         uDkrqOTsx1L8XdUGbNqIPpIbH6FQ72dgcycxcvVdlOjGiGkvQu8kmbHn4Xzk0sWpD2JC
         QfEmPjGPTnNN83i0bHwnkB3a5HoabK2ghmdUFpqKebkoOIf8vDoSdSFe3bk1LpTrD8Om
         eDqpuCR8Y58zylbi/KEHUWlMlCwqMaIsiUOws+fgVwHAaun/p529WOxI0o5abhkJUW8A
         XtG3kPHUlDTdogp2K3+dnrzMPKDFKEzDECyEZqxGf8ZdFx/3kDKUaUJqV5tRPcysEisD
         /6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695363873; x=1695968673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czUvoB2YphHxinmpy35aY7rZVy/pXgKwXq7ZvtF0H2o=;
        b=nqLRFEaolCwVApszAcIzkfB+L4dTgZpdeIiNVecZeE/i58moJ7dnKkzF8gIvZKmXCb
         pUh6NkfLkJxDCqjc3ULfjYlx0ecLBQHBYDEB24oGdQ2qD7w3e6Tilh/RPMwQABZblBfw
         UDLPi2/9KGNozP+3QH+43Am90E+bygkDj4JOGcMDaQscBXmPXOfzGg3wrF9TP0ZLPc6Y
         KgT9YzrLQicXLZBPH6uhN3yVO9tz2J1pxlkezoz4EmTtcGrVwNzcAm6xQxCdCY4W30o5
         vqOBAS91SMGr1TexMzF/fM0nFk1ybi6kn9DOamWBLyQi4cRQIoQPxdhpOyAGRk487EMc
         USSA==
X-Gm-Message-State: AOJu0Yw1u/J9QYXJlKXZLLxQZDJQ4YlPKuJZf0UroLrZeGiS7TLBFDtX
        MubWQrXgfhZyeLwjXecpM0pwiCw7YLJjeg==
X-Google-Smtp-Source: AGHT+IFo/dMHrKhrXzrmuTbA2nbaz+4CumVSEQs5uTcJpaZheSgUBnAikJtCr6iNfGXaL4eFNV+iMQ==
X-Received: by 2002:a17:90a:f687:b0:274:74ee:eda5 with SMTP id cl7-20020a17090af68700b0027474eeeda5mr7615562pjb.4.1695363873229;
        Thu, 21 Sep 2023 23:24:33 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090ade0b00b00274de7c8aacsm4157417pjv.45.2023.09.21.23.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 23:24:32 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrzej.p@collabora.com
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kflin@nuvoton.com,
        Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v16 5/7] media: v4l2-ctrls: Add user control base for Nuvoton NPCM controls
Date:   Fri, 22 Sep 2023 14:24:03 +0800
Message-Id: <20230922062405.2571850-6-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922062405.2571850-1-milkfafa@gmail.com>
References: <20230922062405.2571850-1-milkfafa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a control base for Nuvoton NPCM driver controls, and reserve 16
controls.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
---
 include/uapi/linux/v4l2-controls.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index c3604a0a3e30..68db66d4aae8 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -203,6 +203,12 @@ enum v4l2_colorfx {
  */
 #define V4L2_CID_USER_ASPEED_BASE		(V4L2_CID_USER_BASE + 0x11a0)
 
+/*
+ * The base for Nuvoton NPCM driver controls.
+ * We reserve 16 controls for this driver.
+ */
+#define V4L2_CID_USER_NPCM_BASE			(V4L2_CID_USER_BASE + 0x11b0)
+
 /* MPEG-class control IDs */
 /* The MPEG controls are applicable to all codec controls
  * and the 'MPEG' part of the define is historical */
-- 
2.34.1

