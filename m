Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9D27BF0A6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 04:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441832AbjJJCJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 22:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379326AbjJJCJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 22:09:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8804E9F;
        Mon,  9 Oct 2023 19:09:55 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399NwjQF007687;
        Tue, 10 Oct 2023 02:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=0LveXQE+MVdCxsgEAOJKLVY9bU5JFnPNXgnTY+F1FwU=;
 b=DCko350fWoakPcEDjHWnriGiBZvu40dl4iPdP4tsr6vSX6bd9QE2HfWxP58RePSl/vU5
 ACh2Kr2L4Wax8C53NbouCw6hk0giTz/rvTk2dSD2Ak4GvH/9rxvujpxFDi+eB8EjVwD2
 b/rraART0PPdlmGcbvfFh8S0hgDfIo/5lU8tfMGVSPOLT0gICY2jDhCYhJ8k/4iaa+GC
 8kowhmn4q2elXfaCZ4QntTpZBdwz/DugyWIntDhswt+w/I4I8CxypjxvMzjZsVIIWCmN
 HkuD9GXsjXfN1YdD2RG3DdHIFiWnzrWGH6LDWYgMd/M+SZ0y21W9jM2N5aDxAOZxKyuM NA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjycdm0gu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 02:09:42 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39A05wWG014885;
        Tue, 10 Oct 2023 02:09:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws63mbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 02:09:41 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39A29dUK036611;
        Tue, 10 Oct 2023 02:09:41 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3tjws63m9y-2;
        Tue, 10 Oct 2023 02:09:40 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     satishkh@cisco.com, Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        sebaddel@cisco.com, kartilak@cisco.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] scsi: fnic: clean up some inconsistent indenting
Date:   Mon,  9 Oct 2023 22:09:33 -0400
Message-Id: <169690017531.1410956.14131508778746287052.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230922100657.14566-1-jiapeng.chong@linux.alibaba.com>
References: <20230922100657.14566-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_01,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=691 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310100013
X-Proofpoint-ORIG-GUID: XXshYvq10UALNWW4hLIHfITnibJG00eV
X-Proofpoint-GUID: XXshYvq10UALNWW4hLIHfITnibJG00eV
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023 18:06:57 +0800, Jiapeng Chong wrote:

> No functional modification involved.
> 
> drivers/scsi/fnic/fnic_fcs.c:152 fnic_handle_link() warn: inconsistent indenting.
> 
> 

Applied to 6.7/scsi-queue, thanks!

[1/1] scsi: fnic: clean up some inconsistent indenting
      https://git.kernel.org/mkp/scsi/c/5ef104b749e8

-- 
Martin K. Petersen	Oracle Linux Engineering
