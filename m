Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971DF7D2D9E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjJWJHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjJWJHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:07:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63B7E6;
        Mon, 23 Oct 2023 02:06:58 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39N6j9jO010268;
        Mon, 23 Oct 2023 09:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=1/7CrogggWqOQDPi4E83arLGCy38g/wiwwtQ4kqV4B4=;
 b=TTbXOgbwCn9/EzmlS8m14GFr1iQY6iv8O9M/td7pf415JTw/C1n9K0Djua6B4lyIv6bZ
 HdoEcV2z1m9GaG5POPdEJOUOM3nLrVPrd/fnsjjJrtdzmYikxjvOUMnlOPIrwbO8sVQh
 jq9Ag7gwsfknYJ1N2LnvO8cvcjuVdmPC6WaanhEOfOjRXT9KCLIAILk/lK5tWt0sAl4I
 jpITB2ixTdciJBqaqwSOhKcq6Iozjgl3smE4DIKgSIc7ucz8IoL4/QZCOAn3RJT9DD7C
 XGbjJFxWkk1s5HdyqTaKSDEtRbeERT6resHU+RrpKy81nfOe25TozUwYCXuC+lOpnPMm Jg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5e32n2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Oct 2023 09:06:45 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39N6gPbG015051;
        Mon, 23 Oct 2023 09:06:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tv533qebu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Oct 2023 09:06:44 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39N96hY8005451;
        Mon, 23 Oct 2023 09:06:43 GMT
Received: from t460-2.home (dhcp-10-175-60-137.vpn.oracle.com [10.175.60.137])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3tv533qeb1-1;
        Mon, 23 Oct 2023 09:06:43 +0000
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] Documentation: kbuild: clarifications
Date:   Mon, 23 Oct 2023 11:06:38 +0200
Message-Id: <20231023090638.935867-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_07,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230078
X-Proofpoint-GUID: 2SI9zToTw4NGuHPC3pNchUM7bYIqH9Nn
X-Proofpoint-ORIG-GUID: 2SI9zToTw4NGuHPC3pNchUM7bYIqH9Nn
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kconfig language is subtle. Document a few more non-obvious
aspects of it.

Also fix a small markup issue while we're at it.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/kbuild/kconfig-language.rst | 53 ++++++++++++++++++++---
 1 file changed, 48 insertions(+), 5 deletions(-)

diff --git a/Documentation/kbuild/kconfig-language.rst b/Documentation/kbuild/kconfig-language.rst
index 0135905c0aa3..f694d90f83d1 100644
--- a/Documentation/kbuild/kconfig-language.rst
+++ b/Documentation/kbuild/kconfig-language.rst
@@ -42,9 +42,11 @@ Every line starts with a key word and can be followed by multiple
 arguments.  "config" starts a new config entry. The following lines
 define attributes for this config option. Attributes can be the type of
 the config option, input prompt, dependencies, help text and default
-values. A config option can be defined multiple times with the same
-name, but every definition can have only a single input prompt and the
-type must not conflict.
+values.
+
+A config option can be defined multiple times (i.e. by multiple menu
+entries) with the same name, but each definition can have only a single
+prompt and their types must not conflict.
 
 Menu attributes
 ---------------
@@ -136,7 +138,10 @@ applicable everywhere (see syntax).
   below), reverse dependencies can be used to force a lower limit of
   another symbol. The value of the current menu symbol is used as the
   minimal value <symbol> can be set to. If <symbol> is selected multiple
-  times, the limit is set to the largest selection.
+  times, the limit is set to the largest selection. In other words, if
+  at least one menu selecting another symbol is ``y``, then the selected
+  symbol will also be ``y``.
+
   Reverse dependencies can only be used with boolean or tristate
   symbols.
 
@@ -473,6 +478,22 @@ This is a collection of Kconfig tips, most of which aren't obvious at
 first glance and most of which have become idioms in several Kconfig
 files.
 
+Misconceptions about prompts and symbols
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Looking at fragments of common Kconfig usage, it is easy to believe
+that a symbol can depend on another symbol. In fact, it is not the
+symbol itself that has a dependency; it is the visibility of the
+symbol's prompt that has a dependency.
+
+Likewise, since each prompt defines its own dependencies, it is quite
+possible to have two prompts for the same symbol with different sets
+of dependencies. As long as the user has at least one visible prompt,
+they can enable that symbol in their config. Conversely, if there are
+no visible prompts for a symbol, the user can not change its value,
+not even by explicitly setting it in their .config. (It may, however,
+still be selected by other prompts.)
+
 Adding common features and make the usage configurable
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 It is a common idiom to implement a feature/functionality that are
@@ -567,7 +588,7 @@ distro config owners, but also for every single developer or user who
 configures a kernel.
 
 Such a dependency can be relaxed by combining it with the compile-testing rule
-above, leading to:
+above, leading to::
 
   config FOO
 	bool "Support for foo hardware"
@@ -692,6 +713,28 @@ e98062ed6dc4    select A -> depends on A        (3)
 (2) That seems to be the gist of that fix.
 (3) Same error.
 
+Experimenting with smaller-scale Kconfigs
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+It is fully possible to play around with smaller-scale Kconfig fragments
+instead of using the kernel's full set of Kconfig files. Create a file
+called ``Kconfig.test`` containing e.g.::
+
+  config MODULES
+          bool "Modules"
+          modules
+
+  config FOO
+          tristate "foo"
+
+  config BAR
+          tristate "bar"
+          depends on FOO
+
+You can now e.g. use menuconfig on this by simply running:
+``scripts/kconfig/mconf Kconfig.test``.
+
+
 Future kconfig work
 ~~~~~~~~~~~~~~~~~~~
 
-- 
2.34.1

