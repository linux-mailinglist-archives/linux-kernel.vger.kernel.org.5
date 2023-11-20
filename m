Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453A67F0DD9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjKTIol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbjKTIoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:44:39 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F61A4;
        Mon, 20 Nov 2023 00:44:36 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK8MOLC000933;
        Mon, 20 Nov 2023 08:44:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=TxJZRF8ZNaeh/lNriJCrTeKh8nkctlArLTJQkMSpmIo=;
 b=NgIMl6ot6UQjjRkuNTnJmksTKF/Dud179qfkaDAlLGfjvh2JemOIsovpXeiSEwoehEyf
 wT1PyJWlwo2DD36Re9H3niH7T0vkc/ZePkePlkICKQuz1kPvtRQe+DDb9rNc+1zKgGLS
 aLlRKBDfH3gKgolXo/qCK/bjl+1zdFmVtdGO/euB/AQZqvrFD2XoJ5B4+zsIb1LGde9H
 NR8ircjeezb7mlnUAlIS+5ikvKBh8KL3nAjMMIC6Ai7gObWnE3b7LUzZSsaV+L74aj9f
 +2GBk5Y6Gnx+j4Vu97A5tuco8CJbXeNnCYCvMfCzqhCzVm/fHQjfL73SHfSz+gh5rnmw MQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ug3vprm48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 08:44:09 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AK8NrQe004350;
        Mon, 20 Nov 2023 08:44:08 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ug3vprkst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 08:44:08 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK7KTi6008982;
        Mon, 20 Nov 2023 08:43:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf7yy853w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 08:43:59 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AK8huwi42664686
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 08:43:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 261032004E;
        Mon, 20 Nov 2023 08:43:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA39320075;
        Mon, 20 Nov 2023 08:43:54 +0000 (GMT)
Received: from [9.171.73.39] (unknown [9.171.73.39])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Nov 2023 08:43:54 +0000 (GMT)
Message-ID: <04ff08d1-5892-44e8-bf74-802a225eeeda@linux.ibm.com>
Date:   Mon, 20 Nov 2023 09:43:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/34] net: smc: fix opencoded find_and_set_bit() in
 smc_wr_tx_get_free_slot_index()
Content-Language: en-US
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
 <20231118155105.25678-30-yury.norov@gmail.com>
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20231118155105.25678-30-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RCGHS0U65x8_e0nDUsvDqhplocMS6oNa
X-Proofpoint-GUID: sLbkG6D89j2LFxlDlB5wgMhttmCPU6Pq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_06,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=933 suspectscore=0 bulkscore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.11.23 16:51, Yury Norov wrote:
> The function opencodes find_and_set_bit() with a for_each() loop. Fix
> it, and make the whole function a simple almost one-liner.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  net/smc/smc_wr.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
> index 0021065a600a..b6f0cfc52788 100644
> --- a/net/smc/smc_wr.c
> +++ b/net/smc/smc_wr.c
> @@ -170,15 +170,11 @@ void smc_wr_tx_cq_handler(struct ib_cq *ib_cq, void *cq_context)
>  
>  static inline int smc_wr_tx_get_free_slot_index(struct smc_link *link, u32 *idx)
>  {
> -	*idx = link->wr_tx_cnt;
>  	if (!smc_link_sendable(link))
>  		return -ENOLINK;
> -	for_each_clear_bit(*idx, link->wr_tx_mask, link->wr_tx_cnt) {
> -		if (!test_and_set_bit(*idx, link->wr_tx_mask))
> -			return 0;
> -	}
> -	*idx = link->wr_tx_cnt;
> -	return -EBUSY;
> +
> +	*idx = find_and_set_bit(link->wr_tx_mask, link->wr_tx_cnt);
> +	return *idx < link->wr_tx_cnt ? 0 : -EBUSY;
>  }
>  
>  /**


My understanding is that you can omit the lines with
> -	*idx = link->wr_tx_cnt;
because they only apply to the error paths and you checked that the calling function
does not use the idx variable in the error cases. Do I understand this correct?

If so the removal of these 2 lines is not related to your change of using find_and_set_bit(),
do I understand that correctly?

If so, it may be worth mentioning that in the commit message.
