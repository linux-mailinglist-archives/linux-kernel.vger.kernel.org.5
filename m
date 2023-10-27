Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264297D9120
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbjJ0ITw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235221AbjJ0ITc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:19:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06922D42;
        Fri, 27 Oct 2023 01:19:22 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39R5iCp5020795;
        Fri, 27 Oct 2023 08:19:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=1pikA91vUTNV05//EH2EMfg5yCx5g71Zj4B5oU1dgV0=;
 b=jzYtVlJsH7AHD5Czyrz5o1kH1Kti08yoBSUPloSJCxOD5oSdafKtwEHMGrEetRVo6H5U
 3R2WtZ19Ar4xncHO4/X3NMx8HLiiC9lwX7/FyntzrxcTkbkJWyHg32buQjea61C25lnt
 +pcvUDPAguIFz9Km1GTrxGFrEHIjBoamzZDskUvV+EmcGUnjJyvp8JjRT/hhY8ZCVZYT
 7j4r6SejUjOFwJ3HzLOZ36EvdXt6quUFdwMPgFkWSc6QjQ4h7lbHNy8fyl43cUwOA8XP
 us9HTuZWiiEZJ2Fno7vorfjna9i9zpSew4cv4zx/iZmgNoLx6CibK7AT3Mvxqeer+lH0 PA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tyx4tgx0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 08:19:01 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39R8FtVl009374;
        Fri, 27 Oct 2023 08:19:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tywqjebch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 08:19:00 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39R8Ig9V028975;
        Fri, 27 Oct 2023 08:19:00 GMT
Received: from t460-2.nl.oracle.com (dhcp-10-175-63-126.vpn.oracle.com [10.175.63.126])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3tywqjeb1g-7;
        Fri, 27 Oct 2023 08:19:00 +0000
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Jani Nikula <jani.nikula@intel.com>, linux-kernel@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Richard Cochran <richardcochran@gmail.com>,
        SeongJae Park <sj@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Armin Wolf <W_Armin@gmx.de>,
        Iwona Winiarska <iwona.winiarska@intel.com>,
        =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        linux-media@vger.kernel.org, Yanteng Si <siyanteng@loongson.cn>,
        Alex Shi <alexs@kernel.org>, Wu XiangCheng <bobwxc@email.cn>
Subject: [PATCH RFC 06/11] docs: driver-api: properly format ToC headings
Date:   Fri, 27 Oct 2023 10:18:25 +0200
Message-Id: <20231027081830.195056-7-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027081830.195056-1-vegard.nossum@oracle.com>
References: <20231027081830.195056-1-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_06,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310270071
X-Proofpoint-GUID: wz7HOd5et-SDzZciojXibt6vUTGSeytM
X-Proofpoint-ORIG-GUID: wz7HOd5et-SDzZciojXibt6vUTGSeytM
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

Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Armin Wolf <W_Armin@gmx.de>
Cc: Iwona Winiarska <iwona.winiarska@intel.com>
Cc: "Ricardo Cañuelo" <ricardo.canuelo@collabora.com>
Cc: Tomas Winkler <tomas.winkler@intel.com>
Cc: linux-media@vger.kernel.org
Cc: Yanteng Si <siyanteng@loongson.cn>
Cc: Alex Shi <alexs@kernel.org>
Cc: Wu XiangCheng <bobwxc@email.cn>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/driver-api/index.rst                         | 5 +----
 Documentation/driver-api/media/index.rst                   | 7 +------
 Documentation/driver-api/mei/index.rst                     | 7 +------
 Documentation/driver-api/pci/index.rst                     | 5 +----
 Documentation/translations/zh_CN/driver-api/gpio/index.rst | 3 +--
 Documentation/translations/zh_CN/driver-api/index.rst      | 5 +----
 6 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 1e16a40da3ba..4540f79a34a9 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -9,11 +9,8 @@ of device drivers.  This document is an only somewhat organized collection
 of some of those interfaces — it will hopefully get better over time!  The
 available subsections can be seen below.
 
-.. class:: toc-title
-
-	   Table of contents
-
 .. toctree::
+   :caption: Table of contents
    :maxdepth: 2
 
    driver-model/index
diff --git a/Documentation/driver-api/media/index.rst b/Documentation/driver-api/media/index.rst
index 08e206567408..d5593182a3f9 100644
--- a/Documentation/driver-api/media/index.rst
+++ b/Documentation/driver-api/media/index.rst
@@ -20,13 +20,8 @@ Documentation/userspace-api/media/index.rst
   - for the userspace APIs used on media devices.
 
 
-.. only:: html
-
-   .. class:: toc-title
-
-        Table of Contents
-
 .. toctree::
+    :caption: Table of Contents
     :maxdepth: 5
     :numbered:
 
diff --git a/Documentation/driver-api/mei/index.rst b/Documentation/driver-api/mei/index.rst
index 3a22b522ee78..eae6f18f18cf 100644
--- a/Documentation/driver-api/mei/index.rst
+++ b/Documentation/driver-api/mei/index.rst
@@ -9,13 +9,8 @@ Intel(R) Management Engine Interface (Intel(R) MEI)
 **Copyright** |copy| 2019 Intel Corporation
 
 
-.. only:: html
-
-   .. class:: toc-title
-
-        Table of Contents
-
 .. toctree::
+   :caption: Table of Contents
    :maxdepth: 3
 
    mei
diff --git a/Documentation/driver-api/pci/index.rst b/Documentation/driver-api/pci/index.rst
index c6cf1fef61ce..a38e475cdbe3 100644
--- a/Documentation/driver-api/pci/index.rst
+++ b/Documentation/driver-api/pci/index.rst
@@ -4,11 +4,8 @@
 The Linux PCI driver implementer's API guide
 ============================================
 
-.. class:: toc-title
-
-	   Table of contents
-
 .. toctree::
+   :caption: Table of contents
    :maxdepth: 2
 
    pci
diff --git a/Documentation/translations/zh_CN/driver-api/gpio/index.rst b/Documentation/translations/zh_CN/driver-api/gpio/index.rst
index 9ab64e94aced..9a6a14162a6c 100644
--- a/Documentation/translations/zh_CN/driver-api/gpio/index.rst
+++ b/Documentation/translations/zh_CN/driver-api/gpio/index.rst
@@ -14,9 +14,8 @@
 通用型输入/输出（GPIO）
 =======================
 
-目录:
-
 .. toctree::
+   :caption: 目录
    :maxdepth: 2
 
    legacy
diff --git a/Documentation/translations/zh_CN/driver-api/index.rst b/Documentation/translations/zh_CN/driver-api/index.rst
index ba354e1f4e6d..92ff1b7fc3d3 100644
--- a/Documentation/translations/zh_CN/driver-api/index.rst
+++ b/Documentation/translations/zh_CN/driver-api/index.rst
@@ -17,11 +17,8 @@ Linux驱动实现者的API指南
 内核提供了各种各样的接口来支持设备驱动的开发。这份文档只是对其中一些接口进行了
 一定程度的整理——希望随着时间的推移，它能变得更好！可用的小节可以在下面看到。
 
-.. class:: toc-title
-
-	   目录列表：
-
 .. toctree::
+   :caption: 目录列表
    :maxdepth: 2
 
    gpio/index
-- 
2.34.1

