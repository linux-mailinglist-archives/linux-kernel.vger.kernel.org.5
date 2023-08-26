Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D327892AD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 02:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjHZAQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 20:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjHZAQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 20:16:19 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A9A26B2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 17:16:16 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-41205469f4eso7375241cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 17:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693008975; x=1693613775;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D1cp+fyJaYel+OZ1knmXDOhGjnOwMl8kMcdgE1kpwYU=;
        b=bxbFe17VGOtxx88d/sgNi+lmDP6GYR59gRG3WovOBZieZXD+mhYvrCjCAFzY6l2eiJ
         ZoLRhxNqcmwR9IlIaS/ipjOq/5IWMCPol8QDyTSdVfqBrlPivA3PO/2LRYZG0AzWUoTP
         SnoOtk24k13WC2wkVhdFmW7kob+3Oa4CvfJpOWBRNYT+I+NzX3qX9v6m1hcOwvaO9tHW
         3xSdIHZsFwk8rrFgz8buaFdLwFfkI6r9YUhQdvFUKn/bK2/gcokrnyhXBszBmhroUacy
         jHLQ+dRE0Dwgoo9ehZFMOGTrCf7I41QB9bErtYEO20ZX7nId7mltxyM5kutWC1to1np2
         uIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693008975; x=1693613775;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D1cp+fyJaYel+OZ1knmXDOhGjnOwMl8kMcdgE1kpwYU=;
        b=Yu+KYYA+ElRlrcFq/AG6QYvC0+MgW37bulTiPBbJKchiNSdPhS1pygS0U66rwRYOW6
         LCPPyvjM/OPAFCgqxa5I52kMmpq8oHzK7gHLV6kcUT8cDqWoZ6gDTazC72nOsaNPMuy0
         8RISJSYXFilANPITPu+YK3P8ULOlcP/AkTWoNe5fjDRJbEvQWleP6hyLIdF5dROce33g
         LDJkdx39tw3Edw8a4Zzmk0Qelg/3FBtR8KnpiG0cCetzOnOsV7ejEbkkUwtWwdYOMrlB
         rj5i2Ezb6rG4EHZQMQkGox2kgcHR+b72yJiGMh9/5+r+8bi1eWyKY5sfp3/R45lZ8LuQ
         xOiQ==
X-Gm-Message-State: AOJu0Yx5oOkq8cd9ya/5og92TiWj+gvL8puU/Wz70U9BXjGBpuS+iTXl
        fLspRkFsRNDSthwW5bW0V6c=
X-Google-Smtp-Source: AGHT+IGkT3JItBrPkBVmxUeW2f3DhVFy3RaN/KbkqNrcL7IWQ0QovlmKr/qYpxK06mSvbxA/P6Staw==
X-Received: by 2002:a05:622a:1048:b0:40d:78af:cf7b with SMTP id f8-20020a05622a104800b0040d78afcf7bmr25566413qte.22.1693008975075;
        Fri, 25 Aug 2023 17:16:15 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:82ea:8c7c:b784:3f92:988a])
        by smtp.gmail.com with ESMTPSA id dq7-20020a05622a520700b004120ae42859sm815831qtb.90.2023.08.25.17.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 17:16:14 -0700 (PDT)
Date:   Fri, 25 Aug 2023 21:16:10 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH] staging: vme_user: fix check lines not ending with '(' in
 vme_fake.c
Message-ID: <ZOlESk0dI80Lsu1X@alolivei-thinkpadt480s.gru.csb>
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

Fixed all CHECK: Lines should not end with a '('
as reported by checkpatch to adhere to the Linux kernel
coding-style guidelines.

Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
---
 drivers/staging/vme_user/vme_fake.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index a88d2c8a785b..dbaf050f88e5 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -403,8 +403,7 @@ static void fake_lm_check(struct fake_driver *bridge, unsigned long long addr,
 				if (((lm_base + (8 * i)) <= addr) &&
 				    ((lm_base + (8 * i) + 8) > addr)) {
 					if (bridge->lm_callback[i])
-						bridge->lm_callback[i](
-							bridge->lm_data[i]);
+						bridge->lm_callback[i](bridge->lm_data[i]);
 				}
 			}
 		}
-- 
2.41.0

