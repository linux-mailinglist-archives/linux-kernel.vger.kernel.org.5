Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24418808C32
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443553AbjLGPrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443511AbjLGPro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:47:44 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCA510F3;
        Thu,  7 Dec 2023 07:47:50 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B78wjtP009869;
        Thu, 7 Dec 2023 15:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DMNId5NNTRlJNHzk+yn5j+Qypl85O0gZX/21kwX/lzk=;
 b=ldx9OVJ0+ypNve2LIJ8H1fQknaLUsPcq42+3uFP197S33ioy6M4yNvDs/AVSXx3Yo0rU
 lHnixS+ToJlRp3Nu5HfJpDyRoGTK6mpVabJ4A4VZxm008WNq7fZw+a6pUeJOhkWxozZl
 hoALbUqgDMD9DTNHiiv2GorOr4WQnDugNbwSdGYUXJYgjwr4ooKJad3bwUxEQpAvD8tO
 ZtOcyMqFHCShzQpRXGhUYgRfmWXWrFVkdnuyvBToJVKS5pT7r+LyUKVdms+1BNYDV2fF
 FnHmTVV6WGyrSH6MQAC/q6lXT3NIcVMGzTYvpftvpZrvSn1Kj70Afg5xbfppV82amjCq JQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uu2p8a1vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 15:47:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B7Flhpf020296
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Dec 2023 15:47:43 GMT
Received: from [10.216.4.183] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 7 Dec
 2023 07:47:36 -0800
Message-ID: <9d52fa8c-41d1-46a7-be89-5c1c11ca09b4@quicinc.com>
Date:   Thu, 7 Dec 2023 21:17:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] usb: dwc3: qcom: Rename hs_phy_irq to
 qusb2_phy_irq
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Conor Dooley <conor+dt@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>
References: <20231204100950.28712-1-quic_kriskura@quicinc.com>
 <20231204100950.28712-3-quic_kriskura@quicinc.com>
 <ZXHkpwji_AzXMjfm@hovoldconsulting.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZXHkpwji_AzXMjfm@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5hA4un0pgVGyjOaodvzPzjc48OfgqVvv
X-Proofpoint-ORIG-GUID: 5hA4un0pgVGyjOaodvzPzjc48OfgqVvv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_12,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=361 mlxscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312070129
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/2023 8:58 PM, Johan Hovold wrote:
> On Mon, Dec 04, 2023 at 03:39:46PM +0530, Krishna Kurapati wrote:
>> For wakeup to work, driver needs to enable interrupts that depict what is
>> happening on th DP/DM lines. On QUSB targets, this is identified by
> 
> typo: the
> 
>> qusb2_phy whereas on SoCs using Femto PHY, separate {dp,dm}_hs_phy_irq's
>> are used instead.
>>
>> The implementation incorrectly names qusb2_phy interrupts as "hs_phy_irq".
>> Clean this up so that driver would be using only qusb2/(dp & dm) for wakeup
>> purposes.
> 
> Here too you should say something about why this won't break any systems
> booting using an older devicetree. Specifically, the QUSB2 PHY interrupt
> has never been armed on any system running mainline as those bits never
> made it upstream.
> 
> So an alternative to this could also be to just drop the QUSB2 PHY
> interrupt handling from this driver for now. >

Hi Johan,

So, are you suggesting that we drop the whole patch ?
I assume if the older kernels are using old DT, they would be using an 
old driver version too right ? Is there a case where DT is not updated 
but driver is ? Because if we drop this patch from series, targets with 
updated DT's would break.

Regards,
Krishna,
