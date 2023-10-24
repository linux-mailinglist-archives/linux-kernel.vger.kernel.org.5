Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE93E7D49FF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjJXI0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbjJXI0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:26:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663B9D7B;
        Tue, 24 Oct 2023 01:26:41 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39O7VSZq021879;
        Tue, 24 Oct 2023 08:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uElCGA3B+UiSIPKNkNNcfVvZAHci/QRPYuaJRfq0/Do=;
 b=HXb4Hzu40ISNEDoTWGjtKGIxDszkS41y5Wz0rxS7yFdDsDEbFU9qrbW7BG0nPGFbZuvR
 Ml/ucEDaL2Dg+SjkKGyxP/V7hCSBLBmfIdezv4lxkEvM/4LBK9IXoTjzWloNTpWNeLJQ
 JifY/dTf/P1tOBRry0VdQ0liiCOHLAC9GItvAW91eYEPjGOs9XE5QEdABV0/JkcYRZlG
 UyYS3MsbXdRvo4JXMN8OgiP/tn1NWu7o9oYLs3daZWKSXThVjepUk2SnAQbBdeMRVR6I
 8+djZzjgEL5WdlBVNZljebi5x2q6NyThK/+/7nXeGRCfmqj0MFBbWfvqAvrDspB5TOIg VQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tx7r80av1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 08:26:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39O8QQbw002388
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 08:26:26 GMT
Received: from [10.249.18.70] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 24 Oct
 2023 01:26:20 -0700
Message-ID: <78f672c9-cdab-4fd0-a611-9b6ae3407017@quicinc.com>
Date:   Tue, 24 Oct 2023 13:56:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 09/10] arm64: dts: qcom: sa8295p: Enable tertiary
 controller and its 4 USB ports
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
 <20231007154806.605-10-quic_kriskura@quicinc.com>
 <ZTad-_toGkumYx6O@hovoldconsulting.com>
 <faa647ed-9692-4233-b421-b9e6271f8934@quicinc.com>
 <ZTdwNSvi1FJ5TNg3@hovoldconsulting.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZTdwNSvi1FJ5TNg3@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PHBu8NlQ-iHgdr31rkininCpII8ZbOZe
X-Proofpoint-GUID: PHBu8NlQ-iHgdr31rkininCpII8ZbOZe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_07,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=675 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310240071
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/24/2023 12:50 PM, Johan Hovold wrote:
> On Mon, Oct 23, 2023 at 11:12:40PM +0530, Krishna Kurapati PSSNV wrote:
>> On 10/23/2023 9:53 PM, Johan Hovold wrote:
>>> On Sat, Oct 07, 2023 at 09:18:05PM +0530, Krishna Kurapati wrote:
> 
>>>> +	usb2_en_state: usb2-en-state {
>>>
>>> No need to include '_state' in the labels.
>>>
>> Any specific reason ? I have no problem if removing the suffix but just
>> wanted to know the reason.
> 
> For consistency with the rest of the sc8280xp devicetree sources
> (including this file) where we've used that pattern (e.g. as reproducing
> "state" in the label is mostly redundant). For example:
> 
> 	pcie2a_default: pcie2a-default-state {}
> 
> and
> 
> 	nvme_reg_en: nvme-reg-en-state {}
> 

Thanks for the reference.

Regards,
Krishna,
