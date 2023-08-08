Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955D6773710
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjHHCus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjHHCuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:50:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096F219F;
        Mon,  7 Aug 2023 19:50:44 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3781i2VX006675;
        Tue, 8 Aug 2023 02:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=iggh4y4QTxuhyA0uRYET20kV1pGY6yQJMzn3eoXWECM=;
 b=qmTMHZHSYme6wVe7kEamVK62t8yDpOuCpynYWXrpU9MKG8WZOdqnWJyrzMz+yptjQqOX
 byrAf3IH0LlsahKu8fdBWcwjBVjK0ajmoso08EmW/nEqVtq+79q6ntATTKM1apoW6J2Q
 YV63UJS6+eEyNcue2VIr3PF491eSCclvN5bKdANgsSEqKpE6IwPXwmm/ZZmkN5/R9njP
 28cZZLJXVYH2u0yebJd0v99g+FgqXQeBiM1dxcCm0j8O43t6RC5PlmJBCBhTzRNXJ/QM
 +i5LOOpV/bTJpD4dxYkJHMV5WRehbN6r+Bs6Bo4K8aV25aPJ12Wfj+v+gvkxYlcO47DD 0Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9dbc45wn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 02:50:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3780Iret027338;
        Tue, 8 Aug 2023 02:50:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv561p5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 02:50:38 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3782oadk010815;
        Tue, 8 Aug 2023 02:50:38 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3s9cv561mp-6;
        Tue, 08 Aug 2023 02:50:38 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Hannes Reinecke <hare@suse.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wang Jinchao <wangjinchao@xfusion.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        stone.xulei@xfusion.com
Subject: Re: [PATCH] scsi: aic7xxx: fix firmware build fatal error
Date:   Mon,  7 Aug 2023 22:50:31 -0400
Message-Id: <169146270848.4040832.411550339569144039.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ZK0XIj6XzY5MCvtd@fedora>
References: <ZK0XIj6XzY5MCvtd@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_28,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=908 bulkscore=0
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080023
X-Proofpoint-ORIG-GUID: AlO43cIdIK1qjOeHbi9U2fT-8w1AABYA
X-Proofpoint-GUID: AlO43cIdIK1qjOeHbi9U2fT-8w1AABYA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2023 16:47:30 +0800, Wang Jinchao wrote:

> When building with CONFIG_AIC7XXX_BUILD_FIRMWARE=y, two fatal errors
> are reported as shown below:
> > aicasm_gram.tab.c:203:10: fatal error: aicasm_gram.tab.h:
> > No such file or directory
> > aicasm_macro_gram.tab.c:167:10: fatal error: aicasm_macro_gram.tab.h:
> > No such file or directory
> Fix these issues to make randconfig builds more reliable.
> 
> [...]

Applied to 6.6/scsi-queue, thanks!

[1/1] scsi: aic7xxx: fix firmware build fatal error
      https://git.kernel.org/mkp/scsi/c/ec6c7c9f5fc4

-- 
Martin K. Petersen	Oracle Linux Engineering
