Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F2177C257
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbjHNVWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbjHNVW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:22:29 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF82DE65
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:22:28 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6bcae8c4072so3317696a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692048148; x=1692652948;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ETq6NHQzE5uYgQSsvIEmQ3cUO0JE3BC558iMTdYIco=;
        b=KKDCAMKrj4HWX4q8djHjfs8r1N4vuq0/bASY8fNi1pTur2ev2H1LAq8Rsp5/Ns0MW6
         CT/ZQOdZMU4t3TKUH/cKWwBKezPjuGVtV+6D0unEryohggYSLhYlQ2nanj+GdRuvFT9i
         WLrFt/lZifQC+1NwbE8xn8ZcNqZkl4Twe/Hy2iroGrSQIiqBMDbjPkwvZQyCU481K2Ko
         EGLg26Nse8Q6Ll/MeV3T4JZvm7nP5NWPL0hfODuNiYab9zDdHaeM17IZF0zMhpXhDzfS
         CKqLgPvDMTo1ZKmpG7Jydut9ZsT0uJ8LKpSn4TNEfU3qeMVeWH2o+lrWdGa6pJo6wGFK
         IUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692048148; x=1692652948;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ETq6NHQzE5uYgQSsvIEmQ3cUO0JE3BC558iMTdYIco=;
        b=DXLkd1kXtFdYv/CUvw++YK29ldmoP4XGDcA+S06VR/rYtInomHbQT69W1u6UKnLulc
         XxaqmHH+++EUzmy2PMLBkWqGXgT5I9aggnuM96iJukRW62iFuIA4EvYIfh5ll0VwpjAW
         Hkod/GZ+0odtVE9dpAlBSeaJNmt+QQjhW+RxB+0YZBW3IzeT5zROPgpHbVG9AHY1Q2zq
         6Yv+IKBDICwHujWNL0njvrtFe+zgTaSTO1UO3gCFyUwZe/JZOUXBHyqMDSECE//16CK0
         TUZsZATcEIEu9DZQGo0bvFhSiOg52xvJ97+YTL5OTC2PYYpDxHMtAWm8AnMqpKp+LTFQ
         LzGQ==
X-Gm-Message-State: AOJu0Yxyy+uFgmnfSMB01E8hHHIatJRL1V5iiSQHV1vOQObpDyPgGg2a
        432BFZd7M1SPMG0cKt//8Ok=
X-Google-Smtp-Source: AGHT+IHXuYthpQCDDePJ4+6LTcXnA+JZBl7rvir5Z2KZuy1pxO46fKlsTyaSzptXfQW3gP9gwpW2WQ==
X-Received: by 2002:a9d:6ac2:0:b0:6b9:6276:c64c with SMTP id m2-20020a9d6ac2000000b006b96276c64cmr8493872otq.12.1692048148149;
        Mon, 14 Aug 2023 14:22:28 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:86d6:7871:f7e9:8a15:865a])
        by smtp.gmail.com with ESMTPSA id t16-20020a9d7750000000b006b9cc007e87sm4696143otl.20.2023.08.14.14.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 14:22:27 -0700 (PDT)
Date:   Mon, 14 Aug 2023 18:22:22 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH] staging: vme_user: fix check lines should not end with a '('
Message-ID: <ZNqbDtRjGWq67lDJ@alolivei-thinkpadt480s.gru.csb>
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
 drivers/staging/vme_user/vme.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index bbf82b1be9f1..d0366dd3f2b1 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -1267,9 +1267,8 @@ void vme_bus_error_handler(struct vme_bridge *bridge,
 }
 EXPORT_SYMBOL(vme_bus_error_handler);
 
-struct vme_error_handler *vme_register_error_handler(
-	struct vme_bridge *bridge, u32 aspace,
-	unsigned long long address, size_t len)
+struct vme_error_handler *vme_register_error_handler(struct vme_bridge *bridge, u32 aspace,
+						     unsigned long long address, size_t len)
 {
 	struct vme_error_handler *handler;
 
-- 
2.41.0

