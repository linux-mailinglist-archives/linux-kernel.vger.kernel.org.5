Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6B47AA65A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 03:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjIVBG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 21:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjIVBGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 21:06:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48898F5;
        Thu, 21 Sep 2023 18:06:19 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LIsMBb011444;
        Fri, 22 Sep 2023 01:06:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=4sks/tXUf4xnsCRkMVuUcEHqv0ac9dFEzdYVSS3K4j4=;
 b=nbBk3USv2ADqkP1SFu0ySv/4aWSTK3NHGHAlYHRAd5wo4JcnFciUoFuiIrUcjWKDceOz
 aJe4Ts8yxjBwbqCatq4vSP3rHJjtzWUXAlKExRXs1WjCOHCdwBxQBq/7DCRIVRgDOTQQ
 XuswiCaJ0LmHTRGohP5xHChZvOrZRbsZcPg6IPgnDHxtZ//6/ALcj73+dSYzkUzoj2w9
 oanfV794xKJ8SUqQAwNEZE+oyEKzRezXfDKkAYbwnQHHCOGBywhcij4Us8LfczO7pBZ9
 3pIlzh3VrFpT2e///04fGjwzEcR1e8P40fe0pJjII6DurJEEe3FoA7SZarLwOC8sDnSw AA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tsvrkag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 01:06:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38LMeF9L040575;
        Fri, 22 Sep 2023 01:06:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t8u19bn4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 01:06:10 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38M164sx032168;
        Fri, 22 Sep 2023 01:06:09 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3t8u19bn0m-5;
        Fri, 22 Sep 2023 01:06:09 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Stanley Chu <stanley.chu@mediatek.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-scsi@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: ufs: do not look for unsupported vdd-hba-max-microamp
Date:   Thu, 21 Sep 2023 21:05:55 -0400
Message-Id: <169534443606.456601.439761904656869208.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230906113302.201888-1-krzysztof.kozlowski@linaro.org>
References: <20230906113302.201888-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_01,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=957 phishscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309220008
X-Proofpoint-GUID: HNAUVlPRhNXLEOv6kAT5tu68crePIR1j
X-Proofpoint-ORIG-GUID: HNAUVlPRhNXLEOv6kAT5tu68crePIR1j
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Sep 2023 13:33:02 +0200, Krzysztof Kozlowski wrote:

> Bindings do not allow vdd-hba-max-microamp property and the driver does
> not use it (does not control load of vdd-hba supply).  Skip looking for
> this property to avoid misleading dmesg messages:
> 
>   ufshcd-qcom 1d84000.ufs: ufshcd_populate_vreg: unable to find vdd-hba-max-microamp
> 
> 
> [...]

Applied to 6.7/scsi-queue, thanks!

[1/1] scsi: ufs: do not look for unsupported vdd-hba-max-microamp
      https://git.kernel.org/mkp/scsi/c/2c99e3d7d2cb

-- 
Martin K. Petersen	Oracle Linux Engineering
