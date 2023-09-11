Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA16179A0F8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 03:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjIKBY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 21:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjIKBYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 21:24:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B9A120;
        Sun, 10 Sep 2023 18:24:18 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38B0wMWN011370;
        Mon, 11 Sep 2023 01:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jjUp8svKQlfJPyCMt/gckYHXgUZ34QmZOAlOxqoLL7o=;
 b=c1suQyKqujR++c91fk6vTBEsXAhn5SFW9K0bCDcXKpngUv7UVvrcRkyhirKf3dbCFM35
 AvVJbxaag0heehYA3eJkwgjou18TIRUvvpx9e18qA8ZhyMdPEUsjzghfbFAbfhaHsfix
 nvOx7IBQxgBCDq2JcGB4gUI4kfynwV1VKU4Ski+ZkkefVJnvc5mCSqWYU+E1asttaq/o
 mQHTeINsbNN6BbvppBVlrpov0b2Gnr7TWfEinvZdzVNuHjVN1dyjfpCN1kRdC3xru0vS
 vyA++LnCXTQdPbdVvBsIbE/ncyPA/sQkQ6KCX92vxUDctW5I2LwPeQz6INgl7oZRTbKH Ww== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t0g1rjaa1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 01:23:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38B1NfKx002105
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 01:23:41 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sun, 10 Sep
 2023 18:23:32 -0700
Message-ID: <3b27680b-f34f-49c6-bb74-0146c3ca2484@quicinc.com>
Date:   Mon, 11 Sep 2023 09:23:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] pinctrl: qcom: Add SM4450 pinctrl driver
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <linus.walleij@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <arnd@arndb.de>, <geert+renesas@glider.be>,
        <nfraprado@collabora.com>, <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_tsoni@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tdas@quicinc.com>, <quic_tingweiz@quicinc.com>,
        <quic_aiquny@quicinc.com>, <kernel@quicinc.com>
References: <20230908063843.26835-1-quic_tengfan@quicinc.com>
 <20230908063843.26835-3-quic_tengfan@quicinc.com>
 <d0d6825a-97f7-405b-910e-772100c325a9@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <d0d6825a-97f7-405b-910e-772100c325a9@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MQPRpea4FhPqSGx_7no7CEpX0ubg0tew
X-Proofpoint-ORIG-GUID: MQPRpea4FhPqSGx_7no7CEpX0ubg0tew
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-10_18,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 spamscore=0 mlxlogscore=880 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309110010
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 9/8/2023 4:45 PM, Konrad Dybcio 写道:
> On 8.09.2023 08:38, Tengfei Fan wrote:
>> Add pinctrl driver for TLMM block found in SM4450 SoC.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
> [...]
> 
>> +/* Every pin is maintained as a single group, and missing or non-existing pin
> /*
>   * Every pin
> 
>> + * would be maintained as dummy group to synchronize pin group index with
>> + * pin descriptor registered with pinctrl core.
>> + * Clients would not be able to request these dummy pin groups.
>> + */
> [...]
> 
>> +static const int sm4450_acpi_reserved_gpios[] = {
>> +	0, 1, 2, 3, 136, -1
>> +};
> Are you ever going to boot with ACPI on this platform?
> 
> Why reserve UFS_RESET?
> 
> Why are 0-3 reserved? FP reader? Please leave a comment. Or
> delete this.
> 
> Konrad
Thanks Konrad reviewed this patch, will do more test and disscuss about 
this reserve gpio setting, and will remove this in next patch if possible.

-- 
Thx and BRs,
Tengfei Fan
