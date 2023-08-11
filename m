Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BDD7799FD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 23:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237103AbjHKV4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 17:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbjHKV4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:56:19 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7740A273E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 14:56:18 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5840ea40c59so28156637b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 14:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691790977; x=1692395777;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lT6tvtL3J1wO3rO58ecG8VmDi6hvumDUq9zV3VFr4l0=;
        b=4zR6Gk7b5WgoYYkjgHkbEdMl0Npa1klK7G6HU823mI4KCGMmE2ACU7FKX/Rx7djRWM
         vPSXX8RvxhZhN5BTdzsj7HLLyaKkJiaR/AWNiekKwSXCI0hZJBgaHMal2R1ulnpyTIKT
         Z4yV5rrzP91cKJNttjtv59XAZFBbEovwcSq3KhLeb9Mb2QbVPmOgqsddE91asxnnNnAf
         a2off5mhdEoIqCUh2baX3eqv5OzsUpFVQlJIo9QD/SPpjfqtgJdpld9NHRqSe0Q2xxVu
         /yST74GcCCA4NGu9cTHbIvHYTjCIAu+QwMK0U1NjBwXQfqopCDiAAHhj97LjOvCLXE6R
         qnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691790977; x=1692395777;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lT6tvtL3J1wO3rO58ecG8VmDi6hvumDUq9zV3VFr4l0=;
        b=IrgrjSreWWo4IrjInWgxM86c5fRzJfMcttqcL1O+G5XYrEemD7M0el5wJw4YirgCfK
         y2BsatJEiF1tl7IlVWjUUV9BnZzyEdsrm7+1jcbOZmfgug2czjbviZocWDVe6xEoq+z7
         sWi8JoWmWPcaY2QgpaHilDzCE5/HjpbMP3JlJ3rXfh/EUNHrQcBaBHXritU9Fftwejin
         A+QOlb6e7xjaZ6dnJwSywbeB5gZaqpGBmddC0PKMS+XtjEcEu6aWN4DJ1Idtb04VLzsI
         3fNdcMYVBp4QQ8Dxt0WrONrn1Q0F/2PtEvMwjIAT6poEnRoZ0+2t9ESZf3/85rZ/o7yw
         6sfg==
X-Gm-Message-State: AOJu0YwlRHqlwbGKeeaeNlXlQ2ql/GGqZjV7tiHrCGgOjZVAJed/q5os
        mDGBi39L/1uxVjdd33PHpUe4dbHjLOHhCRfnKg==
X-Google-Smtp-Source: AGHT+IHeErCF9oRJ+YjqL0nvzOSVKIvENViCdgPR6lX/nLxioPJPIyxxMS3l/0/J8uWK2yZvq5UVWwCZX9DkbYQAPQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:b64e:0:b0:589:a5c6:4a8f with SMTP
 id h14-20020a81b64e000000b00589a5c64a8fmr56998ywk.6.1691790977740; Fri, 11
 Aug 2023 14:56:17 -0700 (PDT)
Date:   Fri, 11 Aug 2023 21:56:15 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAH6u1mQC/x3MQQqAIBBA0avErBvQzKiuEi3EphwKixEikO6et
 HyL/zMkEqYEY5VB6ObEZyzQdQU+uLgR8lIMjWqM6rVGJz5gMoPCnSTSgUPXL8q21rfWQckuoZW ffznN7/sBkre9I2IAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691790976; l=1354;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=BDgTepl8ANjK7Fi3fsCGrvFDBI6wG66OFrFJ5xRKuj8=; b=S/xRL7ar/FEQsFKSEeFdyltpdmxSXJiVn2g8hnPqMJK9IO8SDw/aPXvJH2qtnHOc8yzvexD8g
 bE0kNvLPxekBCOjoY8gK0ym/jwQORc9w0odpV6vX7mocLqzapcpEAmr
X-Mailer: b4 0.12.3
Message-ID: <20230811-arch-s390-kernel-v1-1-7edbeeab3809@google.com>
Subject: [PATCH] s390/ipl: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

Use `strscpy_pad` which has the same behavior as `strncpy` here with the
extra safeguard of guaranteeing NUL-termination of destination strings.
In it's current form, this may result in silent truncation if the src
string has the same size as the destination string.

Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 arch/s390/kernel/ipl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 85a00d97a314..a6dcf6f28197 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -266,7 +266,7 @@ static ssize_t sys_##_prefix##_##_name##_store(struct kobject *kobj,	\
 		struct kobj_attribute *attr,				\
 		const char *buf, size_t len)				\
 {									\
-	strncpy(_value, buf, sizeof(_value) - 1);			\
+	strscpy_pad(_value, buf, sizeof(_value));			\
 	strim(_value);							\
 	return len;							\
 }									\

---
base-commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f
change-id: 20230811-arch-s390-kernel-968d0545c45a

Best regards,
--
Justin Stitt <justinstitt@google.com>

