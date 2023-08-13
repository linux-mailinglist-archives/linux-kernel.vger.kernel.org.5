Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B3177A6E7
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 16:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjHMOZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 10:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjHMOZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 10:25:50 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ECD1719;
        Sun, 13 Aug 2023 07:25:52 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-686b9964ae2so2209882b3a.3;
        Sun, 13 Aug 2023 07:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691936751; x=1692541551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u+Bbe2ATRUNZ2U0iDFw/4l0wbzl0ApUtMQF0UvPw22Q=;
        b=Luouxj5LwU8rtQTxzvqFr9qhwbgELf2N2f8Cy0zZbcAcaRzDs1EfNC6Io7lAcUBrXc
         zOC5Yv3xoAbrAKvAWH5jug8gxRatuXtAjL4IYR18uI5n2EcnbUB8giIJMclwT2ZLInW7
         zxp57FEHcXTBMizJUwRPcv4YaGmyJEoWx9t8W1lgcrXt7B4kc33uDFF0RULSa5tmdr2s
         hBYGATj9ySQ4VEEJur46OPikEm+JsY03JmGoN0rH95c4GVfg1CLBs/9Ma/tCrxYhNiO2
         xUK5bkNd3gPnp9w6tTaihYx0hrA6muz9oixiGsNnFaQn9Lq8ZfzHIKzl08njGgYgiDjB
         Q1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691936751; x=1692541551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u+Bbe2ATRUNZ2U0iDFw/4l0wbzl0ApUtMQF0UvPw22Q=;
        b=ESY2MbILR7t+82CvV2EkTTJ94Z/6e8wb9RKcFDhPMR8g+quzfnSK/BMZkLktMaU2v0
         BlcG1xBFK/j58RWceWYGc9bvRu5RRjZAKrW/TGa37VLZuRL1brXQa3Pum+jx9g1K9bVE
         aMRgJxdZ8O26jcosF9wHazYdXv6CCICb8UEZ941B9SfuOLOcbw6uI8GxdQ4wBYUI0dC9
         FLdRD/ajU1cXxyPxVrVijwwvsG7Rro4idU4I+gDfTk/gADgtts+IdWO9jvDdW8GiodEl
         RQeMx1rzWKM/9uDpqx/g86Zkgq2hulSduPAYLyKp2oVF8xsCfA91BXlxs+NKqxugyOD6
         NOvw==
X-Gm-Message-State: AOJu0Yx2J2wSHzzMDeuKWKLh6gmc3tR7QPqmzlEFLcJGDSv/1+/6WfFm
        WjgUrLXnxmBkSpBIKxtUA2A=
X-Google-Smtp-Source: AGHT+IHmz/gnjtoFiqwnQfwKPpTKrfpr3OSJ3X5BmGB76Tvs5u7NacAzNSMRJtPnOXO61WT/7vXimw==
X-Received: by 2002:a05:6a20:100d:b0:13c:8e50:34b8 with SMTP id gs13-20020a056a20100d00b0013c8e5034b8mr4980193pzc.35.1691936751531;
        Sun, 13 Aug 2023 07:25:51 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:1022:f538:d00a:1992:423:e24e])
        by smtp.gmail.com with ESMTPSA id fk1-20020a056a003a8100b006765cb3255asm6296626pfb.68.2023.08.13.07.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 07:25:51 -0700 (PDT)
From:   coolrrsh@gmail.com
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Rajeshwar R Shinde <coolrrsh@gmail.com>
Subject: [PATCH v2] Documentation: spi: Added a valid hyperlink
Date:   Sun, 13 Aug 2023 19:55:46 +0530
Message-Id: <20230813142546.150799-1-coolrrsh@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajeshwar R Shinde <coolrrsh@gmail.com>

The hyperlink to datasheet in website are subject to change.
Created stable hyperlinks to view datasheets.

Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>

---
v1->v2
changed the commit message

---
 Documentation/spi/spi-lm70llp.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/spi/spi-lm70llp.rst b/Documentation/spi/spi-lm70llp.rst
index 0144e12d9..f6a416468 100644
--- a/Documentation/spi/spi-lm70llp.rst
+++ b/Documentation/spi/spi-lm70llp.rst
@@ -6,7 +6,7 @@ Supported board/chip:
 
   * National Semiconductor LM70 LLP evaluation board
 
-    Datasheet: http://www.national.com/pf/LM/LM70.html
+    Datasheet: https://nbviewer.org/github/spidocs/spi-lm70llp/blob/main/LM70-LLP.pdf
 
 Author:
         Kaiwan N Billimoria <kaiwan@designergraphix.com>
@@ -28,7 +28,7 @@ Hardware Interfacing
 The schematic for this particular board (the LM70EVAL-LLP) is
 available (on page 4) here:
 
-  http://www.national.com/appinfo/tempsensors/files/LM70LLPEVALmanual.pdf
+  https://nbviewer.org/github/spidocs/spi-lm70llp/blob/main/LM70-LLP_schematic.pdf
 
 The hardware interfacing on the LM70 LLP eval board is as follows:
 
-- 
2.25.1

