Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF1E7BF0A9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 04:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441842AbjJJCKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 22:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379326AbjJJCKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 22:10:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7CCA7;
        Mon,  9 Oct 2023 19:10:01 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399NwuB9016274;
        Tue, 10 Oct 2023 02:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=tLdCG6jN7hKzemz3BqeIqgk+1LWVl64DMX/5vSOGzuU=;
 b=1VSbNAdYfjhd59uutV3S/ras1X34agVW3cGcUSEjg8U/657+vAVblWInhj8XJ+38mqyC
 V9/p9cPxOA1udFDuIl+4+SOU6s9pVo3W7OVhxPHPBYarR8k4CFSCSVH8gztAyMRVGLeJ
 pNVldwuKDfs88Pp89q5DnbtvqWgwd1lNs8q/xADnNt3vsU5MT2MEPPKz9/r8z+ow0VmZ
 Nf7gtXF7piozNM2A2vQ3D4R7IdbJusKtbS3TuIosLpyQ85S5q/65922YxTnaCClXK1oF
 ZRTRZB2AMyBs/rYAXIncrPjio/EKHj/0SUeRVqC7LzEWxtwiONulWYooRnNlk//lquBR Cg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tmh89sdk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 02:09:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39A1JBsp014884;
        Tue, 10 Oct 2023 02:09:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws63mcb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 02:09:43 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39A29dUM036611;
        Tue, 10 Oct 2023 02:09:42 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3tjws63m9y-3;
        Tue, 10 Oct 2023 02:09:42 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Bodo Stroesser <bostroesser@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: target: tcmu: Annotate struct tcmu_tmr with __counted_by
Date:   Mon,  9 Oct 2023 22:09:34 -0400
Message-Id: <169690017527.1410956.11295274010331353504.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230922175300.work.148-kees@kernel.org>
References: <20230922175300.work.148-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_01,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=682 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310100013
X-Proofpoint-GUID: bkFeGgmIwkMBadGMwEnQVSLRIbis1HxP
X-Proofpoint-ORIG-GUID: bkFeGgmIwkMBadGMwEnQVSLRIbis1HxP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023 10:53:01 -0700, Kees Cook wrote:

> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct tcmu_tmr.
> 
> [...]

Applied to 6.7/scsi-queue, thanks!

[1/1] scsi: target: tcmu: Annotate struct tcmu_tmr with __counted_by
      https://git.kernel.org/mkp/scsi/c/caf22c969ed1

-- 
Martin K. Petersen	Oracle Linux Engineering
