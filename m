Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A22768AE9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 07:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjGaFEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 01:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGaFEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 01:04:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CB51BF;
        Sun, 30 Jul 2023 22:04:34 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36V4iGxL018972;
        Mon, 31 Jul 2023 05:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TcMnLnc/KdAeHdH42ftkVYIT3tPuoTwENsJK/nuaSqk=;
 b=GRf1z0MfbJtNriUXrz4cYj2TAoZANx1ilpD9+hlD0aVCbhvCjsnotgvMWAzyBiGMKCjg
 pM3pS3yQpE7aNf8DarZ9kV/7Hv+JJ7iMtwf4eDJZN7H6iRwVuf2G+cYKy4WwfepL0Otc
 TmRcoDXfHaz9qzhtGJhJpAkEcflpv62PsJ9pRj+U0ZHGpbAsBd/xD8bCIXtvEYph7Ehr
 iT/1xw0Ux8SpwLZaREjYJX+MHI69cE9A0ibLYZoWDy6DLAo2j6mWbNfC8tImU2sVfDlQ
 +itxwczyf0GB3ZvUbJ3T3i3W+KJXqg1wxdt2yFyxe8f5Y+3Rx0mz+A38pnha0xyPFKXQ Ng== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4uat2n6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 05:04:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36V54TKS031441
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 05:04:29 GMT
Received: from [10.201.206.238] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sun, 30 Jul
 2023 22:04:22 -0700
Message-ID: <58e66ef8-25ff-9d66-da41-52f686480dc0@quicinc.com>
Date:   Mon, 31 Jul 2023 10:34:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v4 09/11] remoteproc: qcom: Add Hexagon based multipd
 rproc driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_eberman@quicinc.com>, <kvalo@kernel.org>,
        <loic.poulain@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_varada@quicinc.com>
References: <20230728063412.1641856-1-quic_mmanikan@quicinc.com>
 <20230728063412.1641856-10-quic_mmanikan@quicinc.com>
 <117f6341-55d7-601b-203f-8a09dd4bb22f@linaro.org>
Content-Language: en-US
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <117f6341-55d7-601b-203f-8a09dd4bb22f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZzqXozlKprTkbGbxntLcEqOIZPGLW9q8
X-Proofpoint-GUID: ZzqXozlKprTkbGbxntLcEqOIZPGLW9q8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 priorityscore=1501 mlxlogscore=903 suspectscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 impostorscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310046
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/2023 1:57 PM, Krzysztof Kozlowski wrote:
> On 28/07/2023 08:34, Manikanta Mylavarapu wrote:
>> +
>> +static int q6_get_inbound_irq(struct qcom_q6v5 *q6,
>> +			      struct platform_device *pdev,
>> +			      const char *int_name,
>> +			      int index, int *pirq,
>> +			      irqreturn_t (*handler)(int irq, void *data))
>> +{
>> +	int ret, irq;
>> +	char *interrupt, *tmp = (char *)int_name;
>> +	struct q6_wcss *wcss = q6->rproc->priv;
>> +
>> +	irq = platform_get_irq(pdev, index);
>> +	if (irq < 0) {
>> +		if (irq != -EPROBE_DEFER)
> 
> Still not good... I think I am saying this the third time: drop this
> eprobe defer dance. It is not needed. Just open the definition of
> dev_err_probe().
> 
Yeah, somehow it's missed. I will drop.

Thanks & Regards,
Manikanta.

>> +			return dev_err_probe(&pdev->dev, irq,
>> +					     "failed to retrieve %s IRQ: %d\n",
>> +					     int_name, irq);
>> +	}
>> +
> 
> 
> 
> Best regards,
> Krzysztof
> 
