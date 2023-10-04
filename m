Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E33E7B7D91
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 12:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbjJDKxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 06:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjJDKxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 06:53:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB98A1;
        Wed,  4 Oct 2023 03:53:44 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394AjGSG025031;
        Wed, 4 Oct 2023 10:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9R2nYmUlbsMTQaQ62JQ6OiRNY2PCc78P2XH8kTRAImk=;
 b=J9OUa3voShEuUbgQJqtiI3vEwXY/EzRVV9aUP3fk0LBZ4JHuEMY/cMDIvup4N02lPnf3
 HyTHk+L9gmklZE1Fi4w/PWMVUh2vTzu8RT88Gw7VDtNvGUaW+KVkFdprG1Ifp4jdqSne
 YFHag250vlnEmXbO7azFpsCx04hY1y+KRIAsrBn+/sTZsHB4vQrGZomqmC8PWnMSVa+H
 9feqilJQ4Oq0YG6tokevymYKh2Ay0f0fggvqnP6YcSneV8c1ngl+7tfK12yg6vNwu6mI
 C7XL92/83VNAX6nc+EsJTN5jLV1lZWJVUiqKiHaR59SYyKnD0yGsgH+e9SzyXnb9JY3q Ow== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3th18jgn33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 10:53:38 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 394ArbJV025477
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Oct 2023 10:53:37 GMT
Received: from [10.217.218.207] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 4 Oct
 2023 03:53:32 -0700
Message-ID: <de91353f-41b7-414d-9ae2-51cbc7615411@quicinc.com>
Date:   Wed, 4 Oct 2023 16:23:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] mmc: sdhci-msm: Enable MMC_CAP2_SLEEP_AWAKE for
 Qualcomm controllers
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_rampraka@quicinc.com>,
        <quic_pragalla@quicinc.com>, <quic_sayalil@quicinc.com>,
        <quic_nitirawa@quicinc.com>, <quic_sachgupt@quicinc.com>,
        <quic_bhaskarv@quicinc.com>, <quic_narepall@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
References: <20230929102831.9702-1-quic_sartgarg@quicinc.com>
 <20230929102831.9702-3-quic_sartgarg@quicinc.com>
 <7db0a714-de18-4644-84d1-a5d543af5693@linaro.org>
From:   Sarthak Garg <quic_sartgarg@quicinc.com>
In-Reply-To: <7db0a714-de18-4644-84d1-a5d543af5693@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JG7f_JF-X9IZ763baualsDqRYvjOQp5E
X-Proofpoint-ORIG-GUID: JG7f_JF-X9IZ763baualsDqRYvjOQp5E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_02,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=611 bulkscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/29/2023 5:17 PM, Konrad Dybcio wrote:
> On 29.09.2023 12:28, Sarthak Garg wrote:
>> Enable MMC_CAP2_SLEEP_AWAKE for Qualcomm controllers to let them use
>> sleep/awake functionality for faster eMMC resume instead of
>> doing full initialization.
>>
>> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
>> ---
> Will this work on all SoCs from MSM8974 to SM8550 inclusive?
>
> Such changes affect all users of this driver.
>
> Konrad


Yes it will work on all SOC's as its an eMMC card specific feature and 
where the underlying eMMC card supports sleep/awake commands.


