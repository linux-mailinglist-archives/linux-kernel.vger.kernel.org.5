Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA9F792B70
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239167AbjIEQxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354246AbjIEKTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:19:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2B618D;
        Tue,  5 Sep 2023 03:19:31 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3853PHAT011372;
        Tue, 5 Sep 2023 10:18:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=EcuX8KjamwI7Dq570CAvr+Skf4pa4oyab+qhvsVTb8k=;
 b=J91QkLkgzxT5Si7NG6c+3JhqkLy94fXYlHHbAMLdDOUQqJSip2UD8QhL9kFwtUxiTkw/
 p75fAeMnNYyGD59SCJo1pUWhSKydH6cR/G3iQvesHas5c8GVMlTLaAQLRSrrkAZxUBtb
 a152pkB7PX7pVZZcnDtHBLY2gc201IjvUCDmH+kyBdUxeYaXm2D244sCJhw3N27vz5cM
 NaiKtQbuLtl3iizt280dOv/rd25RyqM5Xr8qcaJklcUI63HRxovAJRXjvtJLp9tjrJuD
 4Kcdmw1b1zE+Z9kUqj7JvwAgBnBXb9oXz4UsaFYFHrDGD5QkzGMF6Cr2aIFJE0ndGApT Aw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3suuu3mxup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 10:18:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3859eCR1029092;
        Tue, 5 Sep 2023 10:18:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug4j8b2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 10:18:48 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 385AIlOV032271;
        Tue, 5 Sep 2023 10:18:47 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3suug4j85n-1;
        Tue, 05 Sep 2023 10:18:47 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        stanley.chu@mediatek.com, beanhuo@micron.com, bvanassche@acm.org,
        tomas.winkler@intel.com, cang@codeaurora.org,
        jonghwi.rha@samsung.com, Bean Huo <beanhuo@iokpp.de>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Changes for UFS advanced RPMB
Date:   Tue,  5 Sep 2023 06:18:24 -0400
Message-Id: <169390541198.1533355.3634162443096116989.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230809181847.102123-1-beanhuo@iokpp.de>
References: <20230809181847.102123-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_08,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=619 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309050092
X-Proofpoint-ORIG-GUID: VfTuX7lK00J7tZbqDhGwzp7TbcIHBSjf
X-Proofpoint-GUID: VfTuX7lK00J7tZbqDhGwzp7TbcIHBSjf
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Aug 2023 20:18:45 +0200, Bean Huo wrote:

> Bean Huo (2):
>   scsi: ufs: core: Add advanced RPMB support where UFSHCI 4.0 does not
>     support EHS length in UTRD
>   scsi: ufs: core: No need to update UPIU.header.flags and lun in
>     advanced RPMB handler
> 
> drivers/ufs/core/ufs_bsg.c |  3 +--
>  drivers/ufs/core/ufshcd.c  | 14 ++++++++++----
>  2 files changed, 11 insertions(+), 6 deletions(-)
> 
> [...]

Applied to 6.6/scsi-queue, thanks!

[1/2] scsi: ufs: core: Add advanced RPMB support where UFSHCI 4.0 does not support EHS length in UTRD
      https://git.kernel.org/mkp/scsi/c/c91e585cfb3d
[2/2] scsi: ufs: core: No need to update UPIU.header.flags and lun in advanced RPMB handler
      https://git.kernel.org/mkp/scsi/c/9f6fec656613

-- 
Martin K. Petersen	Oracle Linux Engineering
