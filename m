Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E727BE935
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjJIS2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbjJIS16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:27:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC18BAF;
        Mon,  9 Oct 2023 11:27:56 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399F8L88001636;
        Mon, 9 Oct 2023 18:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Q+cCkUzN9xrbsC8Pf+ICak/y+bLqYP4HVThQeuiAvuI=;
 b=NIcP1acjmif1uakqbc+d+05R9lcRmlew/UP7J1IbSAhHucx8yV6OQ9cvklKM+XuM21mI
 eRBctGtnmj6wo8T5s/eQuZWOrvDFkBcVDfBrglrNLh1KrxljwaCc5MnDkqpV3rj0TaWM
 EZ/Av5U/VA6A1DnGgOEsiDOAfXclpeWBfoOnii/28BccOZwC/MUU71oSLsPKxkN8d+0/
 SFKSUCR1d2lX5ZhPE2hp7WUxaJogQFnIiZDS/6suGbt3D1c6DUjo3FX76tlz2KCnRWs4
 n4+r63UFoIh/3LmJmmenCYT1diAehp7Y21NgvK8RqzercRy70UKqyiYPVnBiF71cizZS EA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tkh6g38em-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 18:27:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 399IRqri013329
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Oct 2023 18:27:52 GMT
Received: from [10.216.9.133] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 9 Oct
 2023 11:27:48 -0700
Message-ID: <e361e3c0-069c-4e91-8f3a-d7ab2de8bdd4@quicinc.com>
Date:   Mon, 9 Oct 2023 23:57:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: gadget: ncm: Add support to update
 wMaxSegmentSize via configfs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
        onathan Corbet <corbet@lwn.net>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_wcheng@quicinc.com>, <quic_jackp@quicinc.com>
References: <20231009142005.21338-1-quic_kriskura@quicinc.com>
 <20231009142005.21338-2-quic_kriskura@quicinc.com>
 <2023100931-reward-justice-ed1c@gregkh>
 <a9efdc23-0417-48dc-aa17-ef7b1459b85a@quicinc.com>
 <2023100910-used-unruly-f750@gregkh>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <2023100910-used-unruly-f750@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: p6mIrmFhuRgEFSCW21TOg7PthHAmRr8q
X-Proofpoint-ORIG-GUID: p6mIrmFhuRgEFSCW21TOg7PthHAmRr8q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_16,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 clxscore=1015 mlxlogscore=252 bulkscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310090150
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/9/2023 11:24 PM, Greg Kroah-Hartman wrote:
> On Mon, Oct 09, 2023 at 09:02:32PM +0530, Krishna Kurapati PSSNV wrote:
>>
>>
>> On 10/9/2023 8:38 PM, Greg Kroah-Hartman wrote:
>>> On Mon, Oct 09, 2023 at 07:50:05PM +0530, Krishna Kurapati wrote:
>>>> Currently the NCM driver restricts wMaxSegmentSize that indicates
>>>> the datagram size coming from network layer to 1514.
>>>
>>> I don't see that restriction in the existing driver, where does that
>>> happen?
>>
>> Hi Greg,
>>
>>   In the ecm_desc, the following line restricts the value:
>>
>> .wMaxSegmentSize =      cpu_to_le16(ETH_FRAME_LEN),
> 
> Ok, so is that 1514?  I don't know as I don't know what ETH_FRAM_LEN is.
> 
Hi Greg,

Yes, that is 1514.

> So how about saying something to the affect of "the max segment size is
> currently limited to the ethernet frame length of the kernel which
> happens to be 1514 at this point in time."
> 

Sure. I will rephrase this in v2 with the suggestion provided.

Regards,
Krishna,
