Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210E9787CE9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 03:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237437AbjHYBOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 21:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237357AbjHYBNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 21:13:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD6B1BF1;
        Thu, 24 Aug 2023 18:13:47 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OJEYoM007801;
        Fri, 25 Aug 2023 01:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=5260xzaHyO6XyQi1Mo1mIN5drHIusf4DHMyEutde8/k=;
 b=OkGk5T8qDpre2DBJUpLWkBdTM2fggp6J9Rr/0vD0qDwfJBhbPyMER/ydj6X0dg3f6sUX
 /bOTx3HvFgBC1c8LvriLCMTzZk8YQSdU97eniAm4eHXR7tvQ732/7DEXR+YRqhGUznha
 xJlD3YAD0in+oPG8CbbsFVol68ZiQ9jh9DcJsWFgrRABYQDJI2kcVDtIKfwr+mOp5uqe
 fH8DPXifwDIIjjg0/JXEH3zrBT7lEq+2pJIYUrK5XM3UYzuFgizpTMY76TEOO6/kXM86
 x+fkPZvsG/Ns4aaBLuNoIPxVL3lIZjaotX85PT353+ZxQFDS0P7qt+3NEBle4tV8MZMN Og== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yvwcny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 01:13:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37P0AZ0I036049;
        Fri, 25 Aug 2023 01:13:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1ywqfj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 01:13:37 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37P1DVE0019787;
        Fri, 25 Aug 2023 01:13:37 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3sn1ywqf8n-4;
        Fri, 25 Aug 2023 01:13:37 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Artem Chernyshev <artem.chernyshev@red-soft.ru>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] scsi: isci: init Return result of sas_register_ha()
Date:   Thu, 24 Aug 2023 21:12:50 -0400
Message-Id: <169292577154.789945.13458266128732412253.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813202336.240874-1-artem.chernyshev@red-soft.ru>
References: <20230813202336.240874-1-artem.chernyshev@red-soft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_01,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=775 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250009
X-Proofpoint-ORIG-GUID: UDdIW3tt0F-UZyppdfdmEJ_8G1Y9ORfF
X-Proofpoint-GUID: UDdIW3tt0F-UZyppdfdmEJ_8G1Y9ORfF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Aug 2023 23:23:36 +0300, Artem Chernyshev wrote:

> To properly manage possible failure of sas_register_ha() in
> isci_register_sas_ha() return it's result instead of zero
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> 

Applied to 6.6/scsi-queue, thanks!

[1/1] scsi: isci: init Return result of sas_register_ha()
      https://git.kernel.org/mkp/scsi/c/9a23ed57abbb

-- 
Martin K. Petersen	Oracle Linux Engineering
