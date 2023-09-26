Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB487AF31A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbjIZSla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 14:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbjIZSl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:41:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64DB11F;
        Tue, 26 Sep 2023 11:41:21 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QIcToP029667;
        Tue, 26 Sep 2023 18:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=sKtbeylSWVLyUui5BBAROIGKpDpCi31kNkcoiTxLpkQ=;
 b=UWzYF4aKvk1pUCcb3enJmISVnJqRXvsp4P+7d7NlY+K/dMJNKNmYc1BJyszmMdYEfnon
 anZCDQAXXd+ySzOwew3a7XP645CY43VM0N2h0ML1Ri93k/NpcVeuplGkYohN8b20s99q
 rUOTAB5xYaww90xkGA9thfXnUmP4/czuGK1os+/ok1NExr8+5S8LTTScC8a1nopomAZ3
 Cw71cJnkue8OUeacY9DJQyR51uZk1JzqYuBGEEo0jpOli6EeaMNysftcv0vEzJbxcj9F
 spQs6yQL2tM21ZQlI4+cxUqiZN5OkqPx8pwuGtBucwLrTYSJBG9jE6TWN7QfTxuOLu+6 yA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tbmwwtcmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 18:41:08 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38QIf755013574
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 18:41:07 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 26 Sep 2023 11:41:07 -0700
Date:   Tue, 26 Sep 2023 11:41:05 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Om Prakash Singh <quic_omprsing@quicinc.com>
CC:     <neil.armstrong@linaro.org>, <konrad.dybcio@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <conor+dt@kernel.org>,
        <davem@davemloft.net>, <devicetree@vger.kernel.org>,
        <herbert@gondor.apana.org.au>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <marijn.suijten@somainline.org>,
        <robh+dt@kernel.org>, <vkoul@kernel.org>
Subject: Re: [PATCH V4] crypto: qcom-rng - Add hw_random interface support
Message-ID: <20230926184105.GD437346@hu-bjorande-lv.qualcomm.com>
References: <20230926102005.3277045-1-quic_omprsing@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230926102005.3277045-1-quic_omprsing@quicinc.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lxWp1M1oY6HIRf5IaiW51npEmjeIBPGU
X-Proofpoint-ORIG-GUID: lxWp1M1oY6HIRf5IaiW51npEmjeIBPGU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_13,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=758 spamscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309260162
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 03:50:05PM +0530, Om Prakash Singh wrote:
> Add hw_random interface support in qcom-rng driver as new IP block
> in Qualcomm SoC has inbuilt NIST SP800 90B compliant entropic source
> to generate true random number.
> 
> Keeping current rng_alg interface as well for random number generation
> using Kernel Crypto API.
> 
> Signed-off-by: Om Prakash Singh <quic_omprsing@quicinc.com>

Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Regards,
Bjorn
