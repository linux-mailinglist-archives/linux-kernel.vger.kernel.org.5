Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7B27835AC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 00:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjHUW2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 18:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjHUW16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 18:27:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AC713D;
        Mon, 21 Aug 2023 15:27:54 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LFxT2n014071;
        Mon, 21 Aug 2023 22:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=c5cadN73PA7IqpQZ2d3EUBXx0Fg1FzW9/SSeyGbOd0g=;
 b=AmNNq7c+/3IR5ugnsWXtRBnojMyoobKZ9emoHaj4LHdAuc3FSrQEoTOhptm2JydrzYWd
 67jenrLSRX7wf8pH4gSZzbDfHiEojFosz7ryNuX4TqIdRczEGBep6Tdr++RaxbPVvhbv
 +w6svAeRtV38Pwa9KP+UQcpNapul/8AVJtey6xHDeozaQ+Y9tcKM+WjCgHKyFK+Jdu/p
 isw17yY0mhCBC8kOrQ2mcKjEXkxXYUI7zT4YaE3oGtKvHGHXF96MAr4wgz9eZKN0yyVJ
 ZgtDO+W3zPpP7FD0B4V1Tj22WGVr0F3Ykm5KQ8ocxPVbitqiQZJEx6bw5OKXV39ZBnYk 8A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjnbtv0gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 22:27:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37LKYVV7029793;
        Mon, 21 Aug 2023 22:27:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm6ajb5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 22:27:45 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37LMRiRx021660;
        Mon, 21 Aug 2023 22:27:44 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3sjm6ajb5m-1;
        Mon, 21 Aug 2023 22:27:44 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jejb@linux.ibm.com, adrian.hunter@intel.com, bvanassche@acm.org,
        avri.altman@wdc.com, Jeuk Kim <jeuk20.kim@samsung.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scsi: ufs: ufs-pci: Add support for QEMU
Date:   Mon, 21 Aug 2023 18:27:36 -0400
Message-Id: <169265683485.715970.3832893778954602927.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807013726epcms2p1c604cb8e98680aebebb7cc5ab2d580f5@epcms2p1>
References: <CGME20230807013726epcms2p1c604cb8e98680aebebb7cc5ab2d580f5@epcms2p1> <20230807013726epcms2p1c604cb8e98680aebebb7cc5ab2d580f5@epcms2p1>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_10,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=905
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308210206
X-Proofpoint-GUID: bgL9kZ1vjEZe4WfdpHkcAW86I0gEvuCC
X-Proofpoint-ORIG-GUID: bgL9kZ1vjEZe4WfdpHkcAW86I0gEvuCC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Aug 2023 10:37:26 +0900, Jeuk Kim wrote:

> To ensure that the pci based QEMU ufs device properly works with linux,
> register the device id (0x0013) and vendor id (0x1b36) of QEMU ufs device.
> 
> QEMU UFS will enable testing of the UFS driver inside a virtual machine
> on systems without UFS host controller. It can also be used to preemptively
> implement and test new features before the real device is created.
> 
> [...]

Applied to 6.6/scsi-queue, thanks!

[1/1] scsi: ufs: ufs-pci: Add support for QEMU
      https://git.kernel.org/mkp/scsi/c/a18e81d17a7e

-- 
Martin K. Petersen	Oracle Linux Engineering
