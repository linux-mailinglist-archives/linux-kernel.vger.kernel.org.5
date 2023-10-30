Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BDA7DB810
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjJ3K1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjJ3K1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:27:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4108D43;
        Mon, 30 Oct 2023 03:26:59 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39U8f6FH028076;
        Mon, 30 Oct 2023 10:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uP9thLy3jzWSSjRvA0uZ8VuTotc1A8u04dYCHo/3CCc=;
 b=KUzvHYTpYanvEe/7C7Qc3AOJ+FFAkphFNVOefPz0Q6sM9WWa8lEkJTNAdM6ZIWPqNP1R
 O6oAAKEsfsFRizw0oppVLb7lPmswyB2+YWzwpGxNUtX0dI5BwVeZoDdVszAZ+LWwP5LX
 O7H59QuwtCAzG+iJcKjsMKkgHZupC6jfWbC8QImrEj2H3bzx6YFqqBzFW94+nLRFCBi7
 BoDSco4tlBMct3ZYfFNnnbZC3cztK11jVAmaXzcFiMj2rMMFR4wepWZ5ANd6D5WLbHhw
 Uon99bH7D9CxyQhZup5O1jyIoZxJJefD2AAnlY5R3OJOBfBLr/Nh0v5vAn4SkPjRPB+F 7A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u0s8yukmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 10:26:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39UAQmML008236
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 10:26:48 GMT
Received: from [10.216.13.23] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 30 Oct
 2023 03:26:42 -0700
Message-ID: <c77d416e-ed4a-4f92-980a-abe6b690f049@quicinc.com>
Date:   Mon, 30 Oct 2023 15:56:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] arm64: defconfig: build NSS Clock Controller driver
 for IPQ5332
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20231030-ipq5332-nsscc-v1-0-6162a2c65f0a@quicinc.com>
 <20231030-ipq5332-nsscc-v1-8-6162a2c65f0a@quicinc.com>
Content-Language: en-US
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <20231030-ipq5332-nsscc-v1-8-6162a2c65f0a@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: obNjgnvksFC1bfVqdm-UQHVIJnqf_l6B
X-Proofpoint-ORIG-GUID: obNjgnvksFC1bfVqdm-UQHVIJnqf_l6B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_09,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 suspectscore=0 spamscore=0 mlxlogscore=899 mlxscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/30/2023 3:17 PM, Kathiravan Thirumoorthy wrote:
> Build Qualcomm IPQ9574 NSSCC driver as module.

should be IPQ5332, will fix it in V2.

> 
> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> ---
>   arch/arm64/configs/defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index b60aa1f89343..c075202d255d 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1223,6 +1223,7 @@ CONFIG_QCOM_CLK_SMD_RPM=y
>   CONFIG_QCOM_CLK_RPMH=y
>   CONFIG_IPQ_APSS_6018=y
>   CONFIG_IPQ_GCC_5332=y
> +CONFIG_IPQ_NSSCC_5332=m
>   CONFIG_IPQ_APSS_5018=y
>   CONFIG_IPQ_GCC_5018=y
>   CONFIG_IPQ_GCC_6018=y
> 
