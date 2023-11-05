Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8B27E1279
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 08:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjKEHmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 02:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjKEHme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 02:42:34 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69B2FB;
        Sun,  5 Nov 2023 00:42:31 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A57aTp9026988;
        Sun, 5 Nov 2023 07:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=i5PCjL1i8Bpxyd0U7V/bOrMic2mwXGgx5uCjdGDO8MI=;
 b=WXA3p2Vg/YL9wL+E62RAtMmLCeu+S00ZLP60aOczvZd7gJA035ixSp5dITv3HpxGcPih
 nNRbOEqSXegne9DMjHbD1/BHikClt2DsFQW63QF4PMBoZLVdsnudZWJN3D7fchGo/gif
 DQmyeg1cOkrIKmg7b01LXnbl9i2WdUokbuL1xxINxsyxCI7jkZH7391u+9+BpuQrXVT8
 PB2hu7GZ5k1+wtFof28HNYTEjQmkbmeUivJe8UgDXB1M/zIgE1+9QccQPGHx2dDNj9hE
 VPl0/JnXAm8gP1BOKpubFBeQmb9s+e8DJW+bXkBp4/e5WTpHKKQgoEvKwzbhnshqsSc8 fA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u5f521m2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 05 Nov 2023 07:42:08 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A57g70T019444
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 5 Nov 2023 07:42:07 GMT
Received: from [10.253.39.47] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Sun, 5 Nov
 2023 00:42:05 -0700
Message-ID: <aef83003-6ddb-f09c-5a49-765273e71ceb@quicinc.com>
Date:   Sun, 5 Nov 2023 15:42:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] net: phy: at803x: add QCA8084 ethernet phy support
To:     Andrew Lunn <andrew@lunn.ch>
CC:     <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231103123538.15735-1-quic_luoj@quicinc.com>
 <806fb6b6-d9b6-457b-b079-48f8b958cc5a@lunn.ch>
 <7f0df23b-f00e-fef8-fa03-314fcfe136eb@quicinc.com>
 <1aaf7a4b-fc7e-4203-af71-740bc187d046@lunn.ch>
Content-Language: en-US
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <1aaf7a4b-fc7e-4203-af71-740bc187d046@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OjFK7WnCkW6UPzX-2N3Xtv5lgLsNBHb-
X-Proofpoint-GUID: OjFK7WnCkW6UPzX-2N3Xtv5lgLsNBHb-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-05_04,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 mlxlogscore=943 phishscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311050064
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/4/2023 10:19 PM, Andrew Lunn wrote:
> On Sat, Nov 04, 2023 at 02:25:25PM +0800, Jie Luo wrote:
>>
>>
>> On 11/3/2023 9:01 PM, Andrew Lunn wrote:
>>>>    #define QCA8081_PHY_ID				0x004dd101
>>>> +#define QCA8081_PHY_MASK			0xffffff00
>>>
>>> That is an unusual mask. Please check it is correct. All you should
>>> need its PHY_ID_MATCH_EXACT, PHY_ID_MATCH_MODEL, PHY_ID_MATCH_VENDOR.
>>
>> Thanks Andrew for the review.
>> The PHY ID of qca8084 is correct, i will update to use PHY_ID_MATCH_EXACT in
>> the new added entry for qca8084.
> 
> Note, i asked about the mask, not the ID. Is PHY_ID_MATCH_EXACT maybe
> too exact? Is there the option for different revisions of the PHY? Can
> one entry in the table be used for multiple revisions?
> 
> 
>      Andrew
> 
> ---
> pw-bot: cr

Sure, Andrew, qca8084 is the different model chip from qca8081, and 
there is only one PHY ID used currently for the qca8084(4-port) and 
qca8082(2-port), but we can use PHY_ID_MATCH_MODEL for new added entry 
of qca8084 and qca8082.
