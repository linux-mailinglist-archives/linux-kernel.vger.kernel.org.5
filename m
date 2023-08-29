Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D482178BCA0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 04:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbjH2CGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 22:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbjH2CGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 22:06:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313CA199;
        Mon, 28 Aug 2023 19:05:58 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T1o5BN011932;
        Tue, 29 Aug 2023 02:05:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BZcG3tqI0kzEOY8t3aqHftJO1+twcKOp7CgugX3DoGw=;
 b=cXm83m6bxurTD+MgntE9858ufrfV+YhkKBwiMzfkvfm8A5Jy45MkrRHMBQx+zYfuSde/
 dZYeQC/8egD1sXWeYmudKPm04UDP2+iQJr6JN29sFa6rDbOiQONAgbxXRKz3eh+dQuhI
 GlMgsva+HdkCThj7/3cf0IYgShinmhDkmJEkEI4VK7sk6Z9r2s+DYT+0LJqoEhcU6Th7
 WFfY0amwkjbY2xLrOr0ixVjQEoDA2gksIE6Zq/fqmcoDFpgr/CD+1n3bDMjXjKaAJWP0
 I6rqun5Fj2LszSJeSl9hbXmIz22WonjfNxaoV6WX4+XTd6IezpL5YN3oiAx0bezaC48f CQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sq9sdms49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 02:05:37 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37T25aOh006445
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 02:05:36 GMT
Received: from [10.110.46.69] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 28 Aug
 2023 19:05:34 -0700
Message-ID: <f7bd1ae7-fc38-0f29-546b-9ea4a323f42f@quicinc.com>
Date:   Mon, 28 Aug 2023 19:05:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 11/28] dt-bindings: usb: dwc3: Add
 snps,num-hc-interrupters definition
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <agross@kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <bgoswami@quicinc.com>,
        <andersson@kernel.org>, <gregkh@linuxfoundation.org>,
        <tiwai@suse.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>, <quic_plai@quicinc.com>
References: <20230308235751.495-1-quic_wcheng@quicinc.com>
 <20230308235751.495-12-quic_wcheng@quicinc.com>
 <20230311134008.GA20831-robh@kernel.org>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <20230311134008.GA20831-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hIPcrOrnLk6Z93lB_NzAW648eyNkAbAE
X-Proofpoint-ORIG-GUID: hIPcrOrnLk6Z93lB_NzAW648eyNkAbAE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_20,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 clxscore=1011 mlxlogscore=907 mlxscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290016
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 3/11/2023 5:40 AM, Rob Herring wrote:
> On Wed, Mar 08, 2023 at 03:57:34PM -0800, Wesley Cheng wrote:
>> Add a new definition for specifying how many XHCI secondary interrupters
>> can be allocated.  XHCI in general can potentially support up to 1024
>> interrupters, which some uses may want to limit depending on how many
>> users utilize the interrupters.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>   .../devicetree/bindings/usb/snps,dwc3.yaml          | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> index be36956af53b..4e2417191f93 100644
>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> @@ -359,6 +359,19 @@ properties:
>>       items:
>>         enum: [1, 4, 8, 16, 32, 64, 128, 256]
>>   
>> +  snps,num-hc-interrupters:
>> +    description:
>> +      Defines the maximum number of XHCI host controller interrupters that can
>> +      be supported.  The XHCI host controller has support to allocate multiple
>> +      event rings, which can be assigned to different clients/users.  The DWC3
>> +      controller has a maximum of 8 interrupters.  If this is not defined then
>> +      the value will be defaulted to 1.  This parameter is used only when
>> +      operating in host mode.
> 
> Is this an XHCI or DWC3 feature? The former should be added to the XHCI
> binding.
> 

Sorry for the late response...message got routed to a folder I don't 
frequently check...

This is a XHCI feature, but the DWC3 design is built in a way that DWC3 
host initializes the XHCI device and populates the properties associated 
to XHCI dev.

Will update the XHCI yaml as well for non-DWC3 based SoCs.

Thanks
Wesley Cheng
