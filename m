Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F171767007
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbjG1PCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237301AbjG1PCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:02:09 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564362115;
        Fri, 28 Jul 2023 08:02:00 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9a828c920so36329441fa.1;
        Fri, 28 Jul 2023 08:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690556518; x=1691161318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4RwtXxw18kFYFi2O6VgR0yT2o2eoXEI7h/e+lf2SMqQ=;
        b=E6fh8Cd/oWqNYEuaYRga4hh31zIDKc5UymmfTHUgU89GmVQeA5uqP69u0/20Lf1Y6f
         oKdPmOmhGbm6eVo616eZ9TrETZDTnXb0NSy+8rzPKic9IaRyv+IcA23Ed0gKN2YuMiI9
         v04BuKX+jsW5bTuNQfax85LEsbOaGbLnXH//Cwpmn0gBZZZjzXmD8xocd7KVraw33mh1
         l//m1nlNUo+KCROaibxKQFJGogZl8/AS8wPGDvaZrqdkqkiK6Ps2ldMPZzjRZQdcQRqC
         Dy4jJtPzwQ5TOtAYznt7q6mb9aRtZeNtoqVDAJ5D15tl0SHgxI1t7LnlWuHPbJcl4HIO
         LPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690556518; x=1691161318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4RwtXxw18kFYFi2O6VgR0yT2o2eoXEI7h/e+lf2SMqQ=;
        b=M4dthWw3jTeCuFL+aFKSoS8NQRgd+jArQHwMpj1/A5BTr1FJ42ymGj9VU3tfZ+zfcO
         SJ4hVJGVQyYZFkfOB5Xe+bgz/FxdLffGtav8QCcOUdUb8Lx7HTMCiiFTFtPNpxFLR/Ry
         CSfgvCuVtYXMLyd0RdM/RntJMnTY84F7AsDX/x2Lsx/ohI8q2L4xHqq5mp2mU5s326Ua
         uCvCCYpjGgR6OdzFkZ3FmB8qtT7O47v5+OpONRT4Pux3/XYcASQpzhJRUT9ZcWPMf4Ad
         UB9X6yYoG5hTpyPrWfddqWANYfFPZ59tzXENo4scrHxPYVFwR0hmtfmQPz2QCA5wUPxl
         BekQ==
X-Gm-Message-State: ABy/qLaOb80oER4X6tzDLTM/49a30p4uWpCr+hdA4cQLnPXV82Z/+dCJ
        lc4P/3wCZ+MlpE3FAFLpPIl0Detly+7Scc87
X-Google-Smtp-Source: APBJJlFQAVfUBUyJXfWkU3cS8hGu68loqdZgOE6UGRBNDbKB4lcWTpdzptYB7LUTFMgq12y/0Na14w==
X-Received: by 2002:a2e:7807:0:b0:2b6:e958:5700 with SMTP id t7-20020a2e7807000000b002b6e9585700mr2028137ljc.4.1690556518144;
        Fri, 28 Jul 2023 08:01:58 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-157-016.77.0.pool.telefonica.de. [77.0.157.16])
        by smtp.gmail.com with ESMTPSA id w23-20020a170906481700b009927d4d7a6bsm2143370ejq.53.2023.07.28.08.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 08:01:57 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] selinux: log about VM being executable by default
Date:   Fri, 28 Jul 2023 17:01:49 +0200
Message-Id: <20230728150150.16224-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case virtual memory is being marked as executable by default, SELinux
checks regarding explicit potential dangerous use are disabled.

Inform the user about it.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
   shorten message as suggested by Paul
---
 security/selinux/hooks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5194f12def97..7cd687284563 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7265,6 +7265,8 @@ static __init int selinux_init(void)
 	cred_init_security();
 
 	default_noexec = !(VM_DATA_DEFAULT_FLAGS & VM_EXEC);
+	if (!default_noexec)
+		pr_notice("SELinux:  virtual memory is executable by default\n");
 
 	avc_init();
 
-- 
2.40.1

