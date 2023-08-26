Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5364E7897B4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 17:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjHZPV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 11:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjHZPVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 11:21:33 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD3A172D
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 08:21:31 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a85cc7304fso1391842b6e.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 08:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693063291; x=1693668091;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hd7adZZYOTiFa760wWHbvro1iAu1WnMNCa9ih8fX4BY=;
        b=rIfVMQCJThxrfongc1TNXRgOCpwRWM5Y/NYtBN5JZETFs5eqaD03F7yoPgwSZa24sk
         OZhaJcG3CoHGlVv7t9FwJ3GO9hqz4tlmrySztdY9UQqitMFgTwF0n78h187Odv6rRvPP
         iN1VXUva6lSBtt+7FG8qq4QI44R7Spv0LdwDpWy8817HCS6oAlrREDumSpSKrfI3c8dS
         1WLmRz73M0WHo5usq1XyCAE883blLbLC9KAf8pzB6f15m4QfTyIIaD+JEoCT2svPeNlZ
         /SpQXz0RIgmTwoowd9Jf5erDA8uzo353IhLnVfD3EE4NZ/9qMacc+MjC+8ngVzn0xyJb
         nuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693063291; x=1693668091;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hd7adZZYOTiFa760wWHbvro1iAu1WnMNCa9ih8fX4BY=;
        b=T6y3Ex+gb2dJKlzSm7v1xY/Lxgv8fsb7pkbqo2wNP5Uvk3dgHmMaL4F967QCn2L8WB
         GSzlB+ITP5eGAe8t9jQ7vMjYDy0MAtF9GHmYt+90gT51OXgDv6MceBQXmRGLg8UFyQ1f
         OrFgYWdO3EXZPqHt+YjRrXSEfeI2SiJT/zJwqfe0HuC8+yz5xaKBs5YDZCcITGZeZBeA
         zc66BPMx5jcn6QUiOX3kGMB+nkBAPef9H+2SNtEaerCvh8tGmd+UUSC+hdxIFUjTRUuX
         Vm0U1H/EnzyrHnbwm8nccdIZpvciwq4G4mEPpTy00Uan0Tdv3/n74ALRpPvL57cIK8lI
         vDfg==
X-Gm-Message-State: AOJu0Yx+fTucP6+4m7gpTycOuK5ZrRV2ADgWZvroQdMRxkzDwdo7hasv
        8l+9KPGfCQgSy55h2DvG6zlqjRH/QC8=
X-Google-Smtp-Source: AGHT+IGMBg02sEa4hS1aKKX+LM72sLA42B9wE6fuIYdZvvSb5r5V5/YYMKA0SV+5mK4w9Cu+YGvb+g==
X-Received: by 2002:aca:1716:0:b0:3a9:bc8d:42c3 with SMTP id j22-20020aca1716000000b003a9bc8d42c3mr1663122oii.50.1693063290941;
        Sat, 26 Aug 2023 08:21:30 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:82ea:8c7c:b784:3f92:988a])
        by smtp.gmail.com with ESMTPSA id q12-20020a056808200c00b003a89019d5fesm1780379oiw.51.2023.08.26.08.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 08:21:30 -0700 (PDT)
Date:   Sat, 26 Aug 2023 12:21:25 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v2 4/4] staging: vme_user: fix check unnecessary space after
 a cast in vme_fake.c
Message-ID: <ZOoYdRNn/XYbzKqU@alolivei-thinkpadt480s.gru.csb>
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

Fixed all CHECK: No space is necessary after a cast
as reported by checkpatch to adhere to the Linux kernel
coding-style guidelines.

Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
---

Changes in v2:
- Fixed summary phrase with tags to indicate commit order
in the patch series, noted by Greg KH

 drivers/staging/vme_user/vme_fake.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index 4258ed6033e7..4ccb16dd0d0b 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -95,7 +95,7 @@ static void fake_VIRQ_tasklet(unsigned long data)
 	struct vme_bridge *fake_bridge;
 	struct fake_driver *bridge;
 
-	fake_bridge = (struct vme_bridge *) data;
+	fake_bridge = (struct vme_bridge *)data;
 	bridge = fake_bridge->driver_priv;
 
 	vme_irq_handler(fake_bridge, bridge->int_level, bridge->int_statid);
@@ -1092,7 +1092,7 @@ static int __init fake_init(void)
 	mutex_init(&fake_device->vme_int);
 	mutex_init(&fake_bridge->irq_mtx);
 	tasklet_init(&fake_device->int_tasklet, fake_VIRQ_tasklet,
-		     (unsigned long) fake_bridge);
+		     (unsigned long)fake_bridge);
 
 	strcpy(fake_bridge->name, driver_name);
 
-- 
2.41.0

