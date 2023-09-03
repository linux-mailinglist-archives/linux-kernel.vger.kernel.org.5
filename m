Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE393790BAD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 13:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbjICLrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 07:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236692AbjICLrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 07:47:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EE5127;
        Sun,  3 Sep 2023 04:47:37 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 383BeB0H019975;
        Sun, 3 Sep 2023 11:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=kqOx4rE7ZjAj2+gJwCjmNBLqQP3EnutZBVgrYAy9vPE=;
 b=N585fTBHNjAXe0qycyaqUUP/wsNCsAeNwns2Ac4Ztp0tGqUGFJ7NuqaCrs1vH744q8hL
 U+eimXaHL2XUxvh17/5ptOkzx9loDoitgqhF4YZ0iRJrVfxdqsFuJ6MX/pol5j0uGtXE
 JDDiQokI7vEoHBa4ycnKhtt24yvKFpG0zBpOtMkb5t+K3eO9512/y+Ik/qYMIpbqtDgp
 YK0x4sjaiJWZ03ozfNwoXyjnPVvtYxcDOdU6w/rt++aDZCqFyRdxxKgq2YeKo/HzKLv1
 zzdNQwd5rv04eZwNEY6GRFU8UQrqU9j1+liNc9xpmLLhaddweUlX+CCSdK0q5tMCw5K0 ug== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3svqaasn93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Sep 2023 11:47:29 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 383BlSNw005152;
        Sun, 3 Sep 2023 11:47:28 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3svqaasn8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Sep 2023 11:47:28 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3838jQVn012275;
        Sun, 3 Sep 2023 11:47:28 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svhkjahm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Sep 2023 11:47:27 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 383BlPew45089080
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 3 Sep 2023 11:47:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07FC620043;
        Sun,  3 Sep 2023 11:47:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5C6B20040;
        Sun,  3 Sep 2023 11:47:22 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown [9.171.15.154])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sun,  3 Sep 2023 11:47:22 +0000 (GMT)
From:   Aditya Gupta <adityag@linux.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Introduce perf check subcommand
Date:   Sun,  3 Sep 2023 17:17:17 +0530
Message-ID: <20230903114721.190733-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9gZWFME7-nUxsKNIbP9JfdsbMZOlmyuj
X-Proofpoint-ORIG-GUID: 8L4QkFb9rzCKoyEhCJrxJyrWwggdluQW
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-03_09,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309030108
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

Introduce a subcommand "perf check --feature", with which
scripts can test for presence of a feature, such as:

    perf check --feature HAVE_LIBTRACEEVENT

    or

    perf check --feature libtraceevent

The usage of "perf version --build-options | grep" has been replaced in two
tests, with "perf check --feature" command

Also, to not duplicate the same feature list at multiple places, a new global
'supported_features' array has been introduced in builtin.h, so both commands
'perf check --feature' and 'perf version --build-options' use the same array

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
https://github.com/adi-g15-ibm/linux/tree/perf-check-feature

Changelog
=========
V1
+ changed subcommand name to 'perf check --feature'
+ added documentation for perf check
+ support both macro (eg. HAVE_LIBTRACEEVENT), and name (eg. libtraceevent) as
  input to 'perf check --feature'
+ change subject and descriptions of all patch mentioning perf check instead of
  perf build

V0: Previous patch series: https://lore.kernel.org/linux-perf-users/20230825061125.24312-1-adityag@linux.ibm.com/

Aditya Gupta (3):
  perf check: introduce check subcommand
  perf version: update --build-options to use 'supported_features' array
  perf tests task_analyzer: use perf check for libtraceevent support

Athira Rajeev (1):
  tools/perf/tests: Update probe_vfs_getname.sh script to use perf check
    --feature

 tools/perf/Build                              |  1 +
 tools/perf/Documentation/perf-check.txt       | 53 +++++++++++
 tools/perf/builtin-check.c                    | 95 +++++++++++++++++++
 tools/perf/builtin-version.c                  | 39 ++------
 tools/perf/builtin.h                          | 47 +++++++++
 tools/perf/perf.c                             |  1 +
 .../perf/tests/shell/lib/probe_vfs_getname.sh |  4 +-
 .../shell/record+probe_libc_inet_pton.sh      |  5 +-
 .../shell/record+script_probe_vfs_getname.sh  |  5 +-
 tools/perf/tests/shell/test_task_analyzer.sh  |  4 +-
 10 files changed, 217 insertions(+), 37 deletions(-)
 create mode 100644 tools/perf/Documentation/perf-check.txt
 create mode 100644 tools/perf/builtin-check.c

-- 
2.41.0

