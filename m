Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAF57723C4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbjHGMW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbjHGMW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:22:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAF910D8;
        Mon,  7 Aug 2023 05:21:59 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 377ASHWF001047;
        Mon, 7 Aug 2023 12:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Ry5qplbTH9tYJQFOvIzc1Nc2bpleiUZClxm4KuS3my0=;
 b=pHKfzzGcV6WcEEnkVkO0fHjuUA6yFPm4wK+0fbJLPfl6/hcpk1CsvdzqXZNy6bwNUBJ2
 Bf3XgL02ZO6jTTeQ6YgAlBkYV/ymLfP40t6uSNR/CxaR3qdW2j1selEr/b6WOP9O82dI
 z9uE/gbzbJ6lwdPpUtbq1ML3X1d/S3rsgqvHC1lwc8CEoNB8BhKMnp0pftftGhT1/ik0
 Lp9yLKKvZNUKjObvKf2PQ8L5xp9pw7uIpMpgFmQ8botCLnK25Yvj7a+LI481y/ueEEtn
 eHeMEh/dTOTMyplwNSL4M1e5rODLdNgPV2hIuaGrk25tyu6scVg3gfh9pAzcMHX7S5Ma 2w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sawbg8h3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 12:21:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 377CLo2T029174
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Aug 2023 12:21:50 GMT
Received: from [10.214.66.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 7 Aug
 2023 05:21:46 -0700
Message-ID: <f29eae07-b6c4-e7ea-3790-ee800d83859e@quicinc.com>
Date:   Mon, 7 Aug 2023 17:51:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 0/9] Add pmics supported in Qualcomm's SDX75 platform
Content-Language: en-US
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <abel.vesa@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <quic_pkondeti@quicinc.com>
References: <1691410698-25180-1-git-send-email-quic_rohiagar@quicinc.com>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <1691410698-25180-1-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eTT2n1XpJULgfHAuurqzdn9PEUXeNTKY
X-Proofpoint-GUID: eTT2n1XpJULgfHAuurqzdn9PEUXeNTKY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_11,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=929
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308070112
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/7/2023 5:48 PM, Rohit Agarwal wrote:
> Hi,
>
> Changes in v2:
>   - Added compatible for pm7550ba for eusb2 repeater and used it in DT.
>   - Addressed some minor comments from Konrad to add fixes tag, labels
>     and update the labels
>
> This series add support of pmics that are found in SDX75 platform and
> add the corresponding regulators in the IDP platform as well.
> It also parallely updates the pmic found in SDX65 to PM7250b and add pinctrl
> support for the same pmic chip.
> This series is based on the new header inclusion[1] and movement of the
> regulators level from rpmpd to rpmhpd[2].
> This series can be picked after successfully picking [2] and [3] as [1] has
> already been applied.
>
> [1] https://lore.kernel.org/all/1689744162-9421-1-git-send-email-quic_rohiagar@quicinc.com/
> [2] https://lore.kernel.org/all/1690781104-2290-1-git-send-email-quic_rohiagar@quicinc.com/
> [3] https://lore.kernel.org/all/1690461813-22564-1-git-send-email-quic_rohiagar@quicinc.com/
>
> Thanks,
> Rohit.
Sorry for the spam please ignore this. Will resend version 2.

Thanks,
Rohit.
>
> Rohit Agarwal (9):
>    dt-bindings: phy: qcom,snps-eusb2-repeater: Add compatible for
>      PM7550BA
>    arm64: dts: qcom: sdx75: Add spmi node
>    arm64: dts: qcom: Add pinctrl gpio support for pm7250b
>    arm64: dts: qcom: Add pm7550ba PMIC dtsi
>    arm64: dts: qcom: Add pmx75 PMIC dtsi
>    ARM: dts: qcom: sdx65-mtp: Update the pmic used in sdx65
>    arm64: dts: qcom: sdx75-idp: Add pmics supported in SDX75
>    arm64: dts: qcom: sdx75: Add rpmhpd node
>    arm64: dts: qcom: sdx75-idp: Add regulator nodes
>
>   .../bindings/phy/qcom,snps-eusb2-repeater.yaml     |   7 +-
>   arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts          |   2 +-
>   arch/arm64/boot/dts/qcom/pm7250b.dtsi              |  10 +
>   arch/arm64/boot/dts/qcom/pm7550ba.dtsi             |  70 +++++++
>   arch/arm64/boot/dts/qcom/pmx75.dtsi                |  64 ++++++
>   arch/arm64/boot/dts/qcom/sdx75-idp.dts             | 230 +++++++++++++++++++++
>   arch/arm64/boot/dts/qcom/sdx75.dtsi                |  74 +++++++
>   7 files changed, 455 insertions(+), 2 deletions(-)
>   create mode 100644 arch/arm64/boot/dts/qcom/pm7550ba.dtsi
>   create mode 100644 arch/arm64/boot/dts/qcom/pmx75.dtsi
>
