Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D470776A17B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjGaTp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjGaTpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:45:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071491FC3;
        Mon, 31 Jul 2023 12:45:38 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VDTaDI024754;
        Mon, 31 Jul 2023 19:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=G7YJJ2j0tg7epV7YgG1Ddfsc8YtQIbaDMwZxEVp+CQI=;
 b=QqV4wdu5bfJ2XKqvtfryPwOyfC6ADMLt8wEOfwq6iQ+2zvYWXHf51aOiWNK2dMxRJTHn
 mLBjMdWcFL17rWeoLjs0UWXKqAkZSz5A8L6vpki+pclFsBY2BnVQP/xow61BHYTWFy2r
 5Htc15K5nr+sYbSLo9Jgp3AJ0juPltl7UXkzZfQy0SNQhOcgMmGoydViN71vXXU74zFj
 z7wV9RWfUIXHMZilH0oj58drO5+NCwQZ0bZcMNjjcjMwS98tizGYbZ+gp1W2nS46LQHD
 6O9HUTSKjEDPsYcffXAD0Wl8e39tTHFB+iOIG+v3WivaCV1ll2ngJcclD1JSiP1uOoS4 Aw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4tnbbdpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 19:45:22 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VIFp8G013569;
        Mon, 31 Jul 2023 19:45:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s75cmse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 19:45:21 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36VJjEfj025102;
        Mon, 31 Jul 2023 19:45:21 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3s4s75cmf1-6;
        Mon, 31 Jul 2023 19:45:21 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     lduncan@suse.com, cleech@redhat.com, michael.christie@oracle.com,
        jejb@linux.ibm.com, haowenchao@huawei.com,
        YueHaibing <yuehaibing@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] scsi: iscsi: Remove unused extern declaration iscsi_lookup_iface()
Date:   Mon, 31 Jul 2023 15:45:07 -0400
Message-Id: <169083266404.2873709.17161054183653404974.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230725141531.10424-1-yuehaibing@huawei.com>
References: <20230725141531.10424-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_13,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxlogscore=771 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310179
X-Proofpoint-ORIG-GUID: 814jzVMC9Vm9OCeTPL49B1wqTB0w9oPC
X-Proofpoint-GUID: 814jzVMC9Vm9OCeTPL49B1wqTB0w9oPC
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 22:15:31 +0800, YueHaibing wrote:

> This is not used anymore, so can be removed.
> 
> 

Applied to 6.6/scsi-queue, thanks!

[1/1] scsi: iscsi: Remove unused extern declaration iscsi_lookup_iface()
      https://git.kernel.org/mkp/scsi/c/a615e93d6cfe

-- 
Martin K. Petersen	Oracle Linux Engineering
