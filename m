Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE4977DB23
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 09:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242434AbjHPHbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 03:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242431AbjHPHac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 03:30:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0749210D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 00:30:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C05963768
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4116C433C7;
        Wed, 16 Aug 2023 07:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692171029;
        bh=IjU0xsme7hzmvI4HEK1ZSqT2ZAu9jNopCFcXjHtbehU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NWK2UZrzBO6aoDhOJ2padLKD5u6ti/iomybfecIB11eIT10D/lieiEGA20edkTkBr
         DkRuKB75y4hYxbtSmYT2BFJltRrj/kDzNPLfVokA1MSERq6LdvbTESp0zzeoi1i96e
         nlQgtsD7g0mWvNBjME60dt0i+eVn7NJG7g3RqbeRgKMBWH+r0wHmQoxt+Hk5Oc4B4W
         cJB+rlkvRhFPUr+OI/3cYInyStlTQUP+SONR98W2UQeyMLRbFw21Xn3oHf3BK26+yo
         HsFtJ/UwOupldUugvDB0VJ5+H4i65htDHvYkq1pwG1OSxCoFkQjPWKyn+WeXnwjurK
         eYKXL0HCmAjWw==
From:   Maxime Ripard <mripard@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 2/2] drivers: base: test: Add missing MODULE_* macros to root device tests
Date:   Wed, 16 Aug 2023 09:30:19 +0200
Message-ID: <20230816073019.1446155-2-mripard@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816073019.1446155-1-mripard@kernel.org>
References: <20230816073019.1446155-1-mripard@kernel.org>
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

Commit 06188bc80ccb ("drivers: base: Add basic devm tests for root
devices") introduced a new set of tests for root devices that could be
compiled as a module, but didn't have the usual module macros.

Make sure they're there.

Fixes: 06188bc80ccb ("drivers: base: Add basic devm tests for root devices")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/base/test/root-device-test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/test/root-device-test.c b/drivers/base/test/root-device-test.c
index 780d07455f57..9aea23c9123e 100644
--- a/drivers/base/test/root-device-test.c
+++ b/drivers/base/test/root-device-test.c
@@ -106,3 +106,7 @@ static struct kunit_suite root_device_devm_test_suite = {
 };
 
 kunit_test_suite(root_device_devm_test_suite);
+
+MODULE_DESCRIPTION("Test module for root devices");
+MODULE_AUTHOR("Maxime Ripard <mripard@kernel.org>");
+MODULE_LICENSE("GPL");
-- 
2.41.0

