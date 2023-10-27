Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502AE7D911A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbjJ0ITj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjJ0ITY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:19:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07271D5E;
        Fri, 27 Oct 2023 01:19:18 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39R5i5w6003086;
        Fri, 27 Oct 2023 08:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=phDJ9fYkNDZ1+LpOWiE4bE9znlIs1VUuwW3/CIkXJvU=;
 b=i1/TC3SthuFqudfz2WOcUUFklFcfOYAV3631LtS5OSRJ2rV+AuC/b/n8S4yT8hhblK1+
 r4GtCn4M8LXE7Vq9U8W5CFuvbcoXdG9aqaO5ge3F5v2kkRqFGNkl8oj8oB97ho1arWk8
 Oe5GhEACObCql/85AvATImIGY4CbZTn/SJrg+fwkGJagPoB4tyq+cDh6WcSkQGRA5IG0
 pKZgore+ZqGoX6Rr9Rso3gglbkCJfohhGxQpDx0CKSszC5iz5q1wcL/Qj7YYhq+H0hEn
 IIADLJuZVZmF7a3+IwzclK2MAuFznCkoUri5G4cXQm0St4yQhWOrbLaoKeZ1xkSJFJNg Kg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tyxmv8v0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 08:19:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39R62lO6009264;
        Fri, 27 Oct 2023 08:19:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tywqjebdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 08:19:03 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39R8Ig9X028975;
        Fri, 27 Oct 2023 08:19:03 GMT
Received: from t460-2.nl.oracle.com (dhcp-10-175-63-126.vpn.oracle.com [10.175.63.126])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3tywqjeb1g-8;
        Fri, 27 Oct 2023 08:19:02 +0000
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Jani Nikula <jani.nikula@intel.com>, linux-kernel@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH RFC 07/11] input: docs: properly format ToC headings
Date:   Fri, 27 Oct 2023 10:18:26 +0200
Message-Id: <20231027081830.195056-8-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027081830.195056-1-vegard.nossum@oracle.com>
References: <20231027081830.195056-1-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_06,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310270071
X-Proofpoint-GUID: aoJ9XceRi8i7_aMEaDo6B2ImGRMp_3ab
X-Proofpoint-ORIG-GUID: aoJ9XceRi8i7_aMEaDo6B2ImGRMp_3ab
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"class:: toc-title" was a workaround for older Sphinx versions that are
no longer supported.

The canonical way to add a heading to the ToC is to use :caption:.
Do that.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/input/input_kapi.rst   | 5 +----
 Documentation/input/input_uapi.rst   | 5 +----
 Documentation/input/joydev/index.rst | 5 +----
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/Documentation/input/input_kapi.rst b/Documentation/input/input_kapi.rst
index 41f1b7e6b78e..9937522daa9b 100644
--- a/Documentation/input/input_kapi.rst
+++ b/Documentation/input/input_kapi.rst
@@ -4,11 +4,8 @@
 Linux Input Subsystem kernel API
 ################################
 
-.. class:: toc-title
-
-        Table of Contents
-
 .. toctree::
+   :caption: Table of Contents
    :maxdepth: 2
    :numbered:
 
diff --git a/Documentation/input/input_uapi.rst b/Documentation/input/input_uapi.rst
index 4a0391609327..8275b4223a84 100644
--- a/Documentation/input/input_uapi.rst
+++ b/Documentation/input/input_uapi.rst
@@ -4,11 +4,8 @@
 Linux Input Subsystem userspace API
 ###################################
 
-.. class:: toc-title
-
-        Table of Contents
-
 .. toctree::
+   :caption: Table of Contents
    :maxdepth: 2
    :numbered:
 
diff --git a/Documentation/input/joydev/index.rst b/Documentation/input/joydev/index.rst
index ebcff43056e2..d03d6f6cbfab 100644
--- a/Documentation/input/joydev/index.rst
+++ b/Documentation/input/joydev/index.rst
@@ -6,11 +6,8 @@ Linux Joystick support
 
 :Copyright: |copy| 1996-2000 Vojtech Pavlik <vojtech@ucw.cz> - Sponsored by SuSE
 
-.. class:: toc-title
-
-	Table of Contents
-
 .. toctree::
+	:caption: Table of Contents
 	:maxdepth: 3
 
 	joystick
-- 
2.34.1

