Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188037C86D2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 15:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjJMN30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 09:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjJMN3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 09:29:24 -0400
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830CA95
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 06:29:20 -0700 (PDT)
Received: from localhost.localdomain (unknown [120.208.100.128])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id B8A4380003D;
        Fri, 13 Oct 2023 21:28:46 +0800 (CST)
From:   Hu Haowen <2023002089@link.tyut.edu.cn>
To:     gregkh@linuxfoundation.org
Cc:     Hu Haowen <2023002089@link.tyut.edu.cn>, masahiroy@kernel.org,
        akpm@linux-foundation.org, ndesaulniers@google.com,
        n.schier@avm.de, ojeda@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/show_delta: add __main__ judgement before main code
Date:   Fri, 13 Oct 2023 21:28:32 +0800
Message-Id: <20231013132832.165768-1-2023002089@link.tyut.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSEJIVhpLQ09CQx9NGklOHVUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpJS1VJS0NVSktLVUpJQ1lXWRYaDxIVHRRZQVlPS0hVSkpLSEpDVUpLS1VLWQY+
X-HM-Tid: 0a8b2939aaebb03akuuub8a4380003d
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6P006Nzo6Izw2HAhJTygaGSsd
        GAMKC0hVSlVKTUJMSUtITElMTEpOVTMWGhIXVUlLSUhLS0lLQ0I7FxIVEFUPAg4PVR4fDlUYFUVZ
        V1kSC1lBWUpJS1VJS0NVSktLVUpJQ1lXWQgBWUFKTElCNwY+
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing Python programming it is a nice convention to insert the if
statement `if __name__ == "__main__":` before any main code that does
actual functionalities to ensure the code will be executed only as a
script rather than as an imported module. Hence attach the missing
judgement to show_delta.

Signed-off-by: Hu Haowen <2023002089@link.tyut.edu.cn>
---
 scripts/show_delta | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/show_delta b/scripts/show_delta
index 28e67e178194..291ad65e3089 100755
--- a/scripts/show_delta
+++ b/scripts/show_delta
@@ -125,4 +125,5 @@ def main():
 	for line in lines:
 		print (convert_line(line, base_time),)
 
-main()
+if __name__ == "__main__":
+	main()
-- 
2.34.1

