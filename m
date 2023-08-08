Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8584B773713
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjHHCu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjHHCut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:50:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26AA10C0;
        Mon,  7 Aug 2023 19:50:47 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3781jD6I011184;
        Tue, 8 Aug 2023 02:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=iacwFyTqZfahHyyEkmBoZR5f7zZK+DDgWiccFC0bGF0=;
 b=lfK73tl1ZVp+JX1rnC5iaeJZIsQglPeInVdZV6A3vTgTEDkIBFeKLgi3c/p7SGvuQBI6
 oFoq4KK6tbz1rixkYda7PEYO3UVeuQgzfSgxnMz8j3o6GzjuoNfP+0QCJMjWyKH/0fIY
 jje5ziJ2Dlaiw9Scwz17ZpJHSFimwVbLJ2q2XSc9ZQfAgshOVmQfdv7yw926+tBVKT8i
 kuj1PrOkWbZb3jlmebnScbaS0yc79lBd8YxbYgkeAOMBq12Y3MYhrC3luMYBunnOorsg
 IrtQdDovLF9PjncZTJSzcAfxhXvsJ76NCd2Cym/Awt96TK1rk2Bu+YPA6kXZgpNYXEg4 SA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9eyuc491-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 02:50:38 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37806DoV027337;
        Tue, 8 Aug 2023 02:50:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv561nh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 02:50:37 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3782oade010815;
        Tue, 8 Aug 2023 02:50:37 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3s9cv561mp-3;
        Tue, 08 Aug 2023 02:50:36 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     andersson@kernel.org, konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] scsi: ufs: qcom: Add interconnect support
Date:   Mon,  7 Aug 2023 22:50:28 -0400
Message-Id: <169146270858.4040832.9863920717883598606.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731145020.41262-1-manivannan.sadhasivam@linaro.org>
References: <20230731145020.41262-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_28,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=696 bulkscore=0
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080023
X-Proofpoint-GUID: _Tev_mNlBygBktnZapHAtMHG0n4HQkRT
X-Proofpoint-ORIG-GUID: _Tev_mNlBygBktnZapHAtMHG0n4HQkRT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 20:20:18 +0530, Manivannan Sadhasivam wrote:

> This series adds interconnect support to Qcom UFS driver. Interconnect support
> is added to Qcom UFS driver for scaling the interconnect path dynamically. This
> is required to avoid boot crash in recent SoCs and also to save power during
> runtime. More information is available in patch 2/2.
> 
> Credits
> =======
> 
> [...]

Applied to 6.6/scsi-queue, thanks!

[1/2] scsi: ufs: core: Add enums for UFS lanes
      https://git.kernel.org/mkp/scsi/c/e0d01da2cb0f
[2/2] scsi: ufs: qcom: Add support for scaling interconnects
      https://git.kernel.org/mkp/scsi/c/03ce80a1bb86

-- 
Martin K. Petersen	Oracle Linux Engineering
