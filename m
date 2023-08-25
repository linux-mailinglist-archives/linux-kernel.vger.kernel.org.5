Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B4D787CFF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 03:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239958AbjHYBOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 21:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjHYBN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 21:13:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E0E1BF1;
        Thu, 24 Aug 2023 18:13:57 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OJEYX5026981;
        Fri, 25 Aug 2023 01:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=NAqqIX1D9aCgkRNDwHK/98Ct1JDGzdFBC51IMBe4un4=;
 b=qeL5UreZqPSk/TG9DPl9wgOFFq2oxncdW4cYaf+d77PfzP7hVdXDkn+uKe7B+tzc/F8C
 /dZNiGj9M6a0CdDGkcqYbrjYpCj6NeQnFR2T1mDzyI07I72JVwM/peeSffIft4BkxhoQ
 Reog1X+cBPm+HBqGYdeGb/FO6kjCvsDqzEIQwO1KUpB4IMW7Qt8GbYIt9OuUIxZG7vHv
 xEwc9CHW2C9ENcAJZc/ggkZWdIGkEBH3EQqmuycl9xOOdmU5njkEzEBigP8oBg2j3Te1
 8ngHdjNM9NAXRSIAMH5RaC+7I2T463OGHmoTy49AjsfG1UAVGRG42FO7PHBhiDDWWbgx 6w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn20ddctt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 01:13:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37ONkQMs036091;
        Fri, 25 Aug 2023 01:13:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1ywqfkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 01:13:40 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37P1DVEC019787;
        Fri, 25 Aug 2023 01:13:39 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3sn1ywqf8n-10;
        Fri, 25 Aug 2023 01:13:39 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jejb@linux.ibm.com, chenxiang66@hisilicon.com,
        artur.paszkiewicz@intel.com, yanaijie@huawei.com,
        jinpu.wang@cloud.ionos.com, dlemoal@kernel.org,
        John Garry <john.g.garry@oracle.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] libsas: Some tidy-up
Date:   Thu, 24 Aug 2023 21:12:56 -0400
Message-Id: <169292577178.789945.5198957349560725298.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230815115156.343535-1-john.g.garry@oracle.com>
References: <20230815115156.343535-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_01,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=962 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250009
X-Proofpoint-GUID: 2s0_KkNslxyZRl_BHci2ugg5UtdVm3-S
X-Proofpoint-ORIG-GUID: 2s0_KkNslxyZRl_BHci2ugg5UtdVm3-S
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
