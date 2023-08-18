Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D92781025
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378553AbjHRQSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378614AbjHRQSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:18:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCB43C0F;
        Fri, 18 Aug 2023 09:17:56 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IEF1nY027431;
        Fri, 18 Aug 2023 16:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=j9c1MjBvndUUD0TxkCug1qPVfaYbpXY3IoHMvL5w/sY=;
 b=WuGYNq+ygsXOuG1Qv4TY2Gp4lNEQPb261Jl9+b0fUcJDaoOBmfzjWxps2wmBW6b5ZnzP
 V+DFgNcZgVnkdajVGVFox7JINsq8qwQ4Srf7QcfmqJ1cDn4yVMc25A9lYEe/wz90OlTG
 egiWcRFtRjQytAVpiUFBYYwEicRltfi5wIa1eZouL3ugizqt6kilKUiMC6U6cruWyxyh
 Mu4Vt/oMjDyK/W/Yw6TA2pMWNg6jUNBYooU/Pu/2IhwmKJKW8bQqd0ZhtrsB0zwjUcL1
 VVSbUsrsgWqgZ3ENxet0FSsrN6rRv78WSzFO/2aO4p7JYp7gMXqFxmb3DT/7ujZi4Fxo WA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3she6puu9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 16:17:41 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37IGHeg8023145
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 16:17:40 GMT
Received: from hu-omprsing-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 18 Aug 2023 09:17:36 -0700
From:   Om Prakash Singh <quic_omprsing@quicinc.com>
To:     <konrad.dybcio@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>, <conor+dt@kernel.org>,
        <davem@davemloft.net>, <devicetree@vger.kernel.org>,
        <herbert@gondor.apana.org.au>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <marijn.suijten@somainline.org>,
        <robh+dt@kernel.org>, <vkoul@kernel.org>
Subject: [PATCH 1/3] dt-bindings: crypto: qcom,prng: Add SM8450
Date:   Fri, 18 Aug 2023 21:47:20 +0530
Message-ID: <20230818161720.3644424-1-quic_omprsing@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811-topic-8450_prng-v1-1-01becceeb1ee@linaro.org>
References: <20230811-topic-8450_prng-v1-1-01becceeb1ee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: P6NqFDmgGxE9u9dndGXxY_OvX-K5PqC0
X-Proofpoint-ORIG-GUID: P6NqFDmgGxE9u9dndGXxY_OvX-K5PqC0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_20,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1011 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=587 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having SoC name "qcom,sm8450-prng-ee" we could use "qcom,rng-ee" as
new IP core is not longer pseudo random number generator. so "prng" can be
changed to "rng". Clock configuration is not needed on sm8550 as well. So it is
better to use generic compatible string.
