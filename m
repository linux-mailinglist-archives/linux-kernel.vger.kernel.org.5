Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1689773FCD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjHHQx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbjHHQwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:52:32 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130871885E;
        Tue,  8 Aug 2023 08:58:22 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-26825239890so4128439a91.0;
        Tue, 08 Aug 2023 08:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691510296; x=1692115096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pZIpxuSKG9EQkolkGeP/rvx1DBX6Mw4KQhG+pRiomJA=;
        b=FF9HIA1PnJSoFjb8FNWQz5QzfErNThTLrSL1IWY23CJkIEul77UOAsY5hrv2K3n3h0
         94SMufHF/jQlzHenn7TCZmKHY4kQ3LYnMcgw/viCmBXV0A7FOXsbnNUOMkACHorJIZGE
         ofcU34cdXdvPqx76U6Im9kBaSjH2UlSOwdRhj0tAPQuXGM4HJ36eR9CEHzFGEr4zVs0r
         JVJM2NDQYiqOmCd/LPz6EQwBN+VnDI1iweQ1IluuQRDrMcCHI94Eyiq+ERIF7agMfQLK
         jYj2PjezLe+Qbj4BLq4RZd47Ecnf3UFE0mpc5DRF2lDYHcmkDUxJRvwN4RH7UFGAgCAE
         ocgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510296; x=1692115096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZIpxuSKG9EQkolkGeP/rvx1DBX6Mw4KQhG+pRiomJA=;
        b=FmoqYUfustIO+nVb0OLCXTVfIgWhs0pwxmTsq5+mokMxGiCQWYksKU7KI+vpeu5MdW
         Kul6X4bpB4RNZkRxvI+E6zG0EINSlcSViMh9oH4Xo7EJ7FCgf03HtVZQfQQDHw6JH5DW
         trA0/59QSG+GoFpNQxQf47fB+N1noAGRAdQZMUOvlx0uv8PZd2GMWmzgf6AqMN3Qv0uY
         J4h1qk9utz3i8FM2ie4S5OO7Ru9If3Gtj+vuzzS5ivQjjflk2COEcEpdWK1naJeqUeq7
         +nEtHJDsXUqDn78pZZId9P2nyxQZygYiGGSV+vtO3TmwORrzg2i2Un70Dgufu61GQaO1
         fnyQ==
X-Gm-Message-State: AOJu0YwWAmWyzvwoHV42bXnwJCR5FPb5cfNf4Y8C3rJjJ5sPhSWc+deA
        T7cAgNE8KGKH5ICHOheuF9w=
X-Google-Smtp-Source: AGHT+IE+ekEamcrQdo8s1rENYDlsoOEFNWmwxyOsFCAaTqyR8sJUFQ9ziTAQiZ2/16nOZS35z2BcfA==
X-Received: by 2002:a17:90b:360a:b0:269:439d:8c3f with SMTP id ml10-20020a17090b360a00b00269439d8c3fmr7829559pjb.22.1691510295827;
        Tue, 08 Aug 2023 08:58:15 -0700 (PDT)
Received: from linux.lan ([2409:8a1e:21bd:e0e0:d532:b5f:45fb:48d5])
        by smtp.gmail.com with ESMTPSA id k4-20020a17090a910400b00262d9b4b527sm8053542pjo.52.2023.08.08.08.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 08:58:15 -0700 (PDT)
From:   Wei Zhang <zhangweilst@gmail.com>
To:     corbet@lwn.net, paulmck@kernel.org, rostedt@goodmis.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Zhang <zhangweilst@gmail.com>
Subject: [PATCH] Documentation: RCU: fix section numbers after adding Section 7 in whatisRCU.rst
Date:   Tue,  8 Aug 2023 23:58:11 +0800
Message-Id: <20230808155811.550575-1-zhangweilst@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Wei Zhang <zhangweilst@gmail.com>
---
 Documentation/RCU/whatisRCU.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index e488c8e557a9..60ce02475142 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -59,8 +59,8 @@ experiment with should focus on Section 2.  People who prefer to start
 with example uses should focus on Sections 3 and 4.  People who need to
 understand the RCU implementation should focus on Section 5, then dive
 into the kernel source code.  People who reason best by analogy should
-focus on Section 6.  Section 7 serves as an index to the docbook API
-documentation, and Section 8 is the traditional answer key.
+focus on Section 6 and 7.  Section 8 serves as an index to the docbook
+API documentation, and Section 9 is the traditional answer key.
 
 So, start with the section that makes the most sense to you and your
 preferred method of learning.  If you need to know everything about

base-commit: 14f9643dc90adea074a0ffb7a17d337eafc6a5cc
-- 
2.34.1

