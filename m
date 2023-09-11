Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE1179C1D8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 03:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjILBqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 21:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbjILBpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 21:45:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD2C180EFC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 17:39:22 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BMcJB0022673;
        Mon, 11 Sep 2023 22:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=IcjCxc3WabGEcLuPnUXM8SMTY2h0LZT28kULFxMPDDk=;
 b=VRpMkmV4SH8qk8Cw/PEhMAg1+7WQqxGiz+joegfyY5UfQxWkAy/60PHg1+loDeI5PBCk
 J3kv6JRDMzyEwlya5aHsCfBhxvx1P1dT3TVVZYOYqYyIa+zP1wR4aY3kMrL+nGNfBM+n
 kRNWuCpA+G0f/CpHyAvAa2FhvFrK/OBjiJHxU8BW+/HjwCE74jvFCAtFZsUzwd5r36Fr
 owBGMKnZeVqf3GMDdDxU7aLl2OfJgXQqBjNOHkbYKd04c+Z+9Wx9mPzaWeRPhr1WkQrB
 AjM2QDLXm0WVY9rQChFxCdyiW1KSP0QXYhZEYC453MYEaitf+fKz8upeIlTBXv1ePQd+ rw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t29qhkhd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 22:42:10 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38BLG1qJ012064;
        Mon, 11 Sep 2023 22:42:09 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t13dyeh4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 22:42:09 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38BMg8Ff26673836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 22:42:08 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A50E558056;
        Mon, 11 Sep 2023 22:42:08 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6934258052;
        Mon, 11 Sep 2023 22:42:08 +0000 (GMT)
Received: from [9.61.88.151] (unknown [9.61.88.151])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 11 Sep 2023 22:42:08 +0000 (GMT)
Message-ID: <0b177938-2b73-4331-b7c3-cd5a707aac78@linux.ibm.com>
Date:   Mon, 11 Sep 2023 17:42:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] fsi: sbefifo: Remove write's max command length
Content-Language: en-US
To:     Joel Stanley <joel@jms.id.au>
Cc:     jk@ozlabs.org, alistair@popple.id.au, eajames@linux.ibm.com,
        linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230907221016.2978802-1-ninad@linux.ibm.com>
 <20230907221016.2978802-2-ninad@linux.ibm.com>
 <CACPK8Xd_pjt5Ok5CR_oKNBjWiuYMWKq8ByV_ounREL3PGKf3Hw@mail.gmail.com>
From:   Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <CACPK8Xd_pjt5Ok5CR_oKNBjWiuYMWKq8ByV_ounREL3PGKf3Hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4qxNfMHdtmahuAX-KBYF3oqkSkafCeDv
X-Proofpoint-GUID: 4qxNfMHdtmahuAX-KBYF3oqkSkafCeDv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_18,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110207
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On 9/11/23 01:03, Joel Stanley wrote:
> On Thu, 7 Sept 2023 at 22:10, Ninad Palsule <ninad@linux.ibm.com> wrote:
>> This commit removes max command length check in the user write path.
>> This is required to support images larger than 1MB. This should not
>> create any issues as read path does not have this check either.
>>
>> As per the original design cronus server was suppose to break up the
>> image into 1MB pieces but it requires restructuring of the driver.
> When you say "driver" you mean the kernel driver, or userspace?
>
> This isn't a great justification for removing a bounds check.
I have improved the comment. Added length check back.
>
>> Today driver sends EOT message on each write request so we will have to
>> send it only after all pieces are sent which requires large change hence
>> we decided to remove this check.
> This paragraph could be clearer. Could you try rephrasing?
>
> Assuming we want to make this change, what is the expected maximum
> transfer? Could we instead make the check be that value (3MB?).
Added length check back. I am using 4MB for some cushion.

Thanks for the review.

~Ninad

>> Testing:
>>    Loaded 3 MB image through cronus server.
>>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
>>   drivers/fsi/fsi-sbefifo.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
>> index 9912b7a6a4b9..b771dff27f7f 100644
>> --- a/drivers/fsi/fsi-sbefifo.c
>> +++ b/drivers/fsi/fsi-sbefifo.c
>> @@ -113,7 +113,6 @@ enum sbe_state
>>   #define SBEFIFO_TIMEOUT_IN_RSP         1000
>>
>>   /* Other constants */
>> -#define SBEFIFO_MAX_USER_CMD_LEN       (0x100000 + PAGE_SIZE)
>>   #define SBEFIFO_RESET_MAGIC            0x52534554 /* "RSET" */
>>
>>   struct sbefifo {
>> @@ -870,8 +869,6 @@ static ssize_t sbefifo_user_write(struct file *file, const char __user *buf,
>>          if (!user)
>>                  return -EINVAL;
>>          sbefifo = user->sbefifo;
>> -       if (len > SBEFIFO_MAX_USER_CMD_LEN)
>> -               return -EINVAL;
>>          if (len & 3)
>>                  return -EINVAL;
>>
>> --
>> 2.39.2
>>
