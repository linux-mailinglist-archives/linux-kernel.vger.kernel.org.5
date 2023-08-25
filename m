Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094E7787CF9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 03:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240304AbjHYBOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 21:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237616AbjHYBNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 21:13:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4791F1BFE;
        Thu, 24 Aug 2023 18:13:49 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OJEKpx016614;
        Fri, 25 Aug 2023 01:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=IRM7clTLJsFv7y8+IXvQPcdHCoU8AJwOLyxoShZ6Z7Q=;
 b=2nvWZmJzWLP4ad6agOlfDpmembyGqDsNBfdMJ8rmifIf8Nzp56/VQG41L2zHuxpfHqeD
 7Q3uxkSE94VO6mSYU8uLg2uweTqblG9jkmD7CXrYYdhD6Ay7Pc46GrS1VngqSBlURf4X
 4TESlvWlMqTaYj0saW2CquDc4LClBasTAxV5Z2gAPous6nTGX9KhxLe3WUMAPU+ZP9TP
 5R0GitDq1zAPZ3DGdKVeg/ZnOBljLrZUbpy4iAjbZJYmWVlCH9zDogofCFLJ3guuf2Uf
 IK/7CuTeRxL7hgwPE3idFOAulq3QJXHr39nGpOva9B3llkZs8omBX0nQ7p5Vzr5L6o8Y Hg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yvwfua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 01:13:39 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37OMuKkl036170;
        Fri, 25 Aug 2023 01:13:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1ywqfjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 01:13:38 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37P1DVE4019787;
        Fri, 25 Aug 2023 01:13:38 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3sn1ywqf8n-6;
        Fri, 25 Aug 2023 01:13:37 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     james.smart@broadcom.com, ram.vegesna@broadcom.com,
        jejb@linux.ibm.com, rdunlap@infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, coolrrsh@gmail.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v3] scsi: sli4: Remove code duplication
Date:   Thu, 24 Aug 2023 21:12:52 -0400
Message-Id: <169292577168.789945.14600068133090244401.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230817114301.17601-1-coolrrsh@gmail.com>
References: <20230817114301.17601-1-coolrrsh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_01,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=636 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250009
X-Proofpoint-GUID: 0QsdpT99nTfZs8tZTKnjNxT1geXAbs2_
X-Proofpoint-ORIG-GUID: 0QsdpT99nTfZs8tZTKnjNxT1geXAbs2_
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 17:13:01 +0530, coolrrsh@gmail.com wrote:

> In the function sli_xmit_bls_rsp64_wqe, the 'if' and 'else' conditions
> evaluates the same expression and gives same output. Also, params->s_id
> shall not be equal to U32_MAX. Therefore removing the unused code.
> 
> This fixes coccinelle warning such as:
> drivers/scsi/elx/libefc_sli/sli4.c:2320:2-4: WARNING: possible
> condition with no effect (if == else)
> 
> [...]

Applied to 6.6/scsi-queue, thanks!

[1/1] scsi: sli4: Remove code duplication
      https://git.kernel.org/mkp/scsi/c/2d6f70fe175e

-- 
Martin K. Petersen	Oracle Linux Engineering
