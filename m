Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489C27B25F1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 21:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjI1T0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 15:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI1T0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 15:26:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B87619F;
        Thu, 28 Sep 2023 12:26:17 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SISQbA015355;
        Thu, 28 Sep 2023 19:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ooAQqC9xWI1PCS2E+DEZfMn/7C9bplMAfccRyJkPlJk=;
 b=Hd66bLzENYH5cLyg9yLHt7Z5DSnu0WeilfkB5Av+Si2k/4gYn4+pEEZW3WpeM/Zt6UP7
 +7hsRLYGC21CGmOi+ouuanNXSL1i21cIvU0W2L9gSExAfC5kO1gmXGp7dpwmBEJcmXF3
 S2t26O08EvmdicxUNyJLtvoAjmjoSUDkYWmjMcK7Y5X8lcVH2AmEY6FaqvXGziJqhCjT
 W6S+6nxzX4q+fXwpiioXDoid7Ookgcfc03xRhc9A864/1nYpeEKiEQz1kbVGVtXb8JwU
 lnbW+eMuwuiS2Ff1nJLZsWEOPAyuhkHl2UdSD3MJUpJlWZiCspMHdwP3G1z1lqWUgZCa hQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tct5gty2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 19:26:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38SJQ6On015886
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 19:26:06 GMT
Received: from [10.111.177.152] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 28 Sep
 2023 12:26:06 -0700
Message-ID: <712b1f74-72c3-4655-9e38-3138db74a1b7@quicinc.com>
Date:   Thu, 28 Sep 2023 12:26:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 wireless-next 2/9] carl9170: remove unnecessary (void*)
 conversions
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>,
        Christian Lamparter <chunkeey@gmail.com>
CC:     Wu Yunchuan <yunchuan@nfschina.com>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20230919044916.523308-1-yunchuan@nfschina.com>
 <e544d992-cddd-4ade-81ef-2eed4f3681e8@gmail.com> <87zg16iab3.fsf@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <87zg16iab3.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _B7Ky4Z_Shdw0MgsMykdd17s1DKnzkXl
X-Proofpoint-GUID: _B7Ky4Z_Shdw0MgsMykdd17s1DKnzkXl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_18,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=676 impostorscore=0 phishscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280166
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/2023 8:31 AM, Kalle Valo wrote:
> Christian Lamparter <chunkeey@gmail.com> writes:
> 
>> On 9/19/23 06:49, Wu Yunchuan wrote:
>>> No need cast (void *) to (struct ar9170 *), (u8 *) or (void*).
>>
>> hmm, your mail went into the spam folder. Good thing I checked.
>>
>>  From what I remember: The reason why these casts were added in
>> carl9170 was because of compiler warnings/complaints.
>> Current gcc compilers should be OK (given that the kernel-bot
>> didn't react, or went your Mail to their spam-folder as well?)
>> but have you checked these older versions?
> 
> Do you remember anything more about these warnings? I tried to check the
> git history and at least quickly couldn't find anything related to this.
> 
> The changes look very safe to me, struct urb::context field and the out
> variable are both of type 'void *' so removing the explicit casts should
> change anything. I cannot really come up a reason why would this patch
> cause new warnings so I am inclined towards taking this patch. What do
> you think?

Anything that would have had issue would have predated C99.
This change is safe.

