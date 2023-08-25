Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39F2787CF8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 03:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240152AbjHYBOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 21:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237818AbjHYBNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 21:13:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205541BFB;
        Thu, 24 Aug 2023 18:13:50 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OJEofR022564;
        Fri, 25 Aug 2023 01:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=wjYnDCnJ/gIL/9h6HNzHJABHTPt5pAV93o57WL/6Eqc=;
 b=xY0G3vv2fTUpOq8qwsUCzoZb15Y86AY0VWn5HNpzbIbZFBO45lt4v3wKXPqpzLUBnjhk
 /oXh68o10s91z7gWeCrFTZJWMzUb1f1dUjzdIgLXHcWMSr4ULwc6CwkgTMDOfAc5WhR6
 6vZspcvXmKzPYxEZTwqNrw3tWi1l/Vy277QhfADL3FZT4hzHggYl96XJAMF/zkhcVZMm
 9M0x5aJjKdDjk9s1lLfpGjvHTMkv8+HnyB29biumLjFJlz8WC7BI1KmbIpmYcLMORURU
 aeSHATtLgFPucomjZgzuSxakr4uYTVezjG2hhi9g5YR6zgVft8bRGH15xRMoHMFg/lLj DA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yu5hts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 01:13:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37P0d735036245;
        Fri, 25 Aug 2023 01:13:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1ywqfn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 01:13:41 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37P1DVEM019787;
        Fri, 25 Aug 2023 01:13:41 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3sn1ywqf8n-15;
        Fri, 25 Aug 2023 01:13:41 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jinpu.wang@cloud.ionos.com, jejb@linux.ibm.com,
        john.garry@huawei.com, Yue Haibing <yuehaibing@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] scsi: pm8001: Remove unused declarations
Date:   Thu, 24 Aug 2023 21:13:01 -0400
Message-Id: <169292577173.789945.10303176343285024737.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230818124700.49724-1-yuehaibing@huawei.com>
References: <20230818124700.49724-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_01,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=623 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250009
X-Proofpoint-GUID: YijWXBgkF5bYVGOQju-tAhHNBAVcxgsP
X-Proofpoint-ORIG-GUID: YijWXBgkF5bYVGOQju-tAhHNBAVcxgsP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023 20:47:00 +0800, Yue Haibing wrote:

> Commit 4fcf812ca392 ("[SCSI] libsas: export sas_alloc_task()")
> removed these implementations but not the declarations.
> 
> 

Applied to 6.6/scsi-queue, thanks!

[1/1] scsi: pm8001: Remove unused declarations
      https://git.kernel.org/mkp/scsi/c/04aff456af18

-- 
Martin K. Petersen	Oracle Linux Engineering
