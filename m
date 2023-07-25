Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E61A761D6C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjGYPdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjGYPdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:33:52 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677311FD0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:33:51 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-760dff4b701so69484239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690299230; x=1690904030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=psCANlN8ACjqTR5+3XCODQFlRe+14Lhpu8FtMgSALfM=;
        b=XwyLWIwxqnXL7pdpixAZ7q7aZfXrtB5N3jrb9CGtJQgmoaMsAFjc824pcQav2Y8nFz
         dN9U2IHD3t3dFCcUkGiv9g6fRURFGoyvqHGwYrax1UqC+4ubXYd6IgxqMJptSbhO53Ki
         hXI7K1tKTwyp2MagRqI+xh6QKutgKA+929GC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690299230; x=1690904030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=psCANlN8ACjqTR5+3XCODQFlRe+14Lhpu8FtMgSALfM=;
        b=NnfNjheoHEThPW3AcUXM+6GqujO/X2/xJ/nDY3eR2epiQSr5k9FP4gx1eWccOvoiBm
         px0ZW35CBHU7Mrm5wL2wnW4//8XQBMQ9ToEdon4dDJ8kXJ6fRbDUVWhToPLoxwhLt1pC
         EuS9cnG2daCMj88eF7WWW0OhvRWJ28hj7Q4oDcgWIfEE3p4j+nJmnILren4BEtwd+UzG
         tJdtDe3mGWD9aF944qc4S6v5jtk5rkjWYh6ID+MyU0QYew+BTlq+qQZ9/IAwmsTD6qit
         lTNylrBWG35apD/fLXvkI8fp5Mow0GSZT9BUDCqUn1+TsrlejvjATD6F7S0+derQn3u9
         lHVw==
X-Gm-Message-State: ABy/qLbAtFaCGbFp2JJsnd/Go13p5rbzQbmE/TDLgXcERCaPccs5LAi4
        RdfsiCTQuUkBbLvsp1sbzkLp0g==
X-Google-Smtp-Source: APBJJlF7kccJ981q5CKsoJuFOTcAmWiQ82hFVPTu/ZADMUjQKNsZTHiZLqgFuMaVxnjNgiqvLsCSyQ==
X-Received: by 2002:a92:908:0:b0:345:e438:7381 with SMTP id y8-20020a920908000000b00345e4387381mr8802640ilg.2.1690299230778;
        Tue, 25 Jul 2023 08:33:50 -0700 (PDT)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id k8-20020a02a708000000b0042b394eb984sm3743384jam.105.2023.07.25.08.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 08:33:50 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests:prctl: add set-process-name to .gitignore
Date:   Tue, 25 Jul 2023 09:33:49 -0600
Message-Id: <20230725153349.15048-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add newly addded set-process-name test to .gitignore

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/prctl/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/prctl/.gitignore b/tools/testing/selftests/prctl/.gitignore
index 7a657b25f686..05d5e31661df 100644
--- a/tools/testing/selftests/prctl/.gitignore
+++ b/tools/testing/selftests/prctl/.gitignore
@@ -3,3 +3,4 @@ disable-tsc-ctxt-sw-stress-test
 disable-tsc-on-off-stress-test
 disable-tsc-test
 set-anon-vma-name-test
+set-process-name
-- 
2.39.2

