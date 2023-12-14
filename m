Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427DC812685
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 05:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjLNEaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 23:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443169AbjLNE3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 23:29:39 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E35139;
        Wed, 13 Dec 2023 20:29:44 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE0SCGT015282;
        Thu, 14 Dec 2023 04:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=bFV8OKkJGodTqyjK8n8DTW2B7ztgrlOO0X7kZb9PVfc=;
 b=gzXAMg/W4tci6GTMjl1vAc4wsq87terZeK0uXSqTk4eI42MYEDjZmdK0BEqEP6DJDYyz
 vwlZ+DNMdTiKUpHdJQ4MeUygMWOLgOsW1DwmriT8HD6v3ShM/9iYL+W/UHeCWMKVRton
 l2sEKMau0S13qvD5P/oMDNjAx5Gd9Xq5A04ra7a4aGjRgerXJguZ74pP+Nr80kH7CbKa
 4HmoSw7PWWr1a6qo9iw8kdJckTjlF4r0nkgH67deTK3GMYfutIU/RHHJwbzVOdamUIOy
 PDIlxskKt/nnT6McXekbwELnvZG1gGKbvVRmVhuxV8RmWf3vmR2zvH22vA3U75oQTMDS 2A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwgn3r25g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 04:29:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE3awI8009848;
        Thu, 14 Dec 2023 04:29:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep9ev45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 04:29:30 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BE4TQMM035965;
        Thu, 14 Dec 2023 04:29:30 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uvep9ev0g-10;
        Thu, 14 Dec 2023 04:29:30 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     brking@us.ibm.com, Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        jejb@linux.ibm.com, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ipr: Remove obsolete check for old CPUs
Date:   Wed, 13 Dec 2023 23:29:15 -0500
Message-ID: <170205513100.1790765.774706440257641676.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231127111740.1288463-1-mpe@ellerman.id.au>
References: <20231127111740.1288463-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_01,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312140024
X-Proofpoint-ORIG-GUID: A-lVqce28UXu8pv09wQDegTOzjQa28JF
X-Proofpoint-GUID: A-lVqce28UXu8pv09wQDegTOzjQa28JF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023 22:17:40 +1100, Michael Ellerman wrote:

> The IPR driver has a routine to check whether it's running on certain
> CPU versions and if so whether the adapter is supported on that CPU.
> 
> But none of the CPUs it checks for are supported by Linux anymore.
> 
> The most recent CPU it checks for is Power4+ which was removed in commit
> 471d7ff8b51b ("powerpc/64s: Remove POWER4 support").
> 
> [...]

Applied to 6.8/scsi-queue, thanks!

[1/1] scsi: ipr: Remove obsolete check for old CPUs
      https://git.kernel.org/mkp/scsi/c/84e46978b91f

-- 
Martin K. Petersen	Oracle Linux Engineering
