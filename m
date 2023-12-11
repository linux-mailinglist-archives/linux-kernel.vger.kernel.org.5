Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C21580C521
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbjLKJrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjLKJrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:47:11 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BE9B0;
        Mon, 11 Dec 2023 01:47:17 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BB9OsPO008442;
        Mon, 11 Dec 2023 09:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=qA5ZVdBUHXONJSbk1B6ONk+koVB9zZViE+crch+rfkk=;
 b=SSfIJueFh3baXq2llKtGGt5uFYOajSYH6r+FIySa/biy61KiOSKrxkWUB6StK05PhEnQ
 OMl36CfTYgiPIELDCn+WWcrphMLdcQ71YjOKlzSjMH1TH3P6oFeDglklPdp46YObK1/R
 uWaYDSxBbvScnXHkEN1ljC7QveDY3ljhynaZ53d/43x7PY807A0zAEARFYwZdOPzBP5e
 DpON+2EnxpiA7VSieAlT8x3OHqCWxqilm4Dd1IjT0cJPhJodtlweK1W0ctO7xvxip6Ig
 3W49JAOvStEjAdh+11+s9hmoHq9VhywGOdZcnzOkYkbck2hQjhFZsOj+EnXZRxgRsLOc 6g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uwys50hvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 09:47:13 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BB9PsTL011078;
        Mon, 11 Dec 2023 09:47:12 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uwys50huy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 09:47:12 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BB6mkWa008544;
        Mon, 11 Dec 2023 09:47:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw2jt0qrq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 09:47:11 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BB9l8Ml18416158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Dec 2023 09:47:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D375620040;
        Mon, 11 Dec 2023 09:47:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9447F20043;
        Mon, 11 Dec 2023 09:47:07 +0000 (GMT)
Received: from [9.171.1.164] (unknown [9.171.1.164])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 11 Dec 2023 09:47:07 +0000 (GMT)
Message-ID: <3b3b5b33-1088-47c3-8cbc-4079c6ff472e@linux.ibm.com>
Date:   Mon, 11 Dec 2023 10:47:07 +0100
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
 <4ad3a168-f506-fc21-582d-fe8764f404c0@linux.alibaba.com>
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <4ad3a168-f506-fc21-582d-fe8764f404c0@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dZDYn_0Xjx9uV1UNXaJKRwR5kolgRSZx
X-Proofpoint-GUID: 4g6xtjCVpjoErk9ewx3B4joiBrjmdCfA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-11_03,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxscore=0 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312110079
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09.12.23 03:50, Wen Gu wrote:
> 
> 
> On 2023/12/8 15:40, Wen Gu wrote:
> 
>> There is a large if-else block in smc_clc_send_confirm_accept() and it
>> is better to split it into two sub-functions.
>>
>> Suggested-by: Alexandra Winter <wintera@linux.ibm.com>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
>>   net/smc/smc_clc.c | 196 +++++++++++++++++++++++++++++++-----------------------
>>   1 file changed, 114 insertions(+), 82 deletions(-)
>>
>> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
>> index 0fcb035..52b4ea9 100644
>> --- a/net/smc/smc_clc.c
>> +++ b/net/smc/smc_clc.c
>> @@ -998,6 +998,111 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
>>       return reason_code;
>>   }
>>   +static void smcd_clc_prep_confirm_accept(struct smc_connection *conn,
>> +                struct smc_clc_msg_accept_confirm_v2 *clc_v2,
> 
> checkpatch will complain 'Alignment should match open parenthesis' here.
> But in order to make the length less than 80 columns, there seems to be
> no other good way.
> 
>> +                int first_contact, u8 version,
>> +                u8 *eid, struct smc_init_info *ini,
>> +                int *fce_len,
>> +                struct smc_clc_first_contact_ext_v2x *fce_v2x,
>> +                struct smc_clc_msg_trail *trl)
>> +{
> <...>
> 
>> +
>> +static void smcr_clc_prep_confirm_accept(struct smc_connection *conn,
>> +                struct smc_clc_msg_accept_confirm_v2 *clc_v2,
> 
> And here.
> 
>> +                int first_contact, u8 version,
>> +                u8 *eid, struct smc_init_info *ini,
>> +                int *fce_len,
>> +                struct smc_clc_first_contact_ext_v2x *fce_v2x,
>> +                struct smc_clc_fce_gid_ext *gle,
>> +                struct smc_clc_msg_trail *trl)
>> +{
> <...>
> 


You could shorten the names of the functions
