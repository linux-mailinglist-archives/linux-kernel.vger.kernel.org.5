Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE49A7FF0C9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345747AbjK3NxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345740AbjK3NxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:53:16 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A88B9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:53:23 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40b4c2ef584so7805105e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701352401; x=1701957201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vh8fgHf4VbVXQAtoSfn0NqPkk1fZpC4zX2ISfWKVIQM=;
        b=mob7rgADKfDtN0ODT3laUMpF4w4GUiLz1OCtmp3MwKY3jnf2cjoOUpLofzLekHjqB4
         XuGe9Q7GG7r5P25CqYXO0ndlZCL+glg6bgRHO3uTgNg+nwZhJVAObHRqu+uqpdAPTheH
         2+qK/OtwF3D7YSoctt9RP9q0LnvVemB7zLyYcXF/1UzHqrad4rDRQKan+sBNYunS7+jP
         bv/t1WPHlVWsVWE942w1GclmdqNPFkV+BikC9/9B0ARIMWnM1B/P8Sd1UXVKsoT268oF
         6E5UJrLVwK4DG9s1rtRnq5qtS9u69rnsWj5azZSphJllzZ7aKSL54qbLXuAxlR1L/So1
         Nlaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701352401; x=1701957201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vh8fgHf4VbVXQAtoSfn0NqPkk1fZpC4zX2ISfWKVIQM=;
        b=D41rPj1uYxi9OZDqc9YzhMeVoPPFQ/t9Ktgoc6pkDDyAaaQGQnav2owQr2VjueaGbJ
         HSDR2lNeovARhac3cYf5kdIAfyRJm8JpleLQeaW6b4m01PZG+HxnlJvfNR74e17bUtbu
         zgAO2hz3NcjT8CugXwhNoVZRQDPq23TVgF1blpfJs4ERymLSpT7F4ZEdDlYxwznjQYzT
         DDv/Ze94cTn2YTD5pcQ5NTSDGbFU5xT26DDgtpdIKnm1/0swfCtHphTjvZVhMOes/36p
         a8PodA6eDfJt6M5nzgITtqp8/ng65pVlUWFOtyacR5OlT5vtG1lioNXK3AjMrhheYcrm
         Rqsg==
X-Gm-Message-State: AOJu0YzWzj4IOlCKvlwzgSibG/mepYDoypdgG1b0CKlwgKxS725poLYL
        WYTzA8uqeMmtu2KIWjHLiOk=
X-Google-Smtp-Source: AGHT+IGaLv3RI8lqocNNF3eRfSnx3JhFXi80PR7IlvFYnJnh7qLCynxVjit8YcDIqMZPMeNu80uXlA==
X-Received: by 2002:a05:600c:3b23:b0:405:4a78:a892 with SMTP id m35-20020a05600c3b2300b004054a78a892mr13782875wms.9.1701352401362;
        Thu, 30 Nov 2023 05:53:21 -0800 (PST)
Received: from mfe-desktop.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.googlemail.com with ESMTPSA id d9-20020a05600c34c900b0040b2c195523sm5864573wmq.31.2023.11.30.05.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 05:53:20 -0800 (PST)
From:   marc.ferland@gmail.com
X-Google-Original-From: marc.ferland@sonatest.com
To:     krzysztof.kozlowski@linaro.org
Cc:     gregkh@linuxfoundation.org, marc.ferland@sonatest.com,
        jeff.dagenais@gmail.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] w1: ds2433: remove unused definition
Date:   Thu, 30 Nov 2023 08:52:29 -0500
Message-Id: <20231130135232.191320-3-marc.ferland@sonatest.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130135232.191320-1-marc.ferland@sonatest.com>
References: <20231130135232.191320-1-marc.ferland@sonatest.com>
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
-- 
2.34.1

