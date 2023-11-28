Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2380A7FB4B7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344225AbjK1Iq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbjK1Iqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:46:52 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B81137;
        Tue, 28 Nov 2023 00:46:57 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AS7Hmi3032528;
        Tue, 28 Nov 2023 08:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=qcppdkim1; bh=Hk6V4uM03krytOobIZzfr+PiKdIw2psb21TNotImem0=;
 b=Y7eGOPUe55MPYaJpGL0HRsJLj4OfLQQ7PYJydJPIbhF8MpN4/unsAx49uGqDe4m6mTsb
 1mQjhnpKaVe3swIUxiR/5RgFT7hT2Ud4GfWOK7irTTjUh70mCPKjnj2nFb6T9k7hkYBy
 7+22CyKJWAx7sKeZImbIGD6BdHYLnbKVFdvvXi1pK3N9Oatx9u0svO/To7+456FNXn0M
 vu0k7rQe41ixg8NupFzlxFRmDpikjzFlPTQ0ckMmNjm/K1q/fWqw4BUTBPJtnuk+5aUv
 mHV7kKbW9jsyWn2fShZJkOM8LItbwQwYxh6kZLZFVuGLNo07DYd9dQKTvWhL50mtLi7l aw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3umt632tb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 08:46:52 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3AS8hNZA007208;
        Tue, 28 Nov 2023 08:46:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3uka0kw92n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 08:46:49 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AS8kd8k010074;
        Tue, 28 Nov 2023 08:46:49 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-varada-blr.qualcomm.com [10.190.111.7])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3AS8knYF010172
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 08:46:49 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 85203)
        id 48049416F2; Tue, 28 Nov 2023 14:16:48 +0530 (+0530)
From:   Varadarajan Narayanan <varada@hu-varada-blr.qualcomm.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        dmitry.baryshkov@linaro.org, quic_varada@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Varadarajan Narayanan <varada@hu-varada-blr.qualcomm.com>
Subject: [PATCH v1 0/2] ipq9574: Fix USB 'vdda-pll-supply'
Date:   Tue, 28 Nov 2023 14:16:44 +0530
Message-Id: <cover.1701160842.git.varada@hu-varada-blr.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5d9UDsz8OwdCL7AAddfa06WWIIraItwo
X-Proofpoint-ORIG-GUID: 5d9UDsz8OwdCL7AAddfa06WWIIraItwo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_07,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=2 priorityscore=1501 mlxscore=2
 mlxlogscore=162 bulkscore=0 suspectscore=0 spamscore=2 lowpriorityscore=0
 malwarescore=0 phishscore=0 clxscore=1034 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311280068
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The earlier patch ec4f047679d5, incorrectly used 'l2'
as the vdda-pll-supply. However, 'l5' is the correct
ldo that supplies power to the USB PHY.

Following checks passed:
make W=1 ARCH=arm64 -j 16 CHECK_DTBS=y DT_SCHEMA_FILES=qcom dtbs_check
make W=1 ARCH=arm64 -j 16 DT_CHECKER_FLAGS='-v -m' dt_binding_check DT_SCHEMA_FILES=qcom

Varadarajan Narayanan (2):
  regulator: qcom_smd: Add LDO5 MP5496 regulator
  arm64: dts: qcom: ipq9574: Fix USB 'vdda-pll-supply'

 arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi | 11 +++++++++--
 drivers/regulator/qcom_smd-regulator.c           |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.34.1

