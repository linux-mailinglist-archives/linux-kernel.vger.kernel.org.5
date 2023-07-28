Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314C776735E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbjG1R3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbjG1R3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:29:32 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135C13A8C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:29:31 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-78706966220so23466939f.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690565370; x=1691170170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MRetka3XmHjrduRcLx8auHl/RYMdUC7YkqhFVrnaMJ4=;
        b=bP89L6dvIsj5o9kT4HZvJTW4rK3q1szR6j8h5AZVFErx80ziNL/0QSsSH0FzC5C7fE
         8wIjQLGud6CG1XEsMSUDxjnvq+IAFaBOVMbtwQGI+2u3qnecAY8kMMCWGvEgOhIRthZP
         NQVqr1kjTFzatLhzQDTlaAfpvh91DjUUQYdus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690565370; x=1691170170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MRetka3XmHjrduRcLx8auHl/RYMdUC7YkqhFVrnaMJ4=;
        b=IbK3PuqkhLYSfgtMF4NgDgfL8QXaO7IP0x0kvNUxu+tLu0MVv+OZ6XSgJRQYhbZm8q
         PJB79d9+dAbuZuxMYqgZIGJihQbq6One4um6qwXhryS/j7ngtnbXjZNyG3Ulj6KsqfCq
         8vGEGFRz88aXPdl4c6biZjnAO3auoTEX+ZRN320tyfOym5wK/n4/cQj0VjDsU/FlYm5L
         SrMN2q+q8oN1KqpGMSypl+gtJh3fyx8XhefsY5Dx4yF8p2sDL5rpZhRI399w9wqXCqwp
         yIYVaB0i3a4EW1RXYI+OfKidSBlTWiE0fjP1I+D1ZOMCDH5QFlusJ7AxaOt7ccwK85vf
         UIBw==
X-Gm-Message-State: ABy/qLZLWyVe3Wg0oyznw0Mnj7zgTQuZxCq8n0W+K3qj7Ox5MfvUKz6L
        6cfnZdoVBZcQs5jp0eGTvGbDEg==
X-Google-Smtp-Source: APBJJlG++dQGjr9Fm6NWZbXMUUHRFA6B5WaaKhVtSvn74pz3s9HPc7XbjI4la4/GVLUyqkW+AyakaQ==
X-Received: by 2002:a6b:c9d3:0:b0:788:2d78:813c with SMTP id z202-20020a6bc9d3000000b007882d78813cmr248459iof.0.1690565370474;
        Fri, 28 Jul 2023 10:29:30 -0700 (PDT)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id b2-20020a029a02000000b0042b37dda71asm1181050jal.136.2023.07.28.10.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 10:29:30 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, Liam.Howlett@oracle.com,
        anjali.k.kulkarni@oracle.com, naresh.kamboju@linaro.org,
        kuba@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, davem@davemloft.net,
        lkft-triage@lists.linaro.org, netdev@vger.kernel.org,
        llvm@lists.linux.dev, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH next 0/3] Connector/proc_filter test fixes 
Date:   Fri, 28 Jul 2023 11:29:25 -0600
Message-Id: <cover.1690564372.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This 3 patch series consists of fixes to proc_filter test
found during linun-next testing.

The first patch fixes the LKFT reported compile error, second
one adds .gitignore and the third fixes error paths to skip
instead of fail (root check, and argument checks)

Shuah Khan (3):
  selftests:connector: Fix Makefile to include KHDR_INCLUDES
  selftests:connector: Add .gitignore and poupulate it with test
  selftests:connector: Add root check and fix arg error paths to skip

 tools/testing/selftests/connector/.gitignore    | 1 +
 tools/testing/selftests/connector/Makefile      | 2 +-
 tools/testing/selftests/connector/proc_filter.c | 9 +++++++--
 3 files changed, 9 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/connector/.gitignore

-- 
2.39.2

