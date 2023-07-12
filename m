Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1C975117C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 21:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjGLTqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 15:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjGLTqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 15:46:35 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C7C1FDA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:46:34 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-668730696a4so4256757b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689191194; x=1691783194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=klYbycvplGJ1ytkS4a6ghIwucAHaphSST8O3II0SxfE=;
        b=SF0LZwHlIBt0vqg2YFHKZnZdPEL2qnJzclU3byf+jX1jPF6H3Q9mB4oUsPJTkPybX4
         vAMh5JPh/MvbcrsFoWms9c7vZ+coAOwUjdI7/n0TtcsKm+vlQgl4+3o4a4+VTeW+QKYx
         2Qz/Zhw8GEQBoFkrNZTwdckz2H1PkB29hYJt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689191194; x=1691783194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=klYbycvplGJ1ytkS4a6ghIwucAHaphSST8O3II0SxfE=;
        b=lxPtaZQf3kyRpjccKyu5fXKy4AG1uVk8CHS6xh/xdDMdESdyUrdBP+uYQJVLv38s2I
         PSbnhEN/ADrryJ2GrInKZgzVnlwvpCe4jbNTz7LS94obKubaDIjVniYcHg+Pcj9d9mvd
         aUdR1y9Qf2tC4FYAvb+Pc75PcU54/P+L94hVm991lp2Rejr9GAcEbXiFSbNkB8xYSbfs
         n/Q0jFMbVEx4VHpPcQsUptAyq+HoOYEhU1L8Y9DLosufclalOBrBKWgqGEQgMhlpgqVq
         grooHGQ831YMimp3t+iKZTnanGYK145XR1lQthoP0T94/YV+ZrH3fsZjEhaDbPMSX4UT
         vUZg==
X-Gm-Message-State: ABy/qLYSXZWuQ3+E31C716RlFtl8lwH8+DdMcAcbyB/MDaEC+nNiSNST
        APQZxN84l7w8vqJgq8ptoDckwA==
X-Google-Smtp-Source: APBJJlE8PzaPsG36V1KguOraP6XGsTq/gkvisldTxFDpG16GYfzF90jDF3mpcjO4jm82e5W3NEhxGQ==
X-Received: by 2002:a05:6a00:856:b0:682:759c:644d with SMTP id q22-20020a056a00085600b00682759c644dmr19272948pfk.27.1689191193907;
        Wed, 12 Jul 2023 12:46:33 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j5-20020a62e905000000b0068338b6667asm1173687pfh.212.2023.07.12.12.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 12:46:33 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Foolishly claim maintainership of string routines
Date:   Wed, 12 Jul 2023 12:46:29 -0700
Message-Id: <20230712194625.never.252-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=910; i=keescook@chromium.org;
 h=from:subject:message-id; bh=oRDbPOiITIWo0E4ckhRol5nzE7VgmQjMV1y8KYTho0o=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkrwMV4Y4d4oGGuW8WNHhsUrlk6bUkoWNQHLLfk
 9tN6hMoZxaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZK8DFQAKCRCJcvTf3G3A
 Jk+aEACOLRAnc7Jsi9PcMFldWEo+qh0n2f6Btz2DIOEcu1HKKDpG8LfFti1reP7orag5vNwuCBr
 rQ591NJ3We5LGxUzhgiHXU7l7FWBMMQLFsrJdDpTKUwFXvUhyvjm/tohghFt+IBwcZiQTH4vHDM
 8Qia8sVLbkjC9t2V5srd3O5Rbn1DwVr2k/Kz+wDwNZEvAC6mM5aKM4MAWjgCwsp/xCfZfMK3hFC
 lc+XLoq1fQGk5S5EzmKhDBYvhoUM0GDho4DuBNIL0NLqVUt/QR3jX1jMWQzAR2CSgqZ0TKQbux7
 /5zcwna8LshNhXCRGlWBi3eFJgMUQ72BZyAq/BY5pbI7D+88KErb+d2JhJprvV2dsltxhRjLJLD
 koNf7Q8f8sAb+S1bA5yqYgBOrTdMywI+qbuPU1X6zYuWD0TA0U3YDVXUtLjEB7Qpj9h1UtHb7oN
 pg73NJmyyW+CYHk5e08oEoKWkLuiUM+K6Gy67RHzR7y29moqPxWTdjWERbMbbkfWvLfe7nO75Hv
 tPQQ/lmB9/8+hvnlj72018PmbsvP1HcEW9VZtuXYlhgvCojmLNSmfPYnUW+bpkCuVfS4Z0DBEJm
 Fwqe5e/SHYnfn/V3duGpc4YgylsH+c//mpPRyxVx1ihCIiJuJJEZjbIXgevebT6nIyXhaOe4M/U
 su+QIfZL hV1uDpg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the string API is tightly coupled with FORTIFY_SOURCE, I am
offering myself up as maintainer for it. Thankfully Andy is already a
reviewer and can keep me on the straight and narrow.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 MAINTAINERS | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3be1bdfe8ecc..b639d6123856 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8672,8 +8672,11 @@ S:	Maintained
 F:	drivers/input/touchscreen/resistive-adc-touch.c
 
 GENERIC STRING LIBRARY
+M:	Kees Cook <keescook@chromium.org>
 R:	Andy Shevchenko <andy@kernel.org>
-S:	Maintained
+L:	linux-hardening@vger.kernel.org
+S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
 F:	include/linux/string.h
 F:	include/linux/string_choices.h
 F:	include/linux/string_helpers.h
-- 
2.34.1

