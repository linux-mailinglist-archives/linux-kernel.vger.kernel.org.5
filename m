Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974AD7D2A2F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbjJWGSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJWGSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:18:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20211B9;
        Sun, 22 Oct 2023 23:18:13 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39N5KcrB013790;
        Mon, 23 Oct 2023 06:17:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HVDrCUf3g4LHhUIjDtKHtE6V9XyZyOr9a1j0I+Qf3uk=;
 b=mTEDYTu3OUJ8XIL/6OHCja9gFHuT/YqlUSohp+y5kT4o+Fzhd3xHHmmHF5HNt/vTDgAd
 lFYvnlMhTmP8lzwPNbEhDjc097GInw6kQeQE8WRLT8M5jaXUWOU+ZMSJIk7JtVVFkMza
 /7NKXHNa4FvKLYYscOXjFLXlo+5joS2PMceYdSaIz61mbdJqxFyED15JrNXTJtJ7pBXP
 qV3FnddsSHEnCJwR+5we8y7Y5myi3xUr3/vQ+fbMvphdq3OcwmdZY4FWzPPEZcNN5QAW
 S3iR2h3O2vP6/gn+kC40vC3RgN3Jj3g6Xpxgxd4m64viTvklqSkAFJVmOL4i1RKiTAML Rg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv40ukhae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 06:17:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39N6HnBj014989
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 06:17:49 GMT
Received: from [10.216.48.174] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Sun, 22 Oct
 2023 23:17:41 -0700
Message-ID: <2dc93e2b-61b4-943c-f938-296922fbece4@quicinc.com>
Date:   Mon, 23 Oct 2023 11:47:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 09/11] iio: adc: Update QCOM ADC drivers for bindings path
 change
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <sboyd@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_kamalw@quicinc.com>,
        <marijn.suijten@somainline.org>,
        <andriy.shevchenko@linux.intel.com>,
        <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
 <20230708072835.3035398-10-quic_jprakash@quicinc.com>
 <20230708162318.1e2b169f@jic23-huawei>
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <20230708162318.1e2b169f@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: z1KJ9FpynL593asgKxlZdSst7d2eyx41
X-Proofpoint-ORIG-GUID: z1KJ9FpynL593asgKxlZdSst7d2eyx41
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_03,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=811
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230054
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 7/8/2023 8:53 PM, Jonathan Cameron wrote:
> On Sat, 8 Jul 2023 12:58:33 +0530
> Jishnu Prakash <quic_jprakash@quicinc.com> wrote:
>
>> Update ADC dt-bindings file paths in QCOM ADC driver files to
>> match the dt-bindings change moving the files from 'iio' to
>> 'iio/adc' folder.
>>
>> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> Do the move in one go.
>
> Diff rename detection will make the resulting patch more trivial
> to look at than this multistep version.
>
> Jonathan


Hi Jonathan,

Just to recap, in patches 8-11, the intention is to move the dt-binding 
files used for QCOM ADCs from /dt-bindings/iio folder to the 
/dt-bindings/iio/adc folder.

I'm just confirming, can we move the files and update documentation, 
bindings, driver and devicetree files all in one patch? Or you mean one 
patch for documentation, bindings and driver files and one patch for 
devicetree files (based on the comment from Krzysztof for the next patch 
10 in this series)?

Based on this patch series: 
https://lore.kernel.org/all/cover.1646388139.git.zong.li@sifive.com/, 
I'm wondering if I should add the files in the new location first, do 
the file path updates and then completely remove the files in the old 
path to avoid breaking the kernel.....or is it possible to get the 
devicetree changes picked along with the binding changes, to avoid any 
problems with bisectability?


>> ---
>>   drivers/iio/adc/qcom-spmi-adc5-gen3.c | 2 +-
>>   drivers/iio/adc/qcom-spmi-adc5.c      | 2 +-
>>   drivers/iio/adc/qcom-spmi-vadc.c      | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>
Thanks,

Jishnu

