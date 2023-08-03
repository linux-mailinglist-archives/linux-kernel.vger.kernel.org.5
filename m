Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0748C76EE27
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237141AbjHCPa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235070AbjHCPa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:30:26 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E82180;
        Thu,  3 Aug 2023 08:30:22 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-56c4457c82eso708167eaf.0;
        Thu, 03 Aug 2023 08:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691076622; x=1691681422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sj2V1iph8YBdqh+zvb4+vH4P/YUd3FpRJz1b4pwKt6A=;
        b=n3Y1l7AKPSXX4w1grOcTNKAqKhG+sGcvMyBTnuU32hRaLq4BaIkV4fZCj8uiIDRt+c
         B1Cor2+4wwLs1WuL9h7wjZr1L2VoE69YWNRFM3AXAmEomfMVCmQfgAC5G8nK2qw4KS/C
         1CgEaZr/dA4kZZd694TMOjOTTspRxEy6NFcbEH/hRKieZkZziCsXZY3aoo9FXcRMcv91
         1IvjYg9wOKFZJB1oEg0SKuHoiyqPoQn2jO+Bqh9o52tOldrqiwvNFCo+cPY4PbgNpW1x
         HAN4mP8aJliHFaYePtgqKh97I8cJMlAEEbWJYXufvQdYUPY780rwS74lHwYkrF/QNEM/
         r+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691076622; x=1691681422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sj2V1iph8YBdqh+zvb4+vH4P/YUd3FpRJz1b4pwKt6A=;
        b=U2MIOrpDMzxHIwt3COCwpU3YkSwgQ0cKln+Ock86jF9r2E06DwwHnHDXZ+nguOk53G
         KrzA+zDMqIXkuibVgxDdZLXFNCrE5KHigtl1+y8c+nyS0oskfsY7shpRbq7A2e0goWgH
         z71VlRiquVKMll0gkv/Jkw+7Vm76E8wvqU7rFtMhv7BN1WTihH92lQLl3EgmsDsZDWSB
         aZg+D9Xe7EKZx+kFIfPyVt3gzuO5LiJ+0+IBXytt+eiqA7SE+sQCI/P08ygG9DV4Ctt0
         NPFMx7Caui5haqWQ5kSVCCFw6FujjgyiKw26AORYSplQ59kpUEn6hcaCFBwE3xmWqCUG
         i5qA==
X-Gm-Message-State: ABy/qLaNji7nlEZOjxmuDTdA6sa8l1JgakNSlAbjncmILt5c3gcsH6ov
        z/tTcTiUi5L9z8/BVapEU2k=
X-Google-Smtp-Source: APBJJlHHZyDlNjTGFtdITWvrpAZ3sGKbPyP/i7T7vXVHb+u+jTw8dapdFEE8xbRF4xtajbRtiyo5+g==
X-Received: by 2002:a05:6870:538c:b0:19f:4dc2:428e with SMTP id h12-20020a056870538c00b0019f4dc2428emr20708123oan.14.1691076621854;
        Thu, 03 Aug 2023 08:30:21 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:100e:4034:19a2:fe9:9d1b:5681])
        by smtp.gmail.com with ESMTPSA id pj1-20020a17090b4f4100b00263d3448141sm102956pjb.8.2023.08.03.08.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 08:30:21 -0700 (PDT)
From:   coolrrsh@gmail.com
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Rajeshwar R Shinde <coolrrsh@gmail.com>
Subject: [PATCH 10/10] Added a valid hyperlink
Date:   Thu,  3 Aug 2023 21:00:14 +0530
Message-Id: <20230803153014.25378-2-coolrrsh@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230803153014.25378-1-coolrrsh@gmail.com>
References: <20230803153014.25378-1-coolrrsh@gmail.com>
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

From: Rajeshwar R Shinde <coolrrsh@gmail.com>

The hyperlink to datasheet in website are subject to change.
Created stable hyperlinks to view datasheets.

Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>
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

