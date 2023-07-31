Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BA3768D46
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjGaHKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjGaHJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:09:59 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C124335A6;
        Mon, 31 Jul 2023 00:08:27 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbea14706eso38350835e9.2;
        Mon, 31 Jul 2023 00:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690787281; x=1691392081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfPe6oOYMMedBDB4xd574gcfMtPjOKfspfZcrHbarSk=;
        b=Cdnwf6zqQRk63GK1qy1/wvGs1oNzayMz08OpJcs+yhi/U80Uhm8GHkWzp6bAe+dVxm
         BHEofR6deiExpvMh5+0wRclXXQDNNxFVJBcesCSzW+MIMCif7sl+EYgDdS6lZQtOOuiK
         ivlpcMTAT4h8xbhQZklWioPSWOtYGtdWhkLN6az7Sj6g/chFLvB1EhJBaj9a5oaF0skY
         QQRwc50G/SFSCn3GyKscTq7Gtq4LFpxHLkcn2fIHJ94ryxtEH6MmIgpjXkdiKqf1+hKb
         zI6Pm8XuJni1d1drKG2ytivtMcDy4qz77eO+NRcv+uIn3YNzJlze1zw3+XISIl3mounl
         jJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690787281; x=1691392081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfPe6oOYMMedBDB4xd574gcfMtPjOKfspfZcrHbarSk=;
        b=FkXVMP3lg7wOvzCozbOQrB8O0I1ylZhmUIRh3UL4fHvoUZpQCqLu0mePC6aCE+oufS
         PQBSyXGV913cwrtYOZRgv3ZOahseA9fyvM3zncH+ITQwqsR+BLUyeFXgpoDHQ5fBSsSy
         +PY4XX5Yn9f5rxu0CMLQ89e9wj4wecK3x3iGAhnxPHcs7KpRW4IM//y7mEGt/YJHqCwO
         zl9P5LD4YNPNboGJItrdNH7/flSPrYtNa+OgiwxhDOvHiJpYHg44TX7SYAOJSIg+Dk2K
         JnUmGBZkWy8R48k05lVYZ6XE1GjOLxZt0pE1MkzRDAp0LHufm2YO7ijLKVCQTwu513Yz
         TF7A==
X-Gm-Message-State: ABy/qLbwiy9SG3IocM+Ra097ylllCYft1VGhcvURA8r5KYewh6Q/DkzK
        jKc8kAqckkD9hznpXSkATnDTH4GzFRR9nhuG
X-Google-Smtp-Source: APBJJlGupX3Wu9zlyxclnQH5I+YVUadh5sPcJ5XhfbMabFHBpNn8tRTHMj3IClfdyefQ0bOp5LzxNA==
X-Received: by 2002:a05:600c:b54:b0:3fa:9348:51a8 with SMTP id k20-20020a05600c0b5400b003fa934851a8mr4368451wmr.23.1690787280696;
        Mon, 31 Jul 2023 00:08:00 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.65.235])
        by smtp.gmail.com with ESMTPSA id l10-20020a05600c1d0a00b003fd2d3462fcsm15114098wms.1.2023.07.31.00.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 00:08:00 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com,
        john.johansen@canonical.com, alison.schofield@intel.com,
        ztarkhani@microsoft.com
Cc:     Khadija Kamran <kamrankhadijadj@gmail.com>
Subject: [PATCH 2/2] lsm: split cap_capget() declaration to multiple lines
Date:   Mon, 31 Jul 2023 12:07:32 +0500
Message-Id: <e5d8757c7f9108aaf4bc2fd904b75244d2393174.1690786467.git.kamrankhadijadj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1690786466.git.kamrankhadijadj@gmail.com>
References: <cover.1690786466.git.kamrankhadijadj@gmail.com>
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

cap_capget(...) LSM hook declaration exceeds the 80 characters per line
limit. Split the function declaration to multple lines to decrease the
line length.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 include/linux/security.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 8b7d0b2ec1a4..fef65d0e522d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -145,7 +145,8 @@ extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 extern int cap_settime(const struct timespec64 *ts, const struct timezone *tz);
 extern int cap_ptrace_access_check(struct task_struct *child, unsigned int mode);
 extern int cap_ptrace_traceme(struct task_struct *parent);
-extern int cap_capget(const struct task_struct *target, kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted);
+extern int cap_capget(const struct task_struct *target, kernel_cap_t *effective,
+					  kernel_cap_t *inheritable, kernel_cap_t *permitted);
 extern int cap_capset(struct cred *new, const struct cred *old,
 		      const kernel_cap_t *effective,
 		      const kernel_cap_t *inheritable,
-- 
2.34.1

