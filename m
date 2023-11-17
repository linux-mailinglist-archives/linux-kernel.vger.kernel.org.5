Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4698C7EF7D7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 20:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346100AbjKQT3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 14:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjKQT3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 14:29:49 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3682ED51
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 11:29:45 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4083cd3917eso20076075e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 11:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700249383; x=1700854183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3kGDbNgJEZnQxIqJTDiTxyz7vqEWWOiaNZtZNR6F76c=;
        b=ctMoW5hWKuH13i+M2vuZAyhtSoOa4PtQzNamaFPQ4VS7jtj+qVXjaD+S91m8+ueIjz
         gA98/S9lc9/5KNjdYtM7lkCR/NKQmU2gt4KmmrkiWI4EY0EEzLhS68WjiiiEN56VbRyO
         GvB+1WoWWHqLHMynXKdDwx9sHAp937DwKGWc3GY4CvLa0ft5x+IWLNYIzbYd6Nr58Eqk
         Da7P+UIL5U2NrKox1XrmYCCotijjfYTUxhnzaQQC/toLRyuWN4PRF6hgVPQXodBHcnKL
         bH0LOC5Rj0ssExmJchVr8tycyVo222lLEfnsDE7hF4HI9lHCGRhno8uy4HJjyIkhsErk
         XU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700249383; x=1700854183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3kGDbNgJEZnQxIqJTDiTxyz7vqEWWOiaNZtZNR6F76c=;
        b=RHfwzzV8mwUsUp3T7tfoz4oxRSRQ9ARJosLX55YxeAID5/TUlS0EbPUPh1era07rOB
         HeY4mW36pyEAFSSd1/UcjAmz3a400doOrNDyoiG9JRd7kUjzd5Rxr0JEziECAJNlAxY2
         4yZO7kK+FJ8EUaGnF/vY3WmoJqrdoZkPE+jA066mXy4vUrI3VedOzAxjSsRa4ufF5crq
         bfaUptHBqtTFHJCJ67MDXlICjd+sdMdfeJi+Aq6H53CI2Q+xP/ha8FCrhJpT+1PrQ/rY
         7VakLf3wrCz84lT15C4ES+MkWqS3Q2TfO/mAkqo/9FTmGfOeRBqluOWpsqyAroPNHyYB
         gUWg==
X-Gm-Message-State: AOJu0Yw+4uK/TSSxz2N9B3sWJzn85EXl3tUox4HTJ3/vnTfGUlJKTZmY
        9WwiQbDB8KueaxVuvH2qWKs=
X-Google-Smtp-Source: AGHT+IHiJthH+ApJuH/72lZ39Y8nUutmDkkyWGHDequt1aLS2ijDgTIYjzGjRAv/celXY5kjGuj2Dw==
X-Received: by 2002:a7b:c311:0:b0:406:4573:81d2 with SMTP id k17-20020a7bc311000000b00406457381d2mr68301wmj.39.1700249383456;
        Fri, 17 Nov 2023 11:29:43 -0800 (PST)
Received: from mfe-desktop.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.googlemail.com with ESMTPSA id 22-20020a05600c021600b0040523bef620sm4440397wmi.0.2023.11.17.11.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 11:29:42 -0800 (PST)
From:   marc.ferland@gmail.com
X-Google-Original-From: marc.ferland@sonatest.com
To:     krzysztof.kozlowski@linaro.org
Cc:     gregkh@linuxfoundation.org, marc.ferland@sonatest.com,
        jeff.dagenais@gmail.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] w1: ds2433: remove unused definition
Date:   Fri, 17 Nov 2023 14:29:03 -0500
Message-Id: <20231117192909.98944-1-marc.ferland@sonatest.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Ferland <marc.ferland@sonatest.com>

W1_F23_TIME isn't used anywhere, get rid of it.

Signed-off-by: Marc Ferland <marc.ferland@sonatest.com>
---
 drivers/w1/slaves/w1_ds2433.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2433.c b/drivers/w1/slaves/w1_ds2433.c
index 9f21fd98f799..e18523ef8c45 100644
--- a/drivers/w1/slaves/w1_ds2433.c
+++ b/drivers/w1/slaves/w1_ds2433.c
@@ -30,8 +30,6 @@
 #define W1_PAGE_BITS		5
 #define W1_PAGE_MASK		0x1F
 
-#define W1_F23_TIME		300
-
 #define W1_F23_READ_EEPROM	0xF0
 #define W1_F23_WRITE_SCRATCH	0x0F
 #define W1_F23_READ_SCRATCH	0xAA

base-commit: 7475e51b87969e01a6812eac713a1c8310372e8a
-- 
2.34.1

