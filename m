Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1E37D29F2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbjJWGKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjJWGKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:10:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD24D65;
        Sun, 22 Oct 2023 23:10:09 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39N3hZWq019199;
        Mon, 23 Oct 2023 06:09:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pyp0WwozmLb9QG0BjAWpnuHgrRXDyEq+sCaBj1NCa30=;
 b=lGaT6aaySkRic0Z9vQokadmxdgBtxjqs1YVxG7MAWUpMKlkDBYb9M+PDyVHI/4UXoQg1
 E4D4KdPBqFgOtPGfQM1yO4TOGk+z/CHCy4idNih/TCnhlNJObWULeelxncw7UxNb9bGE
 YolzwrZusfDrQH88mGWwfP5+NQ2TfX+iyfsoEYR3NFelVFnizX8TPzAfzDtdtTGgk+Mk
 dWaSlTYFES72cuF9jJPIQhAvmPS3xpG4Xhguk5iBwPUtjUy1y72pwKVg2VUwxmvygtQK
 b8OZ8jL7MLwgjEbvnUvWDaJI8WBmDhN0qTpFvRtxHXl9SaqHm3/Jw0YDsgwn+H94yHMZ lQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv71d375g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 06:09:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39N69rGg006578
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 06:09:53 GMT
Received: from [10.216.48.174] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Sun, 22 Oct
 2023 23:09:45 -0700
Message-ID: <27b5806f-ef15-7a90-5adc-5ee12690f2ca@quicinc.com>
Date:   Mon, 23 Oct 2023 11:39:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 03/11] ARM: dts: qcom: Update devicetree for ADC7 rename
 for QCOM PMICs
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <sboyd@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_kamalw@quicinc.com>,
        <marijn.suijten@somainline.org>,
        <andriy.shevchenko@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     <linux-iio@vger.kernel.org>, <linux-arm-msm-owner@vger.kernel.org>
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
 <20230708072835.3035398-4-quic_jprakash@quicinc.com>
 <839cfac2-8f74-3386-5854-e3fb2ba4e07f@linaro.org>
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <839cfac2-8f74-3386-5854-e3fb2ba4e07f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KKq-YFVErprcxFPppezRHzFCscx3ZXyV
X-Proofpoint-GUID: KKq-YFVErprcxFPppezRHzFCscx3ZXyV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_03,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=721
 clxscore=1011 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230053
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 7/9/2023 10:48 PM, Krzysztof Kozlowski wrote:
> On 08/07/2023 09:28, Jishnu Prakash wrote:
>> The name "ADC7" needs to be replaced with the name "ADC5_GEN2"
>> everywhere to match the convention used for these ADC peripherals
>> on Qualcomm Technologies, Inc. PMICs. Update devicetree files for
> We do not rename compatibles to match convention. Please provide proper
> rationale.

I'll avoid renaming the compatible directly, will just mark it 
deprecated - but is it fine to do the other changes, for updating the 
macro names used in devicetree (replacing the ADC7 macros with the ADC5 
Gen2 macros)?

I do see an example of a macro change in devicetree done in this patch: 
https://lore.kernel.org/all/cover.1646388139.git.zong.li@sifive.com/.

Patch 2 here replaced some macro definitions: 
https://lore.kernel.org/all/f9284873c2993a9952d9fe4f8dd5e89f20daab75.1646388139.git.zong.li@sifive.com/.

Patch 3 made the corresponding update in devicetree files: 
https://lore.kernel.org/all/db92d209fa700f7da8bc8028083476fcc138d80e.1646388139.git.zong.li@sifive.com/. 


 From this mail, it looks like the maintainer was willing to pick them 
at that time: 
https://lore.kernel.org/all/20220315225652.CDAD1C340E8@smtp.kernel.org/, 
would something similar be possible here?

Thanks,

Jishnu


