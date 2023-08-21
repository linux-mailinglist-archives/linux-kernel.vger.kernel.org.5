Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892667835AA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 00:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjHUW2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 18:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjHUW1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 18:27:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEFCDB;
        Mon, 21 Aug 2023 15:27:51 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LFxJOY031473;
        Mon, 21 Aug 2023 22:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=qfYH4TxpfPIOVenF9f9ZDTuwn3n9dL2N2NBSi46iuAU=;
 b=Vu7N2DHabFtRcaJa0IIG+vwQ/qn9b0XEu+g80OSHhQRtAhxhbb9nGUYTPZFb7LYWKb0b
 43JKWLRmZHUfgT85so67oruM8iDtlElMjTETUjleWT7b1NU1mmlFaE+CSK0/aME1iyFc
 dU2mdcO8jhm0TwlER00cE/Byj0ny1nCz6yPpHdealRbr61Sa97/ZI2RBQc6GUZ772QOb
 XdVXh7TYwYZBXsxuCmGDpXjmgZu4mCB2b4/P5XkzHV0UzMyZQ7x0eTomTdLt96WFW44J
 5O89upJiYxiGTo964qfi7j8lWCYeSNqAHoEX2dZjyhqJDuIrQ1mhiSpMftEEglsgVvfd Dg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjnscc1w2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 22:27:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37LM5D6j029822;
        Mon, 21 Aug 2023 22:27:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm6ajb64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 22:27:45 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37LMRiS1021660;
        Mon, 21 Aug 2023 22:27:45 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3sjm6ajb5m-2;
        Mon, 21 Aug 2023 22:27:45 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     andersson@kernel.org, konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] scsi: ufs: qcom: Make struct ufs_qcom_bw_table static const
Date:   Mon, 21 Aug 2023 18:27:37 -0400
Message-Id: <169265683481.715970.17212549902659421051.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230802040154.10652-1-manivannan.sadhasivam@linaro.org>
References: <20230802040154.10652-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_10,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=782
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308210206
X-Proofpoint-GUID: LyxIhjj2G585q4avjQ_ed0wiCBQjmddi
X-Proofpoint-ORIG-GUID: LyxIhjj2G585q4avjQ_ed0wiCBQjmddi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Aug 2023 09:31:54 +0530, Manivannan Sadhasivam wrote:

> ufs_qcom_bw_table is not modified anywhere. So make it static const so that
> it can be placed in read-only memory.
> 
> 

Applied to 6.6/scsi-queue, thanks!

[1/1] scsi: ufs: qcom: Make struct ufs_qcom_bw_table static const
      https://git.kernel.org/mkp/scsi/c/01e747157b61

-- 
Martin K. Petersen	Oracle Linux Engineering
