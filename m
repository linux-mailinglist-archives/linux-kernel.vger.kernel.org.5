Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD145787F98
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241393AbjHYGLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241253AbjHYGLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:11:47 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2A31BF2;
        Thu, 24 Aug 2023 23:11:46 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37P65swu028546;
        Fri, 25 Aug 2023 06:11:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=U0v7jNIn3oQz0IQzr0PZRDKoIUVT5oQUvwSUQef7ELc=;
 b=DUx8Ju4S/A51o5RPnFkHk/2Azv2pqTM7TVJx5tabOsvB3DHblMMV4saOZwqhjQmEMRzV
 UfV9JceMg8faKGn7tV4/XxUo9Pmx9iUH457MlMDDPTiedhGK6Iz8pf1O5NjlszDKoCsW
 9aZKwy64/2SoromXPYloFfL8gx0gLsS6S1ls4fLp6vwptnouENtaCjxngiq16ielW/Hf
 SCrRJvuZZIEm5JSHPq+W5chT7X28fTS+AWOOvVQOeJdr5KEWhehtFG2aNY2oHwFc3AKj
 uvYcYAHOmKMDIur4mEsxJgZEwNd5G6YcoJwezTmZ0Tr8V/fAIzrYDl288QCOgEkBnCwb Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sppm30asn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 06:11:33 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37P66B3I031184;
        Fri, 25 Aug 2023 06:11:33 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sppm30asg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 06:11:33 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37P5CBeU010269;
        Fri, 25 Aug 2023 06:11:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sn21t5abs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 06:11:31 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37P6BTZf15008396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 06:11:29 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03B7320049;
        Fri, 25 Aug 2023 06:11:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5A0E2004D;
        Fri, 25 Aug 2023 06:11:26 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown [9.109.199.72])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 25 Aug 2023 06:11:26 +0000 (GMT)
From:   Aditya Gupta <adityag@linux.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Introduce perf build subcommand
Date:   Fri, 25 Aug 2023 11:41:21 +0530
Message-ID: <20230825061125.24312-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aa1GcXspGqJlPLE35oWcI8QchDPeRk-F
X-Proofpoint-GUID: eypVpzIXPBMLupNOKPPGsFRNpyjNvDwN
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_04,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=777 priorityscore=1501 impostorscore=0
 clxscore=1011 phishscore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Problem
===========

Currently the presence of a feature is checked with a combination of
perf version --build-options and greps, such as:

    perf version --build-options | grep " on .* HAVE_FEATURE"

Proposed solution
=================

As suggested by contributors in:
https://lore.kernel.org/linux-perf-users/ZMPWk5K63tadmDlU@kernel.org/

Introduce a subcommand "perf build --has", with which
scripts can test for presence of a feature, such as:

    perf build --has HAVE_FEATURE

The usage of "perf version --build-options | grep" has been replaced in two
tests, with "perf build --has" command

Also, to not duplicate the same feature list at multiple places, a new global
'supported_features' array has been introduced in builtin.h, so both commands
'perf build --has' and 'perf version --build-options' use the same array

'supported_features' feature is an array of 'struct feature_support', which
also has the name of the feature, macro used to test it's presence, and a
is_builtin member, which will be 0 if feature not built-in, and 1 if built-in

Architectures Tested
====================
* x86_64
* ppc64le

Git tree
========

Git tree with this patch series applied for testing:
https://github.com/adi-g15-ibm/linux/tree/perf-build-has

Aditya Gupta (3):
  perf build: introduce build subcommand
  perf version: update --build-options to use 'supported_features' array
  perf tests task_analyzer: check perf build for libtraceevent support

Athira Rajeev (1):
  tools/perf/tests: Update probe_vfs_getname.sh script to use perf build
    --has

 tools/perf/Build                              |  1 +
 tools/perf/builtin-build.c                    | 94 +++++++++++++++++++
 tools/perf/builtin-version.c                  | 39 ++------
 tools/perf/builtin.h                          | 47 ++++++++++
 tools/perf/perf.c                             |  1 +
 .../perf/tests/shell/lib/probe_vfs_getname.sh |  4 +-
 .../shell/record+probe_libc_inet_pton.sh      |  5 +-
 .../shell/record+script_probe_vfs_getname.sh  |  5 +-
 tools/perf/tests/shell/test_task_analyzer.sh  |  4 +-
 9 files changed, 163 insertions(+), 37 deletions(-)
 create mode 100644 tools/perf/builtin-build.c

-- 
2.41.0

