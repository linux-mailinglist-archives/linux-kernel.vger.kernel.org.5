Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FCB7FD4B1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjK2Ku0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjK2KuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:50:24 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2A510DA;
        Wed, 29 Nov 2023 02:50:30 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATATwp1001200;
        Wed, 29 Nov 2023 10:50:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jETCxhm4tnAH6W3L2K0FEp9gQwed225cM9Yoo3a/AcM=;
 b=b6Yiaa1MZJKYB8PIAVFdj/LwOAN/9REIaUM3yPk/YXsqqIEA+G79xP6iC+NlHP7ypxwE
 pHU1AQZio8kmQRo0E0JfThyTPhGSsX0E/2iLHJTPjlpZlCvXspo8lA6wCY1F6EZ0D905
 +LUPSHVxxtN4gnLMDhK7/AwPSlARWc0uB+cIvje7ZlqKcVhc+8pUsGCq/Wdt4JUEQ2B9
 z0Bd5g87TItccJ5e2xTNDordYfvxUtk+falShFHMFw7FnlNsKjEMz5uNwSjE2b0KWyvh
 Lok3M48AwS6GkJ6MgF85XmU1Mnez2ZJQLu8v7ofTbOkeaxQU5aT/ipsT0sDSMGiFB2lX WA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3up2byr8wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 10:50:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ATAoPRZ019480
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 10:50:25 GMT
Received: from [10.216.28.66] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 29 Nov
 2023 02:50:20 -0800
Message-ID: <3abe4ebe-80fc-4214-b01e-50c25575f2b9@quicinc.com>
Date:   Wed, 29 Nov 2023 16:20:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: usb: dwc3: Clean up hs_phy_irq in
 bindings
To:     Johan Hovold <johan@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>
References: <20231122191335.3058-1-quic_kriskura@quicinc.com>
 <ZV9dYpTYRXn63tXe@hovoldconsulting.com>
 <1192d91f-11bf-44af-953a-14e08e2b6ca8@quicinc.com>
 <ZWCpGdJRexnk98IN@hovoldconsulting.com>
 <004ddc69-1566-4de4-b260-0fca96a9395f@quicinc.com>
 <ZWW_FOAKp95Cf9vN@hovoldconsulting.com>
 <18965bb9-7afa-4892-8b71-981ba29d2cd4@quicinc.com>
 <ZWXHrvUDnF2dMk6r@hovoldconsulting.com>
 <6d7527bf-8c1a-49b5-a0cf-99a92098c971@quicinc.com>
 <c8a28c72-5c0a-4a67-a4c9-e46a5716cda4@linaro.org>
 <ZWcPZPX-eT-xHAOv@hovoldconsulting.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZWcPZPX-eT-xHAOv@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IfrZHqYTGRK6-G-08zSRMKQei08laPtA
X-Proofpoint-ORIG-GUID: IfrZHqYTGRK6-G-08zSRMKQei08laPtA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_08,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=952 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311290080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/29/2023 3:46 PM, Johan Hovold wrote:
> On Wed, Nov 29, 2023 at 10:28:25AM +0100, Krzysztof Kozlowski wrote:
>> On 28/11/2023 12:32, Krishna Kurapati PSSNV wrote:
>>>
>>>>
>>>> So back to my initial proposal, with a slight modification moving
>>>> pwr_event first (e.g. as it is not a wakeup interrupt):
>>>>
>>>> qusb2-:
>>>>
>>>> 	- const: pwr_event
>>>> 	- const: qusb2_phy
>>>> 	- const: ss_phy_irq	(optional)
>>>>
>>>> qusb2:
>>>>
>>>> 	- const: pwr_event
>>>> 	- const: hs_phy_irq
>>>> 	- const: qusb2_phy
>>>> 	- const: ss_phy_irq	(optional)
>>>>
>>>> femto-:
>>>> 	- const: pwr_event
>>>> 	- const: dp_hs_phy_irq
>>>> 	- const: dm_hs_phy_irq
>>>> 	- const: ss_phy_irq	(optional)
>>>>
>>>> femto:
>>>> 	- const: pwr_event
>>>> 	- const: hs_phy_irq
>>>> 	- const: dp_hs_phy_irq
>>>> 	- const: dm_hs_phy_irq
>>>> 	- const: ss_phy_irq	(optional)
>>
>> I did not follow entire thread and I do not know whether you change the
>> order in existing bindings, but just in case: the entries in existing
>> bindings cannot change the order. That's a strict ABI requirement
>> recently also discussed with Bjorn, because we want to have stable DTB
>> for laptop platforms. If my comment is not relevant, then please ignore.
> 
> Your comment is relevant, but I'm not sure I agree.
> 
> The Qualcomm bindings are a complete mess of DT snippets copied from
> vendor trees and which have not been sanitised properly before being
> merged upstream (partly due to there not being any public documentation
> available).
> 
> This amounts to an unmaintainable mess which is reflected in the
> binding schemas which similarly needs to encode every random order which
> the SoC happened to use when being upstreamed. That makes the binding
> documentation unreadable too, and the next time a new SoC is upstreamed
> there is no clear hints of what the binding should look like, and we end
> up with yet another permutation.
> 
> As part of this exercise, we've also determined that some of the
> devicetrees that are already upstream are incorrect as well as
> incomplete.
> 
> I really see no alternative to ripping of the plaster and cleaning this
> up once and for all even if it "breaks" some imaginary OS which (unlike
> Linux) relies on the current random order of these interrupts.
> 
> [ If there were any real OSes actually relying on the order, then that
> would be a different thing of course. ]
> 

Hi Krzysztof, Johan,

   We are modifying all the DT's in accordance to bindings as well. 
Still it would be breaking ABI ?

Regards,
Krishna,
