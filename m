Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280ED77371F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjHHCvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjHHCvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:51:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3658710E0;
        Mon,  7 Aug 2023 19:50:55 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3781jG8g024289;
        Tue, 8 Aug 2023 02:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=RJKjb9iir6ZKATjLFX0/AMRZlGCWU2V69ESNnUDMjuY=;
 b=HPyigEuPtmluNF1kzjQ/YoLq8K+kbga2JEVWpWBOVOPu9xh4ng04SwM9lz9U1grKWqKc
 KZ38TlLzVRdzecfkM2VHAbqdjxjtnBL2xBlfLnj8cMf3a4STygednoMFvvg4uZnA58PE
 NkOyRJTyUewAKS02zYtRvuPpslz2Kzq23+74gKStmL185v9UpwIPO62dYQo/08qCZ/Db
 vOlLPo2HCdUljyrpzzL+F9js+laQcebmSj1XGGbrLFQwHpP5St4h8R+XoNUkwGw2iJPA
 SiaKuQjUyIecGNXJ5Jw1gfD8roPqgMJC6vSYhjWNa6439fdxZgL6rfJimUszsu65wIgV bg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9eaam459-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 02:50:39 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3782Xg8Q027833;
        Tue, 8 Aug 2023 02:50:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv561ny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 02:50:38 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3782oadi010815;
        Tue, 8 Aug 2023 02:50:38 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3s9cv561mp-5;
        Tue, 08 Aug 2023 02:50:37 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sunil V L <sunilvl@ventanamicro.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] scsi: hisi_sas: Fix warning detected by sparse
Date:   Mon,  7 Aug 2023 22:50:30 -0400
Message-Id: <169146270852.4040832.12704177144124933887.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230726051759.30038-1-sunilvl@ventanamicro.com>
References: <20230726051759.30038-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_28,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=898 bulkscore=0
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080023
X-Proofpoint-ORIG-GUID: wYO83yOVnrSBcW6Uxuz2oTRDJ3OlxkYG
X-Proofpoint-GUID: wYO83yOVnrSBcW6Uxuz2oTRDJ3OlxkYG
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 10:47:59 +0530, Sunil V L wrote:

> LKP reports below warning when building for RISC-V
> with randconfig configuration.
> 
> drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:4567:35: sparse:
> sparse: incorrect type in argument 4 (different base types)
> @@     expected restricted __le32 [usertype] *[assigned] ptr
> @@     got unsigned int * @@
> 
> [...]

Applied to 6.6/scsi-queue, thanks!

[1/1] scsi: hisi_sas: Fix warning detected by sparse
      https://git.kernel.org/mkp/scsi/c/b7fc2caf20ea

-- 
Martin K. Petersen	Oracle Linux Engineering
