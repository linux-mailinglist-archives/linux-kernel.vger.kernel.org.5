Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031C7796F4E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 05:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbjIGDg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 23:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjIGDgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 23:36:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0217BCA;
        Wed,  6 Sep 2023 20:36:50 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3873aQh5019926;
        Thu, 7 Sep 2023 03:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=xjUqkcasUHG6X6szFIyOnz5zqQS0OzrUc4k6evvFVkk=;
 b=PEj5D9a4Mh2ndJvk0mVWVIQoAJCjEjwhAOMyrLJxDbLOz8ehmhV+IMFWWKbeZE4pxWUJ
 gRdIB0LmLvh+/TD/10GL1QRynePPfWMYQUR/FqgJHxc/+3erjVOhxpQ3QQbO49N/k7va
 dKQLywXOae5oOPFcBu6JjmqS71aDttgzKmf1DRFsPXsuL8dpdvgvs3NvDoM/cI04a4ay
 96y1zfTWQ7LkGr3ukqRrKmRBt14I2YoNQWyPyN3Ewkg3iQ7OH+JfAUtA6/zTOU1lmTY3
 lSgKGexIQ0LeWrknmf/lpIB0eGbOmNY0RgABSnK1ZdC3KdmuyqK/FtyErT1jN7nImODc 5A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sxpt02bbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 03:36:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3873aRmi004140
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Sep 2023 03:36:27 GMT
Received: from [10.216.1.243] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 6 Sep
 2023 20:36:20 -0700
Message-ID: <e7bd3aa9-b8ee-4b8a-2354-e786f9a9ff47@quicinc.com>
Date:   Thu, 7 Sep 2023 09:06:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v11 13/13] arm64: dts: qcom: sa8540-ride: Enable first
 port of tertiary usb controller
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
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <f19fa545-0ccb-4670-af77-7c034b1016ef@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rTa9Vun7GAwUtbdDKzpEpdcsGhKFjBA0
X-Proofpoint-GUID: rTa9Vun7GAwUtbdDKzpEpdcsGhKFjBA0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 mlxscore=0 phishscore=0 impostorscore=0 suspectscore=0 mlxlogscore=534
 adultscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070029
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/6/2023 10:28 PM, Konrad Dybcio wrote:
> On 28.08.2023 15:30, Krishna Kurapati wrote:
>> From: Andrew Halaney <ahalaney@redhat.com>
>>
>> There is now support for the multiport USB controller this uses so
>> enable it.
>>
>> The board only has a single port hooked up (despite it being wired up to
>> the multiport IP on the SoC). There's also a USB 2.0 mux hooked up,
>> which by default on boot is selected to mux properly. Grab the gpio
>> controlling that and ensure it stays in the right position so USB 2.0
>> continues to be routed from the external port to the SoC.
>>
>> Co-developed-by: Andrew Halaney <ahalaney@redhat.com>
>> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
>> [Krishna: Rebased on top of usb-next]
>> Co-developed-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
> Is there any benefit to removing the other ports?
> 
> i.e. are ports 1-3 not parked properly by the dwc3 driver if
> they're never connected to anything?
> 
Hi Konrad,

  Whether or not the phy is connected to a port, the controller would 
modify the GUSB2PHYCFG/GUSB3PIPECTL registers. But if we don't specify 
only one phy and let phys from base DTSI take effect (4 HS / 2 SS), we 
would end up initializing and powering on phy's which are never 
connected to a port. To avoid that we need to specify only one phy for 
this platform.

Regards,
Krishna,
