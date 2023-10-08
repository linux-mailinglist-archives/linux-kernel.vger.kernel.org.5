Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBFA7BCDEE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 13:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344661AbjJHLB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 07:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344569AbjJHLBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 07:01:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3CCAC;
        Sun,  8 Oct 2023 04:01:54 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 398ApVTO022624;
        Sun, 8 Oct 2023 11:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GGKblOyJ7XSl3htCiFQ8+bviD4IqBok5IRccknTmqZY=;
 b=Z7fH0iEad33soGdLZRXGoKKmpL4J9gaXw6sy1yogcwEZVqdOpFxP43plmnaWWsN/X36p
 0rF9nI+YnECBwebkXSlrxvOocIeUJFt0MlFulcIlrY5rHki6epvuCBAu99nEtcKWamdz
 EQ39vT4Jjb33MyrBUmDeAtAb51EwMxT5kOdjakXuhGW7Vkgaw9FnMdhXuXlCvJHGdEVh
 SOQAWrmdD3jMF3yDHlbrkrtcIo5TNVFyhBTwZCzJ+XHosxK2JyT7Sm7tR5osj9T9VEm4
 teU+EGaonuUN94+2CfIiqC+fCd3TeLzsotU27cIEnoPlle6js/H+Gc3vHLSh4WQBOx1h ig== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tkh878hfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 08 Oct 2023 11:01:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 398B1Opi020531
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 8 Oct 2023 11:01:24 GMT
Received: from [10.216.15.238] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sun, 8 Oct
 2023 04:01:17 -0700
Message-ID: <75db183e-3c47-48e4-ad29-fea785826109@quicinc.com>
Date:   Sun, 8 Oct 2023 16:31:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 00/10] Add multiport support for DWC3 controllers
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
 <d4663197-8295-4967-a4f5-6cc91638fc0d@linaro.org>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <d4663197-8295-4967-a4f5-6cc91638fc0d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: I1tVyil0196ub9T8-wNxFXS-vtSdgOn1
X-Proofpoint-GUID: I1tVyil0196ub9T8-wNxFXS-vtSdgOn1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-08_08,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 impostorscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=743
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310080098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/8/2023 4:13 PM, Krzysztof Kozlowski wrote:
> On 07/10/2023 17:47, Krishna Kurapati wrote:
>> Currently the DWC3 driver supports only single port controller which
>> requires at most two PHYs ie HS and SS PHYs. There are SoCs that has
>> DWC3 controller with multiple ports that can operate in host mode.
>> Some of the port supports both SS+HS and other port supports only HS
>> mode.
>>
>> This change primarily refactors the Phy logic in core driver to allow
>> multiport support with Generic Phy's.
>>
>> Changes have been tested on  QCOM SoC SA8295P which has 4 ports (2
>> are HS+SS capable and 2 are HS only capable).
>>
> 
> I think I said it few times on the lists to Qualcomm folks, although I
> cannot remember whether exactly in this patchset. Please split DTS from
> USB, because Greg prefers to grab everything and DTS *should go* via
> Qualcomm SoC.
> 
Hi Krzyztof,

Apologies !

Do you mean to send the DTS just to linux-arm-msm list and not linux-usb 
list ? I don't think it was posted on this series and I am not on 
linux-arm-msm mailing list, so missed that comment. Sorry for that. I 
saw some series where DT, Driver and bindings were sent as one set to 
linux-usb list as well and so wanted to follow suite. Will make sure to 
send DT just to linux-arm-msm list from now on. Thanks for the comments :-)

Regards,
Krishna,
