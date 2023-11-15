Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EE87EC6E1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344434AbjKOPNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344398AbjKOPNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:13:22 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C951AC;
        Wed, 15 Nov 2023 07:13:19 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFE3sxO010429;
        Wed, 15 Nov 2023 15:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=zz1/EnkZMGU0MZPcY0N+OqSuX6AglSIBEu4LF6hLjic=;
 b=i108W8AclFN7oU+lGGp3duaIM00UfQCawVu9jbR7A2RbOUOrNau6YnMMkHEz4tVqXImL
 I980zVzEgvcNAIqe4qn6J4ZXIUeklewj3Bs9TZ99F/2yzeMe4NI8nT30gCGBvrVNJhyo
 FmowMguAUkvVzKTe9luaL23egxR3DsCb4UCSwmtQfU/Eux3QvjUlaKdG4F5JKBr/1fam
 nDnDmt7Qqw8CYQi6M248Owqsun5sifGFluQWl0y1MbmHQXCOhBMK74YGoLMfeakpN+5A
 WEk+i8O6k3KDLYl3XngxAUR7jWTak+rZoZRM1oAKrhTO/bM4DBE7Jfy+mNRQjN65oODB eA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2na0t4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 15:13:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFF8GN8004088;
        Wed, 15 Nov 2023 15:13:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxj40882-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 15:13:10 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AFFD8SR011253;
        Wed, 15 Nov 2023 15:13:09 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uaxj4085x-3;
        Wed, 15 Nov 2023 15:13:09 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: ufs: qcom-ufs: document the SM8650 UFS Controller
Date:   Wed, 15 Nov 2023 10:13:01 -0500
Message-Id: <170006111400.506874.7193155029123585368.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231030-topic-sm8650-upstream-bindings-ufs-v3-1-a96364463fd5@linaro.org>
References: <20231030-topic-sm8650-upstream-bindings-ufs-v3-1-a96364463fd5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_13,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=796 mlxscore=0 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150115
X-Proofpoint-GUID: nzLqVCgQHp2OGrlM-1-5q9_Iz6p9JysS
X-Proofpoint-ORIG-GUID: nzLqVCgQHp2OGrlM-1-5q9_Iz6p9JysS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 10:43:11 +0100, Neil Armstrong wrote:

> Document the UFS Controller on the SM8650 Platform.
> 
> 

Applied to 6.7/scsi-fixes, thanks!

[1/1] dt-bindings: ufs: qcom-ufs: document the SM8650 UFS Controller
      https://git.kernel.org/mkp/scsi/c/e439e4a62a8e

-- 
Martin K. Petersen	Oracle Linux Engineering
