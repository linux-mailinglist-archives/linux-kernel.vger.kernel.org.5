Return-Path: <linux-kernel+bounces-2034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6A6815729
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601381F2559B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E255410965;
	Sat, 16 Dec 2023 04:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DXR4OkHA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7677010947;
	Sat, 16 Dec 2023 04:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BG3tC8N020385;
	Sat, 16 Dec 2023 04:04:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=76ER6ivhVeqySEtNL0JNcPoe4X6jm6/wigfWskWuCkU=; b=DX
	R4OkHAiN0+ftLFbOP1kzrbk7DlgeU+uePG8ELo/9cJfZAIGHf28+e4oxQwsmyZVx
	naLg/grBwtscQDdL2aL1ws9HPZSSmB6nZ6Pbr6UtfL3rASj/6QmooV/R3ptCI5qg
	B4WAjn/2M3l5CsD0Blk4E26Gj4EM1wYSmQNUDyz80Q4W381EiFtFicWaswBp1jDA
	+I78OLcf7ZKpb9+wN977W06j03KcgSkGu9UNPnjJfa6H/oFSIlL2awpeQZHPO6Ph
	ria+GrqSR3N41tCc0hP+8NYEgzVz6i+BCfx+ojUuEmEOFE/X3l7m9S+nvxvrnQO/
	kUd4Z+YOTu4p2h9Pdirw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v137x03dn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 04:04:54 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BG44sbV016332
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 04:04:54 GMT
Received: from [10.253.38.198] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 20:04:51 -0800
Message-ID: <132a5c10-99ee-4893-a30b-407fdd81cf8c@quicinc.com>
Date: Sat, 16 Dec 2023 12:04:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tty: Add comments for tty-ldisc module loading logic
Content-Language: en-US
To: Elliot Berman <quic_eberman@quicinc.com>,
        Jiri Slaby
	<jirislaby@kernel.org>,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        <gregkh@linuxfoundation.org>, <quic_qiancai@quicinc.com>,
        <quic_arandive@quicinc.com>, <quic_saipraka@quicinc.com>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1702640236-22824-1-git-send-email-quic_zijuhu@quicinc.com>
 <1702647690-6787-1-git-send-email-quic_zijuhu@quicinc.com>
 <de1181fe-a948-a1e2-04c8-dcd88085f1df@quicinc.com>
 <6401ff24-c82d-4d69-9aaf-b219af9d4db9@kernel.org>
 <e83d29b8-5022-466a-b2ee-61fa5dd1c9ae@quicinc.com>
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <e83d29b8-5022-466a-b2ee-61fa5dd1c9ae@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sa5nCLPIykPdti488U3_CIlAgxYDOgz8
X-Proofpoint-ORIG-GUID: sa5nCLPIykPdti488U3_CIlAgxYDOgz8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312160027

On 12/16/2023 1:51 AM, Elliot Berman wrote:
> 
> 
> On 12/15/2023 9:26 AM, Jiri Slaby wrote:
>> On 15. 12. 23, 15:19, Vijaya Krishna Nivarthi wrote:
>>> Hi,
>>>
>>>
>>> On 12/15/2023 7:11 PM, Zijun Hu wrote:
>>>> Current tty-ldisc module loading logic within tty_ldisc_get()
>>>> is prone to mislead beginner that the module is able to be loaded
>>>> by a user without capability CAP_SYS_MODULE, add comments to make
>>>> the logic easy to undertand.
>>>>
>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>>> ---
>>>> Changes in v2:
>>>> - Remove condition checking changes
>>>>
>>>>   drivers/tty/tty_ldisc.c | 4 ++++
>>>>   1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
>>>> index 3f68e213df1f..34526ffaccbc 100644
>>>> --- a/drivers/tty/tty_ldisc.c
>>>> +++ b/drivers/tty/tty_ldisc.c
>>>> @@ -150,6 +150,10 @@ static struct tty_ldisc *tty_ldisc_get(struct tty_struct *tty, int disc)
>>>>        */
>>>>       ldops = get_ldops(disc);
>>>>       if (IS_ERR(ldops)) {
>>>> +        /*
>>>> +         * Always request tty-ldisc module regardless of user's
>>>> +         * CAP_SYS_MODULE if autoload is enabled.
>>>> +         */
> 
> The added comment confused me more :-)
> 
> "Request tty-ldisc if process has CAP_SYS_MODULE or autoload is enabled"
> 
got it, please ignore my comments and changes.
>>>
>>> Without much knowledge of this file...
>>>
>>>
>>> What the if condition below accomplishes is evident,
>>
>> After a bit of thinking, sure.
>>
>>> it probably doesn't require a comment.
>>
>> I would not add a comment there at all. I would rewrite the code so it is obvious to everyone. Like:
>>
>> static inline bool tty_ldisc_can_autoload(void)
>> {
>>   return capable(CAP_SYS_MODULE) || tty_ldisc_autoload;
>> }
>>
>> And then:
>> if (!tty_ldisc_can_autoload())
>>   return ERR_PTR(-EPERM);
>>
if you want to remain current logic, suggest think about below question:

for a user without module loading permission CAP_SYS_MODULE, kernel should not allow module to be loaded for the user,
even if kernel calls request_module() to load a module for the user, the loading operation will be refused by permission
checking triggered by request_module(). right?

i have no concern about current design if your answer is NO.

it maybe be worth double checking current logic introduced by below commit if your answer is YES
7c0cca7c847e "tty: ldisc: add sysctl to prevent autoloading of ldiscs"
i also don't understand why above commit will introduce extra capable(CAP_SYS_MODULE) checking.

>>> A more useful comment would be why it does so?
>>
>> From an insider, the reason is obvious. But maybe not so much for newcomers. Well, one could document the new inline above. Like:
>> ""
>> We allow loads for capable users or when autoloading is explicitly enabled.
>> ""
>> or alike...
> 
> I agree with Vijaya that it seems evident after a few moments of analysis, but we're
> also maybe used to reading kernel code more. I don't think we should be opposed
> to changes that make code easier to grok, even if they're trivial.
> 
> If we want to make it clearer, I like Jiri's suggestion. One other thing I'd add
> is to give a reference to read config LDISC_AUTOLOAD's help text.
> 
> Zijun,
> 
> Please send future revisions of the patch to our internal pre-submit review list
> before sending to kernel.org. Qualcommers can visit go/upstream.
> 
got it, will follow go/upstream for further patch upstream.
> - Elliot


