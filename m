Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD207E7F69
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjKJRxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjKJRwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:52:46 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF5C900D;
        Fri, 10 Nov 2023 00:32:32 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA7exJO018675;
        Fri, 10 Nov 2023 08:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=25mtvY+NTGW9DCzRWztwAgArQMlHdGCwKfpiRg2qsK0=;
 b=FwrtrwUR95NVAjgV+k2R1coe7//+z1by3KpeZ2ar/C6mL+a9qpqXnnmGLkicsvdpWo+i
 57SpGz7kl52hKEbeMj4N83SaeKDiq0OmblPkAFaO8JHRqIvnx0IIg3PY6djISSgVvr9Q
 VJk+gcBi21KmJCdnZOYDGNcBWe9hj8653HA3JskDbSagkHTO6i3BRY41mIM830f38us4
 NdkP0xozw92ZmEgZmGtWMIiTTedesHjZj8JTPfEL+CRpglbiLrZ7WdpUadQfc/TF74N7
 YK7zcD1ECARn2y7bhBDNIm7fH3ffZsDrJBdY3HMPI4CXBJx1b4q/Zu9FjuxupNIeyf+M fw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u8y39aevj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 08:32:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AA8WKhs016764
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 08:32:20 GMT
Received: from [10.217.216.47] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 10 Nov
 2023 00:32:13 -0800
Message-ID: <d716fbbe-b681-af41-bfe7-85448cc47c7c@quicinc.com>
Date:   Fri, 10 Nov 2023 14:02:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RESEND v3 4/5] clk: qcom: Use HW_CTRL_TRIGGER flag to
 switch video GDSC to HW mode
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>,
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
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-media@vger.kernel.org>
References: <20231101-gdsc-hwctrl-v3-0-0740ae6b2b04@linaro.org>
 <20231101-gdsc-hwctrl-v3-4-0740ae6b2b04@linaro.org>
 <v4dnsawo7s74spccrsvjwmal73tqfq4aptiny25tyyp6ungxha@jlbywvcssqtl>
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <v4dnsawo7s74spccrsvjwmal73tqfq4aptiny25tyyp6ungxha@jlbywvcssqtl>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uP73AjW-MR_JJ8huakF3mrlf6qgG7jJS
X-Proofpoint-ORIG-GUID: uP73AjW-MR_JJ8huakF3mrlf6qgG7jJS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_04,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=947 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311100071
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/4/2023 1:45 AM, Bjorn Andersson wrote:
> On Wed, Nov 01, 2023 at 11:04:10AM +0200, Abel Vesa wrote:
>> From: Jagadeesh Kona <quic_jkona@quicinc.com>
>>
>> The current HW_CTRL flag switches the video GDSC to HW control mode as
>> part of GDSC enable itself, instead of that use HW_CTRL_TRIGGER flag to
>> give consumer drivers more control and switch the GDSC mode as and when
>> required.
>>
>> HW_CTRL_TRIGGER flag allows consumer drivers to switch the video GDSC to
>> HW/SW control modes at runtime using dev_pm_genpd_set_hwmode API.
>>
> 
> This states what the code currently does, and what the new code will do.
> But I don't find that it adequately describes _why_ this is done.
> 
> 
> In the current implementation, the hardware is might collapse the GDSC
> anytime between gdsc_enable() and gdsc_disable(). By giving "drivers
> more control" the time spent in this state is reduced to some fraction
> of that span, which to me implies higher power consumption.
> 
> Under the assumption that we don't want to consume more power without
> reason, I'm forced to guess that there might be some scenarios that we
> want this feature to keep the GDSC non-collapsed against the indication
> of the hardware - to avoid some instability somewhere, perhaps?
> 

Thanks Bjorn for your review. Sure, will update commit text with details 
in next series.

Normally, consumers will enable the GDSC and then the required clocks. 
If GDSC is moved to HW mode in gdsc_enable() itself, the subsequent 
clocks enablement that are dependent on GDSC might fail since GDSC could 
be turned off by HW. The consumers can still switch the GDSC to HW mode 
with new API right after the clocks are enabled and the control will be 
taken back to SW mode just before disabling the GDSC, so even with the 
newer implementation, HW can collapse the GDSC anytime for most of the 
duration between gdsc_enable() and gdsc_disable(). This API adds more 
flexibility for consumer drivers to control the GDSC mode as per their
requirements.

Thanks,
Jagadeesh

