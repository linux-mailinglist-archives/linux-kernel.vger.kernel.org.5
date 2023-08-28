Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F9F78BA5F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 23:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbjH1VfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 17:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbjH1Vew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 17:34:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C5C18D;
        Mon, 28 Aug 2023 14:34:48 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SGlrLk014757;
        Mon, 28 Aug 2023 21:34:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KTOcDeYyCRyiovqYnrzFTCzHd61617TvJNtHfKzls9o=;
 b=mU3PcIihc6+YzmyOIQGQCEj/HWM4eicBNuayvcZdwV+bxLD0SZEvUdw/1KQ5Ln/vlSQ+
 Kh1XxiiJqBF8w5lbGuSxXR0hvE03EXRg1tqnjtHEKumSlKd1/B0d44+6NaObk2XnZtD7
 Ibx9HdlbrPk8ZMhdYfbdeQih1UpAH5d+3uXkl/fEMKiwQgwZADI0s/CxAMEg/ik8nS5U
 5k9DuGqbK+m2DUnWmyUh7ExIq9XCv8bRjrAO/OyzHyPXPN/Y69uupQfBUiZtdgd3L0/1
 ZuVEkvIVs187RWONuRP/h0E7FH4RU1ma67DKWcKyVZnsm1q7EbuTsM6rsSXx0O7jAj0M 0A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sq9m8vrnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 21:34:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37SLYXuq029778
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 21:34:33 GMT
Received: from [10.110.49.169] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 28 Aug
 2023 14:34:32 -0700
Message-ID: <969988f6-f01f-0e31-6a98-7d02c5a3a4ad@quicinc.com>
Date:   Mon, 28 Aug 2023 14:34:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 2/3] dt-bindings: usb: snps,dwc3: Add
 runtime-suspend-on-usb-suspend property
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Roger Quadros <rogerq@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
References: <20230814185043.9252-1-quic_eserrao@quicinc.com>
 <20230814185043.9252-3-quic_eserrao@quicinc.com>
 <a77403f5-8b99-3012-3843-1999ee8d12ce@linaro.org>
 <6b27cd55-4e44-7a26-30ff-9692344cae4c@quicinc.com>
 <31fa930a-51fb-6a7f-300d-e71f6b399eb1@linaro.org>
 <a0a6c561-6319-00ba-c6db-f1dec9f0f0aa@quicinc.com>
 <5dfae814-7233-eb1f-cae7-f335e54ce1b6@linaro.org>
 <cf0227c8-cd02-81b6-9e13-2e7fe6f505f2@kernel.org>
 <20230826015257.mbogiefsbz5474ft@synopsys.com>
 <afd4843b-427a-8535-78e2-f81879378371@linaro.org>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <afd4843b-427a-8535-78e2-f81879378371@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kxzmCSGPZqfyRKLHhhWJ1Hu9ne_33UJo
X-Proofpoint-GUID: kxzmCSGPZqfyRKLHhhWJ1Hu9ne_33UJo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_18,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=568
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280186
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/2023 1:39 AM, Krzysztof Kozlowski wrote:
> On 26/08/2023 03:53, Thinh Nguyen wrote:
>>>>> For example on Qualcomm platforms there is a phy sideband signalling
>>>>> which detects the wakeup signal when resume is initiated by the host.
>>>>
>>>> So compatible-specific.
>>>>
>>>>> Thus qcom platforms can benefit from this feature by defining this dt
>>>>> property. (in a parallel discussion with Thinh N to come up with a
>>>>> better name for this dt entry).
>>>>
>>>> Thanks, with quite a long message you at the end admitted this is
>>>> compatible-specific. Exactly what I wrote it one sentence previously.
>>>>
>>
>> Various dwc3 platforms often share a common capability that can be
>> shared with a common dt property. If we dedicate a property such as in
>> this case, it helps designers enable a certain feature without updating
>> the driver every time a new platform is introduced. It also helps keep
>> the driver a bit simpler on the compatible checks.
> 
> That's not the purpose of bindings. Sorry.
> 
>>
>> Regardless, what Krzysztof said is valid. Perhaps we can look into
>> enhancing dwc3 to maintain shared behavior based on compatible instead?
> 
> 
Thank you Krzysztof, Thinh, Roger for your comments and feedback. I will 
upload v5 making this change compatible-specifc.

Best Regards
Elson


