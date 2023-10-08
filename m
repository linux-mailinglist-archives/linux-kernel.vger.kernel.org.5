Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267347BCE23
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 13:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344709AbjJHLV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 07:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344667AbjJHLV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 07:21:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E5D8F;
        Sun,  8 Oct 2023 04:21:55 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 398BLibs010142;
        Sun, 8 Oct 2023 11:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BFnqeAoUrOZzSgvYFtjnNV7IHsVy9j+UaCkYA1AuWng=;
 b=aOt1f0Jyi4TvXL8si4snJ7zVefFYMgpgdWl5P5rgHpZ68HfkbbIRDV8vMjK1JKG1RbHx
 a8FrR20FtOhTE24j09BrY2SeH7WCw1c8KwXS9khdwkIHC/WhKFgCMWC3usNec6HCsl5I
 LQmNKoQVmxlPktdtei1DM5r/oBkoyYYQHBt43M9xuG0tmpiiglJAAHwi2CMI633obzBq
 1ormtvPd8SvWgbFbXpsin/Xb4QSaUzPR7rrWuC34KNaP0auzDpFr8WymlLxW9y09zBpO
 0ruqdivAmAeP1rhzAi4AmSdPEGDNKMLgA3v0v7az6VqtfSv45Dj+OcHof20TXefRISEZ Ow== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tkh4t8jdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 08 Oct 2023 11:21:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 398BLhXX006789
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 8 Oct 2023 11:21:43 GMT
Received: from [10.216.15.238] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sun, 8 Oct
 2023 04:21:36 -0700
Message-ID: <1fb7bc00-8338-41f6-92ae-84b442f896a3@quicinc.com>
Date:   Sun, 8 Oct 2023 16:51:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 08/10] arm64: dts: qcom: sc8280xp: Add multiport
 controller node for SC8280
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "Wesley Cheng" <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
 <20231007154806.605-9-quic_kriskura@quicinc.com>
 <e0a7dcaf-9303-4ddd-9a75-dd56165698f9@linaro.org>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <e0a7dcaf-9303-4ddd-9a75-dd56165698f9@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mbpckuNRE0wT92AB9UGhtBdwI36iV3ca
X-Proofpoint-ORIG-GUID: mbpckuNRE0wT92AB9UGhtBdwI36iV3ca
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-08_09,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=730
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 spamscore=0 impostorscore=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310080102
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/8/2023 4:41 PM, Krzysztof Kozlowski wrote:
> On 07/10/2023 17:48, Krishna Kurapati wrote:
>> Add USB and DWC3 node for tertiary port of SC8280 along with multiport
>> IRQ's and phy's. This will be used as a base for SA8295P and SA8295-Ride
>> platforms.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 84 ++++++++++++++++++++++++++
>>   1 file changed, 84 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> index cad59af7ccef..5f64f75b07db 100644
>> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> @@ -3330,6 +3330,90 @@ system-cache-controller@9200000 {
>>   			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>>   		};
>>   
>> +		usb_2: usb@a4f8800 {
>> +			compatible = "qcom,sc8280xp-dwc3-mp", "qcom,dwc3";
> 
> There is no such compatible. Scrolling through 3 pages of cover letter,
> I did not find dependency listed. I did not scroll more - dependency is
> the most important piece, so I would assume it is in the top-part.
> 
Hi Krzysztof,

  I rebased the series on top of latest usb-next. I mentioned in cover 
letter that the first 3 patches have been merged on usb-next and this 
series has the remaining 10 patches. Apologies, I must have mentioned 
commit number of the merged patches as well for better context. The 
compatible was merged in the patch [1].

[1]: 
https://lore.kernel.org/all/20230828133033.11988-2-quic_kriskura@quicinc.com/

Regards,
Krishna,
