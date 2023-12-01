Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBA0800311
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 06:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377464AbjLAFgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 00:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjLAFgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 00:36:48 -0500
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B10A1703
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 21:36:51 -0800 (PST)
Received: from localhost.localdomain (unknown [111.52.6.202])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id DBB7E8000B5;
        Fri,  1 Dec 2023 13:36:06 +0800 (CST)
From:   Hu Haowen <2023002089@link.tyut.edu.cn>
To:     gregkh@linuxfoundation.org, akpm@linux-foundation.org
Cc:     Hu Haowen <2023002089@link.tyut.edu.cn>, masahiroy@kernel.org,
        ndesaulniers@google.com, n.schier@avm.de, ojeda@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] scripts/show_delta: reformat code
Date:   Fri,  1 Dec 2023 13:35:40 +0800
Message-Id: <20231201053540.9534-1-2023002089@link.tyut.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZQ0JMVhlLHUIZQ0wdSE1JTFUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKSlVOSVVNVUlLSVlXWRYaDxIVHRRZQVlLVUtVS1VLWQY+
X-HM-Tid: 0a8c23e08a49b03akuuudbb7e8000b5
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Py46Mhw6DDw2SxUuKjRLHh8q
        ORowCwNVSlVKTEtKT0tDQk1DSE9NVTMWGhIXVUlLSUhLS0lLQ0I7FxIVEFUPAg4PVR4fDlUYFUVZ
        V1kSC1lBWUpKSlVOSVVNVUlLSVlXWQgBWUFISktMNwY+
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
 scripts/show_delta | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/scripts/show_delta b/scripts/show_delta
index 291ad65e3089..33446adce74b 100755
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
@@ -81,9 +81,9 @@ def main():
 	base_str = ""
 	filein = ""
 	for arg in sys.argv[1:]:
-		if arg=="-b":
-			base_str = sys.argv[sys.argv.index("-b")+1]
-		elif arg=="-h":
+		if arg == "-b":
+			base_str = sys.argv[sys.argv.index("-b") + 1]
+		elif arg == "-h":
 			usage()
 		else:
 			filein = arg
@@ -92,7 +92,7 @@ def main():
 		usage()
 
 	try:
-		lines = open(filein,"r").readlines()
+		lines = open(filein, "r").readlines()
 	except:
 		print ("Problem opening file: %s" % filein)
 		sys.exit(1)
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

