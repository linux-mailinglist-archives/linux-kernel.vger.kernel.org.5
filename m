Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691CC7975AF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjIGPxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbjIGPq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:46:58 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807FF448D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:39:10 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6b9e478e122so768391a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694101094; x=1694705894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gb8EYqnyASMqqsnZ2iLYAah6l2OQpOCqu3iuHke0P/0=;
        b=KHkopzpOLMUp0vg19H7P46Q4WK1i0bpyeU5qJgsapb6/Tj9+oCS3gLRGs8xzHIhs1Y
         VZ8yUTM2h4eioYvawygEhKYzBk9nAGWQbpd+liRed1PTQNyjA5AxjE58NRXITkCxbSY+
         Q1MQ2H2BaIR/Pixdpo0KVowY7F8WyKxtdQYeYNeBPDyqeuIGhGvCvknJvOqNVFwt2HJT
         +HcuSTW93or/gigOJEOn51shRZ6wFHvJYU2MAwPQF4EIt6x5ovnwjQw1TDCELtxmkXCZ
         wylATumU4LWbjxH1PxuGmximgXI39RUn+/Rz98pOWFxx+b+JoFG7EL9sz5tUBwyseZFQ
         snAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694101094; x=1694705894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gb8EYqnyASMqqsnZ2iLYAah6l2OQpOCqu3iuHke0P/0=;
        b=BEUbTy0vHYz1WpFaj1X3NMH80R3ZHhh8+XOYNh2ukGPTnQ3/j0mgJOsYl9ExZr9ONY
         ARjamNqaxSRnQSpkONddYOQd+S+dr0NitlMaBcAtFB+rpgRnvUaIBgI2j9QnThZQxyV7
         LDLYQgedfqT/aiwuNA0SWohx3GOPCkNPEMbtKKJrXbmFDgxKF7/re9j1iSIwjEOTQ2VW
         6RqvNFbcdTnwAEY3cYmAoR+eZ7dBoel89ddX+d1EPrM8crqt/nuAtPd3p/Luf67Au4nY
         rKS7OKt8QNyByxLvQv2LE2rHfNpYR/1Gpdyr7IBVbRAZJcQVnYv0VeDXV4mXNq+Mla16
         wOVw==
X-Gm-Message-State: AOJu0YwZOjUXq0lRhKnTJuEIxx0rPi1lfejkCf0mOYc14qqSOfxHUAEU
        XDZu5kxrMcvmxsA/JF6THaH9DDhktHM7b2LtioBjXA==
X-Google-Smtp-Source: AGHT+IHq9zupsfJmVjaj0Q6U+++liIcrHH5PBFa/Uec0t8DPMoJUynQPWH8/OnfYyZAhvgd1JzqsDg==
X-Received: by 2002:a05:6a20:974f:b0:14c:f4e1:d9e9 with SMTP id hs15-20020a056a20974f00b0014cf4e1d9e9mr15072708pzc.45.1694073771758;
        Thu, 07 Sep 2023 01:02:51 -0700 (PDT)
Received: from localhost.localdomain ([124.123.167.146])
        by smtp.gmail.com with ESMTPSA id y19-20020a62b513000000b00689f1ce7dacsm11778001pfe.23.2023.09.07.01.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 01:02:50 -0700 (PDT)
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
To:     linux-kselftest@vger.kernel.org
Cc:     skhan@linuxfoundation.org, beaub@linux.microsoft.com,
        linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH] selftests: user_events: create test-specific Kconfig fragments
Date:   Thu,  7 Sep 2023 13:32:09 +0530
Message-Id: <20230907080209.223478-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create the config file in user_events directory of testcase which
need more kernel configuration than the default defconfig. User
could use these configs with merge_config.sh script:

The Kconfig CONFIG_USER_EVENTS=y is needed for the test to read
data from the following files,
  - "/sys/kernel/tracing/user_events_data"
  - "/sys/kernel/tracing/user_events_status"
  - "/sys/kernel/tracing/events/user_events/*"

Enable config for specific testcase:
(export ARCH=xxx #for cross compiling)
./scripts/kconfig/merge_config.sh .config \
                tools/testing/selftests/user_events/config

Enable configs for all testcases:
(export ARCH=xxx #for cross compiling)
./scripts/kconfig/merge_config.sh .config \
                tools/testing/selftests/*/config

Cc: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 tools/testing/selftests/user_events/config | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/user_events/config

diff --git a/tools/testing/selftests/user_events/config b/tools/testing/selftests/user_events/config
new file mode 100644
index 0000000000000..64f7a9a90cec4
--- /dev/null
+++ b/tools/testing/selftests/user_events/config
@@ -0,0 +1 @@
+CONFIG_USER_EVENTS=y
-- 
2.30.2

