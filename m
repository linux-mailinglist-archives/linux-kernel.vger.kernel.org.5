Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B2F79139C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 10:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240141AbjIDIiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 04:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjIDIiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:38:19 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20A493;
        Mon,  4 Sep 2023 01:38:15 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3847pLij030066;
        Mon, 4 Sep 2023 08:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4evW5x2jf5yJ7uFy236w0xJCDV6EE1sj+3xfMBmDyfE=;
 b=Lta72LbTjPZX51f6UYg4+IaV25MOob+hYrQejLTa03PnUi4VNexOUMqsph5kz+XB80QH
 uVoqhPAl/zZx49pweF2VKjz9O4lgtcYcEDbITl8H/Hdwp14sILMJXNyRny723cnY2SyR
 Hw+OFEJp94NUM9Pkz2IrRc3sbBJe+K5nhy3RT3M8xBqwCMvWGhTKAUHzsMJFtc3cs1NM
 txc/ZUnVbO0UaaVDBltjlQK+zma87GE6dYVHfew+xhjcLiHmIJrXNOXmhvBdtJ286G02
 0xvVYZhMMeoXcAYEFr23m5OPZ9Z7dG984apJblcB27MsbClZYXNljDZzqEXBi2sGumQZ dg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suv2caxvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 08:38:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3848cA3F002377
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Sep 2023 08:38:10 GMT
Received: from [10.214.82.226] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 4 Sep
 2023 01:38:03 -0700
Message-ID: <359ba91d-866b-45e4-83fe-598ed791f877@quicinc.com>
Date:   Mon, 4 Sep 2023 14:08:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: firmware: Add documentation for
 qcom,platform-parts-info
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_kaushalk@quicinc.com>, <quic_rohiagar@quicinc.com>,
        <kernel@quicinc.com>
References: <20230901060223.19575-1-quic_namajain@quicinc.com>
 <f340f731-8471-39be-c7b2-7d930916e3b1@linaro.org>
From:   Naman Jain <quic_namajain@quicinc.com>
In-Reply-To: <f340f731-8471-39be-c7b2-7d930916e3b1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MHhkfxv5_tvEVbYi4IjqQS7KlshkVjnL
X-Proofpoint-GUID: MHhkfxv5_tvEVbYi4IjqQS7KlshkVjnL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_06,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309040077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/1/2023 12:52 PM, Krzysztof Kozlowski wrote:
> On 01/09/2023 08:02, Naman Jain wrote:
>> Add documentation to describe device tree bindings for QCOM's
>> platform-parts-info node. Firmware populates these nodes to pass the
>> information to kernel regarding the subset of hardware blocks
>> and features like Camera, Modem, Display present in a product.
>>
>> This is to support that the same software image runs seamlessly on
>> different platforms where one or more HW blocks are not supported or
>> if some sub parts for a particular block are not supported.
>>
>> Purpose of these definitions is to allow clients to know about this,
>> and thus, handle these cases gracefully.
> Whether camera is or is not supported, is defined by presence of camera
> node or by its status field.
>
> Existing firmware (e.g. U-Boot) is also doing this - patching DTS when
> needed.
>
> I do not think introducing some parallel way makes any sense, so no,
> that's not the way to do it.
>
> Best regards,
> Krzysztof


Thanks Krzysztof for reviewing the patch. I think for telling whether 
the Camera HW block is not
supported / not present, firmware can either remove the device tree 
node, or change its status
to disabled, so that is fine.
With this patch, I was trying to address the use case, where Camera is 
supported but certain features
of that particular Camera are not supported, due to dependent HW blocks 
not present, or due to
product decision to not support it. We wanted to avoid the firmware to 
have this overhead of knowing
what these individual bits mean and thus, disable few of the HW blocks 
that are supposed to be
disabled. And this is applicable for each of these HW blocks.

For example, we can know from 32 bits provided for modem, if 3G/4G/5G is 
supported or not on a
platform. That is decided based on presence/absence of certain HW 
blocks, but it may or may not be as
simple as disabling a particular DT node.
Basically we wanted to defer it to the subsystem drivers, to do whatever 
they like with this
information on sub-parts that are available.

Will rephrase my commit message to make it clearer, but would like to 
hear your thoughts on this first.


Thanks,

Naman Jain


>
