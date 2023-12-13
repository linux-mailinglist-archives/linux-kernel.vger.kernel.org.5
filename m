Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8E3811A78
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379114AbjLMRHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378891AbjLMRHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:07:22 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE54D0;
        Wed, 13 Dec 2023 09:07:26 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BDGd2JP030010;
        Wed, 13 Dec 2023 17:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:subject:date:message-id:mime-version:content-type
        :content-transfer-encoding:to:cc; s=qcppdkim1; bh=kN410wwRUNkyfP
        B7ahiFKEuZhRz6mV89Ym+9lK+dfNQ=; b=U2BFaeSVEh4jQX0pbjz/c1bRKiSRNR
        cKg83IDMph3fuNpeMFtBzfsFkTiyymvHnb2icXcM3NRTWpzlvzFQwC7sgSgu1Ly+
        IlXwOkYcbt9z5mxAHUwdnQSNr6lVPOblEUEyv49zq+J7mg77O1q7k0W3oocGmr7F
        U/e9S+7cE0J8bRv/7fFho/CyVzWJZ2yDH2/BZ9nVNx5me2WGwBv6M0Wy5Jjp2Z7E
        sKK5RKfJOx8hAWspFtP/q/lVYYi1613ArYmwlwagycg9GKIO7z47ezRKDzDGEPcr
        u4GCmcHhuskGb0kF0JHpUsGJjCAVixXLSHHA87qQp+ShVUwoA09ca65g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uy5tvhpv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 17:06:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BDH6eVM031494
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 17:06:40 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Dec
 2023 09:06:40 -0800
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH 0/6] wifi: ath10k: use flexible arrays
Date:   Wed, 13 Dec 2023 09:06:38 -0800
Message-ID: <20231213-wmi_host_mem_chunks_flexarray-v1-0-92922d92fa2c@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ/keWUC/5XNyw6CMBCF4VchXVvjDDd15XsYQ2qZ2okC2kKFE
 N5dYOdOl/9ZfGcUnhyTF8doFI4Ce27qOWATCW1VfSPJ5dwCdxgDAsp3xYVtfFtUVBXadvXdF+Z
 BvXJODTLfY5YQJFkeg5iNpyPD/eqfL3Nb9m3jhvUuwLL+KgeQIFON6aFUKWUGTq+ONdd6q5tKL
 HbAvzyUO2nwmua6NACgvr1pmj4ibXffHAEAAA==
To:     Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
CC:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.12.3
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lRec6QprZZ2S4zgOuvxWwXKHU4hYWDQ3
X-Proofpoint-GUID: lRec6QprZZ2S4zgOuvxWwXKHU4hYWDQ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=600 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312130122
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the last remaining zero-length and one-element arrays in
ath10k to comply with:
https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays

With these cleanups done the ath10k-check script no longer reports any
issues.

---
Jeff Johnson (6):
      wifi: ath10k: use flexible array in struct wmi_host_mem_chunks
      wifi: ath10k: use flexible arrays for WMI start scan TLVs
      wifi: ath10k: remove struct wmi_pdev_chanlist_update_event
      wifi: ath10k: remove unused template structs
      wifi: ath10k: use flexible array in struct wmi_tdls_peer_capabilities
      wifi: ath10k: remove duplicate memset() in 10.4 TDLS peer update

 drivers/net/wireless/ath/ath10k/wmi.c | 10 +++----
 drivers/net/wireless/ath/ath10k/wmi.h | 55 +++++++++--------------------------
 2 files changed, 17 insertions(+), 48 deletions(-)
---
base-commit: 7133b072dfbfac8763ffb017642c9c894894c50d
change-id: 20231212-wmi_host_mem_chunks_flexarray-78264e146731

