Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2AD7F3DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 07:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbjKVGJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 01:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVGJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 01:09:35 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479FCD1;
        Tue, 21 Nov 2023 22:09:31 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM4hiJh032712;
        Wed, 22 Nov 2023 06:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : cc : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vThq1oi26KFnLqYRqimd+y9S4pnfD/7AHosfvgTDFnU=;
 b=WiKQT54IkcHxuzt8O+e45lADJ+QzaxWWe2xCtVfzuh+tYXDsdE5Maaj7HNmYGPfHYxmV
 FUinvccJq+zNV7Jak2GaIGIRKEs+uTD/iXaqgj+c/29J3d0GDyvfoP3km56GJVccihIG
 tzyFCiP7c9sPt33Iby7Y8rqdoRY7H3W4hQSN3QMihr3GgeM/s/rjcxhMdsxRWg/W4eKQ
 VPbZe3gEvZ6zALHIWiDzdj3RCqjaOK+3RsaJDBl55gD7fCrMlQcd4XZjyOYo45Mu5VJj
 DQDql7+j9/sZtPNsYmBYLjDBkbdA/U3klkvem9n3AEUzyEs75lKoZvpXr3UolzXIitUT kw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uh477gvc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 06:09:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AM69BdE018763
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 06:09:11 GMT
Received: from [10.216.41.176] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 21 Nov
 2023 22:09:08 -0800
Message-ID: <eba3fc5a-d106-4420-8350-c4a783bc79f9@quicinc.com>
Date:   Wed, 22 Nov 2023 11:39:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: gcc-msm8953: fix stuck gcc_usb30_master_clk
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>
References: <20231002170021.192740-1-trabarni@gmail.com>
 <0eebfc14-dbcd-4987-9e94-ea5630b6c268@linaro.org>
 <07937184481af74c65108bae26526605.sboyd@kernel.org>
 <64a9d171-377c-48df-bdcd-1ac6d13c2da6@linaro.org>
Content-Language: en-US
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <64a9d171-377c-48df-bdcd-1ac6d13c2da6@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wlclgCYyPsjDEDJ5vK5hZevnlqFxs7Ax
X-Proofpoint-GUID: wlclgCYyPsjDEDJ5vK5hZevnlqFxs7Ax
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_03,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=852 clxscore=1011
 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220043
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/18/2023 6:18 AM, Konrad Dybcio wrote:
> On 24.10.2023 04:59, Stephen Boyd wrote:
>> Quoting Konrad Dybcio (2023-10-06 16:50:18)
>>> On 2.10.2023 19:00, Barnabás Czémán wrote:
>>>> According to downstream dwc3-msm source this clock has FSM dependency on
>>>> gcc_pcnoc_usb30_clk so enabling it would fail if latter isn't enabled.
>>>> This patch add works around this issue by changing parent of
>>>> gcc_usb30_master_clk to gcc_pcnoc_usb30_clk. This is acceptable because
>>>> both clocks have same parent and are branches/gates.
>>>>
>>>> Signed-off-by: Barnabás Czémán <trabarni@gmail.com>
>>>> ---
>>> "meh"
>>>
>>> There are multiple cases, especially with qcom, where there are some
>>> magic "dependencies" without parent-child relationship. The common
>>> clock framework doesn't currently have any good way to handle this,
>>> other than some mind gymnastics like you had to do here with matching
>>> them against a common parent/ancestor..
>>>
>>> Stephen, what do you say?
>>>
>>
>> You can't change the parent to be not the actual parent. The consumer of
>> the branch probably wants to call clk_set_rate() on the branch and have
>> it propagate up to the parent to set the actual rate. Can the axi clk
>> simply be left enabled all the time? That seems simpler. Otherwise we
>> probably need to leave the axi clk control to the interconnect driver
>> and make sure drivers enable interconnects before enabling this branch.
> Yeah I'm almost inclined to think adding even more ifs to the icc driver
> will consume more power than just leaving the AXI hanging..
> 
>>
>> When things start to get this tangled I tend to think that we need to
>> remove control of the clk from the general drivers and put the logic to
>> control interconnects and clks into some SoC glue driver and expose a
>> single interface, like genpd power_on/power_off so that general drivers
>> can't get the sequence of steps wrong. Instead all they can do is "power
>> on" their device, and the SoC glue driver can do the proper sequence of
>> framework calls to power up the device.
> That too, given the structure of qcom SoCs, it should almost look like:
> 
> xyznoc-bus {
> 	compatible = "simple-pm-bus";
> 	clocks = <&gcc xyznoc_ahb>,
> 		 <&gcc xyznoc_axi>;
> 	...
> 
> 	xyznoc-node@abcd {};
> }
> 
> etc.
> 
> I've actually discussed this with Bjorn, but we came to a conclusion
> that it's not trivial to determine which peripheral lives on which NoC
> + many of them seem to sorta overlap more than one..

Are we seeing the clk getting stuck during suspend/resume or during 
clk_prepare_enable in probe ?

Regards,
Krishna,
