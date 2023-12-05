Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6288043A5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 01:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343632AbjLEA7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 19:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjLEA7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 19:59:21 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF32A4;
        Mon,  4 Dec 2023 16:59:28 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B504MVZ025715;
        Tue, 5 Dec 2023 00:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=T738itOozoPN5W91FwWVw0mvtukuJmpFNP5o/YIrwCY=;
 b=J8fRcgT5WB1raj9YoQNOGMnMiYYM+ql64CsYGEx06oxfpxRC6+OLUBhAmsuyJkq63HeW
 XJs+kXXozAJpJR7STup5souiCiSvcoYJnrBPPqhZiN5y8UJKr2Kr2C1YXCS0+NZIUyN3
 AtZor7z98YhQgJSi1x9cb8JRM3KeVxWBsMjnBaBwg/ghxg/hjERKJtybegOq5dRPRRwN
 cwj5aI3dzkVDDrvkkg58AoujSLybHOKG4P2vfxUKSsZ0bc9/3Ho5TudsnQ/Sts9zzQ8s
 bmd1O00f9NTpPZxHm9VQciGAhK0m3FMWoeY8nFacMikAUvevRVw2JidTKWVLH7AJvltD qQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3us8wpjj4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 00:59:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B50xNG1013296
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Dec 2023 00:59:23 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 4 Dec
 2023 16:59:18 -0800
Message-ID: <5d2c734c-8a33-4a57-be2e-7c80357089ea@quicinc.com>
Date:   Tue, 5 Dec 2023 08:59:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] pinctrl: qcom: sm4450: correct incorrect address
 offset
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     <agross@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
References: <20231130024046.25938-1-quic_tengfan@quicinc.com>
 <20231130024046.25938-5-quic_tengfan@quicinc.com>
 <dx62durg3wmqviqdpecdqprd5wwkg4i7n5tgcab55axzssdeel@ftt35c6td2sh>
 <CACRpkdZRNvUY0rEY__v9wPy4bjuDSgFhEkXFHxixdfyKSw56Bg@mail.gmail.com>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <CACRpkdZRNvUY0rEY__v9wPy4bjuDSgFhEkXFHxixdfyKSw56Bg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GsCL24S4eXQQVXi9z_E_7EBAyDQ91g3n
X-Proofpoint-ORIG-GUID: GsCL24S4eXQQVXi9z_E_7EBAyDQ91g3n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_24,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0
 mlxlogscore=990 impostorscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2312050005
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 12/4/2023 5:57 PM, Linus Walleij 写道:
> On Fri, Dec 1, 2023 at 10:33 PM Bjorn Andersson <andersson@kernel.org> wrote:
>> On Thu, Nov 30, 2023 at 10:40:46AM +0800, Tengfei Fan wrote:
>>> The address offset of 0x100000 is already provided in SM4450 DTSI, so
>>> subtract 0x100000 from the offset which used by ufs and sdc.
>>>
>>
>> As Konrad points out, please fix the broken patch, don't add a separate
>> fix in the same series.
>>
>>> Suggested-by: Can Guo <quic_cang@quicinc.com>
>>
>> We unfortunately don't have a way to give credit to those providing
>> review feedback, so omit this when fixing patch #2.
> 
> Just write in the commit message that Can Guo helped out in reviewing
> the driver (just some free text).
> 
> Yours,
> Linus Walleij
Thanks for your suggestions, The next version patch commit message will 
contain some description information.

-- 
Thx and BRs,
Tengfei Fan
