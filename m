Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7D87E3656
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 09:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbjKGIHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 03:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKGIHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 03:07:51 -0500
X-Greylist: delayed 387 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Nov 2023 00:07:47 PST
Received: from sym2.noone.org (sym.noone.org [178.63.92.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C57EA;
        Tue,  7 Nov 2023 00:07:47 -0800 (PST)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4SPgdp2ctLzvjhV; Tue,  7 Nov 2023 09:01:17 +0100 (CET)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] indirect_call_wrapper: Fix typo in INDIRECT_CALL_$NR kerneldoc
Date:   Tue,  7 Nov 2023 09:01:17 +0100
Message-Id: <20231107080117.29511-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_05,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a small typo in the kerneldoc comment of the INDIRECT_CALL_$NR
macro.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 include/linux/indirect_call_wrapper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/indirect_call_wrapper.h b/include/linux/indirect_call_wrapper.h
index c1c76a70a6ce..adb83a42a6b9 100644
--- a/include/linux/indirect_call_wrapper.h
+++ b/include/linux/indirect_call_wrapper.h
@@ -11,7 +11,7 @@
  *  @__VA_ARGS__: arguments for @f
  *
  * Avoid retpoline overhead for known builtin, checking @f vs each of them and
- * eventually invoking directly the builtin function. The functions are check
+ * eventually invoking directly the builtin function. The functions are checked
  * in the given order. Fallback to the indirect call.
  */
 #define INDIRECT_CALL_1(f, f1, ...)					\
-- 
2.42.0

