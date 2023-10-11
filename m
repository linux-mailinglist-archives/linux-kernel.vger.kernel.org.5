Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB4F7C490D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 07:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjJKFMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 01:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjJKFMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 01:12:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A915F94;
        Tue, 10 Oct 2023 22:12:07 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39B4L7Qv018484;
        Wed, 11 Oct 2023 05:11:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Shlvryev70po6+y16cgY2lwIBQ2lfoFlgDPaJLuAWWQ=;
 b=n95wl1DvgAlwFmru9lVDHn21r/bIQ0UAiwl4K9JFWOGLTuwTjt9+i4prjkCqY7Uw/jVv
 g7yi5w2SAyjlWlREBFoAn2LTOkPL7YEP7HNeEt3PJKBBPbJXs4hgHzhKUopXt2iPJRl4
 o0WmcyyscwjjDTfeR73rZITEoO4fiTVaAycebqhVQxaKzEkMOQrFwq+Z1g6NNFlj2a+H
 2NY6mrowYQ9CUld+0i9hVz9uMYUD+rJBT7gYABNfwdAmddp1FsO85ZM9egjLhSxFcOQ/
 uZpJbf0OjiKRMM7bUw4CcUKKQjDWHqDl1GYKCKrdw0PgLkB4K2qmxQfz36+L/lrmGXyB Uw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tn4he232m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 05:11:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39B5BsDS020211
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 05:11:54 GMT
Received: from [10.216.3.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 10 Oct
 2023 22:11:47 -0700
Message-ID: <2c325941-0fcc-4092-9581-dd6ebb067163@quicinc.com>
Date:   Wed, 11 Oct 2023 10:41:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 00/10] Add multiport support for DWC3 controllers
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
        Johan Hovold <johan@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
 <537d59b3-0e40-4d4d-80ab-b99028af6ec2@linaro.org>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <537d59b3-0e40-4d4d-80ab-b99028af6ec2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qBwvHOhGTLevD_mKHfjY_UTaE_ONyd2f
X-Proofpoint-ORIG-GUID: qBwvHOhGTLevD_mKHfjY_UTaE_ONyd2f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_01,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=643
 suspectscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110046
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2023 2:21 AM, Konrad Dybcio wrote:
> 
> 
> On 10/7/23 17:47, Krishna Kurapati wrote:
>> Currently the DWC3 driver supports only single port controller which
>> requires at most two PHYs ie HS and SS PHYs. There are SoCs that has
>> DWC3 controller with multiple ports that can operate in host mode.
>> Some of the port supports both SS+HS and other port supports only HS
>> mode.
>>
>> This change primarily refactors the Phy logic in core driver to allow
>> multiport support with Generic Phy's.
>>
>> Changes have been tested on  QCOM SoC SA8295P which has 4 ports (2
>> are HS+SS capable and 2 are HS only capable).
>>
>> Changes in v13:
>> This series is a subset of patches in v11 as the first 3 patches in v11
>> have been mereged into usb-next.
>> Moved dr_mode property from platform specific files to common sc8280xp 
>> DT.
>> Fixed function call wrapping, added comments and replaced #defines with
>> enum in dwc3-qcom for identifying IRQ index appropriately.
>> Fixed nitpicks pointed out in v11 for suspend-resume handling.
>> Added reported-by tag for phy refactoring patch as a compile error was
>> found by kernel test bot [1].
> "If you fix the issue in a separate patch/commit (i.e. not just a new 
> version of
> the same patch/commit), kindly add following tags"
> 
> the issue your patch resolves is not one that was reported by the kernel 
> testing robot, it just pointed out that you need to fix up the next 
> revision
> 

I Agree. It sounds wrong to add a reproted-by tag making it seem like a 
bug instead of a feature we have written. But if we fix the compile 
error mentioned and not add the "reported-by", its like not giving 
credit for the reporter. So I put in the reproted by and closes tag to 
give a view of what was reported and the feature implemented.

Regards,
Krishna,
