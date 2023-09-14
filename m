Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035577A0994
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241162AbjINPq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241191AbjINPq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:46:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E847D1FDA;
        Thu, 14 Sep 2023 08:45:51 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EFE4hK003959;
        Thu, 14 Sep 2023 15:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=25aS0EJkCskLRfxjNaNCLueqzUMPVBM9At3Cq6IJbeQ=;
 b=J9p+U6Llth2WLxI40mR4dwbssC6++wfnrtGkHxGqZ04A3ihglaORcBUZN5qQU/eM8vNP
 2fjTLeII18kbE1vZ6zB4EJ9p/0ROenvOb6xIEv7C1zs1oxuIrDLIwScfGcxTlG6v47eg
 csy+T0o79tHLBZhVo4vi01jBlZPuEHobioCLPZjUWy5Sg6PrApDZm4dciHWkW8Y9U4s7
 etSJxVT+lMoknPSm4TqD9F/TM+H8LBmRswTfYU0tMRUterqkuOMyo1epRfQ1OJ1F9tZ8
 OC+8VmJnYv3UgT4NeYNDQ0wmcT3AtsPCjfLenen5DQwGexEiVZow6hrItVjB7u1gEDqK 5w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3x6mseav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 15:45:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38EFjXxj021265
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 15:45:33 GMT
Received: from [10.216.57.92] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 14 Sep
 2023 08:45:25 -0700
Message-ID: <e7e4fc1e-661a-fd62-e8b1-1e173cbfcd3e@quicinc.com>
Date:   Thu, 14 Sep 2023 21:15:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v11 13/13] arm64: dts: qcom: sa8540-ride: Enable first
 port of tertiary usb controller
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>
References: <20230828133033.11988-1-quic_kriskura@quicinc.com>
 <20230828133033.11988-14-quic_kriskura@quicinc.com>
 <f19fa545-0ccb-4670-af77-7c034b1016ef@linaro.org>
 <e7bd3aa9-b8ee-4b8a-2354-e786f9a9ff47@quicinc.com>
 <3920bc96-fe58-4e3b-96ab-706f00edb2ee@linaro.org>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <3920bc96-fe58-4e3b-96ab-706f00edb2ee@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: C3-6HXJM9MvGEdsAnyfnrF0grhv9JR47
X-Proofpoint-ORIG-GUID: C3-6HXJM9MvGEdsAnyfnrF0grhv9JR47
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=493 malwarescore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140136
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/13/2023 5:40 PM, Konrad Dybcio wrote:
> On 7.09.2023 05:36, Krishna Kurapati PSSNV wrote:
>>
>>
>>> Is there any benefit to removing the other ports?
>>>
>>> i.e. are ports 1-3 not parked properly by the dwc3 driver if
>>> they're never connected to anything?
>>>
>> Hi Konrad,
>>
>>   Whether or not the phy is connected to a port, the controller would modify the GUSB2PHYCFG/GUSB3PIPECTL registers. But if we don't specify only one phy and let phys from base DTSI take effect (4 HS / 2 SS), we would end up initializing and powering on phy's which are never connected to a port. To avoid that we need to specify only one phy for this platform.
> And does that have any major effect on power use?
> 
> Do these PHYs not have some dormant/low power mode?
> 
Hi Konrad,

  I believe there will be some minimal power use. IMO its best to keep 
only one phy enabled for this variant instead of giving all and 
initializing/powering-on all 4 of them.

Regards,
Krishna,
