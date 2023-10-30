Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF407DBCCE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjJ3Pj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjJ3PjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:39:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39664C9;
        Mon, 30 Oct 2023 08:39:21 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UDcOfQ029600;
        Mon, 30 Oct 2023 15:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=cbJsm6eXFARNAA8yOhcMaHvGvkPuRyOWad3dmiNECC8=;
 b=z++n8SLfk6OqtmeVgMayLk4vCOBrUgIy2PsZC1lPdB89s0MR3LiNICAtrJMTF5iCyirq
 ZskZhQNwJ+3vgapSoJvXmWY6fM/CxL0k3RLelxt9nI0k9FwIza91LXJwE4YehMwc9nxQ
 fhl7dXF002qKtg2FNZ4JQcmucrxLZE9pYMh+/v7SA9hj1F/RQMU9JDXCMrUDPKnf2QjJ
 Pr/dICpjVZtxgZ4EfKD9yu9TERFwdVKaXD9EXXxpRiQIXgilrZMC127xY7zgpkbUNlej
 oH9ODA0UDvreYjQ8at9fUwogZpURmXwP3vKVPim4IJlSlp3UhnqcGfmNq2iTTXSEtq0I zg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0rqdu3md-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 15:35:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39UE3vOp038030;
        Mon, 30 Oct 2023 15:35:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rran8yj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 15:35:02 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39UFVkmO023458;
        Mon, 30 Oct 2023 15:35:01 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3u0rran8wc-8;
        Mon, 30 Oct 2023 15:35:01 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jejb@linux.ibm.com, Yang Li <yang.lee@linux.alibaba.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] scsi: pmcraid: Fix some kernel-doc comments
Date:   Mon, 30 Oct 2023 11:34:52 -0400
Message-Id: <169868005482.2933713.3189661563408433659.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231017025853.67562-1-yang.lee@linux.alibaba.com>
References: <20231017025853.67562-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310300120
X-Proofpoint-ORIG-GUID: Urx5EDdlwMUyAD1xvws2jw78_xRSpWWv
X-Proofpoint-GUID: Urx5EDdlwMUyAD1xvws2jw78_xRSpWWv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2023 10:58:53 +0800, Yang Li wrote:

> Fix some kernel-doc comments to silence the warnings:
> drivers/scsi/pmcraid.c:2697: warning: Excess function parameter 'scsi_cmd' description in 'pmcraid_reset_device'
> drivers/scsi/pmcraid.c:2697: warning: Function parameter or member 'scsi_dev' not described in 'pmcraid_reset_device'
> 
> 

Applied to 6.7/scsi-queue, thanks!

[1/1] scsi: pmcraid: Fix some kernel-doc comments
      https://git.kernel.org/mkp/scsi/c/9e1c911ecbbc

-- 
Martin K. Petersen	Oracle Linux Engineering
