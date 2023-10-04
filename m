Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954007B866D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243437AbjJDR0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbjJDR0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:26:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5159E;
        Wed,  4 Oct 2023 10:26:05 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394F9JOl026502;
        Wed, 4 Oct 2023 17:25:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=d62c819H4RldyhqeJMN2hxOs+nsXLp9YLOXPSwLXCQo=;
 b=iUy+qVit2KtztOn5npc1dryKQ/t2oqARFBlulD+NS7GFr+fRU373q5DzAU2npjjDMQra
 +Ka72ye2q7xXdBwokTai1bWOFGBR6cGdt2tIg1VG2g5R3QQ+xZrPbixznk2rxtY0dkHe
 /yCvCvle2wz+QH/eqHkw4PDpxJa1DLdN3UHVSs/DHW7bz93abUMUu4azVz6YT8+P5CvJ
 TPEZK+vsPXaJTYPKZL+LA/60m2AsEmTeGxhw82VWi4/DvwMbpKp7lKOiYWQ5hLd2na2A
 23+wwPvMWnSpJbqrKnLq1z6M4XJFVGR3A808IHqbl1u4/v8ioxZjLsjcOsUreyHM6/4B YQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tgxrjt33t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 17:25:51 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 394HPpBJ014758
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Oct 2023 17:25:51 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 4 Oct 2023 10:25:48 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <p.zabel@pengutronix.de>,
        <linus.walleij@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH 0/3 v7] Misc SCM changes
Date:   Wed, 4 Oct 2023 22:55:35 +0530
Message-ID: <1696440338-12561-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 12LszjTrRyYw_FdC_Y-vdqfX7tNgqkYv
X-Proofpoint-ORIG-GUID: 12LszjTrRyYw_FdC_Y-vdqfX7tNgqkYv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_09,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 clxscore=1011 suspectscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310040125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have given version to this series as v7 as it has already
gone through v6 and later got added to minidump patch series
However, these 3 patches can go independently and has no
relation with minidump hence, separated it from minidump series.

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
  pinctrl: qcom: Use qcom_scm_io_update_field()
  firmware: scm: Modify only the download bits in TCSR register

 drivers/firmware/qcom_scm.c            | 32 ++++++++++++++++++++++++++++++--
 drivers/pinctrl/qcom/pinctrl-msm.c     | 10 ++++------
 include/linux/firmware/qcom/qcom_scm.h |  2 ++
 3 files changed, 36 insertions(+), 8 deletions(-)

-- 
2.7.4

