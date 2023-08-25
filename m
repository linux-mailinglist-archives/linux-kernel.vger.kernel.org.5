Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2A37890C2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 23:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjHYVvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 17:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjHYVvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 17:51:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CC426AF;
        Fri, 25 Aug 2023 14:51:28 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PIEOv1031083;
        Fri, 25 Aug 2023 21:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=vNBIvltdc39krwBWu+BwzX3iIBgpvpQ3v6V5YRJoG1g=;
 b=i5tGL4L9X5C1vNJvEfJ2wdakDUgSuV0+0OCy4smFuEoXr6ELl7Uz4BCEMxaTdhTaIxwx
 MKT9gpGsNq7tEmtoCi2vXtpDmDBxwKVeviP4dbpizeB+MxX+K7d188/TL5sEcCNwT5yf
 Y7Y7f/ESxDgKauLOO844Mmq62/OQ5+DaMJ2CoPT0pD2SLfzCFvnyFhNtViLphqiSJe/D
 b9IbTgOuPgTHML5ghr5957YfqbpY6vyOj3PK065+NXk1ZUXTpwtKG+60mxeg5WrlHBlU
 42s5owxsTbqxF1eASf2pGSJVAJLB7SVB/FUnaiX7IVzb3ekq8zYo73brybvpCqlMBStH Bg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn20cq8k1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 21:51:16 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37PKGadr005812;
        Fri, 25 Aug 2023 21:51:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yv4en9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 21:51:15 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37PLpDvX019636;
        Fri, 25 Aug 2023 21:51:15 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3sn1yv4eg7-2;
        Fri, 25 Aug 2023 21:51:14 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jejb@linux.ibm.com, john.g.garry@oracle.com, bvanassche@acm.org,
        bblock@linux.ibm.com, dan.carpenter@linaro.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhu Wang <wangzhu9@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH -next v2] scsi: Remove raid_component_add()
Date:   Fri, 25 Aug 2023 17:51:00 -0400
Message-Id: <169300023876.1212091.15299365995936177450.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230822015254.184270-1-wangzhu9@huawei.com>
References: <20230822015254.184270-1-wangzhu9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_19,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 mlxlogscore=548 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308250195
X-Proofpoint-ORIG-GUID: IiYSPElHf5CUQKGEzajmOPt3YpqVbBsE
X-Proofpoint-GUID: IiYSPElHf5CUQKGEzajmOPt3YpqVbBsE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2023 01:52:54 +0000, Zhu Wang wrote:

> The raid_component_add() function was added to the kernel tree via
> patch "[SCSI] embryonic RAID class" (2005). Remove this function since
> it never has had any callers in the Linux kernel. And also
> raid_component_release is only used in raid_component_add(), so it is
> also removed.
> 
> 
> [...]

Applied to 6.5/scsi-fixes, thanks!

[1/1] scsi: Remove raid_component_add()
      https://git.kernel.org/mkp/scsi/c/60c5fd2e8f3c

-- 
Martin K. Petersen	Oracle Linux Engineering
