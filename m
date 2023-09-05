Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2307792B5A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238251AbjIEQwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353681AbjIEHND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:13:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3E8CC2;
        Tue,  5 Sep 2023 00:13:00 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3857Ci3u010726;
        Tue, 5 Sep 2023 07:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cqBJWnd9BPUO9SKMIGmMu95sPHYeTKr3pysQWTUgpjE=;
 b=HPccXOuRBi+H8cUe/fOw2Xy+lAdqla4y3X3E6X3QdBu5qGDdc2ykRWK/bdsEqT/NL3fC
 uY5TACs4LczKox3rsILHta43HbXJtP2vEmT0Kc37V+hYuLjNbOUsbeAIxDFSGzeLz2Ib
 wDzAI2NqjyECQBrtZEX7iR7fc/Ium0ueFTn7B6ry2o/yPIxZfLbPhsrNPdEzQ7Za8lCV
 hB5il2AoTcay+c60Z6gtZ61+jTyFvvK3L/PpCoH0MA7URc5WMCVk7vE3ktDm+dPxkFPm
 Gz0Z6dbT7mGfSq8ZXsMn/W2sHZ8ZuHWC3547PUX2cBjx9Kugnxl5j2FP7PLZn2J/pdWb Gw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3swpr6gqfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 07:12:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3857CqB5015375
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Sep 2023 07:12:52 GMT
Received: from [10.216.59.199] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 5 Sep
 2023 00:12:43 -0700
Message-ID: <ef19c349-4769-5bd5-b08b-4ab29b8f1efd@quicinc.com>
Date:   Tue, 5 Sep 2023 12:42:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 5/5] phy: qcom-qmp-usb: Add Qualcomm SDX75 USB3 PHY
 support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <abel.vesa@linaro.org>,
        <quic_wcheng@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <kernel@quicinc.com>
References: <1693889028-6485-1-git-send-email-quic_rohiagar@quicinc.com>
 <1693889028-6485-6-git-send-email-quic_rohiagar@quicinc.com>
 <f49b9075-93b7-6f4a-ef80-543bd5b497e2@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <f49b9075-93b7-6f4a-ef80-543bd5b497e2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6gMUXBwzH0ZJnEaRjMa5H2DnoakGMSdI
X-Proofpoint-GUID: 6gMUXBwzH0ZJnEaRjMa5H2DnoakGMSdI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_05,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=751 clxscore=1015 adultscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309050063
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/5/2023 12:23 PM, Krzysztof Kozlowski wrote:
> On 05/09/2023 06:43, Rohit Agarwal wrote:
>> Add support for USB3 QMP PHY found in SDX75 platform.
>>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> ---
>
>
>>   
>> +static const struct qmp_phy_cfg sdx75_usb3_uniphy_cfg = {
>> +	.lanes			= 1,
>> +	.offsets		= &qmp_usb_offsets_v5,
>> +
>> +	.serdes_tbl		= sdx75_usb3_uniphy_serdes_tbl,
>> +	.serdes_tbl_num		= ARRAY_SIZE(sdx75_usb3_uniphy_serdes_tbl),
>> +	.tx_tbl			= sdx75_usb3_uniphy_tx_tbl,
>> +	.tx_tbl_num		= ARRAY_SIZE(sdx75_usb3_uniphy_tx_tbl),
>> +	.rx_tbl			= sdx75_usb3_uniphy_rx_tbl,
>> +	.rx_tbl_num		= ARRAY_SIZE(sdx75_usb3_uniphy_rx_tbl),
>> +	.pcs_tbl		= sdx75_usb3_uniphy_pcs_tbl,
>> +	.pcs_tbl_num		= ARRAY_SIZE(sdx75_usb3_uniphy_pcs_tbl),
>> +	.pcs_usb_tbl		= sdx75_usb3_uniphy_pcs_usb_tbl,
>> +	.pcs_usb_tbl_num	= ARRAY_SIZE(sdx75_usb3_uniphy_pcs_usb_tbl),
>> +	.clk_list		= qmp_v4_sdx55_usbphy_clk_l,
>> +	.num_clks		= ARRAY_SIZE(qmp_v4_sdx55_usbphy_clk_l),
>> +	.reset_list		= msm8996_usb3phy_reset_l,
>> +	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
>> +	.vreg_list		= qmp_phy_vreg_l,
>> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
>> +	.regs			= qmp_v5_usb3phy_regs_layout,
>> +	.pcs_usb_offset		= 0x1000,
>> +
>> +	.has_pwrdn_delay	= true,
>> +
> Stray blank line
>
>> +};
>> +
>>   static const struct qmp_phy_cfg sm8350_usb3phy_cfg = {
>>   	.lanes			= 2,
>>   
>> @@ -1985,6 +2141,7 @@ static int qmp_usb_init(struct phy *phy)
>>   	void __iomem *dp_com = qmp->dp_com;
>>   	int ret;
>>   
>> +
> No need for this.
This got added because I was trying to debug earlier. Sorry for this.
But this should get caught by checkpatch, shouldnt it? I did run 
checkpatch script.

Thanks,
Rohit.
>
> Best regards,
> Krzysztof
>
