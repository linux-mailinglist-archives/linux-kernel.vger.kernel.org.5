Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C0278E495
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 03:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345654AbjHaBtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 21:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345637AbjHaBtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 21:49:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED0F9C;
        Wed, 30 Aug 2023 18:49:17 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37V0EGnO011938;
        Thu, 31 Aug 2023 01:49:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=NAqqIX1D9aCgkRNDwHK/98Ct1JDGzdFBC51IMBe4un4=;
 b=HhvpSUxhCB97Y/nxJZVkTmcsAjEP+ihHwVx7iicGviMIbEF9kZU450MQzMy0ZhjvSd5f
 sA5vvR9k6tEVKlaaYgT6Xzg5DeXuseGbhZo7fQb03d3tE9cJIUStT/j5/TQ1GZXZWieb
 t92SUMtHtOQYk9shwUheRSYJoUHyKgRZWyYv+EAjFCTPqj3A3EOo2Q3dYDm9CpPYALr+
 TAgy5xa94XRNdBb9SocAA9DvhXecjkDAoOyWAt8ojN5sifR590NB2ldAyTE0jy3SvxXt
 QHCUkw53otfHv41Vmf2R2EQvLJeiiA2BoyUSMwqZ5veM+F6u8q0okLuuj39lqHfIpCRE YQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9xt8smc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Aug 2023 01:49:01 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37V0j6hP032916;
        Thu, 31 Aug 2023 01:49:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6dqtxn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Aug 2023 01:49:00 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37V1mnKv000352;
        Thu, 31 Aug 2023 01:49:00 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3sr6dqtxfw-7;
        Thu, 31 Aug 2023 01:48:59 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jejb@linux.ibm.com, chenxiang66@hisilicon.com,
        artur.paszkiewicz@intel.com, yanaijie@huawei.com,
        jinpu.wang@cloud.ionos.com, dlemoal@kernel.org,
        John Garry <john.g.garry@oracle.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] libsas: Some tidy-up
Date:   Wed, 30 Aug 2023 21:48:34 -0400
Message-Id: <169344360096.1293881.4285235477270655393.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230815115156.343535-1-john.g.garry@oracle.com>
References: <20230815115156.343535-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_01,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=964 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310014
X-Proofpoint-ORIG-GUID: 6vC5SsqO-9LyfWqx0ZSmFivEkCk2L5gt
X-Proofpoint-GUID: 6vC5SsqO-9LyfWqx0ZSmFivEkCk2L5gt
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2023 11:51:46 +0000, John Garry wrote:

> This series tidies-up libsas a bit, including:
> - delete structure(s) with only one member
> - delete structure members which are only ever set
> - delete structure members which are never set and code which relies on
>   that member being set
> 
> This conflicts with the following series:
> https://lore.kernel.org/linux-scsi/20230809132249.37948-1-yuehaibing@huawei.com/
> 
> [...]

Applied to 6.6/scsi-queue, thanks!

[01/10] scsi: libsas: Delete sas_ha_struct.lldd_module
        https://git.kernel.org/mkp/scsi/c/b1bc49731770
[02/10] scsi: libsas: Delete enum sas_class
        https://git.kernel.org/mkp/scsi/c/c46a91709335
[03/10] scsi: libsas: Delete enum sas_phy_type
        https://git.kernel.org/mkp/scsi/c/2f4e20cd6ef8
[04/10] scsi: libsas: Delete struct scsi_core
        https://git.kernel.org/mkp/scsi/c/1136a0225d05
[05/10] scsi: libsas: Delete sas_ssp_task.retry_count
        https://git.kernel.org/mkp/scsi/c/31d9061b475c
[06/10] scsi: libsas: Delete sas_ssp_task.enable_first_burst
        https://git.kernel.org/mkp/scsi/c/ebf26e93cfec
[07/10] scsi: libsas: Delete sas_ssp_task.task_prio
        https://git.kernel.org/mkp/scsi/c/4dc051eb0c6b
[08/10] scsi: libsas: Delete sas_ata_task.set_affil_pol
        https://git.kernel.org/mkp/scsi/c/7b964c402285
[09/10] scsi: libsas: Delete sas_ata_task.stp_affil_pol
        https://git.kernel.org/mkp/scsi/c/44862dc2d2e7
[10/10] scsi: libsas: Delete sas_ata_task.retry_count
        https://git.kernel.org/mkp/scsi/c/86344494e364

-- 
Martin K. Petersen	Oracle Linux Engineering
