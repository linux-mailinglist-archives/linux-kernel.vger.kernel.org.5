Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33A07AB8B8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbjIVR5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbjIVR5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:57:20 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06B31735
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:53:33 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-690ba63891dso2030257b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405213; x=1696010013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j1DuAf/+ZW6v7oQmMqiRSnBOde6Jc28Je383H2K4ozI=;
        b=eFZseXVf3N54HDMPfBZVTq8gxWB33isNnuzfv0E4vdm6Bgy9ZXBdWX7Df5t37kQWVl
         f9xEpdadh/mbflQhfemsXRjKD7WuKpeGqS5ttW0wB6c/SP4kC504N9Yy+Gxhi9FYJqnD
         IwW8y+vf6iVyDLUA2klcdt+JGTqP1ZanCXJoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405213; x=1696010013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1DuAf/+ZW6v7oQmMqiRSnBOde6Jc28Je383H2K4ozI=;
        b=fcjCHvCTysSZKxfZHaFxHrOcSAC0MsGGmnQwwt2H4/RZcy2SvVPJ+7fKNNcWhMpiA7
         ZSmxftBLVhKu6p3X2qHLFHyFe7jXYl4Ak3YNuw7t+0QUl64t6G8LfzVBdN66joBF90Dl
         Q79NqyKJxwb3uxqkhvO5jvix25JPgE4Lqb2Kg0lljZfEO4RBDkELhDWuTNohkPSOuK88
         pOjUuJFNAC2Y0c/39D/h1fBR+iKp3O5YJDDNRu3Rh4F8f8B7XelEC1/7H94fuSsD+1LV
         rS5+LGcj9eLkaukxvpCFsNe7KLgwXghqvfxEMJmp7OHZomK+ZY9ldvAcB5DXbiXKj+Xy
         g/cQ==
X-Gm-Message-State: AOJu0Yw7A40B8OLRu58uwXPIj8rifiIY3g8X9niLewS/oUo1mvu/t3q5
        t4upAw72hkD/43z+go0NoaWmVA==
X-Google-Smtp-Source: AGHT+IFXuq8R136xW5nVqkU1923m0VVoi8A+AfdyU6CNk0S0T0wMiLniXuESANSpe0yEyArZHXB0TQ==
X-Received: by 2002:a05:6a00:1ac9:b0:690:c1e5:937e with SMTP id f9-20020a056a001ac900b00690c1e5937emr140303pfv.13.1695405212835;
        Fri, 22 Sep 2023 10:53:32 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x25-20020a62fb19000000b006889081281bsm3434175pfm.138.2023.09.22.10.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:53:32 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Support Opensource <support.opensource@diasemi.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] regulator: da9062: Annotate struct da9062_regulators with __counted_by
Date:   Fri, 22 Sep 2023 10:53:31 -0700
Message-Id: <20230922175330.work.066-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1309; i=keescook@chromium.org;
 h=from:subject:message-id; bh=jyjltd9IGcWvOg910fwXOz2T1bioU2VSJx7SDglJoh4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdSbKq2clcu9Od4D1cu0Gb37wvavMtZYXO0ui
 +p2R9xoGOaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UmwAKCRCJcvTf3G3A
 Jhe6D/0T4QS0EkQ2zac2mAd9FiPbgfHmVh7ksYNRfnLOFwWHQ2OKYTrlpZ4DlKKed6BR/5EGsHM
 PLvNIlPwb6qlX5en77saxlwegJJdG6/Zu0Z28nQ9q2jQooHTLdjGFIAkohpGXx7M6TRqWWaJbKM
 LLYWoOv/xnvAih0XvHN3aSbp/Sw7x8P9GmDOpK1S33ArIsPL3qh6DiYppwS7PAOl54GHR1w6dJs
 6LfowXTPErRdxa3jYFmyba0DB3T5C42AwH55S3NI14xWiRTT3gt4G43i3QV071LUgzWdSwIJlPB
 sH8pVJ2gQIenwfsxWs5lcjlxGYO+znS0K+DCQzFjJPBSLXkJXfBOc+FKRE2tb8FsubbGJGGlThc
 zEomQvNHUJtMW1MT5XNMF2+M9i1LE4ljJh8n/UKr01gCynJCW0wULsrCTc8xdq4wlVTUK0tYaos
 7EyN4lSEzHG9OCqm2vZ6KCKPkBiUZv/WI0dWvn4GEZPwDhc8ZiERFJlfgiEyW+Pd2XVNmCFOGlS
 XbOqvWlu9gaL7C1niB1AZmyE2LU39p93sqhuCQrOYWEJRk86PluoJ7cmk1vpi4OPJJo1oQZ8Mik
 ZEoaKsT8ewvGg01yU7Cdf5vF4Z8Cfp3xS1JGFZc8UCpslNWVvCDqvpTajtGEuxA7B4wCJwz37Gb
 uAmi8qe frPhTiOA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct da9062_regulators.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Support Opensource <support.opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/regulator/da9062-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index 1d354db0c1bd..e0c96f10e570 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -73,7 +73,7 @@ struct da9062_regulators {
 	int					irq_ldo_lim;
 	unsigned				n_regulators;
 	/* Array size to be defined during init. Keep at end. */
-	struct da9062_regulator			regulator[];
+	struct da9062_regulator			regulator[] __counted_by(n_regulators);
 };
 
 /* Regulator operations */
-- 
2.34.1

