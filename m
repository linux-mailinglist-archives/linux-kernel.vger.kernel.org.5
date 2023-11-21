Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930357F3281
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbjKUPkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbjKUPkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:40:21 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1C799;
        Tue, 21 Nov 2023 07:40:16 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALFT3sW004097;
        Tue, 21 Nov 2023 15:39:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Aodh+P1UXwSaVpcBsa/LsQorupIGPPf7uDn93EnI5K4=;
 b=Ufv0V9v25bCrdjxgr90ppOx0IqfYq6U91im+AO1N5MjDd1oSjHRym5VOz4bwrmkIucaO
 8PW5scBQydyC9nMDFq0AyYIPm72VXgLWDUqO+dXNHf6rjJwWPr3ymmQeaAUwpSMkcdyy
 Was7R331Xuo3mW1JnPiB8vQswauSWSLTCLmxNyK0ucX1vHEsY3jocaQUWC5krQ2B7bZt
 a70+qDZ5RLpzp7zVcx7meJ01ZhZLWTUP0WgYH6WtHN9EZwy1DXUsLH/60Y7BW23b0cu+
 Ysgu8hKbSCghWR2Rk4olilaDqqIIFt8xxBxOrvTmn8Q0gOoD93nlQA6njtpuTCzd+zag tA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ugy7u8kbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 15:39:48 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ALFdExp015964;
        Tue, 21 Nov 2023 15:39:48 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ugy7u8kb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 15:39:48 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALDnNGG021716;
        Tue, 21 Nov 2023 15:39:47 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ufaa211ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 15:39:47 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ALFdgFS9831098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 15:39:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0941F2004E;
        Tue, 21 Nov 2023 15:39:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B862520040;
        Tue, 21 Nov 2023 15:39:41 +0000 (GMT)
Received: from [9.152.224.24] (unknown [9.152.224.24])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 21 Nov 2023 15:39:41 +0000 (GMT)
Message-ID: <64198545-c405-4933-ab85-8d28caef1b27@linux.ibm.com>
Date:   Tue, 21 Nov 2023 16:39:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/34] net: smc: fix opencoded find_and_set_bit() in
 smc_wr_tx_get_free_slot_index()
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
 <20231118155105.25678-30-yury.norov@gmail.com>
 <04ff08d1-5892-44e8-bf74-802a225eeeda@linux.ibm.com>
 <ZVyzgmb/+oUJ1xcR@yury-ThinkPad>
Content-Language: en-US
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <ZVyzgmb/+oUJ1xcR@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 74dz3WWiTTHnYbdNxOdrUyzH2sZrbX5n
X-Proofpoint-GUID: db9nUyvrm1yKvEy3HrxtcjNooI6dDEB6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_09,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=938 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210122
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.11.23 14:41, Yury Norov wrote:
> On Mon, Nov 20, 2023 at 09:43:54AM +0100, Alexandra Winter wrote:
>>
>>
>> On 18.11.23 16:51, Yury Norov wrote:
>>> The function opencodes find_and_set_bit() with a for_each() loop. Fix
>>> it, and make the whole function a simple almost one-liner.
>>>
>>> Signed-off-by: Yury Norov <yury.norov@gmail.com>
>>> ---
>>>  net/smc/smc_wr.c | 10 +++-------
>>>  1 file changed, 3 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
>>> index 0021065a600a..b6f0cfc52788 100644
>>> --- a/net/smc/smc_wr.c
>>> +++ b/net/smc/smc_wr.c
>>> @@ -170,15 +170,11 @@ void smc_wr_tx_cq_handler(struct ib_cq *ib_cq, void *cq_context)
>>>  
>>>  static inline int smc_wr_tx_get_free_slot_index(struct smc_link *link, u32 *idx)
>>>  {
>>> -	*idx = link->wr_tx_cnt;
>>>  	if (!smc_link_sendable(link))
>>>  		return -ENOLINK;
>>> -	for_each_clear_bit(*idx, link->wr_tx_mask, link->wr_tx_cnt) {
>>> -		if (!test_and_set_bit(*idx, link->wr_tx_mask))
>>> -			return 0;
>>> -	}
>>> -	*idx = link->wr_tx_cnt;
>>> -	return -EBUSY;
>>> +
>>> +	*idx = find_and_set_bit(link->wr_tx_mask, link->wr_tx_cnt);
>>> +	return *idx < link->wr_tx_cnt ? 0 : -EBUSY;
>>>  }
>>>  
>>>  /**
>>
>>
>> My understanding is that you can omit the lines with
>>> -	*idx = link->wr_tx_cnt;
>> because they only apply to the error paths and you checked that the calling function
>> does not use the idx variable in the error cases. Do I understand this correct?
>>
>> If so the removal of these 2 lines is not related to your change of using find_and_set_bit(),
>> do I understand that correctly?
>>
>> If so, it may be worth mentioning that in the commit message.
> 
> I'll add:
> 
>         If find_and_set_bit() doesn't acquire a bit, it returns
>         ->wr_tx_cnt, and so explicit initialization of *idx with
>         the same value is unneeded.
> 
> Makes sense?
> 

Makes sense for the -EBUSY case, thank you. 
It does not explain that you also removed the line for the -ENOLINK case 
(which is ok, because the caller has also initialized it to link->wr_tx_cnt)
