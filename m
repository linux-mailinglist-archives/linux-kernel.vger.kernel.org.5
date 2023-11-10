Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69D57E8097
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345103AbjKJSP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235782AbjKJSOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:14:38 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AED7A9D;
        Thu,  9 Nov 2023 22:40:57 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA5UT4Z003312;
        Fri, 10 Nov 2023 05:50:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1qeJzEU9+q9du+S9Sx8kYO/KTx5lYz7McRllLoryFDM=;
 b=Cj5fkE9Yf5Z1HlPdZe/aaaFHUJI7/w0+XK6IcZFTXFnuDXJUn5WQNoLXKefCgm+kt9DM
 HBetWEpz7NyaJoVRUiRUwmFL6PrC2K98RuXa6YRZYKvwAHu/1hiGl7qw/c3GMBniniOk
 df3z3LP4mcfumzh1aBN8jDA728XVj/JZfSoIkejnz13BRylReQ/sI9k7uRqGLag1cxXH
 3ubnXtpjHrT+MDUOA8QwWQFExJs6fScZeehO/E/hSpeTdeq9JwZgvKxAGR0roVba049E
 Fz8iAUM6O8WGcnxFUYyN9zAIP9LFGHH3RKgnpIwEcPNAJEFbGycJet3SxhZGKxCF21LM zQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u93tq9a5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 05:50:21 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AA5oKOV019464
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 05:50:20 GMT
Received: from [10.239.155.136] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 9 Nov
 2023 21:50:15 -0800
Message-ID: <c77d3b96-cec0-b13f-2fd8-df59e29bb889@quicinc.com>
Date:   Fri, 10 Nov 2023 13:50:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dt-bindings: ufs: Add msi-parent for UFS MCQ
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh@kernel.org>
CC:     Bart Van Assche <bvanassche@acm.org>, <quic_asutoshd@quicinc.com>,
        <quic_cang@quicinc.com>, <beanhuo@micron.com>,
        <avri.altman@wdc.com>, <junwoo80.lee@samsung.com>,
        <martin.petersen@oracle.com>, <quic_nguyenb@quicinc.com>,
        <quic_nitirawa@quicinc.com>, <quic_rampraka@quicinc.com>,
        <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        "Guenter Roeck" <linux@roeck-us.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "Mark Brown" <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1698835699-28550-1-git-send-email-quic_ziqichen@quicinc.com>
 <20231106144831.GA317907-robh@kernel.org>
 <5850d5ac-e735-4358-866d-f410b00ba39d@acm.org>
 <CAL_Jsq+XB5p_K3C+rc5XetQ-Xfxu4umNFzcF0idB2hhZvS7HLA@mail.gmail.com>
 <20231109161656.GH3752@thinkpad>
From:   Ziqi Chen <quic_ziqichen@quicinc.com>
In-Reply-To: <20231109161656.GH3752@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jJeOAbnbHovkp2p0lBuzujKZ7WRIQexM
X-Proofpoint-ORIG-GUID: jJeOAbnbHovkp2p0lBuzujKZ7WRIQexM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_02,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100047
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/2023 12:16 AM, Manivannan Sadhasivam wrote:
> On Thu, Nov 09, 2023 at 07:55:14AM -0600, Rob Herring wrote:
>> On Mon, Nov 6, 2023 at 11:56 AM Bart Van Assche <bvanassche@acm.org> wrote:
>>>
>>> On 11/6/23 06:48, Rob Herring wrote:
>>>> On Wed, Nov 01, 2023 at 06:48:13PM +0800, Ziqi Chen wrote:
>>>>> The Message Signaled Interrupts (MSI) has been introduced
>>>>> to UFS driver since the MCQ be enabled.
>>>>
>>>> Not really relevant when a driver supported MSI, but the when the h/w
>>>> did. Has UFS always supported MSI? It was added in some version of the
>>>> spec?
>>>
>>> MSI support has been introduced in UFSHCI version 4.0 and I think that
>>> the controller vendor can decide whether or not to implement MSI. Does
>>> this mean that the patch needs to be improved?
>>
>> Yes, this information is what should be in the commit msg rather than
>> driver details.
>>
> 
> Yes, agreed. Ziqi, please update the commit message to incorporate the hw
> details about when MCQ/MSI got introduced. Devicetree binding should describe
> the hw, not the driver.
> 
Thank you all, I will update the commit message in next version.

- Ziqi

> - Mani
> 
>> Rob
> 
