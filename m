Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3EA7FC923
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 23:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346185AbjK1WL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 17:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbjK1WL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 17:11:28 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BBDD5D;
        Tue, 28 Nov 2023 14:11:34 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-777745f1541so344769885a.0;
        Tue, 28 Nov 2023 14:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701209493; x=1701814293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=smmd9kiR3daHT08sErSgxntxOfc7UlUmITupKqw2V0c=;
        b=XWiAnZH1uQkF9kS7WrjX+/xF+BkTowVcBwwx3KE4wOHEA9hvZ4Ua1SLH7hsRsBleDZ
         p+ZnZFqV0WSTjh37+vbFrpuIx8h7cmxIjCCEX6dZMdQ6dAnUpgCfewpwEauY4SdXqsu2
         u9OZXLJXqgtVRcI1v4l1zswsEgAY4XH2ce46t6FEjQEh9eD84/Z1LLKy00bjNvpPIXzJ
         oK9G7sIT2tD1hLH6r5XnUJyNW9Ke8YmZadJC8X5pSADl3Ja4UcKaYb2GW7baoxzB0B10
         weglkHMMHBmQGU7WgsgCl36r30Dztp8K9GwDpk4knYxHhU7+Jsb2q9WePO434v1sLoL7
         DO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701209493; x=1701814293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=smmd9kiR3daHT08sErSgxntxOfc7UlUmITupKqw2V0c=;
        b=h5I9QJHQjh38VHqkk/A5aFJw7WujGYt4n/DPN6lCp/YIZ+ndZzdi2nrUhFuQN5+Ibf
         foQfDHkJUu8mQE+NDKu7JzaQpRzYh4VUk1FtvDgXZPzEfD0ZMErTnFQf58KU8HVGROEE
         MAS7Zm3g69DAkrMTiEPIcKLkcrq/VvxsrQP0tOjNpFwTHYLolRb6SNiCUbQjEpTRh402
         rDoA/bIMV3EMxpznwuvIIxOVgSHZR04wPPFZi0peu3zfn8DFEuyzhflQrs720KsQ9uFl
         k3m9zSfSsFG2UkaBOJqLQvLmBeYcNckkb6lmto05A4tj5DGuMEbW++fBX9LuRCI3e4ML
         WjOg==
X-Gm-Message-State: AOJu0YzaG35gIJS4yPo+eV89JLUTYy08aaYl4jAmgwJOsNIXC6gJhaJG
        JBGejCTxXMGiIETyTfZJYkI=
X-Google-Smtp-Source: AGHT+IHHqwVc8SvRXmif3h+061EREXCzwmz1UC8lMM25VJt2rpTg19U4o5b4qIr0XZad2Fj2jk4P1g==
X-Received: by 2002:a05:620a:8718:b0:77d:5c49:b4f3 with SMTP id px24-20020a05620a871800b0077d5c49b4f3mr15289011qkn.47.1701209493722;
        Tue, 28 Nov 2023 14:11:33 -0800 (PST)
Received: from angquan-linux.. ([72.36.119.4])
        by smtp.gmail.com with ESMTPSA id ea11-20020a05620a488b00b0077d93c7c785sm3144056qkb.119.2023.11.28.14.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 14:11:33 -0800 (PST)
From:   angquan yu <angquan21@gmail.com>
X-Google-Original-From: angquan yu
To:     skhan@linuxfoundation.org
Cc:     shuah@kernel.org, seanjc@google.com, pbonzini@redhat.com,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        angquan yu <angquan21@gmail.com>
Subject: [PATCH] Resolve Macro Expansion Warning in nx_huge_pages_test.c
Date:   Tue, 28 Nov 2023 16:11:05 -0600
Message-Id: <20231128221105.63093-1-angquan21@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: angquan yu <angquan21@gmail.com>

This commit fixes a compiler warning in the file
x86_64/nx_huge_pages_test.c, which was caused by improper
macro expansion of '__TEST_REQUIRE'.

Warning addressed:
- The warning was triggered by the expansion of the '__TEST_REQUIRE'
macro, indicating a potential issue in how the macro was being
used or expanded.

Changes made:
- Modified the usage of the '__TEST_REQUIRE' macro to ensure proper
expansion. This involved explicitly passing the expected magic token
(MAGIC_TOKEN) and a descriptive error message to the macro.
- The fix enhances clarity in the macro usage and ensures that
the compiler correctly interprets the intended logic, thereby
resolving the warning.

Signed-off-by: angquan yu <angquan21@gmail.com>
---
 tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
index 18ac5c195..323ede6b6 100644
--- a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
+++ b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
@@ -259,7 +259,8 @@ int main(int argc, char **argv)
 	__TEST_REQUIRE(token == MAGIC_TOKEN,
 		       "This test must be run with the magic token %d.\n"
 		       "This is done by nx_huge_pages_test.sh, which\n"
-		       "also handles environment setup for the test.");
+		       "also handles environment setup for the test.",
+			   MAGIC_TOKEN);
 
 	run_test(reclaim_period_ms, false, reboot_permissions);
 	run_test(reclaim_period_ms, true, reboot_permissions);
-- 
2.39.2

