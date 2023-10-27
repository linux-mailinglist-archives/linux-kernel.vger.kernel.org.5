Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409887D9129
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbjJ0IU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbjJ0IUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:20:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EF81996;
        Fri, 27 Oct 2023 01:19:35 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39R5iCdg020786;
        Fri, 27 Oct 2023 08:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=3Wu6bIg7tVvARFbVYaBYPJjOg+gs9lUaxjqSIpedt0E=;
 b=gLX/GWaCBpyh1Lw+Mg5zW/ROBo2V7+vbr0cGfLNNAEBpV3J8c4crQgFYu7kTsk2VOgCB
 419izoc3g9sD9pGD8O0mjqfBxUsKO12FRYO907Kj4GoK7L/C4/us05ktxrikmTGg4IoU
 WWg6xhlFTK1alsAlFY120lkgFn0dd+rcAit19QNs0ig6WAKGO1Veq2ajKTcj0DWInDXJ
 AQ7v89Db1RoRCQzmmEcJItUDE256ZQAmMjL40ygtN2puuEosYzRoO2deDreKY1vV5NlR
 bu31FNiY5m9+DcJx8DQP/oVbdsm7JKuH4ffqkyRQ7gMDvz8I+pGJ69uMjWaRQnuyOdAO 7g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tyx4tgx0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 08:19:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39R6HWAx009159;
        Fri, 27 Oct 2023 08:19:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tywqjebh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 08:19:12 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39R8Ig9d028975;
        Fri, 27 Oct 2023 08:19:11 GMT
Received: from t460-2.nl.oracle.com (dhcp-10-175-63-126.vpn.oracle.com [10.175.63.126])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3tywqjeb1g-11;
        Fri, 27 Oct 2023 08:19:11 +0000
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Jani Nikula <jani.nikula@intel.com>, linux-kernel@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res.211@gmail.com>, workflows@vger.kernel.org
Subject: [PATCH RFC 10/11] docs: use toctree :caption: and move introduction
Date:   Fri, 27 Oct 2023 10:18:29 +0200
Message-Id: <20231027081830.195056-11-vegard.nossum@oracle.com>
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
X-Proofpoint-GUID: aNYiUgR9x7UUOkNNILohSUk0CHjwFX3r
X-Proofpoint-ORIG-GUID: aNYiUgR9x7UUOkNNILohSUk0CHjwFX3r
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The canonical way to add a heading to the ToC is to use :caption:.
Do that.

Let's also move the introduction to the top of the document to be
consistent with most other documents.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Federico Vaga <federico.vaga@vaga.pv.it>
Cc: Alex Shi <alexs@kernel.org>
Cc: Yanteng Si <siyanteng@loongson.cn>
Cc: Hu Haowen <src.res.211@gmail.com>
Cc: workflows@vger.kernel.org
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/process/development-process.rst | 19 +++++++++----------
 .../it_IT/process/development-process.rst     | 19 +++++++++----------
 .../zh_CN/process/development-process.rst     |  5 ++---
 .../zh_TW/process/development-process.rst     |  5 ++---
 4 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/Documentation/process/development-process.rst b/Documentation/process/development-process.rst
index 61c627e41ba8..e34d7da58b7f 100644
--- a/Documentation/process/development-process.rst
+++ b/Documentation/process/development-process.rst
@@ -3,9 +3,17 @@
 A guide to the Kernel Development Process
 =========================================
 
-Contents:
+The purpose of this document is to help developers (and their managers)
+work with the development community with a minimum of frustration.  It is
+an attempt to document how this community works in a way which is
+accessible to those who are not intimately familiar with Linux kernel
+development (or, indeed, free software development in general).  While
+there is some technical material here, this is very much a process-oriented
+discussion which does not require a deep knowledge of kernel programming to
+understand.
 
 .. toctree::
+   :caption: Contents
    :numbered:
    :maxdepth: 2
 
@@ -17,12 +25,3 @@ Contents:
    6.Followthrough
    7.AdvancedTopics
    8.Conclusion
-
-The purpose of this document is to help developers (and their managers)
-work with the development community with a minimum of frustration.  It is
-an attempt to document how this community works in a way which is
-accessible to those who are not intimately familiar with Linux kernel
-development (or, indeed, free software development in general).  While
-there is some technical material here, this is very much a process-oriented
-discussion which does not require a deep knowledge of kernel programming to
-understand.
diff --git a/Documentation/translations/it_IT/process/development-process.rst b/Documentation/translations/it_IT/process/development-process.rst
index f1a6eca30824..20e77c9816a1 100644
--- a/Documentation/translations/it_IT/process/development-process.rst
+++ b/Documentation/translations/it_IT/process/development-process.rst
@@ -8,9 +8,17 @@
 Una guida al processo di sviluppo del Kernel
 ============================================
 
