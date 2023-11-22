Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8587F46EF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343868AbjKVMva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343824AbjKVMv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:51:28 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCA118D;
        Wed, 22 Nov 2023 04:51:24 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM5Vcqs013032;
        Wed, 22 Nov 2023 12:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=27Z8pqIwCURhifVSG9XX//Qs1tVHrqv8hOikZ4CO4PY=;
 b=LJvl5TlCGFNaosRuNZfVGSH7xk+GwH2XL37EmKbaC0SRjyKdgqN5BrdSq3xwgO04BGcU
 xuLqW/Q/C1qwDXDh0fFlC6znlNvQDzn9C8/UngmwE20B1St8+mXt6Fz50Q77+pXbjXsh
 1R6enMYzurvTKGo9oqLOPy+Em8abG3SdqqAFjkZ5EkFC69Eifs5j2vXp8dCtq91f5tUg
 EkbxDj6MEiPnVSY4W5mg1kj5MYJxQCNrErNK6Zk63yWdhweTb6r+uUvH6uwGOPIdbTKC
 5gxQn8wYM8fvdmHCPRDOLK4r+/w2wwf+yR7mG1/y3lrg1vlAFEnKmk8UFkLTyDuIS6dh UQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uhbjvh6m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 12:51:10 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AMCp9tq022472
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 12:51:09 GMT
Received: from [10.206.101.41] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 22 Nov
 2023 04:51:02 -0800
Message-ID: <4f5d4019-ffae-1eed-be7f-14e68d933063@quicinc.com>
Date:   Wed, 22 Nov 2023 18:20:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND v3 4/5] clk: qcom: Use HW_CTRL_TRIGGER flag to
 switch video GDSC to HW mode
To:     Jagadeesh Kona <quic_jkona@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-media@vger.kernel.org>
References: <20231101-gdsc-hwctrl-v3-0-0740ae6b2b04@linaro.org>
 <20231101-gdsc-hwctrl-v3-4-0740ae6b2b04@linaro.org>
 <v4dnsawo7s74spccrsvjwmal73tqfq4aptiny25tyyp6ungxha@jlbywvcssqtl>
 <d716fbbe-b681-af41-bfe7-85448cc47c7c@quicinc.com>
Content-Language: en-US
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <d716fbbe-b681-af41-bfe7-85448cc47c7c@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JOFdN4YIviS_rQmdT3WYhksczd3WaO3o
X-Proofpoint-ORIG-GUID: JOFdN4YIviS_rQmdT3WYhksczd3WaO3o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_08,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220090
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2023 2:02 PM, Jagadeesh Kona wrote:
> 
> 
> On 11/4/2023 1:45 AM, Bjorn Andersson wrote:
>> On Wed, Nov 01, 2023 at 11:04:10AM +0200, Abel Vesa wrote:
>>> From: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>
>>> The current HW_CTRL flag switches the video GDSC to HW control mode as
>>> part of GDSC enable itself, instead of that use HW_CTRL_TRIGGER flag to
>>> give consumer drivers more control and switch the GDSC mode as and when
>>> required.
>>>
>>> HW_CTRL_TRIGGER flag allows consumer drivers to switch the video GDSC to
>>> HW/SW control modes at runtime using dev_pm_genpd_set_hwmode API.
>>>
>>
>> This states what the code currently does, and what the new code will do.
>> But I don't find that it adequately describes _why_ this is done.
>>
>>
>> In the current implementation, the hardware is might collapse the GDSC
>> anytime between gdsc_enable() and gdsc_disable(). By giving "drivers
>> more control" the time spent in this state is reduced to some fraction
>> of that span, which to me implies higher power consumption.
>>
>> Under the assumption that we don't want to consume more power without
>> reason, I'm forced to guess that there might be some scenarios that we
>> want this feature to keep the GDSC non-collapsed against the indication
>> of the hardware - to avoid some instability somewhere, perhaps?
>>
> 
> Thanks Bjorn for your review. Sure, will update commit text with details in next
> series.
> 
> Normally, consumers will enable the GDSC and then the required clocks. If GDSC
> is moved to HW mode in gdsc_enable() itself, the subsequent clocks enablement
> that are dependent on GDSC might fail since GDSC could be turned off by HW. The
> consumers can still switch the GDSC to HW mode with new API right after the
> clocks are enabled and the control will be taken back to SW mode just before
> disabling the GDSC, so even with the newer implementation, HW can collapse the
> GDSC anytime for most of the duration between gdsc_enable() and gdsc_disable().
> This API adds more flexibility for consumer drivers to control the GDSC mode as
> per their
> requirements.
There is one more scenario where the driver would like GDSC in driver
controlled. Let say video hardware, which is under vcodec0_gdsc, have registers
to be programmed by TZ. In such scenario, the GDSC should be non collapsed,
while TZ programs those registers precisely while loading the firmware and
bringing hardware out of reset.

Regards,
Vikash

