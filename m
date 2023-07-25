Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DED761CDD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjGYPFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjGYPFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:05:17 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8ED219A7;
        Tue, 25 Jul 2023 08:05:15 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PEfRpK020730;
        Tue, 25 Jul 2023 15:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=5hFheaSKGmfOKtZHhZmpjzVgtdHwInm/xNbWooEA+zw=;
 b=dDsuV3zEqkrCQZ6mpI7KvnGT0kt2Z0cVlI3PJ/8EUbDOvHnUWTxokfuXGccxmcVCpEGL
 t1CNXmau8gYfBF48eAV0Kd7vXyM/u7coENwJdwb+/HiNr9bc2AqIVjVpYHY128XYJ8lA
 3N5qgIl7zjoTBxbaRkSc7VIMGKEzpF2NAwI3MJOfHaOMamW/FHF5BzvkfxP0bXPqsCQf
 b1sGvCOUWjkoAOd0Csxs/MUJjHl+YsFMZhKch9IzBJBGpuaO3cDyqV8q7JrmJ3DyEkGN
 RNreWwxwm1aNPPeJ95EfLMLW3wlAEPOMmn5axyEZ9DVpmHhsYxx31133un9vlspOHdaL tQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s2942d9ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 15:05:06 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36PF3pHc030393;
        Tue, 25 Jul 2023 15:04:25 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s2942d83f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 15:04:24 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36PEUA0I026197;
        Tue, 25 Jul 2023 15:04:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s0serwafw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 15:04:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36PF3uck40894740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jul 2023 15:03:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D41642004E;
        Tue, 25 Jul 2023 15:03:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D2A22004B;
        Tue, 25 Jul 2023 15:03:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jul 2023 15:03:56 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, irogers@google.com, wangnan0@huawei.com,
        jolsa@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 1/2 Resend] perf build: Update feature check for clang and llvm
Date:   Tue, 25 Jul 2023 17:03:46 +0200
Message-Id: <20230725150347.3479291-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AqhTr4dx7muIig6b4ujwkOk9wPZyG1xi
X-Proofpoint-GUID: -G55YXqjURpmZ5aIIwPZoaj5WAa4Hms2
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_08,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250133
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf build auto-detects features and packages already installed
for its build. This is done in directory tools/build/feature. This
directory contains small sample programs. When they successfully
compile the necessary prereqs in form of libraries and header
files are present.

Such a check is also done for llvm and clang. And the checks fail.

Fix this and update to the latest C++ standard and use the
new library provided by clang (which contains new packaging)
see this link for reference:
 https://fedoraproject.org/wiki/Changes/Stop-Shipping-Individual-Component-Libraries-In-clang-lib-Package

Output before:
 # rm -f ./test-clang.bin; make test-clang.bin; ./test-clang.bin; \
	ll test-clang.make.output
 g++  -MD -Wall -Werror -o test-clang.bin test-clang.cpp \
	 	> test-clang.make.output 2>&1 -std=gnu++14 \
	-I/usr/include 		\
	-L/usr/lib64		\
	-Wl,--start-group -lclangBasic -lclangDriver	\
	  -lclangFrontend -lclangEdit -lclangLex	\
	  -lclangAST -Wl,--end-group 			\
	-lLLVM-16	\
			\
	> test-clang.make.output 2>&1
 make: *** [Makefile:356: test-clang.bin] Error 1
 -bash: ./test-clang.bin: No such file or directory
 -rw-r--r--. 1 root root 252041 Jul 12 09:56 test-clang.make.output
 #

File test-clang.make.output contains many lines of unreferenced
symbols.

Output after:
 # rm -f ./test-clang.bin; make test-clang.bin; ./test-clang.bin; \
	cat test-clang.make.output
 g++  -MD -Wall -Werror -o test-clang.bin test-clang.cpp \
	 > test-clang.make.output 2>&1 -std=gnu++17	\
	-I/usr/include 		\
	-L/usr/lib64		\
	-Wl,--start-group -lclang-cpp -Wl,--end-group	\
	-lLLVM-16	\
			\
	> test-clang.make.output 2>&1
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/build/feature/Makefile | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 2cd6dbbee088..3184f387990a 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -340,7 +340,7 @@ $(OUTPUT)test-jvmti-cmlr.bin:
 	$(BUILD)
 
 $(OUTPUT)test-llvm.bin:
-	$(BUILDXX) -std=gnu++14 				\
+	$(BUILDXX) -std=gnu++17 				\
 		-I$(shell $(LLVM_CONFIG) --includedir) 		\
 		-L$(shell $(LLVM_CONFIG) --libdir)		\
 		$(shell $(LLVM_CONFIG) --libs Core BPF)		\
@@ -348,17 +348,15 @@ $(OUTPUT)test-llvm.bin:
 		> $(@:.bin=.make.output) 2>&1
 
 $(OUTPUT)test-llvm-version.bin:
-	$(BUILDXX) -std=gnu++14					\
+	$(BUILDXX) -std=gnu++17					\
 		-I$(shell $(LLVM_CONFIG) --includedir)		\
 		> $(@:.bin=.make.output) 2>&1
 
 $(OUTPUT)test-clang.bin:
-	$(BUILDXX) -std=gnu++14					\
+	$(BUILDXX) -std=gnu++17					\
 		-I$(shell $(LLVM_CONFIG) --includedir) 		\
 		-L$(shell $(LLVM_CONFIG) --libdir)		\
-		-Wl,--start-group -lclangBasic -lclangDriver	\
-		  -lclangFrontend -lclangEdit -lclangLex	\
-		  -lclangAST -Wl,--end-group 			\
+		-Wl,--start-group -lclang-cpp -Wl,--end-group	\
 		$(shell $(LLVM_CONFIG) --libs Core option)	\
 		$(shell $(LLVM_CONFIG) --system-libs)		\
 		> $(@:.bin=.make.output) 2>&1
-- 
2.41.0