-Contenuti:
+Lo scopo di questo documento è quello di aiutare gli sviluppatori (ed i loro
+supervisori) a lavorare con la communità di sviluppo con il minimo sforzo. È
+un tentativo di documentare il funzionamento di questa communità in modo che
+sia accessibile anche a coloro che non hanno famigliarità con lo sviluppo del
+Kernel Linux (o, anzi, con lo sviluppo di software libero in generale).  Benchè
+qui sia presente del materiale tecnico, questa è una discussione rivolta in
+particolare al procedimento, e quindi per essere compreso non richiede una
+conoscenza approfondità sullo sviluppo del kernel.
 
 .. toctree::
+   :caption: Contenuti
    :numbered:
    :maxdepth: 2
 
@@ -22,12 +30,3 @@ Contenuti:
    6.Followthrough
    7.AdvancedTopics
    8.Conclusion
-
-Lo scopo di questo documento è quello di aiutare gli sviluppatori (ed i loro
-supervisori) a lavorare con la communità di sviluppo con il minimo sforzo. È
-un tentativo di documentare il funzionamento di questa communità in modo che
-sia accessibile anche a coloro che non hanno famigliarità con lo sviluppo del
-Kernel Linux (o, anzi, con lo sviluppo di software libero in generale).  Benchè
-qui sia presente del materiale tecnico, questa è una discussione rivolta in
-particolare al procedimento, e quindi per essere compreso non richiede una
-conoscenza approfondità sullo sviluppo del kernel.
diff --git a/Documentation/translations/zh_CN/process/development-process.rst b/Documentation/translations/zh_CN/process/development-process.rst
index 30cffe66c075..c10d8e2e21eb 100644
--- a/Documentation/translations/zh_CN/process/development-process.rst
+++ b/Documentation/translations/zh_CN/process/development-process.rst
@@ -8,9 +8,10 @@
 内核开发过程指南
 ================
 
-内容:
+本文档的目的是帮助开发人员（及其经理）以最小的挫折感与开发社区合作。它试图记录这个社区如何以一种不熟悉Linux内核开发（或者实际上是自由软件开发）的人可以访问的方式工作。虽然这里有一些技术资料，但这是一个面向过程的讨论，不需要深入了解内核编程就可以理解。
 
 .. toctree::
+   :caption: 内容
    :numbered:
    :maxdepth: 2
 
@@ -22,5 +23,3 @@
    6.Followthrough
    7.AdvancedTopics
    8.Conclusion
-
-本文档的目的是帮助开发人员（及其经理）以最小的挫折感与开发社区合作。它试图记录这个社区如何以一种不熟悉Linux内核开发（或者实际上是自由软件开发）的人可以访问的方式工作。虽然这里有一些技术资料，但这是一个面向过程的讨论，不需要深入了解内核编程就可以理解。
diff --git a/Documentation/translations/zh_TW/process/development-process.rst b/Documentation/translations/zh_TW/process/development-process.rst
index f4cf5c2bbc82..c4db0e3e72ce 100644
--- a/Documentation/translations/zh_TW/process/development-process.rst
+++ b/Documentation/translations/zh_TW/process/development-process.rst
@@ -11,9 +11,10 @@
 內核開發過程指南
 ================
 
-內容:
+本文檔的目的是幫助開發人員（及其經理）以最小的挫折感與開發社區合作。它試圖記錄這個社區如何以一種不熟悉Linux內核開發（或者實際上是自由軟體開發）的人可以訪問的方式工作。雖然這裡有一些技術資料，但這是一個面向過程的討論，不需要深入了解內核編程就可以理解。
 
 .. toctree::
+   :caption: 內容
    :numbered:
    :maxdepth: 2
 
@@ -26,5 +27,3 @@
    7.AdvancedTopics
    8.Conclusion
 
-本文檔的目的是幫助開發人員（及其經理）以最小的挫折感與開發社區合作。它試圖記錄這個社區如何以一種不熟悉Linux內核開發（或者實際上是自由軟體開發）的人可以訪問的方式工作。雖然這裡有一些技術資料，但這是一個面向過程的討論，不需要深入了解內核編程就可以理解。
-
-- 
2.34.1

