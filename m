Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0732D75851F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 20:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjGRSyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 14:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjGRSyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:54:19 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EC0126;
        Tue, 18 Jul 2023 11:54:03 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4039a2b71c1so34218491cf.0;
        Tue, 18 Jul 2023 11:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689706443; x=1692298443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J/CrsgelAy4D5Z8podo/b2JgC3WEAES3DxJp/G1efUs=;
        b=Tlp0jl/6iTEc+3lhwQJ/MM+AjX6CGjfXpB4UCVWw7NTyh8c32HZcIN2mUwOYHLCOx7
         XEOfK4v78aG2381SGqx5fBTFkhyJ/HlrmZDn0ZHwWGi2aXWxrmbyWXfVHGOV0EQktLAO
         NHiUl8aWP3FUK2Eojxj1V21okaqFOtQyyXkdiodKK0XbE8NqA5dp0J21hwkk1loLzrPA
         0tkQp36uRCpfYL3bLTc6Tve4i72sz3Gn0QnKzoWOIrtdSpy+beA//GFxElrfgjNQ+jKH
         nuM7WYS78VatHpCyAwkm8AbGVkmLf/FBckfwM0m94WcxrgwygCta8DmEvdpN4kQ7KfOe
         57SA==
X-Gm-Message-State: ABy/qLbNVFmfOldM0rUmaxXqMubUmCxYry8vNTaimEDvVNg6LVkZP+Hp
        DHat+3CTsyZA+dJczMveXJo=
X-Google-Smtp-Source: APBJJlHrH0/tybuohRWeYrtPu0nss6uiitUDZIQ0BdYifYGlbtDGiSDLznYA5LAHpCalYHNjzZpXag==
X-Received: by 2002:ac8:5f95:0:b0:403:c74e:3999 with SMTP id j21-20020ac85f95000000b00403c74e3999mr17336292qta.45.1689706442750;
        Tue, 18 Jul 2023 11:54:02 -0700 (PDT)
Received: from costa-tp.bos2.lab ([5.29.20.9])
        by smtp.gmail.com with ESMTPSA id hg5-20020a05622a610500b0040353ea0827sm825193qtb.56.2023.07.18.11.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 11:54:02 -0700 (PDT)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Cc:     Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH] docs: remove tree links from the main index
Date:   Tue, 18 Jul 2023 21:51:55 +0300
Message-ID: <20230718185156.1015753-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

and leave only their neighbor subsystem-apis

because these links are already listed under
section "Core subsystems" of Documentation/subsystem-apis.rst:

    Core subsystems
    ---------------

    .. toctree::
       :maxdepth: 1

       core-api/index
       driver-api/index
       mm/index
       power/index
       scheduler/index
       timers/index
       locking/index

Reference:
- https://www.kernel.org/doc/html/next/subsystem-apis.html#core-subsystems

Motivation:
- make the documentation more organized
- increase consistency, observability and maintainability
- improve balance of ToC tree by reducing overly populated lists
- avoid duplicate parallel links
- escape tangling of links
- intention to fit the main index into one page

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 Documentation/index.rst | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 9dfdc826618c..8d8b7eab1131 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -38,10 +38,7 @@ kernel.
 .. toctree::
    :maxdepth: 1
 
-   core-api/index
-   driver-api/index
    subsystem-apis
-   Locking in the kernel <locking/index>
 
 Development tools and processes
 ===============================
-- 
2.41.0

