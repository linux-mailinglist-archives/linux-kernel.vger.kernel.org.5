Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC3A76C44F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 06:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjHBEzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 00:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjHBEzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 00:55:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058D81BFA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 21:55:12 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3724gs7m010188;
        Wed, 2 Aug 2023 04:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=vc/7WSOuh6cWhE5ykLDo46lNfe9kjgqo/J5DK5M+6r4=;
 b=prQ0xwv28PYk7j6jC4COxvXAvvNDW3nf1OqEbgSj2H0MfEsybVuCZg7feJZPCtIdiUOS
 Wq4gBZepTwZKrK9bfeab7sRlfSdiPADnCdD2NpXVD+Abr65n3Io8HvVhQ+D2D5RGuBWU
 kTa2ZnsqGxSb8nIhXXdz7KqnzOQO839woX9OfRFUiMwe4BaITM1pArqyrBf6vMIAA/yR
 JvGRpByuFpReI8k/vVskUU58ybj/cmuSw5i/2XGZk2jbv0GHmrNrCbWM6Wjr8zfMpYYm
 usvXyWIYBF7SlrjOwpp1gBBx1IqNJs3j71adGdDXs37ytUihmGEIfAS4nwd28LNJgd86 Aw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s7gc080v6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 04:54:37 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3724saW6009884
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 04:54:36 GMT
Received: from hu-gurus-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 1 Aug 2023 21:54:36 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        Kees Cook <keescook@chromium.org>,
        "Bjorn Andersson" <andersson@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Subject: [PATCH 1/1] scripts: Add add-maintainer.py
Date:   Tue, 1 Aug 2023 21:54:29 -0700
Message-ID: <0d000c48e939beaa97c744c0a8b652396a0b045d.1690951441.git.quic_gurus@quicinc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1690951441.git.quic_gurus@quicinc.com>
References: <cover.1690951441.git.quic_gurus@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7QLohHK_WQTobbPAg2hEEpffrDB8WcNU
X-Proofpoint-GUID: 7QLohHK_WQTobbPAg2hEEpffrDB8WcNU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_02,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=498 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 clxscore=1011 impostorscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020044
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This script runs get_maintainer.py on a given patch file and adds its
output to the patch file in place with the appropriate email headers
"To: " or "Cc: " as the case may be. These new headers are added after
the "From: " line in the patch.

Currently, maintainers are added as "To: ", mailing lists are added as
"Cc: " and all others are addded as "Cc: " as well.

The script is quiet by default (only prints errors) and its verbosity
can be adjusted via an optional parameter.

Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
---
 scripts/add-maintainer.py | 82 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100755 scripts/add-maintainer.py

diff --git a/scripts/add-maintainer.py b/scripts/add-maintainer.py
new file mode 100755
index 000000000000..942d331cf8d4
--- /dev/null
+++ b/scripts/add-maintainer.py
@@ -0,0 +1,82 @@
+#! /usr/bin/env python3
+
+import argparse
+import logging
+import os
+import sys
+import subprocess
+import re
+
+def add_maintainers_to_file(patch_file):
+    # Run get_maintainer.pl on patch file
+    logging.info("Patch: {}".format(os.path.basename(patch_file)))
+    cmd = ['scripts/get_maintainer.pl']
+    cmd.extend([patch_file])
+    p = subprocess.run(cmd, stdout=subprocess.PIPE, check=True)
+    logging.debug("\n{}".format(p.stdout.decode()))
+
+    entries = p.stdout.decode().splitlines()
+
+    maintainers = []
+    lists = []
+    others = []
+
+    for entry in entries:
+        entity = entry.split('(')[0].strip()
+        if "maintainer" in entry:
+            maintainers.append(entity)
+        elif "list" in entry:
+            lists.append(entity)
+        else:
+            others.append(entity)
+
+    # Specify email headers appropriately
+    to_maintainers  = ["To: " + m for m in maintainers]
+    cc_lists        = ["Cc: " + l for l in lists]
+    cc_others       = ["Cc: " + o for o in others]
+    logging.debug("To Maintainers:\n{}".format('\n'.join(to_maintainers)))
+    logging.debug("Cc Lists:\n{}".format('\n'.join(cc_lists)))
+    logging.debug("Cc Others:\n{}".format('\n'.join(cc_others)))
+
+    # Edit patch file in place to add maintainers
+    with open(patch_file, "r") as pf:
+        lines = pf.readlines()
+
+    from_line = [i for i, line in enumerate(lines) if re.search("From: ", line)]
+    if len(from_line) > 1:
+        logging.error("Only one From: line is allowed in a patch file")
+        sys.exit(1)
+
+    next_line_after_from = from_line[0] + 1
+
+    # Reverse lists to maintain same order as in get_maintainer.py output
+    # as we will be insert()-ing the elements
+    to_maintainers.reverse()
+    cc_lists.reverse()
+    cc_others.reverse()
+
+    for o in cc_others:
+        lines.insert(next_line_after_from, o + "\n")
+    for l in cc_lists:
+        lines.insert(next_line_after_from, l + "\n")
+    for m in to_maintainers:
+        lines.insert(next_line_after_from, m + "\n")
+
+    with open(patch_file, "w") as pf:
+        pf.writelines(lines)
+
+def main():
+    parser = argparse.ArgumentParser(description='Add the respective maintainers and mailing lists to patch files')
+    parser.add_argument('patches', nargs='*', help="One or more patch files")
+    parser.add_argument('--verbosity', choices=['debug', 'info', 'error'], default='error', help="Verbosity level of script output")
+    args = parser.parse_args()
+
+    logging.basicConfig(level=args.verbosity.upper(), format='%(levelname)s: %(message)s')
+
+    for patch in args.patches:
+        add_maintainers_to_file(patch)
+
+    logging.info("Maintainers added to all patch files successfully")
+
+if __name__ == "__main__":
+    main()
-- 
2.40.0

