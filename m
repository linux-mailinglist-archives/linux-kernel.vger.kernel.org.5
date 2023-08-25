Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D81787CD9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 03:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238596AbjHYBN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 21:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbjHYBNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 21:13:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7211BF1;
        Thu, 24 Aug 2023 18:13:39 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OJEULO007524;
        Fri, 25 Aug 2023 01:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=e9oBuJKJYsA14/1oNolLGHa4wQyE6N9PL2WD/pYUX+0=;
 b=PS0YX0oP177gsm5vwY/CHSVAqu8ik7jZI/uTpIFy39iuMaXy4XJQX9N9lL+9LR6APjBR
 OA0fB/e+wIVAyCkKYKkp5EUCPLQPTBwdIH3YAsuCO4mnZPeTj5A5bkURDakULF5YBezn
 8K38mBsHQN4uD9WlwKVVSuDxJ2MSMPYuEqAp+cw5oyhsZjhmBSkrlqm+DBZpv2Fts9Iv
 4KpDg30vW5jzBj9GqWTNbzmTibXgtU0EJ54STY4Y8plO95E06C5YF4ZimjWeJ60MdlFK
 vZesM2JAsEQOW3eNI+/lc9Wp+GDCmnlXw0qNVNVDvwGm2UZSbH54safo1Wo6W1lJPRBy 0A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yvwcnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 01:13:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37P0Fgpp036118;
        Fri, 25 Aug 2023 01:13:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1ywqfge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 01:13:34 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37P1DVDt019787;
        Fri, 25 Aug 2023 01:13:33 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3sn1ywqf8n-2;
        Fri, 25 Aug 2023 01:13:33 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Justin Tee <justin.tee@broadcom.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] scsi: lpfc: Do not abuse UUID APIs and LPFC_COMPRESS_VMID_SIZE
Date:   Thu, 24 Aug 2023 21:12:48 -0400
Message-Id: <169292577174.789945.17081087399833466832.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230818155452.875781-1-andriy.shevchenko@linux.intel.com>
References: <20230818155452.875781-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_01,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=624 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250009
X-Proofpoint-ORIG-GUID: Qg-qBPxYhSRN5k-HZsS-wzBuIqkToLe6
X-Proofpoint-GUID: Qg-qBPxYhSRN5k-HZsS-wzBuIqkToLe6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023 18:54:52 +0300, Andy Shevchenko wrote:

> The lpfc_vmid_host_uuid is not defined as uuid_t and its usage is not
> the same as for uuid_t operations (like exporting or importing).
> Hence replace call to uuid_is_null() by respective memchr_inv() without
> abusing casting.
> 
> With that, replace LPFC_COMPRESS_VMID_SIZE with plain number and
> respective sizeof() to make code robust to changes in the future,
> if any.
> 
> [...]

Applied to 6.6/scsi-queue, thanks!

[1/1] scsi: lpfc: Do not abuse UUID APIs and LPFC_COMPRESS_VMID_SIZE
      https://git.kernel.org/mkp/scsi/c/19d7102a9539

-- 
Martin K. Petersen	Oracle Linux Engineering
