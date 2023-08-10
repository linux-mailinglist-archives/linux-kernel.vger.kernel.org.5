Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD79776F31
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 06:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjHJEsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 00:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjHJEsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 00:48:30 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C4A10C;
        Wed,  9 Aug 2023 21:48:30 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37A4G32x022998;
        Thu, 10 Aug 2023 04:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wV9s5mu6NzyGgHba/Xen3N4rjrafuQTS/RvqWOGsu24=;
 b=O0NxbGMYiDs+cEFhIolLJYjGTa+yhuk818E9Qgkgj8CO9jigp1bjUoF4jiGVDe6Y5of/
 ylliXTv44EHPOnbvdD6kp1DmPLxrkr82+mOKLuuDPuxhqWb8EKGza341451n48DWodBu
 FwukVr9UxeQVFlaTfrKrtJDy19WzRq7xut9krmErxde7Vs7KnD8OvJUSkdZJGqMF0+Pt
 14UcBzfBZtPVgWXI3iAP7ZMwn8oBGE3wXmyza0KJNmKCEpEZvJy+me6rRGVwdKLIzR9q
 q36FUH5+DaPJ5H/sARnODh3ezZ4JSLiDi9TCZr3hM0ODiie/Oc/iLYOXkZYYIfHRAmwc 0A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3scqsj04bf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 04:48:16 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37A4mGEK021741
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 04:48:16 GMT
Received: from [10.253.39.188] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 21:48:12 -0700
Message-ID: <d3eb66b9-ab10-de16-ef21-8baea5f0a6c4@quicinc.com>
Date:   Thu, 10 Aug 2023 12:48:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 3/4] clk: qcom: add clock controller driver for
 qca8386/qca8084
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <andersson@kernel.org>,
        <agross@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20230809080047.19877-1-quic_luoj@quicinc.com>
 <20230809080047.19877-4-quic_luoj@quicinc.com>
 <bca30002-8ba9-42a0-8b9f-4dcc8c4ee7e2@linaro.org>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <bca30002-8ba9-42a0-8b9f-4dcc8c4ee7e2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vcz8d056JfrueAwAmESI_Su0RukBqbOl
X-Proofpoint-GUID: vcz8d056JfrueAwAmESI_Su0RukBqbOl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_03,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 mlxscore=0 mlxlogscore=947
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100041
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/2023 12:57 AM, Konrad Dybcio wrote:
> On 9.08.2023 10:00, Luo Jie wrote:
>> Add clock & reset controller driver for qca8386/qca8084.
>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
> [...]
> 
>> +static const struct of_device_id nss_cc_qca8k_match_table[] = {
>> +	{ .compatible = "qcom,qca8085-nsscc" },
>> +	{ .compatible = "qcom,qca8084-nsscc" },
>> +	{ .compatible = "qcom,qca8082-nsscc" },
>> +	{ .compatible = "qcom,qca8386-nsscc" },
>> +	{ .compatible = "qcom,qca8385-nsscc" },
>> +	{ .compatible = "qcom,qca8384-nsscc" },
> Are they 1:1 identical as far as NSS_CC goes?
> 
> Konrad

Hi Konrad,
Yes, the same clock configuration is used by these type of chip.
i will update it to keep "qcom,qca8084-nsscc" and remove others as 
krzysztof suggested.

Thanks.