> Regards,
> Bjorn
> 
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>> ---
>>   drivers/clk/qcom/videocc-sc7180.c | 2 +-
>>   drivers/clk/qcom/videocc-sc7280.c | 2 +-
>>   drivers/clk/qcom/videocc-sdm845.c | 4 ++--
>>   drivers/clk/qcom/videocc-sm8250.c | 4 ++--
>>   drivers/clk/qcom/videocc-sm8550.c | 4 ++--
>>   5 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/clk/qcom/videocc-sc7180.c b/drivers/clk/qcom/videocc-sc7180.c
>> index 5b9b54f616b8..51439f7ba70c 100644
>> --- a/drivers/clk/qcom/videocc-sc7180.c
>> +++ b/drivers/clk/qcom/videocc-sc7180.c
>> @@ -166,7 +166,7 @@ static struct gdsc vcodec0_gdsc = {
>>   	.pd = {
>>   		.name = "vcodec0_gdsc",
>>   	},
>> -	.flags = HW_CTRL,
>> +	.flags = HW_CTRL_TRIGGER,
>>   	.pwrsts = PWRSTS_OFF_ON,
>>   };
>>   
>> diff --git a/drivers/clk/qcom/videocc-sc7280.c b/drivers/clk/qcom/videocc-sc7280.c
>> index 615695d82319..3d07b1e95986 100644
>> --- a/drivers/clk/qcom/videocc-sc7280.c
>> +++ b/drivers/clk/qcom/videocc-sc7280.c
>> @@ -236,7 +236,7 @@ static struct gdsc mvs0_gdsc = {
>>   		.name = "mvs0_gdsc",
>>   	},
>>   	.pwrsts = PWRSTS_OFF_ON,
>> -	.flags = HW_CTRL | RETAIN_FF_ENABLE,
>> +	.flags = HW_CTRL_TRIGGER | RETAIN_FF_ENABLE,
>>   };
>>   
>>   static struct gdsc mvsc_gdsc = {
>> diff --git a/drivers/clk/qcom/videocc-sdm845.c b/drivers/clk/qcom/videocc-sdm845.c
>> index c77a4dd5d39c..dad011c48973 100644
>> --- a/drivers/clk/qcom/videocc-sdm845.c
>> +++ b/drivers/clk/qcom/videocc-sdm845.c
>> @@ -260,7 +260,7 @@ static struct gdsc vcodec0_gdsc = {
>>   	},
>>   	.cxcs = (unsigned int []){ 0x890, 0x930 },
>>   	.cxc_count = 2,
>> -	.flags = HW_CTRL | POLL_CFG_GDSCR,
>> +	.flags = HW_CTRL_TRIGGER | POLL_CFG_GDSCR,
>>   	.pwrsts = PWRSTS_OFF_ON,
>>   };
>>   
>> @@ -271,7 +271,7 @@ static struct gdsc vcodec1_gdsc = {
>>   	},
>>   	.cxcs = (unsigned int []){ 0x8d0, 0x950 },
>>   	.cxc_count = 2,
>> -	.flags = HW_CTRL | POLL_CFG_GDSCR,
>> +	.flags = HW_CTRL_TRIGGER | POLL_CFG_GDSCR,
>>   	.pwrsts = PWRSTS_OFF_ON,
>>   };
>>   
>> diff --git a/drivers/clk/qcom/videocc-sm8250.c b/drivers/clk/qcom/videocc-sm8250.c
>> index ad46c4014a40..c1b73d852f1c 100644
>> --- a/drivers/clk/qcom/videocc-sm8250.c
>> +++ b/drivers/clk/qcom/videocc-sm8250.c
>> @@ -293,7 +293,7 @@ static struct gdsc mvs0_gdsc = {
>>   	.pd = {
>>   		.name = "mvs0_gdsc",
>>   	},
>> -	.flags = HW_CTRL,
>> +	.flags = HW_CTRL_TRIGGER,
>>   	.pwrsts = PWRSTS_OFF_ON,
>>   };
>>   
>> @@ -302,7 +302,7 @@ static struct gdsc mvs1_gdsc = {
>>   	.pd = {
>>   		.name = "mvs1_gdsc",
>>   	},
>> -	.flags = HW_CTRL,
>> +	.flags = HW_CTRL_TRIGGER,
>>   	.pwrsts = PWRSTS_OFF_ON,
>>   };
>>   
>> diff --git a/drivers/clk/qcom/videocc-sm8550.c b/drivers/clk/qcom/videocc-sm8550.c
>> index f3c9dfaee968..404c6600edae 100644
>> --- a/drivers/clk/qcom/videocc-sm8550.c
>> +++ b/drivers/clk/qcom/videocc-sm8550.c
>> @@ -322,7 +322,7 @@ static struct gdsc video_cc_mvs0_gdsc = {
>>   	},
>>   	.pwrsts = PWRSTS_OFF_ON,
>>   	.parent = &video_cc_mvs0c_gdsc.pd,
>> -	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | HW_CTRL,
>> +	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | HW_CTRL_TRIGGER,
>>   };
>>   
>>   static struct gdsc video_cc_mvs1c_gdsc = {
>> @@ -347,7 +347,7 @@ static struct gdsc video_cc_mvs1_gdsc = {
>>   	},
>>   	.pwrsts = PWRSTS_OFF_ON,
>>   	.parent = &video_cc_mvs1c_gdsc.pd,
>> -	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | HW_CTRL,
>> +	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | HW_CTRL_TRIGGER,
>>   };
>>   
>>   static struct clk_regmap *video_cc_sm8550_clocks[] = {
>>
>> -- 
>> 2.34.1
>>
