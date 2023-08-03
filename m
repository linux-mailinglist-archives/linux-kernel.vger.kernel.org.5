Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B320076E30D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbjHCI15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbjHCI1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:27:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D45530E9;
        Thu,  3 Aug 2023 01:24:41 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3737tbtU032470;
        Thu, 3 Aug 2023 08:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=1T2SHlTzR6Ii3RiDiKaGIXZyjoMhDyDBhYYiiUzz9fw=;
 b=VwnqxwoVEIUYEuz3QqU40gRbbQFdVZ6mrnqsC6SD7Q3SktqiBdm4R5Hfj+1uq0sLlx0I
 oI8nkbbfWU6W/L1cOIUA2KartbBBw/cn2uz1aMVi9KK1/Znp/vQqC69EIYu7grDNzW2b
 5XDn/mkKqpn7/FfPb29HgOgVTRLfU7ZaxsF//Q4moDlQfJQIrbU/dEDk+IY212AayF7o
 6yPrPD+AaVunVnYttD9WeRMNNQ4HGzQMXGIfzI3cpF4dV7MaIufMmdp5lCBMjyAXUYoO
 Gdlu0NPH5dChsiB1mgGKSXA2q7D5SG4OPLOCFDeziKonuuCBS1HYc1ZN6GoCEC7nleL2 EQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s7gc0b8n7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 08:23:24 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3738NNhF024143
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Aug 2023 08:23:23 GMT
Received: from hu-gurus-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 3 Aug 2023 01:23:22 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        Kees Cook <keescook@chromium.org>,
        "Bjorn Andersson" <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, Will Deacon <will@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <quic_pkondeti@quicinc.com>, <u.kleine-koenig@pengutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Subject: [PATCH v2 1/1] scripts: Add add-maintainer.py
Date:   Thu, 3 Aug 2023 01:23:16 -0700
Message-ID: <829b08342568735095bbd3f8c44f435f44688018.1691049436.git.quic_gurus@quicinc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1691049436.git.quic_gurus@quicinc.com>
References: <cover.1691049436.git.quic_gurus@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AQu_1VTD7jrRC4meHdZMJ2OS-FGXwutY
X-Proofpoint-GUID: AQu_1VTD7jrRC4meHdZMJ2OS-FGXwutY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_06,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=998 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 clxscore=1011 impostorscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308030073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This script runs get_maintainer.py on a given patch file and adds its
output to the patch file in place with the appropriate email headers
"To: " or "Cc: " as the case may be. These new headers are added after
the "From: " line in the patch.

Currently, for a single patch, maintainers are added as "To: ", mailing
lists and all other roles are addded as "Cc: ".

For a series of patches, however, a set-union scheme is employed in
order to solve the all-too-common problem of sending subsets of a patch
series to some lists, which results in important pieces of context such
as the cover letter being dropped. This scheme is as follows:
- Create set-union of all mailing lists corresponding to all patches and
  add this to all patches as "Cc: "
- Create set-union of all other roles corresponding to all patches and
  add this to all patches as "Cc: "
- Create set-union of all maintainers from all patches and use this to
  do the following per patch:
  - add only that specific patch's maintainers as "To: ", and
  - the other maintainers from the other patches as "Cc: "

Please note that patch files that don't have any "Maintainer"s
explicitly listed in their `get_maintainer.pl` output will not have any
"To: " entries added to them; developers are expected to manually make
edits to the added entries in such cases to convert some "Cc: " entries
to "To: " as desired.

The script is quiet by default (only prints errors) and its verbosity
can be adjusted via an optional parameter.

Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
---
 scripts/add-maintainer.py | 113 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)
 create mode 100755 scripts/add-maintainer.py

diff --git a/scripts/add-maintainer.py b/scripts/add-maintainer.py
new file mode 100755
index 000000000000..b1682c2945f9
--- /dev/null
+++ b/scripts/add-maintainer.py
@@ -0,0 +1,113 @@
+#! /usr/bin/env python3
+
+import argparse
+import logging
+import os
+import sys
+import subprocess
+import re
+
+def gather_maintainers_of_file(patch_file):
+    all_entities_of_patch = dict()
+
+    # Run get_maintainer.pl on patch file
+    logging.info("GET: Patch: {}".format(os.path.basename(patch_file)))
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
+    all_entities_of_patch["maintainers"] = set(maintainers)
+    all_entities_of_patch["lists"] = set(lists)
+    all_entities_of_patch["others"] = set(others)
+
+    return all_entities_of_patch
+
+def add_maintainers_to_file(patch_file, entities_per_file, all_entities_union):
+    logging.info("ADD: Patch: {}".format(os.path.basename(patch_file)))
+
+    # For each patch:
+    # - Add all lists from all patches in series as Cc:
+    # - Add all others from all patches in series as Cc:
+    # - Add only maintainers of that patch as To:
+    # - Add maintainers of other patches in series as Cc:
+
+    lists = list(all_entities_union["all_lists"])
+    others = list(all_entities_union["all_others"])
+    file_maintainers = all_entities_union["all_maintainers"].intersection(entities_per_file[os.path.basename(patch_file)].get("maintainers"))
+    other_maintainers = all_entities_union["all_maintainers"].difference(entities_per_file[os.path.basename(patch_file)].get("maintainers"))
+
+    # Specify email headers appropriately
+    cc_lists        = ["Cc: " + l for l in lists]
+    cc_others       = ["Cc: " + o for o in others]
+    to_maintainers  = ["To: " + m for m in file_maintainers]
+    cc_maintainers  = ["Cc: " + om for om in other_maintainers]
+    logging.debug("Cc Lists:\n{}".format('\n'.join(cc_lists)))
+    logging.debug("Cc Others:\n{}".format('\n'.join(cc_others)))
+    logging.debug("Cc Maintainers:\n{}".format('\n'.join(cc_maintainers) or None))
+    logging.debug("To Maintainers:\n{}\n".format('\n'.join(to_maintainers) or None))
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
+    for o in cc_others:
+        lines.insert(next_line_after_from, o + "\n")
+    for l in cc_lists:
+        lines.insert(next_line_after_from, l + "\n")
+    for om in cc_maintainers:
+        lines.insert(next_line_after_from, om + "\n")
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
+    entities_per_file = dict()
+
+    for patch in args.patches:
+        entities_per_file[os.path.basename(patch)] = gather_maintainers_of_file(patch)
+
+    all_entities_union = {"all_maintainers": set(), "all_lists": set(), "all_others": set()}
+    for patch in args.patches:
+        all_entities_union["all_maintainers"] = all_entities_union["all_maintainers"].union(entities_per_file[os.path.basename(patch)].get("maintainers"))
+        all_entities_union["all_lists"] = all_entities_union["all_lists"].union(entities_per_file[os.path.basename(patch)].get("lists"))
+        all_entities_union["all_others"] = all_entities_union["all_others"].union(entities_per_file[os.path.basename(patch)].get("others"))
+
+    for patch in args.patches:
+        add_maintainers_to_file(patch, entities_per_file, all_entities_union)
+
+    logging.info("Maintainers added to all patch files successfully")
+
+if __name__ == "__main__":
+    main()
-- 
2.40.0

