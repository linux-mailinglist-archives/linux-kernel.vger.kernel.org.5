Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C013C7DB7F3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjJ3KYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbjJ3KX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:23:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2C81FDE
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:21:31 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39U5vlWu028708;
        Mon, 30 Oct 2023 10:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=/T7XK8R2tUKGhfUL0bCCk/UjBDY3rfhSerP3+OWcDMY=;
 b=nK1mv6dEGxf/wAbeVUJwlY4X4jPRMgtpkp1GSPrgv8k1VgwR4ARCtj8InJUTC1qdzBOs
 KKwbzODRIcZLyvKNONSIL7Yf9J3uQDP+Uap/R1e94YJB4z5WeeF7ORwm7hjsykdZkCT/
 +p0ZWELunKl9F7MkZ43ZojJ+rL2gPZ/JzWQ47GfRPvqBwTwaJg11zeMvCgmcehf61jkE
 /i9X29pyW4pFnOs9dvbNh33n4vRRLwaY6r40srxc847VODyRJfrJUhitJ2KhEjmUvBX2
 ShGYupFBAH0Vg1ckrx4+E+XzXNLSqsUtSGCFckmwa0x/Ij/96hEYyNx0QoV1HGe6vypT cg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u0thbbg2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 10:21:28 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39UALR0c031640
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 10:21:27 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 30 Oct 2023 03:21:26 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH] fs/sysfs/dir.c : Fix typo in comment
Date:   Mon, 30 Oct 2023 15:51:14 +0530
Message-ID: <1698661274-32540-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DxLL77bzIxvIx5xz7aZvn88XqpQdSm1H
X-Proofpoint-GUID: DxLL77bzIxvIx5xz7aZvn88XqpQdSm1H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_08,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=657
 spamscore=0 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Typo correction
kboject => kobject

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 fs/sysfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
index b6b6796e1616..4df2afa551dc 100644
--- a/fs/sysfs/dir.c
+++ b/fs/sysfs/dir.c
@@ -81,7 +81,7 @@ void sysfs_remove_dir(struct kobject *kobj)
 	struct kernfs_node *kn = kobj->sd;
 
 	/*
-	 * In general, kboject owner is responsible for ensuring removal
+	 * In general, kobject owner is responsible for ensuring removal
 	 * doesn't race with other operations and sysfs doesn't provide any
 	 * protection; however, when @kobj is used as a symlink target, the
 	 * symlinking entity usually doesn't own @kobj and thus has no
-- 
2.7.4

