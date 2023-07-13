Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9DE7518CE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 08:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbjGMGbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 02:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjGMGbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 02:31:17 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F1C1FC0;
        Wed, 12 Jul 2023 23:31:13 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36D6UkpD061855;
        Thu, 13 Jul 2023 01:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689229846;
        bh=IOUMvtjxzY1ZJPeePTxYO5sK2LDSSE4dwWaf+//lmHQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=sEvjCifKhDDRv5qVXA/PfuRvz7z0VfdgII6iFQ6+VPByRnhQm2JYz21s7oauCTAB7
         WE27t1GJeNgSdOkKs3bDt0/RzRJx5iZWMl0ROb4ZptOQpLOE/KRgF2DOX1maXGA5hT
         bYZ6KjDkayHuHImcpy/3ze8VpxceZltm+r5i8rbg=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36D6Uk0h001759
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Jul 2023 01:30:46 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jul 2023 01:30:45 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jul 2023 01:30:45 -0500
Received: from [172.24.28.200] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36D6Ug88068426;
        Thu, 13 Jul 2023 01:30:43 -0500
Message-ID: <575f9db2-ba47-d261-f7c7-b9e09b369f3e@ti.com>
Date:   Thu, 13 Jul 2023 12:00:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: ti: cpsw_ale: Fix
 cpsw_ale_get_field()/cpsw_ale_set_field()
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
References: <20230712110657.1282499-1-s-vadapalli@ti.com>
 <837f1d5f-64fa-2496-6379-09e5e95252f4@kernel.org>
From:   "Patil, Tanmay" <t-patil@ti.com>
In-Reply-To: <837f1d5f-64fa-2496-6379-09e5e95252f4@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/12/2023 7:20 PM, Roger Quadros wrote:
> 
> 
> On 12/07/2023 14:06, Siddharth Vadapalli wrote:
>> From: Tanmay Patil <t-patil@ti.com>
>>
>> CPSW ALE has 75 bit ALE entries which are stored within three 32 bit words.
>> The cpsw_ale_get_field() and cpsw_ale_set_field() functions assume that the
>> field will be strictly contained within one word. However, this is not
>> guaranteed to be the case and it is possible for ALE field entries to span
>> across up to two words at the most.
>>
>> Fix the methods to handle getting/setting fields spanning up to two words.
>>
>> Fixes: db82173f23c5 ("netdev: driver: ethernet: add cpsw address lookup engine support")
>> Signed-off-by: Tanmay Patil <t-patil@ti.com>
>> [s-vadapalli@ti.com: rephrased commit message and added Fixes tag]
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>   drivers/net/ethernet/ti/cpsw_ale.c | 24 +++++++++++++++++++-----
>>   1 file changed, 19 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
>> index 0c5e783e574c..64bf22cd860c 100644
>> --- a/drivers/net/ethernet/ti/cpsw_ale.c
>> +++ b/drivers/net/ethernet/ti/cpsw_ale.c
>> @@ -106,23 +106,37 @@ struct cpsw_ale_dev_id {
>>   
>>   static inline int cpsw_ale_get_field(u32 *ale_entry, u32 start, u32 bits)
>>   {
>> -	int idx;
>> +	int idx, idx2;
>> +	u32 hi_val = 0;
>>   
>>   	idx    = start / 32;
>> +	idx2 = (start + bits - 1) / 32;
>> +	/* Check if bits to be fetched exceed a word */
>> +	if (idx != idx2) {
>> +		idx2 = 2 - idx2; /* flip */
>> +		hi_val = ale_entry[idx2] << ((idx2 * 32) - start);
>> +	}
>>   	start -= idx * 32;
>>   	idx    = 2 - idx; /* flip */
>> -	return (ale_entry[idx] >> start) & BITMASK(bits);
>> +	return (hi_val + (ale_entry[idx] >> start)) & BITMASK(bits);
> 
> Should this be bit-wise OR instead of ADD?
> 

As the hi_val has been declared and left shifted in this function, we 
are sure that the trailing bits are all '0'. Hence we can directly add them.

>>   }
>>   
>>   static inline void cpsw_ale_set_field(u32 *ale_entry, u32 start, u32 bits,
>>   				      u32 value)
>>   {
>> -	int idx;
>> +	int idx, idx2;
>>   
>>   	value &= BITMASK(bits);
>> -	idx    = start / 32;
>> +	idx = start / 32;
>> +	idx2 = (start + bits - 1) / 32;
>> +	/* Check if bits to be set exceed a word */
>> +	if (idx != idx2) {
>> +		idx2 = 2 - idx2; /* flip */
>> +		ale_entry[idx2] &= ~(BITMASK(bits + start - (idx2 * 32)));
>> +		ale_entry[idx2] |= (value >> ((idx2 * 32) - start));
>> +	}
>>   	start -= idx * 32;
>> -	idx    = 2 - idx; /* flip */
>> +	idx = 2 - idx; /* flip */
>>   	ale_entry[idx] &= ~(BITMASK(bits) << start);
>>   	ale_entry[idx] |=  (value << start);
>>   }
> 
