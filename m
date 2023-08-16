Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5211277DB22
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 09:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242427AbjHPHaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 03:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242455AbjHPHa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 03:30:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16A6B3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 00:30:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D9586102F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB71C433C8;
        Wed, 16 Aug 2023 07:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692171026;
        bh=I8ugELsiLhPi5/Uez9ANm4CZY7xS4VMhFNvjwLb/ZIw=;
        h=From:To:Cc:Subject:Date:From;
        b=YKD9qM/6bWdXyBURQWdfhoppr0z1kSukoRYEVRrlDdJfDAnmVzsdBs1SB2Jk/dVC9
         2LAs4pCg48T/vzkz3aXJVAD9gp9x125ijV1G85XJwLVV70VJgiQqKBxBqWQWIsCne6
         cgrLihpfJowqZTq2LxPt7eld5DwSD6IHXb/r7u/vOh+Zmqby8QONT/X0FLlEUeU6cV
         WHzFpKLkt/4O/PJ8cstZHuptHB4QBNOoXE+sB8Nx7BSovaD04fWeGaQEBjkQDcD1+N
         mj0gfj9B3HAQEezDsWzAJCtaxrUrVl78pkCZeewwjC3UFvtKHo8OW16kFvbln1zCjV
         CK0gbOQli4yqQ==
From:   Maxime Ripard <mripard@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 1/2] drivers: base: test: Add missing MODULE_* macros for platform devices tests
Date:   Wed, 16 Aug 2023 09:30:18 +0200
Message-ID: <20230816073019.1446155-1-mripard@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b4cc44301b9d ("drivers: base: Add basic devm tests for platform
devices") introduced a new set of tests for platform devices that could
be compiled as a module, but didn't have the usual module macros.

Make sure they're there.

Fixes: b4cc44301b9d ("drivers: base: Add basic devm tests for platform devices")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/base/test/platform-device-test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/test/platform-device-test.c b/drivers/base/test/platform-device-test.c
index 1ae5ce8bd366..ea05b8785743 100644
--- a/drivers/base/test/platform-device-test.c
+++ b/drivers/base/test/platform-device-test.c
@@ -218,3 +218,7 @@ static struct kunit_suite platform_device_devm_test_suite = {
 };
 
 kunit_test_suite(platform_device_devm_test_suite);
+
+MODULE_DESCRIPTION("Test module for platform devices");
+MODULE_AUTHOR("Maxime Ripard <mripard@kernel.org>");
+MODULE_LICENSE("GPL");
-- 
2.41.0

