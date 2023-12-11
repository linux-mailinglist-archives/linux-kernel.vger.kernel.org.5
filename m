Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EFF80D401
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344741AbjLKRgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344682AbjLKRgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:36:11 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D3ED9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:36:17 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-28654179ec0so4606892a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702316177; x=1702920977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPdVH85PHNtuHkJ/XiXbqX9ARcJdxzQjA4e5Iwg8PSI=;
        b=erGnks2RnRzOnAcHT0XCzdswdDjVCJwbvyspo84P8CmKxSOzeBeMs8OlsYsacTKoIy
         EfIY6c4XGHgCtvzWbH7+X5codzm3BSxE1v51Dnr2NeToF+1gTfpcQzgQt5YXQgxWLdiO
         hWC0+Q9jxOzVxCU2mjpRKQtFQuHeFxkqEZAjIubGb7iJxePEryIE2ZmDvmLJFoWs2/DG
         T01eQ3aOmu8Eza8abx4Lnxkc3lRkS5+s7aW9nBVyBXSxmrwf25eYshutcbulL8qpgYAD
         umC23Wqetp8NCai0/ocICUvGbJxC7arrv8bUOT232D8w0O/1QGFA+QDTUIDcV/JTtA07
         zEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702316177; x=1702920977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZPdVH85PHNtuHkJ/XiXbqX9ARcJdxzQjA4e5Iwg8PSI=;
        b=RFzPzktA9k4yZzDJvhEmymcteMOWGsCswR4DIlDMlzmeXBiqMRyiH09YGSWgSBau+C
         X0JxkDxzVKtQ1GsJZYtyAlXG93JSY0gwfqGMtlDSiE5JyPKRPrv8ydTn0HxcBPtlRkm/
         4yn9a0tzzdhsZ5WikW+onRgatlshrUMi0Ncs+Vp+Q155Xhv6PEm1TW9OX4W8u+z4NiPl
         7F8n2A/8traA3HL02n5uHxV5e68bEnc/GUzJ00QzHE7OXWBgMx4I4rBs87abxEL4Bahb
         JFJtOoc2/jeDDNHli0ZuQvK09AgDSaCh5te+iV5BFQeQo5eb1udS/LbGOhbWNev0YXAO
         V6eg==
X-Gm-Message-State: AOJu0YwnRNkoltALz9nCpyVwUqYdQsmhwr6UBZqiiIY4DhfJNBK2UqJP
        4r/UzbeQx6sBIV1U9ZWGBXgFPhUIJl/lci3x
X-Google-Smtp-Source: AGHT+IH/W/nbswz7bhHu2QiqSHXIYb5UCTsYZ0FXUQ5NvIRoPZBU0dkpIWMTXVMkKtN0uXyArYbiPQ==
X-Received: by 2002:a17:90b:3803:b0:285:d32c:670f with SMTP id mq3-20020a17090b380300b00285d32c670fmr3641131pjb.10.1702316176759;
        Mon, 11 Dec 2023 09:36:16 -0800 (PST)
Received: from yqt-VirtualBox ([223.166.246.87])
        by smtp.gmail.com with ESMTPSA id mm22-20020a17090b359600b00286901e226bsm8776565pjb.28.2023.12.11.09.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:36:16 -0800 (PST)
From:   Piro Yang <piroyangg@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Piro Yang <piroyangg@gmail.com>, linux-staging@lists.linux.dev,
        Linux Outreachy <outreachy@lists.linux.dev>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging:vme_user:fix the issue of using the wrong error code
Date:   Tue, 12 Dec 2023 01:36:10 +0800
Message-Id: <20231211173610.106501-1-piroyangg@gmail.com>
X-Mailer: git-send-email 2.25.1
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

the error code of ENOSYS indicates Invalid system call number, but there is not system call

Signed-off-by: Piro Yang <piroyangg@gmail.com>
---
 v2: split two different changes,
     only fix the issue of wrong error code
---
 drivers/staging/vme_user/vme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index 5c416c31ec57..9bc2d35405af 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -341,7 +341,7 @@ int vme_slave_set(struct vme_resource *resource, int enabled,
 
 	if (!bridge->slave_set) {
 		dev_err(bridge->parent, "Function not supported\n");
-		return -ENOSYS;
+		return -EINVAL;
 	}
 
 	if (!(((image->address_attr & aspace) == aspace) &&
-- 
2.25.1

