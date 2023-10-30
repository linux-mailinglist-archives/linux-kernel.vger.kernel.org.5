Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824777DBCB5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbjJ3Pf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbjJ3PfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:35:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CEAD9;
        Mon, 30 Oct 2023 08:35:15 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UD3xLx012096;
        Mon, 30 Oct 2023 15:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=cSw07YagL98EOVnfuNXbnPniTldyUjYyuixlhgueqmo=;
 b=AqHfQDp6uCvrKvgadZQBe41c+GyTeLBs6jO3OOccVVAyJ+GABXEzlCh6Sk1tL/2sS+6i
 WtqaYhQQIunnjmCASFRcDiIyivGtkO0imwuoeBvzwlCcnLB8rLfk6s69le7Du1CCTdWT
 5YXr4cuFgPhcsG5zi+qKOUb7SHY+x4yb9WW5Lhb2AkPb/w3SWsp/MNJy/GCpCjAOoHZp
 hIWfKVHo5JZV5AmyzPIK/fnSMUTMO77BCEQBHF7DJeC+9eMnHcQAzjFIK73den/I+xwc
 epLGQ/Iqa/3zA68zEcPhBbVScfV2tqSWc0PlMJTnLJpkiGJbQmcSrgMB0FTMRixoBwDI /Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0s33u5pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 15:34:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39UE3wc8038039;
        Mon, 30 Oct 2023 15:34:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rran8wn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 15:34:59 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39UFVkmA023458;
        Mon, 30 Oct 2023 15:34:58 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3u0rran8wc-1;
        Mon, 30 Oct 2023 15:34:58 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Wenchao Hao <haowenchao2@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        louhongxiang@huawei.com
Subject: Re: [PATCH v3 0/2] cleanup patch
Date:   Mon, 30 Oct 2023 11:34:45 -0400
Message-Id: <169868005488.2933713.18395761386334531936.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018113746.1940197-1-haowenchao2@huawei.com>
References: <20231018113746.1940197-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 mlxlogscore=774 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310300120
X-Proofpoint-GUID: fCAT2PRF4x6NL7fzBnFjbMeExDTc_UtX
X-Proofpoint-ORIG-GUID: fCAT2PRF4x6NL7fzBnFjbMeExDTc_UtX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023 19:37:44 +0800, Wenchao Hao wrote:

> This is a cleanup patchset, no logic changed.
> 
> The first patch cleanup scsi_dev_queue_ready();
> The second patch add comment to tell callback target_destroy of
> scsi_host_template must not sleep.
> 
> V3:
>   - Update comments suggested by Bart
> 
> [...]

Applied to 6.7/scsi-queue, thanks!

[1/2] scsi: core: cleanup scsi_dev_queue_ready()
      https://git.kernel.org/mkp/scsi/c/3dc985bfbd00
[2/2] scsi: Add comment of target_destroy in scsi_host_template
      https://git.kernel.org/mkp/scsi/c/82f52b2cd5fc

-- 
Martin K. Petersen	Oracle Linux Engineering
