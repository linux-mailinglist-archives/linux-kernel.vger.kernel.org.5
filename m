Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279717D6ACC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjJYMF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjJYMF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:05:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36AA129;
        Wed, 25 Oct 2023 05:05:23 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39P7liaJ020652;
        Wed, 25 Oct 2023 12:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=4x3LlBXAqUOSeSVXdSN2ThZrQ0ckhuH6bbWl/fj8Zxg=;
 b=epyxYHlFMUD4UyZLk8SFkJmOZkxdgAcJ7IZ5WGoLoNFEVOo3oFUXdDDWvAbjdmfNx5sy
 wVN+Fd5EbSg5hyMdCIWTWOWaOWezqfwBofYniDvfVSKM8eLrC+Iw70CM3AC6NjWbfZbC
 XccRQj40NoyC56cFDzDY7TAdmnNGbOocjJTdRFtYPqfZAdFoG2F+vp6prEjzH1e1b9gd
 AUvtebiC/tNvIn910DbGYd82xR4TYh0RIK9vrPjq7cFsiOApOQ7jShyyPo03F/y+MqLV
 lZkxm43bHOIyOek4NYLKXxrhYoCyv1gfIcTrLkWBLRrD5YaDxjIo/A7v2b2eP95iJjIL Rw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3txmhx9jyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 12:05:19 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39PC5J3B027600
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 12:05:19 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 25 Oct 2023 05:05:16 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linus.walleij@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v8 0/3] Misc SCM changes
Date:   Wed, 25 Oct 2023 17:35:03 +0530
Message-ID: <1698235506-16993-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MgWeqp9D4eIEJuObsCf9WSAcAdRqjNFM
X-Proofpoint-GUID: MgWeqp9D4eIEJuObsCf9WSAcAdRqjNFM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250104
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These changes are needed to enable download mode on chipset
like IPQ9574 and IPQ5332 SoCs or also will help enabling crash
dump on multiple Qualcomm Soc with proper handling of download
mode bits.

First two changes(1/3-2/3) are SCM driver specific while 3/3 from
pinctrl try to use the introduced API(1/3) via removing the existing
logic.

Changes from v7: https://lore.kernel.org/lkml/1696440338-12561-1-git-send-email-quic_mojha@quicinc.com/
 - Rebased it on next-20231025.
 - Added reviewed-by tag and take care of comment made about
   commit text should be in imperative mode.
 - Modified the name of the API to qcom_scm_io_rmw() as per suggestion
   made by [Dmitry]
 - Moved spinlock inside qcom_scm structure.
 - Corrected the patch order as per subsystem SCM first then pinctrl.

Change from minidump-v5(13/17-15/17):https://lore.kernel.org/lkml/1694429639-21484-1-git-send-email-quic_mojha@quicinc.com/
 - Removed mistakenly added macros.
   https://lore.kernel.org/lkml/9da888dc-401a-4cbb-b616-b4654fa79e35@quicinc.com/
 - Added Acked-by tag from Linus.w to 2/3.

Changes from dload series v6: https://lore.kernel.org/lkml/1680076012-10785-1-git-send-email-quic_mojha@quicinc.com/
 - Rebased it on latest tag available on linux-next
 - Added missed Poovendhan sign-off on 15/17 and tested-by tag from
   Kathiravan. Thanks to him for testing and reminding me of missing sign-off.
 - Addressed comments made on dload mode patch v6 version

Changes in v6:
  - Applied suggested API change(at v4) by [dmitry.baryshkov] 

Changes in v5: https://lore.kernel.org/lkml/1680017869-22421-1-git-send-email-quic_mojha@quicinc.com/
  - Tried to fix the issue reported by kernel test robot
    https://lore.kernel.org/lkml/202303280535.acb66sQT-lkp@intel.com/

  - Applied some of the improvement suggested by [Bjorn.andersson]
 
    . Dropped 'both' instead support full,mini or mini,full for setting download
    mode to collect both minidump and full dump.
    
    . logging improvement.
    

Changes in v4: https://lore.kernel.org/lkml/1679935281-18445-1-git-send-email-quic_mojha@quicinc.com/
  - val should be shifted within the function [srinivas.kandagatla]
    i.e new = (old & ~mask) | (val << ffs(mask) - 1);
  - Added Acked-by [linus.walleij] on pinctrl change.

Changes in v3 : https://lore.kernel.org/lkml/1679070482-8391-1-git-send-email-quic_mojha@quicinc.com/
 - Removed [1] from the series and sent as a separate patch[2], although this series
   should be applied on top [2].
  [1] https://lore.kernel.org/lkml/1677664555-30191-2-git-send-email-quic_mojha@quicinc.com/
  [2] https://lore.kernel.org/lkml/1678979666-551-1-git-send-email-quic_mojha@quicinc.com/
 - Introduce new exported symbol on suggestion from [srinivas.kandagatla]
 - Use the symbol from drivers/pinctrl/qcom/pinctrl-msm.c.
 - Addressed comment given by [dmitry.baryshkov]
 - Converted non-standard Originally-by to Signed-off-by.

Changes in v2: https://lore.kernel.org/lkml/1677664555-30191-1-git-send-email-quic_mojha@quicinc.com/
 - Addressed comment made by [bjorn]
 - Added download mask.
 - Passed download mode as parameter
 - Accept human accepatable download mode string.
 - enable = !!dload_mode
 - Shifted module param callback to somewhere down in
   the file so that it no longer need to know the
   prototype of qcom_scm_set_download_mode()
 - updated commit text.


Mukesh Ojha (3):
  firmware: qcom_scm: provide a read-modify-write function
  firmware: scm: Modify only the download bits in TCSR register
  pinctrl: qcom: Use qcom_scm_io_rmw() function

 drivers/firmware/qcom/qcom_scm.c       | 38 ++++++++++++++++++++++++++++++++--
 drivers/pinctrl/qcom/pinctrl-msm.c     | 10 ++++-----
 include/linux/firmware/qcom/qcom_scm.h |  1 +
 3 files changed, 41 insertions(+), 8 deletions(-)

-- 
2.7.4

