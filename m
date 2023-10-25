Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEEC7D5FD6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 04:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjJYCUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 22:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYCUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 22:20:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02F69C;
        Tue, 24 Oct 2023 19:20:05 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OLUNN6004153;
        Wed, 25 Oct 2023 02:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=BoJr5H11P3Mxq3RdCvbv/K4oFLgQ2TVLlaOWrcTCKVA=;
 b=pTQdANJyioC3m+r9ve023Kg9iRG3ds0R+WfQ3nYga1KW8Or9zRCLbGuo1dxZNrXuFwDN
 dQSBjKHRLOIYJOdg1mb9X+EuqNOfQdB7tnoNjSpDf7CP44WRBdx59SVT/7ja4oVN3a2/
 UM0Oo/gdI6fSy2iqZBd0Bi6sZ3rxJsiAExyhUwQQjhx6oHtRDEDWdeQEkgXou3O/rF/j
 2RiBY4JQiG0ffNICsPccmwPfIMN7hBfbTrsyhrWmtJERNbR7zEzPKPcXc0xnH/30JzBd
 ZPImBvmA9cbLQXUOQkvczoIXkcIvuIDwAWOyg82EzdAMBzcoiBF/qeoVf7/Bss4Kqh0I vA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv581pr9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 02:19:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39P0LjbR015130;
        Wed, 25 Oct 2023 02:19:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tv53621a5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 02:19:52 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39P2JpFK000926;
        Wed, 25 Oct 2023 02:19:52 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3tv5362196-2;
        Wed, 25 Oct 2023 02:19:52 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Douglas Gilbert <dgilbert@interlog.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        louhongxiang@huawei.com
Subject: Re: [PATCH v6 00/10] scsi:scsi_debug: Add error injection for single device
Date:   Tue, 24 Oct 2023 22:19:44 -0400
Message-Id: <169819964272.2667926.6343411701212225977.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231010092051.608007-1-haowenchao2@huawei.com>
References: <20231010092051.608007-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=985
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250018
X-Proofpoint-GUID: l5JbVltxVkkgXdqC-5QwO4vc7xS5ppie
X-Proofpoint-ORIG-GUID: l5JbVltxVkkgXdqC-5QwO4vc7xS5ppie
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023 17:20:41 +0800, Wenchao Hao wrote:

> The original error injection mechanism was based on scsi_host which
> could not inject fault for a single SCSI device.
> 
> This patchset provides the ability to inject errors for a single
> SCSI device. Now we support inject timeout errors, queuecommand
> errors, and hostbyte, driverbyte, statusbyte, and sense data for
> specific SCSI Command. Two new error injection is defined to make
> abort command or reset LUN failed.
> 
> [...]

Applied to 6.7/scsi-queue, thanks!

[01/10] scsi: scsi_debug: create scsi_debug directory in the debugfs filesystem
        https://git.kernel.org/mkp/scsi/c/6e2d15f59b1c
[02/10] scsi: scsi_debug: Add interface to manage single device's error inject
        https://git.kernel.org/mkp/scsi/c/a9996d722b11
[03/10] scsi: scsi_debug: Define grammar to remove added error injection
        https://git.kernel.org/mkp/scsi/c/962d77cd4c85
[04/10] scsi: scsi_debug: timeout command if the error is injected
        https://git.kernel.org/mkp/scsi/c/32be8b6e22eb
[05/10] scsi: scsi_debug: Return failed value if the error is injected
        https://git.kernel.org/mkp/scsi/c/33bccf55c20b
[06/10] scsi: scsi_debug: set command's result and sense data if the error is injected
        https://git.kernel.org/mkp/scsi/c/33592274321e
[07/10] scsi: scsi_debug: Add new error injection abort failed
        https://git.kernel.org/mkp/scsi/c/5551ce928805
[08/10] scsi: scsi_debug: Add new error injection reset lun failed
        https://git.kernel.org/mkp/scsi/c/0267811625e1
[09/10] scsi: scsi_debug: Add debugfs interface to fail target reset
        https://git.kernel.org/mkp/scsi/c/f084fe52c640
[10/10] scsi: scsi_debug: Add param to control sdev's allow_restart
        https://git.kernel.org/mkp/scsi/c/573c2d066eb9

-- 
Martin K. Petersen	Oracle Linux Engineering
