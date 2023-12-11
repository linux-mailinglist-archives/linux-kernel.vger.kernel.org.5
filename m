Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4902A80CB1B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343686AbjLKNfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbjLKNff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:35:35 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCB2C3;
        Mon, 11 Dec 2023 05:35:41 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BBCfvm6014022;
        Mon, 11 Dec 2023 13:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=JAO7RAzqIufMkqXyBj2RDXc5OJpGZGCJxGWVA2r+BIE=;
 b=cU9Wnc13nl1ldvsI59qkPgqSwzHgjrFM2c2DVHC1iUx7qkrzMSBT4Lg27Lx5yXsk47RE
 DwshL7/iLkbrge8+wld2DzyzJmrrCuDhLoBS05uiCETysfcaNPik0Kcw/UgAOK+KttwI
 qJeLq4qQbZg4bStFBCtu+gJGdmt66TvTSN257lY9t+Hz2U8PmXK8luvd83AGdJtLs2Ec
 qb5vS9IO55LhsnQ8uGBaF+kB3TNHpRNiGNUydcECMQouh3cf34zy9gMbp/NQpIufbMa9
 kgFQTJYujTUOE8LwqzUCvT0eAvDWazJdR0WvcQT2MtJvvgs0cV048o9qoGchfJH/EXqL Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uwwgaauey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 13:35:36 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BBDO37J001880;
        Mon, 11 Dec 2023 13:35:36 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uwwgaauec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 13:35:35 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BBAspTq012588;
        Mon, 11 Dec 2023 13:35:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw3jnhm0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 13:35:35 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BBDZWaW14942970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Dec 2023 13:35:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5B912004B;
        Mon, 11 Dec 2023 13:35:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB81F20043;
        Mon, 11 Dec 2023 13:35:30 +0000 (GMT)
Received: from [9.171.1.164] (unknown [9.171.1.164])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 11 Dec 2023 13:35:30 +0000 (GMT)
Message-ID: <fb2365f6-1237-4f22-9897-5676757e5157@linux.ibm.com>
Date:   Mon, 11 Dec 2023 14:35:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/9] net/smc: introduce sub-functions for
 smc_clc_send_confirm_accept()
Content-Language: en-US
To:     Wen Gu <guwen@linux.alibaba.com>, wenjia@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc:     borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        raspl@linux.ibm.com, schnelle@linux.ibm.com,
        guangguan.wang@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1702021259-41504-1-git-send-email-guwen@linux.alibaba.com>
 <1702021259-41504-3-git-send-email-guwen@linux.alibaba.com>
 <ac3c0823-8705-4225-96c8-ed7bc55d1bfc@linux.ibm.com>
 <9a6d57c0-f5b4-9b2c-dc5f-dc47d0518141@linux.alibaba.com>
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <9a6d57c0-f5b4-9b2c-dc5f-dc47d0518141@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nvWSigTNjRKeB0k24C_PLqi6Z4_D9fIY
X-Proofpoint-ORIG-GUID: Xm1LkjuJPOyctm3kFAYKDGShQp_5pLlv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-11_07,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxlogscore=782
 impostorscore=0 bulkscore=0 clxscore=1015 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312110110
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.12.23 13:15, Wen Gu wrote:
>>> +    clc = (struct smc_clc_msg_accept_confirm *)clc_v2;
>>
>> Why is this cast neccessary? (Here as well as in smcr_clc_prep_confirm_accept
>> and in smc_clc_send_confirm_accept)
>> smc_clc_msg_accept_confirm_v2 has hdr and d0 as well.
> 
> I think the cast is to imply that v2 is an expansion of v1, or v1 is the base of v2.
> So here using clc(v1) reperesents their common set.
> 
> If we use smc_clc_msg_accept_confirm_v2 for all, I think readers may be tempted to
> check whether the hdr and d0 in 'smc_clc_msg_accept_confirm_v2' are also applicable to v1.
> 
> And there are settings below that are specific for v1. It may be confusing if we
> change it like this:
> 
> if (version == SMC_V1) {
>     clc_v2->hdr.length = htons(SMCD_CLC_ACCEPT_CONFIRM_LEN);
> } else {
> 
> 
>>
>> IMO, it would be a nice seperate patch to get rid of the 2 type defs for
>> smc_clc_msg_accept_confirm and smc_clc_msg_accept_confirm_v2
>> and all the related casting anyhow.
>>
> 
> Do you mean to define only smc_clc_msg_accept_confirm_v2 or define with the name
> of smc_clc_msg_accept_confirm but the contents of smc_clc_msg_accept_confirm_v2?
> 
> I have a different opinion on this, since I think the smc_clc_msg_accept_confirm
> and smc_clc_msg_accept_confirm_v2 clearly shows the difference between v1 and
> v2 messages and remind people what is currently working on. So I perfer to keep them.
> Am I missing something?
> 


This is a discussion about coding style, readability and maintainability (avoid future errors).
And the code works today and the rest is opinions. That said, let me list some arguments why
I don't like the casts.

Casts in general break the type checking of the compiler.

In some places e.g. clc.d0 points to struct smc_clc_msg_accept_confirm in other
places it points to struct smc_clc_msg_accept_confirm_v2.
This makes it hard to find all places where e.g. d0 is altered. (e.g. with an IDE).

You say: "smc_clc_msg_accept_confirm
> and smc_clc_msg_accept_confirm_v2 clearly shows the difference between v1 and
> v2 messages"
But that is not even the case in the code that this patch changes:
In smcd_clc_prep_confirm_accept() you pass a struct smc_clc_msg_accept_confirm_v2
cast it to v1 (even in the v2 case) and then use the v1 layout for the common fields and
the v1-only fields. So I don't think that helps very much.

The v2 messages were explicitely defined for compatibility. i.e.
all v1 fields are still available. It would be good to see that in the code as well.
With 2 differnet structs you don't emphasize that.

With future changes somebody could easily make a mistake that the 2 structures don't 
have the same size anymore. And then the casting can lead to out-of-bound error that
are hard to find.

We want v2 to be the usual case and v1 to be the exception for backwards compatibility.
FOr historic reasons, the code looks as if v2 is the exception. I'd rather point out the 
remaining v1 cases.



I could envision something like:

struct smc_clc_msg_accept_confirm {	/* clc accept / confirm message */
	struct smc_clc_msg_hdr hdr;
	union {
		struct { /* SMC-R */
			struct smcr_clc_msg_accept_confirm r0;
			/* v2 only, reserved and ignored in v1: */
			u8 eid[SMC_MAX_EID_LEN];
			u8 reserved6[8];
		} r1;
		struct { /* SMC-D */
			struct smcd_clc_msg_accept_confirm_common d0;
			/* v2 only, reserved and ignored in v1: */
			__be16 chid;
			u8 eid[SMC_MAX_EID_LEN];
			__be64 gid_ext;
		} __packed d1;
	};
};

And then only use this one structure.








