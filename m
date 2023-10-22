Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B717D2573
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 20:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjJVSto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 14:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVStm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 14:49:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB9C197;
        Sun, 22 Oct 2023 11:49:40 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39MBM0B9013546;
        Sun, 22 Oct 2023 18:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=AfPo0CQqUl2C/VImdIgEdj8artktDGxCrai/+Jf+/ls=;
 b=2u3rUBj+IajFU+0RlyB5UsmEQL+cB7He8Q61HCIBCen+r60UT5p7xOCRSpBmEc4kb7Oy
 74J1kMk3SOsFmZaDh3KHCqMoFzclp+aC7ZkTZCeCgGOGdxRAmKhl+BDtiLBl6EX8NQaM
 JuYkeHP8iVT7ZUqHvdV/F1QBrF6ETz0xGQvJobpBauB/z4bu+z72Re0SrrBAwM7yMEM8
 Yq6uSd/ypSZSc3ZJZD2Hg6AJzfOu8WHeKzDfLhySb3+fX6cj0fdima4z8vE9V/mjuexV
 xrUOx/XodWVjlzORlR7YjFTDVMfLLDYk/i02wErpozEOWgETDUAMZ1gw4cWFFgEasv11 ow== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5jb9v21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 Oct 2023 18:49:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39MIaj8x001460;
        Sun, 22 Oct 2023 18:49:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv539pu0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 Oct 2023 18:49:30 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39MInTYB017392;
        Sun, 22 Oct 2023 18:49:29 GMT
Received: from localhost.localdomain (dhcp-10-175-52-84.vpn.oracle.com [10.175.52.84])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3tv539pu06-1;
        Sun, 22 Oct 2023 18:49:29 +0000
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH] docs: doc-guide: mention 'make refcheckdocs'
Date:   Sun, 22 Oct 2023 20:49:10 +0200
Message-Id: <20231022184910.919201-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-22_16,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310220174
X-Proofpoint-GUID: hI2lr3l0GhQELYIt-CfApe4OXJNAAuXb
X-Proofpoint-ORIG-GUID: hI2lr3l0GhQELYIt-CfApe4OXJNAAuXb
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add this to the section on fixing warnings.

Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/doc-guide/contributing.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/doc-guide/contributing.rst b/Documentation/doc-guide/contributing.rst
index d4793826ad9a..662c7a840cd5 100644
--- a/Documentation/doc-guide/contributing.rst
+++ b/Documentation/doc-guide/contributing.rst
@@ -138,6 +138,10 @@ times, but it's highly important.  If we can actually eliminate warnings
 from the documentation build, then we can start expecting developers to
 avoid adding new ones.
 
+In addition to warnings from the regular documentation build, you can also
+run ``make refcheckdocs`` to find references to nonexistent documentation
+files.
+
 Languishing kerneldoc comments
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.34.1

