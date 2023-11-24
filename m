Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FE97F7A83
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 18:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjKXRj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 12:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjKXRjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 12:39:25 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A22BB;
        Fri, 24 Nov 2023 09:39:28 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOGgX9i027345;
        Fri, 24 Nov 2023 17:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cbZUHFkE5FzVcXNkKDtig22qsSf8ydEAXWN6seFAMAM=;
 b=YHDXF87ays+f+I4K8AzPGVqIdl0VTQ5dHm8gmQJfclfStUlekDVirlnOAns5sSUxVP1M
 9QTChaC3u2ZRvilaujTshf6L65oTNO+AWMvlq5AQ0Db+QFccFnzgOt1Gfa+vJlWywHG2
 jQ3acDNFIdaNxyFR+3G0+OcbOSLnE8AUhxpfEHdgoRpfOMuIbrBtKs8RN34vBXpRJC30
 FvAJXgJR2U7tLo01nlylgD6QXSd7MEt8dp9RyD/3EWCQFa8Sy0gNmsOdg9uBioBCiB2O
 c4RFbpdQZOXISdPr1juw/lmcv3lJtqMGUkSnEck7RwgdIdVR0RYnOULsT4RK+x6QEEv9 VQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uj6emucdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 17:39:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AOHdDXb028084
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 17:39:13 GMT
Received: from [10.216.56.238] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 24 Nov
 2023 09:39:08 -0800
Message-ID: <004ddc69-1566-4de4-b260-0fca96a9395f@quicinc.com>
Date:   Fri, 24 Nov 2023 23:09:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: usb: dwc3: Clean up hs_phy_irq in
 bindings
To:     Johan Hovold <johan@kernel.org>
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
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZWCpGdJRexnk98IN@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vsHpUuDW5EEa0o3VY1neDxDOS6nsKGAN
X-Proofpoint-GUID: vsHpUuDW5EEa0o3VY1neDxDOS6nsKGAN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-24_04,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311240137
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>
>> Yes. From whatever targets I was able to find, only one of them didn't
>> have the power_event irq. Rest all of them had. I will recheck that
>> particular one again.
> 
> Please do. The driver polls the corresponding status register on all
> platforms currently, and perhaps this interrupt can one day be used to
> get rid of the polling.
>   

Ok, I just rechecked and case is, I am not able to get my hands on the 
doc. I can't say for sure that the target is missing the pwr_event 
interrupt. I say we can safely add the target assuming pwr_event is 
present for ipq9574. Every target so far even on downstream has this IRQ 
present in hw.

>>> Note that DP comes before DM above as that seems like the natural order
>>> of these (plus before minus).
>>>
>>> Now if the HS interrupt is truly unusable, I guess we can consider
>>> dropping it throughout and the above becomes just three permutations
>>> instead, which can even be expressed along the lines of:
>>
>> Infact, I wanted to do this but since you mentioned before that if HW
>> has it, we must describe it, I kept it in. But since this functionality
>> is confirmed to be mutually exclusive of qusb2/{dp/dm}, I am aligned to
>> skip it in bindings and drop it in DT.
> 
> As I mentioned elsewhere, it depends on whether it can be used at all.
> Not simply whether there is some other mechanism that can be used in its
> stead. Such a decision should be left up to the implementation.
> 
> That's why I said "truly unusable" above. It's still not clear to me
> whether that is the case or not.
> 

I looked at the code of  4.4, 4.14/ 4.19/ 5.4/ 5.10/ 5.15/ 6.1 and none 
of them implement the hs_phy_irq.

>>> 	- anyOf:
>>> 	  - items:
>>> 	    - const: qusb2_phy
>>> 	  - items:
>>> 	    - const: dp_hs_phy_irq
>>> 	    - const: dm_hs_phy_irq
>>> 	- const: pwr_event
>>> 	- const: ss_phy_irq	(optional)
>>>
>>
>> This must cover all cases AFAIK. How about we keep pwr_event also
>> optional for time being. The ones I am not able to find also would come
>> up under still binding block.
> 
> No, we should avoid that if we can as with two many optional things,
> these quickly gets messy (one optional interrupt at the end is fine and
> can be expressed using min/maxItems).
> 
> If the "qusb2+" combination above isn't needed, then we're down to four
> permutations, which is few enough to be spelled out explicitly even if
> we decide that the hs_phy_irq should be kept in. Without hs_phy_irq, it
> seems there's really only two permutations.
> 

My opinion would be to keep the power_event irq as mandatory and not to 
include the hs_phy_irq.

Regards,
Krishna,
