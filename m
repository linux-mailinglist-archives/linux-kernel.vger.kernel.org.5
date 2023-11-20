Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B0B7F0D66
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjKTIVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjKTIVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:21:01 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE97B9;
        Mon, 20 Nov 2023 00:20:57 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK7Lvn3003771;
        Mon, 20 Nov 2023 08:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gba2Tcl2eMbmK/kLsFECV0armcjkhrFttLQIW9wsuXo=;
 b=SEjUIH9AP531QvS27jtrUrKOEiN62KB4ujjYrcXzL+gsPHPbnUmXbp/g+4BsxBgP1VJO
 /r5pOXHdHPqxM5z4FvPh0AqPjZlsZpr7B+h9OxUJxZTMM1A6GGsu+pQSHw6hgk2bZ8ZU
 51UZSv24m4pkbOzQRtX7cnApm42JqdqIQf9n7ZVh8Loa981roaNY8oCnxhksNUGMZomZ
 rc6UrsgjN+1jw6k6qFNVknyQnAnzPVIb4cVovjOki/vwOcmTSJxqfsGwyUk7mOiCHdJM
 xQ+E1TDFXE/IHqFUurcG/Lti3T4bqcffPHY8mnCEf6Zxgl85rnpLQz21JKBwCKy9+rDO lw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ug30mg41t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 08:20:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AK8Kasq029827
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 08:20:36 GMT
Received: from [10.216.59.34] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 20 Nov
 2023 00:20:27 -0800
Message-ID: <5ecab46b-3808-4e89-a5ac-3c13e0c0a216@quicinc.com>
Date:   Mon, 20 Nov 2023 13:50:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] dt-bindings: reserved-memory: MediaTek: Add reserved
 memory for SVP
Content-Language: en-US
To:     =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "quic_vjitta@quicinc.com" <quic_vjitta@quicinc.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "jstultz@google.com" <jstultz@google.com>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?SmlhbmppYW8gWmVuZyAo5pu+5YGl5aejKQ==?= 
        <Jianjiao.Zeng@mediatek.com>,
        =?UTF-8?B?S3VvaG9uZyBXYW5nICjnjovlnIvptLsp?= 
        <kuohong.wang@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Brian.Starkey@arm.com" <Brian.Starkey@arm.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "tjmercier@google.com" <tjmercier@google.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
References: <20230911023038.30649-1-yong.wu@mediatek.com>
 <20230911023038.30649-9-yong.wu@mediatek.com>
 <d4d471e7-64cf-42bf-a061-82934c904691@quicinc.com>
 <2c3ad77806df3ef23cb69336f2049821529e337b.camel@mediatek.com>
 <a83b00c4-a33a-4687-b024-173c6c5a66a0@quicinc.com>
 <8666e39c6b59322af6a9637121ed22f291830c46.camel@mediatek.com>
From:   Jaskaran Singh <quic_jasksing@quicinc.com>
In-Reply-To: <8666e39c6b59322af6a9637121ed22f291830c46.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NFg0IuWqxZGtZ8GVXpsSQaeo7n2SJGkl
X-Proofpoint-ORIG-GUID: NFg0IuWqxZGtZ8GVXpsSQaeo7n2SJGkl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_06,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1011 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 spamscore=0 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200054
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/6/2023 11:26 AM, Yong Wu (吴勇) wrote:
> On Wed, 2023-11-01 at 11:20 +0530, Jaskaran Singh wrote:
>>  	 
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>  On 10/20/2023 3:20 PM, Yong Wu (吴勇) wrote:
>>> On Thu, 2023-10-19 at 10:16 +0530, Vijayanand Jitta wrote:
>>>>   
>>>> Instead of having a vendor specific binding for cma area, How
>> about
>>>> retrieving
>>>>
>>>
>> https://lore.kernel.org/lkml/1594948208-4739-1-git-send-email-hayashi.kunihiko@socionext.com/
>>>>  ?
>>>> dma_heap_add_cma can just associate cma region and create a heap.
>> So,
>>>> we can reuse cma heap
>>>> code for allocation instead of replicating that code here.
>>>>
>>>
>>> Thanks for the reference. I guess we can't use it. There are two
>>> reasons:
>>>   
>>> a) The secure heap driver is a pure software driver and we have no
>>> device for it, therefore we cannot call dma_heap_add_cma.
>>>   
>>
>> Hi Yong,
>>
>> We're considering using struct cma as the function argument to
>> dma_heap_add_cma() rather than struct device. Would this help
>> resolve the problem of usage with dma_heap_add_cma()?
> 
> Yes. If we use "struct cma", I guess it works.
>

Great; I've posted a v2[1] for the API incorporating this change.

Thanks,
Jaskaran.

[1]
https://lore.kernel.org/lkml/20231117100337.5215-1-quic_jasksing@quicinc.com/
