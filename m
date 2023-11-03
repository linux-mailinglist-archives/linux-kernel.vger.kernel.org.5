Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C527E081E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 19:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbjKCS2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 14:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbjKCS2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 14:28:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC872DB
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 11:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699036052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tCQTZTtBGHUcOzfNPoWKgA+n3Zp3rKItoxbSjEs0GKE=;
        b=Kyp1LLj89KfwiLqdjlRIuEAFcGphbDA7CM/asGpVqZ66C+RBbifyW27rYWwqWzMO/flxfN
        /bWW2i8Pr1n7zKiwXdY5gCgfGq0CJ0c0VN3zbraRMIKKO0rIQoGI7Ipe+k3GJbvI2R1STa
        z+laGdy1AIbkhX0Afpl6uaPPsO2bBuw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-dmATparcOzqhWsHJ-sPZaA-1; Fri, 03 Nov 2023 14:27:29 -0400
X-MC-Unique: dmATparcOzqhWsHJ-sPZaA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5401de6ce9eso456203a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 11:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699036048; x=1699640848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tCQTZTtBGHUcOzfNPoWKgA+n3Zp3rKItoxbSjEs0GKE=;
        b=Ts02zWUJmLUoJyrDAFlZnB72C7rCqVGV8jtbxFydAO0TnxfenMTPEM6fiBBdwKatvj
         zbW/V9rINZ5sgs6fACYoT0Z6yB7/henvIL9JIW9qnwNaAwFjz3zXagjn2QUiqpzBU8TG
         nZ3DlV3bUpcrAGUBpYzwDFFu0f6cAs94zOfGe/KlLB2WycI1NMhmKpf7rjQzEgdC201Q
         uw2J+FlnG8puY/LHkCF6rOsUqHCIaw3yUkhpicbwGjeA2BsTwSQ6oZdNCOSXC0WHSrNE
         FgjlCRfDoWBf52++9ooyzXOaigdDQcU2ah/yHjnvwEnXcGz2bL9fuzaOUudTn7VjBkKX
         MFxQ==
X-Gm-Message-State: AOJu0YxJC1mc/rKgVoV/t39ztDX5M9Y5t54FDePxUGDYaUNEY6wHhziQ
        lRfJ1bL7mrjssobhedh2aAKtVcXJaA48H+uw5hqoMzTbpH9fQmljJ8B72xPV8dTLvxiNIMIOmfx
        I7uAsfHwUpFI7SddvUGTtDBb/
X-Received: by 2002:a05:6402:f0a:b0:544:3966:6904 with SMTP id i10-20020a0564020f0a00b0054439666904mr873182eda.2.1699036048592;
        Fri, 03 Nov 2023 11:27:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/afJoWCH0B69Fkx5QSe1FwXqsA2+HGUFWSQOKo++oLG5JDy6JNH3qK4i1hA0DdwxaL+aeiA==
X-Received: by 2002:a05:6402:f0a:b0:544:3966:6904 with SMTP id i10-20020a0564020f0a00b0054439666904mr873173eda.2.1699036048291;
        Fri, 03 Nov 2023 11:27:28 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.fritz.box ([2001:9e8:32d1:5200:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id v23-20020a50d597000000b0053dd8898f75sm1250103edi.81.2023.11.03.11.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 11:27:28 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Dave Airlie <airlied@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jocelyn Falempe <jfalempe@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v2] drm/ast: use managed devres functions
Date:   Fri,  3 Nov 2023 19:25:43 +0100
Message-ID: <20231103182542.97589-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, tha ast-driver just maps the PCI-dev's regions with
pcim_iomap(). It does not actually reserve the regions exclusively
with, e.g., pci_request_regions().

Replace the calls to pcim_iomap() with ones to pcim_iomap_regions() to
reserve and map the regions simultaneously.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
Changes in v2:
- Remove unnecessary return code checks for pcim_iomap_regions()
  (Jocelyn)

Thx Jocelyn for the kind review
---
 drivers/gpu/drm/ast/ast_main.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_main.c b/drivers/gpu/drm/ast/ast_main.c
index dae365ed3969..8b714b99f9d6 100644
--- a/drivers/gpu/drm/ast/ast_main.c
+++ b/drivers/gpu/drm/ast/ast_main.c
@@ -444,9 +444,11 @@ struct ast_device *ast_device_create(const struct drm_driver *drv,
 	if (ret)
 		return ERR_PTR(ret);
 
-	ast->regs = pcim_iomap(pdev, 1, 0);
-	if (!ast->regs)
-		return ERR_PTR(-EIO);
+	ret = pcim_iomap_regions(pdev, BIT(1), 0);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ast->regs = pcim_iomap_table(pdev)[1];
 
 	/*
 	 * After AST2500, MMIO is enabled by default, and it should be adopted
@@ -461,9 +463,10 @@ struct ast_device *ast_device_create(const struct drm_driver *drv,
 
 	/* "map" IO regs if the above hasn't done so already */
 	if (!ast->ioregs) {
-		ast->ioregs = pcim_iomap(pdev, 2, 0);
-		if (!ast->ioregs)
-			return ERR_PTR(-EIO);
+		ret = pcim_iomap_regions(pdev, BIT(2), 0);
+		if (ret)
+			return ERR_PTR(ret);
+		ast->ioregs = pcim_iomap_table(pdev)[2];
 	}
 
 	if (!ast_is_vga_enabled(dev)) {
-- 
2.41.0

