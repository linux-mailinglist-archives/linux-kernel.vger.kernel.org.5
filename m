Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079B87D2586
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 20:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbjJVSzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 14:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjJVSzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 14:55:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4312B3;
        Sun, 22 Oct 2023 11:55:19 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39MIigNk021143;
        Sun, 22 Oct 2023 18:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=0wNx4/Gh1EJH/v4J2di/oMPj5N2hjMV44KUHZGbXqw8=;
 b=S95F5eNPofsYQW/n+lkpsQsi0bXFZU6zkOJVPf0wl4j9AUolyqAI9vH15EQ795YXp6QY
 Ir1DpvjFq9OxMLDYd+9zmlodK85pes9DxoWj2zk9jY62MiijIhNleKjAAtEnM1F4U39C
 fjE8qZ62KpdZgEDP9vDJSiq3V7PdCEGi4cjXAH6V/1aHgx8+/D0n6EBhxVdwvmF88+KT
 W6LsITE43dtxkEr+we7F4qXGd/HavQA2rXYxQVsaE7xSBRN9bCDkZdYd4wTTjShR7yYp
 /wQi4DGsFsM9w2IOs/8YwL0krNl1M7CWAc0QdTio64MAupN+0kjFPCmfQCb3t4BSk2Gy 7A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv581hv8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 Oct 2023 18:54:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39MHopQk019016;
        Sun, 22 Oct 2023 18:54:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv533evhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 Oct 2023 18:54:54 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39MIsrIG031295;
        Sun, 22 Oct 2023 18:54:53 GMT
Received: from localhost.localdomain (dhcp-10-175-52-84.vpn.oracle.com [10.175.52.84])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3tv533evgw-1;
        Sun, 22 Oct 2023 18:54:53 +0000
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>,
        "Srivatsa S . Bhat" <srivatsa@csail.mit.edu>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH] cpupower: fix reference to nonexistent document
Date:   Sun, 22 Oct 2023 20:54:46 +0200
Message-Id: <20231022185446.919363-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-22_16,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310220175
X-Proofpoint-GUID: GuHYiyIvtZutb2MYzBxrA9TwnOwbBeGp
X-Proofpoint-ORIG-GUID: GuHYiyIvtZutb2MYzBxrA9TwnOwbBeGp
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file was renamed from .txt to .rst and left a dangling reference.
Fix it.

Fixes: 151f4e2bdc7a ("docs: power: convert docs to ReST and rename to *.rst")
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 tools/power/cpupower/man/cpupower-powercap-info.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/man/cpupower-powercap-info.1 b/tools/power/cpupower/man/cpupower-powercap-info.1
index df3087000efb..145d6f06fa72 100644
--- a/tools/power/cpupower/man/cpupower-powercap-info.1
+++ b/tools/power/cpupower/man/cpupower-powercap-info.1
@@ -17,7 +17,7 @@ settings of all cores, see cpupower(1) how to choose specific cores.
 .SH "DOCUMENTATION"
 
 kernel sources:
-Documentation/power/powercap/powercap.txt
+Documentation/power/powercap/powercap.rst
 
 
 .SH "SEE ALSO"
-- 
2.34.1

