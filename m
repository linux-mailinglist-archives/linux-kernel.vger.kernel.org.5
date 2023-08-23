Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F31A785D1A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 18:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbjHWQRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 12:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjHWQRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 12:17:20 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998C5E74
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 09:17:18 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40fed08b990so37581491cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 09:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692807438; x=1693412238;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Sb+MR/Lt+uikyl1c75o5pU9syq5jGmJBTY3hwwDWFw=;
        b=gnZ6gP/4kTK+Ozb5yJMZy8i97A7/By1IZQU3ZwcZlBiZWZNcES/FqIsOCIOGvPn7Fs
         7IHIqcUD9ACXWOfqxUErkeIT7h7np3gUa7vFuLXjxwnQw42/Q4+ntjqSBKLaeKdJ8zvS
         yTIzREC1nDLJo5bq+0Dvl0QwhQWtQfh1ak/Eh5Fm5ApSuKxVjJXSwqZX/C8w3UKMxRNk
         OjM4Bd7JbcmPFNIPtrFNAfsZFdseUVwMs24TW5WGtm3mj6yU/RRFzMkyQpaCWUU6S/B6
         jehBYVsKrEKjCjhTYgDOcgeWZfZrshXe30Gto3PC6lNMG4/uxzgZHIliPpgDDSwkVnV2
         0EEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692807438; x=1693412238;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Sb+MR/Lt+uikyl1c75o5pU9syq5jGmJBTY3hwwDWFw=;
        b=H/4uzRlyEEWlMxYWP3SWleHRWV7zrFS2v9Cw6hPtTlqq8OzfHUznQRGLbJHFygwFb3
         MCkd+AvONapTyRHtiVc2m9mK4SGuRbHbmGFW7f+rxtRRE9Py9na2addm3dm3lglmmagM
         xwZ/2cpGLYVVDZYebnU9XBIucLmUmE76EBsK9QM8tW60ebVXIytA5qmh1RtQPJgSfOhj
         HhKM3TiXapdpcjRxJ+N4tqHZsNkkjn/6JDPvRnZuavdQHyAX6D66mx7+NgEvTjkeqehx
         X+6QLigPMjL+fSd31z7U+bN9NMniuhdoZIW0G4jX02EaGZJY047JY2WpDTdL49N9zmS3
         etEw==
X-Gm-Message-State: AOJu0YwNK3hg28b4KyNAsZrzmS1e8V1Ueaw0tbBqhg8xBQF+i3oQwwDY
        fOIOGz8DlgGxFL/MUxls1X4WhreKKL0=
X-Google-Smtp-Source: AGHT+IEAfeIP+ECkRHM/ZnJvfacEMrbMzK3qL6v0mlT6M71nKJPK8Q9PhjD640mqIfNytSoJqju+Pw==
X-Received: by 2002:a05:622a:4c7:b0:410:92f3:8ede with SMTP id q7-20020a05622a04c700b0041092f38edemr14158882qtx.9.1692807437671;
        Wed, 23 Aug 2023 09:17:17 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:82ea:8c7c:b784:3f92:988a])
        by smtp.gmail.com with ESMTPSA id d14-20020ac8614e000000b00410ab3c78efsm450829qtm.11.2023.08.23.09.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 09:17:17 -0700 (PDT)
Date:   Wed, 23 Aug 2023 13:17:13 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH] staging: vme_user: fix check misspellings
Message-ID: <ZOYxCQlCd04HHFZ+@alolivei-thinkpadt480s.gru.csb>
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

Fixed all CHECK: 'specificed' may be misspelled - perhaps 'specified'?
as reported by checkpatch to adhere to the Linux kernel
coding-style guidelines.

Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
---
 drivers/staging/vme_user/vme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index ac98b3da6bed..1e11047acf54 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -1620,7 +1620,7 @@ EXPORT_SYMBOL(vme_lm_get);
  * @callback: Pointer to callback function called when triggered.
  * @data: Generic pointer that will be passed to the callback function.
  *
- * Attach a callback to the specificed offset into the location monitors
+ * Attach a callback to the specified offset into the location monitors
  * monitored addresses. A generic pointer is provided to allow data to be
  * passed to the callback when called.
  *
@@ -1655,7 +1655,7 @@ EXPORT_SYMBOL(vme_lm_attach);
  * @resource: Pointer to VME location monitor resource.
  * @monitor: Offset to which callback should be removed.
  *
- * Remove the callback associated with the specificed offset into the
+ * Remove the callback associated with the specified offset into the
  * location monitors monitored addresses.
  *
  * Return: Zero on success, -EINVAL when provided with an invalid location
-- 
2.41.0

