Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6434F7E27B1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjKFOwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjKFOwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:52:38 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28FBEA;
        Mon,  6 Nov 2023 06:52:35 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6CDuxd001801;
        Mon, 6 Nov 2023 14:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XfMj9nm4CdQ/djsWTELEj9VgwgJnhaCmfO3SH+58Op8=;
 b=acA/JN78LHGt/t+AMBusLjGe7zrPwUHijwfeYxMAu2i0EYiz7JaWRphgfMK8s0iHr9Hb
 LgFeb0eSIm5EBIaDi6kWmXYNGY3X+iEQ7ZEn/0eau63sZWSqHjO0A7mHPPQaalxXhw3Y
 oer1a8hC5gsfXnpOQnRO4Ij1nzpRIBByykbZZTSUj/H87LqkXQGT7NNz5Aaa9dIG3MP5
 afA1kAUWJ7RwNYOsJ3gk9YYlj9JLd73BvKZHKM/ggqz459VpsPqM6fAq/bfsqI/AOu9y
 mB1dQV0y4IfIYLCWCLqL1uaug9jgUzx3TUuImwsf1MmdFvZMjf+aZQMcU1jFdDgCkPOe cQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u6yehrhab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 14:52:31 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A6Eq4em015369
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Nov 2023 14:52:04 GMT
Received: from [10.216.42.224] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 6 Nov
 2023 06:51:57 -0800
Message-ID: <5c2fb6c7-c7c8-b607-c160-df27000a37b1@quicinc.com>
Date:   Mon, 6 Nov 2023 20:21:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 2/2] arm64: dts: qcom: qcm6490: Add qcm6490 idp and
 rb3 board
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_nainmeht@quicinc.com>
References: <20231103184655.23555-1-quic_kbajaj@quicinc.com>
 <20231103184655.23555-3-quic_kbajaj@quicinc.com>
 <CAA8EJprNyu0r_mV9hbKA1fSvoEvTHuk5umxU8H64Voj_cnZcFQ@mail.gmail.com>
 <1830fc44-7bac-4db5-af59-112410d73a64@linaro.org>
 <af05dbdb-21bf-34f0-e9b3-9f6b9a0c3115@quicinc.com>
 <bf473ea4-8fbf-467a-9ebc-e404741ddf94@linaro.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <bf473ea4-8fbf-467a-9ebc-e404741ddf94@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LEFftfI4ot51W1KG1B8lnI3yQajeWOuN
X-Proofpoint-ORIG-GUID: LEFftfI4ot51W1KG1B8lnI3yQajeWOuN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_12,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060120
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/6/2023 6:35 PM, Krzysztof Kozlowski wrote:
> On 06/11/2023 12:41, Mukesh Ojha wrote:
> 
>>> I agree here. What exactly is common in the real hardware between IDP
>>> and RB3? Commit msg does not explain it, so I do not see enough
>>> justification for common file. Just because some DTS looks similar for
>>> different hardware does not mean you should creat common file.
>>
>> @Dmitry/@Krzysztof,
>>
>> Thank you for reviewing the RFC, we wanted to continue the
>> suggestion/discussion given on [1] , where we discussed that this
>> qcm6490 is going to be targeted for IOT segment and will have different
>> memory map and it is going to use some of co-processors like adsp/cdsp
>> which chrome does not use.
>>
>> So to your question what is common between RB3 and IDP, mostly they will
>> share common memory map(similar to [2]) and regulator settings and both
> 
> The question was what is common hardware, not common in your DTS.

Got your point.
Let me know if you agree with the suggestion shared here

https://lore.kernel.org/lkml/CAA8EJpq89g9EeyKcogU+Mt9ie6Bk-rmgi=GqyycYBm_291i1Bw@mail.gmail.com/

-Mukesh
> 
> 
>> will use adsp/cdsp etc., we will be posting the memory map changes as
>> well in coming weeks once this RFC is acked.
> 
> Sorry, that's not common part of hardware.
> 
> Best regards,
> Krzysztof
> 
