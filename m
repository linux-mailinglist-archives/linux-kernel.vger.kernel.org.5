Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D127812DD2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443801AbjLNKzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443864AbjLNKyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:54:51 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3137F2699;
        Thu, 14 Dec 2023 02:54:17 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE8UWDK031960;
        Thu, 14 Dec 2023 10:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        qcppdkim1; bh=76devEkZTjPGRkg/VIiGTbMZH9PHCembcDxQMeXk7cA=; b=XO
        dyIfYQ6XaJPjX6HT4a5Kpco4c/Lmrym4UphomVzTQJ2z1w9i+W2mzbQvSpQ4EGXp
        njXsP/WdLkxtJ0jsX+4H/rypE8AxjouQkOQ7Ujsm0p2WlWLtsaQqyaTxeoku+DJe
        T0838rjQK9OKvy2K/3RP5dFuswSce+aP++he86oudKCWM+kHP6OlsEw9s5dh70cK
        yVUbKA+R0SePE3gHBItUsMrmdaThTCNy3YNeotCge+Upik1nqXkFhmiapi8FnUZx
        OGiyG8c5Om//ZPYZoXkHwVUuqkR9HYmKEqFRibXBjt8om8YcwKCF+0UsoJ9l5Kqq
        S34MZuXonGgU+UykDtWA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uynre170c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 10:54:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BEAs9Bf019421
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 10:54:09 GMT
Received: from [10.216.56.190] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Dec
 2023 02:54:04 -0800
Message-ID: <1fbb9812-ca50-42eb-95af-1f7c8a2714e3@quicinc.com>
Date:   Thu, 14 Dec 2023 16:24:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: usb: dwc3: Clean up hs_phy_irq in
 bindings
To:     Johan Hovold <johan@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
References: <20231211121124.4194-1-quic_kriskura@quicinc.com>
 <20231211121124.4194-2-quic_kriskura@quicinc.com>
 <24fb0b25-0139-4370-864c-839ae931f847@linaro.org>
 <c5d85c84-3783-4262-a379-1f28e13ae4ce@quicinc.com>
 <ZXrRS7O0Cv1sAJdk@hovoldconsulting.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZXrRS7O0Cv1sAJdk@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ub2PCxLZRoI81DIgk7JXzjGDuppBi3Rp
X-Proofpoint-GUID: Ub2PCxLZRoI81DIgk7JXzjGDuppBi3Rp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=933
 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312140073
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/2023 3:26 PM, Johan Hovold wrote:
> On Wed, Dec 13, 2023 at 09:48:57PM +0530, Krishna Kurapati PSSNV wrote:
>> On 12/13/2023 12:45 PM, Krzysztof Kozlowski wrote:
>>> On 11/12/2023 13:11, Krishna Kurapati wrote:
>>>> The high speed related interrupts present on QC targets are as follows:
> 
>>>> Classiffy SoC's into four groups based on whether qusb2_phy interrupt
> 
> typo: Classify
> 
>>>> or {dp/dm}_hs_phy_irq is used for wakeup in high speed and whether the
>>>> SoCs have hs_phy_irq present in them or not.
>>>>
>>>> The ss_phy_irq is optional interrupt because there are mutliple SoC's
>>>> which either support only High Speed or there are multiple controllers
>>>> within same Soc and the secondary controller is High Speed only capable.
>>>>
>>>> This breaks ABI on targets running older kernels, but since the interrupt
>>>> definitions are given wrong on many targets and to establish proper rules
>>>> for usage of DWC3 interrupts on Qualcomm platforms, DT binding update is
>>>> necessary.
>>>
>>> This still does not explain why missing property has to be added as
>>> first one, causing huge reordering of everything here and in DTS.
>>>
>>> If pwr_event is required and we already break the ABI, reduce the impact
>>> of the change by putting it after all required interrupts. Otherwise
>>> please explain here and in commit msg why different approach is taken.
>>>
>>
>> Hi Krzysztof. I don't know much about the effect of the ordering on ABI.
>> I will try to learn up on it. Would the series be good if we just move
>> the pwr_event to the end and keep everything in v3 as it is, and push v4
>> for now ?
> 
> Since all SoCs have the pwr_event (HS) interrupt, but not all
> controllers have the SS PHY interrupt, this would prevent expressing
> that the SS PHY is optional by keeping it last in the binding schema and
> making sure that minItem = maxItems - 1.
> 
> And as we discussed, the aim here is to group the three classes of SoCs
> (qusb2, qusb2+, femto) and fix the order of these interrupts once and
> for all so that random reorderings, renames and omissions do not make it
> into the bindings next time someone grabs a downstream DT and sends it
> upstream.
> 

Hi Krzysztof,

  One more reason is that all targets do have a pwr_event interrupts for 
sure and ss_phy is optional as Johan mentioned. So with this reasoning, 
can we put pwr_event first followed by others and push ss_phy to the end 
of list ?

Regards,
Krishna,
