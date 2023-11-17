Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306EC7EEF6F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345863AbjKQJ4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235726AbjKQJ4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:56:48 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857C110E0;
        Fri, 17 Nov 2023 01:56:44 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AH9XDQJ007104;
        Fri, 17 Nov 2023 09:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MBwQNnrP/VoAcmnLrs6vo1SDNvrC8nNxML8vPT+zO5s=;
 b=cHxEdEruI4S98eFsBMjPeWOSOt4i/ANGXHbwaVFGFoCTFbpW36cV/HqbpnK3yHLUKWUr
 H7RISv4qYe0UToETdFyCf5H5nIkjFvOyyQ8eJOc9fY53u4EdvIBgosQssYBs3xU3WYMZ
 Zp19V0IXjTk6FEDxExTyD1CecyZY/k9YqF7oV7gtxvyjn+rtlinWFqUQ8quwUnxPnHeX
 No2msSBW/9U67shr2z8sV5+RrA/aJcQm87zm8nSQQ9VqGDA8zU8JErEVIdHDHb9o3lkl
 Iuig1bFqSadUIYIo5TT8WcJsN4Q+s6osMqTr1gCoPMRrLI53tdtqEWEuSFNwjs4rWOU0 cQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3udpqq205v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 09:56:32 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AH9uVKB030753
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 09:56:31 GMT
Received: from [10.253.8.81] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 17 Nov
 2023 01:56:26 -0800
Message-ID: <dd8260ce-3cbe-42f5-bc58-51730cd5dabd@quicinc.com>
Date:   Fri, 17 Nov 2023 17:56:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] net: mdio: ipq4019: increase eth_ldo_rdy for ipq5332
 platform
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <robert.marko@sartura.hr>
CC:     <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20231115032515.4249-1-quic_luoj@quicinc.com>
 <20231115032515.4249-2-quic_luoj@quicinc.com>
 <7786f8e0-2395-4bb6-bc29-071ed637611f@linaro.org>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <7786f8e0-2395-4bb6-bc29-071ed637611f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nvHhsVaDEiLh6-yQu5letGiCWdpGE7Yo
X-Proofpoint-ORIG-GUID: nvHhsVaDEiLh6-yQu5letGiCWdpGE7Yo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_07,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/16/2023 7:57 PM, Krzysztof Kozlowski wrote:
> On 15/11/2023 04:25, Luo Jie wrote:
>> There are two PCS(UNIPHY) supported in SOC side on ipq5332,
>> and three PCS(UNIPHY) supported on ipq9574.
>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
>>   drivers/net/mdio/mdio-ipq4019.c | 55 +++++++++++++++++++--------------
>>   1 file changed, 32 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
>> index abd8b508ec16..9d444f5f7efb 100644
>> --- a/drivers/net/mdio/mdio-ipq4019.c
>> +++ b/drivers/net/mdio/mdio-ipq4019.c
>> @@ -18,28 +18,31 @@
>>   #define MDIO_DATA_WRITE_REG			0x48
>>   #define MDIO_DATA_READ_REG			0x4c
>>   #define MDIO_CMD_REG				0x50
>> -#define MDIO_CMD_ACCESS_BUSY		BIT(16)
>> -#define MDIO_CMD_ACCESS_START		BIT(8)
>> -#define MDIO_CMD_ACCESS_CODE_READ	0
>> -#define MDIO_CMD_ACCESS_CODE_WRITE	1
>> -#define MDIO_CMD_ACCESS_CODE_C45_ADDR	0
>> -#define MDIO_CMD_ACCESS_CODE_C45_WRITE	1
>> -#define MDIO_CMD_ACCESS_CODE_C45_READ	2
>> +#define MDIO_CMD_ACCESS_BUSY			BIT(16)
>> +#define MDIO_CMD_ACCESS_START			BIT(8)
>> +#define MDIO_CMD_ACCESS_CODE_READ		0
>> +#define MDIO_CMD_ACCESS_CODE_WRITE		1
>> +#define MDIO_CMD_ACCESS_CODE_C45_ADDR		0
>> +#define MDIO_CMD_ACCESS_CODE_C45_WRITE		1
>> +#define MDIO_CMD_ACCESS_CODE_C45_READ		2
> 
> Where is anything related to ipq5332 here?

This is for alignment format, will keep it untouched in the next
patch set.

> 
> 
> ..
> 
>>   	bus->name = "ipq4019_mdio";
>>   	bus->read = ipq4019_mdio_read_c22;
>> @@ -288,6 +296,7 @@ static void ipq4019_mdio_remove(struct platform_device *pdev)
>>   static const struct of_device_id ipq4019_mdio_dt_ids[] = {
>>   	{ .compatible = "qcom,ipq4019-mdio" },
>>   	{ .compatible = "qcom,ipq5018-mdio" },
>> +	{ .compatible = "qcom,ipq5332-mdio" },
> 
> How user comes before binding?

The new added compatible is for the GCC uniphy AHB/SYS clocks configured
on the ipq5332 platform, will move this change into the following patch
that involves the ipq5332 to make it clear.

<net: mdio: ipq4019: Enable the clocks for ipq5332 platform>.

> 
> Best regards,
> Krzysztof
> 
