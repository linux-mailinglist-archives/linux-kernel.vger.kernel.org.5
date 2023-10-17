Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8490B7CB7D3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 03:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbjJQBMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 21:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbjJQBMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 21:12:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5890A7;
        Mon, 16 Oct 2023 18:12:10 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GKO8Ww014417;
        Tue, 17 Oct 2023 01:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=0UqtvTlWtYUjTwRaatrPSa61bjeGeeFg2mCM1sTDg0k=;
 b=gghMr2KNFMowyXOT8sYVqNeRDc72XhP+OPkm7jG6yQDElSqPWgM2bi971nVaErdlCaaU
 ck3mPlEN+84evDhlkLWKDfPBZFOI26HkkKdro9drgienqqrtu9aPA2cYx6dfBYXVpuid
 P4+K5deTt+4+eHMQtNJ6a/ofW/+GzlAFOdiJmD/91RoZa0Lm0haChNDZGmvn0dCx5zUO
 dkA2eNhw8BqEDMlsflzTkRbai+vaBp/D833KZMqEru0yeTu1NSGp1h5JAa1TGvU7Ihso
 cwoEWI5doV9IXsyxHlBPzW48zsB+pLfdSOFd1d4pneUMHfCLxGyj063GiVpWPtUxssOc 0g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1bkykn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 01:12:08 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39GMpBM0027214;
        Tue, 17 Oct 2023 01:12:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3trg5366py-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 01:12:07 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39H1C3so039761;
        Tue, 17 Oct 2023 01:12:07 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3trg5366mf-5;
        Tue, 17 Oct 2023 01:12:07 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jejb@linux.ibm.com, Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: scsi: cxgbi: libcxgbi.c: Fixed 'generated' typo
Date:   Mon, 16 Oct 2023 21:11:52 -0400
Message-Id: <169750286901.2183937.9053747172413544155.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231013055121.12310-1-m.muzzammilashraf@gmail.com>
References: <20231013055121.12310-1-m.muzzammilashraf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=721 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310170008
X-Proofpoint-GUID: 6WAJSJ-VIT4zOOdkC-8fyhaIQFKWEpDi
X-Proofpoint-ORIG-GUID: 6WAJSJ-VIT4zOOdkC-8fyhaIQFKWEpDi
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 10:51:21 +0500, Muhammad Muzammil wrote:

> Fixed 'generated' typo
> 
> 

Applied to 6.7/scsi-queue, thanks!

[1/1] drivers: scsi: cxgbi: libcxgbi.c: Fixed 'generated' typo
      https://git.kernel.org/mkp/scsi/c/f42706a8f0cb

-- 
Martin K. Petersen	Oracle Linux Engineering
