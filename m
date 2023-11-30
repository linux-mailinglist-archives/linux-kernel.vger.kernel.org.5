Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EB07FF2D9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346073AbjK3OtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346068AbjK3OtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:49:17 -0500
X-Greylist: delayed 581 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Nov 2023 06:49:21 PST
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDE2D46
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:49:21 -0800 (PST)
Received: from localhost.localdomain (unknown [120.208.100.109])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 6677D800089;
        Thu, 30 Nov 2023 22:38:50 +0800 (CST)
From:   Hu Haowen <2023002089@link.tyut.edu.cn>
To:     gregkh@linuxfoundation.org, akpm@linux-foundation.org
Cc:     Hu Haowen <2023002089@link.tyut.edu.cn>, masahiroy@kernel.org,
        ndesaulniers@google.com, n.schier@avm.de, ojeda@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/show_delta: reformat code
Date:   Thu, 30 Nov 2023 22:38:22 +0800
Message-Id: <20231130143822.17173-1-2023002089@link.tyut.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSBhJVkpLGUoeTkkeSkhOT1UTARMWGhIXJBQOD1
        lXWRgSC1lBWUpJS1VJS0NVSktLVUpLQllXWRYaDxIVHRRZQVlLVUtVS1VLWQY+
X-HM-Tid: 0a8c20ab0f65b03akuuu6677d800089
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MUk6MBw4Ejw*Fhc1PC5LLS9W
        GR0wC0hVSlVKTEtKSE5OSkhKTk9CVTMWGhIXVUlLSUhLS0lLQ0I7FxIVEFUPAg4PVR4fDlUYFUVZ
        V1kSC1lBWUpJS1VJS0NVSktLVUpLQllXWQgBWUFJQ0tDNwY+
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct some lines in irregular coding style to make them look more
harmonious and fit the common coding regulations in Python.

Signed-off-by: Hu Haowen <2023002089@link.tyut.edu.cn>
---
 scripts/show_delta | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/show_delta b/scripts/show_delta
index 291ad65e3089..f5e42780ee7b 100755
--- a/scripts/show_delta
+++ b/scripts/show_delta
@@ -13,7 +13,7 @@ import sys
 import string
 
 def usage():
-	print ("""usage: show_delta [<options>] <filename>
+	print("""usage: show_delta [<options>] <filename>
 
 This program parses the output from a set of printk message lines which
 have time data prefixed because the CONFIG_PRINTK_TIME option is set, or
@@ -46,7 +46,7 @@ def get_time(line):
 		raise ValueError
 
 	# split on closing bracket
-	(time_str, rest) = string.split(line[1:],']',1)
+	(time_str, rest) = string.split(line[1:], ']', 1)
 	time = string.atof(time_str)
 
 	#print "time=", time
@@ -82,7 +82,7 @@ def main():
 	filein = ""
 	for arg in sys.argv[1:]:
 		if arg=="-b":
-			base_str = sys.argv[sys.argv.index("-b")+1]
+			base_str = sys.argv[sys.argv.index("-b") + 1]
 		elif arg=="-h":
 			usage()
 		else:
@@ -111,19 +111,19 @@ def main():
 					(time, rest) = get_time(line)
 				except:
 					continue
-				if string.find(rest, base_str)==1:
+				if string.find(rest, base_str) == 1:
 					base_time = time
 					found = 1
 					# stop at first match
 					break
 			if not found:
-				print ('Couldn\'t find line matching base pattern "%s"' % base_str)
+				print('Couldn\'t find line matching base pattern "%s"' % base_str)
 				sys.exit(1)
 	else:
 		base_time = 0.0
 
 	for line in lines:
-		print (convert_line(line, base_time),)
+		print(convert_line(line, base_time),)
 
 if __name__ == "__main__":
 	main()
-- 
2.34.1

