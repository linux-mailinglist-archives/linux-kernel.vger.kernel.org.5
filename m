Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D02F787CEC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 03:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239852AbjHYBOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 21:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbjHYBNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 21:13:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFCA19BB;
        Thu, 24 Aug 2023 18:13:47 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OJES7G018522;
        Fri, 25 Aug 2023 01:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=PeKpm5uGyPLoWpsbJU0wnUq8VkkkAegsoBMOFUvgTio=;
 b=PJTvItK/OCmBxtO2DEQq3knBizGrjlRUu2Evfv8mfbk2pxrPMQh+MnmDazrpd61nmPY7
 QBSarCsLN3AUw2RHviDsUytjM+6Q/lTahEtHf37lJn8iPAmWC1lFEu4fqcyslbW7edoL
 4pNOwq2ZWk7qgZJhZlWkQ5CJskCDTTAfZ8caYdNGuRVEWg4dMZiLN4Kr1+Cci5s+tc4j
 sNU1FJfOS/NDhca1FEo+Ng2cKSrNBPYQptB+jpnVrJwG40wTq+klvw1XY80Nedb7pKGy
 3nZ5qxFN4vKGS+9rId64IDH6Y8g079UJlP/JMJpnIPSQTqy8ylZQM41KSs/nCcD22tVX zA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn20cncv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 01:13:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37OMuKkm036170;
        Fri, 25 Aug 2023 01:13:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1ywqfkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 01:13:39 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37P1DVE8019787;
        Fri, 25 Aug 2023 01:13:38 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3sn1ywqf8n-8;
        Fri, 25 Aug 2023 01:13:38 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] scsi: bfa: Replace one-element array with flexible-array member in struct fc_rscn_pl_s
Date:   Thu, 24 Aug 2023 21:12:54 -0400
Message-Id: <169292577165.789945.3215059945658236967.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ZN0VTpDBOSVHGayb@work>
References: <ZN0VTpDBOSVHGayb@work>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_01,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=569 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250009
X-Proofpoint-ORIG-GUID: Agt8W35HpKYI4yQ6fQ5yaTeZYuZMWwfR
X-Proofpoint-GUID: Agt8W35HpKYI4yQ6fQ5yaTeZYuZMWwfR
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2023 12:28:30 -0600, Gustavo A. R. Silva wrote:

> One-element and zero-length arrays are deprecated. So, replace
> one-element array in struct fc_rscn_pl_s with flexible-array member.
> 
> This results in no differences in binary output.
> 
> 

Applied to 6.6/scsi-queue, thanks!

[1/1] scsi: bfa: Replace one-element array with flexible-array member in struct fc_rscn_pl_s
      https://git.kernel.org/mkp/scsi/c/56a4d69a26c9

-- 
Martin K. Petersen	Oracle Linux Engineering
