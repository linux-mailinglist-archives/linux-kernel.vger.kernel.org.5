Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622F477273D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjHGONh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjHGONe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:13:34 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0B3107;
        Mon,  7 Aug 2023 07:13:32 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3778eCqw024287;
        Mon, 7 Aug 2023 14:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Gt+gCUHmgDjj2zNUxEfs8O41tYDOTQH90wdcsrwitAc=;
 b=S1WdKG5Y5q3RgokRD85oKHJKd5mUZNVUJgd3j02B25wuR/5W/GOtxIMEHOW2FTzVj/gj
 gtUJzOVBgpGkDOAahRQgUoLP8ECkwKI9wtqRPJ6rcAZqadZKcpjtF6E1VOqkZY+TlmN6
 Orty990YVLgJDPKu0lJHam1suD8vnOHmbSHiheDrVFiww/g2hB0IFFuFHVKkhAjLh8jQ
 W8ZO/VSWVwApsQQRVbCEsGQbHSiZotZpt/MxwWgX7zcm5zJNp/Yy7FvG7elkWla/XGgq
 CMpKsU7bJg10EWG9HI2P9ktmiEH5XEqbi13C7/R8y23S7sUP/TlZ9n8P6LkH7bMlQTP7 ig== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3saw0r8s43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 14:13:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 377EDLRJ028863
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Aug 2023 14:13:21 GMT
Received: from [10.111.180.219] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 7 Aug
 2023 07:13:21 -0700
Message-ID: <47f1a06b-8bfe-911a-3a05-da7d522b588f@quicinc.com>
Date:   Mon, 7 Aug 2023 07:13:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ath6kl: replace one-element array with flexible-array
 member
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>, Kalle Valo <kvalo@kernel.org>
CC:     Atul Raut <rauji.raut@gmail.com>,
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230804045554.6934-1-rauji.raut@gmail.com>
 <2023080433-patio-staining-2cfe@gregkh> <87sf8zs2oi.fsf@kernel.org>
 <2023080410-unadorned-vertigo-c0b8@gregkh>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <2023080410-unadorned-vertigo-c0b8@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: g6PxgHzzUW0wA2SGSy-RByiRbc4Ag86W
X-Proofpoint-ORIG-GUID: g6PxgHzzUW0wA2SGSy-RByiRbc4Ag86W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_13,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 phishscore=0 adultscore=0 impostorscore=0 mlxlogscore=502 clxscore=1011
 spamscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070131
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/2023 2:30 AM, Greg KH wrote:
> On Fri, Aug 04, 2023 at 10:10:37AM +0300, Kalle Valo wrote:
>> Greg KH <gregkh@linuxfoundation.org> writes:
>>
>>> On Thu, Aug 03, 2023 at 09:55:54PM -0700, Atul Raut wrote:
>>>
>>>> One-element arrays are no longer relevant, and their
>>>> place has been taken by flexible array members thus,
>>>> use a flexible-array member to replace the one-element
>>>> array in struct ath6kl_usb_ctrl_diag_cmd_write
>>>>
>>>> This fixes warnings such as:
>>>> ./drivers/net/wireless/ath/ath6kl/usb.c:109:8-12: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
>>>>
>>>> Signed-off-by: Atul Raut <rauji.raut@gmail.com>
>>>> ---
>>>>   drivers/net/wireless/ath/ath6kl/usb.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
>>>> index 5220809841a6..c8ecc9e85897 100644
>>>> --- a/drivers/net/wireless/ath/ath6kl/usb.c
>>>> +++ b/drivers/net/wireless/ath/ath6kl/usb.c
>>>> @@ -106,7 +106,7 @@ struct ath6kl_usb_ctrl_diag_cmd_write {
>>>>   	__le32 cmd;
>>>>   	__le32 address;
>>>>   	__le32 value;
>>>> -	__le32 _pad[1];
>>>> +	__le32 _pad[];
>>>
>>> Are you sure this is actually a variable length array?
>>
>> It's not, it's just padding. We both told this in v1:
>>
>> https://patchwork.kernel.org/project/linux-wireless/patch/20230731012941.21875-1-rauji.raut@gmail.com/
> 
> Hey, I'm consistent, nice!  :)
> 
> But Atul, that's not good to ignore our review comments.  Usually that
> ends up meaning that everyone will then just ignore your submissions,
> generally a not-good resolution.
> 
> thanks,
> 
> greg k-h

Since the 'pad' field is never directly accessed, suggest the author 
respin this this to use simply:
	__le32 _pad;

That will prevent others from trying to "fix" this actual one-element 
array in the future.
