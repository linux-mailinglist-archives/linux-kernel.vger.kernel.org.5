Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD71879084E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 16:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjIBOnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 10:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjIBOni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 10:43:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB9B10EB;
        Sat,  2 Sep 2023 07:43:35 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 382EhPRo007680;
        Sat, 2 Sep 2023 14:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UjNidh8ce6KQOxCJsuzKeLVYqu+hNoaa2Ob7Pv0Efv0=;
 b=cjEVpIA+dwykfDjlahTBaFRjcH4kA7RklWLPp3cU4YombI317JhpFUkTMQ3PZ5KL3piS
 MNF78hLv5TMM+MyFxAucMf4kfBri/Fhc2ghVdGuf7qNvFGs0sjNI5WIN8HL7LYTRIsIF
 b3ZmKHQPYduGY51HjE8OxvsBgBOucJ1Wohu0OcGx1WDSWhbltP0ULqSL2qSIXoRx99Do
 AUgm/Y1VkgFVdB7QnXnvki6IJixXMlV8wZvfZwffIOYm2sxHmr+8+ogdJ82/0yHPgKbJ
 f3m7I+n90E1wtOT5Rcqz5eOdu4HTD3NsZvN47tU5Peh/eH8UOfMmD3MbbGMGqKdK8cxa Ew== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suvn6gn5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 02 Sep 2023 14:43:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 382EhOOe026924
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 2 Sep 2023 14:43:24 GMT
Received: from [10.216.50.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sat, 2 Sep
 2023 07:43:20 -0700
Message-ID: <6f7e2b0a-5113-2526-bdfe-c9053c285d55@quicinc.com>
Date:   Sat, 2 Sep 2023 20:13:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/2] soc: qcom: socinfo: Add IDs for IPQ8174 family
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20230901181041.1538999-1-robimarko@gmail.com>
 <20230901181041.1538999-2-robimarko@gmail.com>
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <20230901181041.1538999-2-robimarko@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ovs3Up_xvn6xoULmiaMcrK7oPMkOQR6X
X-Proofpoint-GUID: Ovs3Up_xvn6xoULmiaMcrK7oPMkOQR6X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-02_10,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=947 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309020137
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/1/2023 11:40 PM, Robert Marko wrote:
> IPQ8174 (Oak) family is part of the IPQ8074 family, but the ID-s for it
> are missing so lets add them.
>
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>   drivers/soc/qcom/socinfo.c | 3 +++
>   1 file changed, 3 insertions(+)


Reviewed-by: Kathiravan T <quic_kathirav@quicinc.com>


>
> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> index 497cfb720fcb..345f0b002eb5 100644
> --- a/drivers/soc/qcom/socinfo.c
> +++ b/drivers/soc/qcom/socinfo.c
> @@ -359,6 +359,9 @@ static const struct soc_id soc_id[] = {
>   	{ qcom_board_id(SM6125) },
>   	{ qcom_board_id(IPQ8070A) },
>   	{ qcom_board_id(IPQ8071A) },
> +	{ qcom_board_id(IPQ8172) },
> +	{ qcom_board_id(IPQ8173) },
> +	{ qcom_board_id(IPQ8174) },
>   	{ qcom_board_id(IPQ6018) },
>   	{ qcom_board_id(IPQ6028) },
>   	{ qcom_board_id(SDM429W) },
